Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F888C61DB2
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Jun 2025 05:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7AheENJr5i6NdnlHJGBTFCLuwoIOwLRab83eapqX6b0=; b=sGJf8Sn262iNK3oDG7ngl9GoO2
	Uokn+uwRHt/KM+9iszzpQo1tND4yuaUfzU5exPwbpLLvG/MtJb4GlZ1u6M3IKqQj9Sxk5uefYbxiN
	ChFe6NVD98NLMhl/530aLWEib10lTHtu09Tbxl2jTQIh9kxXTLzn3N7XCdFrJ+julclfL8TMznJTF
	LvXT+/i7sWLFFguGa0+unnaaYmsKO6NlCVg6N0vHVIkrP93LyIqrQIOurh/6PKbglP/3pA6XgP1Zn
	fqccpC+hHgpCBRiL7Tmi/43TkbLhr4bQWnIU21IBQJPzmMDQ2nplJSN7XosJnsSmwaJCSdp3a4u8m
	ZIMKZBkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPxPu-0000000FRPE-1OPS;
	Fri, 13 Jun 2025 05:57:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPxP5-0000000FRGQ-1HhA
	for linux-nvme@lists.infradead.org;
	Fri, 13 Jun 2025 05:56:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F3C4268CFE; Fri, 13 Jun 2025 07:56:30 +0200 (CEST)
Date: Fri, 13 Jun 2025 07:56:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, john.g.garry@oracle.com, bmarzins@redhat.com,
	chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
	brauner@kernel.org, martin.petersen@oracle.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 01/10] block: introduce BLK_FEAT_WRITE_ZEROES_UNMAP to
 queue limits features
Message-ID: <20250613055630.GA9119@lst.de>
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com> <20250604020850.1304633-2-yi.zhang@huaweicloud.com> <20250611060900.GA4613@lst.de> <343f7f06-9bf6-442f-8e77-0a774203ec3f@huaweicloud.com> <20250612044744.GA12828@lst.de> <41c21e20-5439-4157-ad73-6f133df42d28@huaweicloud.com> <20250612150347.GK6138@frogsfrogsfrogs> <3569a77f-1f38-4764-b1e3-d0075775c7bb@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3569a77f-1f38-4764-b1e3-d0075775c7bb@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250612_225639_484891_75F8ACF8 
X-CRM114-Status: GOOD (  13.76  )
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

On Fri, Jun 13, 2025 at 11:15:41AM +0800, Zhang Yi wrote:
> Yeah, this solution looks good to me. However, we currently have only
> two selections (none and unmap). What if we keep it as is and simply
> hide this interface if BLK_FEAT_WRITE_ZEROES_UNMAP is not set, making
> it visible only when the device supports this feature? Something like
> below:

I really hate having all kinds of different interfaces for configurations.
Maybe we should redo this similar to the other hardware/software interfaces
and have a hw_ limit that is exposed by the driver and re-only in
sysfs, and then the user configurable one without _hw.  Setting it to
zero disables the feature.


