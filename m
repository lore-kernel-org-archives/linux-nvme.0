Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00BBC63797
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jan 2023 12:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JN1ozIPaF36z9JF2Zbf7i9N2c+vgyVY97Zt7dr1fdoE=; b=i7+oQcplBlSqbzYf0LDZpD22m9
	duZIY/aeNEG9ZwxMS2L59liiyUaJ05fsFCLTRblBoN0BgYtlTNF1GhYf6dI1t6nnYhCj1zZ5Tn7Ub
	T2rnTxd/EuPFhPszHNHvH3EoNX16wTmdQ2gwWYm2YqNLdi6qEJOHWYshFpw0XkLZkw5ie6bapHPGS
	8RnpWp//FikPxfR7Tbxipl0Shuw/C+MvPvYEeEoONPUn2GgtKmMtIK9LLiKxtIhp+6nha/UCxQs+V
	DFWqliU2S1s+yXmo93ynYo7MDa2aBkV0mPBg9y/8+nvOEHpJ9h4lBtEQNYh9dy5c78/dUVJ2X6CY6
	ehF7X7Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHkdD-00E6t3-Fa; Tue, 17 Jan 2023 11:59:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHkdA-00E6s4-15
	for linux-nvme@lists.infradead.org; Tue, 17 Jan 2023 11:59:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 64D2A612EE;
	Tue, 17 Jan 2023 11:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B004C433D2;
	Tue, 17 Jan 2023 11:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673956794;
	bh=aTQYYKmLmNf07nxBHwjaA+StqUovg0SS7JYEnCH+EZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JcktzRZbthNjyz+5qDuk41oZMxJYCCPDkgEXy01vFYTwlnZjxjziBy/fjRBFrmcSa
	 E+PMfnpmsxQOvk4Nnoif+2kebtJFzsk6MLmCF0naHyrUxRwLUY0egDjGMueOewYX9U
	 jY95uj2yF2tCHsBQgxOnBrKJInMJKFTeLLsroP9Qz+Zmb5S5ohasJ2sIlHVuXyrdKU
	 +JQlAVyRuTN0m1l13Oc+TNnPPuP7Sr59v4b9nO4VxcqClgsxIrXN9pyrNM8z/w85BT
	 oBD2AKo9teesJp1MkdO9eUCNiMo/mj0umhmkVIhKlpMUQYQSsiQ5U2bWLoyBYl3VOM
	 zsK3K8o3KkQoA==
Date: Tue, 17 Jan 2023 13:59:51 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Israel Rukshin <israelr@nvidia.com>,
	Bryan Tan <bryantan@vmware.com>, Christoph Hellwig <hch@lst.de>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@fb.com>,
	Keith Busch <kbusch@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vishnu Dasa <vdasa@vmware.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 11/13] nvme: Introduce a local variable
Message-ID: <Y8aNt9YB9irSVXNo@unreal>
References: <cover.1673873422.git.leon@kernel.org>
 <cf5bc542e014f465f7ae443e52e70def2993aef1.1673873422.git.leon@kernel.org>
 <c095c9a9-0e77-c8ab-d34e-f4ab42b11938@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c095c9a9-0e77-c8ab-d34e-f4ab42b11938@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_035956_124114_F2EDDC1F 
X-CRM114-Status: GOOD (  20.71  )
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

On Tue, Jan 17, 2023 at 12:32:59AM +0000, Chaitanya Kulkarni wrote:
> On 1/16/23 05:05, Leon Romanovsky wrote:
> > From: Israel Rukshin <israelr@nvidia.com>
> > 
> > The patch doesn't change any logic.
> > 
> > Signed-off-by: Israel Rukshin <israelr@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leon@kernel.org>
> > ---
> >   drivers/nvme/host/core.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 7be562a4e1aa..51a9880db6ce 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1870,6 +1870,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
> >   	sector_t capacity = nvme_lba_to_sect(ns, le64_to_cpu(id->nsze));
> >   	unsigned short bs = 1 << ns->lba_shift;
> >   	u32 atomic_bs, phys_bs, io_opt = 0;
> > +	struct nvme_ctrl *ctrl = ns->ctrl;
> >   
> 
> I don't think this patch is needed, existing code is more readable and
> gives much clarity that we are accessing ctrl from namespace since we
> are in nvme_update_disk_info() which is namespace based.

I don't have strong opinion here.

Thanks

> 
> -ck
> 

