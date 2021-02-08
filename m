Return-Path: <SRS0=c0j7=HK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6490DC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 03:29:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBF4064E31
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 03:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF4064E31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9hk8oeo2fCScZcc0O+tXVbQV2ZcqYmqi6pXxPkLdNYc=; b=0SHx4zUOQ/fMrbRr46rdPRyU0
	YPl6VVF4xdIOwORg6wk737amRYS4G8SnMmy3Rkdd5Z11gb2QIvB3jZKpHv81rRwAR8I4iMgJR0db4
	6jxAlOMgTWeOxbm/u7QDfXgT0M6s5rve4LJzEWfU6/Z0TQoV2ZvAcEVPjb2N6UECNplSSkjE21q8n
	904fexijV+NtA1lphKaAalPzDDKCZ2MTT4XhMeKXN8p8yueR3tENZsCjneVb3B/8HorKcxBfqhvI9
	h5LZcIJxr3QRuAh6tqyyssTmzur8BW/XtIeU9kndOUdO+MuDWZL/r7GwfX0x01arGa0s3v65+su0q
	Hti+37d0Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l8xEQ-0004VU-J6; Mon, 08 Feb 2021 03:28:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l8xEN-0004Ur-UO
 for linux-nvme@lists.infradead.org; Mon, 08 Feb 2021 03:28:57 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7478964E66;
 Mon,  8 Feb 2021 03:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612754934;
 bh=rF5T8xJ/sr/dn3D9Kb+yh+I0JXZ49WBnHNDL83ZJG4s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DBhnR1NC0xz7Pp5JRc4vuaWU5KYDN8/K9OaBab01AHV9MFSe0xAIlUSZK5UPcjqZ0
 BnzUdwo3Y7AXKtWkRPqMBbFlGKNMEOh2qkZvmvWS8NKpmtn38rnSKfD9r2AYCh1x4b
 1g1yQZNloQVMoApF98UkBMsg4e3iyGXrkHIKSpKOp3k0pWDJjRVZ740u5zBwn2olRR
 Enz7tyQ4059tBo7TIG5nG70bez3SUxgN0/lhHm8Dzhibr51OeUmk/v4BXlcBJ6g/EQ
 CQqBXTqz9mp1rulqqppnPyrAZ8Hp8X4Z/gCDe23uKKwET7O5NOKwjK5SaXK6deagOy
 uM2wMGNhr5AhA==
Date: Mon, 8 Feb 2021 12:28:51 +0900
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] nvme-multipath: set nr_zones for zoned namespaces
Message-ID: <20210208032851.GA14062@redsun51.ssa.fujisawa.hgst.com>
References: <20210205195002.2657209-1-kbusch@kernel.org>
 <BL0PR04MB65147CDC426FC6345B2048D7E7B09@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BL0PR04MB65147CDC426FC6345B2048D7E7B09@BL0PR04MB6514.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210207_222856_115680_E24BC8A9 
X-CRM114-Status: GOOD (  15.21  )
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
Cc: Minwoo Im <minwoo.im.dev@gmail.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Feb 07, 2021 at 11:06:36PM +0000, Damien Le Moal wrote:
> On 2021/02/06 4:50, Keith Busch wrote:
> > The bio based drivers only require the request_queue's nr_zones is set,
> > so set this field in the head if the namespace path is zoned.
> > 
> > Reported-by: Minwoo Im <minwoo.im.dev@gmail.com>
> > Cc: Damien Le Moal <damien.lemoal@wdc.com>
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> 
> Shouldn't this have a Fixes tag ?

Probably yes, since this omission does go back to the initial inclusion:

Fixes: 240e6ee272c07 ("nvme: support for zoned namespaces")
 
> > ---
> >  drivers/nvme/host/multipath.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> > index 1427c9555cef..a1d476e1ac02 100644
> > --- a/drivers/nvme/host/multipath.c
> > +++ b/drivers/nvme/host/multipath.c
> > @@ -677,6 +677,10 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
> >  	if (blk_queue_stable_writes(ns->queue) && ns->head->disk)
> >  		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES,
> >  				   ns->head->disk->queue);
> > +#ifdef CONFIG_BLK_DEV_ZONED
> > +	if (blk_queue_is_zoned(ns->queue) && ns->head->disk)
> > +		ns->head->disk->queue->nr_zones = ns->queue->nr_zones;
> > +#endif
> 
> Is the zone model set already ? I have not checked...

That's a good question, and we should be safe with the zone namespace's
zone settings set at this point: nvme_mpath_add_disk() is invoked after
nvme_update_ns_info().

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
