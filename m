Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2152BC3601E
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 11:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kwjI5g252VPUcJWv7u/Ueqthfa9fXj4Xusonc5vPD8o=; b=xr2owFI/tKHpIpKB4QVWI+Va6T
	neb0vNimcaM31h5MwOXnPoZ+ZFoS3lOxQY+wKeyqrk3wNUONyI4Ynm5c6U22LivILPh/w+Ogabt8F
	qvNqfmtpSg9mkyMGfdiawRIAZrj5iVjQ4N5ae//gVEOAYUuqwDJWrHfjCz9b9UyBTtpvX842U7HlI
	c/z7hX+N9J2ZSvbNuKceCQ9TP6afOu7u+F5NRtEHZy1U6EclN0tti5i3QkYnLJBPoVANkHA0/AO6y
	gvqH9BvmZBn+EY0kOP799veGQEOUnNJn5A+oVb00gyxW1N8o2NWuVmlDnUhv123EaiPBEnJY2s4gJ
	9Za8GiVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2ptQ-0000000AC7d-3Fhg;
	Thu, 10 Apr 2025 11:16:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2o0k-00000009u3t-0VRW
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 09:15:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A943C44EA8;
	Thu, 10 Apr 2025 09:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC84C4CEDD;
	Thu, 10 Apr 2025 09:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744276548;
	bh=RSA9On+1TRGN99hGFNNk/mtlWhNlsvRcbo24bXoW50I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c9DmK91WAr4wGEqgPmP9DDTM/wGubBdNc/lzepM53hG/EdvqTarWggys0LvDqV9CF
	 eNSdrLoTEiMCBBpIYiirOkDCHqKv7TohgfOSK3AE/4ehIwwc518xKSFjr0Wjb/shul
	 J0uxye01M8iy1Sp7L5WNpHlfcbbyQ9SNN4xe+02CjHuGANfLR4LxZIVgMq/jRu/ZRc
	 DYoOtIzFqj0Pptbb8wSDyFxHvSSmKF/AlVCN23JPLsssBvIZAK6DvlqyJ4SnZ0fs9r
	 HmrlX2fn0kKSgYh9YPGAMhYcw9afgWg90oXPc9eiQAhK6E/EDXPFt0GGEsG4TpzGgN
	 rZz4VwxBcW6RQ==
Date: Thu, 10 Apr 2025 11:15:44 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/3] nvmet: pci-epf: Always fully initialize completion
 entries
Message-ID: <Z_eMQIngBd4CjR8N@ryzen>
References: <20250408024733.690966-1-dlemoal@kernel.org>
 <20250408024733.690966-2-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408024733.690966-2-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_021550_177997_A201423A 
X-CRM114-Status: GOOD (  18.74  )
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

On Tue, Apr 08, 2025 at 11:47:31AM +0900, Damien Le Moal wrote:
> For a command that is normally processed through the command request
> execute() function, the completion entry for the command is initialized
> by __nvmet_req_complete() and nvmet_pci_epf_cq_work() only needs to set
> the status field and the phase of the completion entry before posting
> the entry to the completion queue.
> 
> However, for commands that are failed due to an internal error (e.g. the
> command data buffer allocation fails), the command request execute()
> function is not called and __nvmet_req_complete() is never executed for
> the command, leaving the command completion entry uninitialized. For
> such command failed before calling req->execute(), the host ends up
> seeing completion entries with an invalid submission queue ID and
> command ID.
> 
> Avoid such issue by always fully initilizing a command completion entry
> in nvmet_pci_epf_cq_work(), setting the entry submission queue ID and
> command ID.
> 
> Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/nvme/target/pci-epf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index 51c27b32248d..f6b22ef4c267 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -1763,6 +1763,8 @@ static void nvmet_pci_epf_cq_work(struct work_struct *work)
>  
>  		/* Post the IOD completion entry. */
>  		cqe = &iod->cqe;
> +		cqe->sq_id = cpu_to_le16(iod->sq->qid);
> +		cqe->command_id = iod->cmd.common.command_id;
>  		cqe->status = cpu_to_le16((iod->status << 1) | cq->phase);

Looking at e.g. __nvmet_req_complete() and __nvmet_fc_fcp_nvme_cmd_done()
in addition to setting sq_id, command_id, and status, they also set:
cqe->sq_head.

(__nvmet_req_complete() -> nvmet_update_sq_head() -> req->cqe->sq_head = ...)

Should we perhaps set sq_head too?


Kind regards,
Niklas

