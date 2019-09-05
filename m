Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C81C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 20:37:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 797B220828
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 20:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FwKs14IT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797B220828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fms/GbwbM04ksyJLAQqyysctw56zYb7vgMl7iuIwto8=; b=FwKs14IT2SInT9
	0wOFCYyctoY2vt+b37NJAP5719nQoHSTxLK5BDgEEp1WBJ9RvD8ILbWAIipB02NA2tMBHaORWGOfN
	x84npOTvjny7LKwLHXnlnqnM5DX5TR7g6Mh0VKRL3AN4HdQlAoQk/Bq1pK59uHMyPYNjBksSxGak5
	W0qcxhVrLJEQPjzCFLayr+/lUYZLpJBKDWSnoMoxhfo10sQAY676qVJnaZOttIFjhonI0CrADxbVw
	IKe9MY9JhC/22fkmii4ElwdeA1qG7OAWM8ssN9Vaf+9jsigEg4VMSknDzqN2TW7yBljOh8RC4jKW1
	G3x3UYQ6d7kBAhnWfoAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5yVK-0006YL-U9; Thu, 05 Sep 2019 20:37:18 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5yVI-0006Uz-Ee
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 20:37:17 +0000
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Sep 2019 13:37:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,471,1559545200"; d="scan'208";a="177424705"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
 by orsmga008.jf.intel.com with ESMTP; 05 Sep 2019 13:37:14 -0700
Date: Thu, 5 Sep 2019 14:35:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/5] nvme: Prevent resets during paused states
Message-ID: <20190905203546.GB25467@localhost.localdomain>
References: <20190905142607.24897-1-kbusch@kernel.org>
 <20190905142607.24897-2-kbusch@kernel.org>
 <5f36518c-7cf0-9fe1-49d7-2b24b3d229fe@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5f36518c-7cf0-9fe1-49d7-2b24b3d229fe@grimberg.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_133716_507398_BDE165B6 
X-CRM114-Status: GOOD (  22.32  )
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
Cc: Edmund Nadolski <edmund.nadolski@intel.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 05, 2019 at 01:23:53PM -0700, Sagi Grimberg wrote:
> 
> > A paused controller is doing critical internal activation work. Don't
> > allow a reset to occur by setting it to the resetting state, preventing
> > any future reset from occuring during this time.
> 
> Is there a reproducible bug actually being addressed here?

Yes, IO timeouts happen during CSTS.PP, which is normal, and esaclating
such errors to reset the controller while it is activating firmware is
not a good idea.

Further, we do not want to a user to manaully trigger a reset (via sysfs
or other means), so this properly blocks such actions.
 
> Also, seems a bit "acrobatic" to set the state to RESETTING without
> really resetting it (and then change it back to LIVE before you do
> actually resetting it).

We can think of a CSTS.PP as the device internally resetting itself to
activate firmware.

> Would it make sense to look at nvme_ctrl_pp_status when
> scheduling a reset in nvme_reset_ctrl? Just a thought..

We have to be able to reset if we decide CSTS.PP is stuck, fw activation
timeout.

> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >   drivers/nvme/host/core.c | 9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 91b1f0e57715..d42167d7594b 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3705,20 +3705,23 @@ static void nvme_fw_act_work(struct work_struct *work)
> >   		fw_act_timeout = jiffies +
> >   				msecs_to_jiffies(admin_timeout * 1000);
> > +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> > +		return;
> > +
> >   	nvme_stop_queues(ctrl);
> >   	while (nvme_ctrl_pp_status(ctrl)) {
> >   		if (time_after(jiffies, fw_act_timeout)) {
> >   			dev_warn(ctrl->device,
> >   				"Fw activation timeout, reset controller\n");
> 
> Would be good if the print will reflect if it resetting or not..
>
> > -			nvme_reset_ctrl(ctrl);
> > +			if (nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
> > +				nvme_reset_ctrl(ctrl);
> 
> How can this state change not succeed? ctrl removal?

Right, we can't prevent a transition to a deleting state.

> >   			break;
> >   		}
> >   		msleep(100);
> >   	}
> > -	if (ctrl->state != NVME_CTRL_LIVE)
> > +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
> >   		return;
> 
> In what scenario this will not succeed? if the reset did it?

Controller deletion should be the only reason here.

I see now the "break" for a failed activation ought to be a return,
so I can fix that if you're okay with the rest.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
