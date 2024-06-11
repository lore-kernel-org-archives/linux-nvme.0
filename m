Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3321C25B76
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 08:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LUcYTrpA+B5VNV91G4ttPyRDpWFIUJd+vfVbsxlfzLY=; b=Eter0HjCJt1VwiC/KzER3cLyVF
	ZI59aBXNgvhbXP3rylQ0+dcCZurKfJrv/b8B34V22/xJxE/Qm+FNld7u8/GGI6boCl2tjzmYWNU/m
	bQ3AUkFYQCYM08d4SOe2GjXVlIzD5cNeuuKPrF3S1kdNEoH592Yb1eDdViYDOS52hP71UVHtdBTv3
	UVpvOEzBSvqePUKtZ5XWunP64A+rfWHBBHSNS0qNmeKifAyuEVQipL/shwsg1NERLgCIZ1RWZXaTg
	QUp+kR6ycqX4j3Hwo3bZNIvv3zfEX3r+c9ALOVsbG+g7xQHT+8Wwm/pYIhdBo0TkkvEuhz+8mP8Da
	sG8jEaFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGwTD-00000007xr3-2bhG;
	Tue, 11 Jun 2024 08:03:07 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGvsk-00000007psk-2tuX;
	Tue, 11 Jun 2024 07:25:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B2D1CCE19E4;
	Tue, 11 Jun 2024 07:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F46C2BD10;
	Tue, 11 Jun 2024 07:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718090724;
	bh=SKDzpdZjTAHkWp+zsEQwH6Ky8PVIUSEQggaioawXXkU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UCtiHiiw5QvJYmElyhHUIvI9qZN2kq7wHApTDMzEobrX5tFMllUF7QgwTYv0VDSQe
	 4AvJZ9Xc1WQTZynkZ5eqZVN35p41xaFCgmlC7UMaLIvvCM36uO+T8E3D8B2kWkrwrw
	 CxnQ5rfAOwcQk9F3stXF5NyYVqFnlDWOGrsxEQrWt2LCiqL+fvPkUXoNp9aPDrZKK/
	 Jf1WpJR5Tfo8C4kN4+IDjAFgA3wv+/TYcPyqih/c85wJGX2v2SpjxCABdfzaKWUWw8
	 mwFNFCAMG5oIrZT1WMKm7NaX1XpI2tHzzzRuvurRNs7Kd2xxeNWyHz9cxkpcbZ5fhc
	 X7SraO1QML8XQ==
Message-ID: <92df5033-5df7-4b2a-98ad-a27f8443ee6a@kernel.org>
Date: Tue, 11 Jun 2024 16:25:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/26] sd: move zone limits setup out of
 sd_read_block_characteristics
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Richard Weinberger <richard@nod.at>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Christoph B??hmwalder <christoph.boehmwalder@linbit.com>,
 Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Roger Pau Monn?? <roger.pau@citrix.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
 Vineeth Vijayan <vneethv@linux.ibm.com>,
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
 <20240611051929.513387-3-hch@lst.de>
 <40ca8052-6ac1-4c1b-8c39-b0a7948839f8@kernel.org>
 <20240611055239.GA3141@lst.de> <20240611055405.GA3256@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240611055405.GA3256@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_002527_119400_287E1F67 
X-CRM114-Status: GOOD (  13.11  )
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

On 6/11/24 2:54 PM, Christoph Hellwig wrote:
> On Tue, Jun 11, 2024 at 07:52:39AM +0200, Christoph Hellwig wrote:
>>> Maybe we should clear the other zone related limits here ? If the drive is
>>> reformatted/converted from SMR to CMR (FORMAT WITH PRESET), the other zone
>>> limits may be set already, no ?
>>
>> blk_validate_zoned_limits already takes care of that.
> 
> Sorry, brainfart.  The integrity code does that, but not the zoned
> code.  I suspect the core code might be a better place for it,
> though.

Yes. Just replied to your previous email before seeing this one.
I think that:

static int blk_validate_zoned_limits(struct queue_limits *lim)
{
        if (!lim->zoned) {
                if (WARN_ON_ONCE(lim->max_open_zones) ||
                    WARN_ON_ONCE(lim->max_active_zones) ||
                    WARN_ON_ONCE(lim->zone_write_granularity) ||
                    WARN_ON_ONCE(lim->max_zone_append_sectors))
                        return -EINVAL;
                return 0;
        }
	...

could be changed into:

static int blk_validate_zoned_limits(struct queue_limits *lim)
{
	if (!lim->zoned) {
                lim->max_open_zones = 0;
		lim->max_active_zones = 0;
		lim->zone_write_granularity = 0;
		lim->max_zone_append_sectors = 0
		return 0;
	}

But then we would not see "bad" drivers. Could have a small

blk_clear_zoned_limits(struct queue_limits *lim)

helper too.

-- 
Damien Le Moal
Western Digital Research


