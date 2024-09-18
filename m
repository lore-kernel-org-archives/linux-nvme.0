Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C41CAC589
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2024 06:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ohlU3H7J49UwE38nb0b/18OXTM3M1cuzUWzOzdZnkyw=; b=w8WgvXa/JUoqol8WhC2jfv9eTF
	km1MG5tAYr6yUdj8pL2lH/YKxewHfV7OAzs4PaPNs2i2L16I2J41tJcsm9D5VZbPC3c8hMSjWgn4v
	V31ridYNRXd0UIutLMv/ncUdwE2afK27tT+brWuqf/D5SFPd01f9mux3lenesdZL/KGPwuTD80w0B
	ZXhmKS5NAff2esrHYBlrU2XgJ53S26qcdQhbT2F8i8HWed/6VuOixpUJUy+o3cB0y1z40tONCL27q
	EO+aocxSBc+E3bKfrBpSyPviF2kJ3SsUKPVLIx4WhDFticsewEx0oNylH5EtFuEdPYak2CgwWlJWD
	/bqEmTvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqnvc-00000007WTq-1w08;
	Wed, 18 Sep 2024 06:12:40 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqnvZ-00000007WTQ-2jxb
	for linux-nvme@lists.infradead.org;
	Wed, 18 Sep 2024 06:12:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 00B235C5910;
	Wed, 18 Sep 2024 06:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15A3C4CEC3;
	Wed, 18 Sep 2024 06:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726639956;
	bh=0cMDnLfawnNrBsiNhzS/y1l/gwhUjiP67PgaOZ9uELw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oVsBV5Mj0MFrRPZiQ6YO0gJf0djPToMIrwWJZnu7Y4FRGnZHTuRdNJMv+l1jdE6e9
	 aVk1DFoyMNaihfLUh1BEMRS5qWay9IM2chiRfV+WeHDccePwM4zjiy6o9C8mu3f/rS
	 mcreKg2WfWQCiEWZN9AnKsenpAODv8sQVVq8S2IY=
Date: Wed, 18 Sep 2024 08:12:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stuart hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>
Subject: Re: [PATCH] driver core: fix async device shutdown hang
Message-ID: <2024091838-keenly-scrabble-8cce@gregkh>
References: <20240917201517.1145331-1-stuart.w.hayes@gmail.com>
 <2024091753-estate-legroom-5d62@gregkh>
 <751d4ba8-1e35-47a5-9a94-9873ff2619ae@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <751d4ba8-1e35-47a5-9a94-9873ff2619ae@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240917_231237_756402_F3CE18FC 
X-CRM114-Status: GOOD (  21.97  )
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

On Tue, Sep 17, 2024 at 07:20:41PM -0500, stuart hayes wrote:
> 
> 
> On 9/17/2024 3:42 PM, Greg Kroah-Hartman wrote:
> > On Tue, Sep 17, 2024 at 03:15:17PM -0500, Stuart Hayes wrote:
> > > Modify device_shutdown() so that supplier devices do not wait for
> > > consumer devices to be shut down first when the devlink is sync state
> > > only, since the consumer is not dependent on the supplier in this case.
> > > 
> > > Without this change, a circular dependency could hang the system.
> > > 
> > > Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> > 
> > What commit id does this fix?  Should it go to stable?
> > 
> > And what driver is causing this problem, is this a regression or for
> > something new that just got added to the tree?
> > 
> > thanks,
> > 
> > greg k-h
> 
> This fixes commit 8064952c65045f05ee2671fe437770e50c151776, in
> driver-core-next & linux-next... it's problem with code that was just
> added to the tree (in drivers/base/core.c).  It is not in stable.

Ah, that wasn't obvious, sorry.

> Apologies, I should have mentioned that from the start.

Can you resend this with a "Fixes:" tag in it so I can just take it that
way and not have to edit it by hand?

thanks,

greg k-h

