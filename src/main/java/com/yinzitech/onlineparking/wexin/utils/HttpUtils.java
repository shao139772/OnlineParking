package com.yinzitech.onlineparking.wexin.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.net.ssl.SSLHandshakeException;

import org.apache.http.HeaderElement;
import org.apache.http.HttpEntity;
import org.apache.http.HttpEntityEnclosingRequest;
import org.apache.http.HttpRequest;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.NoHttpResponseException;
import org.apache.http.client.HttpRequestRetryHandler;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.protocol.ExecutionContext;
import org.apache.http.protocol.HttpContext;
import org.apache.http.util.EntityUtils;
 

@SuppressWarnings("deprecation")
public class HttpUtils {

	private HttpUtils() {
	}

	public synchronized static String getStringFromInputStream(InputStream is, String charset) throws Exception {
		if (is == null) {
			return null;
		}

		BufferedReader br = new BufferedReader(new InputStreamReader(is, charset));
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = br.readLine()) != null) {
			sb.append(line + "\n");
		}
		if (br != null) {
			br.close();
		}

		String str = sb.toString();
		return str;
	}

	public static String postXml(String url, String xml) throws IllegalStateException, IOException, Exception {
		String result = null;
		HttpEntity postEntity = new StringEntity(xml, "UTF-8");
		HttpPost httpPost = new HttpPost(url);
		httpPost.addHeader("Content-Type", "text/xml");
		httpPost.setEntity(postEntity);
		CloseableHttpClient httpclient = HttpClients.custom().build();
		HttpResponse response = null;
		response = httpclient.execute(httpPost);
		int statusCode = response.getStatusLine().getStatusCode();
		if (statusCode == HttpStatus.SC_MOVED_PERMANENTLY || statusCode == HttpStatus.SC_MOVED_TEMPORARILY) {
			String location = response.getFirstHeader("Location").getValue();
			return get(location);
		}
		HttpEntity entity = response.getEntity();
		if (entity != null) {
			result = getStringFromInputStream(entity.getContent(), "UTF-8");
		}
		return result;
	}

	public static HttpRequestRetryHandler getRetryHandler() {
		HttpRequestRetryHandler myRetryHandler = new HttpRequestRetryHandler() {
			public boolean retryRequest(IOException exception, int executionCount, HttpContext context) {
				if (executionCount >= 5) {
					return false;
				}
				if (exception instanceof NoHttpResponseException) {
					return true;
				}
				if (exception instanceof SSLHandshakeException) {
					return false;
				}
				HttpRequest request = (HttpRequest) context.getAttribute(ExecutionContext.HTTP_REQUEST);
				boolean idempotent = !(request instanceof HttpEntityEnclosingRequest);
				if (idempotent) {
					return true;
				}
				return false;
			}
		};

		return myRetryHandler;
	}

	public static String get(String url) throws Exception {
		String result = "";
		HttpGet request = new HttpGet(url);
		CloseableHttpClient httpclient = HttpClients.custom().build();
		HttpResponse response = httpclient.execute(request);
		int statusCode = response.getStatusLine().getStatusCode();
		if (statusCode == HttpStatus.SC_MOVED_PERMANENTLY || statusCode == HttpStatus.SC_MOVED_TEMPORARILY) {
			String location = response.getFirstHeader("Location").getValue();
			return get(location);
		}
		HttpEntity entity = response.getEntity();
		HeaderElement[] hes = entity.getContentType().getElements();
		String encode = "UTF-8";
		if (hes != null && hes.length > 0) {
			for (HeaderElement he : hes) {
				encode = he.getParameterByName("charset") == null ? "UTF-8"
						: he.getParameterByName("charset").getValue();
			}
		}
		if (entity != null) {
			// result = getStringFromInputStream(entity.getContent(), encode);
			result = EntityUtils.toString(entity, encode);
		}
		return result;
	}

	public static String getHost(String url) {
		if (url == null || url.trim().equals("")) {
			return "";
		}
		String host = "";
		Pattern p = Pattern.compile("(?<=//|)((\\w)+\\.)+\\w+(\\:[0-9]*){0,1}");
		Matcher matcher = p.matcher(url);
		if (matcher.find()) {
			host = matcher.group();
		}
		return host;
	}
}
