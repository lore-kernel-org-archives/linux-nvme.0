Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6409FC6FA82
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 14:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jqbUb/OuEeI1N+9pcoGfvCj5B/nUqFI08uRk09xPfzs=; b=y3EiMHsJwVP06SE6Nj48lV5e6g
	nMhnA+UsPidY5YuQhhv/4ysrRfNMkKdXFoEMFZAWMh4R+kw9lvP/ngKHS7yCLYmqpYRDzTA78dHfK
	R1erAzsnr/fpi1nhXbLuqipnKF+vnIZ6+FGjkGR0o6rZda/R0a7tnvihc2by4ohJKHPnrClfFdT7l
	dJrSTlTjoqsgwD3260OOUfPLmKui7LeZmaJ1AtRlgrDj7+qzR6J2QHNsHop/cYRi442FAiudi9oq4
	7/pCdTU1Iws7IF15YxoU4VV9L/BBxyjltutW6/syc19Lgb1JXOdyh9Al+n9L+pz5lPyjKxEzpGTpT
	ZA1uJiEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obN2J-00Fwvu-GA; Thu, 22 Sep 2022 14:18:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obN2G-00Fwqf-1n
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 14:18:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B35DF68AFE; Thu, 22 Sep 2022 16:18:23 +0200 (CEST)
Date: Thu, 22 Sep 2022 16:18:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 01/13] nvme: add common helpers to allocate and free
 tagsets
Message-ID: <20220922141823.GA27549@lst.de>
References: <20220920171611.1289361-1-hch@lst.de> <20220920171611.1289361-2-hch@lst.de> <c9bc8a76-94aa-5a4c-526e-f92204635a22@huawei.com> <20220922054549.GB27338@lst.de> <a7bf9d8c-cb39-470c-1abe-ea78dc2d964d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7bf9d8c-cb39-470c-1abe-ea78dc2d964d@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_071840_248518_3C1662ED 
X-CRM114-Status: GOOD (  14.07  )
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

On Thu, Sep 22, 2022 at 04:02:01PM +0800, Chao Leng wrote:
> We can do some special processing in nvme_setup_cmd for connect command to
> treat queue mapping.
> Do you think that's okay?

nvme_setup_cmd does not help, as anything we could do there we could
in the code that submits the command.  The point is that it needs to
be sent out on the hctx for that particular I/O queue.

