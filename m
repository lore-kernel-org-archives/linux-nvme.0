Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DA7C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 02:50:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45670613F6
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 02:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45670613F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=g3ZQy0+TzLN9tFR5KtiTG6TKUwSn4YsNdOsbuYEtM7U=; b=ajsrudnSf9Vq2YYeaBuEW7ie3
	Uis/Zl7ICQIKZc+CiZPUFWBqYR1174cLRgXy40QwiAcnX1XOWVVZYUnPtfG2J35vjKdkJ08q6WUNW
	/xjEQvvsVFwbVOw27S9Qpb8JZJH2zpVIM3TNBdM8ePng3gsseeK/VlXir/VfpWyTGoW8UJc2l+mZ6
	E7TSj1LHZ8xU3vd6QsmeTaTPIMwDHVvp36xYp89IJTq8FGrtctJULKuZ3zQF4UOXSGXy5mtCw0Onc
	0kaFm4cxAnV9xUhARG65Huk5fAPn9EnCMU8Lt2qjnyiPbpvtOobqmzNusMvp8NfbzU/Fybfh0mF2t
	3eo4Uz7/g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhNuQ-006zoG-VT; Fri, 14 May 2021 02:50:39 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhNuL-006zmr-Bv
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 02:50:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ATg9q/M6jvlElwevit8ADJAeDzZb4eSVOxZKtBlWVtE=; b=0uLSnMjKHPGq5D63L4XZYDj1o6
 6b8h6eBk9XV/UQcp0dEZsw/k/uQvLILMsCRhJHgvTKHhBjOGgnfq4BKoy/3mo0aZbcN+bn/JlnkTp
 De+ev+nBrPWR+KSeMUIo54QytzOcqSNVKZdnbm3jrSkJx8Rg1NOb7Rk3CP8vNISS4++1+FJogwWbI
 Mg6YhI57kFfFMSU6Rpv+cABw+QxsIuikinNVvpxdxexRLzNRTknYkYQvrsRzOPx1vmP8wp3qmIDq/
 9DqYRC/S/tiil7axednwUCH9IElxpItiPlts1GdoNvJ2XM4QSlq1CQNOIazp1nFDl8M1I2L52RPhC
 fO/szVbg==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhNuI-00BfuV-7g
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 02:50:31 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3180661406;
 Fri, 14 May 2021 02:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620960629;
 bh=NdnNFHHJEnnVdOQS/NvyN81+kLTnIQhndpEaWGvbIkM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=p6lg52MiipVtHKORxFKkxhPtjHOMJuM+qn04bKswzW9CL7/CqGNe4jNQbkFgdAoLP
 +at4jzGXLiC5kGM4fUIhaDb5VvTqvkYYqk7+jgPUE9lg3fgU+clX8uazEmGnRMk/JK
 Z8+0/K69+GopRHaKSyibsg6Mc5rYtoiAMxr5CZ+qjykLUKuX27oU5wW0cs1MrPDzjJ
 WoHCZmck9TnWq9z+MZt9NIGlJvatXD1+N1l7SNoFkDCsSyCNyH4hbHRxbo+74GlrL4
 C7wyheFxd6X+hYYo0CgdFSreX9JIVTpf+9VNyZMdn7xL4UPtb/HxCS/mt+NV6eLHck
 aoQhiOuvX9Y0A==
Date: Thu, 13 May 2021 19:50:26 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 12/15] block: switch polling to be bio based
Message-ID: <20210514025026.GA2447336@dhcp-10-100-145-180.wdc.com>
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-13-hch@lst.de>
 <45d66945-165c-ae48-69f4-75dc553b0386@grimberg.me>
 <20210512221237.GA2270434@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210512221237.GA2270434@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_195030_321985_4DF64D81 
X-CRM114-Status: GOOD (  26.76  )
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

On Wed, May 12, 2021 at 03:12:37PM -0700, Keith Busch wrote:
> On Wed, May 12, 2021 at 03:03:40PM -0700, Sagi Grimberg wrote:
> > On 5/12/21 6:15 AM, Christoph Hellwig wrote:
> > > + *
> > > + * Note: the caller must either be the context that submitted @bio, or
> > > + * be in a RCU critical section to prevent freeing of @bio.
> > > + */
> > > +int bio_poll(struct bio *bio, unsigned int flags)
> > > +{
> > > +	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> > > +	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
> > > +
> > > +	if (cookie == BLK_QC_T_NONE ||
> > > +	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
> > > +		return 0;
> > > +
> > > +	if (current->plug)
> > > +		blk_flush_plug_list(current->plug, false);
> > > +
> > > +	/* not yet implemented, so this should not happen */
> > > +	if (WARN_ON_ONCE(!queue_is_mq(q)))
> > 
> > What happens if the I/O wasn't (yet) queued to the bottom device
> > (i.e. no available path in nvme-mpath)?
> > 
> > In this case the disk would be the mpath device node (which is
> > not mq...)
> 
> The bi_cookie should remain BLK_QC_T_NONE in that case, so we wouldn't
> get to the warning. But if that does happen, it doesn't appear that
> anyone is going to wake up thread that needs to poll for this bio's
> completion when a path becomes available for dispatch. I think it would
> make sense for nvme-mpath to just clear the REQ_POLLED flag if it
> doesn't immediately have viable path.

It looks like there is a way to hit this warning. If you induce a path
error to create a failover, the nvme-mpath will reset the bio's bdev to
the mpath one, which is not MQ. I can occaisionally hit it with a fault
injection test.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
