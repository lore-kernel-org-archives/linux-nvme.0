Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4821C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Dec 2023 23:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MXXaeQJQ5RQ6hdmj/dj0Fy28PI+9ZRzNYDojVYtXFPc=; b=YEx5eQl8iXrtfPvt3tYSVZ3jaU
	6QC7EYacCNvB2xkZba/5jH9igY45668H9EwzFqlJZIri34gM3muQMYo507wilqOCvVsQMuXWYVyqQ
	EenrwcfuSCogVUpKn99l1XaWrtC1y295+TdZ6MD2DYDhdoiX/R+ZJ1f/sPSiZqu3NNhxM/C/sQrp5
	bgBx2Y2EosK7PHbvA9snNASfrkwTpR17gQitmtY+q20fKor7BzpLpDxlQJ5xrw7Cq9bZDkk5coqdR
	qLOgEeY2f8AX0wZkdQGqVWw7YdK3d11XFvubpFS0I0gMyfAn/fE4m3GVtBUTDxB9Rm81czITDJ+aR
	MQBNB78w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDvH7-001ZAY-0I;
	Thu, 14 Dec 2023 23:37:53 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDvH4-001Z9r-0U
	for linux-nvme@lists.infradead.org;
	Thu, 14 Dec 2023 23:37:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6C9D7623E2;
	Thu, 14 Dec 2023 23:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8927C433C8;
	Thu, 14 Dec 2023 23:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702597069;
	bh=arX++frJmrhVDBP2RiMfCW8Qy/N8N1wmAEZ1Q3U+GDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oUmcAv7ANzTll085d2olkDYJZayz2V19I3Hq5fFo/Qj8oThDR36ExwDwUssP/iJtx
	 blHXQ2VRNk6TgeRIC18cnMympG8+P3SMT4mm57jBB70/035bQFb0wOkTS1j4XvvF8j
	 /jumJ2Xf5unkPz8210m6RUrtmF4Wyc/6TFbH+Os6KDqdUds2nE4YxmUhbSzD0ZTURI
	 BTvhZ/bLBY+3X1VNbPjzKpQHbU4y/9abCZ/r2PR6AMMcu1a7AIv1Mer3xAkTm4FxPO
	 Fyu3Z4KXWujVNh1+FnItzOeYVU375v1MHiuSyb0D3SUnW8dYe/+EF50kSkPfEFTYCR
	 7TLr4aiP/Ytnw==
Date: Thu, 14 Dec 2023 15:37:47 -0800
From: Keith Busch <kbusch@kernel.org>
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: parallel nvme format
Message-ID: <ZXuRyk7IjbyzCQ3R@kbusch-mbp>
References: <ZXsJdJxDXEbCmSec@x1-carbon>
 <ZXs5B8pYKTBLD1NH@kbusch-mbp>
 <ZXtx2EOnRUMLSjcu@x1-carbon>
 <ZXuGkmdgXwFKB_cY@kbusch-mbp>
 <ZXuK9YQVkhjwUTr6@kbusch-mbp>
 <BYAPR04MB4151B88FACA25A38C4C998FCBC8CA@BYAPR04MB4151.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4151B88FACA25A38C4C998FCBC8CA@BYAPR04MB4151.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_153750_274825_EAF932CA 
X-CRM114-Status: GOOD (  18.84  )
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

On Thu, Dec 14, 2023 at 11:27:57PM +0000, Kamaljit Singh wrote:
> Hi Keith,
> 
> Good suggestions but we may need another change to check for NVME_CTRL_NEEDS_SCAN and kick-off nvme_scan_work later, to follow-up for the call that may have been skipped.

Another check where? These are the only two paths that hold scan_lock,
so if the initial scan was aborted because the other path was holding
the lock, that path has to see that the needs rescan flag was set and
requeue it.

I guess there could be some user initiated scan or an AER triggered scan
in a multipath+multihost setup that was aborted because of an admin
command without ever explicitly setting the flag bit, so we could set it
on trylock failure to make doubly sure it gets rekicked after the
scan_lock is released:

	if (!mutex_trylock(&ctrl->scan_lock)) {
		set_bit(NVME_CTRL_NEEDS_RESCAN, &ctrl->flags);
		return;
	}
 
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1120,6 +1120,8 @@ u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
> >               nvme_start_freeze(ctrl);
> >               nvme_wait_freeze(ctrl);
> >       }
> > +     if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC))
> > +             set_bit(NVME_CTRL_NEEDS_RESCAN, &ctrl->flags);
> >       return effects;
> >  }
> >  EXPORT_SYMBOL_NS_GPL(nvme_passthru_start, NVME_TARGET_PASSTHRU);
> > @@ -1140,7 +1142,7 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
> >  "controller capabilities changed, reset may be required to take effect.\n");
> >               }
> >       }
> > -     if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC)) {
> > +     if (test_bit(NVME_CTRL_NEEDS_RESCAN, &ctrl->flags)) {
> >               nvme_queue_scan(ctrl);
> >               flush_work(&ctrl->scan_work);
> >       }
> > @@ -3945,7 +3947,14 @@ static void nvme_scan_work(struct work_struct *work)
> >               nvme_clear_changed_ns_log(ctrl);
> >       }
> >
> > -     mutex_lock(&ctrl->scan_lock);
> > +     /*
> > +      * Failure to acquire scan_lock means another thread will requeue this
> > +      * work shortly
> > +      */
> > +     if (!mutex_trylock(&ctrl->scan_lock))
> > +             return;
> > +
> > +     clear_bit(NVME_CTRL_NEEDS_RESCAN, &ctrl->flags);
> >       if (nvme_ctrl_limited_cns(ctrl)) {
> >               nvme_scan_ns_sequential(ctrl);
> >       } else {
> > diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> > index 39a90b7cb1254..79a71b6ae64fe 100644
> > --- a/drivers/nvme/host/nvme.h
> > +++ b/drivers/nvme/host/nvme.h
> > @@ -251,6 +251,7 @@ enum nvme_ctrl_flags {
> >       NVME_CTRL_STOPPED               = 3,
> >       NVME_CTRL_SKIP_ID_CNS_CS        = 4,
> >       NVME_CTRL_DIRTY_CAPABILITY      = 5,
> > +     NVME_CTRL_NEEDS_RESCAN          = 6,
> >  };
> >
> >  struct nvme_ctrl {
> > --
> >

