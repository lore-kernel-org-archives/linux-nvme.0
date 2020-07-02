Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCB0C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 06:55:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3602067D
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 06:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rl1aXbjY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="jHPI8BGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3602067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IexEAirGXhumeq8guyQY8r9LQLQCNGzDLU5rrbgTk2Q=; b=rl1aXbjYWivwZ616Lwj0Awip9
	eUOygjbikBcyU2c7Qggyj0zh11VWGYc6yhqmR0EPupfedlLuqLwTfGKCARDHSqsdgPVDlQ96i1RgR
	YJKu88exuZxb8K4U7q9DBTosLAL3jSM+prAVNxDKgyn6Vy6tobOkH0GUPlTYyZ3pMlMixiqLNAShz
	qBjRlWK/1Nl4MUz5MbsWWUsmprawShQZrbIxf7f2WJAmdLX6cWtmwF0o/8D1BMD3rMWq8WaQepWuR
	rUPH65oHqrvSutpWzLKrTvJC35ifq/3jPhqD29i1xKTUa3O4b7lWjcmmoIatGgvmtlvQj/swJs1NG
	SpvFiuM2A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqt7w-0008W4-Mx; Thu, 02 Jul 2020 06:55:20 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqt7j-0008Ng-TF
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 06:55:09 +0000
Received: by mail-ed1-x541.google.com with SMTP id g20so22252493edm.4
 for <linux-nvme@lists.infradead.org>; Wed, 01 Jul 2020 23:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mBAEu2FkWCoUHddbe3NyP7a2YbJ4zD2w9Baf5z5Fx3Y=;
 b=jHPI8BGbaFFQIyi+Ut/ZHPViE0BmHnwBxTqZmPLkMoHWRgHbdfRnnbAVKe7BbGy28l
 dKxmms0rCd+k3CM2k5gzfrEdfM/pzj4sMWf/CnqiTjRzVjC5rGwrqyGMgj9eYgXnmjGI
 McMkAFROTNUEdX8iVjve2Pnh53/9mEN2tgT6aaQWMSyOukiLup7oz/ao/P42hPR1/JIy
 Mo4XFxAFXEuhpk2ABdelkGx8KtMmdyCHzShc7PSmHjNBVCyWAGvjYH7FEr3P2n87aqCT
 +dkU6iygsMqcE1YG5NKX73kZE3P6jm7cqYoc1oz9YaLc6LAjPKkbs/t4O++3DCQ6woo4
 Vw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mBAEu2FkWCoUHddbe3NyP7a2YbJ4zD2w9Baf5z5Fx3Y=;
 b=cIWwK761yA67Uh1VrRKCYMCHnhpzOZhl03SpoJkZE3m6vg21JMwvIv3qhw1lIojBA4
 fQewueJ/cCKEDdy0t+EWdcOsgc7qVdh2aaBQd/xwPMJ4qFGUm1d2h8q7rXuUYLeeVvqs
 jzW7zCMds9NGsoEBCLr/BnXcoCyKelROhYUAjyD434wLbcZEd1/GmNOJeW5vK79O/65D
 yyHTFCeUbA8sHCBPFHRCEkQlwjdk8Hg96yC8dQ7H1Mo8+X9flS3/EqiDTu10FHf0qsl/
 0+VgINqhO82KucqbirM+OQdAhhAKkYEdlVlYjL3uoAja7v+V/aRq5QGTkDJnwRfTzZzt
 x/yQ==
X-Gm-Message-State: AOAM533QK3BJkNWjqDSQFbt2YD9/scHvugOIJ+kYKrw7FsvwwdURN1bn
 dMy/6b9uPyrQVO/LTnSiQu02BRM2nlkkhjci
X-Google-Smtp-Source: ABdhPJyL/BVcaBeMvR6W5Ilnhz2uE3e8A+oPUeNUiZyJBer3LEpqy+GpLnE79vkjfvRjc2E9oipsMQ==
X-Received: by 2002:a05:6402:3064:: with SMTP id
 bs4mr33813102edb.350.1593672906690; 
 Wed, 01 Jul 2020 23:55:06 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id cz2sm7912769edb.82.2020.07.01.23.55.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 01 Jul 2020 23:55:06 -0700 (PDT)
From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 3/4] nvme: Add consistency check for zone count
Date: Thu,  2 Jul 2020 08:54:37 +0200
Message-Id: <20200702065438.46350-4-javier@javigon.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702065438.46350-1-javier@javigon.com>
References: <20200702065438.46350-1-javier@javigon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_025508_293887_A677636B 
X-CRM114-Status: GOOD (  18.49  )
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
 Kanchan Joshi <joshi.k@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 linux-block@vger.kernel.org, kbusch@kernel.org,
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
b3N0L252bWUuaAppbmRleCA2NjJmOTVmYmQ5MDkuLmVmODBlMGI0ZGY1NiAxMDA2NDQKLS0tIGEv
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
KQorCQkJCQl1bnNpZ25lZCBsYmFmCisJCQkJCXNlY3Rvcl90IG5zemUpCiB7CiAJZGV2X3dhcm4o
bnMtPmN0cmwtPmRldmljZSwKIAkJICJQbGVhc2UgZW5hYmxlIENPTkZJR19CTEtfREVWX1pPTkVE
IHRvIHN1cHBvcnQgWk5TIGRldmljZXNcbiIpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hv
c3Qvem5zLmMgYi9kcml2ZXJzL252bWUvaG9zdC96bnMuYwppbmRleCBiMzRkMmVkMTM4MjUuLmQ3
ODVkMTc5YTM0MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL2hvc3Qvem5zLmMKKysrIGIvZHJp
dmVycy9udm1lL2hvc3Qvem5zLmMKQEAgLTMyLDEzICszMiwzNiBAQCBzdGF0aWMgaW50IG52bWVf
c2V0X21heF9hcHBlbmQoc3RydWN0IG52bWVfY3RybCAqY3RybCkKIAlyZXR1cm4gMDsKIH0KIAor
c3RhdGljIHU2NCBudm1lX3puc19ucl96b25lcyhzdHJ1Y3QgbnZtZV9ucyAqbnMpCit7CisJc3Ry
dWN0IG52bWVfY29tbWFuZCBjID0geyB9OworCXN0cnVjdCBudm1lX3pvbmVfcmVwb3J0IHJlcG9y
dDsKKwlpbnQgYnVmbGVuID0gc2l6ZW9mKHN0cnVjdCBudm1lX3pvbmVfcmVwb3J0KTsKKwlpbnQg
cmV0OworCisJYy56bXIub3Bjb2RlID0gbnZtZV9jbWRfem9uZV9tZ210X3JlY3Y7CisJYy56bXIu
bnNpZCA9IGNwdV90b19sZTMyKG5zLT5oZWFkLT5uc19pZCk7CisJYy56bXIuc2xiYSA9IGNwdV90
b19sZTY0KDApOworCWMuem1yLm51bWQgPSBjcHVfdG9fbGUzMihudm1lX2J5dGVzX3RvX251bWQo
YnVmbGVuKSk7CisJYy56bXIuenJhID0gTlZNRV9aUkFfWk9ORV9SRVBPUlQ7CisJYy56bXIuenJh
c2YgPSBOVk1FX1pSQVNGX1pPTkVfUkVQT1JUX0FMTDsKKwljLnptci5wciA9IDA7CisKKwlyZXQg
PSBudm1lX3N1Ym1pdF9zeW5jX2NtZChucy0+cXVldWUsICZjLCAmcmVwb3J0LCBidWZsZW4pOwor
CWlmIChyZXQpCisJCXJldHVybiByZXQ7CisKKwlyZXR1cm4gbGU2NF90b19jcHUocmVwb3J0Lm5y
X3pvbmVzKTsKK30KKwogaW50IG52bWVfdXBkYXRlX3pvbmVfaW5mbyhzdHJ1Y3QgZ2VuZGlzayAq
ZGlzaywgc3RydWN0IG52bWVfbnMgKm5zLAotCQkJICB1bnNpZ25lZCBsYmFmKQorCQkJICB1bnNp
Z25lZCBpbnQgbGJhZiwgc2VjdG9yX3QgbnN6ZSkKIHsKIC8vCXN0cnVjdCBudm1lX2VmZmVjdHNf
bG9nICpsb2cgPSBucy0+aGVhZC0+ZWZmZWN0czsKIAlzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSA9
IGRpc2stPnF1ZXVlOwogCXN0cnVjdCBudm1lX2NvbW1hbmQgYyA9IHsgfTsKIAlzdHJ1Y3QgbnZt
ZV9pZF9uc196bnMgKmlkOworCXNlY3Rvcl90IGNhcF9ucl96b25lczsKIAlpbnQgc3RhdHVzOwog
CiAJLyogRHJpdmVyIHJlcXVpcmVzIHpvbmUgYXBwZW5kIHN1cHBvcnQgKi8KQEAgLTgwLDYgKzEw
MywyMCBAQCBpbnQgbnZtZV91cGRhdGVfem9uZV9pbmZvKHN0cnVjdCBnZW5kaXNrICpkaXNrLCBz
dHJ1Y3QgbnZtZV9ucyAqbnMsCiAJCWdvdG8gZnJlZV9kYXRhOwogCX0KIAorCW5zLT5ucl96b25l
cyA9IG52bWVfem5zX25yX3pvbmVzKG5zKTsKKwlpZiAoIW5zLT5ucl96b25lcykgeworCQlzdGF0
dXMgPSAtRUlOVkFMOworCQlnb3RvIGZyZWVfZGF0YTsKKwl9CisKKwljYXBfbnJfem9uZXMgPSBu
dm1lX2xiYV90b19zZWN0KG5zLCBsZTY0X3RvX2NwdShuc3plKSkgPj4gaWxvZzIobnMtPnpzemUp
OworCWlmIChucy0+bnJfem9uZXMgIT0gY2FwX25yX3pvbmVzKSB7CisJCWRldl9lcnIobnMtPmN0
cmwtPmRldmljZSwgImluY29uc2lzdGVudCB6b25lIGNvdW50OiAlbGx1LyVsbHVcbiIsCisJCQlu
cy0+bnJfem9uZXMsIGNhcF9ucl96b25lcyk7CisJCXN0YXR1cyA9IC1FSU5WQUw7CisJCWdvdG8g
ZnJlZV9kYXRhOworCX0KKwogCXEtPmxpbWl0cy56b25lZCA9IEJMS19aT05FRF9ITTsKIAlxLT56
b25lX2ZsYWdzID0gQkxLX1pPTkVfUkVQX0NBUEFDSVRZIHwgQkxLX1pPTkVfUkVQX09GRkxJTkU7
CiAJYmxrX3F1ZXVlX2ZsYWdfc2V0KFFVRVVFX0ZMQUdfWk9ORV9SRVNFVEFMTCwgcSk7Ci0tIAoy
LjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
