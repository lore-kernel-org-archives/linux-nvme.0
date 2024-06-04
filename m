Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AE9C27C53
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jun 2024 07:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R2qcYpI0mFvLOvr2gk3eng5jTPbZVJ51W4GKMgvY9to=; b=xsbWUCo7XGyX73wCOgah6T/iU2
	DHQCq+EXW4ibyfcuWFZp+p9avl4cAdr5cEaqaTwswlmtt3eR3QI5pyoQjI4z84mSXojfaTzdJgE0o
	wBneNN8VFDaBYqkHPpvKcVYRLvgcRkb0K3RuVg8Uy9MNNwc83HHhbXeduto57veIVy4qVV15Se6Gb
	ay9vXNpFkFGmovBoRMo7HbkE3g13HiPysMuclt7uRwpPjAEHcmQU/31CNyG9NU/SWmCJdKmKHRArp
	jYy/vNgH69M5+YoZ7ZgSO8aXswAAvN3AJ0Uu0/J5dxvzfsGz7UL4iZtf+9BfHAaM8b/w+nVCWr3P0
	EzMzAtDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEOlb-00000001XwU-0Rf8;
	Tue, 04 Jun 2024 07:39:35 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEOlX-00000001Xvn-404B
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 07:39:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 236B06116E;
	Tue,  4 Jun 2024 07:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11995C32782;
	Tue,  4 Jun 2024 07:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717486770;
	bh=IwRk73FI7oCSvA9GoThk9eEnhOPDGRbbqcPOdPVc2Uw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GI261o576gg25/lggqNDA2SfXlSJn3QRY7AGVwcyAmBUOY2+2/Skb/bS1BUCh9qWl
	 QKz3Jh5M82o5F/6PUgsBq0Gsh7DHrbgUxYPptG+VI9WDVVcsarzvpz92mvCFUSRn4w
	 dsA3PAUnRTIlKggNkbrr+yewxURwwu2pgA4udfQ7PsravITSz0hF0RNkvPEsXjrDW0
	 wgwdLoaBdgKRYI4xl7pgSc9vSh2CdAzwjhxH4xcArykbw0zJHnERyQlz+xAu/TMLtL
	 Yd9pQ9MINSEdazBen1lLjskybIkbgnHTDxCdtLFQWOH/x3vJ71IiKQwnw36Gv4Ljfd
	 jhhldACaNEbJQ==
Message-ID: <5441b256-494a-4344-89fd-ee8c5a073f8b@kernel.org>
Date: Tue, 4 Jun 2024 16:39:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 00/12] Implement copy offload support
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
 damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240604043242.GC28886@lst.de>
 <393edf87-30c9-48b8-b703-4b8e514ac4d9@suse.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <393edf87-30c9-48b8-b703-4b8e514ac4d9@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_003932_142888_F387898B 
X-CRM114-Status: GOOD (  16.62  )
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

On 6/4/24 16:16, Hannes Reinecke wrote:
> On 6/4/24 06:32, Christoph Hellwig wrote:
>> On Mon, Jun 03, 2024 at 10:53:39AM +0000, Nitesh Shetty wrote:
>>> The major benefit of this copy-offload/emulation framework is
>>> observed in fabrics setup, for copy workloads across the network.
>>> The host will send offload command over the network and actual copy
>>> can be achieved using emulation on the target (hence patch 4).
>>> This results in higher performance and lower network consumption,
>>> as compared to read and write travelling across the network.
>>> With this design of copy-offload/emulation we are able to see the
>>> following improvements as compared to userspace read + write on a
>>> NVMeOF TCP setup:
>>
>> What is the use case of this?   What workloads does raw copies a lot
>> of data inside a single block device?
>>
> 
> The canonical example would be VM provisioning from a master copy.
> That's not within a single block device, mind; that's more for copying 
> the contents of one device to another.

Wouldn't such use case more likely to use file copy ?
I have not heard a lot of cases where VM images occupy an entire block device,
but I may be mistaken here...

> But I wasn't aware that this approach is limited to copying within a 
> single block devices; that would be quite pointless indeed.

Not pointless for any FS doing CoW+Rebalancing of block groups (e.g. btrfs) and
of course GC for FSes on zoned devices. But for this use case, an API allowing
multiple sources and one destination would be better.

-- 
Damien Le Moal
Western Digital Research


