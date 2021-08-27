Return-Path: <SRS0=9COT=NS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9EAC432BE
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 18:33:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89E84601FF
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 18:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 89E84601FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F0MbFEQ7NhV4c1BZkxu/UdieJy60xKDhWGIjxiRSCXU=; b=UGvKcRaUeMr/dW
	UaZhmwTHrqrgjPVTG5uaBMut2A4Fl6TO4cTf2QCqqtwg34Lxe0JyOg6Hm1yjPLSoHHRvNYC20ftSh
	udT6D3POSAmwIBWdEZLXtElOGfEVuQcZgM8UrEbSm+yEjhmQibeY6VvaCvZ1jW+DzHcSifaPtOM3/
	H0C+cqSsYNVAjYCiQIRvKf/SXfDBuOfueR6sEayaAtjSyVjN6m+FsVycb1PziUDnHn/ipLKwebBMK
	cVjmRw8jfkzvBszCIAcn/QtRW8Xtd8NDVTHUG5P8pu9QcGaGgSU9vARHGBZ6RKeuM2PO2FeWQtDrB
	zkdYhl37C6j1SG9cyeyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mJges-00CxwM-I0; Fri, 27 Aug 2021 18:32:54 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mJgeq-00Cxw6-V7; Fri, 27 Aug 2021 18:32:52 +0000
Date: Fri, 27 Aug 2021 11:32:52 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
 kbusch@kernel.org, sagi@grimberg.me, adrian.hunter@intel.com,
 beanhuo@micron.com, ulf.hansson@linaro.org, avri.altman@wdc.com,
 swboyd@chromium.org, agk@redhat.com, snitzer@redhat.com,
 josef@toxicpanda.com, hare@suse.de, bvanassche@acm.org,
 ming.lei@redhat.com, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-mmc@vger.kernel.org,
 dm-devel@redhat.com, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] nvme: add error handling support for add_disk()
Message-ID: <YSkv1GtmFgvQ81Up@bombadil.infradead.org>
References: <20210823202930.137278-1-mcgrof@kernel.org>
 <20210823202930.137278-6-mcgrof@kernel.org>
 <YSSNIaYpUhrkvC+J@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YSSNIaYpUhrkvC+J@infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 24, 2021 at 07:09:37AM +0100, Christoph Hellwig wrote:
> On Mon, Aug 23, 2021 at 01:29:25PM -0700, Luis Chamberlain wrote:
> > +	rc = device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups);
> > +	if (rc)
> > +		goto out_cleanup_ns_from_list;
> > +
> 
> Nit: no real need for the rc variable here as we never use the actual
> value.

Alrighty.

> >  	if (!nvme_ns_head_multipath(ns->head))
> >  		nvme_add_ns_cdev(ns);
> >  
> > @@ -3785,6 +3789,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
> >  
> >  	return;
> >  
> > + out_cleanup_ns_from_list:
> > +	down_write(&ctrl->namespaces_rwsem);
> > +	list_del_init(&ns->list);
> > +	up_write(&ctrl->namespaces_rwsem);
> 
> This also needs to do a nvme_put_ctrl.

Fixed.

  Luis

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
