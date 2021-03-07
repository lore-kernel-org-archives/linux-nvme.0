Return-Path: <SRS0=8cAR=IF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6EDC433E0
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Mar 2021 13:58:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E196B65104
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Mar 2021 13:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E196B65104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kw4GzdeYon3viFiLjoPyF7adrubU95q41IrkJIv8LmQ=; b=PyUdqXrRxY32T2mBPanH+cGG6
	wNGk6znMr4kMtcKc6Kr/SBliECdwyPzaF767voRaYINY1zM+YJMJeNF7wQht7Oxb3kOBetEMo1pnF
	0GoQ9bmbFeyDlVPRApjs6DnVIEGzh/J4EmC/5ZGXDFADftH77cgSkef8zIjd66OuIQKYp43tb8cTP
	gJPyfUDq4xfBChGZL98ps5TX1Tj8o7AQFHmFY2O3eghrmLWJ7Sj6/42FhU3txLjK0xHCYKH3ragnp
	Qc1JhEEnLnhwF9CEJ14fA2/WQPchC1p59IVXHsq6ozExdoS9r/OWGWYTwREmJ58Hin837OOoMKCHE
	dk/VL2LFw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lItvI-00AJB6-Ky; Sun, 07 Mar 2021 13:58:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lItuy-00AJ2J-4j
 for linux-nvme@lists.infradead.org; Sun, 07 Mar 2021 13:58:02 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCD8564EE6;
 Sun,  7 Mar 2021 13:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615125477;
 bh=1ES4PPvD+5KQp4HDC3M1PufT+RVzP3FwrXVx+11QKjk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eJR8wUIFb2tSVjuUhmZU6S8RpYDd+F+/lS2mK5fVjZkREYzDNv9cef0wPVHVKnGJ2
 mEA7V5SshkQByBGIozzECbY1aFXHNGeNwyHuZdWOSTQRjawNwuAfd9y/Dk5ZhZt7e7
 5hI/EtJo+dcBiUZ8y2EpFIDdo9nvtCMG+E5fFEkElCh0WtOYZDHOppHnBCQRQGQMfs
 08dkj5vYIqyY7wrnEkkY2hvvNcujVYyWtpiVFGeBS79bn/vnHsHkMYeNi/OPXaRUdI
 Imjysumzpm1e3t7AM+sUE3mHvg7nMNknE01O8fJL/9/TjDodksoNKdR9VgJLxkBmMx
 Jlqos+5EzJyyw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?= <zboszor@gmail.com>, 
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.11 09/12] nvme-pci: mark Kingston SKC2000 as not
 supporting the deepest power state
Date: Sun,  7 Mar 2021 08:57:43 -0500
Message-Id: <20210307135746.967418-9-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210307135746.967418-1-sashal@kernel.org>
References: <20210307135746.967418-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210307_135800_490915_A25197C8 
X-CRM114-Status: GOOD (  11.03  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RnJvbTogWm9sdMOhbiBCw7ZzesO2cm3DqW55aSA8emJvc3pvckBnbWFpbC5jb20+CgpbIFVwc3Ry
ZWFtIGNvbW1pdCBkYzIyYzFjMDU4YjVjNGZlOTY3YTIwNTg5ZTM2ZjAyOWVlNDJhNzA2IF0KCk15
IDJUQiBTS0MyMDAwIHNob3dlZCB0aGUgZXhhY3Qgc2FtZSBzeW1wdG9tcyB0aGF0IHdlcmUgcHJv
dmlkZWQKaW4gNTM4ZTRhOGM1NyAoIm52bWUtcGNpOiBhdm9pZCB0aGUgZGVlcGVzdCBzbGVlcCBz
dGF0ZSBvbgpLaW5nc3RvbiBBMjAwMCBTU0RzIiksIGkuZS4gYSBjb21wbGV0ZSBOVk1FIGxvY2t1
cCB0aGF0IG5lZWRlZApjb2xkIGJvb3QgdG8gZ2V0IGl0IGJhY2suCgpBY2NvcmRpbmcgdG8gc29t
ZSBzb3VyY2VzLCB0aGUgQTIwMDAgaXMgc2ltcGx5IGEgcmViYWRnZWQKU0tDMjAwMCB3aXRoIGEg
c2xpZ2h0bHkgb3B0aW1pemVkIGZpcm13YXJlLgoKQWRkaW5nIHRoZSBTS0MyMDAwIFBDSSBJRCB0
byB0aGUgcXVpcmsgbGlzdCB3aXRoIHRoZSBzYW1lIHdvcmthcm91bmQKYXMgdGhlIEEyMDAwIG1h
ZGUgbXkgbGFwdG9wIHN1cnZpdmUgYSA1IGhvdXJzIGxvbmcgWW9jdG8gYm9vdHN0cmFwCmJ1aWxk
ZmVzdCB3aGljaCByZWxpYWJseSB0cmlnZ2VyZWQgdGhlIFNTRCBsb2NrdXAgcHJldmlvdXNseS4K
ClNpZ25lZC1vZmYtYnk6IFpvbHTDoW4gQsO2c3rDtnJtw6lueWkgPHpib3N6b3JAZ21haWwuY29t
PgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KU2lnbmVkLW9m
Zi1ieTogU2FzaGEgTGV2aW4gPHNhc2hhbEBrZXJuZWwub3JnPgotLS0KIGRyaXZlcnMvbnZtZS9o
b3N0L3BjaS5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jIGIvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMK
aW5kZXggN2EzOGQ3NjRiNDg2Li4xNGM1YjUyNDAwZWYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZt
ZS9ob3N0L3BjaS5jCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jCkBAIC0zMjYyLDYgKzMy
NjIsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgbnZtZV9pZF90YWJsZVtd
ID0gewogCQkuZHJpdmVyX2RhdGEgPSBOVk1FX1FVSVJLX0RJU0FCTEVfV1JJVEVfWkVST0VTLCB9
LAogCXsgUENJX0RFVklDRSgweDFkOTcsIDB4MjI2MyksICAgLyogU1BDQyAqLwogCQkuZHJpdmVy
X2RhdGEgPSBOVk1FX1FVSVJLX0RJU0FCTEVfV1JJVEVfWkVST0VTLCB9LAorCXsgUENJX0RFVklD
RSgweDI2NDYsIDB4MjI2MiksICAgLyogS0lOR1NUT04gU0tDMjAwMCBOVk1lIFNTRCAqLworCQku
ZHJpdmVyX2RhdGEgPSBOVk1FX1FVSVJLX05PX0RFRVBFU1RfUFMsIH0sCiAJeyBQQ0lfREVWSUNF
KDB4MjY0NiwgMHgyMjYzKSwgICAvKiBLSU5HU1RPTiBBMjAwMCBOVk1lIFNTRCAgKi8KIAkJLmRy
aXZlcl9kYXRhID0gTlZNRV9RVUlSS19OT19ERUVQRVNUX1BTLCB9LAogCXsgUENJX0RFVklDRShQ
Q0lfVkVORE9SX0lEX0FQUExFLCAweDIwMDEpLAotLSAKMi4zMC4xCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QK
TGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
