Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E64C41513
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 10:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WWjVIb73aPGnSj21KIkV9jfyuMi0dNhpRHNwMUA5nms=; b=UYn1kJGqDDGCOHBTiEsYzb2h1S
	eczAwjrzGA/OuZqqaQG38+ZGyg6SGTOUx1WXoK/YdiH6l3c0MxTsWNaSljxotea5OowWPGwLfgxDh
	L4l1qeTjlotllukoYhsd4AOygUT4furNJ/ZUX3U1b+3LNBU4dVEeExgypAmHHoK2OHqAksChTLgT3
	byJ48QAp/S+56R/REwIff1i9q3htqia3lpWVXUd7mhbSgGzxO14L1+x56SZ2zztP1uq/BxbWLzTIV
	W61OUiQJnQbL51Nij/hHUU8r4/KAydUxowAaX9S2alAMq7TpjxUOuhryah4LS0VAQrbvTyKpcWmfk
	U/WMhXgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGz36-00000008Uzx-42Th;
	Tue, 11 Jun 2024 10:48:20 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGwcZ-0000000815g-3tq3;
	Tue, 11 Jun 2024 08:12:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 3E604CE0988;
	Tue, 11 Jun 2024 08:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85352C2BD10;
	Tue, 11 Jun 2024 08:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718093565;
	bh=zMBbLHWiI0o4/6MjscYA2/ULza201WjvhSMdL22ilmQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=efMUQjqzDR6/6LZgdCczIkMTU67PAqpDM0RBu6vBwxbRTCrqV/SLQPjysAgXVIH+u
	 Gs7FwJjGTrCL01zQP92DMiL3AF1rQHaJ0EqlTORyNynpUYXTzsuY6sJ9mfoqPT1Tvg
	 BSo7cvDW+fM7fvH1aN5LdfHWfYWXWuQSJiOAXVL+z2KUCiOWthz8XV9sMCo6FSpXv+
	 2SHsDignO7grM22XDSxgAJ0znadsNiLDmWusigAzWpriOV5Y9jvSmQhMPwNSEb8Bvj
	 SvInHsx54FSttIPvfIwG30ulL5P3X40mKZipSzOnWLUzNb0kOcJMR/irZgSdTd0fnE
	 LJc4doaBwGC7g==
Message-ID: <a10087ad-8b2c-4a6c-accb-fb1e8015e704@kernel.org>
Date: Tue, 11 Jun 2024 17:12:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/26] block: move the stable_write flag to queue_limits
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
 <20240611051929.513387-18-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240611051929.513387-18-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_011248_189289_55266415 
X-CRM114-Status: GOOD (  10.10  )
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
> Move the io_stat flag into the queue_limits feature field so that it can

s/io_stat/stable_write

> be set atomically and all I/O is frozen when changing the flag.
> 
> The flag is now inherited by blk_stack_limits, which greatly simplifies
> the code in dm, and fixed md which previously did not pass on the flag
> set on lower devices.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Other than the nit above, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


