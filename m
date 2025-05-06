Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0E6C3ABAC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 06:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XBDUa/scuCJJuyPPmE+3um2K8RapBGwIE+K+7HH95yw=; b=nGPfV76FFvTNnisJny6ZwiMdl6
	YlV0csfTWrfFLOnSHSfOSO+v90bgQnbAohM4g/txrmjWdOtiYt5Zxyotv7OIt86+aLeYZdMlAiFaM
	zVOSZu6fxfnewN/38bYMSLs6pSOa6QRPYL8lSpj3fBNXfTGXOQ+BgV6XrLSzr088EiEZZvR6lMqjv
	9WhqtAtjjQxNJ3HkJR89/PXP+aWGgpsDJGo/U9jlesFnBeMKNFVCP9eb7ADasEb6AcNmzrvoDmTdm
	kVhvCZInDJ7wwtON5cK2Q0MZcH4k1+MJxJeFEHVYwsp7uACPZ3dQgmENF62z1t9tLaxMwGJN3ZZca
	YrqqZjxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCBqJ-0000000AhAP-3IRw;
	Tue, 06 May 2025 06:31:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCB9N-0000000AWI4-0M5T
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 05:47:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 16BA567373; Tue,  6 May 2025 07:47:23 +0200 (CEST)
Date: Tue, 6 May 2025 07:47:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Zhang Yi <yi.zhang@huaweicloud.com>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, john.g.garry@oracle.com, bmarzins@redhat.com,
	chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
	brauner@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
Message-ID: <20250506054722.GA28781@lst.de>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com> <20250421021509.2366003-8-yi.zhang@huaweicloud.com> <20250505132208.GA22182@lst.de> <20250505142945.GJ1035866@frogsfrogsfrogs> <20250506050239.GA27687@lst.de> <20250506053654.GA25700@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506053654.GA25700@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_224729_265820_76FFA0EF 
X-CRM114-Status: GOOD (  17.05  )
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

On Mon, May 05, 2025 at 10:36:54PM -0700, Darrick J. Wong wrote:
> I think STATX_* (i.e. not STATX_ATTR_*) flags have two purposes: 1) to
> declare that specific fields in struct statx actually have meaning, most
> notably in scenarios where zeroes are valid field contents; and 2) if
> filling out the field is expensive, userspace can elect not to have it
> filled by leaving the bit unset.  I don't know how userspace is supposed
> to figure out which fields are expensive.

Yes.

> (I'm confused about the whole premise of /this/ patch -- it's a "fast
> zeroing" fallocate flag that causes the *device* to unmap, so that the
> filesystem can preallocate and avoid unwritten extent conversions?

Yes.

> What happens if the block device is thinp and it runs out of space?
> That seems antithetical to fallocate...)

While the origin posix_fallocate was about space preallocatіon, these
days fallocate seems to be more about extent layout and/or fast
zeroing.

I'm not a huge fan of either this or the hardware atomics as they
force a FTL layer world view which is quite ingrained but also
rather stupid, but some folks really want to go down there full
throttle, so..

