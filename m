Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4786C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Dec 2023 06:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fUI7uwCcxXo07zUgKKnc+448L4SvHPNZMlR0HPb4dtA=; b=ldByGDkvwZNKdDYIdPVd3tiUuJ
	P4/LNYjkLUlf3OX8HRg+3qC3rC73sTaXMkz6TG5XynmdYUmXgsgTdTfyQ4So26/Qw+V+t2UE+JK5z
	HE2QKpr/SyJd9v8vs1hMU40fT4AM0gA/9VM+B8qsLWbqom06M1jpU2bwi94Ep8jX7XX9xQobcXlbM
	P7eTh2oG88mk36EQRgCL5rAQ+x27i0RDsaQ6dVX6zgP8dxHm9/KhcZU3Gev+JrBI4CmYWku8cC2Bv
	4T6zhOHsauFu1Lwfqht2vLB8BAKOh2XK8RUnPHc3M6vdNPBxsScrT+RJUNgxzcFTPvUOatS5wKARX
	v+Jwpyqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFqCr-00GJki-0m;
	Wed, 20 Dec 2023 06:37:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFqCo-00GJkP-1X
	for linux-nvme@lists.infradead.org;
	Wed, 20 Dec 2023 06:37:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0898668BFE; Wed, 20 Dec 2023 07:37:19 +0100 (CET)
Date: Wed, 20 Dec 2023 07:37:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, james.smart@broadcom.com,
	sagi@grimberg.me, hch@lst.de, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-fc: set numa_node after nvme_init_ctrl
Message-ID: <20231220063718.GB1421@lst.de>
References: <20231219174934.20400-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219174934.20400-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_223722_662698_C94B8970 
X-CRM114-Status: GOOD (  11.20  )
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

On Tue, Dec 19, 2023 at 09:49:34AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> nvme_init_ctrl() always sets ctrl->numa_node to NUMA_NO_NODE. Set the
> desired value after that function call so it won't be overwritten.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

