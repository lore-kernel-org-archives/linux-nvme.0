Return-Path: <SRS0=b72z=GS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244B4C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 03:30:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C396623AAC
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 03:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C396623AAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fLH5NJP5NmPLtARgwRYIP3bYruMfOIQt28eo4TgjCGc=; b=QsixBihmCCmzbso7JvgjQsRKl
	x6I+CetqWtAseaVkBT+gybL+ViAZ+aldycIwNwhA0VXRT3DbciYcmvePfQpIUJsdrZWX78a3n1gBu
	dr40RC5a2F2C0ODimhNxk3FZZ+RvfmKylF7aGwAii4NFSgtl+S8KxPY7ntsuTUusSLYTckAYzGgtJ
	cTQRFPeubKUgbQ0VdlPr5nEMRlGj6M1KaKC89Wpf4NBA06K8dIuELx2AHIF8xHVALsUGsS8aPs7dY
	G/mGyNb+NiqrJR16ZklgQaMdhJ0yWOeaNnMEYo3PMhw6KE1BlivO5F4861XWaqtmgiGcV0ShMrOGN
	p+cAUOtdA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l0Fod-0004LU-CB; Fri, 15 Jan 2021 03:30:23 +0000
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0Foa-0004JZ-0u
 for linux-nvme@lists.infradead.org; Fri, 15 Jan 2021 03:30:21 +0000
Received: by mail-ua1-x934.google.com with SMTP id g5so2470488uak.10
 for <linux-nvme@lists.infradead.org>; Thu, 14 Jan 2021 19:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FHB4fMBtfKDMwN9w9JdCzRXoxbs4xAQTsyrkwH5WUSA=;
 b=lDrTqRAmOyTHtKoQN7FBr4FOu44a9JPSGOR2jxU/vvAjs9jeZEuc3W9V1xmt0FAm4y
 G3WfA1n3aOtX9mKjEyYCUE9VZvpMTwtfiavn88Q54AVQBMCOk4GxxmAx0wRtpBNgE8LI
 CNjQlmVzWn/1JBrMal5k5hg0tW75iDYVZkUvyyZaHMq3XN6AjcHx6mItzPIGzZPNP67f
 1hPE2etZ+TDNEhxST75xYY4AOig8aHBAlXo+TLIBGxLhLdeE3Yfq3YbI3D21GxKKu8mq
 owD8bmtfQS+SXbQ29f9xwZhF0rqqr1SUtUldetYwhZi23VWOkr4IDKLISV5KeyuRlTNN
 /M8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FHB4fMBtfKDMwN9w9JdCzRXoxbs4xAQTsyrkwH5WUSA=;
 b=aWwnXqJ1NuC11QIfFv0iH/gJFVOQMRBC+3y7GSooJz6wpaN2aSDzyk3tTfj7+n82se
 R3KC1c/o6HvHKXvaR1cApGwtn05r9GczzzLe5nUoWnFNwzbxxFytjs3W3+adr9eek2Ue
 8RN2xrnaanGOWB8jvEh5VvVMWVgvAQpWGqZrZftw+dxkaANne1RQBTMHPStBFirWH1LY
 zvoTIQ1619pRtfnMAB6/dGCCBg9oE+cozUCiFM5BbsV4ipElpuRp/Wdn/YyLNuWXNs3N
 GDj/RLKmyELJia7lodrxcoQI1qNxIW6Am4EqebWHEouXxCJMUOU1mCeLG3Y/1t2RoMNf
 Et4w==
X-Gm-Message-State: AOAM530YN7uPjchm/CcCi3b2Kc5/TGuiGDXdLVN0Gfw7PpALRqOGYALb
 D/Ir7LOWhvziIifIKmH8UQVc1I/ppPtiLHc3Lp453w==
X-Google-Smtp-Source: ABdhPJyN0jpln82clSMDqfYY3n10nf1X2e7qZe1UJ0WGM+Ui1KmCf7Lp56vWBEt8DjaamTchOWz/xXi4HwyQ+m5Jmg0=
X-Received: by 2002:ab0:2388:: with SMTP id b8mr8290397uan.122.1610681415412; 
 Thu, 14 Jan 2021 19:30:15 -0800 (PST)
MIME-Version: 1.0
References: <20210113160621.98615-1-fengli@smartx.com>
 <SN4PR0401MB35985C08E5FFCDF0F5817A9D9BA90@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <87698545-de26-c0ca-01e9-4dc2ddcacc80@grimberg.me>
 <20210114174311.GB31188@lst.de>
In-Reply-To: <20210114174311.GB31188@lst.de>
From: Li Feng <fengli@smartx.com>
Date: Fri, 15 Jan 2021 11:30:06 +0800
Message-ID: <CAHckoCzhJVAWFSYeCAMHZ+fVqzv_1XxvM97QmvCESnEcc5AQuQ@mail.gmail.com>
Subject: Re: [PATCH] nvme: reject the ns when the block size is smaller than a
 sector
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_223020_226320_0E31BB06 
X-CRM114-Status: GOOD (  14.24  )
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
Cc: "lifeng1519@gmail.com" <lifeng1519@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Q2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+IOS6jjIwMjHlubQx5pyIMTXml6XlkajkupQg
5LiK5Y2IMTo0M+WGmemBk++8mgo+Cj4gT24gV2VkLCBKYW4gMTMsIDIwMjEgYXQgMDI6MTI6NTlQ
TSAtMDgwMCwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiA+PiBCdXQgdGhpcyBvbmx5IGNhdGNoZXMg
YSBwaHlzaWNhbCBibG9jayBzaXplIDwgNTEyIGZvciBOVk1lLCBub3QgYW55IG90aGVyIGJsb2Nr
IGRldmljZS4KPiA+Pgo+ID4+IFBsZWFzZSBmaXggaXQgZm9yIHRoZSBnZW5lcmFsIGNhc2UgaW4g
YmxrX3F1ZXVlX3BoeXNpY2FsX2Jsb2NrX3NpemUoKS4KPiA+Cj4gPiBXZSBhY3R1YWxseSBjYWxs
IHRoYXQgbGF0ZXIgYW5kIHdvdWxkIHByb2JhYmx5IGJlIGJldHRlciB0byBjaGVjayBoZXJlLi4K
Pgo+IFdlIGhhZCBhIHNlcmllcyBmb3IgdGhhdCBhIHNob3J0IHdoaWxlIGFnbyB0aGF0IGdvdCBs
b3N0LgpXaGVyZSBpcyB0aGUgc2VyaWVzPyBPciBjb3VsZCB5b3UgYWR2aXNlIG9uIGhvdyB0byBm
aXggdGhpcyBpc3N1ZSBpcyBhY2NlcHRhYmxlPwpUaGlzIGlzc3VlIHdpbGwgZ2VuZXJhdGUgYW4g
b29wcywgY2hlY2sgaXQgaGVyZToKaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjEvMS8xMi8xMDY0
CgpUaGFua3MsCkZlbmcgTGkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LW52bWUK
