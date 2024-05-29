Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC55C25B75
	for <linux-nvme@archiver.kernel.org>; Wed, 29 May 2024 21:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mG8rvbRusECtzDBqIeScFx0/GKnS7hPJPd7xd1IjMAM=; b=O+nTPMRJ9hK7PYHRXI3cHqHkY0
	cQOvvhQdeckum8tHQ6POvZMS5Ca3+4SVQ8bA8MsWBL1EDd55k8o4SGTQZc6dm4N/dLvvuwydEzxyg
	N3TDfDFIiUnq203qh5u9Xt4vCUJNNGVu4+kec6qBcJG6f+YPI4t+u2Swng9GdEg0ERwAcZY9syKko
	uyy/ZjuEx5TMo8cStO/6zJmRvR23MVNYCBII1KaeJsYvdLNFW0FxUB08+7UrYg+jWmh+FdadWhAHJ
	/bulsGlLnjQE3S5NLmyMQsrMuNXHV4hvjNebYtomorQCxSHGsMAs0FNpsUNi/o1aBuRDSpCZnd0O/
	t2YtpAxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCR3L-00000005cF5-0R0h;
	Wed, 29 May 2024 21:41:47 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCR3H-00000005cEX-2qPx
	for linux-nvme@lists.infradead.org;
	Wed, 29 May 2024 21:41:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 03C6B61CC9;
	Wed, 29 May 2024 21:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5045EC113CC;
	Wed, 29 May 2024 21:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717018900;
	bh=Vgyry3/HqGZgPXelcs31WNLFfeS3kD9rdU869hO509o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nE5OfZGcfgOZyvWB06VwnJHGLLM0Fa8iyZaUOnjO83Nxirle5iHeBWkTEGnhtuntU
	 JlC7bNS1vvb2Z6xsIboA93Xa2+u+AN6j77mmAFN34F8UTa5F0VKdGqtZZOiEd6FXWt
	 nylLAkQstAqDb25hGLOxgNuQF5UI7i3GwsfiZdR0HiBWIY9BD4C398KGUpakCt/LwQ
	 CB9bCKUewAxAT+8QXDkRQB5sHUcXZlFBpu86uuyup4ybB6fnm3eVU985YvqZGVtff6
	 Wl+QcYAP34RwFk6a9yaC69yv5Kc7cnbxkVn5/BW5XSp2SPAmeF/s3zXOQg3mO7hb44
	 lDhKcVobkBk8A==
Date: Wed, 29 May 2024 15:41:37 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Weiwen Hu <huweiwen@linux.alibaba.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Mike Christie <michael.christie@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] nvme: fix nvme_pr_* status code parsing
Message-ID: <ZlehEZyVyJ0qUvWG@kbusch-mbp.dhcp.thefacebook.com>
References: <20240529122300.92377-1-huweiwen@linux.alibaba.com>
 <20240529122300.92377-2-huweiwen@linux.alibaba.com>
 <d5cdd059-cf7a-4465-8712-7814fe41f9b8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5cdd059-cf7a-4465-8712-7814fe41f9b8@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_144143_989666_CB70D042 
X-CRM114-Status: GOOD (  19.63  )
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

On Wed, May 29, 2024 at 07:18:36PM +0000, Chaitanya Kulkarni wrote:
> On 5/29/24 05:22, Weiwen Hu wrote:
> > Fix the parsing if extra status bits (e.g. MORE) is present.
> >
> > Renamed nvme_sc_to_pr_err to nvme_status_to_pr_err to better match its
> > semantic.
> >
> > Fixes: 7fb42780d06c ("nvme: Convert NVMe errors to PR errors")
> > Signed-off-by: Weiwen Hu <huweiwen@linux.alibaba.com>
> > ---
> >   drivers/nvme/host/pr.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
> > index e05571b2a1b0..25e23cdba151 100644
> > --- a/drivers/nvme/host/pr.c
> > +++ b/drivers/nvme/host/pr.c
> > @@ -72,12 +72,12 @@ static int nvme_send_ns_pr_command(struct nvme_ns *ns, struct nvme_command *c,
> >   	return nvme_submit_sync_cmd(ns->queue, c, data, data_len);
> >   }
> >   
> > -static int nvme_sc_to_pr_err(int nvme_sc)
> > +static int nvme_status_to_pr_err(int nvme_status)
> 
> do you really have to make this helper name longer ?
> nvme_sc matches the NVME_SC and makes it easy to grep when
> looking for symbols and error codes, but if everyone is okay with
> this then sure go ahead ...

Yeah, I'd agree. In fact, just resend with only the "& 0x7ff" masking
for the "Fixes" part of this, and that can go in for 6.10. Potential
enhancments can come after.

> > -	switch (nvme_sc) {
> > +	switch (nvme_status & 0x7ff) {
> >   	case NVME_SC_SUCCESS:
> >   		return PR_STS_SUCCESS;
> >   	case NVME_SC_RESERVATION_CONFLICT:

