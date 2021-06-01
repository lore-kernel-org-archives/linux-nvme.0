Return-Path: <SRS0=ddWr=K3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E4EC4708F
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 17:09:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABEA1613BD
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 17:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABEA1613BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fBk8ajAhNROg/cj0b4QNVu4J8ugdm9vKsf0wMsjf4YE=; b=IJEm4mKOUb9s26
	8It5c3BbMn4mw1MQHJFKAvLubg1kWfWI3MdVXUQJsLxZeOLb233GGJt9KCdWZV4RaKZ7kToVurb16
	2bBBlPK51AM869mmffm5bsQxxo4TnCJKfGaZrRDNct1Yf/Etri//jSyUkTtnkKVCe2Epsrsq5R9yw
	gdZG0h37c08HqOi6lOXHJ6GVv9EgSl5HsBOKVI5RXH+P2uewU0uJjvf90y6X9qxVVdjxQ/f0kofZt
	WtZCTogr8k48PVoHFk+S2j/I/ibgyrvY4rglx6FEuRzuBCGHbvnciEXMJrD+vXM6YvYJuW7f6HhmX
	mTpeH/Q2CV7RNWx2xz/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lo7tT-0001v3-Na; Tue, 01 Jun 2021 17:09:31 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lo7tR-0001tz-5Z
 for linux-nvme@lists.infradead.org; Tue, 01 Jun 2021 17:09:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=7C4nZGI59pk4Go+wyKJ3w0WpSJ4WX1QUn6Hq2aU67tA=; b=njfhz1pbu4HVZguoHnSrvGVpRS
 XSP2qIFfKpBrHOPV/1s3Zfzp7Xv02I8YCSkjVf0uI34MQmgChWXh8ry2PR0Nj6dJcXe69ejSauEIf
 Nt0kp66ZtbkAL+qH/V9Jz2bLqVzzVf8+c/dIWEUJ0yiZ4f+Uq6zplF/gRKIn0zbh/tLgR6ZW23TkV
 KBl1nwg4URXO1U4OIIVf2+WG0HZXD4uMXYxnQDAlXmbVrIsCiB6mYaaEa4hc18Ivmb56S676/UY6W
 K7dTqa6ZhgI6R8qINp01XB+Ze77fwjt9tdFUY7JloZnI5ihJIovrPIfwUbiSzn81D+7KurqA3QLHO
 GKIY+YMg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lo7tL-0001dk-O4; Tue, 01 Jun 2021 11:09:24 -0600
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, kbusch@kernel.org, hch@lst.de, chaitanya.kulkarni@wdc.com
Cc: oren@nvidia.com, israelr@nvidia.com
References: <20210601162205.38326-1-mgurtovoy@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d487d20e-4c9b-227a-62b8-92d7c6c46aae@deltatee.com>
Date: Tue, 1 Jun 2021 11:09:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210601162205.38326-1-mgurtovoy@nvidia.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: israelr@nvidia.com, oren@nvidia.com,
 chaitanya.kulkarni@wdc.com, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, mgurtovoy@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 1/1] nvmet: fix freeing unallocated p2pmem
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210601_100929_279174_B620E932 
X-CRM114-Status: GOOD (  18.14  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021-06-01 10:22 a.m., Max Gurtovoy wrote:
> In case p2p device was found but the p2p pool is empty, the nvme target
> is still trying to free the sgl from the p2p pool instead of the
> regular sgl pool and causing a crash (BUG() is called). Instead, assign
> the p2p_dev for the request only if it was allocated from p2p pool.
> 
> This is the crash that was caused:
> 
> [Sun May 30 19:13:53 2021] ------------[ cut here ]------------
> [Sun May 30 19:13:53 2021] kernel BUG at lib/genalloc.c:518!
> [Sun May 30 19:13:53 2021] invalid opcode: 0000 [#1] SMP PTI
> ...
> [Sun May 30 19:13:53 2021] kernel BUG at lib/genalloc.c:518!
> ...
> [Sun May 30 19:13:53 2021] RIP: 0010:gen_pool_free_owner+0xa8/0xb0
> ...
> [Sun May 30 19:13:53 2021] Call Trace:
> [Sun May 30 19:13:53 2021] ------------[ cut here ]------------
> [Sun May 30 19:13:53 2021]  pci_free_p2pmem+0x2b/0x70
> [Sun May 30 19:13:53 2021]  pci_p2pmem_free_sgl+0x4f/0x80
> [Sun May 30 19:13:53 2021]  nvmet_req_free_sgls+0x1e/0x80 [nvmet]
> [Sun May 30 19:13:53 2021] kernel BUG at lib/genalloc.c:518!
> [Sun May 30 19:13:53 2021]  nvmet_rdma_release_rsp+0x4e/0x1f0 [nvmet_rdma]
> [Sun May 30 19:13:53 2021]  nvmet_rdma_send_done+0x1c/0x60 [nvmet_rdma]
> 
> Fixes: c6e3f1339812 ("nvmet: add metadata support for block devices")
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

This makes sense to me save one small nit below. Thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>



> -static bool nvmet_req_find_p2p_dev(struct nvmet_req *req)
> +static struct pci_dev *nvmet_req_find_p2p_dev(struct nvmet_req *req)
>  {
> -	if (!IS_ENABLED(CONFIG_PCI_P2PDMA))
> -		return false;
> +	struct pci_dev *p2p_dev = NULL;
>  
> -	if (req->sq->ctrl && req->sq->qid && req->ns) {
> -		req->p2p_dev = radix_tree_lookup(&req->sq->ctrl->p2p_ns_map,
> -						 req->ns->nsid);
> -		if (req->p2p_dev)
> -			return true;
> -	}
> +	if (!IS_ENABLED(CONFIG_PCI_P2PDMA))
> +		goto out;

Seems like we could just return NULL here and save the label and goto.

> -	req->p2p_dev = NULL;
> -	return false;
> +	if (req->sq->ctrl && req->sq->qid && req->ns)
> +		p2p_dev = radix_tree_lookup(&req->sq->ctrl->p2p_ns_map,
> +					    req->ns->nsid);
> +out:
> +	return p2p_dev;
>  }
>  

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
