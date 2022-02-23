Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC86C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Feb 2022 06:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UHKUXaQs83hzUDt8v+U00kEJvR6ZOsIIGcwG7EVaZYM=; b=F/z+5GZmlBPNzxr0xMOcfYZWSt
	k2ucX2/4p74Te/jAbRA1YB+lrvJHL2jdCcUqGdqnSd2wgHdB8xN6X6Sl7OEkKHeFDHv/RwriNmr40
	qT6Y1Cf1L5BY46vpIyvPV0wJlw6p8wvmXlmMT7Gl6qhFvmcDFHy9rWQrjRfrpECA9nkjT70BOsR0c
	mkkQWHP37Oj0hfFzGuky7rDtDAs6/uZwxVCq8qyFIVX28ln+CUHcQ3clL4Efi9NS0cvW3G4uEekOu
	obMxsL3yco6omo5Lw/iF5bZwyns8O4FAvJLnG6BrP0XpzBHqm4SZnucQz3jxKREj/oQ4Thr5figBN
	fYPilZjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMkze-00Cwc9-41; Wed, 23 Feb 2022 06:19:18 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nMfwT-00C2dS-Pt; Wed, 23 Feb 2022 00:55:41 +0000
Date: Tue, 22 Feb 2022 16:55:41 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: hch@lst.de, javier@javigon.com, chaitanyak@nvidia.com,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, axboe@kernel.dk, msnitzer@redhat.com,
 bvanassche@acm.org, martin.petersen@oracle.com, hare@suse.de,
 kbusch@kernel.org, Frederick.Knight@netapp.com, osandov@fb.com,
 lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
 josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
 jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
 nitheshshetty@gmail.com, SelvaKumar S <selvakuma.s1@samsung.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/10] block: Introduce queue limits for copy-offload
 support
Message-ID: <YhWGDUyQkUcE6itt@bombadil.infradead.org>
References: <20220214080002.18381-1-nj.shetty@samsung.com>
 <CGME20220214080605epcas5p16868dae515a6355cf9fecf22df4f3c3d@epcas5p1.samsung.com>
 <20220214080002.18381-3-nj.shetty@samsung.com>
 <20220217090700.b7n33vbkx5s4qbfq@garbanzo>
 <20220217125901.GA3781@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217125901.GA3781@test-zns>
X-Mailman-Approved-At: Tue, 22 Feb 2022 22:19:07 -0800
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

On Thu, Feb 17, 2022 at 06:29:01PM +0530, Nitesh Shetty wrote:
>  Thu, Feb 17, 2022 at 01:07:00AM -0800, Luis Chamberlain wrote:
> > The subject says limits for copy-offload...
> > 
> > On Mon, Feb 14, 2022 at 01:29:52PM +0530, Nitesh Shetty wrote:
> > > Add device limits as sysfs entries,
> > >         - copy_offload (RW)
> > >         - copy_max_bytes (RW)
> > >         - copy_max_hw_bytes (RO)
> > >         - copy_max_range_bytes (RW)
> > >         - copy_max_range_hw_bytes (RO)
> > >         - copy_max_nr_ranges (RW)
> > >         - copy_max_nr_ranges_hw (RO)
> > 
> > Some of these seem like generic... and also I see a few more max_hw ones
> > not listed above...
> >
> queue_limits and sysfs entries are differently named.
> All sysfs entries start with copy_* prefix. Also it makes easy to lookup
> all copy sysfs.
> For queue limits naming, I tried to following existing queue limit
> convention (like discard).

My point was that your subject seems to indicate the changes are just
for copy-offload, but you seem to be adding generic queue limits as
well. Is that correct? If so then perhaps the subject should be changed
or the patch split up.

> > > +static ssize_t queue_copy_offload_store(struct request_queue *q,
> > > +				       const char *page, size_t count)
> > > +{
> > > +	unsigned long copy_offload;
> > > +	ssize_t ret = queue_var_store(&copy_offload, page, count);
> > > +
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	if (copy_offload && !q->limits.max_hw_copy_sectors)
> > > +		return -EINVAL;
> > 
> > 
> > If the kernel schedules, copy_offload may still be true and
> > max_hw_copy_sectors may be set to 0. Is that an issue?
> >
> 
> This check ensures that, we dont enable offload if device doesnt support
> offload. I feel it shouldn't be an issue.

My point was this:

CPU1                                       CPU2
Time
1) if (copy_offload 
2)    ---> preemption so it schedules      
3)    ---> some other high priority task  Sets q->limits.max_hw_copy_sectors to 0
4) && !q->limits.max_hw_copy_sectors)

Can something bad happen if we allow for this?


