Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBF6C4741F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 09:39:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F27E920780
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 09:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ih+sTrQk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="ilIIetMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27E920780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=72gRyqL42hIaXKXTMm2ZWKDsL76++AWB8WxDOG3c9J4=; b=ih+sTrQkGnGBpFR/FphU96OJEU
	ewIxfojZ/9g3jdS1JJqoCts5qpipV8jgU5zIiPtZVYZsnKAYi9en4hu2Cxz1p7Jk2uaBcw4TMXTrE
	sTICxxcRMQABdgQ1l1nX12ns6EinLV81hMOLybEei1WTII7TWLdDQ5KbrQWOAy7DiM2DYQFY1iM/I
	GDG62ad4AvTmL9iBcQoINLdAoI28zcWInbQayVY9LNHCSv4RqoF9WglmZJJTiu6hTQV5IPH/XQISn
	epKfrz8QMK3oSp7MirNwyHABeAjWZb3MQy9Lvu0trZCw3ti/jYokSwzGH1HvkhZASB0mUBuqXYPP9
	tyrWOCNw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcQ7z-0005ZC-67; Tue, 10 Nov 2020 09:39:51 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcQ7w-0005YL-IV
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 09:39:49 +0000
Received: by mail-ed1-x542.google.com with SMTP id v22so1597477edt.9
 for <linux-nvme@lists.infradead.org>; Tue, 10 Nov 2020 01:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NGC8UHUSWpvH5SIBX91yvBkFsjsQSnbCUrNFDTpaJfY=;
 b=ilIIetMJVASZ2CjUBlpYVv5epCMIE0scmhVtWr/IhhibOareIYg/jqO+zq96nSRazJ
 BSSkgqBVSsVzRoqOHH9sM1He9JWlT3lJipAcc/50OkE6S5PTfw+FdWBp4LVWLma7XL4g
 7k/PPiAd1xCaDxVNqQMpN5xibQeYKUeHg0zV7ZNo87v6dw5TEqzGj7Af+IIYcET1M/JR
 8YgCyslUySIdjM/hdu4bxtKbjDrI4hbH8MN5pJ20fGaEYERO2EOsmSvdogVY2FsRqmkU
 2Xq3JZffKveWk5hpU7pPrt5F26sUiztIyEd7dn+vDvvJcZQkRFNCq36XrHrCJ/5N/SdZ
 iNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NGC8UHUSWpvH5SIBX91yvBkFsjsQSnbCUrNFDTpaJfY=;
 b=VVjojIumFonQSHVXP7YvQhHz6DVzDrQ5U8JsntKUqt4IZRK8GgCr5RxVuAjl+D55ut
 gQQjO8gIC2QzcwUycr2D94JOL2/TNg+KZe7hL2lhq4yjd16EXpGplSVPeqxOaWdPuxBy
 ZbSsYoVDzYjZzCG5g9UpjdbkLqYCbqmFo8pqfRe49wW4j2Q38OXgAkFNVLDuetKLoIVK
 fVkd7CGJ7CCux0FD2DcJTP/RM3X1BUP+R5n40UAzTu7E5UaL6kuEiOyNRrsqfNTvRB+y
 zjfKwkCSt5hAnU1nGqVjvq6tjnzPq/i93AR8g/xXpqC8aurCPjaEe8UjumoUbeyfCW7U
 Of+g==
X-Gm-Message-State: AOAM531J1bDniH/tQeXiKFUjB3Gsp4ArRBUvoirSe7ZbP8GEZNSIV4ei
 vQOOTW/zFbFPorXjZlVVrMCVP4RS8GLE5ffC
X-Google-Smtp-Source: ABdhPJx9jMhSI9/pAO8n4wsT1z0Fz92RcU9WurS0rtO41pg5rI6aMIH85K1ZOnWe7/rAUVgxRBZZ7w==
X-Received: by 2002:a50:cf45:: with SMTP id d5mr19709676edk.225.1605001183960; 
 Tue, 10 Nov 2020 01:39:43 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk.
 [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id s25sm10065845ejc.29.2020.11.10.01.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 01:39:43 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?=
 <javier.gonz@samsung.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2] nvme: enable ro namespace for ZNS without append
Date: Tue, 10 Nov 2020 10:39:38 +0100
Message-Id: <20201110093938.25386-1-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201110_043948_652276_49E25256 
X-CRM114-Status: GOOD (  18.72  )
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

QWxsb3cgWk5TIE5WTWUgU1NEcyB0byBwcmVzZW50IGEgcmVhZC1vbmx5IG5hbWVzcGFjZSB3aGVu
IGFwcGVuZCBpcyBub3QKc3VwcG9ydGVkLCBpbnN0ZWFkIG9mIHJlamVjdGluZyB0aGUgbmFtZXNw
YWNlIGRpcmVjdGx5LgoKVGhpcyBhbGxvd3MgKGkpIHRoZSBuYW1lc3BhY2UgdG8gYmUgdXNlZCBp
biByZWFkLW9ubHkgbW9kZSwgd2hpY2ggaXMgbm90CmEgcHJvYmxlbSBhcyB0aGUgYXBwZW5kIGNv
bW1hbmQgb25seSBhZmZlY3RzIHRoZSB3cml0ZSBwYXRoLCBhbmQgKGlpKSB0bwp1c2Ugc3RhbmRh
cmQgbWFuYWdlbWVudCB0b29scyBzdWNoIGFzIG52bWUtY2xpIHRvIGNob29zZSBhIGRpZmZlcmVu
dApmb3JtYXQgb3IgZmlybXdhcmUgc2xvdCB0aGF0IGlzIGNvbXBhdGlibGUgd2l0aCB0aGUgTGlu
dXggem9uZWQgYmxvY2sKZGV2aWNlLgoKVGhpcyBwYXRjaCBpbmNsdWRlcyBjb21tZW50cyBmcm9t
IENocmlzdG9waCwgTmlrbGFzIGFuZCBLZWl0aCB0aGF0CmFwcGxpZWQgdG8gYSBkaWZmZXJlbnQg
YXBwcm9hY2ggc2V0dGluZyBjYXBhY2l0eSB0byAwCiAgaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQv
bGlzdHMvbGludXgtYmxvY2svbXNnNjA3NDcuaHRtbAoKVGhlIHJlbWluZGVyIG9mIHRoZSBvcmln
aW5hbCBwYXRjaCB3aWxsIGJlIHN1Ym1pdHRlZCBzZXBhcmF0ZWx5LgoKQ2hhbmdlcyBzaW5jZSBW
MToKICAtIENoYW5nZSBsb2dpYyB0byB1c2UgTlZNRV9OU19BVFRSX1JPIChmcm9tIENocmlzdG9w
aCkKICAtIFNldCBtYXhfem9uZV9hcHBlbmQgZWdlbiBpbiBSTy4gVGhpcyBhbGxvd3MgdGhlIGRl
dmljZSB0byBiZSBwcm9wZXJseQogICAgcmV2YWxpZGF0ZWQgYW5kIGVuYWJsZXMgdXNlci1zcGFj
ZSB0b29scyBzdWNoIGFzIGJsa3pvbmUgdG8gYmUgdXNlZCB3aGVuCiAgICBpbnRlcmFjdGluZyB3
aXRoIHRoaXMgem9uZWQgZGV2aWNlLgoKU2lnbmVkLW9mZi1ieTogSmF2aWVyIEdvbnrDoWxleiA8
amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+Ci0tLQogZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIHwg
MyArKy0KIGRyaXZlcnMvbnZtZS9ob3N0L252bWUuaCB8IDEgKwogZHJpdmVycy9udm1lL2hvc3Qv
em5zLmMgIHwgNCArKy0tCiAzIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJz
L252bWUvaG9zdC9jb3JlLmMKaW5kZXggNDBjYTcxYjI5YmI5Li40ZmNhZWMwYjMzMGIgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYworKysgYi9kcml2ZXJzL252bWUvaG9zdC9j
b3JlLmMKQEAgLTIwNTgsNyArMjA1OCw4IEBAIHN0YXRpYyB2b2lkIG52bWVfdXBkYXRlX2Rpc2tf
aW5mbyhzdHJ1Y3QgZ2VuZGlzayAqZGlzaywKIAludm1lX2NvbmZpZ19kaXNjYXJkKGRpc2ssIG5z
KTsKIAludm1lX2NvbmZpZ193cml0ZV96ZXJvZXMoZGlzaywgbnMpOwogCi0JaWYgKGlkLT5uc2F0
dHIgJiBOVk1FX05TX0FUVFJfUk8pCisJaWYgKGlkLT5uc2F0dHIgJiBOVk1FX05TX0FUVFJfUk8g
fHwKKwkJCXRlc3RfYml0KE5WTUVfTlNfRk9SQ0VfUk8sICZucy0+ZmxhZ3MpKQogCQlzZXRfZGlz
a19ybyhkaXNrLCB0cnVlKTsKIAllbHNlCiAJCXNldF9kaXNrX3JvKGRpc2ssIGZhbHNlKTsKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaCBiL2RyaXZlcnMvbnZtZS9ob3N0L252
bWUuaAppbmRleCBiYzMzMGJmMGQzYmQuLjNhOTg1ZTk4Y2EyNyAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9udm1lL2hvc3QvbnZtZS5oCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaApAQCAtNDQ4
LDYgKzQ0OCw3IEBAIHN0cnVjdCBudm1lX25zIHsKICNkZWZpbmUgTlZNRV9OU19SRU1PVklORwkw
CiAjZGVmaW5lIE5WTUVfTlNfREVBRCAgICAgCTEKICNkZWZpbmUgTlZNRV9OU19BTkFfUEVORElO
RwkyCisjZGVmaW5lIE5WTUVfTlNfRk9SQ0VfUk8JMwogCiAJc3RydWN0IG52bWVfZmF1bHRfaW5q
ZWN0IGZhdWx0X2luamVjdDsKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3Qvem5zLmMg
Yi9kcml2ZXJzL252bWUvaG9zdC96bnMuYwppbmRleCA2N2U4N2U5ZjMwNmYuLjhmMzYzMmM0ZGIw
NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL2hvc3Qvem5zLmMKKysrIGIvZHJpdmVycy9udm1l
L2hvc3Qvem5zLmMKQEAgLTU3LDEwICs1NywxMCBAQCBpbnQgbnZtZV91cGRhdGVfem9uZV9pbmZv
KHN0cnVjdCBudm1lX25zICpucywgdW5zaWduZWQgbGJhZikKIAkvKiBEcml2ZXIgcmVxdWlyZXMg
em9uZSBhcHBlbmQgc3VwcG9ydCAqLwogCWlmICghKGxlMzJfdG9fY3B1KGxvZy0+aW9jc1tudm1l
X2NtZF96b25lX2FwcGVuZF0pICYKIAkJCU5WTUVfQ01EX0VGRkVDVFNfQ1NVUFApKSB7CisJCXNl
dF9iaXQoTlZNRV9OU19GT1JDRV9STywgJm5zLT5mbGFncyk7CiAJCWRldl93YXJuKG5zLT5jdHJs
LT5kZXZpY2UsCi0JCQkiYXBwZW5kIG5vdCBzdXBwb3J0ZWQgZm9yIHpvbmVkIG5hbWVzcGFjZTol
ZFxuIiwKKwkJCSJhcHBlbmQgbm90IHN1cHBvcnRlZCBmb3Igem9uZWQgbmFtZXNwYWNlOiVkLiBG
b3JjaW5nIHRvIHJlYWQtb25seSBtb2RlXG4iLAogCQkJbnMtPmhlYWQtPm5zX2lkKTsKLQkJcmV0
dXJuIC1FSU5WQUw7CiAJfQogCiAJLyogTGF6aWx5IHF1ZXJ5IGNvbnRyb2xsZXIgYXBwZW5kIGxp
bWl0IGZvciB0aGUgZmlyc3Qgem9uZWQgbmFtZXNwYWNlICovCi0tIAoyLjE3LjEKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
