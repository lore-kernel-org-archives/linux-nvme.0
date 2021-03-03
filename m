Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BAAC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 20:59:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8935364EF8
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 20:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8935364EF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cX5TKSnyaQKk8oRgYYcmk7Apkudxw9wVNidgJLcQod8=; b=L2ohVaf66CrZxWbAdhcWiyvBH
	gniNNl2WhCHpNbDIA/0/cuCePtnZoVmw1xvxphOi6mguCADYhA9oAC+Xi3IjuNfXSTH7YESGv6Zob
	sf8B56ZQEVLkTAd6yeQbkXrwZlAQxljcilgQFdxUv45VWWblHZz39qzP0RgsbKUYu9sXkHH5bMOPt
	DduJQHu4P0jgBk6B97YWD1hNNfe3asyUs0euj71QiwQtktZErSH5HYqmTAz//a8FOoiVzY5vrOrqK
	7MlxrK/XfNXX2z75h3j4SxYun9/qHZR9o/nCL+73lHNuYC5lVzSYHI+MsjdFTO8RKOnpTyGV8fo7M
	IDp2WJ6VA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHYaA-006VwV-OV; Wed, 03 Mar 2021 20:58:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHT7U-005JPk-H2
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 15:09:02 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71A6D64EF3;
 Wed,  3 Mar 2021 15:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614784136;
 bh=XC1wZei78fiWQGpuj9EI9I2vB45e4VaOi87vDMlalUk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=q75Tma2+TWNfqReDDqcByzCJOYK7a0b+oobLY34pllk0oH/T9tT/7Oc1xx+wN+Hye
 jh4gyUIiPdKpiSgZnLU0pdUj3MdpMjWjYNh/NW6OHebW3sBpAtEqTge5zlqYX4VHM7
 HWSIpiY30vrRoEt+mjqjMq3co86R3CsWX9D9nLAWI8fJMkd9yb/LK5tcLsjFk0u7rV
 b81p4VMbgv4pwPjSN75fW2DT3UdExCdPSb0Ao0yIRsDD++b7hK1B7gxvOITZVf9y8p
 lNxpfhm3peD1Ww4MV6QTKyVL92GGAy006HXdQlpzIIp5gZs94qg55al3R9zM6u9CrS
 xVHYyNNwRJXvA==
Date: Thu, 4 Mar 2021 00:08:50 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-rdma: fix crash for no IO queues
Message-ID: <20210303150850.GA27048@redsun51.ssa.fujisawa.hgst.com>
References: <7c30ddb7-ee41-9972-4cb6-0a5c089f687c@huawei.com>
 <2a9bb7c3-eb4e-2341-dcfa-583d41912977@suse.de>
 <0a8fbff4-3759-f300-1fa8-601df1eab683@huawei.com>
 <fe262778-4d30-176a-b6c5-a17f023ac22f@suse.de>
 <8ceff1a9-8015-feab-6c02-fd22ec3346de@huawei.com>
 <20210302182418.GA22346@redsun51.ssa.fujisawa.hgst.com>
 <399fd796-64c2-7d25-b0d8-0f445c4bb2dd@huawei.com>
 <20210303031416.GD22346@redsun51.ssa.fujisawa.hgst.com>
 <1fc0b92d-0726-9309-42ce-3e64858cd3aa@huawei.com>
 <9b055c28-62e9-1de1-b30b-207c39178c36@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9b055c28-62e9-1de1-b30b-207c39178c36@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
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

On Wed, Mar 03, 2021 at 08:41:58AM +0100, Hannes Reinecke wrote:
> On 3/3/21 4:39 AM, Chao Leng wrote:
> > 
> > 
> > On 2021/3/3 11:14, Keith Busch wrote:
> >> On Wed, Mar 03, 2021 at 10:27:01AM +0800, Chao Leng wrote:
> >>> On 2021/3/3 2:24, Keith Busch wrote:
> >>>> We can continue to administrate a controller that didn't create IO
> >>>> queues, but the controller must provide a response to all commands. If
> >>>> it doesn't, the controller will either be reset or abandoned. This
> >>>> should be the same behavior for any transport, though; there's nothing
> >>>> special about PCIe for that.
> >>> Though I don't see any useful scenarios for nvme over fabric now,
> >>> Reserved for future possibilities may be a better choice.
> >>
> >> The admin queue may be the only way for a user to retrieve useful
> >> information on the malfunctioning controller. The telemetry log isn't
> >> unique to PCIe.
> > User can also directly visit target to get these information for
> > nvme over fabrics.
> 
> Not necessarily. There is no requirement that the storage admin is
> identical to the host admin; in fact, in larger installations both roles
> are strictly separated.

There's also no requirement that nvme targets providing anything but
in-band management capabilities, so there is no justification for
relying on a vendor specific method.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
