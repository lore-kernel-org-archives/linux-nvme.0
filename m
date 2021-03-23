Return-Path: <SRS0=jrCY=IV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD6FC433C1
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 14:54:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A049D6197F
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 14:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A049D6197F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZOsKsTE5OVH8ZEHMm/yM2k0AGSlNpl1xLv1g9insGQ8=; b=md7Ytn0PL7v6fnFB4RqWXpk7W
	eYQ3wMvTi7MugWzwdvD+t1nCyjBmXwLSSvUZFTgRwVLuufOFOIlA0kt62CEEhXG2sZGG7KGh9Zdv+
	knPOuGxI5rsRptXrMnMK+C6aZaaWuC7BVPf0O1ZB/H8uUbPreMKvVT7XnAAxXs3Hn1XiGeIp6S7X3
	Y8eprrjWOsPcuMzx3wUhATTskIgQvS0i+/5szSsZHhCCl+ypsmlPI38H84a8oeOqAGOUUEZOhjsbY
	l8p5X3AbqioZSojopEFRoF44opEMQBDYCqTLdiyAIpwUu4Kdn1o6MoJ9u9Q3tTOUzGZql9Iu3MSA0
	vubJhF1iw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOiPg-00FCdm-PM; Tue, 23 Mar 2021 14:53:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOiPa-00FCcj-OW
 for linux-nvme@lists.infradead.org; Tue, 23 Mar 2021 14:53:40 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A56D860232;
 Tue, 23 Mar 2021 14:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616511217;
 bh=h5LZB7DGfoEeckCd6NF3dO8C/UBNfhNOFjdcQ4pFMt4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fUeIkHRN1lvzu9REhSjwjHepwClYcjwIyh2KpHpjtDLX2h1KiSJfJD5TGvNMnPsr2
 QqIYGHbPwd98xYrzTgH9Mzk3x6MH0UjqxjqNxYTqwGaiufZ7IMiH5TZfwUDdn9rOty
 v3HcpSj7iI7fH2Xxfbcie+7MxzLmQ6rpmnxp4vrGjhBdvVKZLN6WlLpSaKdIOQHOtI
 dMh1FEYp01HKZ/k9XcnP0Da5Gjv6DZnG9jhX1Yg4PhdiPbvHOLoUnXhwED3t5sAlxm
 7sYKw6FCzJ2y5gegAq55rTo3ZNx6BFtQ7HBKD7BmqPOssaNcMRBrC/zMjPE0az1exN
 f9euHlxucs8ww==
Date: Tue, 23 Mar 2021 23:53:30 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Chao Leng <lengchao@huawei.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of
 the underlying device
Message-ID: <20210323145330.GB21687@redsun51.ssa.fujisawa.hgst.com>
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
 <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
 <c064b296-c25c-3731-cbbd-f99ab93e6bd2@suse.de>
 <608f8198-8c0d-b59c-180b-51666840382d@grimberg.me>
 <250dc97d-8781-1655-02ca-5171b0bd6e24@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <250dc97d-8781-1655-02ca-5171b0bd6e24@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210323_145339_141165_BBEA807D 
X-CRM114-Status: GOOD (  23.74  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 23, 2021 at 09:36:47AM +0100, Hannes Reinecke wrote:
> On 3/23/21 8:31 AM, Sagi Grimberg wrote:
> > =

> > > Actually, I had been playing around with marking the entire bio as
> > > 'NOWAIT'; that would avoid the tag stall, too:
> > > =

> > > @@ -313,7 +316,7 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
> > > =A0=A0=A0=A0=A0=A0=A0=A0 ns =3D nvme_find_path(head);
> > > =A0=A0=A0=A0=A0=A0=A0=A0 if (likely(ns)) {
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bio_set_dev(bio, ns-=
>disk->part0);
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bio->bi_opf |=3D REQ_NVME=
_MPATH;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bio->bi_opf |=3D REQ_NVME=
_MPATH | REQ_NOWAIT;
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 trace_block_bio_rema=
p(bio, disk_devt(ns->head->disk),
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bio->bi_iter.bi_sector);
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D submit_bio_n=
oacct(bio);
> > > =

> > > =

> > > My only worry here is that we might incur spurious failures under
> > > high load; but then this is not necessarily a bad thing.
> > =

> > What? making spurious failures is not ok under any load. what fs will
> > take into account that you may have run out of tags?
> =

> Well, it's not actually a spurious failure but rather a spurious failover,
> as we're still on a multipath scenario, and bios will still be re-routed =
to
> other paths. Or queued if all paths are out of tags.
> Hence the OS would not see any difference in behaviour.

Failover might be overkill. We can run out of tags in a perfectly normal
situation, and simply waiting may be the best option, or even scheduling
on a different CPU may be sufficient to get a viable tag  rather than
selecting a different path.

Does it make sense to just abort all allocated tags during a reset and
let the original bio requeue for multipath IO?

 =

> But in the end, we abandoned this attempt, as the crash we've been seeing
> was in bio_endio (due to bi_bdev still pointing to the removed path devic=
e):
> =

> [ 6552.155251]  bio_endio+0x74/0x120
> [ 6552.155260]  nvme_ns_head_submit_bio+0x36f/0x3e0 [nvme_core]
> [ 6552.155271]  submit_bio_noacct+0x175/0x490
> [ 6552.155284]  ? nvme_requeue_work+0x5a/0x70 [nvme_core]
> [ 6552.155290]  nvme_requeue_work+0x5a/0x70 [nvme_core]
> [ 6552.155296]  process_one_work+0x1f4/0x3e0
> [ 6552.155299]  worker_thread+0x2d/0x3e0
> [ 6552.155302]  ? process_one_work+0x3e0/0x3e0
> [ 6552.155305]  kthread+0x10d/0x130
> [ 6552.155307]  ? kthread_park+0xa0/0xa0
> [ 6552.155311]  ret_from_fork+0x35/0x40
> =

> So we're not blocked on blk_queue_enter(), and it's a crash, not a deadlo=
ck.
> Blocking on blk_queue_enter() certainly plays a part here,
> but is seems not to be the full picture.
> =

> Cheers,
> =

> Hannes
> -- =

> Dr. Hannes Reinecke                Kernel Storage Architect
> hare@suse.de                              +49 911 74053 688
> SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
> HRB 36809 (AG N=FCrnberg), Gesch=E4ftsf=FChrer: Felix Imend=F6rffer

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
