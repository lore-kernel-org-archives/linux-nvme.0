Return-Path: <SRS0=w+e8=AG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA56AC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 12:22:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC5F9206EB
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 12:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0ogvmTAY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="m1E1SI7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5F9206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TCsUWCFwu/iPjxY9uB3bFaABUvjCNPDX/b/vvqOsa5M=; b=0ogvmTAYQMmOyVQsXWxjINgsGI
	cMKx0ZqAkducD2FpSvgPVmmXnPuTC+gOzDBHObS0bn573jai1mRB99Z8RMDrvhDO3F/8GuOEnFRUT
	xQJbNXyAxjQOapL7nWYEdLZ9k+7ydXGTeXGdOhC9ETUvR6ewq/f5WUvsvuBRMyBRJjm8QcL4Zs0G/
	f2H1LG2Fbu+JbpxhOn7hWYhDy+d5ROiV6X8k6x611K52olz4DxGteevcEUmQ++00+uUpHAwCuB/zC
	aBx3Z1KHKgCXLiYiuig81XVpqNDiQ/dZmTgFqPFEIiIPnRCQeSxUDRXmyHcUzu9mWLON72AbTqrKD
	torIXETg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joQtY-0001f8-08; Thu, 25 Jun 2020 12:22:20 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joQtV-0001du-GZ
 for linux-nvme@lists.infradead.org; Thu, 25 Jun 2020 12:22:18 +0000
Received: by mail-wr1-x442.google.com with SMTP id s10so5594528wrw.12
 for <linux-nvme@lists.infradead.org>; Thu, 25 Jun 2020 05:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8c99i5kWRH0gixiwS76ATmLU2DFdFXCBI5Yt4Kd+2ic=;
 b=m1E1SI7rOXU1elJos5jwy58AkSTR2KRnV4QroC873xhs2NEsEhnE40nVwqUD8kea5F
 qjZi8Lqk4IwuJCYPngFAZMepwNc1V4xt6Ex7KEGwi4Wm8j8eWK1CnZAtanHv67+SUfsO
 OizSMPEGfP7NLlfn6WjCgOCTFvUqUrrCTBAnFfVIaGMPvHLrMYtxBkj6DZcMzvZANaS6
 T+vYJtzVIYHr8vT0KvYkEZhgEXyMLToerKImY+vdwUPteJA9FS7xNBarY4ckiXksbR6u
 JGt8I/U0IthGLzw5MI6i7KU+UCesocXo1RrLSkB/ToGWLp18wV9PLdcIWgMbzBvrQ2zg
 iH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8c99i5kWRH0gixiwS76ATmLU2DFdFXCBI5Yt4Kd+2ic=;
 b=DihItr8MElgHt9G6aonRn1vHgqf8P7xZYN3ucXNzzY2Oy7ZeQfFAlyXPoHV0ILwAwo
 iM1BoMLXR0vIaFe3BMHHGM8wc+R+sys49KoZK90sgfUFxwMi0NJicsQRwQecWlL6vCtn
 2FjIqbf+M0nY8T+UCBsNDm8389C9YJJdMBsK5h3yu6aXBnQ3nTwukBaG6NXACwzpcGHx
 EAtFBjIR7FsBYaYo2SF2TOsTt2K2Wks2/nKdjKxeDDQLZbyfe1kPleTHz45NMFf0xVjg
 KEwnAuUN5OaLKLx6nLy2TX8RWRMo+gfbcK4IfWErmbmQl6bVX3fg9J1rMnUsMt/HUwXn
 O01A==
X-Gm-Message-State: AOAM531w8lrcZrNqUmV+Hz50bdkbMfdSPZo9UJYAdhMaeVD4tsAR3We5
 A3wqH8XrhwKiB4WPH8J4W48OBMz+5OoMUA==
X-Google-Smtp-Source: ABdhPJzkrMmz/kWb0Lg21iTqV4aU2Af1dmQ9dZ5s4hEkWzU8VLAKD2ZUqnL4hTTRaiMhZVhQAK0+zA==
X-Received: by 2002:a5d:4283:: with SMTP id k3mr30422914wrq.322.1593087734535; 
 Thu, 25 Jun 2020 05:22:14 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id f186sm11934307wmf.29.2020.06.25.05.22.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jun 2020 05:22:13 -0700 (PDT)
From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/6] ZNS: Extra features for current patches
Date: Thu, 25 Jun 2020 14:21:46 +0200
Message-Id: <20200625122152.17359-1-javier@javigon.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
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
Cc: axboe@kernel.dk, sagi@grimberg.me, linux-block@vger.kernel.org,
 kbusch@kernel.org,
 =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+CgpUaGlzIHBh
dGNoc2V0IGV4dGVuZHMgem9uZWQgZGV2aWNlIGZ1bmN0aW9uYWxpdHkgb24gdG9wIG9mIHRoZSBl
eGlzdGluZwp2MyBaTlMgcGF0Y2hzZXQgdGhhdCBLZWl0aCBzZW50IGxhc3Qgd2Vlay4KClBhdGNo
ZXMgMS01IGFyZSB6b25lZCBibG9jayBpbnRlcmZhY2UgYW5kIElPQ1RMIGFkZGl0aW9ucyB0byBl
eHBvc2UgWk5TCnZhbHVlcyB0byB1c2VyLXNwYWNlLiBPbmUgbWFqb3IgY2hhbmdlIGlzIHRoZSBh
ZGRpdGlvbiBvZiBhIG5ldyB6b25lCm1hbmFnZW1lbnQgSU9DVEwgdGhhdCBhbGxvd3MgdG8gZXh0
ZW5kIHpvbmUgbWFuYWdlbWVudCBjb21tYW5kcyB3aXRoCmZsYWdzLiBJIHJlY2FsbCBhIGNvbnZl
cnNhdGlvbiBpbiB0aGUgbWFpbGluZyBsaXN0IGZyb20gZWFybHkgdGhpcyB5ZWFyCndoZXJlIGEg
c2ltaWxhciBhcHByb2FjaCB3YXMgcHJvcG9zZWQgYnkgTWF0aWFzLCBidXQgbmV2ZXIgbWFkZSBp
dAp1cHN0cmVhbS4gV2UgZXh0ZW5kZWQgdGhlIElPQ1RMIGhlcmUgdG8gYWxpZ24gd2l0aCB0aGUg
Y29tbWVudHMgaW4gdGhhdAp0aHJlYWQuIEhlcmUsIHdlIGFyZSBoYXBweSB0byBnZXQgc2lnbi1v
ZmZzIGJ5IGFueW9uZSB0aGF0IGNvbnRyaWJ1dGVkCnRvIHRoZSB0aHJlYWQgLSBqdXN0IGNvbW1l
bnQgaGVyZSBvciBvbiB0aGUgcGF0Y2guCgpQYXRjaCA2IGlzIG52bWUtb25seSBhbmQgYWRkcyBh
biBleHRyYSBjaGVjayB0byB0aGUgWk5TIHJlcG9ydCBjb2RlIHRvCmVuc3VyZSBjb25zaXN0ZW5j
eSBvbiB0aGUgem9uZSBjb3VudC4KClRoZSBwYXRjaGVzIGFwcGx5IG9uIHRvcCBvZiBKZW5zJyBi
bG9jay01LjggKyBLZWl0aCdzIFYzIFpOUyBwYXRjaGVzLgoKVGhhbmtzLApKYXZpZXIKCkphdmll
ciBHb256w6FsZXogKDYpOgogIGJsb2NrOiBpbnRyb2R1Y2UgSU9DVEwgZm9yIHpvbmUgbWdtdAog
IGJsb2NrOiBhZGQgc3VwcG9ydCBmb3Igc2VsZWN0aW5nIGFsbCB6b25lcwogIGJsb2NrOiBhZGQg
c3VwcG9ydCBmb3Igem9uZSBvZmZsaW5lIHRyYW5zaXRpb24KICBibG9jazogaW50cm9kdWNlIElP
Q1RMIHRvIHJlcG9ydCBkZXYgcHJvcGVydGllcwogIGJsb2NrOiBhZGQgem9uZSBhdHRyLiB0byB6
b25lIG1nbXQgSU9DVEwgc3RydWN0CiAgbnZtZTogQWRkIGNvbnNpc3RlbmN5IGNoZWNrIGZvciB6
b25lIGNvdW50CgogYmxvY2svYmxrLWNvcmUuYyAgICAgICAgICAgICAgfCAgIDIgKwogYmxvY2sv
YmxrLXpvbmVkLmMgICAgICAgICAgICAgfCAxMDggKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLQogYmxvY2svaW9jdGwuYyAgICAgICAgICAgICAgICAgfCAgIDQgKysKIGRyaXZlcnMv
bnZtZS9ob3N0L2NvcmUuYyAgICAgIHwgICA1ICsrCiBkcml2ZXJzL252bWUvaG9zdC9udm1lLmgg
ICAgICB8ICAxMSArKysrCiBkcml2ZXJzL252bWUvaG9zdC96bnMuYyAgICAgICB8ICA2OSArKysr
KysrKysrKysrKysrKysrKysrCiBpbmNsdWRlL2xpbnV4L2Jsa190eXBlcy5oICAgICB8ICAgNiAr
LQogaW5jbHVkZS9saW51eC9ibGtkZXYuaCAgICAgICAgfCAgMTkgKysrKystCiBpbmNsdWRlL3Vh
cGkvbGludXgvYmxrem9uZWQuaCB8ICA2OSArKysrKysrKysrKysrKysrKysrKystCiA5IGZpbGVz
IGNoYW5nZWQsIDI4OSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKLS0gCjIuMTcuMQoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
