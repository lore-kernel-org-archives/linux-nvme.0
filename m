Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A48BC83F17
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jul 2025 02:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=urfXVP5MoyAzWyBovRVL6q4EkbUYkcph60ENMOJZUlo=; b=mL+q3VK0R1MvV2c5zjeZ0ptzqG
	u3DlkkXudrZhg50SZySw4zitlkDIq0lKR9SudT6JFwMTqfDV3nAg9P4MQ7kLAd6CempsGzHOPiWc/
	jwSrHiN+dadmtKikoWGt582YzP6atqDOvqPjEfNBiV+VCUVl1fKT8n82mUat0/OH4oZzoN082EgrD
	oj7QpNwIAH27d35g9x81dsFcWAveqArJlY1niuKNMswvFYVDS+LIk4NLSqtbh+Of+7hBOuQJWqn0M
	e0VlUhYFxmauff0qbilttheCBJAIeBMcKKvPIQdLgfiwW6c6gfNYoo2ytwoMYSY785npyK95Oa0ai
	WuX2qBfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udg7Y-0000000FyDv-3oNy;
	Mon, 21 Jul 2025 02:19:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udg7W-0000000Fy8u-0v9j
	for linux-nvme@lists.infradead.org;
	Mon, 21 Jul 2025 02:19:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753064352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=urfXVP5MoyAzWyBovRVL6q4EkbUYkcph60ENMOJZUlo=;
	b=aM1eEmkTZm+guXVrprXcDx8xTMb3VLU2UhQtJ57ia54BEgCa9+sAJHh616cgv/+OcCQIy9
	OiXdYT3NZDV5d3rRMKWsBT7ay7DjtpTXQe8d90SWk+32gd39SuI8magQtVgAm46A6DW+zA
	wbjxaEz+5AXEcnsroY736Xo4kNIKaAc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-veFedEmlODmg1JvA7RzocA-1; Sun,
 20 Jul 2025 22:17:37 -0400
X-MC-Unique: veFedEmlODmg1JvA7RzocA-1
X-Mimecast-MFC-AGG-ID: veFedEmlODmg1JvA7RzocA_1753064256
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFE5818004A7;
	Mon, 21 Jul 2025 02:17:35 +0000 (UTC)
Received: from cleech-thinkpadt14sgen2i.rmtusor.csb (unknown [10.2.16.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5102330001B9;
	Mon, 21 Jul 2025 02:17:33 +0000 (UTC)
From: Chris Leech <cleech@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	Prashanth Nayak <prashanth.nayak@netapp.com>,
	John Meneghini <jmeneghi@redhat.com>
Subject: [PATCH 1/1] libnvme: TLS PSK derivation fixes
Date: Sun, 20 Jul 2025 19:17:18 -0700
Message-ID: <20250721021718.1159879-2-cleech@redhat.com>
In-Reply-To: <20250721021718.1159879-1-cleech@redhat.com>
References: <20250721021718.1159879-1-cleech@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BgkL7nWW5eOghiZ2veGHOsFqGyolXiEwBUfaDJODPrg_1753064256
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250720_191914_334566_9AA3AA76 
X-CRM114-Status: GOOD (  15.42  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

There are issues with the Retained and TLS PSK derivations due to the
implementation not adhering to the RFC 8446 definition of the
HKDF-Expand-Label function.

  1) The 16-bit HkdfLabel.length value must be converted to network byte
     order.

  2) The variable length HkdfLabel.label and HkdfLabel.context vectors
     must be prefixed with a length byte.

Signed-off-by: Chris Leech <cleech@redhat.com>
---
 src/nvme/linux.c | 86 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 29 deletions(-)

diff --git a/src/nvme/linux.c b/src/nvme/linux.c
index ae4aa526..674b20b5 100644
--- a/src/nvme/linux.c
+++ b/src/nvme/linux.c
@@ -618,6 +618,46 @@ static DEFINE_CLEANUP_FUNC(
 	cleanup_evp_pkey_ctx, EVP_PKEY_CTX *, EVP_PKEY_CTX_free)
 #define _cleanup_evp_pkey_ctx_ __cleanup__(cleanup_evp_pkey_ctx)
 
+/*
+ * hkdf_info_printf()
+ *
+ * Helper function to append variable length label and context to an HkdfLabel
+ *
+ * RFC 8446 (TLS 1.3) Section 7.1 defines the HKDF-Expand-Label function as a
+ * specialization of the HKDF-Expand function (RFC 5869), where the info
+ * parameter is structured as an HkdfLabel.
+ *
+ * An HkdfLabel structure includes two variable length vectors (label and
+ * context) which must be preceded by their content length as per RFC 8446
+ * Section 3.4 (and not NUL terminated as per Section 7.1). Additionally,
+ * HkdfLabel.label must begin with "tls13 "
+ *
+ * Returns the number of bytes appended to the HKDF info buffer, or -1 on an
+ * error.
+ */
+__attribute__((format(printf, 2, 3)))
+static int hkdf_info_printf(EVP_PKEY_CTX *ctx, char *fmt, ...)
+{
+	_cleanup_free_ char *str;
+	uint8_t len;
+	int ret;
+
+	va_list myargs;
+	va_start(myargs, fmt);
+	ret = vasprintf(&str, fmt, myargs);
+	va_end(myargs);
+	if (ret < 0)
+		return ret;
+	if (ret > 255)
+		return -1;
+	len = ret;
+	if (EVP_PKEY_CTX_add1_hkdf_info(ctx, (unsigned char *)&len, 1) <= 0)
+		return -1;
+	if (EVP_PKEY_CTX_add1_hkdf_info(ctx, (unsigned char *)str, len) <= 0)
+		return -1;
+	return (ret + 1);
+}
+
 /*
  * derive_retained_key()
  *
@@ -652,7 +692,7 @@ static int derive_retained_key(int hmac, const char *hostnqn,
 			       size_t key_len)
 {
 	_cleanup_evp_pkey_ctx_ EVP_PKEY_CTX *ctx = NULL;
-	uint16_t length = key_len & 0xFFFF;
+	uint16_t length = htons(key_len & 0xFFFF);
 	const EVP_MD *md;
 	size_t hmac_len;
 
@@ -690,18 +730,11 @@ static int derive_retained_key(int hmac, const char *hostnqn,
 		errno = ENOKEY;
 		return -1;
 	}
-	if (EVP_PKEY_CTX_add1_hkdf_info(ctx,
-			(const unsigned char *)"tls13 ", 6) <= 0) {
-		errno = ENOKEY;
-		return -1;
-	}
-	if (EVP_PKEY_CTX_add1_hkdf_info(ctx,
-			(const unsigned char *)"HostNQN", 7) <= 0) {
+	if (hkdf_info_printf(ctx, "tls13 HostNQN") <= 0) {
 		errno = ENOKEY;
 		return -1;
 	}
-	if (EVP_PKEY_CTX_add1_hkdf_info(ctx,
-			(const unsigned char *)hostnqn, strlen(hostnqn)) <= 0) {
+	if (hkdf_info_printf(ctx, "%s", hostnqn) <= 0) {
 		errno = ENOKEY;
 		return -1;
 	}
@@ -736,12 +769,13 @@ static int derive_retained_key(int hmac, const char *hostnqn,
  *
  * and the value '0' is invalid here.
  */
+
 static int derive_tls_key(int version, unsigned char cipher,
 			  const char *context, unsigned char *retained,
 			  unsigned char *psk, size_t key_len)
 {
 	_cleanup_evp_pkey_ctx_ EVP_PKEY_CTX *ctx = NULL;
-	uint16_t length = key_len & 0xFFFF;
+	uint16_t length = htons(key_len & 0xFFFF);
 	const EVP_MD *md;
 	size_t hmac_len;
 
@@ -774,30 +808,24 @@ static int derive_tls_key(int version, unsigned char cipher,
 		errno = ENOKEY;
 		return -1;
 	}
-	if (EVP_PKEY_CTX_add1_hkdf_info(ctx,
-			(const unsigned char *)"tls13 ", 6) <= 0) {
-		errno = ENOKEY;
-		return -1;
-	}
-	if (EVP_PKEY_CTX_add1_hkdf_info(ctx,
-			(const unsigned char *)"nvme-tls-psk", 12) <= 0) {
+	if (hkdf_info_printf(ctx, "tls13 nvme-tls-psk") <= 0) {
 		errno = ENOKEY;
 		return -1;
 	}
-	if (version == 1) {
-		char hash_str[5];
-
-		sprintf(hash_str, "%02d ", cipher);
-		if (EVP_PKEY_CTX_add1_hkdf_info(ctx,
-				(const unsigned char *)hash_str,
-				strlen(hash_str)) <= 0) {
+	switch (version) {
+	case 0:
+		if (hkdf_info_printf(ctx, "%s", context) <= 0) {
 			errno = ENOKEY;
 			return -1;
 		}
-	}
-	if (EVP_PKEY_CTX_add1_hkdf_info(ctx,
-			(const unsigned char *)context,
-			strlen(context)) <= 0) {
+		break;
+	case 1:
+		if (hkdf_info_printf(ctx, "%02d %s", cipher, context) <= 0) {
+			errno = ENOKEY;
+			return -1;
+		}
+		break;
+	default:
 		errno = ENOKEY;
 		return -1;
 	}
-- 
2.50.1


