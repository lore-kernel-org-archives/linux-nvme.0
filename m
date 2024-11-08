Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE85FD5C0E1
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 15:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=hChoy2c7v45LDJKBlvuru5HKOG
	BZWoIzCeClMSTUUt2VyMXAQlKd8Q/3o/PBdG4MoEGI98muvugXus//kxn4+kc93ParPzxNhy4qQUV
	bpzqNIGeTQDxYxE84p9D3uMf1K3DCrKGGS/kuc1NOZgzCGC+Gehbp0wZJNMMYPIinggWUpi2IVhkW
	HlMLR8CDYgqRapZMSvG1eVk9ZDvGPlvYmm8hufZ5j1m3kMRMCFs3f5NTkPhsfa7rc0b/JzZ3Rc/jU
	vba/XkVSD6CSZdK/O0kWCxz6mHN9reaW9MwALoMmisIBz+TQdh1/AsNlMyD7f8eovWYx1YbQBPwgD
	D/UHQJZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9QY1-0000000Axbi-0ZhU;
	Fri, 08 Nov 2024 15:05:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Pww-0000000Aqd0-1pFP
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 14:26:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 340F268AA6; Fri,  8 Nov 2024 15:26:54 +0100 (CET)
Date: Fri, 8 Nov 2024 15:26:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, m@bjorling.me,
	matias.bjorling@wdc.com, kch@nvidia.com, kanie@linux.alibaba.com,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 10/13] nvme: use command set independent id ns if
 available
Message-ID: <20241108142653.GF6694@lst.de>
References: <20241107193849.995554-1-kbusch@meta.com> <20241107193849.995554-11-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107193849.995554-11-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_062658_625617_72D11523 
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


