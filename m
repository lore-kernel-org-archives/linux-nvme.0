Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A650CC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 09:25:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71A2320702
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 09:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jFoSc8kO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="foGWa1ds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A2320702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+ADoNy20Nhm6rkEdzvdy+F+qdN/vsHxvXDV+GsCpNXM=; b=jFoSc8kO2m7xZNbd4tEcSDrG3
	2kPkBogoH+i7yQ/ueIu9PPOdPhpcnFZVhoiCcwgy9LGD1hIhg1R7VVcoTgE0/A7h0c89sk+2BJ+aQ
	pMNRD+V9dl2Ukt4p2OeyHHJSHloaQCb5YsSdABNeAlkSfJOozfZgEozPWHBi4OeTEcP9cUkMkv7+g
	ZTVKP+FgGr4IycQSOJhW9NNohl3NmNGbLHWDwXUruMw+H/WDwN3Abr83li5rZkTPTNfziYuTsegPD
	iedyJVDFdISry8kCP943PWBtMPYkM6NUL4rOMfw/QcWvcAwEJvUpptyKb2w0k64wSLPLzA+ffDdFt
	GtU7dNN3w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqvTC-0008Nv-Jf; Thu, 02 Jul 2020 09:25:26 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqvT8-0008Ln-JS
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 09:25:23 +0000
Received: by mail-ed1-x542.google.com with SMTP id by13so13004639edb.11
 for <linux-nvme@lists.infradead.org>; Thu, 02 Jul 2020 02:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=seRLkTJ1ew4YebKz5kRgT9SUY7OCSuZACxJCKoWfuZU=;
 b=foGWa1dsgrf7XlkYun30ylm+oVae2e0vGCrDEY5d+yLiehK3nXxUKrq94J0D6UZGfO
 A5IkWYJ2ie2kUDHv1jyVIP0NklwVMJS0vBb3CXHU04K73WGCo1sCGKcNNW56WNUZNqHq
 cUQskNEhasm+hFP0VQamaDobvqMr9h5sotB6Hf3Zliy2TEvCpKuhSuYk75BjKFBl0pWX
 SPGh5qLgn95pKj4hFpPVZEvSoYSJUAEl9Vi07OFZMY7cmH+Dmgdb7NuGq52/DPyLdUQ4
 xpwmH7dU3ghroDzNRO1uGM5Nq66F9ncYt/yFDSLwP5LTwNglE1tuga8v2buo9OuZRQ9g
 wg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=seRLkTJ1ew4YebKz5kRgT9SUY7OCSuZACxJCKoWfuZU=;
 b=VfFNbNnxwKyA8T2sXrK5yR6qo9vqrvjIpcFZvmM1wZrEtf5mg87flOr4roSy+9IrzW
 HYs/P/IEPXG8KWS2NmpTBUyCqzQe/Kf6Z8KVCet6fUj8QJJeXcBVz8WX+6LgpiFSt6FW
 midYLrdR9THlo1Alq3cEZNC1Ox40hljWw72YuulmSwabtXGx6aj8tzlG0bFbWId8UXm0
 TBPwgPkLqCQlPAO6ObfAeEfVYYOAHLzcY1LZaLYmR1Jmvtnx7iDJSAIcmuYeUEgeLVty
 fl4aDHHB8Jkg5sJPKtKxNDxLayY10V85cNBCO9xq8q0kVGkj1RIVvvabxfQshPmAsSY/
 mZRw==
X-Gm-Message-State: AOAM5333TBPBta8bIYXDz6jeoti27g1M/1I2pJ+9s98vy2/RiZq7+RXB
 pZQYXuOh4xBKuM3LxrP9e2epyuEqY7JI5Ell
X-Google-Smtp-Source: ABdhPJxTEh6o6QgeknmvbHZn321/KVXjaNE5zNnvEz1twZV4AdY5tcuAThmt+lLBqhFL79C5Yj0YuA==
X-Received: by 2002:a05:6402:1d18:: with SMTP id
 dg24mr34180761edb.33.1593681920863; 
 Thu, 02 Jul 2020 02:25:20 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id b18sm6569464ejl.52.2020.07.02.02.25.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 Jul 2020 02:25:20 -0700 (PDT)
From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v3 4/4] block: add attributes to zone report
Date: Thu,  2 Jul 2020 11:24:38 +0200
Message-Id: <20200702092438.63717-5-javier@javigon.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702092438.63717-1-javier@javigon.com>
References: <20200702092438.63717-1-javier@javigon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_052522_718722_63253908 
X-CRM114-Status: GOOD (  16.38  )
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

RnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+CgpBZGQgem9u
ZSBhdHRyaWJ1dGVzIGZpZWxkIHRvIHRoZSBibGtfem9uZSBzdHJ1Y3R1cmUuIFVzZSBaTlMgYXR0
cmlidXRlcwphcyBiYXNlIGZvciB6b25lZCBibG9jayBkZXZpY2VzIGFuZCBhZGQgdGhlIGN1cnJl
bnQgYXRyaWJ1dGVzIGluClpBQy9aQkMuCgpTaWduZWQtb2ZmLWJ5OiBKYXZpZXIgR29uesOhbGV6
IDxqYXZpZXIuZ29uekBzYW1zdW5nLmNvbT4KU2lnbmVkLW9mZi1ieTogU2VsdmFLdW1hciBTIDxz
ZWx2YWt1bWEuczFAc2Ftc3VuZy5jb20+ClNpZ25lZC1vZmYtYnk6IEthbmNoYW4gSm9zaGkgPGpv
c2hpLmtAc2Ftc3VuZy5jb20+ClNpZ25lZC1vZmYtYnk6IE5pdGVzaCBTaGV0dHkgPG5qLnNoZXR0
eUBzYW1zdW5nLmNvbT4KLS0tCiBkcml2ZXJzL252bWUvaG9zdC96bnMuYyAgICAgICB8ICAzICsr
LQogZHJpdmVycy9zY3NpL3NkLmMgICAgICAgICAgICAgfCAgMiArLQogZHJpdmVycy9zY3NpL3Nk
X3piYy5jICAgICAgICAgfCAgOCArKysrKystLQogaW5jbHVkZS91YXBpL2xpbnV4L2Jsa3pvbmVk
LmggfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrLQogNCBmaWxlcyBjaGFuZ2VkLCAzNCBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9o
b3N0L3pucy5jIGIvZHJpdmVycy9udm1lL2hvc3Qvem5zLmMKaW5kZXggZGFmMGQ5MWJjZGY2Li45
MjY5MDRkMTgyN2IgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3pucy5jCisrKyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L3pucy5jCkBAIC0xMTgsNyArMTE4LDcgQEAgaW50IG52bWVfdXBkYXRl
X3pvbmVfaW5mbyhzdHJ1Y3QgZ2VuZGlzayAqZGlzaywgc3RydWN0IG52bWVfbnMgKm5zLAogCX0K
IAogCXEtPmxpbWl0cy56b25lZCA9IEJMS19aT05FRF9ITTsKLQlxLT56b25lX2ZsYWdzID0gQkxL
X1pPTkVfUkVQX0NBUEFDSVRZIHwgQkxLX1pPTkVfU1VQX09GRkxJTkU7CisJcS0+em9uZV9mbGFn
cyA9IEJMS19aT05FX1JFUF9DQVBBQ0lUWSB8IEJMS19aT05FX1JFUF9DQVBBQ0lUWSB8IEJMS19a
T05FX1NVUF9PRkZMSU5FOwogCWJsa19xdWV1ZV9mbGFnX3NldChRVUVVRV9GTEFHX1pPTkVfUkVT
RVRBTEwsIHEpOwogZnJlZV9kYXRhOgogCWtmcmVlKGlkKTsKQEAgLTE5Nyw2ICsxOTcsNyBAQCBz
dGF0aWMgaW50IG52bWVfem9uZV9wYXJzZV9lbnRyeShzdHJ1Y3QgbnZtZV9ucyAqbnMsCiAJem9u
ZS5jYXBhY2l0eSA9IG52bWVfbGJhX3RvX3NlY3QobnMsIGxlNjRfdG9fY3B1KGVudHJ5LT56Y2Fw
KSk7CiAJem9uZS5zdGFydCA9IG52bWVfbGJhX3RvX3NlY3QobnMsIGxlNjRfdG9fY3B1KGVudHJ5
LT56c2xiYSkpOwogCXpvbmUud3AgPSBudm1lX2xiYV90b19zZWN0KG5zLCBsZTY0X3RvX2NwdShl
bnRyeS0+d3ApKTsKKwl6b25lLmF0dHIgPSBlbnRyeS0+emE7CiAKIAlyZXR1cm4gY2IoJnpvbmUs
IGlkeCwgZGF0YSk7CiB9CmRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvc2QuYyBiL2RyaXZlcnMv
c2NzaS9zZC5jCmluZGV4IGI5YzkyMGJhY2UyOC4uNjMyNzA1OThhYTc2IDEwMDY0NAotLS0gYS9k
cml2ZXJzL3Njc2kvc2QuYworKysgYi9kcml2ZXJzL3Njc2kvc2QuYwpAQCAtMjk2Nyw3ICsyOTY3
LDcgQEAgc3RhdGljIHZvaWQgc2RfcmVhZF9ibG9ja19jaGFyYWN0ZXJpc3RpY3Moc3RydWN0IHNj
c2lfZGlzayAqc2RrcCkKIAlpZiAoc2RrcC0+ZGV2aWNlLT50eXBlID09IFRZUEVfWkJDKSB7CiAJ
CS8qIEhvc3QtbWFuYWdlZCAqLwogCQlxLT5saW1pdHMuem9uZWQgPSBCTEtfWk9ORURfSE07Ci0J
CXEtPnpvbmVfZmxhZ3MgPSBCTEtfWk9ORV9SRVBfQ0FQQUNJVFk7CisJCXEtPnpvbmVfZmxhZ3Mg
PSBCTEtfWk9ORV9SRVBfQ0FQQUNJVFkgfCBCTEtfWk9ORV9SRVBfQVRUUjsKIAl9IGVsc2Ugewog
CQlzZGtwLT56b25lZCA9IChidWZmZXJbOF0gPj4gNCkgJiAzOwogCQlpZiAoc2RrcC0+em9uZWQg
PT0gMSAmJiAhZGlza19oYXNfcGFydGl0aW9ucyhzZGtwLT5kaXNrKSkgewpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9zY3NpL3NkX3piYy5jIGIvZHJpdmVycy9zY3NpL3NkX3piYy5jCmluZGV4IDE4M2Ey
MDcyMGRhOS4uNTFjN2Y4MmI1OWM1IDEwMDY0NAotLS0gYS9kcml2ZXJzL3Njc2kvc2RfemJjLmMK
KysrIGIvZHJpdmVycy9zY3NpL3NkX3piYy5jCkBAIC01MywxMCArNTMsMTQgQEAgc3RhdGljIGlu
dCBzZF96YmNfcGFyc2VfcmVwb3J0KHN0cnVjdCBzY3NpX2Rpc2sgKnNka3AsIHU4ICpidWYsCiAK
IAl6b25lLnR5cGUgPSBidWZbMF0gJiAweDBmOwogCXpvbmUuY29uZCA9IChidWZbMV0gPj4gNCkg
JiAweGY7Ci0JaWYgKGJ1ZlsxXSAmIDB4MDEpCisJaWYgKGJ1ZlsxXSAmIDB4MDEpIHsKKwkJem9u
ZS5hdHRyIHw9IEJMS19aT05FX0FUVFJfTlJXOwogCQl6b25lLnJlc2V0ID0gMTsKLQlpZiAoYnVm
WzFdICYgMHgwMikKKwl9CisJaWYgKGJ1ZlsxXSAmIDB4MDIpIHsKKwkJem9uZS5hdHRyIHw9IEJM
S19aT05FX0FUVFJfTlNROwogCQl6b25lLm5vbl9zZXEgPSAxOworCX0KIAogCXpvbmUubGVuID0g
bG9naWNhbF90b19zZWN0b3JzKHNkcCwgZ2V0X3VuYWxpZ25lZF9iZTY0KCZidWZbOF0pKTsKIAl6
b25lLmNhcGFjaXR5ID0gem9uZS5sZW47CmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgv
Ymxrem9uZWQuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5oCmluZGV4IDhiN2M0NzA1
Y2VmNy4uYjQ4YjhjYjEyOWEyIDEwMDY0NAotLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvYmxrem9u
ZWQuaAorKysgYi9pbmNsdWRlL3VhcGkvbGludXgvYmxrem9uZWQuaApAQCAtNzcsMTYgKzc3LDM5
IEBAIGVudW0gYmxrX3pvbmVfY29uZCB7CiAgKiBlbnVtIGJsa196b25lX3JlcG9ydF9mbGFncyAt
IEZlYXR1cmUgZmxhZ3Mgb2YgcmVwb3J0ZWQgem9uZSBkZXNjcmlwdG9ycy4KICAqCiAgKiBAQkxL
X1pPTkVfUkVQX0NBUEFDSVRZOiBab25lIGRlc2NyaXB0b3IgaGFzIGNhcGFjaXR5IGZpZWxkLgor
ICogQEJMS19aT05FX1JFUF9BVFRSOiBab25lIGF0dHJpYnV0ZXMgcmVwb3J0ZWQuCiAgKiBAQkxL
X1pPTkVfU1VQX09GRkxJTkUgOiBab25lIGRldmljZSBzdXBwb3J0cyBleHBsaWNpdCBvZmZsaW5l
IHRyYW5zaXRpb24uCiAgKi8KIGVudW0gYmxrX3pvbmVfcmVwb3J0X2ZsYWdzIHsKIAkvKiBSZXBv
cnQgZmVhdHVyZSBmbGFncyAqLwogCUJMS19aT05FX1JFUF9DQVBBQ0lUWQk9ICgxIDw8IDApLAor
CUJMS19aT05FX1JFUF9BVFRSCT0gKDEgPDwgMiksCiAKIAkvKiBTdXBwb3J0ZWQgY2FwYWJpbGl0
aWVzICovCiAJQkxLX1pPTkVfU1VQX09GRkxJTkUJPSAoMSA8PCAxKSwKIH07CiAKKy8qKgorICog
ZW51bSBibGtfem9uZV9hdHRyIC0gWm9uZSBBdHRyaWJ1dGVzCisgKgorICogQXR0cmlidXRlcyBv
ZiB0aGUgem9uZS4gUmVwb3J0ZWQgaW4gc3RydWN0IGJsa196b25lIC0+IGF0dHIKKyAqCisgKiBA
QkxLX1pPTkVfQVRUUl9aRkM6IFpvbmUgRmluaXNoZWQgYnkgQ29udHJvbGxlciBkdWUgdG8gYSB6
b25lIGFjdGl2ZSBleGN1cnNpb24KKyAqIEBCTEtfWk9ORV9BVFRSX0ZaUjogRmluaXNoIFpvbmUg
UmVjb21tZW5kZWQgcmVxdWlyZWQgYnkgY29udHJvbGxlcgorICogQEJMS19aT05FX0FUVFJfUlpS
OiBSZXNldCBab25lIFJlY29tbWVuZGVkIHJlcXVpcmVkIGJ5IGNvbnRyb2xsZXIKKyAqIEBCTEtf
Wk9ORV9BVFRSX05TUTogTm9uIFNlcXVlbnRpYWwgem9uZQorICogQEJMS19aT05FX0FUVFJfTlJX
OiBOZWVkIFJlc2V0IFdyaXRlIFBvaW50ZXIgcmVxdWlyZWQgYnkgY29udHJvbGxlcgorICogQEJM
S19aT05FX0FUVFJfWkRFVjogWm9uZSBEZXNjcmlwdG9yIEV4dGVuc2lvbiBWYWxpZCBpbiB6b25l
IHJlcG9ydAorICovCitlbnVtIGJsa196b25lX2F0dHIgeworCUJMS19aT05FX0FUVFJfWkZDCT0g
MSA8PCAwLAorCUJMS19aT05FX0FUVFJfRlpSCT0gMSA8PCAxLAorCUJMS19aT05FX0FUVFJfUlpS
CT0gMSA8PCAyLAorCUJMS19aT05FX0FUVFJfTlNRCT0gMSA8PCAzLAorCUJMS19aT05FX0FUVFJf
TlJXCT0gMSA8PCA0LAorCUJMS19aT05FX0FUVFJfWkRFVgk9IDEgPDwgNywKK307CisKIC8qKgog
ICogc3RydWN0IGJsa196b25lIC0gWm9uZSBkZXNjcmlwdG9yIGZvciBCTEtSRVBPUlRaT05FIGlv
Y3RsLgogICoKQEAgLTExMyw3ICsxMzYsOCBAQCBzdHJ1Y3QgYmxrX3pvbmUgewogCV9fdTgJY29u
ZDsJCS8qIFpvbmUgY29uZGl0aW9uICovCiAJX191OAlub25fc2VxOwkvKiBOb24tc2VxdWVudGlh
bCB3cml0ZSByZXNvdXJjZXMgYWN0aXZlICovCiAJX191OAlyZXNldDsJCS8qIFJlc2V0IHdyaXRl
IHBvaW50ZXIgcmVjb21tZW5kZWQgKi8KLQlfX3U4CXJlc3ZbNF07CisJX191OAlhdHRyOwkJLyog
Wm9uZSBhdHRyaWJ1dGVzICovCisJX191OAlyZXN2WzNdOwogCV9fdTY0CWNhcGFjaXR5OwkvKiBa
b25lIGNhcGFjaXR5IGluIG51bWJlciBvZiBzZWN0b3JzICovCiAJX191OAlyZXNlcnZlZFsyNF07
CiB9OwotLSAKMi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
bnZtZQo=
