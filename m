Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BACC7EE23
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 05:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LdR/yzBtMVg21qxPok8Isyk4N2GT/9uf1orXkg0opKE=; b=JsjmSAsVRuOWFMD5UAHT8kk1o0
	JhC0r7oEcAbPDYQwcLZ6+f03siim47gJ9/VYtlkP/qpso4Jn8Re4/RzcVSxKdKk75KT7b6Jvnmrpj
	Sjc1+MfxJauVjFlrMf6Neb3m+nxTo3Ti3gHvmmc9cBv71zvI2v4KH+DhFFqTN9V1DG6Kra+jMhPMs
	VdCHhICM6wb016z/JpSyxAlJ9+c5NiwxV8QN56gh1v+1e6L41hHML3Sxzkjz9MkPBhFS3MsXL6uzs
	GpQWH+78RpvmoqTn0k+4Hca3aNCcUNz/dqJg0s8n12gChkyIuf+fUKaCdFhAnXRWjcfvz7kXLXxYu
	L6mt6pLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6lPq-004OFj-2J;
	Wed, 07 Jun 2023 05:09:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6lPo-004OF5-1O
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jun 2023 05:09:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 300B968AA6; Wed,  7 Jun 2023 07:08:56 +0200 (CEST)
Date: Wed, 7 Jun 2023 07:08:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Israel Rukshin <israelr@nvidia.com>
Cc: Linux-nvme <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Nitzan Carmi <nitzanc@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] nvme-rdma: Fix T10-PI when SW doesn't generate/verify
 metadata
Message-ID: <20230607050855.GA20010@lst.de>
References: <1686048690-374365-1-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686048690-374365-1-git-send-email-israelr@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_220900_616554_823E2926 
X-CRM114-Status: GOOD (  14.79  )
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

On Tue, Jun 06, 2023 at 01:51:30PM +0300, Israel Rukshin wrote:
> When the SW doesn't generate/verify metadata, the SG length is
> smaller than the transfer length.

What is "the SW"?

> length when there is no metadata SGL. The bug reproduces when
> setting read_verify/write_generate to 0 at the child multipath
> device or at the primary device when multipath is disabled. Note
> that setting those to 0 on the multipath device doesn't have any
> impact on the I/Os.

And we really need to prevent this from happening per the last
discussion.  Please submit a patch to fail adding a new path to
a ns_head if the PI settings mismatch.


