Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A4DC25B76
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 08:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ctBnGEWb4xTElDcHASFARzyWucAY4J0d+x/m/foxXs8=; b=PH0qcwXMMkyYWr15CvLnnGkxdd
	bBAk+ixPI4RereRn88sszvRgY0tuiWFdCSBUfr8qteZznILitsxGmlLeBuzvLK7OmHurAd11Gls23
	elcR3lY7b/yB8Iq7cF6GecKQEq1EFf/CR79Ya2ccF3cuELp11y2wpGOlywogX8Np+C7AYjx5oT4qZ
	z0J85tZd7j/yS32yJG/TErP3M6ZA2qidYq2P95jqvb9j4nc0dSNw1aVM9BNcuSH3QbZWdPx/yqFX6
	eByJczVQo7zAjYKoktMK0qwBEs1wt0Fw0AwIM3RvNA3PrSR8ybeb6hpus+U2qfvoq9qrA/wZOdZ8k
	2sQNWmHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGwTB-00000007xqC-2zvO;
	Tue, 11 Jun 2024 08:03:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGvoV-00000007pGe-14es;
	Tue, 11 Jun 2024 07:21:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5EAFE60C76;
	Tue, 11 Jun 2024 07:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B857C2BD10;
	Tue, 11 Jun 2024 07:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718090461;
	bh=SxGiXC2eXjeuicvqjgmxBbbuRkQDAALVXqGltltCvpM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J9t/JghW0gR/ETwdzjpl7VD7KnwAlMW8rRhwZr9kxWhQ6tl8Phg9WjO76NiKxxgu8
	 fLxeqF9M5t6BVVC5kK/sKL3zR1K2qLPoyVha6i0EJluUzp1kNJ5g2TNKh8g+EJPN33
	 hrljcXVnUuN8Lr5KlIujiAJZzEJDuCsFcPLl3jPutPmhKf9R0GeNiPNem29bg2OBO7
	 a1cFWzw0qNt9DSnc6yLqLEresNea8LBs8q7/++QEaUosyu+AjkSi/+C9VElPN9n7PP
	 XlPsIxsXYvBqYod+WVUBRRvW1FiyVSTv+Mlz8E7DodnwczmTJdbU3tnt32fP5VZhAs
	 3tDYxoJTsEL7w==
Message-ID: <6bf90562-0ff9-46b6-8a58-7381332e3beb@kernel.org>
Date: Tue, 11 Jun 2024 16:20:54 +0900
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
 <20240611055239.GA3141@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240611055239.GA3141@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_002103_459371_0383DFEA 
X-CRM114-Status: GOOD (  11.30  )
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

On 6/11/24 2:52 PM, Christoph Hellwig wrote:
> On Tue, Jun 11, 2024 at 02:51:24PM +0900, Damien Le Moal wrote:
>>> -	if (lim->zoned)
>>> +	if (sdkp->device->type == TYPE_ZBC)
>>
>> Nit: use sd_is_zoned() here ?
> 
> Yes.
> 
>>> -	if (!sd_is_zoned(sdkp))
>>> +	if (!sd_is_zoned(sdkp)) {
>>> +		lim->zoned = false;
>>
>> Maybe we should clear the other zone related limits here ? If the drive is
>> reformatted/converted from SMR to CMR (FORMAT WITH PRESET), the other zone
>> limits may be set already, no ?
> 
> blk_validate_zoned_limits already takes care of that.

I do not think it does:

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

So setting lim->zoned to false without clearing the other limits potentially
will trigger warnings...

-- 
Damien Le Moal
Western Digital Research


