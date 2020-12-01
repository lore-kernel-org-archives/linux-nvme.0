Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9CFC83012
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 12:56:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 498FB2086A
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 12:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P9bUivUp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="hcf1XlC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498FB2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/U/I6V0MbWeVxrlyX51r5e6kj9Uf+eW5+0p/Yia8yR8=; b=P9bUivUphmwAqD5WrevYmcUY+
	H/LwBbvh8XWZfLcaDGmxBFl0rQSGjSAsjAoGRCUlfo/yAkjwH1SgkCgnD8QgnR/o/RpeB1HpzflWi
	pyXgRqsJKVsiwpsQYibNS6LltbIk+d3y/EeKMEA5vt/3K0+ZLt3PF6zi7CuJRE9xpHDQvtqz5BmRV
	4O3dO5YDDG2W/fwoBZUCPKqyiGqs8gSkYp9vKDEPHW8OMtUcq49NU++KPr87M7NrqKl64GYpropGr
	hC/Cl8+OvQ6LtL1wOC+C5mYXsMWCEnf17DG8ITU985agc9ib23WHMaP0UrVj7LKv0I/tjnVoQBDCR
	O8VldedWQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kk5Ch-0005SZ-3V; Tue, 01 Dec 2020 12:56:23 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kk5Cc-0005Qt-Hu
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 12:56:19 +0000
Received: by mail-ed1-x544.google.com with SMTP id ck29so3056902edb.8
 for <linux-nvme@lists.infradead.org>; Tue, 01 Dec 2020 04:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RDAJFTOJhz1IwZLtoSRx6PSuhtJlEvB7uRt7tHupXWY=;
 b=hcf1XlC2Q9J2qkWqVwiakA1iMAhjDc9uSsCZ3bmbKuagTYvoBjnQ8875DsRtTCOQ9T
 f6twovBHO4htj29liM9pKjbvE5hHEb3+It0TJKMqUWLmKUBDHq++SROR/zPEMc7RRHVI
 UpH4Nn+79mo9fXgY1VZWq4jdQu+yyJEYhDkCw8kn7AvTf/g7s4lQc3SSYNyHixuRxgJ0
 ir687mQTmgvrcWu7EvRzT7E1iS5VDDuQKg0TxfD5QlgEb/HFx/AWxRgknfWVe3+LlB7Q
 JZM6dc2e60Iwa4sj3K0uPnRoLzHtpMESZE/gUxZbzXwLs27Ywgtiha4fdWUgfbsNjW/j
 TA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RDAJFTOJhz1IwZLtoSRx6PSuhtJlEvB7uRt7tHupXWY=;
 b=p4hIn0O1OFWyfkDY7Y847DcBvMgKmaW+vcD9mZYj77k7B74Zc6e/iVKqfTC+DM2391
 NpvmN8vD/iGlA2vy22zAIDXF7fZudui5urIE/+/9Tlukv8hVZxsRohrGgMTn/InEi3Id
 ulVvhd8aDwcLQW9r784Uod+F4DgGcWjHF6Jj6ph6ubugJCCZwdN02AtM/FZCwW5DC7NC
 cBX0yRQ7Vvo88wfDDio4ghyavFvXMWy/WBrtG30PadLLSbGM193KY1PDLuuFevEN7Bm6
 NHyPzIooft0Tpwk8/C+nXB8gZ8v2VwMH8E5ChvZirStlCxKmwi+yP0IbFVY2SvTxCvWp
 i1Jg==
X-Gm-Message-State: AOAM530+TCpnpIrKrx4rMcRGCDZgzL0+e04ZEwA81HMG0wNv/IhjoTZ9
 HaMgpfAx5JwtpU7/EIthUthl/l809eJ9+OAsDp0=
X-Google-Smtp-Source: ABdhPJzfLiUXsNDBawvEvhjO//SROUMUE3ztr/pyCDHEPwn/uzLjsAu6wF5TY2bt2LcD1BePUA+/mA==
X-Received: by 2002:aa7:db56:: with SMTP id n22mr2991040edt.4.1606827377397;
 Tue, 01 Dec 2020 04:56:17 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk.
 [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id be6sm796864edb.29.2020.12.01.04.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 04:56:16 -0800 (PST)
From: javier@javigon.com
X-Google-Original-From: javier.gonz@samsung.com
To: linux-nvme@lists.infradead.org
Subject: [PATCH 3/4] nvme: rename bdev operations
Date: Tue,  1 Dec 2020 13:56:09 +0100
Message-Id: <20201201125610.17138-4-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201201125610.17138-1-javier.gonz@samsung.com>
References: <20201201125610.17138-1-javier.gonz@samsung.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_075618_683519_E7E317CD 
X-CRM114-Status: GOOD (  14.99  )
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
Cc: linux-block@vger.kernel.org, kbusch@kernel.org,
 =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>, hch@lst.de,
 sagi@grimberg.me
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+CgpSZW1hbmUg
YmxvY2sgZGV2aWNlIG9wZXJhdGlvbnMgaW4gcHJlcGFyYXRpb24gdG8gYWRkIGNoYXIgZGV2aWNl
IGZpbGUKb3BlcmF0aW9ucy4KClNpZ25lZC1vZmYtYnk6IEphdmllciBHb256w6FsZXogPGphdmll
ci5nb256QHNhbXN1bmcuY29tPgotLS0KIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8IDggKysr
Ky0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3Qv
Y29yZS5jCmluZGV4IGMyM2M4OTFhOGZiOC4uMmMyM2VhNmRjMjk2IDEwMDY0NAotLS0gYS9kcml2
ZXJzL252bWUvaG9zdC9jb3JlLmMKKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCkBAIC0y
MjkyLDcgKzIyOTIsNyBAQCBpbnQgbnZtZV9zZWNfc3VibWl0KHZvaWQgKmRhdGEsIHUxNiBzcHNw
LCB1OCBzZWNwLCB2b2lkICpidWZmZXIsIHNpemVfdCBsZW4sCiBFWFBPUlRfU1lNQk9MX0dQTChu
dm1lX3NlY19zdWJtaXQpOwogI2VuZGlmIC8qIENPTkZJR19CTEtfU0VEX09QQUwgKi8KIAotc3Rh
dGljIGNvbnN0IHN0cnVjdCBibG9ja19kZXZpY2Vfb3BlcmF0aW9ucyBudm1lX2ZvcHMgPSB7Citz
dGF0aWMgY29uc3Qgc3RydWN0IGJsb2NrX2RldmljZV9vcGVyYXRpb25zIG52bWVfYmRldl9vcHMg
PSB7CiAJLm93bmVyCQk9IFRISVNfTU9EVUxFLAogCS5pb2N0bAkJPSBudm1lX2lvY3RsLAogCS5j
b21wYXRfaW9jdGwJPSBudm1lX2NvbXBhdF9pb2N0bCwKQEAgLTMzMDEsNyArMzMwMSw3IEBAIHN0
YXRpYyBpbmxpbmUgc3RydWN0IG52bWVfbnNfaGVhZCAqZGV2X3RvX25zX2hlYWQoc3RydWN0IGRl
dmljZSAqZGV2KQogewogCXN0cnVjdCBnZW5kaXNrICpkaXNrID0gZGV2X3RvX2Rpc2soZGV2KTsK
IAotCWlmIChkaXNrLT5mb3BzID09ICZudm1lX2ZvcHMpCisJaWYgKGRpc2stPmZvcHMgPT0gJm52
bWVfYmRldl9vcHMpCiAJCXJldHVybiBudm1lX2dldF9uc19mcm9tX2RldihkZXYpLT5oZWFkOwog
CWVsc2UKIAkJcmV0dXJuIGRpc2stPnByaXZhdGVfZGF0YTsKQEAgLTM0MTAsNyArMzQxMCw3IEBA
IHN0YXRpYyB1bW9kZV90IG52bWVfbnNfaWRfYXR0cnNfYXJlX3Zpc2libGUoc3RydWN0IGtvYmpl
Y3QgKmtvYmosCiAJfQogI2lmZGVmIENPTkZJR19OVk1FX01VTFRJUEFUSAogCWlmIChhID09ICZk
ZXZfYXR0cl9hbmFfZ3JwaWQuYXR0ciB8fCBhID09ICZkZXZfYXR0cl9hbmFfc3RhdGUuYXR0cikg
ewotCQlpZiAoZGV2X3RvX2Rpc2soZGV2KS0+Zm9wcyAhPSAmbnZtZV9mb3BzKSAvKiBwZXItcGF0
aCBhdHRyICovCisJCWlmIChkZXZfdG9fZGlzayhkZXYpLT5mb3BzICE9ICZudm1lX2JkZXZfb3Bz
KSAvKiBwZXItcGF0aCBhdHRyICovCiAJCQlyZXR1cm4gMDsKIAkJaWYgKCFudm1lX2N0cmxfdXNl
X2FuYShudm1lX2dldF9uc19mcm9tX2RldihkZXYpLT5jdHJsKSkKIAkJCXJldHVybiAwOwpAQCAt
Mzg2Myw3ICszODYzLDcgQEAgc3RhdGljIHZvaWQgbnZtZV9hbGxvY19ucyhzdHJ1Y3QgbnZtZV9j
dHJsICpjdHJsLCB1bnNpZ25lZCBuc2lkLAogCWlmICghZGlzaykKIAkJZ290byBvdXRfdW5saW5r
X25zOwogCi0JZGlzay0+Zm9wcyA9ICZudm1lX2ZvcHM7CisJZGlzay0+Zm9wcyA9ICZudm1lX2Jk
ZXZfb3BzOwogCWRpc2stPnByaXZhdGVfZGF0YSA9IG5zOwogCWRpc2stPnF1ZXVlID0gbnMtPnF1
ZXVlOwogCWRpc2stPmZsYWdzID0gZmxhZ3M7Ci0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApM
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
