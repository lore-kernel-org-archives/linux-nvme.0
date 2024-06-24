Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9DEC2BBCA
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jun 2024 05:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eHiV2nKqngvx+qALKESwFfs3axyHInXapW/4dm3TWFo=; b=DVgHgCWMSlpqFOvN6CfImJTJ+W
	JBe5sjLfy5h/f3JLi0bDDKan3jF3H4d7A4EGv3sPG27RxJbJFw2l9V9ac6nFg44onL57QXAiEQT6R
	tF5UlRnbRayA7Qb9TwkbwLSH1bHZXefxDADPz5e7RHEq6mBHByOTwCTtPTPftdT3XZeysniYo73U7
	7zbZyta+v5gqIONxvuvyKey6gPlSYmMtll6MGvOTySWuzBzsZ+RAJhe1Q1FPqCkWYLBBLf0hWoQpa
	dxKOWL3y6CcQRhUu5GGV2hKnRZkaNEfa3/bJ5JzapllIMtu/t2RTJ+lPN15+Wox5PhJiNrRCfgg7b
	43+VoqUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLyIn-00000001cru-0nF1;
	Tue, 25 Jun 2024 05:01:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLlUf-0000000HHuV-2E58;
	Mon, 24 Jun 2024 15:20:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AAC0B68D05; Mon, 24 Jun 2024 17:20:28 +0200 (CEST)
Date: Mon, 24 Jun 2024 17:20:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <cassel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	drbd-dev@lists.linbit.com, nbd@other.debian.org,
	linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, ying.huang@intel.com,
	feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [axboe-block:for-next] [block]  bd4a633b6f:
 fsmark.files_per_sec -64.5% regression
Message-ID: <20240624152028.GA11961@lst.de>
References: <202406241546.6bbd44a7-oliver.sang@intel.com> <20240624083537.GA19941@lst.de> <Znl4lXRmK2ukDB7r@ryzen.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Znl4lXRmK2ukDB7r@ryzen.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_082033_752930_770476C7 
X-CRM114-Status: GOOD (  11.01  )
X-Mailman-Approved-At: Mon, 24 Jun 2024 22:01:05 -0700
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

On Mon, Jun 24, 2024 at 03:45:57PM +0200, Niklas Cassel wrote:
> Seems to be ATA SSD:
> https://download.01.org/0day-ci/archive/20240624/202406241546.6bbd44a7-oliver.sang@intel.com/job.yaml
> 
> ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BG012T4_BTHC428201ZX1P2OGN-part1"
> 
> Most likely btrfs does something different depending on the nonrot flag
> being set or not. (And like you are suggesting, most likely the value of
> the nonrot flag is somehow different after commit bd4a633b6f)

Yes, btrfs does.  That's why I'm curious about the before and after,
as I can't see any way how they would be set differently.  Right now
I can only claim with vitual AHCI devices, which claim to be rotational,
though.


