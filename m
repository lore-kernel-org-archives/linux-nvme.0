Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0CDC47DB3
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 15:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZivfhSUO7bI2RKMPml4q0PLZcT/iq60BoR/pRi33AGc=; b=k6qhTJO/cPSd8jUIYGfxq1ST4q
	Rf6azpgRU+hOA3PNaIL9ds3zCwhR8tGFA+L/qPDlbWPCq/Csn3n5y2tBOqdKzXUSAQ5H2BOKQCuyF
	OlVaz8rPzW2noL2fcwGnINvP0dDcxlkEwcNDJUs8Kr4Wg5cnEjwfsUMjfsSkvoXeSCGg70O04HS8/
	371IEl9a/O0tEm8FfU4e1uJXE+ICUJTvuYGpcuIPE/V9ixy4OszLofW7kdY5HiL2MUjVQvwB01ydW
	EHHQijvjPUTE1vDknHhRBHUWhBa/T2I1C7Cky30MX4PbQDTHCmT8QaRESM36/RjPw31Mv2HXjhaSR
	EZSs9IcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUTdS-0000000DIKo-3bCQ;
	Mon, 29 Jan 2024 15:33:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUTdP-0000000DIIK-3Rft
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 15:33:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706542398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZivfhSUO7bI2RKMPml4q0PLZcT/iq60BoR/pRi33AGc=;
	b=PoX5Dgi+PL1+X5+Ci7VurVgA4Tl0Sna1QnMvUKhrjW7CgE0aL7nqQR/ghQrX7cUL/sULqG
	6J56y9aQZ3gEbSFHB/gzHLiqoujn1WlZSiyT/Lapd3DNHuzhaO/bFgEpA1i8w6XIGePvGA
	ziZVBM8SyvVPjZawHdK1mtSKlzNb09Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-BH2EogReOViRxfbv1EkbXg-1; Mon,
 29 Jan 2024 10:33:16 -0500
X-MC-Unique: BH2EogReOViRxfbv1EkbXg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D7C5B1C0BB43;
	Mon, 29 Jan 2024 15:33:15 +0000 (UTC)
Received: from [10.22.16.145] (unknown [10.22.16.145])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7DA3940C122E;
	Mon, 29 Jan 2024 15:33:15 +0000 (UTC)
Message-ID: <c074403e-9e77-4712-b0ad-e53db709a9ac@redhat.com>
Date: Mon, 29 Jan 2024 10:33:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 3/3] nvme-fc: show hostnqn when connecting to fc target
To: "Nitin U. Yewale" <nyewale@redhat.com>, chaitanyak@nvidia.com,
 linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 loberman@redhat.com
References: <20240129110639.45542-1-nyewale@redhat.com>
 <20240129110639.45542-3-nyewale@redhat.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20240129110639.45542-3-nyewale@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_073320_047961_4DFB8C9E 
X-CRM114-Status: GOOD (  11.93  )
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
>   drivers/nvme/host/fc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 16847a316421..7ac565b0f13b 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3575,8 +3575,8 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>   	flush_delayed_work(&ctrl->connect_work);
>   
>   	dev_info(ctrl->ctrl.device,
> -		"NVME-FC{%d}: new ctrl: NQN \"%s\"\n",
> -		ctrl->cnum, nvmf_ctrl_subsysnqn(&ctrl->ctrl));
> +		"NVME-FC{%d}: new ctrl: NQN \"%s\", hostnqn: %s\n",
> +		ctrl->cnum, nvmf_ctrl_subsysnqn(&ctrl->ctrl), opts->host->nqn);
>   
>   	return &ctrl->ctrl;
>   


