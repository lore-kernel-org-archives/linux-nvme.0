Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC22C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:27:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB13A207E8
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2z9Zzq+r";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mP1S9u/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB13A207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:Subject:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uu99J8wFkL8kJtSFLIaXY2meZxCqfvY3+hSR9be+aKM=; b=2z9Zzq+rRcSr+7yJNZYJEatQK
	eCN7TikP6RePDpKUs1ZLs0RKtgkwoinYnbfAvSn6nFffsEXhHK6XjLLBzQ1k6SUFu525wXhK0wSty
	FLy0+ufucNsiAfb+k14y5Zzcr5GO7pjLJFAjFTdPKFXqp7LBiFhuBjQbAv6efP5EBB6Mn9rFZlTFE
	NBK+G0zLKLEar72AUsXzKDskJ16TaRFl3rGQuqvxoN5MA8/ZZfj8fjiYE6kr6kxOIMMVtNIOX6nnf
	tHEnzmnBASkuJY8xoIR+weZCHVNjBFz1yB4k7xcm1XcS50eZPJZ6NryEvSF6X6xfP9qWwU3l/HvPW
	If7mnxE5w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jonSP-00067R-WF; Fri, 26 Jun 2020 12:27:50 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jonIc-000139-78
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 12:17:44 +0000
Received: by mail-pj1-x102b.google.com with SMTP id i4so4884209pjd.0
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 05:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=978wLGVs1UC0lJ8/UvI6dYC0JDFg86w7Psh56SEUsW4=;
 b=mP1S9u/ZP5t6Z5fMrN3Ihm2rY4U6g4Q26beF94BXeqc8ZJwRS+ddvwFowrq8K9mTyw
 qhS2Wlgq9pWgcAXLYgEF4EgVYV148MF3JpO9fcvczi/2drR00Ua0LEKV7Dyz472qCJuC
 xu7pEg7dMqW+xDdMP5FoSb6H/SAe6gYw34gWpjRoVFMR1HAmL92sSj7IUjP+pX817TY+
 oTByj/mz+mnUz1ZmRiSGOCiOZo9zeoFynymOkbhKLKErVe4MyfaHltJZrHuiKjDRYQ69
 65vUQtHiYkBLUKDz7UQ0tg07MK5nhgdiJg11JacdKZyZxvn8cVxaSArgzoHQN59ArS7X
 Ip/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=978wLGVs1UC0lJ8/UvI6dYC0JDFg86w7Psh56SEUsW4=;
 b=UZGt/ft9xcMcDr+r8D4V12krzw5ame+m/68xMIiUhMM062f4yGj1Cr9sk4bfTCVYPc
 7Hbu92SRhUts924JxmqLQHSypSXITrLoSD5YA4pI0vyBgCyEB4lwOsoOPNfMiS19OOyG
 BcrBvhH46jDm7nByYVU8w2F4pUEkuV/zDMQ/4uTMoLUSyXE+i6k0tBq/XOZOmLBxad9Q
 OHPOEnm/wPsfmWTCVY/zgjNJzdzN+wkpRlLYpIsdSDtES3I/0/BjxhHu7bsI3bzkqfZa
 KTMC9lwaNCDVOcycbTQPZSpNghMsOv5N0eIBUU+fcb8grjLFa2rozeXjc/TCwvmEzx99
 pSkA==
X-Gm-Message-State: AOAM533F4ig/g7uBvl8yALiXX35y/eSCWUNzbuGzuZCA7RpbnbCToe2l
 IxSJ4x68M5PGL2ig6WswwEnTZw==
X-Google-Smtp-Source: ABdhPJyAmSzV3UZfOD2Vf6pE6gjQKxRa7NlRNPAajR7KgCaVgF0iQhcU2RM6EorPKlaqFNy8cRcMjw==
X-Received: by 2002:a17:90a:c84:: with SMTP id v4mr2944021pja.7.1593173857993; 
 Fri, 26 Jun 2020 05:17:37 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id j21sm4858445pfa.133.2020.06.26.05.17.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 05:17:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHv3 1/5] block: add capacity field to zone descriptors
To: Keith Busch <kbusch@kernel.org>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-2-kbusch@kernel.org>
Message-ID: <1a272c03-050c-8a59-f767-cc2170f4c377@kernel.dk>
Date: Fri, 26 Jun 2020 06:17:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622162530.1287650-2-kbusch@kernel.org>
Content-Language: en-US
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
Cc: sagig <sagi@grimberg.me>, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Daniel Wagner <dwagner@suse.de>, Linux NVMe <linux-nvme@lists.infradead.org>,
 linux-block <linux-block@vger.kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 Christoph Hellwig <hch@lst.de>,
 =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBKdW4gMjIsIDIwMjAgYXQgMTA6MjUgQU0gS2VpdGggQnVzY2ggPGtidXNjaEBrZXJu
ZWwub3JnPiB3cm90ZToKPgo+IEZyb206IE1hdGlhcyBCasO4cmxpbmcgPG1hdGlhcy5iam9ybGlu
Z0B3ZGMuY29tPgo+Cj4gSW4gdGhlIHpvbmVkIHN0b3JhZ2UgbW9kZWwsIHRoZSBzZWN0b3JzIHdp
dGhpbiBhIHpvbmUgYXJlIHR5cGljYWxseSBhbGwKPiB3cml0ZWFibGUuIFdpdGggdGhlIGludHJv
ZHVjdGlvbiBvZiB0aGUgWm9uZWQgTmFtZXNwYWNlIChaTlMpIENvbW1hbmQKPiBTZXQgaW4gdGhl
IE5WTSBFeHByZXNzIG9yZ2FuaXphdGlvbiwgdGhlIG1vZGVsIHdhcyBleHRlbmRlZCB0byBoYXZl
IGEKPiBzcGVjaWZpYyB3cml0ZWFibGUgY2FwYWNpdHkuCj4KPiBFeHRlbmQgdGhlIHpvbmUgZGVz
Y3JpcHRvciBkYXRhIHN0cnVjdHVyZSB3aXRoIGEgem9uZSBjYXBhY2l0eSBmaWVsZCB0bwo+IGlu
ZGljYXRlIHRvIHRoZSB1c2VyIGhvdyBtYW55IHNlY3RvcnMgaW4gYSB6b25lIGFyZSB3cml0ZWFi
bGUuCj4KPiBJbnRyb2R1Y2UgYmFja3dhcmQgY29tcGF0aWJpbGl0eSBpbiB0aGUgem9uZSByZXBv
cnQgaW9jdGwgYnkgZXh0ZW5kaW5nCj4gdGhlIHpvbmUgcmVwb3J0IGhlYWRlciBkYXRhIHN0cnVj
dHVyZSB3aXRoIGEgZmxhZ3MgZmllbGQgdG8gaW5kaWNhdGUgaWYKPiB0aGUgY2FwYWNpdHkgZmll
bGQgaXMgYXZhaWxhYmxlLgoKUmV2aWV3ZWQtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5k
az4KCi0tIApKZW5zIEF4Ym9lCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=
