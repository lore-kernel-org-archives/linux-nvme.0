Return-Path: <SRS0=t83a=6I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D6FC2BA19
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2020 01:15:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5F822074F
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2020 01:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DYgpHONc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YGMC9RZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F822074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5MHbog9QBJPQ1uy3vrrwsWMOqZjEfhjV4sD+fAZE3m4=; b=DYgpHONcwdDBHj
	2yUfBCaAXHd7LdpIR1OHG4X1DlkJqjrutfVzroKgRn32ZdA/jOh5os72nsDjAIMc/uWru41a4nvvA
	JFUf95ngUDQVV5ZoHq6wv4Bk68Iah31fTjgP7uTEwPIG9ezR82hvVzjB3v93ECDnYTG/TyocI2obI
	mmgeNBXsAAEZ+hZneaR28qzVkMNf1yF27p4Q2v1RJ5UNBJqpUXqe792xTDP6jxUVG/9fxSdAFw6az
	R6WR4BH6a/PCtF9zB6jezuNUZwjPasHeH+mstQpfEkpkaslGBed1INOtLZ36+6FGQ1xxsWvEaXzR+
	pGGW4AOPuS0DygS8BKWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jRmvn-00045a-9t; Fri, 24 Apr 2020 01:15:03 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRmvk-0003wY-LK
 for linux-nvme@lists.infradead.org; Fri, 24 Apr 2020 01:15:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587690916; x=1619226916;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=LS3aWyxri3TUnkgDSrWi8p2kd2MvqxrpKpRXWwXTmVY=;
 b=YGMC9RZjUoQJEwNt3/5V8rAw/r1epz1Xmgk/YM6Bl14L/n/Z4g2NnSp0
 eXNB0tg75lNURnMCVen4dqmDpmQrTfyPvo6ONGCCHzgp3Uj3cXxEHpRtA
 edNvS/D9/UmkjmgR8jv6O3skZJkfeo4fXP//h9PKfaumtdQbQfJ+1CQKn
 LlK3hPyqBWoO7NtvvMT/zoyY7Emw3C+a7ykWZt5B1vRTKIBm1+yCbGaIY
 04DELXBcuvDclN8DAmTaVQyOva1ncjUfxbqkL8Crp1Q72Efnhg/rMcMiV
 eM8zTyGwuklMOg9hDKFuaG+SeXez2CYqi+Y8lvRmpEjHbq9uaMCb2HiBA Q==;
IronPort-SDR: yB12iHL2zH/TEN7lb+4Zs0vL80uNa6rc1J2IBpaSr973OIStTiVYrUeT+H65Ldn1YmNTU7Xq/K
 colPKgwckXNiQijAUYqM18hXCw1SgaI9f1N96OJQyHjjHL9kZ+IbI0cbrVnY+ULd0p2MF0bvAG
 kbMhR+4fijV8acOszM9gsywy08V7s0b6ubwb3sGc28f5QzS3h/ctdkh3MVV4SjA4s/O3fqjf0g
 JZ0VRFdMvv+NcssnrIspsSkIp9dDMEQbJ6sQhn4YBcN5tj2E6qAKgoiXqVy2rw/k2hCvalkZm2
 TYs=
X-IronPort-AV: E=Sophos;i="5.73,309,1583164800"; d="scan'208";a="238524455"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2020 09:15:06 +0800
IronPort-SDR: jRCVwHaVFQen+UGfSjiEZmyuVKvJywf45bHkEVuMemJFkEc+v42xCWDtCd25DOv4AZ5y8fU+yD
 K3vE6IGSlztSvFHM09YuwWNRm94yofjAY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2020 18:05:08 -0700
IronPort-SDR: KU6vlyquvqSynhbFxxe9/2zuw6C4gjyJPnYXQ8an6e9HxeXLMfTEvaRxYVMINcIoZmwKQCGAeG
 WSY3+rKWRcYg==
WDCIronportException: Internal
Received: from wdsc_char_051.sc.wdc.com (HELO xfs.sc.wdc.com) ([10.4.170.150])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Apr 2020 18:14:54 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: fix compiler warnings
Date: Thu, 23 Apr 2020 18:14:53 -0700
Message-Id: <20200424011453.11156-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200423_181500_794764_AE03B1EB 
X-CRM114-Status: GOOD (  13.32  )
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
Cc: kbusch@kernel.org, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGhpcyBwYXRjaCBmaXhlcyB0aGUgZm9sbG93aW5nIGVycm9ycyA6LQoKbnZtZS10b3BvbG9neS5j
OiBJbiBmdW5jdGlvbiDigJh2ZXJpZnlfbGVnYWN5X25z4oCZOgpudm1lLXRvcG9sb2d5LmM6MzYx
OjMyOiBlcnJvcjogZm9ybWF0IG5vdCBhIHN0cmluZyBsaXRlcmFsIGFuZCBubyBmb3JtYXQgYXJn
dW1lbnRzIFstV2Vycm9yPWZvcm1hdC1zZWN1cml0eV0KICAzNjEgfCAgICBhc3ByaW50Zigmbi0+
Y3RybC0+YWRkcmVzcywgdG1wX2FkZHJlc3MpOwogICAgICB8ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBefn5+fn5+fn5+fgpudm1lLXRvcG9sb2d5LmM6MzYwOjQ6IGVycm9yOiBpZ25v
cmluZyByZXR1cm4gdmFsdWUgb2Yg4oCYYXNwcmludGbigJksIGRlY2xhcmVkIHdpdGggYXR0cmli
dXRlIHdhcm5fdW51c2VkX3Jlc3VsdCBbLVdlcnJvcj11bnVzZWQtcmVzdWx0XQogIDM2MCB8ICAg
IGFzcHJpbnRmKCZuLT5jdHJsLT50cmFuc3BvcnQsICJwY2llIik7CiAgICAgIHwgICAgXn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgpudm1lLXRvcG9sb2d5LmM6MzYxOjQ6IGVy
cm9yOiBpZ25vcmluZyByZXR1cm4gdmFsdWUgb2Yg4oCYYXNwcmludGbigJksIGRlY2xhcmVkIHdp
dGggYXR0cmlidXRlIHdhcm5fdW51c2VkX3Jlc3VsdCBbLVdlcnJvcj11bnVzZWQtcmVzdWx0XQog
IDM2MSB8ICAgIGFzcHJpbnRmKCZuLT5jdHJsLT5hZGRyZXNzLCB0bXBfYWRkcmVzcyk7CiAgICAg
IHwgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgpjYzE6IGFsbCB3
YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlOiAqKiogW01ha2VmaWxlOjk2OiBu
dm1lLXRvcG9sb2d5Lm9dIEVycm9yIDEKClRoaXMgY2FuIGJlIGVhc2lseSByZSBwcm9kdWNlZCBv
biB0aGUgZ2NjIHZlcnNpb24gOi0KKFVidW50dSA5LjIuMS05dWJ1bnR1MikgOS4yLjEgMjAxOTEw
MDgKClNpZ25lZC1vZmYtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8Y2hhaXRhbnlhLmt1bGthcm5p
QHdkYy5jb20+Ci0tLQpIaSwKCkkndmUgbm90IHRlc3RlZCB0aGlzIHBhdGNoIG9uIHRoZSBsZWdh
Y3ktbnMgYXMgSSBkb24ndCBoYXZlIHRoZQpzZXR1cCwgYnV0IGl0IGlzIG5lZWRlZCB0byBjb21w
aWxlIHRoZSBjb2RlIGZvciBub3csIHdpbGwgYmUga2VlcGluZwphbiBleWUgZm9yIGFueSBidWdz
IHJlbGVhdGVkIHRvIHRoaXMuCgotQ2hhaXRhbnlhCi0tLQogbnZtZS10b3BvbG9neS5jIHwgNiAr
KysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvbnZtZS10b3BvbG9neS5jIGIvbnZtZS10b3BvbG9neS5jCmluZGV4IDU1YWQ4
YzEuLmU5MzhmMjMgMTAwNjQ0Ci0tLSBhL252bWUtdG9wb2xvZ3kuYworKysgYi9udm1lLXRvcG9s
b2d5LmMKQEAgLTM1Nyw4ICszNTcsMTAgQEAgc3RhdGljIGludCB2ZXJpZnlfbGVnYWN5X25zKHN0
cnVjdCBudm1lX25hbWVzcGFjZSAqbikKIAkJY2hhciB0bXBfYWRkcmVzc1s2NF0gPSAiIjsKIAkJ
bGVnYWN5X2dldF9wY2lfYmRmKHBhdGgsIHRtcF9hZGRyZXNzKTsKIAkJaWYgKHRtcF9hZGRyZXNz
WzBdKSB7Ci0JCQlhc3ByaW50Zigmbi0+Y3RybC0+dHJhbnNwb3J0LCAicGNpZSIpOwotCQkJYXNw
cmludGYoJm4tPmN0cmwtPmFkZHJlc3MsIHRtcF9hZGRyZXNzKTsKKwkJCWlmIChhc3ByaW50Zigm
bi0+Y3RybC0+dHJhbnNwb3J0LCAicGNpZSIpICE9IDEpCisJCQkJcmV0dXJuIC0xOworCQkJaWYg
KGFzcHJpbnRmKCZuLT5jdHJsLT5hZGRyZXNzLCAiJXMiLCB0bXBfYWRkcmVzcykgIT0gMSkKKwkJ
CQlyZXR1cm4gLTE7CiAJCX0KIAl9CiAKLS0gCjIuMjQuMAoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
