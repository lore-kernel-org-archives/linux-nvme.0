Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C003CC54E67
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 23:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RdUdH1+vEPbpTFGV74SsnBd6aw/6AHIdxSkE9t7wO4o=; b=Ypp1Sw+qpGk1uEH09IraPx713M
	aW6b1ye7X6VX0ZYD66lG85yEVi61CdpfbHdG/Aqk4mfCzDMurEFaDLcNC61bj6YpVFAjREFST0EW1
	xiptu5fKmPeHAVcJFUyHt62Si090Bp6wlaus2UrW2XDYNsA1517W4xGqrPFZnPRoUKHj9Jr39oEvE
	ukF/yyr8zGYxbvmuMj0D/z+VpusLLUOS+TcPKdpAHuPk+zs1SXr0AqBwl12ZC0JnF8iZdn8+3V2YO
	iJK9fxI9gPoUJFUQQSDe31+XQhDd8bKgVqIg0W8WxNmm9z9fsFZWr+lSYKkyUnNAzclLphARQCVHF
	QGhiKuCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rn55W-00000001Di5-1cIo;
	Wed, 20 Mar 2024 23:11:14 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rn55T-00000001DhZ-0FCL
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 23:11:12 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3416fd2463dso75421f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 20 Mar 2024 16:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710976269; x=1711581069;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RdUdH1+vEPbpTFGV74SsnBd6aw/6AHIdxSkE9t7wO4o=;
        b=TxsDUCr4mtgjGKNdY1j4P2DFA8knhB//SiOeVKWx50mLhv4mfwFbSOc+dIiPInjMUh
         H+t40vzF00LYTzlZkxFc+COsHWbK2DRg87nu1gvYyzEmUbYYr5kCCQGGevfDlpw+2qtt
         p2MChXNd1ih9WAhL3SLJCIj0laokbaRRyfM3IbRlhSBwfP91HNtaVgVK0LeLqxtVwbDi
         5h6PGNWro3g1uFqGmSKXIG7ivGYkjHh0UjLXLqS5+xu6mHGID24pQJkZxU3VLhrfZ6o3
         SM/fVQd+ex4BKUf8F1xorcrHbdiSUE3H6+J6kl//+h52wDDWOkWYU/zH7JtMhg/Ot/KT
         DcxA==
X-Forwarded-Encrypted: i=1; AJvYcCU70IIsToce4+X/PI22mvnOnVuC2SZwgL9tkwETzBaib8nZCPfnWW2Obc/mffg2AFRIJiLSIvyQvkbUDTa75x0DEhgSt3okokjI0XRIEME=
X-Gm-Message-State: AOJu0YyhF4UmzabL/QDBLnIF4CkreTNCYCH0KMp+WnoyqNYHCQj2KaPo
	c4Doxs8UbH4bcnr0HF2EPXAJYRA5wQjrHw6otigC1WP1QTz4Q46c
X-Google-Smtp-Source: AGHT+IFtnrjExrFIuKRTuoM4rDELAd7KsFwMl5CsWwZm2HVitfpljqv1jt7JO9hr9KORAGj3Q2izPA==
X-Received: by 2002:a05:6000:1849:b0:341:8f18:db39 with SMTP id c9-20020a056000184900b003418f18db39mr4552536wri.1.1710976269295;
        Wed, 20 Mar 2024 16:11:09 -0700 (PDT)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c199100b004146e58cc32sm2680862wmq.12.2024.03.20.16.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 16:11:08 -0700 (PDT)
Message-ID: <17118de5-001c-4f08-a092-3b553a74feb9@grimberg.me>
Date: Thu, 21 Mar 2024 01:11:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] nvmet-tcp: implement queue_peer_traddr()
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org
References: <20240320144017.106283-1-hare@kernel.org>
 <20240320144017.106283-4-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240320144017.106283-4-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_161111_129337_6E861C92 
X-CRM114-Status: GOOD (  17.18  )
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



On 20/03/2024 16:40, Hannes Reinecke wrote:
> Implement callback to display the peer transport address.

s/peer/host

> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/target/tcp.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 4718d4d87a85..4b2cef897a66 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -2201,6 +2201,18 @@ static void nvmet_tcp_disc_port_addr(struct nvmet_req *req,
>   	}
>   }
>   
> +static ssize_t nvmet_tcp_disc_peer_addr(struct nvmet_ctrl *ctrl,
> +			struct nvmet_sq *sq, char *traddr, size_t traddr_len)
> +{
> +	struct nvmet_tcp_queue *queue =
> +		container_of(sq, struct nvmet_tcp_queue, nvme_sq);
> +
> +	if (queue->sockaddr_peer.ss_family == AF_UNSPEC)
> +		return -EINVAL;
> +	return snprintf(traddr, traddr_len, "%pISc",
> +			(struct sockaddr *)&queue->sockaddr_peer);
> +}
> +
>   static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
>   	.owner			= THIS_MODULE,
>   	.type			= NVMF_TRTYPE_TCP,
> @@ -2211,6 +2223,7 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
>   	.delete_ctrl		= nvmet_tcp_delete_ctrl,
>   	.install_queue		= nvmet_tcp_install_queue,
>   	.disc_traddr		= nvmet_tcp_disc_port_addr,
> +	.queue_peertraddr	= nvmet_tcp_disc_peer_addr,

host_traddr, and it should really be per controller, and be taken from 
the admin
queue. Not sure how this would ever be different across queues in the 
same ctrl

