Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24F6CD37AC
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2026 20:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6QhSlHazNnQKAS71NPERt6rMUH+K0PvPN7gJ3+ElUdk=; b=ZKP97pupUbfvDbePb3OgBdPtcq
	z5InKTS8etatzSCgpR6Ki+tspAlEciWvUTc1f5FPqN/Tegx/oB1AXHA26I53PwErGjPJlFWEDFEDx
	lDNjlIPNHaYqKpQ/LaS3NCwXDOuRw3WVQUoZ5Jst0Qc9nw4P/L0nctGRifc7xSNKeu71oXwH8r+PK
	78AMBZ/kfEFEj7upV7wZmtyxmRCo+N4I0yv23Iae6tqyjRJLunW2RkjYUehTg2o1McBUkGguIZUKW
	AEKp8bT/u7j6sIBbrm+bfVkfWonOLzMKYoUz25+dPFziG29mgYTAeCB8RotTrPjGTVRXXC21Q+LBa
	thHDgVhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL5GU-00000004o1t-1QnN;
	Thu, 07 May 2026 20:24:10 +0000
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL5GR-00000004o0d-0RTu
	for linux-nvme@lists.infradead.org;
	Thu, 07 May 2026 20:24:08 +0000
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-7dca4debedaso1320496a34.2
        for <linux-nvme@lists.infradead.org>; Thu, 07 May 2026 13:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778185446; x=1778790246; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6QhSlHazNnQKAS71NPERt6rMUH+K0PvPN7gJ3+ElUdk=;
        b=H7CaVHolaB0B9vdxpCX8KD0/IYzcPm9/hb2daw2MumwRFA7DtxSe+dLFMIJAopm0JS
         CW1FsHYQRiy0hkHwl9C+gKmTx3DATphj+U5sM3z0cKO/pCexQgst9jGWyY2d/Sf8ZW4Z
         sPvDPDS0Paq0e1I3KnSdzt6iboytAkfRbumUz1JCiEeJQgMAp4fKLUp/tY1du+dm1qvz
         WoPs2Cu7wClDoP+8o0Ngc4SVpZ+xuqq8vn1VrlPUaGBieXkU5jxPIuAEdVeWC5OlGxVb
         urBANxbPSYUV4xkYpTJxpI/K/p8XcpnV5dFI3+3isPuCRFU5RLzlgBiZp+Orf2ei6PmY
         sSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778185446; x=1778790246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QhSlHazNnQKAS71NPERt6rMUH+K0PvPN7gJ3+ElUdk=;
        b=Y7F9cPuWfW6XzpfuOs/yifswahBxIPFjhKZxhbpQ4RxM1CC3EMiq9ZBjHvCkH/YEYl
         aUudzc+7JIdoPyMT5ntg9VRe7OqeWzjow5rqQpG6CAcUCsEd+FfprR1WTc+TWqkbQhNk
         o+RarfYIxxuKxxQjtBOyg5lgi7v0EMndebuLha3iwtTXZmsp1LjS0jEIBDlPM9GHkNt/
         VeobQrLzzgZzqNyTOVDhrU6kdzQKEm19ENlu+7Kvg+yhbdfCt1dxdrEz0GxzYqvddTAP
         ZgaVo72EsSSc5scWDVwnMVw+4hLkYmSKLZeyMITZp0f8tPxGMlvnYbU49drOudxtFMrY
         mLRw==
X-Gm-Message-State: AOJu0Yw1eXj8lS/KrelD4Exb60nMVUsAHv73UBShOCrQrtcbZfIVvkMp
	k/TWsmBKDKJUyyhXkeoFigRjFUyjPREu1bz4PZRCCdIT2TNQbF+EKA7Mc0R4Cg==
X-Gm-Gg: AeBDievgJCw3Uf0u7LIX4CE5dwKnWk90pSt+TwgA2rC4Uip7FOD0b9awamMuIuKmc5Q
	XZKgnkOcoAed9tdqWpQPUZhPlbAXBJe3KOxQAjta620WEmIPSH6rC40S/iZQY9hMi24nSGRrH9a
	KPMxD9dPnkJmGzjcL18hTdeVRe0JMw9KhmaIv0KSEYFELFSjVKMrD664a6XIkM/r2DXZOBtVaNc
	4e8TQxJNpx3kySMtVKUiUnS745VxWxIP+eeqxBhc6jncJnX59pr9C8ue1tm0BgFIdq/lUuHNVY8
	Jvx6nUDfNvEisFIQ18Lst/8DJp45q50vPxiLFmJzB5+sHhxXVnd6zAQqf4qUSAwL+YVwp9FDsN+
	7aVG245wmB8JHjvuMggQES04QyRLXvFilm6KEcnaQql6nCl7ZUz5chXH1hjl894POV0Oi+RiHR/
	WqEju2qE6BEt3OavYS5ZrIvkYJ+h16oDWCAoMQBVLAN0g=
X-Received: by 2002:a05:6830:d13:b0:7dc:de8a:b93e with SMTP id 46e09a7af769-7e1df20e3a3mr6145588a34.25.1778185445763;
        Thu, 07 May 2026 13:24:05 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e302457080sm406288a34.9.2026.05.07.13.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 13:24:05 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-nvme@lists.infradead.org,
	Daniel Wagner <wagi@kernel.org>
Cc: stuart.hayes@dell.com,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH] nbft: use the correct interfaces for NBFT connections
Date: Thu,  7 May 2026 15:23:45 -0500
Message-ID: <20260507202345.277280-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260507_132407_152741_F8266E20 
X-CRM114-Status: GOOD (  18.71  )
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

The NBFT specifies which network interface should be used to connect to
each namespace (using the HFI descriptor), but that is currently ignored
when "nvme connect-all --nbft" is used. If there are namespaces on
different interfaces, some namespaces can fail to connect, unless the IP
tables were already set up to route these in the desired way when the
interface isn't specified.

Add a bit of logic to look at the HFI descriptors in the NBFT and find the
network interface to use when connecting each namespace.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
 libnvme/src/nvme/fabrics.c | 91 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/libnvme/src/nvme/fabrics.c b/libnvme/src/nvme/fabrics.c
index 326287ec6..92ae498da 100644
--- a/libnvme/src/nvme/fabrics.c
+++ b/libnvme/src/nvme/fabrics.c
@@ -11,6 +11,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <fnmatch.h>
+#include <ifaddrs.h>
 #include <inttypes.h>
 #include <limits.h>
 #include <stdbool.h>
@@ -21,7 +22,9 @@
 #include <unistd.h>
 
 #include <arpa/inet.h>
+#include <linux/if_ether.h>
 #include <net/if.h>
+#include <netpacket/packet.h>
 #include <netdb.h>
 #include <sys/param.h>
 #include <sys/stat.h>
@@ -2820,6 +2823,76 @@ static int nbft_discovery(struct libnvme_global_ctx *ctx,
 	return 0;
 }
 
+#define VLAN_PROC_PATH "/proc/net/vlan"
+
+/*
+ * Return 0 for no vlan_id, to be consistent with the NBFT spec.
+ */
+static int get_vlan_id(const char *ifname)
+{
+	char path[256], line[256];
+	int vlan_id = 0;
+	FILE *f;
+
+	snprintf(path, sizeof(path), "%s/%s", VLAN_PROC_PATH, ifname);
+	f = fopen(path, "r");
+	if (!f)
+		return 0;
+
+	while (fgets(line, sizeof(line), f)) {
+		if (sscanf(line, " VID: %d", &vlan_id) == 1) {
+			fclose(f);
+			return vlan_id;
+		}
+	}
+
+	fclose(f);
+	return 0;
+}
+
+/*
+ * Find network interface corresponding to the NBFT HFI
+ * by looking for mac address and vlan id.
+ */
+static char *nbft_find_hfi_iface(struct libnbft_hfi *hfi)
+{
+	struct ifaddrs *ifaddr, *ifa;
+	char *result = NULL;
+
+	if (strcmp((char *)hfi->transport, "tcp"))
+		return NULL;
+
+	if (getifaddrs(&ifaddr) != 0)
+		return NULL;
+
+	for (ifa = ifaddr; ifa != NULL; ifa = ifa->ifa_next) {
+		struct sockaddr_ll *sll;
+
+		if (!ifa->ifa_addr)
+			continue;
+
+		if (ifa->ifa_addr->sa_family != AF_PACKET)
+			continue;
+
+		sll = (struct sockaddr_ll *)ifa->ifa_addr;
+
+		if (sll->sll_halen != ETH_ALEN)
+			continue;
+
+		if (!memcmp(sll->sll_addr, hfi->tcp_info.mac_addr, ETH_ALEN)) {
+			int vlan_id = get_vlan_id(ifa->ifa_name);
+
+			if (vlan_id == hfi->tcp_info.vlan) {
+				result = strdup(ifa->ifa_name);
+				break;
+			}
+		}
+	}
+
+	freeifaddrs(ifaddr);
+	return result;
+}
+
 __public int libnvmf_discovery_nbft(struct libnvme_global_ctx *ctx,
 		struct libnvmf_context *fctx, bool connect, char *nbft_path)
 {
@@ -2905,7 +2978,11 @@ __public int libnvmf_discovery_nbft(struct libnvme_global_ctx *ctx,
 				nfctx.transport = (*ss)->transport;
 				nfctx.traddr = (*ss)->traddr;
 				nfctx.trsvcid = (*ss)->trsvcid;
-				nfctx.host_iface = NULL;
+				nfctx.host_iface = nbft_find_hfi_iface(hfi);
+				if (!nfctx.host_iface)
+					libnvme_msg(ctx, LIBNVME_LOG_INFO,
+						"SSNS %d: could not find host interface for HFI %d\n",
+						(*ss)->index, hfi->index);
 
 				rr = nbft_connect(ctx, &nfctx, h, NULL, *ss);
 
@@ -2929,6 +3006,9 @@ __public int libnvmf_discovery_nbft(struct libnvme_global_ctx *ctx,
 							host_traddr);
 				}
 
+				if (nfctx.host_iface)
+					free((char *)nfctx.host_iface);
+
 				if (rr) {
 					libnvme_msg(ctx, LIBNVME_LOG_ERR,
 						"SSNS %d: no controller found\n",
@@ -2993,7 +3073,11 @@ __public int libnvmf_discovery_nbft(struct libnvme_global_ctx *ctx,
 			nfctx.traddr = uri->host;
 			nfctx.trsvcid = trsvcid;
 			nfctx.host_traddr = host_traddr;
-			nfctx.host_iface = NULL;
+			nfctx.host_iface = nbft_find_hfi_iface(hfi);
+			if (!nfctx.host_iface)
+				libnvme_msg(ctx, LIBNVME_LOG_INFO,
+					"SSNS %d: could not find host interface for HFI %d\n",
+					(*ss)->index, hfi->index);
 
 			/* Lookup existing discovery controller */
 			c = lookup_ctrl(h, &nfctx);
@@ -3013,6 +3097,9 @@ __public int libnvmf_discovery_nbft(struct libnvme_global_ctx *ctx,
 			} else
 				ret = 0;
 
+			if (nfctx.host_iface)
+				free((char *)nfctx.host_iface);
+
 			if (ret) {
 				libnvme_msg(ctx, LIBNVME_LOG_ERR,
 					"Discovery Descriptor %d: failed to add discovery controller: %s\n",
-- 
2.51.0


