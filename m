Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FF5C56201
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 02:41:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B089F206C0
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 02:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xrs5vWdb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mgmK2jSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B089F206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lAVH9pAWQdQ/7u3VsoX0Bn0IUOhZNiFoq5qHC+oVLAA=; b=xrs5vWdbeD8CpQfK9/7TBLzLY
	6pngIVlryfLcEFu5MxRdIMylR5g+aApaQZu9Ea4/Kw+hg02Q1bhsMrQd6PM2B/g5+S9XYj8USq20V
	6cavKA6qcK99YV8TUZL2TMEnIpIxEyAirk5IpxJb8lZt5bzX1ZRvwx3q15sGUxEGFyhb6ZsQXGKn2
	4OPgCDLomc6sHWCtwethLIuSzyYhNt7MbvuGaim6oktC7WRQQfx+Iw6s7BMUeswKvQnOZcE88pYm3
	jW4/HMLDrH1fGV8iF08YkHE5JcuKhDUJQ52uSv17WRaZ15NrZF+fIbrL19g3HjBWa4ebbCmikPsJc
	YjOauqCBg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ki7E4-0005ED-DR; Thu, 26 Nov 2020 02:41:40 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ki7Dw-0005CI-Ip
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 02:41:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606358492; x=1637894492;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hpoI1V55y5gwFhJlJIS3F+nAY0E41Z5thazQ0M5y7lA=;
 b=mgmK2jShowMIjjQGWPYxVUf+7oJKX18RnCD8qOwDgLcSVdMQ62xefAuE
 A5j7j2MdvhrPREySAgsBltsYtMzjU0CXFH10b+1AbSAiE8AuBfbyNMdT/
 9ZwtNVUDfzcTKP1EuRSYhPvyI5mP6RmAjqoXrMapO4cOwCYUIEM+kI6MK
 K8q+Q/jOYAGiffA/hwyafIFIox8AN8id2erBGmn8ZCCCZ8uqoklLCxweK
 LQFS8lH1t6/3u4dO9Aiw8YHrvM9wGbdWmIgT+rIjDoKrqiJy+xCAm+wbi
 yLhuQLfJPPKwFiQbG44Qf6XbDnwd+OEZ//o3UfyaQwVmasTx4Nb3z6xKb A==;
IronPort-SDR: eMjw60w6VFAPRf95Zn7Km7cPEz1d4+uTfAZ+Y6TrLzFh3DVmSXANpoB2HbKzmgOd/JMddDdutm
 jXFRgI1FvYm9GKEB5p3QWHOYWF8gRzTFfvnRzEXFpEy3U0zZJPH1RjXwNa7UJcbpmMVFYCHFL8
 xnqWZYu7jnPrWVqKRxspud71QFqg5niD8EwKX2+c3eH4JkE8ztu465H3RAK4MfCV23YkNWkpwU
 zcM9DgGj7wY8Mmw8HWiRybe7cJV2PvlOf9KWXD7eIXdmWrPfdm3siotMSAbxjRnZL1Fu7P+KTv
 FlQ=
X-IronPort-AV: E=Sophos;i="5.78,370,1599494400"; d="scan'208";a="263593235"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 10:41:31 +0800
IronPort-SDR: omLAhOuuLNszsSwOEP0BCb6sH3HRHj0Sf1ZaeKhS8tK+VjoAOtgpazK6/su0SN1ijH4GxQyiLf
 OiLjO56bTbH2WU3+hhds1KypQp+l1HSSs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2020 18:27:14 -0800
IronPort-SDR: enmtt+Or6DoLJmp0NbpiS6ndWSSk5cAWh1INEVyXm5F8/n67xcFYFIRYGcCIFMEyViN0V8xMdi
 0oc8SJcSF1DA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Nov 2020 18:41:31 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 4/9] nvmet: add NVME_CSI_ZNS in ns-desc for zbdev
Date: Wed, 25 Nov 2020 18:40:38 -0800
Message-Id: <20201126024043.3392-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_214133_980621_7DD3B8BC 
X-CRM114-Status: GOOD (  13.69  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

V2hlbiBkaXNjb3ZlcmluZyB0aGUgWk5TLCB0aGUgaG9zdC1zaWRlwqBsb29rcyBmb3IgdGhlIE5W
TUVfQ1NJX1pOUwp2YWx1ZSBpbiB0aGUgbnMtZGVzYy4gVXBkYXRlIHRoZSBudm1ldF9leGVjdXRl
X2lkZW50aWZ5X2Rlc2NsaXN0KCkKc3VjaCB0aGF0IGl0IGNhbiBub3cgdXBkYXRlIHRoZSBucy1k
ZXNjIHdpdGggTlZNRV9DU0lfWk5TIGlmIGJkZXYgaXMKem9uZWQuCgpTaWduZWQtb2ZmLWJ5OiBD
aGFpdGFueWEgS3Vsa2FybmkgPGNoYWl0YW55YS5rdWxrYXJuaUB3ZGMuY29tPgotLS0KIGRyaXZl
cnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMgfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5j
IGIvZHJpdmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQuYwppbmRleCBjNjRiNDBjNjMxZTAuLmQ0
ZmMxYmIxYTMxOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQuYwor
KysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5jCkBAIC02MjgsNiArNjI4LDEwIEBA
IHN0YXRpYyB2b2lkIG52bWV0X2V4ZWN1dGVfaWRlbnRpZnlfZGVzY2xpc3Qoc3RydWN0IG52bWV0
X3JlcSAqcmVxKQogCQkJZ290byBvdXQ7CiAJfQogCisJc3RhdHVzID0gbnZtZXRfcHJvY2Vzc196
bnNfY2lzKHJlcSwgJm9mZik7CisJaWYgKHN0YXR1cykKKwkJZ290byBvdXQ7CisKIAlpZiAoc2df
emVyb19idWZmZXIocmVxLT5zZywgcmVxLT5zZ19jbnQsIE5WTUVfSURFTlRJRllfREFUQV9TSVpF
IC0gb2ZmLAogCQkJb2ZmKSAhPSBOVk1FX0lERU5USUZZX0RBVEFfU0laRSAtIG9mZikKIAkJc3Rh
dHVzID0gTlZNRV9TQ19JTlRFUk5BTCB8IE5WTUVfU0NfRE5SOwotLSAKMi4yMi4xCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWls
aW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
