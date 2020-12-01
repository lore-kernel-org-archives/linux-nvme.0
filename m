Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A153FC64E7A
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 20:45:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5C52151B
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 20:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="z0ZeEXL5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="cSxy1C0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5C52151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2KNv1PyxyXsGXSne6KPZv7jy+BJm9LVrDtjiBpbErGY=; b=z0ZeEXL538hH70jTGtelfGB6f
	ccSn1/GFB9+iAMiX5bEdDBYLEkCqH0alqtAQze6t5DHVuRkSfgPxrtgeo1U7IKB2W0v7PF1KwukS1
	3pBdU+H0/27zluJYSWtGAY/4xJxDqZSIc3Qnj62ov89hcaKptCTlttWsjZtrdeYX3dPNIontM4jaR
	1gMjHRxjIADCBwXrrui1rZGjJU2B0x6dXfErf4C3ppYFy/3OY5vfEXSSe4BPOV2OfNejJfwJmqrKi
	nExMpln7xJq6K0ctvCdW5IWT/PWYwZtpSdLCgVtLJhfwiWuAozlUKFlMOKGj/HvRblY1TLor7cQIJ
	RZ4MeuCZw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkCWF-0007KX-DV; Tue, 01 Dec 2020 20:45:03 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkCWA-0007JR-QL
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 20:45:00 +0000
Received: by mail-ed1-x543.google.com with SMTP id d18so5427088edt.7
 for <linux-nvme@lists.infradead.org>; Tue, 01 Dec 2020 12:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=NmOstAzoE1wzkZ59zT3uONq7HE1n7Ff0vJ4qXFAyQoM=;
 b=cSxy1C0NaNS/QCcH2pyc47tStkEcVwFkupq4B68yoNNltqmatQK8iadY1Kma+5J3Ka
 cYqqXvJNyC7+nrexqxpNE1QTiggX2QtRDoIbILkdlzSSePJkqeqHQT5hyyzaeU5HMMOC
 Wxxvf4F5gkB4+I1qiJWQf1hx1WZ6A5pnx2+EGzte4QM2bbmXkz6TpSh6JMmJv3hdqWZC
 UDmaP4zDF0MGIF+L65+gzBpcTZllwWuj9UHff0/KsA5uykyMfZXqFI0KvOu+iY38TqSK
 OPn2Y+7ltsOxBmkG4JxcQNDcWuwW+yNJO1XFxek/6V2UqvxbXHvDUYXVsE/PGzOuW/xx
 VkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NmOstAzoE1wzkZ59zT3uONq7HE1n7Ff0vJ4qXFAyQoM=;
 b=buPAXBNbReH7cQDTJ9gX9Rkq+ysITrKOproy4k8pUaxwwCMqGe4re4V3qkeeje7bq7
 5XMuB/LVBKOgVjD0cnefiDdMl2ZB698Fm0tekhxx38vKoe2gMP0O1NceGNT4sGTBCAMj
 VlVKnVEvlZxgk4G+nEk1WgDHE82l8eN29L015NwOwSJfNgR9m1t1Y/tkVzRFY41XKZVQ
 ntCRNH/lXFCLmlnPXoLfios8+4vd4L0Sgx4KW24djSTZCQIyF8wd6g7bXnj6cYPf0GyG
 4y0FOgyuHDGI646bIXd4jOedyEVDjUrw9xkCRb/iqU2uclpJY2EmJxc964LBEqKp1e2I
 i4WA==
X-Gm-Message-State: AOAM533BqXAip2FsC3C7dn5YTc+s3XPy9LhElo+MjmQ1AS7hNGXiz0nP
 jpK87JTqWqgy9QSXjKT1hrzUBQ==
X-Google-Smtp-Source: ABdhPJxIKppkjwxKxfiVMEBUAQqhOKwJQreGLForJIlRN/dfWK4sFkIYsAqpKTSc9pjCae5+xJyxnw==
X-Received: by 2002:a05:6402:1c96:: with SMTP id
 cy22mr4878517edb.339.1606855497384; 
 Tue, 01 Dec 2020 12:44:57 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id d6sm363069ejy.114.2020.12.01.12.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 12:44:56 -0800 (PST)
Date: Tue, 1 Dec 2020 21:44:56 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/4] nvme: enable char device per namespace
Message-ID: <20201201204456.dt2niquyaqvuci4s@MacBook-Pro.localdomain>
References: <20201201125610.17138-1-javier.gonz@samsung.com>
 <20201201125610.17138-5-javier.gonz@samsung.com>
 <CGME20201201140354eucas1p1940891b47ca0c03ea46603393c844f61@eucas1p1.samsung.com>
 <20201201140348.GA5138@localhost.localdomain>
 <20201201185732.unlurqed2kaqwjsb@MacBook-Pro.localdomain>
 <20201201193002.GB27728@redsun51.ssa.fujisawa.hgst.com>
 <20201201193823.GA3522@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201201193823.GA3522@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_154459_415181_D118B712 
X-CRM114-Status: GOOD (  22.98  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Minwoo Im <minwoo.im.dev@gmail.com>, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 01.12.2020 20:38, Christoph Hellwig wrote:
>On Wed, Dec 02, 2020 at 04:30:02AM +0900, Keith Busch wrote:
>> > > In multi-path, private namespaces for a head are not in /dev, so I don't
>> > > think this will hurt private namespaces (e.g., nvme0c0n1), But it looks
>> > > like it will make a little bit confusions between chardev and hidden blkdev.
>> > >
>> > > I don't against to update nvme-cli things also even naming conventions are
>> > > going to become different than nvmeXcYnZ.
>> >
>> > Agree. But as I understand it, Keith had a good argument to keep names
>> > aligned with the hidden bdev.
>>
>> My suggested naming makes it as obvious as possible that the character
>> device in /dev/ and the hidden block device in /sys/ are referring to
>> the same thing. What is confusing about that?

Ok. I see your point. I was thinking of the case where the multipath
bdev is also enabled so we would have the same name in different places
referring to a different device.

>>
>> > It is also true that in that comment he suggested nesting the char
>> > device in /dev/nvme
>>
>> Yeah, I'm okay with sub-directories for these special handles, but there
>> are arguments against it too. I don't feel that strongly about it either
>> way.
>
>I'd prefer different naming for the char vs the block devices.  Yes,
>this will require a little work in the userspace tools to support the
>character device, but I think it is much cleaner.
>
>Devices in subdirectories of /dev/ are very rare and keep causing problem
>with userspace tooling for the few drivers that use them, so I don't
>think they are a good idea.

Would something like nvmeXnYc work here or your prefer something
different where we need to implement new, dedicated filters for
user-space? I thing you suggested nvmegXnY at some point?

Here, the naming would be for both the char device and the sysfs
entry.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
