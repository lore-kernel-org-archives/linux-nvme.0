Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE8DC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Feb 2022 18:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1zFqRS7lGsUI9447tPjr+UyxcPBpVVJrIYKaMONuEZQ=; b=GztC3yltMGP9piJ6Ok2nz5qQaH
	c1Xzjlo7rQ2W/MmhjpZSyGeT+Ajg7IkEINdVbpBucTF24QktKHUpkDZ8/70sVT05Gq68nPhRHZR/v
	UgCr52FdCxMvF2C2pQAlnFdmc6nH5uCpbqomH3z8OoAnWvxB+XAEOfXdoh6rvVmtcnzzgC54GW+yx
	MZ+fBKLQW6T7bhZuFz0MnEPwrUmDBAKceU5dNVdJavfeuVbfc4QdzJNziIOcqVgp4Kq2RZQ/FWK5O
	RavkwHfTh8Lw4UYL5qdijlpmKzGQKv6FAAIy59DU6PEA9khI26I0033gJiZMS8MV5ndL7fIao/a5q
	BVtdKTng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKlqd-00Bn89-J5; Thu, 17 Feb 2022 18:49:47 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nKkua-00BdTP-0U; Thu, 17 Feb 2022 17:49:48 +0000
Date: Thu, 17 Feb 2022 09:49:47 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "hch@lst.de" <hch@lst.de>, "javier@javigon.com" <javier@javigon.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "msnitzer@redhat.com" <msnitzer@redhat.com>,
 "bvanassche@acm.org" <bvanassche@acm.org>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "hare@suse.de" <hare@suse.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "osandov@fb.com" <osandov@fb.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "djwong@kernel.org" <djwong@kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
 "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "arnav.dawn@samsung.com" <arnav.dawn@samsung.com>,
 "nitheshshetty@gmail.com" <nitheshshetty@gmail.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v3 02/10] block: Introduce queue limits for copy-offload
 support
Message-ID: <Yg6Ku8XqnTjvNCrC@bombadil.infradead.org>
References: <20220214080002.18381-1-nj.shetty@samsung.com>
 <CGME20220214080605epcas5p16868dae515a6355cf9fecf22df4f3c3d@epcas5p1.samsung.com>
 <20220214080002.18381-3-nj.shetty@samsung.com>
 <20220217090700.b7n33vbkx5s4qbfq@garbanzo>
 <f0f9317f-839e-2be2-dec6-c5b94d7022b7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0f9317f-839e-2be2-dec6-c5b94d7022b7@nvidia.com>
X-Mailman-Approved-At: Thu, 17 Feb 2022 10:49:45 -0800
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

On Thu, Feb 17, 2022 at 10:16:21AM +0000, Chaitanya Kulkarni wrote:
> On 2/17/22 1:07 AM, Luis Chamberlain wrote:
> >> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> >> index efed3820cbf7..792e6d556589 100644
> >> --- a/include/linux/blkdev.h
> >> +++ b/include/linux/blkdev.h
> >> @@ -254,6 +254,13 @@ struct queue_limits {
> >>   	unsigned int		discard_alignment;
> >>   	unsigned int		zone_write_granularity;
> >>   
> >> +	unsigned long		max_hw_copy_sectors;
> >> +	unsigned long		max_copy_sectors;
> >> +	unsigned int		max_hw_copy_range_sectors;
> >> +	unsigned int		max_copy_range_sectors;
> >> +	unsigned short		max_hw_copy_nr_ranges;
> >> +	unsigned short		max_copy_nr_ranges;
> > 
> > Before limits start growing more.. I wonder if we should just
> > stuff hw offload stuff to its own struct within queue_limits.
> > 
> > Christoph?
> > 
> 
> Potentially use a pointer to structure and maybe make it configurable,

Did you mean to make queue limits local or for hw offload and make that
a pointer? If so that seems odd because even for hw copy offload we
still need the other limits no?

So what I meant was that struct queue_limits seems to be getting large,
and that hw copy offload seems like an example use case where we should
probably use a separate struct for it. And while at it, well, start
adding kdocs for these things, because, there's tons of things which
could use kdoc love.

> although I'm not sure about the later part, I'll let Christoph decide
> that.

  Luis

