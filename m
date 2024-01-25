Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D6BC46CD2
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jan 2024 00:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QwQ5UGaxvWUFmGp3KkhR2WFUXXQ6NqPPE6WQYBvMTNw=; b=sMmFAI9XJhuvy+x4AT6QSScv97
	Dm+wmPD/PccnsPyfYRzv6z+y44za38XFyjlA0fR8spk9ON6AO5CBiZNUbhYj2ejZ6GN+OLjnkTq58
	XYyWM6oSfeyygEAJOrNJzYX6jcS1JVZsZLc6zhoKZePHMHjg4gULgts/pp0XwLf7uPunrVHGMh7WA
	aGPZLYeFjLjscOjuGQ40BzbXp0tLCX1lE54+mkr4+6P0hDuWMP8gxVMRWn0cU0dhikkJOFqIvIfRw
	A/PjsRtehXfQEADjazpl7dSOOs+5W9jVDXC5EibW4NtTwInWmRZtsiXHEophnDznPozA5Q3R65uXQ
	B4re96YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSngs-005hGR-2y;
	Thu, 25 Jan 2024 00:33:58 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSngo-005hF7-0w
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jan 2024 00:33:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9343DCE32A1;
	Thu, 25 Jan 2024 00:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C26AC433C7;
	Thu, 25 Jan 2024 00:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706142829;
	bh=WCCvXfMjZlRhUWQSC+23moLD6S7nzRFYGjDDU9Ud1g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eRPGwH3R7QjzhkcfGnJyM3+P+zBgFmvKCv6dPATkLrP2XcJAzAoL4/bnulMBvfC1c
	 HBo2Pz7idAx+IhaLFrHjEAQwjkKuI9MFUfptgZTttsQBVvYEqynQKWaCxUaP5Qkjan
	 0Fr0LsTeDhycxTMoAYOrn+NfwTUY02UPa8/R7ztsnuNHsFBiMlLayc9zJyi2BaY1ly
	 btOttignSW5YysHskVYwPeyLPwP1NEDIA5W1+EX/cUVk/M51qoAGshy+KmUZ8aOR1c
	 DQqU80doi+RUfYbNCpjLFag0AAGcbbgT/BPzX5trKXgkkcxExWfZJPLyALjz3H9Rs7
	 wTH6mFQOXFh2w==
Date: Wed, 24 Jan 2024 17:33:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@meta.com>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: use ctrl state accessor
Message-ID: <ZbGsa5NNwlE9WKxj@kbusch-mbp.dhcp.thefacebook.com>
References: <20240124172855.1901146-1-kbusch@meta.com>
 <38cd1a30-75bc-4d19-b26a-cfb29a1f4240@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38cd1a30-75bc-4d19-b26a-cfb29a1f4240@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_163354_590632_FE084ED8 
X-CRM114-Status: GOOD (  15.18  )
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

On Wed, Jan 24, 2024 at 10:19:50PM +0000, Chaitanya Kulkarni wrote:
> On 1/24/24 09:28, Keith Busch wrote:
> >   nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
> >   			struct nvmf_ctrl_options *opts)
> >   {
> > -	if (ctrl->state == NVME_CTRL_DELETING ||
> > -	    ctrl->state == NVME_CTRL_DELETING_NOIO ||
> > -	    ctrl->state == NVME_CTRL_DEAD ||
> > +	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
> > +
> > +	if (state == NVME_CTRL_DELETING ||
> > +	    state == NVME_CTRL_DELETING_NOIO ||
> > +	    state == NVME_CTRL_DEAD ||
> >   	    strcmp(opts->subsysnqn, ctrl->opts->subsysnqn) ||
> >   	    strcmp(opts->host->nqn, ctrl->opts->host->nqn) ||
> >   	    !uuid_equal(&opts->host->id, &ctrl->opts->host->id))
> 
> since original code is accessing ctrl->state each time instead of
> separate variable, why not reading from it from nvme_ctrl_state() that
> will have READ_ONCE() for each call ?

I doubt the original compiled to code that really accessed the memory
address 3 times. We don't really want to do that either. We just want
the snapshot to be consistent throughout these checks.

> > @@ -156,7 +156,7 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
> >   		if (!ns->head->disk)
> >   			continue;
> >   		kblockd_schedule_work(&ns->head->requeue_work);
> > -		if (ctrl->state == NVME_CTRL_LIVE)
> > +		if (nvme_ctrl_state(ns->ctrl) == NVME_CTRL_LIVE)
> >   			disk_uevent(ns->head->disk, KOBJ_CHANGE);
> >   	}
> >   	up_read(&ctrl->namespaces_rwsem);
> > @@ -223,13 +223,14 @@ void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
> >   
> >   static bool nvme_path_is_disabled(struct nvme_ns *ns)
> >   {
> > +	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
> > +
> 
> nvme_ctrl_state(ns->ctrl) is needed to compile the code, unless I'm 
> totally wrong
> here ...

Yep; I tested the wrong config. Will fixup, thanks for the catch.

