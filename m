Return-Path: <SRS0=yxkO=HX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0603C433E9
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Feb 2021 05:13:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3459C64ED7
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Feb 2021 05:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3459C64ED7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=pr.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vW8AZwTcPDlxwH5x/J0UxUQWcNdmaDx0LXwL1sfzUsA=; b=u2G/41lD/Mcy9qSrBx3OFjzWkV
	I9pGmxgS7kz7WaX8TmECaSv4HYAWcRBC3O5s1aJiMbdrlzWdZS7S9XgKD9lsqr1K7wJcPPH1XiT/R
	RUjia2qSfvBRi/vYQC/e/JKYvZh3QIKQyTxAf8FhReV9t1WsyhVKtf0Z7zgB9JvP+dC36CpcPEYZd
	CKl+TpRgrE3RY7L6ZI++qliLzv/2r8ykR4wejPO/R2JBMk8zzRYPVUUIVyBwPOS9cWVvN/f+vfAQk
	VOjGDIdUx0CKAV4sMzjPDHdsjo8YYyOm/GYH5wGCRIRY0/IcnUx4K9m9m8ClGnqPHrLaOwLTZG4X+
	0P0dlGyg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lDh3E-00048N-Ir; Sun, 21 Feb 2021 05:13:00 +0000
Received: from frontdoor.pr.hu ([2a02:808:3:101:250:56ff:fe8e:1370])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lDh31-00047F-8V
 for linux-nvme@lists.infradead.org; Sun, 21 Feb 2021 05:12:48 +0000
Received: from [2a02:808:3:101::5] (helo=mail.pr.hu)
 by frontdoor.pr.hu with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <zboszor@pr.hu>)
 id 1lDh2q-0000VP-Oj; Sun, 21 Feb 2021 06:12:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pr.hu;
 s=pr20170203; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f40Fx/Hmx9xz9dKoklu7aLMqq9AlCJu/St+EpaOZARI=; b=GU4QLV+XxVaEG7rY4f3YbMTCte
 HbbHbAOLmPIMXpAoKZUjOBBB+MLSCz/n9xeGFi5+VRYuHjG9GcxYB2F0HX4By7vuRJxUS/jhqA68X
 0ujdlrNea9f+QuMrqCBnPoZXa8yIVt7tQ+25XYdXSbSj0bhh+rug86BFFsvz5uuZ61qPJSExYSTDv
 Rx7EPVkzCxpTT7XQOEcYpSYdJgaZGS4tyf+mnr3XkH2Oc1Sfhl39LncwO2UeVtE1LI9pudHzsb/lh
 4EQU4XemzW+H5sQPzAQK+/a3GX1dCb/aNgs0FigESasjWsLfisIpwLAIGjosPZZz6+JOC5wdYpBRR
 EcB9YTbQ==;
Received: from host-87-242-23-58.prtelecom.hu ([87.242.23.58]
 helo=zolilaptop.lan)
 by mail.pr.hu with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <zboszor@pr.hu>)
 id 1lDh2m-0002j6-TT; Sun, 21 Feb 2021 06:12:34 +0100
From: =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?= <zboszor@pr.hu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: Apply the same fix Kingston SKC2000 nVME SSD as A2000
Date: Sun, 21 Feb 2021 06:12:16 +0100
Message-Id: <20210221051216.3398620-1-zboszor@pr.hu>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-Scan-Signature: dda648b1d3e643e91fd1a0320e0a0c7d
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210221_001247_739911_776E9F2C 
X-CRM114-Status: GOOD (  11.57  )
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
Cc: gregkh@linuxfoundation.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org,
 =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?= <zboszor@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RnJvbTogWm9sdMOhbiBCw7ZzesO2cm3DqW55aSA8emJvc3pvckBnbWFpbC5jb20+CgpNeSAyVEIg
U0tDMjAwMCBzaG93ZWQgdGhlIGV4YWN0IHNhbWUgc3ltcHRvbXMgdGhhdCB3ZXJlIHByb3ZpZGVk
CmluIDUzOGU0YThjNTcgKCJudm1lLXBjaTogYXZvaWQgdGhlIGRlZXBlc3Qgc2xlZXAgc3RhdGUg
b24KS2luZ3N0b24gQTIwMDAgU1NEcyIpLCBpLmUuIGEgY29tcGxldGUgTlZNRSBsb2NrdXAgdGhh
dCBuZWVkZWQKY29sZCBib290IHRvIGdldCBpdCBiYWNrLgoKQWNjb3JkaW5nIHRvIHNvbWUgc291
cmNlcywgdGhlIEEyMDAwIGlzIHNpbXBseSBhIHJlYmFkZ2VkClNLQzIwMDAgd2l0aCBhIHNsaWdo
dGx5IG9wdGltaXplZCBmaXJtd2FyZS4KCkFkZGluZyB0aGUgU0tDMjAwMCBQQ0kgSUQgdG8gdGhl
IHF1aXJrIGxpc3Qgd2l0aCB0aGUgc2FtZSB3b3JrYXJvdW5kCmFzIHRoZSBBMjAwMCBtYWRlIG15
IGxhcHRvcCBzdXJ2aXZlIGEgNSBob3VycyBsb25nIFlvY3RvIGJvb3RzdHJhcApidWlsZGZlc3Qg
d2hpY2ggcmVsaWFibHkgdHJpZ2dlcmVkIHRoZSBTU0QgbG9ja3VwIHByZXZpb3VzbHkuCgpUZXN0
ZWQgYWdhaW5zdCA1LjEwLjE3LgoKU2lnbmVkLW9mZi1ieTogWm9sdMOhbiBCw7ZzesO2cm3DqW55
aSA8emJvc3pvckBnbWFpbC5jb20+CgotLS0KIGRyaXZlcnMvbnZtZS9ob3N0L3BjaS5jIHwgMiAr
KwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bnZtZS9ob3N0L3BjaS5jIGIvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMKaW5kZXggNGEzMzI4Ny4u
M2FmNmE5NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMKKysrIGIvZHJpdmVy
cy9udm1lL2hvc3QvcGNpLmMKQEAgLTMyNjQsNiArMzI2NCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgcGNpX2RldmljZV9pZCBudm1lX2lkX3RhYmxlW10gPSB7CiAJCS5kcml2ZXJfZGF0YSA9IE5W
TUVfUVVJUktfRElTQUJMRV9XUklURV9aRVJPRVMsIH0sCiAJeyBQQ0lfREVWSUNFKDB4MTViNywg
MHgyMDAxKSwgICAvKiAgU2FuZGlzayBTa3loYXdrICovCiAJCS5kcml2ZXJfZGF0YSA9IE5WTUVf
UVVJUktfRElTQUJMRV9XUklURV9aRVJPRVMsIH0sCisJeyBQQ0lfREVWSUNFKDB4MjY0NiwgMHgy
MjYyKSwgICAvKiBLSU5HU1RPTiBTS0MyMDAwIE5WTWUgU1NEICAqLworCQkuZHJpdmVyX2RhdGEg
PSBOVk1FX1FVSVJLX05PX0RFRVBFU1RfUFMsIH0sCiAJeyBQQ0lfREVWSUNFKDB4MjY0NiwgMHgy
MjYzKSwgICAvKiBLSU5HU1RPTiBBMjAwMCBOVk1lIFNTRCAgKi8KIAkJLmRyaXZlcl9kYXRhID0g
TlZNRV9RVUlSS19OT19ERUVQRVNUX1BTLCB9LAogCXsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lE
X0FQUExFLCAweDIwMDEpLAotLSAKMi4yOS4yCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbnZtZQo=
