Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9845FC27C65
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 08:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BrvK38h0HHhYIEYN/khxv0CLpldYlc67KqvYz1sGjfY=; b=u9Vg1CkFnQRIUIwl9f7jptPdCe
	dTblidtwaJN4ZTvm9ZD5cXcujJQBDOhS3oXeH0aGXnu1CrhwdquoLvr3dsK9ClquZ8bHZjf98ORRv
	jbK83WcRyO62/IncUO03ATQfo/VwmxSSM9fjVYdD8nu6EhsEQeLd2+OEU+pu1dBLJtFdVE9IQ0QkN
	XSMxNuUsxWU2eGfsCEKzDlZY0zHeZ45mQUdg3bLGXKH8mvOQDsKqeGGMVxpUBWbLGv7ZN5XxEGnkm
	gziJyrECnVPRwI04Kd50Ew9JYpuHjV99t8FrM3CrzQFQu8rNXWa4N6vdQ5ozS6OVbLaex2C6wZG8I
	+d4xiVLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGwTE-00000007xs8-48hj;
	Tue, 11 Jun 2024 08:03:08 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGvuA-00000007q8L-0c8t;
	Tue, 11 Jun 2024 07:26:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9B23CCE19AB;
	Tue, 11 Jun 2024 07:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CA5C2BD10;
	Tue, 11 Jun 2024 07:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718090811;
	bh=HG5UcXVYc2pVMu2PGi4iUFqByljMapi6PfR/6ZqBwfo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lhYNStRMJNPVo8fichD7Z0COMh5KCSazuVjE6/0APdy+3x8aX6d+I4Uw+ap69ZwAp
	 3u5aa7mjFdEVQyfJG5WY+eMXxSD+64OfuIlIsHMpLDbrxnp9UPUkR/yayj5dU13RXh
	 23qGW6mbrSQ4iFRccSriB2Li9Cf3c2qv3X/apL7b2mQFQrd0/fuwpUhAaRGZ1yOusP
	 n79nDvyWzKvLB0HpWl65/GKtJMfxc7ZpotjxL9zrrr1dQ3UsAtGXJa69S+Dlnhewkx
	 FHwdj5ZYnFJw9FRojR+8wLW1FYdzAyPRpPQ7jZN/hjLct6+Y9JYli0WJbtrwanSHKq
	 GWPNeceTmkiMQ==
Message-ID: <b3a0692c-05f2-459d-9bed-33b7aa3d79c0@kernel.org>
Date: Tue, 11 Jun 2024 16:26:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/26] virtio_blk: remove virtblk_update_cache_mode
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Richard Weinberger <richard@nod.at>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
 Yu Kuai <yukuai3@huawei.com>, Vineeth Vijayan <vneethv@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org,
 drbd-dev@lists.linbit.com, nbd@other.debian.org,
 linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20240611051929.513387-1-hch@lst.de>
 <20240611051929.513387-9-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240611051929.513387-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_002654_727506_A98DB099 
X-CRM114-Status: UNSURE (   7.27  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Tue, 11 Jun 2024 01:03:01 -0700
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

On 6/11/24 2:19 PM, Christoph Hellwig wrote:
> virtblk_update_cache_mode boils down to a single call to
> blk_queue_write_cache.  Remove it in preparation for moving the cache
> control flags into the queue_limits.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


