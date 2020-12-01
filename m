Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F58C64E7B
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 12:02:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4364C20770
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 12:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KaZAecXG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="jtYjvh+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4364C20770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NJxPdDKkk1o8ZFdCgAmSrvi0N7Fldbckf0e0yIXFhIE=; b=KaZAecXG6dsulzM39Iyx8jHBpw
	VXwsNvu07AdpqjlLT52dnAAt8UMjspQTi71qG7JYrjwMpb52i8ecGc5ycGRFQhKClYdDo26BUxLG3
	3GUWYq4xGZqEOTQYF7mhVAPNmSHcMrmoVQzO0l2PkubcKSciqjkfublg9q0p5StLerum1bXe6fCD5
	Ofjnn/pTWCxDcxoKab13Pig4HvSezQvHQs+Xq/GSeBrIXYniLJAJxzpKTvazt7uLGROoLGaFPKtLY
	JpRMT2VbJfHZL+kUEW5gEFG7xFNcpG+3bVqLPj6jwqdNdJ6jPrrhZYgPHHDZS2S53Z8H2puIo3vp4
	yxleRSdw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kk4Mf-0005fu-LT; Tue, 01 Dec 2020 12:02:37 +0000
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kk4Mb-0005f1-0n
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 12:02:35 +0000
Received: by mail-ej1-x644.google.com with SMTP id g20so2980542ejb.1
 for <linux-nvme@lists.infradead.org>; Tue, 01 Dec 2020 04:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EbprAHFEFknQH4Iq10/TiEWO6fTer6yZcPxsleBmY2s=;
 b=jtYjvh+X/Ag+OJbXIIsb6JUhMJ2y1Cla7SkJSpuj4bffaZo0bKNFbA7lJUvZzT6Z/E
 8VK94GfSJb91fW+McTCWvZJvP5slAEzC+KGVfal+yuj5DD1XPlVEEaF2cCKCq1o/rc8N
 51hVaXK/ZzwTSyEeLZhua+XKI+BadxyMhyITSAWmyzo+LYIbsEjVime/uQNphZjbvuCL
 rguNAxWn4R94H4Xa1iI5zivWGgDUh4bzDtwHEFDY7xDxqpyFCXLSqn7ROVBSGmXuJscL
 tkX1y9hep9wnx4fTCT6vQJchIgHMGq8iAN7FwCbwpk+xzybnXeZBlHAMIGCSXjvYNS0+
 sGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EbprAHFEFknQH4Iq10/TiEWO6fTer6yZcPxsleBmY2s=;
 b=MZ2eByIYNCgwyG9GHftuOPA0T/LKQ07Qle3CkdnyyWyFstDWGtvqmcLoOnoxDz/Z9X
 HaCITRfnMLwnuRY/ti5Zc0Y4AQQkgPO9hR7Hg0Yj3bUpOC3oP1l2nbHKfWjcm/DrzwT4
 bNYpovoKsW/WD3vwJ3kyZjygERD7hlVZZL9ThhNyA9KynnHuQU89Y+5byh+Ddv+BV0D5
 VRETJtuUSH90VgFfxAeWKwQ+PG4d4SVPnN/2oowY9k2D9kh0dRrXJ/D46XQjw+cDltPg
 Jw70VRCBcKQtVK+gkx4TKHyEP4hkk3Cywb5EJTgLteebSSB0XYKCDYAquhEWCmq4MPZb
 X2Cg==
X-Gm-Message-State: AOAM533h2+Df31wPrtG1CGv2Li05OWuSrtPuA/PhuflydHRJ3krMEJ5b
 SIwUvN31rKmtd7lSh+gMM+VGSS+0zK+b7zV18mM=
X-Google-Smtp-Source: ABdhPJwI4S8ymod1OhWiHTBf1ZYrl9NH1LNDNe/YmIOe+SEfOAizYwtAjLv9uOPn7ZjSYGGqcimHVw==
X-Received: by 2002:a17:907:d01:: with SMTP id
 gn1mr2666119ejc.357.1606824149084; 
 Tue, 01 Dec 2020 04:02:29 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk.
 [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id u1sm709040edf.65.2020.12.01.04.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 04:02:27 -0800 (PST)
From: javier@javigon.com
X-Google-Original-From: javier.gonz@samsung.com
To: linux-nvme@lists.infradead.org
Subject: [V5] nvme: enable ro namespace for ZNS without append
Date: Tue,  1 Dec 2020 13:02:21 +0100
Message-Id: <20201201120221.29279-1-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_070233_241119_8AC251F2 
X-CRM114-Status: GOOD (  21.06  )
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
dGNoIHdpbGwgYmUgc3VibWl0dGVkIHNlcGFyYXRlbHkuCgpDaGFuZ2VzIHNpbmNlIFY0OgogIC0g
UmV2ZXJ0IHJlLXJlYWRpbmcgZWZmZWN0cyB0byBwYWdlLiBXYWl0IGZvciBwYXRjaGVzIGZyb20g
Q2hyaXN0b3BoCiAgICBvbiBSTyBmbGFnIHJlZmFjdG9yaW5nIHRoYXQgYWxsb3cgdG8gY2xlYXIg
dGhlIGZsYWdzLgoKQ2hhbmdlcyBzaW5jZSBWMzoKICAtIEZvcmNlIHJlLXJlYWRpbmcgZWZmZWN0
cyBsb2cgcGFnZSAoZnJvbSBLZWl0aCkKICAtIFBlbmRpbmcgcHJvcGVyIHJlZnJlc2ggb2YgUk8g
ZmxhZyAtIGRlcGVuZGVuY3kgb24gcGF0Y2ggZnJvbQogICAgQ2hyaXN0b3BoCgpDaGFuZ2VzIHNp
bmNlIFYyOgogIC0gRml4IHNtYWxsIGNvbmZsaWN0IHdpdGggYSBxdWV1ZWQgcGF0Y2ggZnJvbSBT
YWdpIChmcm9tIENocmlzdG9waCkKICAtIEZpeCBpbmRlbnRhdGlvbiAoZnJvbSBOaWtsYXMpCiAg
LSBSZWZyZXNoIGVmZmVjdHMgbG9nIHBhZ2UgdG8gYWNjb3VudCBmb3IgRlcgY2hhbmdlcyAoZnJv
bSBLZWl0aCkKCkNoYW5nZXMgc2luY2UgVjE6CiAgLSBDaGFuZ2UgbG9naWMgdG8gdXNlIE5WTUVf
TlNfQVRUUl9STyAoZnJvbSBDaHJpc3RvcGgpCiAgLSBTZXQgbWF4X3pvbmVfYXBwZW5kIGVnZW4g
aW4gUk8uIFRoaXMgYWxsb3dzIHRoZSBkZXZpY2UgdG8gYmUKICAgIHByb3Blcmx5IHJldmFsaWRh
dGVkIGFuZCBlbmFibGVzIHVzZXItc3BhY2UgdG9vbHMgc3VjaCBhcyBibGt6b25lIHRvCiAgICBi
ZSB1c2VkIHdoZW4gaW50ZXJhY3Rpbmcgd2l0aCB0aGlzIHpvbmVkIGRldmljZS4KClNpZ25lZC1v
ZmYtYnk6IEphdmllciBHb256w6FsZXogPGphdmllci5nb256QHNhbXN1bmcuY29tPgotLS0KIGRy
aXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8ICAyICstCiBkcml2ZXJzL252bWUvaG9zdC9udm1lLmgg
fCAgMSArCiBkcml2ZXJzL252bWUvaG9zdC96bnMuYyAgfCAxNCArKysrKysrKystLS0tLQogMyBm
aWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwpp
bmRleCBmNDJlZDI2NmJkN2YuLjQ5YmEyMWU4OTQ2NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1l
L2hvc3QvY29yZS5jCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwpAQCAtMjExMyw3ICsy
MTEzLDcgQEAgc3RhdGljIHZvaWQgbnZtZV91cGRhdGVfZGlza19pbmZvKHN0cnVjdCBnZW5kaXNr
ICpkaXNrLAogCW52bWVfY29uZmlnX2Rpc2NhcmQoZGlzaywgbnMpOwogCW52bWVfY29uZmlnX3dy
aXRlX3plcm9lcyhkaXNrLCBucyk7CiAKLQlpZiAoaWQtPm5zYXR0ciAmIE5WTUVfTlNfQVRUUl9S
TykKKwlpZiAoaWQtPm5zYXR0ciAmIE5WTUVfTlNfQVRUUl9STyB8fCB0ZXN0X2JpdChOVk1FX05T
X0ZPUkNFX1JPLCAmbnMtPmZsYWdzKSkKIAkJc2V0X2Rpc2tfcm8oZGlzaywgdHJ1ZSk7CiB9CiAK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaCBiL2RyaXZlcnMvbnZtZS9ob3N0
L252bWUuaAppbmRleCBhZTAxN2Y3Mjc3OTguLmJmY2VkZmE0YjA1NyAxMDA2NDQKLS0tIGEvZHJp
dmVycy9udm1lL2hvc3QvbnZtZS5oCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaApAQCAt
NDUyLDYgKzQ1Miw3IEBAIHN0cnVjdCBudm1lX25zIHsKICNkZWZpbmUgTlZNRV9OU19SRU1PVklO
RwkwCiAjZGVmaW5lIE5WTUVfTlNfREVBRCAgICAgCTEKICNkZWZpbmUgTlZNRV9OU19BTkFfUEVO
RElORwkyCisjZGVmaW5lIE5WTUVfTlNfRk9SQ0VfUk8JMwogCiAJc3RydWN0IG52bWVfZmF1bHRf
aW5qZWN0IGZhdWx0X2luamVjdDsKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3Qvem5z
LmMgYi9kcml2ZXJzL252bWUvaG9zdC96bnMuYwppbmRleCA2N2U4N2U5ZjMwNmYuLmMyYjU1NzQ1
MjQ4MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL2hvc3Qvem5zLmMKKysrIGIvZHJpdmVycy9u
dm1lL2hvc3Qvem5zLmMKQEAgLTU1LDEyICs1NSwxNiBAQCBpbnQgbnZtZV91cGRhdGVfem9uZV9p
bmZvKHN0cnVjdCBudm1lX25zICpucywgdW5zaWduZWQgbGJhZikKIAlpbnQgc3RhdHVzOwogCiAJ
LyogRHJpdmVyIHJlcXVpcmVzIHpvbmUgYXBwZW5kIHN1cHBvcnQgKi8KLQlpZiAoIShsZTMyX3Rv
X2NwdShsb2ctPmlvY3NbbnZtZV9jbWRfem9uZV9hcHBlbmRdKSAmCi0JCQlOVk1FX0NNRF9FRkZF
Q1RTX0NTVVBQKSkgeworCWlmICgobGUzMl90b19jcHUobG9nLT5pb2NzW252bWVfY21kX3pvbmVf
YXBwZW5kXSkgJiBOVk1FX0NNRF9FRkZFQ1RTX0NTVVBQKSkgeworCQlpZiAodGVzdF9hbmRfY2xl
YXJfYml0KE5WTUVfTlNfRk9SQ0VfUk8sICZucy0+ZmxhZ3MpKQorCQkJZGV2X3dhcm4obnMtPmN0
cmwtPmRldmljZSwKKwkJCQkgImFwcGVuZCBzdXBwb3J0ZWQgZm9yIHpvbmVkIG5hbWVzcGFjZTol
ZC4gUmVtb3ZlIHJlYWQtb25seSBtb2RlXG4iLAorCQkJCSBucy0+aGVhZC0+bnNfaWQpOworCX0g
ZWxzZSB7CisJCXNldF9iaXQoTlZNRV9OU19GT1JDRV9STywgJm5zLT5mbGFncyk7CiAJCWRldl93
YXJuKG5zLT5jdHJsLT5kZXZpY2UsCi0JCQkiYXBwZW5kIG5vdCBzdXBwb3J0ZWQgZm9yIHpvbmVk
IG5hbWVzcGFjZTolZFxuIiwKLQkJCW5zLT5oZWFkLT5uc19pZCk7Ci0JCXJldHVybiAtRUlOVkFM
OworCQkJICJhcHBlbmQgbm90IHN1cHBvcnRlZCBmb3Igem9uZWQgbmFtZXNwYWNlOiVkLiBGb3Jj
aW5nIHRvIHJlYWQtb25seSBtb2RlXG4iLAorCQkJIG5zLT5oZWFkLT5uc19pZCk7CiAJfQogCiAJ
LyogTGF6aWx5IHF1ZXJ5IGNvbnRyb2xsZXIgYXBwZW5kIGxpbWl0IGZvciB0aGUgZmlyc3Qgem9u
ZWQgbmFtZXNwYWNlICovCi0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1udm1lCg==
