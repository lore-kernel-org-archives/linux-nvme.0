Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D188CC25B76
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 10:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CgcblUpzyUwbJkITE/Ew+ODNfANKL5vFh4qMmuNo50M=; b=xk3oZeKiF/DyfFB0qyPiebrqeE
	KFgPhfsXq5GBiJtI2EMSB4cAmhklZJXsM2mOWw+gc2ZTsm14F2xx6KDVuMSxZ+FJMrNT7bpyW0VqZ
	f1FkC2r+NZrWkX2PeqczNfqE+pnp2HLOC8lph/5Dl5LUWAZU6OhOIkcAc3W1b5KWGBLNuU2WMapT8
	1Sh00A0mOiOIQd619vQYwvr3C3HHLO0O4u1ITv6SFd9SanyORYv1Ctsca4XhJCVGL/vLovGxDpnVx
	1MHcDvRnCQxuvuki7XT8IvuHVSHTYuvYPVp7kXjFNh1jphWrKzaqE2QUoPgcRB+mGxjmyXVqp/uvp
	1DXlcfZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGz3B-00000008V1w-10vV;
	Tue, 11 Jun 2024 10:48:25 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGwgN-000000082X7-2rDG;
	Tue, 11 Jun 2024 08:16:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E04C060C3E;
	Tue, 11 Jun 2024 08:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A204C2BD10;
	Tue, 11 Jun 2024 08:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718093802;
	bh=0xCsZy2WAGO31vOt2jMux3XsQG5JzkwMLoCsgqbDM7s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BshMQEOFKHQCAeU7Uq7D/QqRf+yvZZUvvFAljFVHRMbxOyzti+TjMe0D1IJKi9gMV
	 zyUA+05eoWqeEmhuLL8uoXj2uFvoj39+EiUXirtXWtXQFdTuvV4hWDH4qLaMCjLfy+
	 AnqgnZ0xCGWpIVHNkCHGqby5QcQzPelY2FXqqGrtk4KASWZEpNZldaxiF+wB3Rw9dc
	 xbMnzOX/e3WR+yoGOTEoauLs/X9V3dTUosPnw+YpOF05bIeErHzOz8DqMDnd798OeG
	 g23Oj4HG5YREgeqkRw2UIxm1G6V2rlg7SUCDzzjKvw7jq8xou/AYaSDtybrj1/IgEi
	 S8SrLRUjTG4qQ==
Message-ID: <4845aae8-ad03-407e-bf31-f164b8f684d4@kernel.org>
Date: Tue, 11 Jun 2024 17:16:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/26] block: move the nowait flag to queue_limits
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
 <20240611051929.513387-20-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240611051929.513387-20-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_011643_852483_52DECB4C 
X-CRM114-Status: GOOD (  12.22  )
X-Mailman-Approved-At: Tue, 11 Jun 2024 03:48:16 -0700
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
> Move the nowait flag into the queue_limits feature field so that it
> can be set atomically and all I/O is frozen when changing the flag.
> 
> Stacking drivers are simplified in that they now can simply set the
> flag, and blk_stack_limits will clear it when the features is not
> supported by any of the underlying devices.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>


> @@ -1825,9 +1815,7 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
>  	int r;
>  
>  	if (dm_table_supports_nowait(t))
> -		blk_queue_flag_set(QUEUE_FLAG_NOWAIT, q);
> -	else
> -		blk_queue_flag_clear(QUEUE_FLAG_NOWAIT, q);
> +		limits->features &= ~BLK_FEAT_NOWAIT;

Shouldn't you set the flag here instead of clearing it ?

-- 
Damien Le Moal
Western Digital Research


