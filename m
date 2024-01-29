Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184D4C47DB3
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 15:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KObBELa1+5vytSqIEOIq8d6s5DA14YIR7DbD+LmTsNo=; b=IWoXcOIXZXvpo3obqgGXYix3nF
	kwrpEhmoKr7gy+x0y6fotqX/gkrE0ecFgn9qzOIy62QsypQQHoUE51c6Svsg2NIXPH9kjfbOxLTof
	/yGeW4PHI2c49J5cu2hV4MOMCVmUHqsmD1jWG3InFWMDSfdYC1vaslCE0Yw3coPceqZnT74bbcOaq
	7GTpNg9Wzr52waYfQfw2J720vq3GRR33Ig67jWZv21VlEzzGCQ4SwkqlVd856qFp8WtIhE2KMzO41
	VpcwdgEib+6BToczDQgrohDgFRFliu0CaR7/xdPa9hqaWE6IDcuRk3lXv3ZeeUHwNGIWAdj+0r4jo
	2zmmPnKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUTdD-0000000DIBC-3af3;
	Mon, 29 Jan 2024 15:33:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUTdB-0000000DI9L-0Lkl
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 15:33:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706542383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KObBELa1+5vytSqIEOIq8d6s5DA14YIR7DbD+LmTsNo=;
	b=ZJuxNwpy9FzKb8k71kLZO5llb/wMOrKC3v+Dvyt+fDfncVFGdscCVfr3lu+d1P7SznYwBb
	vkE37iF2ijTzYsKAOVROEysLUButbV/ZfVjt7Omw7nw181GqM6nyZ6wxu7LxsIHyVAIp1o
	72t8PJa8vkzVojDsueJEwG8oB/kaiJ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-kyTNgZOrM0i-Bmb0wZu48g-1; Mon, 29 Jan 2024 10:33:01 -0500
X-MC-Unique: kyTNgZOrM0i-Bmb0wZu48g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E04A88350E8;
	Mon, 29 Jan 2024 15:33:00 +0000 (UTC)
Received: from [10.22.16.145] (unknown [10.22.16.145])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7B38840C122E;
	Mon, 29 Jan 2024 15:33:00 +0000 (UTC)
Message-ID: <8697223e-db06-419a-914d-6928c9b12ce9@redhat.com>
Date: Mon, 29 Jan 2024 10:33:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/3] nvme-rdma: show hostnqn when connecting to rdma
 target
To: "Nitin U. Yewale" <nyewale@redhat.com>, chaitanyak@nvidia.com,
 linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 loberman@redhat.com
References: <20240129110639.45542-1-nyewale@redhat.com>
 <20240129110639.45542-2-nyewale@redhat.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20240129110639.45542-2-nyewale@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_073305_270598_8BFD3338 
X-CRM114-Status: GOOD (  12.36  )
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

Reviewed-by: John Meneghini <jmeneghi@redhat.com>

On 1/29/24 06:06, Nitin U. Yewale wrote:
> Log hostnqn when connecting to nvme target.
> As hostnqn could be changed, logging this information
> in syslog at appropriate time may help in troubleshooting.
> 
> Signed-off-by: Nitin U. Yewale <nyewale@redhat.com>
> ---
>   drivers/nvme/host/rdma.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 11dde0d83044..60f42c959acb 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -2296,8 +2296,8 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
>   	if (ret)
>   		goto out_uninit_ctrl;
>   
> -	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISpcs\n",
> -		nvmf_ctrl_subsysnqn(&ctrl->ctrl), &ctrl->addr);
> +	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISpcs, hostnqn: %s\n",
> +		nvmf_ctrl_subsysnqn(&ctrl->ctrl), &ctrl->addr, opts->host->nqn);
>   
>   	mutex_lock(&nvme_rdma_ctrl_mutex);
>   	list_add_tail(&ctrl->list, &nvme_rdma_ctrl_list);


