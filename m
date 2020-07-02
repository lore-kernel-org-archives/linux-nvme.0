Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B7CC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 09:25:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66A0E20771
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 09:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cURaFySz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="yA+ecdF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A0E20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5+yYxgOCQ5JYzSQ2M5RHMVQM6PBr5rbs+w7KYpY7GwM=; b=cURaFySz/cVN9wWtVhYEa0mCD
	HFDR4o7p/ZGclKf1hRAz3sNMjgY2mwCbruYkpIOrQd7q/ctTXYeNKDC6nEua6mjvPGl2Y2e0eaXX1
	7VTkoDfWU8wwC9m4DI5PvO3/TAB2TJwAhswD4rXO6rB903nTtU43WtNu6JgKdNjKm9DQqbjq9Q62u
	Y/r11RLuhtdXhc5TxITRjmvK8eiT8pKG2J3RGZGGcEMQlubF/RfvvQTmc5A5Vo4leQjdS5nlk94q/
	52AJllyK0A4LEJWnM5gCBHuUnVFirOPAn2ZYFQ5ms4wvUNdDdAWs9xRUnSv+8TivF4xcxjANy+xu+
	pm0RnX92A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqvTA-0008N2-Nj; Thu, 02 Jul 2020 09:25:24 +0000
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqvT7-0008LG-6h
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 09:25:22 +0000
Received: by mail-ej1-x643.google.com with SMTP id p20so28418615ejd.13
 for <linux-nvme@lists.infradead.org>; Thu, 02 Jul 2020 02:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cAmJ/Zf7T+fcjgZyRga2M0NL/BcX+6gWE28VkxPctQQ=;
 b=yA+ecdF0MKqvSnlvD1xL45nrJ0zLStVUHAckg2WybnGxj6SK7eut+56N5TLtxONncM
 tC59Wy7XLrR4nZcbixSk7gwMOSCXgSGNIXeH0Ap9Ul2YtON7PR2ye1uGVh9Vzt8F195H
 CM4jmbj5QdGMF1mxEuy/ovR6A9M/if8SKdZDoq94m+HbzX4iPNMCJObH68yQa32kezce
 moJsn4/We7du7fghrkIu1+aeMt4n90zFI1JrnAIQLdaaXUDkmwfUEgLjFSrMzNj1Bo7/
 dlWuh3LAOCcbwdO+5RpGwWY6puQHiVduqW3qiJv+6dElekvuHLZTLYjK2eqV2BuXfQa4
 0G3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cAmJ/Zf7T+fcjgZyRga2M0NL/BcX+6gWE28VkxPctQQ=;
 b=pgWtx7QmROAsulffBSeIohhTJG4xTq6TfkktAbspngAz4koYayWx7aY3VVmx4zaqRd
 lVLty6bgBSTo6U/g/d+5xZ/cRavkx8tiQho55W2MDY/xmRcxmWkONg8lj7621wNZBzLI
 TDwQgjTjh5okKu3a7GYSVpwY4/W6lDegEQGpIjtSdvo05Jcpj61RGsb51xt0VCcgOyqK
 htZx3RD82NxpKc9qLuG1T3PlGv8KKNffPbCTeUnvVgbUDZR7VA/w8VH6wQY1Hud+g758
 d70q05reXCX78NRRCXTMBC0G8c0zdWBkdREwVvlmOzGcKRmvalkD8v/c8j2Kc14J80Xt
 R5Cw==
X-Gm-Message-State: AOAM530j7xJOO11vipHKgql/Xxi5MJ7XpQKUvN0VjTwxPsbErJdUfDwg
 FrYuM0WBEB6147n7KktwbnCWP148wcV8Oy4w
X-Google-Smtp-Source: ABdhPJzJ5uSLlUU5QX1Eokd0XUUtn7xhOsOpkXZMNG7F65sNWszBNng61gY8N/jOiGyrGyQvMJTi1w==
X-Received: by 2002:a17:907:41dc:: with SMTP id
 og20mr2553300ejb.183.1593681919699; 
 Thu, 02 Jul 2020 02:25:19 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id b18sm6569464ejl.52.2020.07.02.02.25.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 Jul 2020 02:25:19 -0700 (PDT)
From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v3 3/4] nvme: Add consistency check for zone count
Date: Thu,  2 Jul 2020 11:24:37 +0200
Message-Id: <20200702092438.63717-4-javier@javigon.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702092438.63717-1-javier@javigon.com>
References: <20200702092438.63717-1-javier@javigon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_052521_384784_6447AE13 
X-CRM114-Status: GOOD (  18.63  )
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
Cc: axboe@kernel.dk, Damien.LeMoal@wdc.com,
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, Johannes.Thumshirn@wdc.com,
 Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
 kbusch@kernel.org,
 =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>, mb@lightnvm.io,
 hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+CgpTaW5jZSB0
aGUgbnVtYmVyIG9mIHpvbmVzIGlzIGNhbGN1bGF0ZWQgdGhyb3VnaCB0aGUgcmVwb3J0ZWQgZGV2
aWNlCmNhcGFjaXR5IGFuZCB0aGUgWk5TIHNwZWNpZmljYXRpb24gYWxsb3dzIHRvIHJlcG9ydCB0
aGUgdG90YWwgbnVtYmVyIG9mCnpvbmVzIGluIHRoZSBkZXZpY2UsIGFkZCBhbiBleHRyYSBjaGVj
ayB0byBndWFyYW50ZWUgY29uc2lzdGVuY3kgYmV0d2Vlbgp0aGUgZGV2aWNlIGFuZCB0aGUga2Vy
bmVsLgoKQWxzbywgZml4IGEgY2hlY2twYXRjaCB3YXJuaW5nOiB1bnNpZ25lZCAtPiB1bnNpZ25l
ZCBpbnQgaW4gdGhlIHByb2Nlc3MKClNpZ25lZC1vZmYtYnk6IEphdmllciBHb256w6FsZXogPGph
dmllci5nb256QHNhbXN1bmcuY29tPgpTaWduZWQtb2ZmLWJ5OiBTZWx2YUt1bWFyIFMgPHNlbHZh
a3VtYS5zMUBzYW1zdW5nLmNvbT4KU2lnbmVkLW9mZi1ieTogS2FuY2hhbiBKb3NoaSA8am9zaGku
a0BzYW1zdW5nLmNvbT4KU2lnbmVkLW9mZi1ieTogTml0ZXNoIFNoZXR0eSA8bmouc2hldHR5QHNh
bXN1bmcuY29tPgotLS0KIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8ICAyICstCiBkcml2ZXJz
L252bWUvaG9zdC9udm1lLmggfCAgNiArKysrLS0KIGRyaXZlcnMvbnZtZS9ob3N0L3pucy5jICB8
IDM5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQogMyBmaWxlcyBjaGFu
Z2VkLCA0MyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwppbmRleCAxZjVj
N2ZjM2QyYzkuLjhiOWM2OTE3MjkzMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29y
ZS5jCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwpAQCAtMTk5NCw3ICsxOTk0LDcgQEAg
c3RhdGljIGludCBfX252bWVfcmV2YWxpZGF0ZV9kaXNrKHN0cnVjdCBnZW5kaXNrICpkaXNrLCBz
dHJ1Y3QgbnZtZV9pZF9ucyAqaWQpCiAJY2FzZSBOVk1FX0NTSV9OVk06CiAJCWJyZWFrOwogCWNh
c2UgTlZNRV9DU0lfWk5TOgotCQlyZXQgPSBudm1lX3VwZGF0ZV96b25lX2luZm8oZGlzaywgbnMs
IGxiYWYpOworCQlyZXQgPSBudm1lX3VwZGF0ZV96b25lX2luZm8oZGlzaywgbnMsIGxiYWYsIGxl
NjRfdG9fY3B1KGlkLT5uc3plKSk7CiAJCWlmIChyZXQpCiAJCQlyZXR1cm4gcmV0OwogCQlicmVh
azsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaCBiL2RyaXZlcnMvbnZtZS9o
b3N0L252bWUuaAppbmRleCA2NjJmOTVmYmQ5MDkuLjBjMjA4ZjZjZDMzNSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaApA
QCAtNDA3LDYgKzQwNyw3IEBAIHN0cnVjdCBudm1lX25zIHsKIAl1MzIgc3dzOwogCXU4IHBpX3R5
cGU7CiAjaWZkZWYgQ09ORklHX0JMS19ERVZfWk9ORUQKKwl1NjQgbnJfem9uZXM7CiAJdTY0IHpz
emU7CiAjZW5kaWYKIAl1bnNpZ25lZCBsb25nIGZlYXR1cmVzOwpAQCAtNzAwLDcgKzcwMSw3IEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCBudm1lX21wYXRoX3N0YXJ0X2ZyZWV6ZShzdHJ1Y3QgbnZtZV9z
dWJzeXN0ZW0gKnN1YnN5cykKIAogI2lmZGVmIENPTkZJR19CTEtfREVWX1pPTkVECiBpbnQgbnZt
ZV91cGRhdGVfem9uZV9pbmZvKHN0cnVjdCBnZW5kaXNrICpkaXNrLCBzdHJ1Y3QgbnZtZV9ucyAq
bnMsCi0JCQkgIHVuc2lnbmVkIGxiYWYpOworCQkJICB1bnNpZ25lZCBpbnQgbGJhZiwgc2VjdG9y
X3QgbnN6ZSk7CiAKIGludCBudm1lX3JlcG9ydF96b25lcyhzdHJ1Y3QgZ2VuZGlzayAqZGlzaywg
c2VjdG9yX3Qgc2VjdG9yLAogCQkgICAgICB1bnNpZ25lZCBpbnQgbnJfem9uZXMsIHJlcG9ydF96
b25lc19jYiBjYiwgdm9pZCAqZGF0YSk7CkBAIC03MjAsNyArNzIxLDggQEAgc3RhdGljIGlubGlu
ZSBibGtfc3RhdHVzX3QgbnZtZV9zZXR1cF96b25lX21nbXRfc2VuZChzdHJ1Y3QgbnZtZV9ucyAq
bnMsCiAKIHN0YXRpYyBpbmxpbmUgaW50IG52bWVfdXBkYXRlX3pvbmVfaW5mbyhzdHJ1Y3QgZ2Vu
ZGlzayAqZGlzaywKIAkJCQkJc3RydWN0IG52bWVfbnMgKm5zLAotCQkJCQl1bnNpZ25lZCBsYmFm
KQorCQkJCQl1bnNpZ25lZCBpbnQgbGJhZiwKKwkJCQkJc2VjdG9yX3QgbnN6ZSkKIHsKIAlkZXZf
d2Fybihucy0+Y3RybC0+ZGV2aWNlLAogCQkgIlBsZWFzZSBlbmFibGUgQ09ORklHX0JMS19ERVZf
Wk9ORUQgdG8gc3VwcG9ydCBaTlMgZGV2aWNlc1xuIik7CmRpZmYgLS1naXQgYS9kcml2ZXJzL252
bWUvaG9zdC96bnMuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3pucy5jCmluZGV4IGJiNmEzM2Y1MmQ1
My4uZGFmMGQ5MWJjZGY2IDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvaG9zdC96bnMuYworKysg
Yi9kcml2ZXJzL252bWUvaG9zdC96bnMuYwpAQCAtMzIsMTMgKzMyLDM2IEBAIHN0YXRpYyBpbnQg
bnZtZV9zZXRfbWF4X2FwcGVuZChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKQogCXJldHVybiAwOwog
fQogCitzdGF0aWMgdTY0IG52bWVfem5zX25yX3pvbmVzKHN0cnVjdCBudm1lX25zICpucykKK3sK
KwlzdHJ1Y3QgbnZtZV9jb21tYW5kIGMgPSB7IH07CisJc3RydWN0IG52bWVfem9uZV9yZXBvcnQg
cmVwb3J0OworCWludCBidWZsZW4gPSBzaXplb2Yoc3RydWN0IG52bWVfem9uZV9yZXBvcnQpOwor
CWludCByZXQ7CisKKwljLnptci5vcGNvZGUgPSBudm1lX2NtZF96b25lX21nbXRfcmVjdjsKKwlj
Lnptci5uc2lkID0gY3B1X3RvX2xlMzIobnMtPmhlYWQtPm5zX2lkKTsKKwljLnptci5zbGJhID0g
Y3B1X3RvX2xlNjQoMCk7CisJYy56bXIubnVtZCA9IGNwdV90b19sZTMyKG52bWVfYnl0ZXNfdG9f
bnVtZChidWZsZW4pKTsKKwljLnptci56cmEgPSBOVk1FX1pSQV9aT05FX1JFUE9SVDsKKwljLnpt
ci56cmFzZiA9IE5WTUVfWlJBU0ZfWk9ORV9SRVBPUlRfQUxMOworCWMuem1yLnByID0gMDsKKwor
CXJldCA9IG52bWVfc3VibWl0X3N5bmNfY21kKG5zLT5xdWV1ZSwgJmMsICZyZXBvcnQsIGJ1Zmxl
bik7CisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsKKworCXJldHVybiBsZTY0X3RvX2NwdShyZXBv
cnQubnJfem9uZXMpOworfQorCiBpbnQgbnZtZV91cGRhdGVfem9uZV9pbmZvKHN0cnVjdCBnZW5k
aXNrICpkaXNrLCBzdHJ1Y3QgbnZtZV9ucyAqbnMsCi0JCQkgIHVuc2lnbmVkIGxiYWYpCisJCQkg
IHVuc2lnbmVkIGludCBsYmFmLCBzZWN0b3JfdCBuc3plKQogewogCXN0cnVjdCBudm1lX2VmZmVj
dHNfbG9nICpsb2cgPSBucy0+aGVhZC0+ZWZmZWN0czsKIAlzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAq
cSA9IGRpc2stPnF1ZXVlOwogCXN0cnVjdCBudm1lX2NvbW1hbmQgYyA9IHsgfTsKIAlzdHJ1Y3Qg
bnZtZV9pZF9uc196bnMgKmlkOworCXNlY3Rvcl90IGNhcF9ucl96b25lczsKIAlpbnQgc3RhdHVz
OwogCiAJLyogRHJpdmVyIHJlcXVpcmVzIHpvbmUgYXBwZW5kIHN1cHBvcnQgKi8KQEAgLTgwLDYg
KzEwMywyMCBAQCBpbnQgbnZtZV91cGRhdGVfem9uZV9pbmZvKHN0cnVjdCBnZW5kaXNrICpkaXNr
LCBzdHJ1Y3QgbnZtZV9ucyAqbnMsCiAJCWdvdG8gZnJlZV9kYXRhOwogCX0KIAorCW5zLT5ucl96
b25lcyA9IG52bWVfem5zX25yX3pvbmVzKG5zKTsKKwlpZiAoIW5zLT5ucl96b25lcykgeworCQlz
dGF0dXMgPSAtRUlOVkFMOworCQlnb3RvIGZyZWVfZGF0YTsKKwl9CisKKwljYXBfbnJfem9uZXMg
PSBudm1lX2xiYV90b19zZWN0KG5zLCBsZTY0X3RvX2NwdShuc3plKSkgPj4gaWxvZzIobnMtPnpz
emUpOworCWlmIChucy0+bnJfem9uZXMgIT0gY2FwX25yX3pvbmVzKSB7CisJCWRldl9lcnIobnMt
PmN0cmwtPmRldmljZSwgImluY29uc2lzdGVudCB6b25lIGNvdW50OiAlbGx1LyVsbHVcbiIsCisJ
CQlucy0+bnJfem9uZXMsIGNhcF9ucl96b25lcyk7CisJCXN0YXR1cyA9IC1FSU5WQUw7CisJCWdv
dG8gZnJlZV9kYXRhOworCX0KKwogCXEtPmxpbWl0cy56b25lZCA9IEJMS19aT05FRF9ITTsKIAlx
LT56b25lX2ZsYWdzID0gQkxLX1pPTkVfUkVQX0NBUEFDSVRZIHwgQkxLX1pPTkVfU1VQX09GRkxJ
TkU7CiAJYmxrX3F1ZXVlX2ZsYWdfc2V0KFFVRVVFX0ZMQUdfWk9ORV9SRVNFVEFMTCwgcSk7Ci0t
IAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
