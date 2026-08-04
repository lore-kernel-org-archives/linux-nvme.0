Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A449C55822
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2026 16:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=29Vj7skiDTSy7hSpfOZ2+rZm/FAc6qXMLw5bA7M6CL8=; b=k8V9OJCnO2t8xgp1FGLGzckVj/
	KnIw/2Ap3gC4SHT/Gwg3n7FwdHTSytHLtH7gA7XE09jyum/QQKLP+3NFmaBZunKV/1JHFJrv5l9vq
	VKkba1ZB44UIU37buBDPq4VOXz1TZCjmdft2WP3WHFiJkEVZyOG+b3APVx5j7v8wBlJn/zrjv6dSZ
	Xw6lTygV8aV60kIgyVdcyICl1SRIqO0bIrjEi5BN8pUNPt6Mg3yLDzAKTkvnMFrfr4IoLr4RVZsY2
	ROyil7mJg2j+On9ccPhsC/bW4wID06xZSCfjRAhDFNPljUtUuoiRjoVtVxFIEqF/+FYlcfoMZMsUl
	etPtPfjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrHrZ-00000002IPE-41Pc;
	Tue, 04 Aug 2026 16:19:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrHrV-00000002IN6-3PpP
	for linux-nvme@lists.infradead.org;
	Tue, 04 Aug 2026 16:19:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 55BE168C4E; Tue,  4 Aug 2026 18:19:26 +0200 (CEST)
Date: Tue, 4 Aug 2026 18:19:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: fix heap out-of-bounds read in
 nvmet_auth_negotiate()
Message-ID: <20260804161926.GC11977@lst.de>
References: <20260804033800.3975537-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804033800.3975537-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260804_091930_004203_D733DF8D 
X-CRM114-Status: GOOD (  22.84  )
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

On Tue, Aug 04, 2026 at 11:38:00AM +0800, Guixin Liu wrote:
> nvmet_execute_auth_send() allocates the DH-HMAC-CHAP message buffer with
> the host-supplied transfer length (tl) and hands it to
> nvmet_auth_negotiate() without passing tl along. nvmet_auth_negotiate()
> then reads the negotiate header and, for each of the halen hash
> identifiers and dhlen DH group identifiers, indexes into the fixed
> idlist[60] array (hashes at idlist[0..halen), groups at idlist[30..]).
> 
> Neither the transfer length nor halen/dhlen is validated. A malicious or
> non-conformant host can report a tl smaller than the negotiate structure,
> or a halen/dhlen larger than the array (both are u8, up to 255), making
> the loops read past the end of the allocated buffer (heap out-of-bounds
> read). The sibling nvmet_auth_reply() already validates tl against the
> structure size; the negotiate path did not.
> 
> Pass tl into nvmet_auth_negotiate(), reject a tl that does not cover the
> negotiate data plus one full protocol descriptor, and reject halen/dhlen
> larger than NVME_AUTH_DHCHAP_MAX_DH_IDS.
> 
> Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>  drivers/nvme/target/fabrics-cmd-auth.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index d1b39e64d877..d015968bae2d 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -31,12 +31,16 @@ void nvmet_auth_sq_init(struct nvmet_sq *sq)
>  	sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
>  }
>  
> -static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
> +static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d, u32 tl)
>  {
>  	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>  	struct nvmf_auth_dhchap_negotiate_data *data = d;
>  	int i, hash_id = 0, fallback_hash_id = 0, dhgid, fallback_dhgid;
>  
> +	if (tl < sizeof(*data) +
> +		 sizeof(struct nvmf_auth_dhchap_protocol_descriptor))

Odd formatting here.  Condition continuations either get two-tab indents
or after the brace:

	if (tl < sizeof(*data) +
			sizeof(struct nvmf_auth_dhchap_protocol_descriptor))

	if (tl <
	   sizeof(*data) + sizeof(struct nvmf_auth_dhchap_protocol_descriptor))

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

