Return-Path: <SRS0=Iz8v=EI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C0EC00A89
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2020 13:22:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8F8206F9
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2020 13:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MnyGzhE+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="QP4W/54J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8F8206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+Xxqibw1Lc6yZnsb6NfC+La79qupsJrZoYClkNP6N/g=; b=MnyGzhE+JKsylcEUXgW4PoQXp7
	96LvkvXFlSI3I7vUlnjGnzmUGAkRWzg8vSHoevFbE8AWODEo6acqTqBaA4qdcCebAtW/FVlIgagpD
	foGdPg4j0yZuMokSEkKT0LLbiH7IMTidMK5STinp4o2/z0g5ZfPFvG9OA8XXSgI9qO6eG/HdYhAvL
	g6YVWnfDWJnqCQ510UsoB7+URAIj4ghCVtcjY/8hhLugO48hHg4NST5rPsUsuGLJ7be67oxOuGECW
	aIcWW7i3tzth2TxAQz3IoVK5QsyaGrfbaw6ttN/V+RrqNtV4hBbIbQCsrxmw6mjNLeS4KfQP54eEA
	qgvsw7Gg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kZZmw-0000QY-FM; Mon, 02 Nov 2020 13:22:22 +0000
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kZZmv-0000QD-0P
 for linux-nvme@lists.infradead.org; Mon, 02 Nov 2020 13:22:21 +0000
Received: by mail-ej1-x642.google.com with SMTP id o9so16789197ejg.1
 for <linux-nvme@lists.infradead.org>; Mon, 02 Nov 2020 05:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SZfYKuWyGtGDZXasrB6Z2RY6XZT3LCwmZmxJmGz2Pi0=;
 b=QP4W/54JLYBQ92owzx2ntg7wuLWGJIVQ2fGXic40efQdaUFhG8YgRxKHvtbZ/XFSEz
 NL2V2/dExjPd5XZ7hzEfTiCVNmB42Jj6kYRqOv59SLQQR6Gsku8+nJAqD7QVnWt8ejBQ
 n/q3vmyvXbcA7o+BTFIkzleUrNyO0kEl9VfOBVGbz12T93JdNXnvjXJXZ87JTWRBLeNA
 j49zjDQT+msZazVWArouH0Y6WPODhFTtptBhpvvC7ZQFWslSl2DnqEcTbduP+SXY7m/9
 Ve3y9Wmk+YJrRNn961ejqUT9NgyYAHUo3CgtXDDqOEVPyrD0OCake4GBN2u7645v62Ck
 seDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SZfYKuWyGtGDZXasrB6Z2RY6XZT3LCwmZmxJmGz2Pi0=;
 b=C8UN+U0+gwg5cdGMgJ/3/H9x/cGf8n2wL3zMb745ynzGYn4v5jqYUzrVaKyQN0Fv8P
 dRn0R6jETiNvBvEdyIrOqXHALnGETVttHWOnSzCZUCBBTJ/mWL9XsbJ9AUXS5adubh3B
 7niHWwMKm2E8+ChLIc8twbK+McdxbvSlxKKfY3Wq24Myi1NwsT5xIHA+U9tfE6QeUh2D
 GngE790EdUn3Ega6WH7cjEhAC0yB/GpeFY3jyFarBLDNO1NV3k7pXfEKBop0/41L9x1e
 3BkiQ9rJEW3EsQH6n1n+SVFHfV70rbaaZ6wwCsxsVuEl76ha0ZaESnf+XVYw4qF0XqG0
 4coQ==
X-Gm-Message-State: AOAM53044aWeWS2tPoWEkHgjI8bZzpqE2bdnG5lmE/BWysAW4vrU+bc5
 R+qolhHrbVzCrhVX/66JA7Al8N5ROfTLiWUynps=
X-Google-Smtp-Source: ABdhPJx0yppHNtt0XHA0SJNFeSI8HPFi3fKLHfYSgOdgSiPmBj9pUoCGMWJVYvFVA3130WLxrltL7A==
X-Received: by 2002:a17:906:a1d8:: with SMTP id
 bx24mr14886341ejb.161.1604323339082; 
 Mon, 02 Nov 2020 05:22:19 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.126.247.cgn.fibianet.dk.
 [5.186.126.247])
 by smtp.gmail.com with ESMTPSA id y12sm7294412ejj.95.2020.11.02.05.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 05:22:18 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?=
 <javier.gonz@samsung.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2] nvme: report capacity 0 for non supported ZNS SSDs
Date: Mon,  2 Nov 2020 14:22:14 +0100
Message-Id: <20201102132214.22164-1-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201102_082221_086931_4AB86870 
X-CRM114-Status: GOOD (  20.07  )
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

QWxsb3cgWk5TIFNTRHMgdG8gYmUgcHJlc2VudGVkIHRvIHRoZSBob3N0IGV2ZW4gd2hlbiB0aGV5
IGltcGxlbWVudApmZWF0dXJlcyB0aGF0IGFyZSBub3Qgc3VwcG9ydGVkIGJ5IHRoZSBrZXJuZWwg
em9uZWQgYmxvY2sgZGV2aWNlLgoKSW5zdGVhZCBvZiByZWplY3RpbmcgdGhlIFNTRCBhdCB0aGUg
TlZNZSBkcml2ZXIgbGV2ZWwsIGRlYWwgd2l0aCB0aGlzIGluCnRoZSBibG9jayBsYXllciBieSBz
ZXR0aW5nIGNhcGFjaXR5IHRvIDAsIGFzIHdlIGRvIHdpdGggb3RoZXIgdGhpbmdzCnN1Y2ggYXMg
dW5zdXBwb3J0ZWQgUEkgY29uZmlndXJhdGlvbnMuIFRoaXMgYWxsb3dzIHRvIHVzZSBzdGFuZGFy
ZAptYW5hZ2VtZW50IHRvb2xzIHN1Y2ggYXMgbnZtZS1jbGkgdG8gY2hvb3NlIGEgZGlmZmVyZW50
IGZvcm1hdCBvcgpmaXJtd2FyZSBzbG90IHRoYXQgaXMgY29tcGF0aWJsZSB3aXRoIHRoZSBMaW51
eCB6b25lZCBibG9jayBkZXZpY2UuCgpDaGFuZ2VzIHNpbmNlIFYxOgogICAtIEFwcGx5IGZlZWRi
YWNrIGZyb20gTmlrbGFzOgoJLSBVc2UgSVNfRU5BQkxFRCgpIGZvciBjaGVja2luZyBjb25maWcg
b3B0aW9uCgktIFVzZSBsb2NhbCB2YXJpYWJsZQoJLSBVc2UgZGlmZmVyZW50IHZhcmlhYmxlIG5h
bWVzCgpTaWduZWQtb2ZmLWJ5OiBKYXZpZXIgR29uesOhbGV6IDxqYXZpZXIuZ29uekBzYW1zdW5n
LmNvbT4KLS0tCiBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgfCAgMyArKysKIGRyaXZlcnMvbnZt
ZS9ob3N0L252bWUuaCB8ICAxICsKIGRyaXZlcnMvbnZtZS9ob3N0L3pucy5jICB8IDI2ICsrKysr
KysrKysrKysrLS0tLS0tLS0tLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyks
IDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBi
L2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwppbmRleCBjMTkwYzU2YmY3MDIuLjYzODk5N2I2ZjVj
ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCisrKyBiL2RyaXZlcnMvbnZt
ZS9ob3N0L2NvcmUuYwpAQCAtMjAyNiw2ICsyMDI2LDkgQEAgc3RhdGljIHZvaWQgbnZtZV91cGRh
dGVfZGlza19pbmZvKHN0cnVjdCBnZW5kaXNrICpkaXNrLAogCQkJY2FwYWNpdHkgPSAwOwogCX0K
IAorCWlmIChJU19FTkFCTEVEKENPTkZJR19CTEtfREVWX1pPTkVEKSAmJiAhbnMtPnpvbmVkX25z
X3N1cHApCisJCWNhcGFjaXR5ID0gMDsKKwogCXNldF9jYXBhY2l0eV9yZXZhbGlkYXRlX2FuZF9u
b3RpZnkoZGlzaywgY2FwYWNpdHksIGZhbHNlKTsKIAogCW52bWVfY29uZmlnX2Rpc2NhcmQoZGlz
aywgbnMpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oIGIvZHJpdmVycy9u
dm1lL2hvc3QvbnZtZS5oCmluZGV4IDg3NzM3ZmEzMjM2MC4uZmY0ZmU2NDVhYjliIDEwMDY0NAot
LS0gYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgKKysrIGIvZHJpdmVycy9udm1lL2hvc3QvbnZt
ZS5oCkBAIC00NDMsNiArNDQzLDcgQEAgc3RydWN0IG52bWVfbnMgewogCXU4IHBpX3R5cGU7CiAj
aWZkZWYgQ09ORklHX0JMS19ERVZfWk9ORUQKIAl1NjQgenN6ZTsKKwlib29sIHpvbmVkX25zX3N1
cHA7CiAjZW5kaWYKIAl1bnNpZ25lZCBsb25nIGZlYXR1cmVzOwogCXVuc2lnbmVkIGxvbmcgZmxh
Z3M7CmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC96bnMuYyBiL2RyaXZlcnMvbnZtZS9o
b3N0L3pucy5jCmluZGV4IDU3Y2ZkNzg3MzFmYi4uMWFlMDM5ZjljMjBjIDEwMDY0NAotLS0gYS9k
cml2ZXJzL252bWUvaG9zdC96bnMuYworKysgYi9kcml2ZXJzL252bWUvaG9zdC96bnMuYwpAQCAt
NDIsMjIgKzQyLDI1IEBAIGludCBudm1lX3VwZGF0ZV96b25lX2luZm8oc3RydWN0IGdlbmRpc2sg
KmRpc2ssIHN0cnVjdCBudm1lX25zICpucywKIAlzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSA9IGRp
c2stPnF1ZXVlOwogCXN0cnVjdCBudm1lX2NvbW1hbmQgYyA9IHsgfTsKIAlzdHJ1Y3QgbnZtZV9p
ZF9uc196bnMgKmlkOworCWJvb2wgem9uZWRfbnNfc3VwcCA9IHRydWU7CiAJaW50IHN0YXR1czsK
IAogCS8qIERyaXZlciByZXF1aXJlcyB6b25lIGFwcGVuZCBzdXBwb3J0ICovCiAJaWYgKCEobGUz
Ml90b19jcHUobG9nLT5pb2NzW252bWVfY21kX3pvbmVfYXBwZW5kXSkgJgogCQkJTlZNRV9DTURf
RUZGRUNUU19DU1VQUCkpIHsKKwkJem9uZWRfbnNfc3VwcCA9IGZhbHNlOwogCQlkZXZfd2Fybihu
cy0+Y3RybC0+ZGV2aWNlLAogCQkJImFwcGVuZCBub3Qgc3VwcG9ydGVkIGZvciB6b25lZCBuYW1l
c3BhY2U6JWRcbiIsCiAJCQlucy0+aGVhZC0+bnNfaWQpOwotCQlyZXR1cm4gLUVJTlZBTDsKLQl9
Ci0KLQkvKiBMYXppbHkgcXVlcnkgY29udHJvbGxlciBhcHBlbmQgbGltaXQgZm9yIHRoZSBmaXJz
dCB6b25lZCBuYW1lc3BhY2UgKi8KLQlpZiAoIW5zLT5jdHJsLT5tYXhfem9uZV9hcHBlbmQpIHsK
LQkJc3RhdHVzID0gbnZtZV9zZXRfbWF4X2FwcGVuZChucy0+Y3RybCk7Ci0JCWlmIChzdGF0dXMp
Ci0JCQlyZXR1cm4gc3RhdHVzOworCX0gZWxzZSB7CisJCS8qIExhemlseSBxdWVyeSBjb250cm9s
bGVyIGFwcGVuZCBsaW1pdCBmb3IgdGhlIGZpcnN0CisJCSAqIHpvbmVkIG5hbWVzcGFjZQorCQkg
Ki8KKwkJaWYgKCFucy0+Y3RybC0+bWF4X3pvbmVfYXBwZW5kKSB7CisJCQlzdGF0dXMgPSBudm1l
X3NldF9tYXhfYXBwZW5kKG5zLT5jdHJsKTsKKwkJCWlmIChzdGF0dXMpCisJCQkJcmV0dXJuIHN0
YXR1czsKKwkJfQogCX0KIAogCWlkID0ga3phbGxvYyhzaXplb2YoKmlkKSwgR0ZQX0tFUk5FTCk7
CkBAIC03OCwyMyArODEsMjIgQEAgaW50IG52bWVfdXBkYXRlX3pvbmVfaW5mbyhzdHJ1Y3QgZ2Vu
ZGlzayAqZGlzaywgc3RydWN0IG52bWVfbnMgKm5zLAogCSAqIG9wZXJhdGlvbiBjaGFyYWN0ZXJp
c3RpY3MuCiAJICovCiAJaWYgKGlkLT56b2MpIHsKKwkJem9uZWRfbnNfc3VwcCA9IGZhbHNlOwog
CQlkZXZfd2Fybihucy0+Y3RybC0+ZGV2aWNlLAogCQkJInpvbmUgb3BlcmF0aW9uczoleCBub3Qg
c3VwcG9ydGVkIGZvciBuYW1lc3BhY2U6JXVcbiIsCiAJCQlsZTE2X3RvX2NwdShpZC0+em9jKSwg
bnMtPmhlYWQtPm5zX2lkKTsKLQkJc3RhdHVzID0gLUVJTlZBTDsKLQkJZ290byBmcmVlX2RhdGE7
CiAJfQogCiAJbnMtPnpzemUgPSBudm1lX2xiYV90b19zZWN0KG5zLCBsZTY0X3RvX2NwdShpZC0+
bGJhZmVbbGJhZl0uenN6ZSkpOwogCWlmICghaXNfcG93ZXJfb2ZfMihucy0+enN6ZSkpIHsKKwkJ
em9uZWRfbnNfc3VwcCA9IGZhbHNlOwogCQlkZXZfd2Fybihucy0+Y3RybC0+ZGV2aWNlLAogCQkJ
ImludmFsaWQgem9uZSBzaXplOiVsbHUgZm9yIG5hbWVzcGFjZToldVxuIiwKIAkJCW5zLT56c3pl
LCBucy0+aGVhZC0+bnNfaWQpOwotCQlzdGF0dXMgPSAtRUlOVkFMOwotCQlnb3RvIGZyZWVfZGF0
YTsKIAl9CiAKIAlxLT5saW1pdHMuem9uZWQgPSBCTEtfWk9ORURfSE07CisJbnMtPnpvbmVkX25z
X3N1cHAgPSB6b25lZF9uc19zdXBwOwogCWJsa19xdWV1ZV9mbGFnX3NldChRVUVVRV9GTEFHX1pP
TkVfUkVTRVRBTEwsIHEpOwogCWJsa19xdWV1ZV9tYXhfb3Blbl96b25lcyhxLCBsZTMyX3RvX2Nw
dShpZC0+bW9yKSArIDEpOwogCWJsa19xdWV1ZV9tYXhfYWN0aXZlX3pvbmVzKHEsIGxlMzJfdG9f
Y3B1KGlkLT5tYXIpICsgMSk7Ci0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1l
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1udm1lCg==
