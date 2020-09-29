Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7EAC4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 18:37:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 323A52074A
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 18:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dyUOb+FT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323A52074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7YTo/ImGKRz9VETi4of/QxetOkQrStFGfkTE/jDbUt4=; b=dyUOb+FTZvYdLOQ+0prIRRCCE
	VHxK7wfleIjJrAseKoAL+Hx521W8PeDRfuxBY6QHHCq62XX77X0bDy5v8O7T2a94IFIP2JtfY0ick
	byp3mZIsS/zhozp36yaZ0luam9FTkVsaRaU5VXDlp8/zfHqVgGGVL3hAOPPIBR3h3QzaosNr/UMsi
	Q/pTEpQfh/0hq8c0SsWscoIgMmuhLcRLD247pk5hLzMJJOdhN8PxD8oG5E0t5jka93lp1ShAO68I0
	1m8m0uNAh5Vz069MqKXq0SzwFJoKt3n1ll0piwRkh53EX0tBIrkTlzOeQ9SXi1r1RMCfJxAxuJiaS
	kceApVDEA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNKVJ-00064G-HZ; Tue, 29 Sep 2020 18:37:33 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNKVH-00063P-PN
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 18:37:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7C87767373; Tue, 29 Sep 2020 20:37:29 +0200 (CEST)
Date: Tue, 29 Sep 2020 20:37:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 16/20] nvme: revalidate zone bitmaps in nvme_update_ns_info
Message-ID: <20200929183728.GI12948@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-17-hch@lst.de>
 <CY4PR04MB37517CB7AD3055B588C58E83E7350@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB37517CB7AD3055B588C58E83E7350@CY4PR04MB3751.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_143731_938397_258BBD5A 
X-CRM114-Status: GOOD (  19.24  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 28, 2020 at 03:06:06PM +0000, Damien Le Moal wrote:
> On 2020/09/28 21:35, Christoph Hellwig wrote:
> > Consolidate the two calls into a single place.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/nvme/host/core.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index f19f6c7c5b1242..9c137d8819f756 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -2150,6 +2150,12 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
> >  	nvme_update_disk_info(ns->disk, ns, id);
> >  	blk_mq_unfreeze_queue(ns->disk->queue);
> >  
> > +	if (blk_queue_is_zoned(ns->queue)) {
> > +		ret = nvme_revalidate_zones(ns);
> > +		if (ret)
> > +			return ret;
> > +	}
> 
> Is it OK to call this before nvme_update_ns_info() ?

It is called after nvme_update_ns_info for the relevant gendisk,
but before the one for the multipath node.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
