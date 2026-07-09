Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19CAC43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 10:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:
	Content-Transfer-Encoding:Content-Type:Date:Subject:To:References:
	Mime-Version:Message-Id:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nzPK7Q3qm+3tUE8Y8KFwnXjquoOkl/kUWyXBpYXUuB8=; b=yCvqWrBJgWMNDNX6fBGs7bzosT
	J51tknxXT4novhlgiUL61jN3/6kRjz2chVRxduui+nTmSKS7uplgAg97p6052txqcokQ63n0ClgAg
	gd4NwdARq3CFzcgNYE5eIe2UStCvFz/uBJjbZLCMA8H2rZiJpq/ZPDgMYMHAfo/uLs5iFhE341zUS
	i7q008sUCNuNDYW9jh3uHs5dMeJmSzlVzAq8cGdBrHDwP+wMAI8oJkmgmUXzNNmg3EnlcaVC9n/Hl
	ZNpJ59sJRZeji1vRkZ2ftJVgcszgIDCByH76m1cepNbJ/+dTnsoZrnwCACcObvzPIwraC+MutabSb
	CyLR7YSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whlgY-00000001tSx-3lW9;
	Thu, 09 Jul 2026 10:08:50 +0000
Received: from va-2-59.ptr.blmpb.com ([209.127.231.59])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whlgV-00000001tS8-2LJw
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 10:08:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1783591722;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=nzPK7Q3qm+3tUE8Y8KFwnXjquoOkl/kUWyXBpYXUuB8=;
 b=lmEr59L6hyNDPoexltHX9iycAL/45pk6YoF3XWWsg6Wvx0rwSLZKorXPyguGonelmtu3sE
 2SFPEcoysIMDs3YXsZXF9DIQ7mta8Ukm1vDmj0+cGVbZRE0mBZyjMYpnUpuYXmV7XjRnUC
 eONZHfJJ+Ns3mhhCK59zJJWgCu4Vyjod1zKrlUG/b4BQLAUvG7c8X0yc+qTy2Fp/FYWYh/
 3Myivt1FYf4L5l67F5beixXxczc9s07jswbBqs/CkDlav9ZhKGzZdZaeKWcKxneIdsk0Kf
 auVcM8LVokNBtyNphHUMxjAcQdvowFH8U55ZQUNtxWRmykiEhEAtk2JT4XGIeQ==
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
	<dm-devel@lists.linux.dev>, <linux-bcache@vger.kernel.org>
Message-Id: <75bc21b5-9cc5-4d39-8ba3-7cf69689e438@fygo.io>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a4f7329+7660f4+lists.infradead.org+yukuai@fygo.io>
References: <20260704195124.1375075-1-yukuai@kernel.org> <20260709060959.GA16504@lst.de>
To: "Christoph Hellwig" <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
Subject: Re: [RFC PATCH v1 00/17] blk-cgroup: protect blkgs with blkcg_mutex
Date: Thu, 9 Jul 2026 18:08:36 +0800
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Original-From: yu kuai <yukuai@fygo.io>
Received: from [192.168.1.104] ([39.182.0.144]) by smtp.larksuite.com with ESMTPS; Thu, 09 Jul 2026 10:08:41 +0000
From: "yu kuai" <yukuai@fygo.io>
In-Reply-To: <20260709060959.GA16504@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_030847_655974_65199198 
X-CRM114-Status: GOOD (  12.44  )
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

Hi,

=E5=9C=A8 2026/7/9 14:09, Christoph Hellwig =E5=86=99=E9=81=93:
> On Sun, Jul 05, 2026 at 03:51:07AM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai@fygo.io>
>>
>> This RFC moves queue-local blkg topology synchronization from
>> q->queue_lock to q->blkcg_mutex.
>>
>> q->queue_lock is a hot block-layer spinlock used by request queue runtim=
e
>> paths,
> I don't think it is hot any more.  If it is in one of your workloads
> we have a deep problem somewhere.  That being said, futher removing
> uses of his old catch-all lock is always good, hopefully we can
> eventually remove it entirely.
>
> So this series looks great to me conceptually, but I'm unfortunately
> not a very qualified reviewer for the blk-cgroup code.

Thanks a lot for taking a look at this RFC set, it's very helpful.

It's true that blk-cgroup review is not active for a long time. I'd like to
help but I really don't have time to check every block layer patches.

>
--=20
Thanks,
Kuai

