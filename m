Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C743C3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SmFS1iL7m7shkHz3ahqI7GTn/R9O8JLk1wIK/QDKqWw=; b=brHQkMF2ojyApnIeCLzRPx2lno
	/bdngvOJakYIuyD3opctT00f2wxoaavRSpB4S2X4aOYULu8999TVxdcks1V00Db3tWSwZXDLezHV1
	+djsnuhLonwsQwX5idtkv3MGJJutNkl5mpuC30R+QIxSF78q+VP2ZCH9kly7IF+sATNtpTtydSh6b
	02RqlPqxoEeLQJRUWVKT65Ms3V8WzKgX8c5dwvkgU6Qf+ZZu+broNf+5vanJakHOJWiZh7YozLb3d
	8eKYvRW3IzSIkZ6dW8VDUKbWI4WdeL2c+7yaM5rLf3m1lLOsXOo9y48QrVfkJqs+V1V7VknXZeItn
	xtbkLu7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCa2i-0000000Eifc-2rbH;
	Wed, 07 May 2025 08:22:16 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZB4-0000000EWXK-26jA
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:26:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 27E6F5C5C46;
	Wed,  7 May 2025 07:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E72C4CEE7;
	Wed,  7 May 2025 07:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746602809;
	bh=NH0pipebFsrKlTaW6/K2fcy7NEvFNdmi8GA+9sIY3zg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eaNShTyEQorv8jL2Z/iSBkHxWBH91MctSrIvIFTuMk4XlZWTVLM7Mn7EkoHiDVHlU
	 /gqw3l1atCT11OH08JF/mvIsjBwajkto2iXxm7dAH05FARy7QRLKxvODl334Irrjx9
	 ofQ9kxU8eDGDP0rDC1JqU1YQhG7nk9lcIcXC46SYhCsHFHG8j6a82SabAr9rqO7DiB
	 GCU2OYBGq6aNoxL8V24hw05gHMoYV6/Jxkt0u0rizUnp3WvrKTYhPXlM696KTVS4gT
	 T8++BWt508cm3e/o6LJKQQaOkFyV7nZW1nt5KJuyoh2sU/Qb3qYcNDxILjMoDMBE5Y
	 CjeqcFUmLEQuQ==
Message-ID: <0db89443-9db7-4f39-8db1-eb374a9a3bcd@kernel.org>
Date: Wed, 7 May 2025 16:25:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] nvmet: cq: prepare for completion queue sharing
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: alistair.francis@wdc.com, cassel@kernel.org,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20250424051352.7980-2-wilfred.opensource@gmail.com>
 <20250424051352.7980-4-wilfred.opensource@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250424051352.7980-4-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_002650_635306_7E34F6C3 
X-CRM114-Status: GOOD (  24.66  )
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

On 4/24/25 2:13 PM, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> For the PCI transport, the NVMe specification allows submission queues to
> share completion queues, however, this is not supported in the current
> NVMe target implementation. This is a preparatory patch to allow for
> completion queue (CQ) sharing between different submission queues (SQ).
> 
> To support queue sharing, reference counting completion queues is
> required. This patch adds the refcount_t field ref to struct nvmet_cq
> coupled with respective nvmet_cq_init(), nvmet_cq_get(), nvmet_cq_put(),
> nvmet_cq_is_deletable() and nvmet_cq_destroy() functions.
> 
> A CQ reference count is initialized with nvmet_cq_init() when a CQ is
> created. Using nvmet_cq_get(), a reference to a CQ is taken when an SQ is
> created that uses the respective CQ. Similarly. when an SQ is destroyed,
> the reference count to the respective CQ from the SQ being destroyed is
> decremented with nvmet_cq_put(). The last reference to a CQ is dropped
> on a CQ deletion using nvmet_cq_put(), which invokes nvmet_cq_destroy()
> to fully cleanup after the CQ. The helper function nvmet_cq_in_use() is
> used to determine if any SQs are still using the CQ pending deletion.
> In which case, the CQ must not be deleted. This should protect scenarios
> where a bad host may attempt to delete a CQ without first having deleted
> SQ(s) using that CQ.
> 
> Additionally, this patch adds an array of struct nvmet_cq to the
> nvmet_ctrl structure. This allows for the controller to keep track of CQs
> as they are created and destroyed, similar to the current tracking done
> for SQs. The memory for this array is freed when the controller is freed.
> A struct nvmet_ctrl reference is also added to the nvmet_cq structure to
> allow for CQs to be removed from the controller whilst keeping the new API
> similar to the existing API for SQs.

Looks good to me, modulo one nit below.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index 7fab7f3d79b7..7dda4156d86c 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -1346,6 +1346,7 @@ static u16 nvmet_pci_epf_delete_cq(struct nvmet_ctrl *tctrl, u16 cqid)
>  	nvmet_pci_epf_drain_queue(cq);
>  	nvmet_pci_epf_remove_irq_vector(ctrl, cq->vector);
>  	nvmet_pci_epf_mem_unmap(ctrl->nvme_epf, &cq->pci_map);
> +	tctrl->cqs[cqid] = NULL;

I do not think we need for this hunk in this patch as we are not yet using the
cqs array, and patch 4 removes this line to change it with a call to
nvmet_cq_put().

-- 
Damien Le Moal
Western Digital Research

