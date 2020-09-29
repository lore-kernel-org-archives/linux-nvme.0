Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE5FC4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 18:41:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C72020754
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 18:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fjqK9G3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C72020754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CgpVBYMaxHnBSBnhdGHC1EU9IQiVhLuUOvP8Ug9ByoI=; b=fjqK9G3bQsPCCPc2uHpXTLIEw
	q8n9RC9tAkN5F5b84Ksx9oKr17Yc4PDszCh+QxN3KmHEPoXHWS92uScw9ExIp03poVUMsuZdFYQ+K
	nRbcMz91KJdq4xo4KDYWXq6Jp3P8dtQay5960ccDxP+a6d7UoNEB4yMmzIKzlnevcCv3jdww2RGWa
	THX++IlyT7LZ4UBxFXYRvGq5OsoPrJrSS7/qt62c+JLuvVkY/TtE0t+jyXmVTa9xUwwrX8SQscHyg
	qv5xROA5yccHDRRqEPywFgspgy4FZIdrmEIQbN+Dro37lwl1khuzwlFrKJ9zvFQHUbtQ/77cIQOfk
	fPOLnTLQA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNKYW-0006ju-Ls; Tue, 29 Sep 2020 18:40:52 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNKYT-0006io-Vg
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 18:40:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8750B67373; Tue, 29 Sep 2020 20:40:47 +0200 (CEST)
Date: Tue, 29 Sep 2020 20:40:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 19/20] nvme: refactor nvme_validate_ns
Message-ID: <20200929184047.GJ12948@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-20-hch@lst.de>
 <CY4PR04MB37511A96D7F855F0E3B8C85DE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB37511A96D7F855F0E3B8C85DE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_144050_132338_221B8ED4 
X-CRM114-Status: GOOD (  20.98  )
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

On Mon, Sep 28, 2020 at 03:15:57PM +0000, Damien Le Moal wrote:
> On 2020/09/28 21:35, Christoph Hellwig wrote:
> > Move the logic to revalidate the block_device size or remove the
> > namespace from the caller into nvme_validate_ns.  This removes
> > the return value and thus the status code translation.  Additionally
> > it also catches non-permanent errors from nvme_update_ns_info using
> > the existing logic.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/nvme/host/core.c | 37 +++++++++++++++++--------------------
> >  1 file changed, 17 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 07309f6c14faab..0b88a377a47f6e 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3899,6 +3899,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
> >  	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
> >  		return;
> >  
> > +	set_capacity(ns->disk, 0);
> >  	nvme_fault_inject_fini(&ns->fault_inject);
> >  
> >  	mutex_lock(&ns->ctrl->subsys->lock);
> > @@ -3936,58 +3937,54 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
> >  	}
> >  }
> >  
> > -static int nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
> > +static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
> >  {
> >  	struct nvme_ctrl *ctrl = ns->ctrl;
> >  	struct nvme_id_ns *id;
> > -	int ret = 0;
> > +	int ret = -ENODEV;
> 
> No assignment needed. nvme_identify_ns() will overwrite it.
> 
> >  
> > -	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
> > -		set_capacity(ns->disk, 0);
> > -		return -ENODEV;
> > -	}
> > +	if (test_bit(NVME_NS_DEAD, &ns->flags))
> > +		goto out;

.. but we can already jump to out here, so we do actually need it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
