Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C9CC531D0
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2026 15:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2oQhVvdv6KuXOiBD33tawm7L/XSNS3FQAeB02Lg3Rx8=; b=aNt9wYmeJzDEmo
	aUDuD5PKhBakqPTLbSKVF8c8lhC+UyBq/A0qvdmbm1l7FbO+JRogWp3pQkomXEbjoC5EFKz1rFa7u
	jW9dPGZZoAtVHq4jXZFim/yY36FqlbcEdfM0ARVcjWP7/oI324DiG1r0oF4S7As7youpG+GboKITG
	M0W6b6rkM08H+pSpoUN0hn3RCV2TSUxUujJog17IiaWpg1n2oG9zYWTgmpEls8/sk2N0BdVco/BYd
	hHrOXH30Y2ykhO8nRCYTZBdadzYGThq2D/8sOZQ1WiauXci3VZZXi3E2rb+G1uc2Her+Gt0zxp8V5
	KZPHnG9kxxXSLfrmHYIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woNZ9-00000003E2V-2VqB;
	Mon, 27 Jul 2026 15:48:31 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woNZ6-00000003E21-2puF
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jul 2026 15:48:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=2oQhVvdv6KuXOiBD33tawm7L/XSNS3FQAeB02Lg3Rx8=; b=d3Fyd20RPqcZRPF+6seD52jrxs
	yjAvCdAgZVrU+sB6XDX7ZFpDad4tBDiHMmPolG37tWjhImS68lymNdWNVbq9J4beIpy/cBR/bxo8C
	Ytna5l7NYKOqJPyk3xHR9EqwZy5AC6F3y/euuHm/mzVeBVGKxrAT5xrDHREnCZOjH5l0iSWmZmyS4
	synpvjnCQurud74bxxoVd9M+uK3tIW2m4w8sILjk9Jz2CAOU90M7KK5X27UR+N1VadQirb5CcXqHw
	phpXliLE4QMi4LFi4tZay+vupgomU5LWUKrExwljuf3qPeTABUpKBzlME/M4Z5N3qYxAnGRC0DzwL
	FZ/T295A==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1woNYz-0000000GHSh-1tsM;
	Mon, 27 Jul 2026 09:48:22 -0600
Message-ID: <d3d1eb27-f743-4557-b47e-ec2f8ce0091c@deltatee.com>
Date: Mon, 27 Jul 2026 09:48:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mykola Marzhan <mykola@meshstor.io>, Jens Axboe <axboe@kernel.dk>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai@fygo.io>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>, Xiao Ni <xiao@kernel.org>,
 Guoqing Jiang <guoqing.jiang@linux.dev>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Shivaji Kant <shivajikant@google.com>, Pranjal Shrivastava
 <praan@google.com>, Henrique Carvalho <henrique.carvalho@suse.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 Thorsten Leemhuis <regressions@leemhuis.info>, Martin Wilck <mwilck@suse.com>
References: <20260726113229.2154269-1-mykola@meshstor.io>
 <20260726113229.2154269-12-mykola@meshstor.io>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260726113229.2154269-12-mykola@meshstor.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: mykola@meshstor.io, axboe@kernel.dk, song@kernel.org, yukuai@fygo.io, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org, magiclinan@didiglobal.com, xiao@kernel.org, guoqing.jiang@linux.dev, leon@kernel.org, jgg@ziepe.ca, kmodukuri@nvidia.com, kch@nvidia.com, bhelgaas@google.com, shivajikant@google.com, praan@google.com, henrique.carvalho@suse.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org, regressions@leemhuis.info, mwilck@suse.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v6 11/12] nvme-rdma: ratelimit the map-failure error
 message
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_084828_811710_51E336ED 
X-CRM114-Status: GOOD (  14.12  )
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



On 2026-07-26 05:32, Mykola Marzhan wrote:
> A mapping failure is per-request and, for an unroutable P2P transfer,
> deterministic: a workload that keeps issuing one turns this into a
> log line per I/O.  Ratelimit it, as nvme's per-I/O error logging
> (nvme_log_error()) already is.
> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Mykola Marzhan <mykola@meshstor.io>

Thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
>  drivers/nvme/host/rdma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index c38d949502b7..2f50509a7a61 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -2040,8 +2040,8 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
>  
>  	err = nvme_rdma_map_data(queue, rq, c);
>  	if (unlikely(err < 0)) {
> -		dev_err(queue->ctrl->ctrl.device,
> -			     "Failed to map data (%d)\n", err);
> +		dev_err_ratelimited(queue->ctrl->ctrl.device,
> +				    "Failed to map data (%d)\n", err);
>  		goto err;
>  	}
>  


