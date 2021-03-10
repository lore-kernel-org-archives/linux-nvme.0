Return-Path: <SRS0=Sfb4=II=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B68C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 20:49:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B42F64FB3
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 20:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B42F64FB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PDPNjrQCi2Jwv8SncZ01xT61VJGjOMyM2tIqR/bO70I=; b=U64x8sHQ8H2ZyuXkaRI0lS2nU
	kGm4Jm3Q0BXokDSfLRexMGoU2j6EzGXa19qKfYrAbySet2j0kjeF+GMVkLIWA2gsXtNgjtOnRHDYJ
	c1mnepb22X4C8TDRL5GTNgjmiKOocJwUhLsaB6vJ3CuWImZJpBVMnITFouK0NTQvyed9Yoi+8BQHV
	Q2pgSV7SdIghQ1sOKEn8hXS6Xa06DNVma+DMfIlOWp4dex0/ytRoMLwi0Y2+Bt5rC/uk/Uc1plGyr
	KUZDg7jmoqCC2lNp7AxxVKvVFqds2vQM502AAXaBqH55xhZyNUrJLQQMqq0r9Ygq1JVZEk8bqDagC
	tm4IYhbEg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lK5lI-007hBr-GI; Wed, 10 Mar 2021 20:48:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lK5lB-007hBH-Md
 for linux-nvme@lists.infradead.org; Wed, 10 Mar 2021 20:48:53 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id D61DD64FAF;
 Wed, 10 Mar 2021 20:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615409327;
 bh=KjuIxZCuHxJ7vhdQ55LjNl6m3v2e1qI6ZsgRXC59Qbc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GTqRFGMMSbV7PZgU68zhWRnUBVCDdJf9lMrbqPz5mSEyOAsffVLBOfTEFN4knkI7g
 +7mBPVY936BwFmD0+55fPz/hXY4ihmWSxD4ySYi6srzvWtOyfyzTryz+9GsnB5ZBbj
 hGkKZLHH4fcnvOSaWHK8yeReQYcLUwTtqfvL9musAmPDW6atDQ78wL7GbqWau+RSfc
 FsSkE5bBmVz8oh8AsE48qzOVALih3hTcBlLs5xUYzcdN2tWp0b8RWh9B9xyjuLtOcH
 HeYPsP/MjrMGDO/R7heko7Nn1woClNxqFQ6HFMw1+syKX+Jn1ovln5iF2dklLh9RLg
 7Hdg0JF7tX4PQ==
Date: Wed, 10 Mar 2021 12:48:44 -0800
From: Keith Busch <kbusch@kernel.org>
To: Tony Asleson <tasleson@redhat.com>
Cc: linux-nvme@lists.infradead.org, Tomas Bzatek <tbzatek@redhat.com>
Subject: Re: libnvme questions
Message-ID: <20210310204844.GC3377333@dhcp-10-100-145-180.wdc.com>
References: <245fc813-9441-56d8-47e2-4417fc1f87e7@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <245fc813-9441-56d8-47e2-4417fc1f87e7@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210310_204851_729112_BC361EFB 
X-CRM114-Status: UNSURE (   9.76  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Mar 03, 2021 at 03:14:02PM -0600, Tony Asleson wrote:
> 1. There is interest in utilizing the libnvme library for some other
> projects, when is an official release of the library planned?
> 
> 2. Is it planned for nvme-cli to utilize libnvme?

This is my bad, I fell behind the task due to mutliple conflicts of
time, but I am back on this right now. The plan is to tag nvme-cli v1.14
within the next few weeks, then make the shift to libnvme integration
on a "2.0" version for future work on the master branch. This would
coincide with an official libnvme stable release.

I honestly do not have enough devices to regression test all the
features, so I will continue to maintain nvme-cli 1.x branches as long
as necessary while ironing out any integration issues.
 
> 3. Any plans on adding functionality for NVMe management interfaces to
> the library, e.g. NVMe Enclosures?

Will be happen to incorporate any features that are in-spec.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
