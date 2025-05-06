Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96635C3ABBE
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 15:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z42DKWzQrGFUA4xxtScwUk/kQFCHLo2DdyxI1glwSG4=; b=4aUWNem6vBAy7g7iJ1nhXVlVCE
	pdiLMS1zt8Nx4tO730gxQKggfuOoCSoqMw0xqfk2uY5FOlpxPzp0K0eqgV5hlCc5efMl1S5j2IeiK
	lPRsQiruJIJYvfZ+tezCNLbeg8PFNmRDMC48XEeszXNIJ2VzNlvqS1KJITlpqQhnikcEpw9RaPmEm
	6C2uIC2RnSuu/L73l035FHDZQq3yMAjjI4c2a38sGk84ejaI0j8KHrVkSPidp7dhuiCXieiKOjzFs
	M9+I2YW8u7wDyiKW6tJufsemdF8AM+e8p9Qp/pQeZzgAQN/tMBKlgh+7wQg6whBJ2ppUDpiy0T5Kd
	QjvOyz6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCJwX-0000000CRkZ-49yQ;
	Tue, 06 May 2025 15:10:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCH8c-0000000BrMA-2JQZ
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 12:11:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 27FBC68AA6; Tue,  6 May 2025 14:11:03 +0200 (CEST)
Date: Tue, 6 May 2025 14:11:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, john.g.garry@oracle.com, bmarzins@redhat.com,
	chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
	brauner@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
Message-ID: <20250506121102.GA21905@lst.de>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com> <20250421021509.2366003-8-yi.zhang@huaweicloud.com> <20250505132208.GA22182@lst.de> <20250505142945.GJ1035866@frogsfrogsfrogs> <c7d8d0c3-7efa-4ee6-b518-f8b09ec87b73@huaweicloud.com> <20250506043907.GA27061@lst.de> <64c8b62a-83ba-45be-a83e-62b6ad8d6f22@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64c8b62a-83ba-45be-a83e-62b6ad8d6f22@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_051106_728511_64D065AE 
X-CRM114-Status: GOOD (  14.68  )
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

On Tue, May 06, 2025 at 07:16:56PM +0800, Zhang Yi wrote:
> Sorry, but I don't understand your suggestion. The
> STATX_ATTR_WRITE_ZEROES_UNMAP attribute only indicate whether the bdev
> and the block device that under the specified file support unmap write
> zeroes commoand. It does not reflect whether the bdev and the
> filesystems support FALLOC_FL_WRITE_ZEROES. The implementation of
> FALLOC_FL_WRITE_ZEROES doesn't fully rely on the unmap write zeroes
> commoand now, users simply refer to this attribute flag to determine
> whether to use FALLOC_FL_WRITE_ZEROES when preallocating a file.
> So, STATX_ATTR_WRITE_ZEROES_UNMAP and FALLOC_FL_WRITE_ZEROES doesn't
> have strong relations, why do you suggested to put this into the ext4
> and bdev patches that adding FALLOC_FL_WRITE_ZEROES?

So what is the point of STATX_ATTR_WRITE_ZEROES_UNMAP?


