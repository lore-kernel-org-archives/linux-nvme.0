Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DAFC25B76
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 08:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XnkBdRyeKEq8GatAdP4gEuJwY7uWBuIGWyjm2pfwk3o=; b=tqmbJoV9s9C4OJPBwRwhaeFL1z
	BNREoG0SVqsVdqQdIRiY0HIz0OVwwWJ65ulzW/g2Qvi+VtBG8pbyEtXoc1mJ3oDsIQbfk7q1b0kU8
	MbY4EckQeixSh8R/KFDId5Xd9Kpz8+yitAs7lyuvdXpaajN5h0+cA2ayT8PYeNlBv9YLzsS4tBiHa
	UTDpHDk7L1o/Gz+JXsOAXzXeDMFXJ5urQcyB77w2KHraWqqKxcaq7Yazkgqe/zzhEbpV009dEXU6y
	xlD9ikUeZ7AObBwWR6Bq4LPpeNAYUYi/X5w2OusZ2BlxJdn+GDf1GpokZZNB5iqk8F1JA4n4fFeEB
	e9ERkiTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGwTh-00000007yDr-1wK9;
	Tue, 11 Jun 2024 08:03:37 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGwSj-00000007xdX-0mrX;
	Tue, 11 Jun 2024 08:02:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 58DC4CE10F6;
	Tue, 11 Jun 2024 08:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD55C2BD10;
	Tue, 11 Jun 2024 08:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718092954;
	bh=9448E2ZQUrvNp7ZURrtI3/D86m7bLK+HS2+4F3/kAbo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cVm1t8g2Dmo9pyaeFexP0cVZp2V9+zrzLaosx0fHWpCgyVMjhJafz/YjIRFcP6e/N
	 JiQrRCWm2cXvKJW25gK4jKXdI9z1r5PiGAPnVoL3Jgi9iLA+RTBXO3LhS10/kQ9VJv
	 S0HFEAZmlsLJdqInbsOGCHZ7lARtlpYV0wnusyawzuHxpb/RclmLX5rlq1DxBTsAuq
	 DUc+w0vOa4IhkCXuAcAxPK35SsjdXOHX0tyGNoT44IBIj7FNuzH/TkqH47YX1TuM03
	 t8bqET45kpSSPx+5HvwwYL7yfxY/bG8VgPBzRal4b99z62CNkY4oDCrnC6ah7dxmTJ
	 PwVnGOKYPVpoA==
Message-ID: <01366bae-699e-45dc-bad1-9541883a8b42@kernel.org>
Date: Tue, 11 Jun 2024 17:02:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/26] block: move the nonrot flag to queue_limits
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
 <20240611051929.513387-15-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240611051929.513387-15-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_010237_512888_E7A4CFDB 
X-CRM114-Status: GOOD (  15.18  )
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
> Move the norot flag into the queue_limits feature field so that it can be

s/norot/nonrot

> set atomically and all I/O is frozen when changing the flag.

and... -> with the queue frozen when... ?

> 
> Use the chance to switch to defaulting to non-rotational and require
> the driver to opt into rotational, which matches the polarity of the
> sysfs interface.
> 
> For the z2ram, ps3vram, 2x memstick, ubiblock and dcssblk the new
> rotational flag is not set as they clearly are not rotational despite
> this being a behavior change.  There are some other drivers that
> unconditionally set the rotational flag to keep the existing behavior
> as they arguably can be used on rotational devices even if that is
> probably not their main use today (e.g. virtio_blk and drbd).
> 
> The flag is automatically inherited in blk_stack_limits matching the
> existing behavior in dm and md.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Other than that, looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


