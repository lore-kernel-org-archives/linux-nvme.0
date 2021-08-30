Return-Path: <SRS0=Glcz=NV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB91C432BE
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 21:09:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFDE460724
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 21:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EFDE460724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AKgZxsEtQKN5MoYQu+5qQ5GCLMsH1AHuoBTcXGrnFGk=; b=uIu4jrM0x9RZ5u
	4zywRLAU0vAcAWSq4w/bPuZ2xsxZSlkS5KXpGVu2VwFpO/QHhdoMpSI6T7o1JlqpJnTwUqURIkQMF
	pwclHSQ65pry3Z8vReozfAc+sO/SlKKKQ/m/xAIW2BmLfaYsWKfKE/c6XsYeoV7GvD0T0VSNJTHee
	Q3Uvljg838WA9VAan6WcNPcgHzlRR0VEXGzg6eSwmFcsrAahw05/gLLR6GQ5PPaIRWD9nZBPWeUsx
	jsV/Cbg+N+52t7fBD4q42OkcaI2VlDVHBFF3mIlBsj1Z93PCOczSCqx/KXG0bTFK8G5ZnFABjAbdk
	OEtmeMfDLNit9mgQ5nJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mKoWU-000bKZ-Nt; Mon, 30 Aug 2021 21:08:54 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mKoWS-000bKI-22; Mon, 30 Aug 2021 21:08:52 +0000
Date: Mon, 30 Aug 2021 14:08:52 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, colyli@suse.de, kent.overstreet@gmail.com,
 sagi@grimberg.me, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, dave.jiang@intel.com, ira.weiny@intel.com,
 konrad.wilk@oracle.com, roger.pau@citrix.com,
 boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org,
 minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
 xen-devel@lists.xenproject.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-bcache@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] nvme-multipath: add error handling support for
 add_disk()
Message-ID: <YS1I5DuGr0q7/uow@bombadil.infradead.org>
References: <20210827191809.3118103-1-mcgrof@kernel.org>
 <20210827191809.3118103-4-mcgrof@kernel.org>
 <20210827202932.GA82376@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210827202932.GA82376@dhcp-10-100-145-180.wdc.com>
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

On Fri, Aug 27, 2021 at 01:29:32PM -0700, Keith Busch wrote:
> On Fri, Aug 27, 2021 at 12:18:02PM -0700, Luis Chamberlain wrote:
> > @@ -479,13 +479,17 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
> >  static void nvme_mpath_set_live(struct nvme_ns *ns)
> >  {
> >  	struct nvme_ns_head *head = ns->head;
> > +	int rc;
> >  
> >  	if (!head->disk)
> >  		return;
> >  
> > -	if (!test_and_set_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
> > -		device_add_disk(&head->subsys->dev, head->disk,
> > -				nvme_ns_id_attr_groups);
> > +	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
> 
> This should still be test_and_set_bit() because it is protecting against
> two nvme paths simultaneously calling device_add_disk() on the same
> namespace head.

Interesting, I'll add a comment as well, as this was not clear with the drive
by effort.

  Luis

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
