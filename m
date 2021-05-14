Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C746C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 16:26:46 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B00F61206
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 16:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B00F61206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=S5V548VoYgDdLZrZzG5e4K1yyxjZE49bA1sZfqBJiNk=; b=POvLUU+D/7onEN4n78xsCCOHU
	OApYuA2HS/ra/CDucDQ5ZpvUIjX5LAFXPVq7I2yGV+OyDiPbANB4x8hxEAnY3fMN4sI9g1M3GgK3N
	/gzU6oP1Jsr+UW19M6+bSTFWSOT8eaUIuQZ5JnotF26QZm7wrXH2ZC6k1omLTC58Ac1VrWflQrp7s
	pyEKa0JTU7vqqAlgpBAee6KNQq20cRy++ZZiEoR+6c1pearEuPMLdAnUv6Uijt+YY9wMItX5h56JK
	oAYJy7dQCJUE1c0BTzDlJ1YLdBhaBrY2DRYSW5lFd54YJqqF3+UnSl/CcQt/cPUiCq0vOuXjYxa2D
	cX5vBsKYQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhado-008UP3-8z; Fri, 14 May 2021 16:26:20 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhadm-008UNy-1Y
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 16:26:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=CTNespe6PPe/i44lMZgRLkW9j2gGSddth+ZiOh+Cd4A=; b=hvJ2nwGDrQidiASLSROp1YfdoY
 mcctu+ZC1LXRd1Xozm1NrvXNVMFxGAjdaAbZTnGHSOHVaouuslWYww4ni0UX8AEHEPd6piNru9Ras
 A1kMXMdlk+G2aawPbL6ZLE8slGzFMouxXdVz4BIVTrxfHSygFApQEDbTg6IiZFwIICF8DjkOOoOaU
 1tIrRcAJqSXB4tD1Ji5UPrwKZkcwfU/4iqHXpqTmb63gKvUA/e/PTgMObdBkgA3yE3CW+Y70NAfQk
 DUxsQd8PONt0tOrKQCpf5OXftlLsEqiwtp2BxqX4K4E4ltHMJLMxK2L52i2i+tbdE8Sg4dOhqNSrL
 TIRGN6kg==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhadj-00C7AH-Bj
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 16:26:16 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42950613F1;
 Fri, 14 May 2021 16:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621009575;
 bh=BmQjlO9W718wi8igXBtPXxdqosqGpUfGqz6z39ZK124=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Y98hyR4cMYKLTCUQNVrSCzmNI9ZVf0gmaoYwlQUp4e6NdRX+Po6JSRHrYoqot739E
 OIJ3gpo+RadN2lv8ZgEeKdb0vuEMLL7fk0c4ywdYndOCt1mxXfC4N1idPM3dLQNagm
 J1P6OWZS0F93bpKOShBHiZGEiwufHiEjf57wWg+zVMmxeWuQWqiuy7Fqa+PbTY7ys4
 fDul0qPlHqtayyLCEEADZZXjaK9EGu54lPnyRDOD5inU76/TXNK3KpAL0RN6njDwwE
 aSamaf4+CTuKNwhsVMtVmYwhzJGwT2hs7aPSrgIJmeDbuwpWk7w/nYkIUSOugHDoAH
 +1+YMURMeQ+iA==
Date: Fri, 14 May 2021 09:26:12 -0700
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
Message-ID: <20210514162612.GA2706199@dhcp-10-100-145-180.wdc.com>
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-13-hch@lst.de>
 <45d66945-165c-ae48-69f4-75dc553b0386@grimberg.me>
 <20210512221237.GA2270434@dhcp-10-100-145-180.wdc.com>
 <20210514025026.GA2447336@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210514025026.GA2447336@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210514_092615_461775_BB994259 
X-CRM114-Status: GOOD (  36.46  )
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

On Thu, May 13, 2021 at 07:50:26PM -0700, Keith Busch wrote:
> On Wed, May 12, 2021 at 03:12:37PM -0700, Keith Busch wrote:
> > On Wed, May 12, 2021 at 03:03:40PM -0700, Sagi Grimberg wrote:
> > > On 5/12/21 6:15 AM, Christoph Hellwig wrote:
> > > > + *
> > > > + * Note: the caller must either be the context that submitted @bio, or
> > > > + * be in a RCU critical section to prevent freeing of @bio.
> > > > + */
> > > > +int bio_poll(struct bio *bio, unsigned int flags)
> > > > +{
> > > > +	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> > > > +	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
> > > > +
> > > > +	if (cookie == BLK_QC_T_NONE ||
> > > > +	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
> > > > +		return 0;
> > > > +
> > > > +	if (current->plug)
> > > > +		blk_flush_plug_list(current->plug, false);
> > > > +
> > > > +	/* not yet implemented, so this should not happen */
> > > > +	if (WARN_ON_ONCE(!queue_is_mq(q)))
> > > 
> > > What happens if the I/O wasn't (yet) queued to the bottom device
> > > (i.e. no available path in nvme-mpath)?
> > > 
> > > In this case the disk would be the mpath device node (which is
> > > not mq...)
> > 
> > The bi_cookie should remain BLK_QC_T_NONE in that case, so we wouldn't
> > get to the warning. But if that does happen, it doesn't appear that
> > anyone is going to wake up thread that needs to poll for this bio's
> > completion when a path becomes available for dispatch. I think it would
> > make sense for nvme-mpath to just clear the REQ_POLLED flag if it
> > doesn't immediately have viable path.
> 
> It looks like there is a way to hit this warning. If you induce a path
> error to create a failover, the nvme-mpath will reset the bio's bdev to
> the mpath one, which is not MQ. I can occaisionally hit it with a fault
> injection test.

Oh, and it gets a bit worse. Using pvsync2 will block forever once this
warning is hit, or if nvme-mpath had to requeue the IO for lack of a
path. io_uring doesn't have that hang problem though.

Christoph, I think patch 15 needs something like this:

---
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 7febdb57f690..d40a9331daf7 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -419,6 +419,11 @@ static void nvme_requeue_work(struct work_struct *work)
 		 * path.
 		 */
 		bio_set_dev(bio, head->disk->part0);
+
+		if (bio->bi_opf & REQ_POLLED) {
+			bio->bi_opf &= ~REQ_POLLED;
+			bio->bi_cookie = BLK_QC_T_NONE;
+		}
 		submit_bio_noacct(bio);
 	}
 }
--

This should fix the hang since requeued bio's will use an interrupt
driven queue, but it doesn't fix the warning. The recent commit
"nvme-multipath: reset bdev to ns head when failover" looks like it
makes preventing the polling thread from using the non-MQ head disk
not possible.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
