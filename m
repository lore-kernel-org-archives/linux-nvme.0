Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C8EC3ABAC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 15:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RG+1T7AZdIIwYYTAt6II47UwYwglJwRSZ5faAB2oKRA=; b=VI+9TfHqIMGcR0bro2IPp+jOFU
	TE5EZJzSdlqtlQnYAtgJNtlsqDY3+2BFjaA1XaDuQ5nXMX7b4tSPz3BaeQba/5rH60BwPNcR6T+ze
	vfacaRJqc22wo3vDfGog49ZtRniUWQNeudymKaMcyBgneBRyUFmqu7q1iEMf+XWPc4Qa2o1FxvgV7
	invzdbj+BUOm13vRRNIXeg4MfxBU6Y5PuPb1lm0mbQVG8A4ZeNhayjsEyU2oeCAZNPTdAk5zQwJ0E
	D9cN35RT5GKtGtoo9jGb2Yka2eZ/gh8+BYmMI6H1kG65hAfYvMPaqfbzIP0jHGVvFq6MEBMa2XSkw
	b2uzw4Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCJwX-0000000CRkO-1jG0;
	Tue, 06 May 2025 15:10:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCH7v-0000000Br86-0mnR
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 12:10:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 49E8368AA6; Tue,  6 May 2025 14:10:12 +0200 (CEST)
Date: Tue, 6 May 2025 14:10:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>, dhowells@redhat.com,
	brauner@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, john.g.garry@oracle.com, bmarzins@redhat.com,
	chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
Message-ID: <20250506121012.GA21705@lst.de>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com> <20250421021509.2366003-8-yi.zhang@huaweicloud.com> <20250505132208.GA22182@lst.de> <20250505142945.GJ1035866@frogsfrogsfrogs> <20250506050239.GA27687@lst.de> <20250506053654.GA25700@frogsfrogsfrogs> <20250506054722.GA28781@lst.de> <c3105509-9d63-4fa2-afaf-5b508ddeeaca@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3105509-9d63-4fa2-afaf-5b508ddeeaca@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_051023_366767_91FC970F 
X-CRM114-Status: UNSURE (   9.88  )
X-CRM114-Notice: Please train this message.
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

On Tue, May 06, 2025 at 07:25:06PM +0800, Zhang Yi wrote:
> +       if (request_mask & STATX_WRITE_ZEROES_UNMAP &&
> +           bdev_write_zeroes_unmap(bdev))
> +               stat->result_mask |= STATX_WRITE_ZEROES_UNMAP;

That would be my expectation.  But then again this area seems to
confuse me a lot, so maybe we'll get Christian or Dave to chim in.


