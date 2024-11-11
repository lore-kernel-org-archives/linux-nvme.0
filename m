Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F367D12D72
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 05:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E9TAGddGr04DKHMAWvBXkp0e/n7vIxoctF6ZyiSscEo=; b=m4AJD2qSJ+luhYqQuacBznTjov
	/7qVw1Yi5AVhFCzV9jp70u5uVgLC2e37QKBFsAIFbi0XM2UzFhJSC0OavAMCVfT+qSPXdqfVRkW3q
	2no7feeAhVZSNF3fQdoF8IBLNuT2C5Ns1V+i0vypQEAa8hOp+nAMhC0Kc+7r9sm7EO+OSdNtM+ka9
	/+fAp25x4UYcZ00BDWtJGwjPLE41lHC9Cl+pt/ZyJrW9Bj48Oqm+S5g98+2gLvdAV9CTYpdszwB2z
	jttQhxpiVfzHwOlAV996R0sUj315lGr74ngK7PPhvjUlk6AuuvILqcB+tRbanfcreh/BpatM2ZOXe
	xKD2+O0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tANC2-0000000GPbR-3OTe;
	Mon, 11 Nov 2024 05:42:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tANBz-0000000GPap-1I2i
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 05:42:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8291C68C7B; Mon, 11 Nov 2024 06:42:21 +0100 (CET)
Date: Mon, 11 Nov 2024 06:42:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	m@bjorling.me, matias.bjorling@wdc.com, kch@nvidia.com
Subject: Re: [PATCHv4 13/13] nvmet: report ns's vwc not present
Message-ID: <20241111054221.GB22853@lst.de>
References: <20241107193849.995554-1-kbusch@meta.com> <20241107193849.995554-14-kbusch@meta.com> <20241108142743.GG6694@lst.de> <Zy45M1HRz8cKLPxf@kbusch-mbp> <005617fc-656d-4180-87b8-c9ebc8bff48d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005617fc-656d-4180-87b8-c9ebc8bff48d@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_214227_510135_9FCE24D8 
X-CRM114-Status: GOOD (  10.77  )
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

On Sat, Nov 09, 2024 at 10:59:19PM +0800, Guixin Liu wrote:
>> 	if ((req->ns->file && !req->ns->buffered_io &&
>> 		bdev_write_cache(file_inode(req->ns->file)->i_sb->s_bdev))
>
> Or just remove !req->ns->buffered_io check? All file backend return
>
> support vwc.

Yes, that is the right thing to do.


