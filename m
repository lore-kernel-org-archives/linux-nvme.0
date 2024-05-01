Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195EAC4345F
	for <linux-nvme@archiver.kernel.org>; Wed,  1 May 2024 22:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nQl0dePOSdq166srlJipc4atual9qCDDi8xiEy+ctcI=; b=jjrLeCMA0nNSbICySBDAPrY7WM
	av5eReitH0LGyV4vhKgoJZMpgnOUymOKJMqlJ0TmGZYJU2ty5h2LQVAR6KET5PavmZCEancHYvnM7
	EFF8IQja0IfyZQQ5IJN1et+R3AFoA3EiTXiU0QfhJ2FfxeuRFAxLy3qSmThHilT9xQxQCaR7hpZbn
	06VyMg8DHnzNMSMycePufo8xm8t2FDP4yQJ2Q4c5rMOG8icBJBoPV0kytLfL3L604SsmxicwDlHup
	aZIEx05e7txMqLFECJ+134I3gKYKTI/HxHcUu1BDnUNdnjpS7Dt+P3Hah9wnMLVzBubGVICH3uoGS
	FlUBaZZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2I2v-0000000AmXa-2dxb;
	Wed, 01 May 2024 22:03:25 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2I2s-0000000AmWR-0pXQ
	for linux-nvme@lists.infradead.org;
	Wed, 01 May 2024 22:03:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D50086177E;
	Wed,  1 May 2024 22:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301A9C072AA;
	Wed,  1 May 2024 22:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714601000;
	bh=DGBV2haCSIA+L1hqz5To8c8ZCii7CgJbbOYs5uBLhhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JOYwPhx0BWQ38YNSGGrxiomPX/id0MQ30ydEkxL0Cc5jZx2nix3YwHLsmSkbO69NF
	 wz1Utmt/9Vk3S3DnqNcE6e7AlkTx5PsLPwwsC4iMJ6uAWgZ4h6wi69uRbWw1I07OP4
	 YEoAxv6OnZOvTUbuTdhtNnUjAgLFjhy3tWOmV1gOQE739GBNrOmockszKYgFg++wJ7
	 gRhdJQGiLumDgLSuge2Zl6+axOn9RY5qtiBfAJ5zBXKcx+JJvIo/JjEUV7ABqOZ6g7
	 z0qUdaL0RM1c+S6qjrWM4sXUUNcVONXXNoakkhFz4rJ2TzjKkk5il7ohWykxuwjaRD
	 sUj7EwPOYsDTA==
Date: Wed, 1 May 2024 23:03:14 +0100
From: Keith Busch <kbusch@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: `nvme_disable_ctrl()` takes 411 ms on a Dell XPS 13 with SK
 hynix PC300 NVMEe
Message-ID: <ZjK8IjHfwpAMQajT@kbusch-mbp>
References: <19a6071a-7fb8-4e0f-8050-6f3ba5ee4774@molgen.mpg.de>
 <20240501045145.GA32110@lst.de>
 <ZjH2Coc8Wz9QrdRM@kbusch-mbp.dhcp.thefacebook.com>
 <93c29602-b162-47b3-9a03-a18158b9f6ef@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93c29602-b162-47b3-9a03-a18158b9f6ef@molgen.mpg.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240501_150322_317688_9A3C0B1C 
X-CRM114-Status: GOOD (  19.83  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 01, 2024 at 10:58:05PM +0200, Paul Menzel wrote:
> Am 01.05.24 um 09:58 schrieb Keith Busch:
> > Exactly. Unless the device reports a lower D3 entry latency, then this
> > sounds like everything is working-as-designed.
> 
> Maybe according to the spec, but I have a hard time to believe, that disks
> should take longer to shut down than coreboot to initialize a mainboard.

That doesn't seem too hard to believe to me. A safe shutdown can often
take a while time for an SSD. I've seen other implementations orders of
magnitude worse than what you're showing. You could do an unsafe
shutdown instead, but the device will just take even more time to enable
on its next power-on.
 
> In the end, in my opinion, users cannot make an informed decision, if these
> things are hidden. If it would be visible somehow in the logs - maybe not
> warning but info level - then even not so technical users could inform
> themselves and factor this in their buying decision.

What good is it to advertise a shutdown time when vendors are clearly
unreliable at reporting an accurate value? If you need to see the driver
report it from emperical testing, then you've already bought the device,
right?

> > You can check your device's advertised shutdown time (assuming your
> > device is nvme0):
> > 
> >    nvme id-ctrl /dev/nvme0 | grep rtd3e
> > 
> > The value is reported in microseconds. If it shows 0, then the device
> > doesn't report an expected shutdown time.
> 
> Thank you for sharing. It´s 60 ms:

