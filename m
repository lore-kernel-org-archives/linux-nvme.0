Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5417FC28B20
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Apr 2025 06:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WQlmqeAwSop+3PWdK6x4DTTcUGtrLCljoTGVHUMCDT4=; b=iQ/t4ICU7pQOYBGYeKR9aRWmvt
	eVm+xsl4ZZBi8MlDC3gheWjx3dWEX1X9Uum2EqvnNh5phvrwEC9XeTcBngpiApSwTfNHwcAU1QE/U
	A6lpsG/W2T74VBcU1QYn4dIb6vPnCDtEDHo6irkFDdTS0u0Kk9ExKQaoKIooSUd0u9rNyKQQksCRO
	bAU2C944uibA+UVOnlQHl9DmsQ2As6zCuCPgqX2RzUVgBdTzFpSXzzWoCYdHGzbjQio8wdMl9Twpa
	15LAQPoLBwBcYWB0aPqWt6qa9eAgWSoHSyGi5m9FLpjBqPabkJobuLbIjHov+QnY0389wn/8RfBHA
	Cqnjcj/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzrk6-00000005GDL-1HPC;
	Wed, 02 Apr 2025 06:38:30 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzrjI-00000005GBb-3xPK
	for linux-nvme@lists.infradead.org;
	Wed, 02 Apr 2025 06:37:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 323A25C6338;
	Wed,  2 Apr 2025 06:35:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9C1C4CEDD;
	Wed,  2 Apr 2025 06:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743575859;
	bh=WQlmqeAwSop+3PWdK6x4DTTcUGtrLCljoTGVHUMCDT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HfB7fKcgC3eY7a8bAguJV+7u7G7OfadeUdwoaB+LMGeIf2lUBPPsajuKLad/WQf+t
	 gi5mRdgp/aFovws4dtaA3jYvrwGEliskvu16qxE6/Q1SJHunKti/1cS1dAuN6c+gSP
	 vf4/TuHGUfi9E6ygsw2VWrDgZIo6w8xSiwccLXnBgdpeGMabyi+KI4T3EJloROqWj2
	 +EwdjTrViCuyZOtJLW5uaWoSqobkVCfh+HDqikXiSisdLjW4fmCTn1DUXQTR3HZnpu
	 vTkRcm1WwlpfUo/tCrDwtuL+kX+gud5F8qynslBFQh5UUIGdKh54L/CoJ5q8+oXCKl
	 s6WzCyeFucViw==
Date: Wed, 2 Apr 2025 08:37:35 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	hch <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v1 1/1] nvme: add admin controller support. prohibit ioq
 creation for admin & disco ctrlrs
Message-ID: <Z-zbLx9h0IbOEmbO@ryzen>
References: <20250328213640.798910-1-kamaljit.singh1@wdc.com>
 <20250328213640.798910-2-kamaljit.singh1@wdc.com>
 <Z-qur5YnK2ZtiRR3@kbusch-mbp.dhcp.thefacebook.com>
 <Z-ueG-wTibsSu5lK@ryzen>
 <BY5PR04MB68496CB7512F91FEA30DFF86BCAC2@BY5PR04MB6849.namprd04.prod.outlook.com>
 <MN2PR04MB68626A7C2D254018FB37851DBCAC2@MN2PR04MB6862.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR04MB68626A7C2D254018FB37851DBCAC2@MN2PR04MB6862.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250401_233741_040451_7FF38644 
X-CRM114-Status: GOOD (  16.68  )
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

Hello Kamaljit,

On Tue, Apr 01, 2025 at 10:57:36PM +0000, Kamaljit Singh wrote:
> On 2025/04/01 01:04, Niklas Cassel wrote:
>  
> > But to be honest, the code did previously
> > allow an I/O controller with just the admin queue and no I/O queues.
> Agree. Initially, I was able to use that hole by forcing nvme-cli to
> allow zero IOQs. But based on your suggested driver change we don't
> need to patch nvme-cli anymore. That's slick!
>  
> However, from the nvme-cli's perspective it does feel awkward to be forced
> by "nvme connect" to use -i <non-zero> for an admin-controller, even though
> its now being overridden with this patch. We will have to come up with a
> cleaner and standardized way to connect to an admin controller.  A standard
> port number for an admin controller might be the way to go but it's not in
> the spec yet.

So, with this patch which overrides the user provided value,
if the controller is an admin controller, you need to use:

$ nvme connect -i <non-zero> ?

Can't you simply omit the -i parameter?


Kind regards,
Niklas


