Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E12D5C0E1
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 15:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=2BXMVz80omfmN0to34KmSiItLp
	xcImm07wE0eei5CLgQAiS9Kvxb6m7OYjvDrwOjXvzBtwekYOH+aXstZ7LEAbf538BQzPXfw64FMjA
	wZhN6JioT7kIB9cIHDV+bC5sJ403RvbVDZiH+Nm2L27vucWLS1YPFsu5hVmVAYTdZ5phXTumYegje
	hhMvJwQfJ8ZNrB/oeiBWC/k8Zy8clle1VNv5jxy9rpC4DLsWRzodRlALx2Hp3GturWqZB9iRoobDV
	oGUe79Rk8Sqps7HqpVqSDrK1JYdHS5SkGpG/mt101MioIpCeYlDk6y5vZSyfxr9UGvRrDOBBlwOQ1
	9KPpIY4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9QXv-0000000AxXt-0leL;
	Fri, 08 Nov 2024 15:05:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Pw6-0000000AqQk-3PbB
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 14:26:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2CD4568C7B; Fri,  8 Nov 2024 15:26:04 +0100 (CET)
Date: Fri, 8 Nov 2024 15:26:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, m@bjorling.me,
	matias.bjorling@wdc.com, kch@nvidia.com, kanie@linux.alibaba.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 07/13] nvmet: implement endurance groups
Message-ID: <20241108142603.GD6694@lst.de>
References: <20241107193849.995554-1-kbusch@meta.com> <20241107193849.995554-8-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107193849.995554-8-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_062606_998043_C4E3DEF3 
X-CRM114-Status: UNSURE (   8.68  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


