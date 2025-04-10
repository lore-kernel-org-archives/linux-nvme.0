Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984ADC3601E
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 07:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LCISVMWzMWbLXFt+fVLYQv240tcdvuO+DFTuNa5+7r4=; b=L/WByScewX7rqUQmfeTueJFccU
	VoiO4/iXHJweg68nHKTc+D+88aT8c84YZLD6Z0onAtqg+cgbWyANp7tNEfyUcJ+QrGxmqf4fNIA6k
	SoZCyCQ7Gce1A0MFMv7fGsegmsT8MPMVvs7QALOGTBGPO/Y1VayZSUBl3MZrUv93TtIfjGk/RnpLX
	qnENRBrp4PQWmVx6Oh8kj+SReR8vRLPVNYVUpJ0Hi7YNvo8LtGQuX+axls1jQtK8/nzff9vwfdgYU
	jx0bEkKsIGPIeV/kI0ObvMxIDSvtC0iw99689nUcZudNC03uvuy08Nb0c9OpqmyS0IzNgUSdIrbsp
	w14YNMAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2mie-00000009dCl-0EsA;
	Thu, 10 Apr 2025 07:53:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2m8r-00000009VPs-2kTZ
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 07:16:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4668E68BFE; Thu, 10 Apr 2025 09:16:00 +0200 (CEST)
Date: Thu, 10 Apr 2025 09:15:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu, djwong@kernel.org,
	john.g.garry@oracle.com, bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH -next v3 01/10] block: introduce
 BLK_FEAT_WRITE_ZEROES_UNMAP to queue limits features
Message-ID: <20250410071559.GA32420@lst.de>
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com> <20250318073545.3518707-2-yi.zhang@huaweicloud.com> <20250409103148.GA4950@lst.de> <43a34aa8-3f2f-4d86-be53-8a832be8532f@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43a34aa8-3f2f-4d86-be53-8a832be8532f@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_001605_884763_3A28F9DA 
X-CRM114-Status: GOOD (  19.32  )
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

On Thu, Apr 10, 2025 at 11:52:17AM +0800, Zhang Yi wrote:
> 
> Thank you for your review and comments. However, I'm not sure I fully
> understand your points. Could you please provide more details?
> 
> AFAIK, the NVMe protocol has the following description in the latest
> NVM Command Set Specification Figure 82 and Figure 114:
> 
> ===
> Deallocate (DEAC): If this bit is set to ‘1’, then the host is
> requesting that the controller deallocate the specified logical blocks.
> If this bit is cleared to ‘0’, then the host is not requesting that
> the controller deallocate the specified logical blocks...
> 
> DLFEAT:
> Write Zeroes Deallocation Support (WZDS): If this bit is set to ‘1’,
> then the controller supports the Deallocate bit in the Write Zeroes
> command for this namespace...

Yes.  The host is requesting, not the controller shall.  It's not
guaranteed behavior and the controller might as well actually write
zeroes to the media.  That is rather stupid, but still.

Also note that some write zeroes implementations in consumer devices
are really slow even when deallocation is requested so that we had
to blacklist them.

> Were you saying that what is described in this protocol is not a
> mandatory requirement? Which means the disks that claiming to support
> the UNMAP write zeroes command(WZDS=1,DRB=1), but in fact, they still
> write actual zeroes data to the storage media? Or were you referring
> to some irregular disks that do not obey the protocol and mislead
> users?

The are at least allowed to.


