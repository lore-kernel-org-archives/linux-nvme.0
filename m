Return-Path: <SRS0=YOZe=ER=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9A4C388F9
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 20:10:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 219AD207F7
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 20:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hUtk3GlJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="iTy2MIwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219AD207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nnFxx3lkdCNkFVaPRZcUrvGAwSZNic6RLb+Bbis7gx8=; b=hUtk3GlJYTpHj0SWG9QnNyQaE2
	aMwVkqoFmyhbG6gxBi/h6BRMRAiBhyy/tLrceDausg4DQxUppd90qwDhilpC1c+5eUOXNh3wvPKNr
	06lEgSdcvBgXJAt7w/Mf4zbPUPZynfvRa1oFkLO1pLP5LTKXzsvtv17/NOznasMTHBT8YhB2GHwNx
	7/ysj5cG1mYTz72dwJCfM4Cko8Jan/Sul1LyfiF8JpEVcRqlFEXAYfhIQxk5cdN7ZDY7vj8vAnBjy
	LE6lnngEbTXuizGr3QWZE1wwAV2gznMpz0H0fI+G2YVEzZv0I0dVBlH7eAwnjETUNUEGWhvZvqiM/
	h1x21epg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcwRn-00032J-Va; Wed, 11 Nov 2020 20:10:28 +0000
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcwRl-00031p-TK
 for linux-nvme@lists.infradead.org; Wed, 11 Nov 2020 20:10:26 +0000
Received: by mail-ej1-x643.google.com with SMTP id oq3so4454484ejb.7
 for <linux-nvme@lists.infradead.org>; Wed, 11 Nov 2020 12:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0eKjEubKup8XTHuNBAl9N3Wyqo/WJjUQR451Q6kaN9Y=;
 b=iTy2MIwpO6n935ULTixRdY8Hp8Hf+p8RT5ZenDPsoEzX20hhRtaY29SnS3v9SxwHSK
 iiRBKe9HQd7s/+m0zWw28Ohhec32fbcQNBH1p4XZ+9SvzBRCw+wwtzK07FqI2AO+g+cm
 qjzIz3lpcaHCvtMGIwJYn2+PgYlIWfCTIElfpLRKgyzFolkWQ7mCuRgahY742r52iHZ4
 Ii91M5ikx/dcYSYQ4pRk88ZTfUw21pMjrKIMFqLAwLZyTF+EWhnEGRVl9haMYkinmXW/
 LHWOTpTwsTC6M5kUH4OiwCfAV0QfVUH/Tm04QqeMSgmqH8B+u4IGOgpiDRRUdjr63nQA
 tHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0eKjEubKup8XTHuNBAl9N3Wyqo/WJjUQR451Q6kaN9Y=;
 b=VI2GrDDHB+TJvsBSWHZerlVzAAyChplbDbKAztJYS/OmT62Bs+8fyEDOVvw2+936jH
 1Dgi2D1U4LuSCv40rD/AogI/olHsnuwwE0wPusK+UO830JI9wGzh5scjKY98Im0I33vY
 wpDTp78W7XklUs3ip4z2HwZ4DDwK8cvLkCDcYNS0XHCdAvbTCVcaJBjeBg61oAl3gUmO
 6Pl/QB67RYd90P1coRb3/evZ57VKjOIqF93Gj4n7guAlGjajosWaZo2a1LTgP+a+CV6m
 dCGzize6SvLkn51Q7F0/2znOM0RCnHeCcVIBZosFBuojkusU6Vn6dF7TKzblkld9ywfd
 pnwg==
X-Gm-Message-State: AOAM531pKnsy46xSeg07pM7WPxYZ92fVdv5iVZWRosO14vcdHpcjSged
 PXFO89LA8jYUlbXYzgc52e8GCtCBreOXM6593tk=
X-Google-Smtp-Source: ABdhPJwAX5HGR9uDut/VpxCMLptOFx6697XGl+AHnbWpgMtqhGJWy3z2+hKvQMV6TCRBfDbIky7aoA==
X-Received: by 2002:a17:906:d1c3:: with SMTP id
 bs3mr25631279ejb.246.1605125423958; 
 Wed, 11 Nov 2020 12:10:23 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk.
 [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id j9sm1360421edv.92.2020.11.11.12.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 12:10:22 -0800 (PST)
From: javier@javigon.com
X-Google-Original-From: javier@samsung.com
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: remove unnecessary return values
Date: Wed, 11 Nov 2020 21:10:18 +0100
Message-Id: <20201111201018.30764-1-javier@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201111_151026_128854_F6D5710E 
X-CRM114-Status: GOOD (  12.44  )
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

RnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+CgpDbGVhbnVw
IHVubmVjZXNzYXJ5IHJldCB2YWx1ZXMgdGhhdCBhcmUgbm90IGNoZWNrZWQgb3IgdXNlZCBpbgpu
dm1lX2FsbG9jX25zKCkKClNpZ25lZC1vZmYtYnk6IEphdmllciBHb256w6FsZXogPGphdmllci5n
b256QHNhbXN1bmcuY29tPgotLS0KIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8IDggKysrLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29y
ZS5jCmluZGV4IGZmZjkwMjAwNDk3Yy4uYzllYTMyYzg3ZTUyIDEwMDY0NAotLS0gYS9kcml2ZXJz
L252bWUvaG9zdC9jb3JlLmMKKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCkBAIC0zODMw
LDcgKzM4MzAsNyBAQCBzdGF0aWMgdm9pZCBudm1lX2FsbG9jX25zKHN0cnVjdCBudm1lX2N0cmwg
KmN0cmwsIHVuc2lnbmVkIG5zaWQsCiAJc3RydWN0IGdlbmRpc2sgKmRpc2s7CiAJc3RydWN0IG52
bWVfaWRfbnMgKmlkOwogCWNoYXIgZGlza19uYW1lW0RJU0tfTkFNRV9MRU5dOwotCWludCBub2Rl
ID0gY3RybC0+bnVtYV9ub2RlLCBmbGFncyA9IEdFTkhEX0ZMX0VYVF9ERVZULCByZXQ7CisJaW50
IG5vZGUgPSBjdHJsLT5udW1hX25vZGUsIGZsYWdzID0gR0VOSERfRkxfRVhUX0RFVlQ7CiAKIAlp
ZiAobnZtZV9pZGVudGlmeV9ucyhjdHJsLCBuc2lkLCBpZHMsICZpZCkpCiAJCXJldHVybjsKQEAg
LTM4NTQsOCArMzg1NCw3IEBAIHN0YXRpYyB2b2lkIG52bWVfYWxsb2NfbnMoc3RydWN0IG52bWVf
Y3RybCAqY3RybCwgdW5zaWduZWQgbnNpZCwKIAlucy0+Y3RybCA9IGN0cmw7CiAJa3JlZl9pbml0
KCZucy0+a3JlZik7CiAKLQlyZXQgPSBudm1lX2luaXRfbnNfaGVhZChucywgbnNpZCwgaWRzLCBp
ZC0+bm1pYyAmIE5WTUVfTlNfTk1JQ19TSEFSRUQpOwotCWlmIChyZXQpCisJaWYgKG52bWVfaW5p
dF9uc19oZWFkKG5zLCBuc2lkLCBpZHMsIGlkLT5ubWljICYgTlZNRV9OU19OTUlDX1NIQVJFRCkp
CiAJCWdvdG8gb3V0X2ZyZWVfcXVldWU7CiAJbnZtZV9zZXRfZGlza19uYW1lKGRpc2tfbmFtZSwg
bnMsIGN0cmwsICZmbGFncyk7CiAKQEAgLTM4NzQsOCArMzg3Myw3IEBAIHN0YXRpYyB2b2lkIG52
bWVfYWxsb2NfbnMoc3RydWN0IG52bWVfY3RybCAqY3RybCwgdW5zaWduZWQgbnNpZCwKIAkJZ290
byBvdXRfcHV0X2Rpc2s7CiAKIAlpZiAoKGN0cmwtPnF1aXJrcyAmIE5WTUVfUVVJUktfTElHSFRO
Vk0pICYmIGlkLT52c1swXSA9PSAweDEpIHsKLQkJcmV0ID0gbnZtZV9udm1fcmVnaXN0ZXIobnMs
IGRpc2tfbmFtZSwgbm9kZSk7Ci0JCWlmIChyZXQpIHsKKwkJaWYgKG52bWVfbnZtX3JlZ2lzdGVy
KG5zLCBkaXNrX25hbWUsIG5vZGUpKSB7CiAJCQlkZXZfd2FybihjdHJsLT5kZXZpY2UsICJMaWdo
dE5WTSBpbml0IGZhaWx1cmVcbiIpOwogCQkJZ290byBvdXRfcHV0X2Rpc2s7CiAJCX0KLS0gCjIu
MTcuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
