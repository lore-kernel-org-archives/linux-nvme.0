Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F4EC36014
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Mar 2025 20:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y3XQMDNA5VSPq4soyBuojUJ0OVO3D9JxQPOr0AR1AME=; b=KaysBEFTuRmSf/Hxz0fzFrvgUF
	qVPOcMJiev5ru9AxbxCh7BUJbkrRpilz594rF17EmYRE7HOatybWkedWuayMWOf5oUdMD80R/ZVuH
	g3I5o4MS+YbQdaTEFpzeWm1aNWjBosQscx7tLFAMpWT+HwD8Z4nvoVk7Wq+r2Hd4lMw4KvvWzn115
	dazgqZ1mGvyuu8kl8Lfd3m3ViUQLin/cavDODiB1bCrST5OOQ+AXWdn+Ws24eWmbzbnIFT5O2BzcH
	tzO1bLzX/xDG+Fcjk8eouh9ckFEMwaFVzQHR0AmrbHSasAWw8045KLvDYnwyfdWkI88J4/wnIVhZB
	0OEmRO2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzMC5-00000001MsT-2pAt;
	Mon, 31 Mar 2025 20:57:17 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzMC2-00000001MrW-2FnY
	for linux-nvme@lists.infradead.org;
	Mon, 31 Mar 2025 20:57:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CBDE444326;
	Mon, 31 Mar 2025 20:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AF9C4CEE3;
	Mon, 31 Mar 2025 20:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743454634;
	bh=bHsqO9FPynEB+EQQjXUO2sC0/E6CzHTNZwOBSkcp7gA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=agO++pU2oHbCFS2qMHi4HSPcThW7BsVtJmAvC0qsjcNldfWZKRFgKUEXlmV4wI6Ce
	 LJko6iNJtYjvRAotBnfVUVezn+ekATRQL8917LIfxrcLYXDYw9Nasd0KjhhN3di4a9
	 0ZelRqy7gfUqV75gfJWaQpKhM7FLWoW6vAefuf0XDssHFaVJ+y6U2pjxmB8bWH/BF+
	 opKA7XSSYR0zCVlmp0OEeOrvi+KvHqqAnAtu307qgZRTVasGE+ZbJyZNUhrfc8Z060
	 BTJth4xKrfcOF6SqiBAWDKfiuG8CYKO+WpQbXai7PmWnWxqdaNNkRpCMBN3H5oUagc
	 XDjOSQn0cXo5A==
Date: Mon, 31 Mar 2025 14:57:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@meta.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"wagi@kernel.org" <wagi@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"dwagner@suse.de" <dwagner@suse.de>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH] nvme-cli: attach ns to local controller if none specified
Message-ID: <Z-sBp3YQp60oS-e9@kbusch-mbp.dhcp.thefacebook.com>
References: <20250331190843.2431830-1-kbusch@meta.com>
 <f6567009-341e-44d4-94fd-feb92526d80d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6567009-341e-44d4-94fd-feb92526d80d@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_135714_593212_BB323962 
X-CRM114-Status: GOOD (  16.03  )
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

On Mon, Mar 31, 2025 at 08:37:31PM +0000, Chaitanya Kulkarni wrote:
> On 3/31/25 12:08, Keith Busch wrote:
> > From: Keith Busch<kbusch@kernel.org>
> >
> > Assume the user meant to attach the namespace to the controller the
> > command was sent to if the user didn't provide a controller id list.
> >
> > Suggested-by: Nilay Shroff<nilay@linux.ibm.com>
> > Signed-off-by: Keith Busch<kbusch@kernel.org>
> 
> this will not be backward compatible hence all the existing deployments
> that are resulting in error [1] will now attach the default controller,
> I believe that is what is expected ?

Yes, this changes behavior. I don't think a user would purposefully
request to attach a namespace to nothing. If they explicitly request
that via '-c ""', then that request will still be honored. But if they
omit the list entirely, I think it's reasonable to assume you want the
controller servicing the command to attach the namespace to itself.

It's really a nice workflow optimization since you can skip finding the
controller id when you just want local attachment.
 
> if not then do we need add a version check so it will stay as backward
> compatible ?

I don't follow what you mean here. What version of what component could
be checked to guide this behavior?

