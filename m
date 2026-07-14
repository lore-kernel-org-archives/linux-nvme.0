Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F78C43458
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2026 01:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Type:In-Reply-To:Cc:To:Content-Transfer-Encoding:Date:From:
	Mime-Version:Message-Id:Subject:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MXAT3+5slbifSjkkzpCjT7TTJaAwUZJ8MfqgEo/pHc0=; b=NHMiG2QXtd6aiVLJAoZLvSj6MK
	baZtZMWGg7JBaNczEh20RFo2+Sz9jh04qcDW9mlKmFLXfak/7x4r/ECzEKzsJGUGgrsUHP9DTG5EV
	0yUO5G3/eUYjJ2zkMcneFElB+fRaNzYVk5L5MaKw1R9w4KwiUP7u3Bpr3R7FzHpnwCOfhlRJTGPSl
	jWBtdbX1ZDOunNPjZEVE4ct5NcZe+l+MkhRO4eA3gjHpe/B0aGwu20VbB+aFZQ0ZvTXR9BDGXbcTe
	2W5Ur9tUg054F6/N2T+TqqzIZbGD9eNK5irdXcnEwrairIoL+7ZTx+uEE7Tz0Q/QOWPsr1WSgTY8m
	L82rHp3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjRqh-0000000AfFq-2pJN;
	Tue, 14 Jul 2026 01:22:15 +0000
Received: from va-2-41.ptr.blmpb.com ([209.127.231.41])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjRqY-0000000AfEr-3f87
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jul 2026 01:22:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1783992117;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=MXAT3+5slbifSjkkzpCjT7TTJaAwUZJ8MfqgEo/pHc0=;
 b=CsJkfioZOfCKThBtkoFIqreHboAirqKwBEj69z/tsxUahDElsQl9i8Qq2wZGtQFC4vonXn
 tWWCqZI9aFONnkCoGrW2IOvX/kMubR9mLGaTQS6Ch8sHTYNkGIUER6Xc1hvHZKlL1h/bPi
 iCiVONZE8SU1oFJrvn2j8Q4tJ6GJWInKG5nevT4RT9C+qPjypZLMNH6QWrOBLl4Yd7v/dB
 qmwlFLyVkvVI23fjTTo9NA96ob3JK/6cLszMo86b1HtQmYoQ3i0QSSvc4zOGoov7h4mafa
 bQZb0LM89e/+gOH4L+Sn2WhWWnrMUKge8gH2IZWi0advUSoDqkZc6cg0BX8khw==
Subject: Re: [RFC PATCH v1 01/17] nvme-multipath: retarget failedover bios from requeue work
Message-Id: <e0ba356e-c5ef-4100-b774-b599cae65968@fygo.io>
Mime-Version: 1.0
From: "yu kuai" <yukuai@fygo.io>
Date: Tue, 14 Jul 2026 09:21:50 +0800
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: quoted-printable
To: "Christoph Hellwig" <hch@lst.de>, "Hannes Reinecke" <hare@suse.de>
Cc: "Jens Axboe" <axboe@kernel.dk>, "Tejun Heo" <tj@kernel.org>, 
	"Keith Busch" <kbusch@kernel.org>, "Sagi Grimberg" <sagi@grimberg.me>, 
	"Alasdair Kergon" <agk@redhat.com>, 
	"Benjamin Marzinski" <bmarzins@redhat.com>, 
	"Mike Snitzer" <snitzer@kernel.org>, 
	"Mikulas Patocka" <mpatocka@redhat.com>, 
	"Dongsheng Yang" <dongsheng.yang@linux.dev>, 
	"Zheng Gu" <cengku@gmail.com>, "Coly Li" <colyli@fygo.io>, 
	"Kent Overstreet" <kent.overstreet@linux.dev>, 
	"Josef Bacik" <josef@toxicpanda.com>, 
	"Nilay Shroff" <nilay@linux.ibm.com>, <linux-block@vger.kernel.org>, 
	<cgroups@vger.kernel.org>, <linux-nvme@lists.infradead.org>, 
	<dm-devel@lists.linux.dev>, <linux-bcache@vger.kernel.org>, 
	"yu kuai" <yukuai@fygo.io>
X-Original-From: yu kuai <yukuai@fygo.io>
In-Reply-To: <20260713121244.GA20084@lst.de>
X-Lms-Return-Path: <lba+26a558f34+ea9440+lists.infradead.org+yukuai@fygo.io>
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.1.104] ([39.182.0.157]) by smtp.larksuite.com with ESMTPS; Tue, 14 Jul 2026 01:21:56 +0000
References: <20260704195124.1375075-1-yukuai@kernel.org> <20260704195124.1375075-2-yukuai@kernel.org> <0ded62a6-b3da-4790-adf0-566ded30ee43@suse.de> <20260713121244.GA20084@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_182206_986974_75ADEDB9 
X-CRM114-Status: GOOD (  16.16  )
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
Reply-To: yukuai@fygo.io
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi=EF=BC=8C

=E5=9C=A8 2026/7/13 20:12, Christoph Hellwig =E5=86=99=E9=81=93:
> On Mon, Jul 13, 2026 at 11:29:35AM +0200, Hannes Reinecke wrote:
>> On 7/4/26 9:51 PM, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai@fygo.io>
>>>
>>> bio_set_dev() is about to become explicitly sleepable because it can
>>> associate the bio with a blkg for the destination queue.  NVMe failover
>>> can run from request completion context, and nvme_failover_req() also h=
olds
>>> head->requeue_lock with interrupts disabled while it steals bios from t=
he
>>> failed request.  Calling bio_set_dev() there is not safe once the helpe=
r is
>>> allowed to sleep.
>>>
>>> The requeue lock only protects head->requeue_list.  Keep the list
>>> manipulation under that lock, but defer retargeting to nvme_requeue_wor=
k(),
>>> which already drains the list from process context before resubmitting =
each
>>> bio.  The bios remain private to the requeue list until the worker pops
>>> them, so moving the device switch there preserves the existing retry fl=
ow
>>> while avoiding a sleepable helper in completion context.
>>>
>>> Signed-off-by: Yu Kuai <yukuai@fygo.io>
>>> ---
>>>    drivers/nvme/host/multipath.c | 4 +---
>>>    1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipat=
h.c
>>> index 9b9a657fa330..76baa180ae1c 100644
>>> --- a/drivers/nvme/host/multipath.c
>>> +++ b/drivers/nvme/host/multipath.c
>>> @@ -149,7 +149,6 @@ void nvme_failover_req(struct request *req)
>>>    	struct nvme_ns *ns =3D req->q->queuedata;
>>>    	u16 status =3D nvme_req(req)->status & NVME_SCT_SC_MASK;
>>>    	unsigned long flags;
>>> -	struct bio *bio;
>>>      	nvme_mpath_clear_current_path(ns);
>>>    	atomic_long_inc(&ns->failover);
>>> @@ -165,8 +164,6 @@ void nvme_failover_req(struct request *req)
>>>    	}
>>>      	spin_lock_irqsave(&ns->head->requeue_lock, flags);
>>> -	for (bio =3D req->bio; bio; bio =3D bio->bi_next)
>>> -		bio_set_dev(bio, ns->head->disk->part0);
>> If you remove this the original device remains being referenced by
>> the bio, so there might be a chance of some accidentally referencing
>> the (now invalid) bdev.
>> I think it might be better if you were set it to NULL here, to
>> signal that this bio currently has no bdev associated.
> What should reference it?  This moves setting bi_bdev from the only
> place adding to the list to the only place removing from the list.

I'll follow your advice to move blkg association to bio submit. And this pa=
tch
will not be needed anymore.

>
--=20
Thanks,
Kuai

