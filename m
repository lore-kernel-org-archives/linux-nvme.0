Return-Path: <SRS0=jFtc=XP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7C1C3A5A2
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 18:09:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E71DA20C01
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 18:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IL7VxPCN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGNfS6Gn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71DA20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IRj1/SR3n1TsqNgSePX0zWNfujJsQa/qs4ATHwZvkcc=; b=IL7VxPCNjzgd1P
	LPyJ2CQ3oFztnfVOeWZkLSLVOe+cM7q70K+H07no04YjcF0k9qoFHjU5/1SQ3e7SgZCgiaRkOh9tI
	lso3sLF1knePNgOFCiH7q8q8R4oUM0MjKqErR9faNOnyL+dBpoQBtEKuyH7mS9fhpKssqzAjYfYNW
	8bgWQOGym9ZnJlLohu8dzoS+cLFGVxoCACPQpHn4uvz8cs3XcpAVjUv+PS4iIr7njE+1GUYYlOv2w
	fxfNOsNNmSUNs2e1efSAqmTe6POTeIeEUkLyxSPN496knFrKQtLqSbF8Ad7fzPLdrJx0Hvuwsyumf
	zjZNbhnA49J/DMdzub3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iBNL0-00031J-L3; Fri, 20 Sep 2019 18:08:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBNKy-00030w-1B
 for linux-nvme@lists.infradead.org; Fri, 20 Sep 2019 18:08:57 +0000
Received: from C02WT3WMHTD6 (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 60CCF20717;
 Fri, 20 Sep 2019 18:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569002935;
 bh=nS2LTBFxiEbsEh43096jdzy5B6z5+oP3z5M/FX39Opg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HGNfS6GnpFl6U2xTuhLtMx/VmQnTYZrQhxh/jEFE2CX/sW9E9TmPdOE0JJXYxjmsf
 ZC5xf6gJJlaInAhLlww2BBTS7ufH7Zo99WWHiQ5c1l6BqtoN36u3bvhfQngSNlSpIp
 qnqz1oO2todhPVG48Q0hRefk139E24JWjv0lxGQ0=
Date: Fri, 20 Sep 2019 12:08:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCHv2 5/6] nvme: Prevent resets during paused states
Message-ID: <20190920180853.GC97854@C02WT3WMHTD6>
References: <20190919213431.7864-1-kbusch@kernel.org>
 <20190919213431.7864-6-kbusch@kernel.org>
 <c31bee2b-5f43-9744-8fbc-971c3504622e@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c31bee2b-5f43-9744-8fbc-971c3504622e@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190920_110856_097039_2F2329B1 
X-CRM114-Status: GOOD (  15.04  )
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
 linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 20, 2019 at 11:05:22AM -0700, Sagi Grimberg wrote:
> 
> >   drivers/nvme/host/core.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 95b74d020506..33b5729763c2 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3742,15 +3742,14 @@ static void nvme_fw_act_work(struct work_struct *work)
> >   		if (time_after(jiffies, fw_act_timeout)) {
> >   			dev_warn(ctrl->device,
> >   				"Fw activation timeout, reset controller\n");
> > -			nvme_reset_ctrl(ctrl);
> > -			break;
> > +			nvme_reset_continue(ctrl);
> > +			return;
> >   		}
> >   		msleep(100);
> >   	}
> > -	if (ctrl->state != NVME_CTRL_LIVE)
> > +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
> >   		return;
> > -
> >   	nvme_start_queues(ctrl);
> >   	/* read FW slot information to clear the AER */
> >   	nvme_get_fw_slot_info(ctrl);
> > @@ -3768,7 +3767,8 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
> >   		nvme_queue_scan(ctrl);
> >   		break;
> >   	case NVME_AER_NOTICE_FW_ACT_STARTING:
> > -		queue_work(nvme_wq, &ctrl->fw_act_work);
> > +		if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> > +			queue_work(nvme_wq, &ctrl->fw_act_work);
> 
> btw, what happens if someone just initiated a reset here when the event
> is handled? just ignore the fw activation?

Yep, if someone reset the controller before the driver got to handle the
activation notice event, there's nothing for fw_act_work to do anymore
since CSTS.PP is not valid after toggling CC.EN.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
