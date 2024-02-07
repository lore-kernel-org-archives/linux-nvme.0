Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669A6C4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 05:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xwzkt6doBP2FrsrbbkM3dtlS8pmBBZuQF4jhb3oQ9Yk=; b=HY971I79NP2UB9WUEL7QTaoUQ3
	ij9xAUk+/7d0MtFriNeNrbTPtH4MOV3ja1AIwiaDvMcU/Rex9qPCW2pVIODSLH6onkZHH5gnoLT7Y
	+SvI3E9bt6iE3LjFAZt846YrvNxZ33uHpnLcMJaFz81kwBVqC7z/DAGGJefgn4FMnD36Hu7MAEwnj
	CLTfaC95crQrnUN9IAlWMyeSKyj9R7d+zz+AzIqXuvkSshUaLdKnwA3SB0b+/53Zq6zHNIDy7HQiC
	EKDKZfZBrTux/UFDsQdXVhFKRJ7yO+NFj4sBAqj9Otu1GWU2yAWdSQfkyzJpBDyN8pB8moBlcV5Hp
	413wkWGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXasw-00000009mIZ-3Oyl;
	Wed, 07 Feb 2024 05:54:14 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXasu-00000009mHs-06Sx
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 05:54:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 6568ACE1582;
	Wed,  7 Feb 2024 05:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3C4C433F1;
	Wed,  7 Feb 2024 05:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707285246;
	bh=cFI07+dbVUwHHw+7y88rV6C+6idHG2OYDTI/OwtjECQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B87MqsMiKdXXoG9U+W4t0ZyLLR9LiIsRYQSfDRmRHdx+d0nd0Tij89HCghXtmPQUh
	 /HNay8RTffdowR9xAK/aEAmUANyVYDnVrK494mBzXelBNFXt6fKKukHPGlpZN6utal
	 YqRhbe6b7awsYabIr3eIYnz0fzZ8N8keyUcntCF1YrYypL+e20FD1mIMDqSbu6WPIR
	 PyPZLOGw7oe4xmeyuBu7W9x42h3tZ2GK7pCYd+sUrV9MIussJDTfHqn2ez9csZvVix
	 Y2g7WNo7d+pcDdosOdzIhbzXH7593SNuIofqRZcoM7CU3CNlOT7EQdWQ4/NvnAEgfX
	 uuhOajPZaUvYA==
Date: Tue, 6 Feb 2024 21:54:04 -0800
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@meta.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>,
	Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
	Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH] nvme: move passthrough logging attribute to head
Message-ID: <ZcMa_GF34i9GGPpe@kbusch-mbp>
References: <20240206175040.553999-1-kbusch@meta.com>
 <cb287226-8b73-421a-9fa0-ee1b110912dd@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb287226-8b73-421a-9fa0-ee1b110912dd@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240206_215412_262883_83C8D68C 
X-CRM114-Status: GOOD (  12.68  )
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

On Wed, Feb 07, 2024 at 04:02:42AM +0000, Chaitanya Kulkarni wrote:
> On 2/6/24 09:50, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> >
> > The namespace does not have attributes, but the head does. Move the new
> > attribute to that structure instead of dereferncing the wrong type.
> >
> > And while we're here, fix the reverse-tree coding style.
> >
> > Fixes: 9f079dda14339e ("nvme: allow passthru cmd error logging")
> > Reported-by: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
> > Cc: Alan Adamson <alan.adamson@oracle.com>
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >
> 
> Looks good.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> 
> BTW I've also posted comment correction patch with Alan's review in this
> area, please have a look.

Right, I saw that but the comments would need to be updated again after
this fix. I'll take another look tomorrow and maybe just change it when
applying.

