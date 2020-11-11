Return-Path: <SRS0=YOZe=ER=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62C0C55ABD
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 12:46:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6766B206F1
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 12:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m/t+8ZWL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="SXuNXDjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6766B206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=U5P65HDuHFg3EXcf819xRG5jQsW9BPrxn4O5uVwDVTU=; b=m/t+8ZWL6AT4dXs0CJz4DUlQj
	RfWKk+tRYY+q//mIFNvmmZTbVpPIAmkbUIzfeTeNeNb03l5cHy5m3oo/J9tNdx810efNRP1G+ZydF
	zFIMdoDjcTDUYl4ilr2pymWGXpehtCeCxzuN9IYBGJbnX8/ZBljCJyTLjQjoeei1Wo2VGqeFoiEpy
	pLBLPruofjnCFPtqYEnvmFYU5ru2XOAsh2v3XjiAvEJsZe32pLQs35dl7txXDNsod54ia/5K3L9Q5
	8CIdZ/ebJRhGz5+2BIzPVQ/mMUAyI8Ai854MTM2MmVdldnwa632e07DpBUJjAnt/SUkFVG1GPDUZ0
	wHqmur9sw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcpWT-0002wn-5J; Wed, 11 Nov 2020 12:46:49 +0000
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcpWP-0002v3-CZ
 for linux-nvme@lists.infradead.org; Wed, 11 Nov 2020 12:46:46 +0000
Received: by mail-ej1-x641.google.com with SMTP id s25so2573553ejy.6
 for <linux-nvme@lists.infradead.org>; Wed, 11 Nov 2020 04:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MdPu3wHy0Sjco3BqLc5dTo6hzwsxW20yC+RscSgk9UE=;
 b=SXuNXDjID1+sMS4dZqpn8SrnOQh+zlMFAWEKpByieNYcMtjBQo/90K/CxF8WFkTxZf
 Ct5tNdJCGbA/ML8xXLUS/smBtWqGoRoqQOSJsN0Q53ZO9W5c2GNHoGa/Nf8242Fnl1zl
 AqllXApdPkAtK3Trso/NnXOC4tQAHDewFUh5OWsGhmaK/BvXZRghOZ3OivyBrrZWeG3W
 Hll+7dW7+jKEBy0+TQXpoNCF9VuqzL4tcLlfN/lTl83/hV8hi3QKctAlp7H3BJ1EweBT
 kRyIAPrNWCiH4T69GHdYzH5qo4KT1pY0uFbxDJpfh8NhDu5lGlPMPbU+AH2G+vzy1c6g
 hFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MdPu3wHy0Sjco3BqLc5dTo6hzwsxW20yC+RscSgk9UE=;
 b=k5ePjml/vIPCMIJXRY73FXX2N9VMvqhJpzaaHHSBAmDLeWnQUWHafvUxYQ8G6TVeYs
 IYDrtriGhFvtLHSQdsPkRbYbDaJto13hxoQUJt6v1GzTGCghZiHYO/gjtr81u+zZpNzV
 8x4RbB9CWAdkrOzGbQgISuuuFzuzY45r2VcI1Bmewzd9hFfrLt15V56tINOGv4u+JErw
 5m7p1fkedmonjqdQW2k4S0vB81T1umcdxDes0oVNoBjUIqRtqSs68odqNrHOfkItTFDQ
 rnjPo67EdIsobxuUtYKSWPzxMkws/pMRwZWOTBHPcMH+V01NLHE47sa2OBIfpCHxHdCh
 ApuA==
X-Gm-Message-State: AOAM531L9uUvOQmOLqPIayCRmBUYx5e85C+WmNXokXYZGgnDxLL42iwa
 b10TQ8j5scLyGBg5pWTtrL4uHBUcz1BYd2Yb
X-Google-Smtp-Source: ABdhPJw30G0e6ETGZk6X7FHrSK0BHdFJiQQ/cA/U79TsEW2BzUPRAfQ1w9yZxM8v8Ls91RT2rzMffA==
X-Received: by 2002:a17:906:12cf:: with SMTP id
 l15mr26493252ejb.540.1605098803560; 
 Wed, 11 Nov 2020 04:46:43 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk.
 [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id h22sm840290ejt.21.2020.11.11.04.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 04:46:42 -0800 (PST)
From: javier@javigon.com
X-Google-Original-From: javier@samsung.com
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme: enable ro namespace for ZNS without append
Date: Wed, 11 Nov 2020 13:46:39 +0100
Message-Id: <20201111124639.11305-2-javier@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111124639.11305-1-javier@samsung.com>
References: <20201111124639.11305-1-javier@samsung.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201111_074645_565878_08F5263A 
X-CRM114-Status: GOOD (  22.69  )
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
Cc: axboe@kernel.dk, Niklas.Cassel@wdc.com, sagi@grimberg.me,
 joshi.k@samsung.com, k.jensen@samsung.com, linux-block@vger.kernel.org,
 kbusch@kernel.org,
 =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+CgpBbGxvdyBa
TlMgTlZNZSBTU0RzIHRvIHByZXNlbnQgYSByZWFkLW9ubHkgbmFtZXNwYWNlIHdoZW4gYXBwZW5k
IGlzIG5vdApzdXBwb3J0ZWQsIGluc3RlYWQgb2YgcmVqZWN0aW5nIHRoZSBuYW1lc3BhY2UgZGly
ZWN0bHkuCgpUaGlzIGFsbG93cyAoaSkgdGhlIG5hbWVzcGFjZSB0byBiZSB1c2VkIGluIHJlYWQt
b25seSBtb2RlLCB3aGljaCBpcyBub3QKYSBwcm9ibGVtIGFzIHRoZSBhcHBlbmQgY29tbWFuZCBv
bmx5IGFmZmVjdHMgdGhlIHdyaXRlIHBhdGgsIGFuZCAoaWkpIHRvCnVzZSBzdGFuZGFyZCBtYW5h
Z2VtZW50IHRvb2xzIHN1Y2ggYXMgbnZtZS1jbGkgdG8gY2hvb3NlIGEgZGlmZmVyZW50CmZvcm1h
dCBvciBmaXJtd2FyZSBzbG90IHRoYXQgaXMgY29tcGF0aWJsZSB3aXRoIHRoZSBMaW51eCB6b25l
ZCBibG9jawpkZXZpY2UuCgpUaGlzIHBhdGNoIGluY2x1ZGVzIGNvbW1lbnRzIGZyb20gQ2hyaXN0
b3BoLCBOaWtsYXMgYW5kIEtlaXRoIHRoYXQKYXBwbGllZCB0byBhIGRpZmZlcmVudCBhcHByb2Fj
aCBzZXR0aW5nIGNhcGFjaXR5IHRvIDAKICBodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9s
aW51eC1ibG9jay9tc2c2MDc0Ny5odG1sCgpUaGUgcmVtaW5kZXIgb2YgdGhlIG9yaWdpbmFsIHBh
dGNoIHdpbGwgYmUgc3VibWl0dGVkIHNlcGFyYXRlbHkuCgpDaGFuZ2VzIHNpbmNlIFYzOgogIC0g
Rm9yY2UgcmUtcmVhZGluZyBlZmZlY3RzIGxvZyBwYWdlIChmcm9tIEtlaXRoKQogIC0gUGVuZGlu
ZyBwcm9wZXIgcmVmcmVzaCBvZiBSTyBmbGFnIC0gZGVwZW5kZW5jeSBvbiBwYXRjaCBmcm9tIENo
cmlzdG9waAoKQ2hhbmdlcyBzaW5jZSBWMjoKICAtIEZpeCBzbWFsbCBjb25mbGljdCB3aXRoIGEg
cXVldWVkIHBhdGNoIGZyb20gU2FnaSAoZnJvbSBDaHJpc3RvcGgpCiAgLSBGaXggaW5kZW50YXRp
b24gKGZyb20gTmlrbGFzKQogIC0gUmVmcmVzaCBlZmZlY3RzIGxvZyBwYWdlIHRvIGFjY291bnQg
Zm9yIEZXIGNoYW5nZXMgKGZyb20gS2VpdGgpCgpDaGFuZ2VzIHNpbmNlIFYxOgogIC0gQ2hhbmdl
IGxvZ2ljIHRvIHVzZSBOVk1FX05TX0FUVFJfUk8gKGZyb20gQ2hyaXN0b3BoKQogIC0gU2V0IG1h
eF96b25lX2FwcGVuZCBlZ2VuIGluIFJPLiBUaGlzIGFsbG93cyB0aGUgZGV2aWNlIHRvIGJlCiAg
ICBwcm9wZXJseSByZXZhbGlkYXRlZCBhbmQgZW5hYmxlcyB1c2VyLXNwYWNlIHRvb2xzIHN1Y2gg
YXMgYmxrem9uZSB0bwogICAgYmUgdXNlZCB3aGVuIGludGVyYWN0aW5nIHdpdGggdGhpcyB6b25l
ZCBkZXZpY2UuCgpTaWduZWQtb2ZmLWJ5OiBKYXZpZXIgR29uesOhbGV6IDxqYXZpZXIuZ29uekBz
YW1zdW5nLmNvbT4KLS0tCiBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgfCAgNSArKy0tLQogZHJp
dmVycy9udm1lL2hvc3QvbnZtZS5oIHwgIDIgKysKIGRyaXZlcnMvbnZtZS9ob3N0L3pucy5jICB8
IDE5ICsrKysrKysrKysrKysrLS0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygr
KSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMg
Yi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKaW5kZXggZTRjNzlmMWQyZTk2Li4xNzA3NDVkNGEz
NGIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYworKysgYi9kcml2ZXJzL252
bWUvaG9zdC9jb3JlLmMKQEAgLTIwODMsNyArMjA4Myw3IEBAIHN0YXRpYyB2b2lkIG52bWVfdXBk
YXRlX2Rpc2tfaW5mbyhzdHJ1Y3QgZ2VuZGlzayAqZGlzaywKIAludm1lX2NvbmZpZ19kaXNjYXJk
KGRpc2ssIG5zKTsKIAludm1lX2NvbmZpZ193cml0ZV96ZXJvZXMoZGlzaywgbnMpOwogCi0JaWYg
KGlkLT5uc2F0dHIgJiBOVk1FX05TX0FUVFJfUk8pCisJaWYgKGlkLT5uc2F0dHIgJiBOVk1FX05T
X0FUVFJfUk8gfHwgdGVzdF9iaXQoTlZNRV9OU19GT1JDRV9STywgJm5zLT5mbGFncykpCiAJCXNl
dF9kaXNrX3JvKGRpc2ssIHRydWUpOwogfQogCkBAIC0yOTUxLDggKzI5NTEsNyBAQCBpbnQgbnZt
ZV9nZXRfbG9nKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsIHUzMiBuc2lkLCB1OCBsb2dfcGFnZSwg
dTggbHNwLCB1OCBjc2ksCiAJcmV0dXJuIG52bWVfc3VibWl0X3N5bmNfY21kKGN0cmwtPmFkbWlu
X3EsICZjLCBsb2csIHNpemUpOwogfQogCi1zdGF0aWMgaW50IG52bWVfZ2V0X2VmZmVjdHNfbG9n
KHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsIHU4IGNzaSwgc3RydWN0IG52bWVfZWZmZWN0c19sb2cg
Kipsb2csCi0JCQkJYm9vbCBmb3JjZSkKK2ludCBudm1lX2dldF9lZmZlY3RzX2xvZyhzdHJ1Y3Qg
bnZtZV9jdHJsICpjdHJsLCB1OCBjc2ksIHN0cnVjdCBudm1lX2VmZmVjdHNfbG9nICoqbG9nLCBi
b29sIGZvcmNlKQogewogCXN0cnVjdCBudm1lX2NlbCAqY2VsID0geGFfbG9hZCgmY3RybC0+Y2Vs
cywgY3NpKTsKIAlpbnQgcmV0OwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5o
IGIvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oCmluZGV4IDgzZmIzMGUzMTdlMC4uY2RmY2U3MjUw
ZGEwIDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgKKysrIGIvZHJpdmVycy9u
dm1lL2hvc3QvbnZtZS5oCkBAIC00NDksNiArNDQ5LDcgQEAgc3RydWN0IG52bWVfbnMgewogI2Rl
ZmluZSBOVk1FX05TX1JFTU9WSU5HCTAKICNkZWZpbmUgTlZNRV9OU19ERUFEICAgICAJMQogI2Rl
ZmluZSBOVk1FX05TX0FOQV9QRU5ESU5HCTIKKyNkZWZpbmUgTlZNRV9OU19GT1JDRV9STwkzCiAK
IAlzdHJ1Y3QgbnZtZV9mYXVsdF9pbmplY3QgZmF1bHRfaW5qZWN0OwogCkBAIC02MzgsNiArNjM5
LDcgQEAgaW50IG52bWVfZGVsZXRlX2N0cmwoc3RydWN0IG52bWVfY3RybCAqY3RybCk7CiAKIGlu
dCBudm1lX2dldF9sb2coc3RydWN0IG52bWVfY3RybCAqY3RybCwgdTMyIG5zaWQsIHU4IGxvZ19w
YWdlLCB1OCBsc3AsIHU4IGNzaSwKIAkJdm9pZCAqbG9nLCBzaXplX3Qgc2l6ZSwgdTY0IG9mZnNl
dCk7CitpbnQgbnZtZV9nZXRfZWZmZWN0c19sb2coc3RydWN0IG52bWVfY3RybCAqY3RybCwgdTgg
Y3NpLCBzdHJ1Y3QgbnZtZV9lZmZlY3RzX2xvZyAqKmxvZywgYm9vbCBmb3JjZSk7CiBzdHJ1Y3Qg
bnZtZV9ucyAqbnZtZV9nZXRfbnNfZnJvbV9kaXNrKHN0cnVjdCBnZW5kaXNrICpkaXNrLAogCQlz
dHJ1Y3QgbnZtZV9uc19oZWFkICoqaGVhZCwgaW50ICpzcmN1X2lkeCk7CiB2b2lkIG52bWVfcHV0
X25zX2Zyb21fZGlzayhzdHJ1Y3QgbnZtZV9uc19oZWFkICpoZWFkLCBpbnQgaWR4KTsKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3pucy5jIGIvZHJpdmVycy9udm1lL2hvc3Qvem5zLmMK
aW5kZXggNjdlODdlOWYzMDZmLi5kZmQxYzM4Yjk1ZDQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZt
ZS9ob3N0L3pucy5jCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3pucy5jCkBAIC01NCwxMyArNTQs
MjIgQEAgaW50IG52bWVfdXBkYXRlX3pvbmVfaW5mbyhzdHJ1Y3QgbnZtZV9ucyAqbnMsIHVuc2ln
bmVkIGxiYWYpCiAJc3RydWN0IG52bWVfaWRfbnNfem5zICppZDsKIAlpbnQgc3RhdHVzOwogCisJ
LyogUmVmcmVzaCBlZmZlY3RzIGxvZyBwYWdlIHRvIGNoZWNrIGZvciBjaGFuZ2VzIG9uIGFwcGVu
ZCBzdXBwb3J0ICovCisJc3RhdHVzID0gbnZtZV9nZXRfZWZmZWN0c19sb2cobnMtPmN0cmwsIG5z
LT5oZWFkLT5pZHMuY3NpLCAmbnMtPmhlYWQtPmVmZmVjdHMsIHRydWUpOworCWlmIChzdGF0dXMp
CisJCXJldHVybiBzdGF0dXM7CisKIAkvKiBEcml2ZXIgcmVxdWlyZXMgem9uZSBhcHBlbmQgc3Vw
cG9ydCAqLwotCWlmICghKGxlMzJfdG9fY3B1KGxvZy0+aW9jc1tudm1lX2NtZF96b25lX2FwcGVu
ZF0pICYKLQkJCU5WTUVfQ01EX0VGRkVDVFNfQ1NVUFApKSB7CisJaWYgKChsZTMyX3RvX2NwdShs
b2ctPmlvY3NbbnZtZV9jbWRfem9uZV9hcHBlbmRdKSAmIE5WTUVfQ01EX0VGRkVDVFNfQ1NVUFAp
KSB7CisJCWlmICh0ZXN0X2FuZF9jbGVhcl9iaXQoTlZNRV9OU19GT1JDRV9STywgJm5zLT5mbGFn
cykpCisJCQlkZXZfd2Fybihucy0+Y3RybC0+ZGV2aWNlLAorCQkJCSAiYXBwZW5kIHN1cHBvcnRl
ZCBmb3Igem9uZWQgbmFtZXNwYWNlOiVkLiBSZW1vdmUgcmVhZC1vbmx5IG1vZGVcbiIsCisJCQkJ
IG5zLT5oZWFkLT5uc19pZCk7CisJfSBlbHNlIHsKKwkJc2V0X2JpdChOVk1FX05TX0ZPUkNFX1JP
LCAmbnMtPmZsYWdzKTsKIAkJZGV2X3dhcm4obnMtPmN0cmwtPmRldmljZSwKLQkJCSJhcHBlbmQg
bm90IHN1cHBvcnRlZCBmb3Igem9uZWQgbmFtZXNwYWNlOiVkXG4iLAotCQkJbnMtPmhlYWQtPm5z
X2lkKTsKLQkJcmV0dXJuIC1FSU5WQUw7CisJCQkgImFwcGVuZCBub3Qgc3VwcG9ydGVkIGZvciB6
b25lZCBuYW1lc3BhY2U6JWQuIEZvcmNpbmcgdG8gcmVhZC1vbmx5IG1vZGVcbiIsCisJCQkgbnMt
PmhlYWQtPm5zX2lkKTsKIAl9CiAKIAkvKiBMYXppbHkgcXVlcnkgY29udHJvbGxlciBhcHBlbmQg
bGltaXQgZm9yIHRoZSBmaXJzdCB6b25lZCBuYW1lc3BhY2UgKi8KLS0gCjIuMTcuMQoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFp
bGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
