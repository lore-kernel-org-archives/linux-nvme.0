Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63E4C25B75
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jun 2024 04:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wq9h64sXZl/JCj5YAKVk8E8trDqhDHlO0equhx95LuA=; b=pgcgoEu+T3QScH1Fauhz0AvUqJ
	FIiR/GFkTCRSxCX/PuOCgGe5NOxASsXEEaXQQImehxEeWxdCj6tfMfaHvDmCcEKKoJmYQh1twJpQ0
	pvGDVPu1RkUgeGUStS5cTzPSu803ra9xIIdIBtjcsOUFW1+LpxGSZ5gPdmeVcAcSinBUc/i/JcWmK
	/HEl5NJzeIi1cQjKk7AIA8C1Asu0ifmbv/M3OCLUZghQpwcvah3C87v5YBLXC2zqOgGI6JlY1hMu3
	sJy4Bu+QAxL0YLxv5pzSSEpmm2LAbVTfcCTJaXV8qQe9zq8c+nMgKpusbp4P/OYYE784iveZX1szp
	ko4n0eVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF55T-00000008M01-0brj;
	Thu, 06 Jun 2024 04:50:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF55Q-00000008Lz5-0BuT
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jun 2024 04:50:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3713968CFE; Thu,  6 Jun 2024 06:50:49 +0200 (CEST)
Date: Thu, 6 Jun 2024 06:50:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 04/12] block: remove the blk_integrity_profile structure
Message-ID: <20240606045048.GC8395@lst.de>
References: <20240605063031.3286655-1-hch@lst.de> <20240605063031.3286655-5-hch@lst.de> <fee6338e-4aae-456c-90a3-228a19fae58a@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fee6338e-4aae-456c-90a3-228a19fae58a@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_215052_248356_9421C72A 
X-CRM114-Status: GOOD (  16.65  )
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

On Wed, Jun 05, 2024 at 10:31:27AM -0600, Bart Van Assche wrote:
>> +	case BLK_INTEGRITY_CSUM_CRC64:
>> +		if (bi->flags & BLK_INTEGRITY_REF_TAG)
>> +			return "EXT-DIF-TYPE1-CRC64";
>> +		return "EXT-DIF-TYPE3-CRC64";
>> +	default:
>> +		return "nop";
>> +	}
>> +}
>
> Since bi->csum_type has an enumeration type, please leave out the "default:"
> and move return "nop" outside the switch statement. This will make the
> compiler issue a warning if a new enumeration label would be added without
> updating the above switch statement. Otherwise this patch looks good to me.

For that to work you'd need to make csum_type the enum type and not an
unsigned char, which would bloat the block limits.  You'd also need to
keep the return "nop" where it is, but use the explicit case instead of
the default.


