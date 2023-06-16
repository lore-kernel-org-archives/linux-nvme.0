Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B661CEB64D8
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jun 2023 07:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WGBSTi4nqYoXhHGJo68O6R3Z4UJdDX6tJAwnPapHVPA=; b=MXj84sA353CJesoDhavRch3deT
	UWsu1uzH3m9hoa8mI7bLLrvqxQ5E6DAJiAiHd4UM2y6peztM+GP6Uyqn4AxeLwQm9qbaUj8dTZ8+n
	smoeZY38gIHEf58DHn0hhh9F7VJFkl+2z7N89VyIWYuM74JkX7I2Vaq67h7kcaydal4BRgnHko9Uo
	3+8gy6FdDAX4F3ONjXT0EsyJs//MJ/ULGnGTtS2jUxfC0MIPYKJaRqWx7d/rkhFqDQ6h8fTwJfyTa
	c38+m32ybS276o06kS7RGPa2rdBZYRCuhzm3Tr8VFHwENRtFB5rMdOTjHdl1CoeicSbe2wbJETCQ8
	N5zVJtDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qA3hT-00H7rh-2z;
	Fri, 16 Jun 2023 07:16:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qA3hP-00H7qS-2O
	for linux-nvme@lists.infradead.org;
	Fri, 16 Jun 2023 07:16:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8D4306732D; Fri, 16 Jun 2023 09:16:36 +0200 (CEST)
Date: Fri, 16 Jun 2023 09:16:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] nvme: forward port sysfs delete fix
Message-ID: <20230616071636.GA29803@lst.de>
References: <20230615152318.3391960-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615152318.3391960-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230616_001647_941540_02374775 
X-CRM114-Status: GOOD (  13.09  )
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

On Thu, Jun 15, 2023 at 08:23:18AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> We had a late fix that modified nvme_sysfs_delete() after the staging
> branch for the next merge window relocated the function to a new file.
> Port commit 2eb94dd56a4a4 ("nvme: do not let the user delete a ctrl
> before a complete") to the latest to avoid a potentially confusing merge
> conflict.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

