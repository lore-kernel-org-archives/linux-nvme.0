Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699E2C27C78
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 08:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NyRtEwJ4SZLCWBHsUm/a6ctBPFuyO4BjFg1zxEzh67w=; b=v1O4wxU3v8qM6fVZxwoB5pXEu+
	OItMSS+p26nW2gi0eylh4fZ/4VfTH39bhIytfJ8K6OYCEC4giahwTLaxUNwluTL+1wFuBnxiXx8Qp
	Q9SyVToPUUcWDxFCdu4N05ESsg1ck8A2WhXLVlI1Jh/Jen5Su5B9ZnxShuZUT8gkCxR7nw2D/1+Ew
	Zvcpw+QVed3SY1dgSpISPE4jb5N9Ff5ft5SOD7ZU1mYIdh4hEunuBiVP4OzpxDpJrkoWdq2fZFRVM
	7YgGrmUay1ZOAiO8Xb1osFYDcHjZnG2r0hOHQNVNnLeqUY6CDUnZl0hYyH4qNzhe8xc9wfCShAiKp
	I07Q0jqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGwby-000000080nD-3mB6;
	Tue, 11 Jun 2024 08:12:10 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGwZl-0000000804M-2X3x;
	Tue, 11 Jun 2024 08:09:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7900960D2E;
	Tue, 11 Jun 2024 08:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F729C2BD10;
	Tue, 11 Jun 2024 08:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718093392;
	bh=q0QC/DwdDecsb+SsO2WPgUlAOrUNDUio/s56qnb48bM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ASIoL/u9H/6b4lUyYk5oEzSADY2SPITglYQKbn22RE2v5Zmv+Bdu4yXt2dx4LBuyj
	 NVG1rUDMHnNTWyjPGwlGMS7q0dEKke4PAWQg/UzftKu/Ly2DNOhNfxEkKQj6EFDaHU
	 gbMPLXlbaDGII4KmlbUUWCoStYYGCahBnCwU3sHyUUKQqZ1YdU0vcRocoxwls2ROg2
	 gKF/wxkN6x65ww9rMbS9NJlQNYUg7Y5U2acfwFYdpXRWwDXOcSxo1CVQbqP3uooiqP
	 0hvYmqaICGemmnL938SwljJXBPejQKyIB0+ALAtSSclYdQCRHYhtFi/CQNV4wF5aIA
	 8HiTkYhUDl6Cg==
Message-ID: <d51e4163-99e3-4435-870d-faef3887ab6a@kernel.org>
Date: Tue, 11 Jun 2024 17:09:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/26] block: move the io_stat flag setting to
 queue_limits
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
 <20240611051929.513387-17-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240611051929.513387-17-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_010953_759625_D6434AFA 
X-CRM114-Status: GOOD (  11.25  )
X-Mailman-Approved-At: Tue, 11 Jun 2024 01:12:04 -0700
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
> Move the io_stat flag into the queue_limits feature field so that it
> can be set atomically and all I/O is frozen when changing the flag.

Why a feature ? It seems more appropriate for io_stat to be a flag rather than
a feature as that is a block layer thing rather than a device characteristic, no ?

> 
> Simplify md and dm to set the flag unconditionally instead of avoiding
> setting a simple flag for cases where it already is set by other means,
> which is a bit pointless.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

-- 
Damien Le Moal
Western Digital Research


