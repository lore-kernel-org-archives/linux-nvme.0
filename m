Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714D5C388F7
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 21:07:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6154206D8
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 21:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HdU5NjGk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="w1K69wG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6154206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eaJf4cB5mhVcz0y8RAnKx1SAFTp/hEi7fdE5jcxsZdY=; b=HdU5NjGk/VF4pxMHwMrwRXhNgf
	4GmlBP6/5aNFLxiKTpoG5qbXpe0hEEkkk0TqIdFUwoCfQg9708Fou0OCS9nQ6B5SufePZNhowcLBt
	XLmu9GDBl2jD/YyOI0YvSI1nwHm32DV26rJ91LrBPuKBI5ynn5jEkIhJ8m7x2MS68GuXp+h3u9Exg
	P1DiwP4tOZvSOBCWWvMSPQMbrtR1tMAoHYpYSuFRFXoy3bI+y8qo0s5cSP9HnlTUS8G6NXxzzPewm
	sLqt9gExRhiCU7Uyh2Jc0/EcyRUIfVXTSRxPxySZmkmtz/oL+D9C70pCpp7kMDnkxfVYaCCpRyS/a
	trHQXdsw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcarF-0007zA-7y; Tue, 10 Nov 2020 21:07:17 +0000
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcarC-0007yf-5y
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 21:07:15 +0000
Received: by mail-ej1-x642.google.com with SMTP id s25so19651348ejy.6
 for <linux-nvme@lists.infradead.org>; Tue, 10 Nov 2020 13:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fn70aGa64W5eIqqOUi1sTiBrlHo5x+oxYFL83gN5tjc=;
 b=w1K69wG9IVVBEM8aSvX8uZWph3zS0tJZMl0MkcG0BnndYwtGG9gjTFtt0g+aOEzbh8
 jbq5tuxWxBKb/GcCChcZYEGS2ph/eCNTCOWMJMUmUANAIqxiTtijn08Pdt1m+Ahx2+MP
 xR0Pqq7cNfsjOZ5m7l5QJmZlOPe1WskxhnRBr4AsQGZnD/Pyuc7TKgZnkljjvhlOEP6o
 r72u3pSnyS/itKtLEQl0oJxp2wmV5CaufLaali1PTNSaixa1cTUowr+7HuiiVOm1qs1+
 ZEQjCq9FEdeqOnOkAQDcLP6Mpg7bO8NcZ1qDC3WdPOhkRczT/0xZD3nsG3NsRbAU+Sgr
 QB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fn70aGa64W5eIqqOUi1sTiBrlHo5x+oxYFL83gN5tjc=;
 b=ibvTsTOCJdg91shMj6ZuBRLtdIVDSzaVZC3q/+Km/t9mvaL4hNqRZkiR8EE8AajBv6
 oZUYIGk9VBnVmSXn6OlHvfr4lS1dh+ICS9Ywgyv60LvPAgxHdUHo9/47PpZWjACqt85c
 BGDFEnvR6xkc/+1sY9c3mMinH6/aN7dwQ9EQ4For8wJtDmRA/kT/M+W9v82+IKWlO4hx
 TtfRNa3SQTTuymaGroO24pAsILrv0gz9k5MvAMlAUQIJ6YHUg4CYnr+2tEyoII07NFLV
 WjKXaZyplRkpdamh9QoJD81+03UrESOVoVPfZpl+mhHBaUkfKrf5ltoQoagiem97hcax
 nXWw==
X-Gm-Message-State: AOAM533F0CbfNwVquzhDicEUKGUKx6GPl03ZUugYSyZ2CbjySKqQd/Kr
 Cj6QQlfWwZSlL0iQBuoorBbU73983iijW+2/
X-Google-Smtp-Source: ABdhPJwVznbucUTwxVD/UvOKjCsh+eveawzSlB2eFc+1RBJDOxynYX8FI0YjpDjVa9+Ca52k2kUcLQ==
X-Received: by 2002:a17:906:a4b:: with SMTP id
 x11mr22630420ejf.11.1605042431782; 
 Tue, 10 Nov 2020 13:07:11 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk.
 [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id m16sm9653488eja.58.2020.11.10.13.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 13:07:10 -0800 (PST)
From: javier@javigon.com
X-Google-Original-From: javier@samsung.com
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3] nvme: enable ro namespace for ZNS without append
Date: Tue, 10 Nov 2020 22:07:08 +0100
Message-Id: <20201110210708.5912-1-javier@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201110_160714_347172_3DA9C8D6 
X-CRM114-Status: GOOD (  22.49  )
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
dGNoIHdpbGwgYmUgc3VibWl0dGVkIHNlcGFyYXRlbHkuCgpDaGFuZ2VzIHNpbmNlIFYyOgogIC0g
Rml4IHNtYWxsIGNvbmZsaWN0IHdpdGggYSBxdWV1ZWQgcGF0Y2ggZnJvbSBTYWdpIChmcm9tIENo
cmlzdG9waCkKICAtIEZpeCBpbmRlbnRhdGlvbiAoZnJvbSBOaWtsYXMpCiAgLSBSZWZyZXNoIGVm
ZmVjdHMgbG9nIHBhZ2UgdG8gYWNjb3VudCBmb3IgRlcgY2hhbmdlcyAoZnJvbSBLZWl0aCkKCkNo
YW5nZXMgc2luY2UgVjE6CiAgLSBDaGFuZ2UgbG9naWMgdG8gdXNlIE5WTUVfTlNfQVRUUl9STyAo
ZnJvbSBDaHJpc3RvcGgpCiAgLSBTZXQgbWF4X3pvbmVfYXBwZW5kIGVnZW4gaW4gUk8uIFRoaXMg
YWxsb3dzIHRoZSBkZXZpY2UgdG8gYmUKICAgIHByb3Blcmx5IHJldmFsaWRhdGVkIGFuZCBlbmFi
bGVzIHVzZXItc3BhY2UgdG9vbHMgc3VjaCBhcyBibGt6b25lIHRvCiAgICBiZSB1c2VkIHdoZW4g
aW50ZXJhY3Rpbmcgd2l0aCB0aGlzIHpvbmVkIGRldmljZS4KClNpZ25lZC1vZmYtYnk6IEphdmll
ciBHb256w6FsZXogPGphdmllci5nb256QHNhbXN1bmcuY29tPgotLS0KIGRyaXZlcnMvbnZtZS9o
b3N0L2NvcmUuYyB8ICA1ICsrLS0tCiBkcml2ZXJzL252bWUvaG9zdC9udm1lLmggfCAgMiArKwog
ZHJpdmVycy9udm1lL2hvc3Qvem5zLmMgIHwgMTkgKysrKysrKysrKysrKystLS0tLQogMyBmaWxl
cyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwppbmRl
eCBmZmY5MDIwMDQ5N2MuLjhhMjI0YTZmMjQ3MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL2hv
c3QvY29yZS5jCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwpAQCAtMjA4Myw3ICsyMDgz
LDcgQEAgc3RhdGljIHZvaWQgbnZtZV91cGRhdGVfZGlza19pbmZvKHN0cnVjdCBnZW5kaXNrICpk
aXNrLAogCW52bWVfY29uZmlnX2Rpc2NhcmQoZGlzaywgbnMpOwogCW52bWVfY29uZmlnX3dyaXRl
X3plcm9lcyhkaXNrLCBucyk7CiAKLQlpZiAoaWQtPm5zYXR0ciAmIE5WTUVfTlNfQVRUUl9STykK
KwlpZiAoaWQtPm5zYXR0ciAmIE5WTUVfTlNfQVRUUl9STyB8fCB0ZXN0X2JpdChOVk1FX05TX0ZP
UkNFX1JPLCAmbnMtPmZsYWdzKSkKIAkJc2V0X2Rpc2tfcm8oZGlzaywgdHJ1ZSk7CiB9CiAKQEAg
LTI5NTEsOCArMjk1MSw3IEBAIGludCBudm1lX2dldF9sb2coc3RydWN0IG52bWVfY3RybCAqY3Ry
bCwgdTMyIG5zaWQsIHU4IGxvZ19wYWdlLCB1OCBsc3AsIHU4IGNzaSwKIAlyZXR1cm4gbnZtZV9z
dWJtaXRfc3luY19jbWQoY3RybC0+YWRtaW5fcSwgJmMsIGxvZywgc2l6ZSk7CiB9CiAKLXN0YXRp
YyBpbnQgbnZtZV9nZXRfZWZmZWN0c19sb2coc3RydWN0IG52bWVfY3RybCAqY3RybCwgdTggY3Np
LAotCQkJCXN0cnVjdCBudm1lX2VmZmVjdHNfbG9nICoqbG9nKQoraW50IG52bWVfZ2V0X2VmZmVj
dHNfbG9nKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsIHU4IGNzaSwgc3RydWN0IG52bWVfZWZmZWN0
c19sb2cgKipsb2cpCiB7CiAJc3RydWN0IG52bWVfY2VsICpjZWwgPSB4YV9sb2FkKCZjdHJsLT5j
ZWxzLCBjc2kpOwogCWludCByZXQ7CmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9udm1l
LmggYi9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgKaW5kZXggODNmYjMwZTMxN2UwLi44NTdmY2E5
NWYwMTYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaAorKysgYi9kcml2ZXJz
L252bWUvaG9zdC9udm1lLmgKQEAgLTQ0OSw2ICs0NDksNyBAQCBzdHJ1Y3QgbnZtZV9ucyB7CiAj
ZGVmaW5lIE5WTUVfTlNfUkVNT1ZJTkcJMAogI2RlZmluZSBOVk1FX05TX0RFQUQgICAgIAkxCiAj
ZGVmaW5lIE5WTUVfTlNfQU5BX1BFTkRJTkcJMgorI2RlZmluZSBOVk1FX05TX0ZPUkNFX1JPCTMK
IAogCXN0cnVjdCBudm1lX2ZhdWx0X2luamVjdCBmYXVsdF9pbmplY3Q7CiAKQEAgLTYzOCw2ICs2
MzksNyBAQCBpbnQgbnZtZV9kZWxldGVfY3RybChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKTsKIAog
aW50IG52bWVfZ2V0X2xvZyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCB1MzIgbnNpZCwgdTggbG9n
X3BhZ2UsIHU4IGxzcCwgdTggY3NpLAogCQl2b2lkICpsb2csIHNpemVfdCBzaXplLCB1NjQgb2Zm
c2V0KTsKK2ludCBudm1lX2dldF9lZmZlY3RzX2xvZyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCB1
OCBjc2ksIHN0cnVjdCBudm1lX2VmZmVjdHNfbG9nICoqbG9nKTsKIHN0cnVjdCBudm1lX25zICpu
dm1lX2dldF9uc19mcm9tX2Rpc2soc3RydWN0IGdlbmRpc2sgKmRpc2ssCiAJCXN0cnVjdCBudm1l
X25zX2hlYWQgKipoZWFkLCBpbnQgKnNyY3VfaWR4KTsKIHZvaWQgbnZtZV9wdXRfbnNfZnJvbV9k
aXNrKHN0cnVjdCBudm1lX25zX2hlYWQgKmhlYWQsIGludCBpZHgpOwpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9udm1lL2hvc3Qvem5zLmMgYi9kcml2ZXJzL252bWUvaG9zdC96bnMuYwppbmRleCA2N2U4
N2U5ZjMwNmYuLjQ3Njc5YTkwNzk1YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL2hvc3Qvem5z
LmMKKysrIGIvZHJpdmVycy9udm1lL2hvc3Qvem5zLmMKQEAgLTU0LDEzICs1NCwyMiBAQCBpbnQg
bnZtZV91cGRhdGVfem9uZV9pbmZvKHN0cnVjdCBudm1lX25zICpucywgdW5zaWduZWQgbGJhZikK
IAlzdHJ1Y3QgbnZtZV9pZF9uc196bnMgKmlkOwogCWludCBzdGF0dXM7CiAKKwkvKiBSZWZyZXNo
IGVmZmVjdHMgbG9nIHBhZ2UgdG8gY2hlY2sgZm9yIGNoYW5nZXMgb24gYXBwZW5kIHN1cHBvcnQg
Ki8KKwlzdGF0dXMgPSBudm1lX2dldF9lZmZlY3RzX2xvZyhucy0+Y3RybCwgbnMtPmhlYWQtPmlk
cy5jc2ksICZucy0+aGVhZC0+ZWZmZWN0cyk7CisJaWYgKHN0YXR1cykKKwkJcmV0dXJuIHN0YXR1
czsKKwogCS8qIERyaXZlciByZXF1aXJlcyB6b25lIGFwcGVuZCBzdXBwb3J0ICovCi0JaWYgKCEo
bGUzMl90b19jcHUobG9nLT5pb2NzW252bWVfY21kX3pvbmVfYXBwZW5kXSkgJgotCQkJTlZNRV9D
TURfRUZGRUNUU19DU1VQUCkpIHsKKwlpZiAoKGxlMzJfdG9fY3B1KGxvZy0+aW9jc1tudm1lX2Nt
ZF96b25lX2FwcGVuZF0pICYgTlZNRV9DTURfRUZGRUNUU19DU1VQUCkpIHsKKwkJaWYgKHRlc3Rf
YW5kX2NsZWFyX2JpdChOVk1FX05TX0ZPUkNFX1JPLCAmbnMtPmZsYWdzKSkKKwkJCWRldl93YXJu
KG5zLT5jdHJsLT5kZXZpY2UsCisJCQkJICJhcHBlbmQgc3VwcG9ydGVkIGZvciB6b25lZCBuYW1l
c3BhY2U6JWQuIFJlbW92ZSByZWFkLW9ubHkgbW9kZVxuIiwKKwkJCQkgbnMtPmhlYWQtPm5zX2lk
KTsKKwl9IGVsc2UgeworCQlzZXRfYml0KE5WTUVfTlNfRk9SQ0VfUk8sICZucy0+ZmxhZ3MpOwog
CQlkZXZfd2Fybihucy0+Y3RybC0+ZGV2aWNlLAotCQkJImFwcGVuZCBub3Qgc3VwcG9ydGVkIGZv
ciB6b25lZCBuYW1lc3BhY2U6JWRcbiIsCi0JCQlucy0+aGVhZC0+bnNfaWQpOwotCQlyZXR1cm4g
LUVJTlZBTDsKKwkJCSAiYXBwZW5kIG5vdCBzdXBwb3J0ZWQgZm9yIHpvbmVkIG5hbWVzcGFjZTol
ZC4gRm9yY2luZyB0byByZWFkLW9ubHkgbW9kZVxuIiwKKwkJCSBucy0+aGVhZC0+bnNfaWQpOwog
CX0KIAogCS8qIExhemlseSBxdWVyeSBjb250cm9sbGVyIGFwcGVuZCBsaW1pdCBmb3IgdGhlIGZp
cnN0IHpvbmVkIG5hbWVzcGFjZSAqLwotLSAKMi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=
