Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C98C2BD09
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jun 2024 16:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HuyOiUqUkue5p9iuni8KOUbV1KQSfzHcOXv5eBsp7ao=; b=OLUzgfK2ECdPHAq8zfxmgbT4f9
	4JVLSDGAtEEtwCmICmsXmSMdvg2J1Jm2YBG87sGykWl4iK5oBc5n5AkIE5/kSYpuyR669wOXQPXjK
	vc2ySOq650DvtPy3TkrDtDsFb4H20fIAL+eC0WSg2YYKAtnS6IMscudWrrSZLo/ry7TF8gyWy4xq2
	1sHXydD66iWBCUJZi8A4+21vfbLVAFijsquSojjoND0zOSXgK3surthrE6pzLHtYmdc/IAtGRfuJQ
	lp1x2I6tlx9xCPjZEFUJFfYcWp+lS+AVCTzSEn44DAQfl1iRsgyWWuMK9aH3RPZhzq519wLefU74N
	aCAXAMtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLmEI-0000000HQOP-0Gru;
	Mon, 24 Jun 2024 16:07:42 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLmEE-0000000HQNa-0Cv8
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jun 2024 16:07:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A8C0ACE009F;
	Mon, 24 Jun 2024 16:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4120CC2BBFC;
	Mon, 24 Jun 2024 16:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719245251;
	bh=QmvzWqL6upjkrYqN2k46t5dvqMTjwqkhZJjJmyjFo6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gnpembcgq859uJ4JP4ByPYZirdgTS6QJrm52LTexweFNyaxdWH4VLLamqDhpvm59e
	 GFVdRyRbkEtGvDkeD4g+dIOKGdzBhRN9iCPiGTB/Qi3b85mdGsrcAleWG50YwtWkwD
	 itXk+wu7fHZmOpI+tjZ/QDo08+znD/yyVpbdg24JsI50JQHcPMrKazuwx9ls0BhwKu
	 3Eo479bv5Wp9ooKQ2n/DTVdZO8ZsmEKR4T/UJ84hZPwlpKNGeW7oxyG/AuurgMI9mN
	 J0mETj0r78UQkB8776nUHGCJlK7J/eSeCJy1Jn7Ul4kSLzH8G0ZJr51PygVXVKu8aR
	 gg8vhjzBz+6/A==
Date: Mon, 24 Jun 2024 10:07:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	gjoyce@linux.ibm.com, axboe@fb.com
Subject: Re: [PATCH v3 1/1] nvme-pci : Fix EEH failure on ppc after subsystem
 reset
Message-ID: <ZnmZwOUOuz6g2PFH@kbusch-mbp.dhcp.thefacebook.com>
References: <20240604091523.1422027-1-nilay@linux.ibm.com>
 <20240604091523.1422027-2-nilay@linux.ibm.com>
 <ZnWsXmRdCCgMwL5V@kbusch-mbp>
 <653be192-cfa7-45d6-adf0-2a863960630a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <653be192-cfa7-45d6-adf0-2a863960630a@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_090738_486441_124F356E 
X-CRM114-Status: GOOD (  17.47  )
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

On Sat, Jun 22, 2024 at 08:37:02PM +0530, Nilay Shroff wrote:
> On 6/21/24 22:07, Keith Busch wrote:
> >  static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
> >  {
> > +	u32 val;
> >  	int ret;
> >  
> >  	if (!ctrl->subsystem)
> > @@ -657,10 +660,10 @@ static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
> >  		return -EBUSY;
> >  
> >  	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65);
> > -	if (ret)
> > -		return ret;
> > -
> > -	return nvme_try_sched_reset(ctrl);
> > +	nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
> > +	if (!ret)
> > +		ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &val);
> > +	return ret;

> This is a nice idea! These changes look good. I have tested it on powerpc with 
> EEH and I observed that post nvme subsystem-reset, EEH is able to recover the disk. 
> I have also tested it on a platform which *doesn't* support EEH or pci error recovery
> and on this platform I observed that nvme disk falls through the dead state. 
> 
> So I think you may submit a formal patch with this change.

Just a little concerned about the reg_read32 at the end there. A hot
plug event is potentially expected outcome from the reg write, and that
may unmap the pci bar before read.

And come to think of it, a hot plug could occur before the reg_write32,
too, for a reason unrelated to the requested subsys-reset operation...

Anyway, I think this needs a driver specific op to handle it safely.
I'll send a patch.

