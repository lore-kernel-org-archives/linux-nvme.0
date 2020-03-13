Return-Path: <SRS0=xptm=46=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CC8C10DCE
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2020 20:24:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96DCA20751
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2020 20:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sspw/isE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DCA20751
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Sfr5BNLWWDluwDThcdBpbu16nrtu4wlJ0TEky8gjtCI=; b=Sspw/isEzWJDBN5aaytzAPlpy
	DHQFXJGpVgSEeKK64c006dDkRRanvBWEQyeAENqPOkl1HXp35GFhnPGeYE3TLCf1HnuS9zWyqJjJ5
	jW5mK56nBXDdr2Ww/9wjHfwTxhReoR+0e4ajG4Gdyv7SXQHxSKUzT1S8npl02hC9kkGjp5k8Ck2e3
	FYaGn74jEeaLvn80CiaKdiwXdIYV7ss9un0l62Blns/QBTqiqvNUuU/nZ21LF9hdlF4Tb3kjnZwKG
	eMlYVq4vAXppncFJ5DdQjDH48/SypgMJAl/7+5A+eRTTeZmHnD7C6P+1HVzWYJrkvdXyoM04NFZ2m
	8TNqPMybg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jCqqw-0004AX-Oi; Fri, 13 Mar 2020 20:24:18 +0000
Received: from mail-wm1-f65.google.com ([209.85.128.65])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCqqs-0004AC-QK
 for linux-nvme@lists.infradead.org; Fri, 13 Mar 2020 20:24:16 +0000
Received: by mail-wm1-f65.google.com with SMTP id g62so11663366wme.1
 for <linux-nvme@lists.infradead.org>; Fri, 13 Mar 2020 13:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oVhfG9AVIYryfJJgpQxRnfbsr9Yz1uuJYyaqyMWAykY=;
 b=jGt741oK8Q5NEuoCqrrrurfokMxHLauMZwtLDcLM1YAY9XU2naiWnhBY9Wx58ypDLB
 K8ca8sO2tG+3/hXW7RQCq6Z5XlXDjrSDWXHlUqQeCGKweZ6e9N0QXILk6rIdtKzGk6yY
 jsEAIxfHJJCaw5Ny9+eQIFCFatHakBcVVN3nkhUS4qHTg4SacsQmPBtsY+Ehq5IDvDCM
 w/QDqLKD40j5i36nHEDAz0gjqhaes55p8VB466sTDUDJ2Rp/wC9yFw+LbV7T/SlKdcub
 ZkNs/4VK7NTg/IqySkOZ0M2N98IR7jnFVD0juHwLTJ/fbYrA6UvmnBWh4jE+DH7kLIKe
 B5hA==
X-Gm-Message-State: ANhLgQ3NRftY9Fj92kDepsTA85QNO681PDEWAJJPFYo5r49pmNIg0KYf
 WILQ1wXmysIKfyoL6ZD/u9DHoXkl
X-Google-Smtp-Source: ADFU+vt2HETRCvx9rqB3U86uUf45o8Jk8wkfSqBnxeNS0YgviqaYdzRAzj6BdrF50udKWl8FvjHW7Q==
X-Received: by 2002:a1c:c906:: with SMTP id f6mr12639643wmb.16.1584131053105; 
 Fri, 13 Mar 2020 13:24:13 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0::41? ([2600:1700:65a0:78e0::41])
 by smtp.gmail.com with ESMTPSA id i67sm59626513wri.50.2020.03.13.13.24.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Mar 2020 13:24:12 -0700 (PDT)
Subject: Re: [PATCH] nvme/fc: use real sqsize as argument when connecting
 queues
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20200313124808.39320-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7454340a-1cf1-d661-d1b8-e0181f755619@grimberg.me>
Date: Fri, 13 Mar 2020 13:24:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200313124808.39320-1-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200313_132414_857174_B3CFFD1F 
X-CRM114-Status: GOOD (  18.53  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 James Smart <james.smart@broadcom.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 3/13/20 5:48 AM, Hannes Reinecke wrote:
> When creating queues we should be passing in the real sqsize number,
> and not increasing it by one just so that the function has to
> substract it again.

Kinda makes more sense to pass around actual queue size and
not the zero-based version of it, isn't it?


> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/fc.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 0cbc4a703359..f76325a47578 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1211,7 +1211,7 @@ nvme_fc_connect_admin_queue(struct nvme_fc_ctrl *ctrl,
>   				sizeof(struct fcnvme_lsdesc_cr_assoc_cmd));
>   
>   	assoc_rqst->assoc_cmd.ersp_ratio = cpu_to_be16(ersp_ratio);
> -	assoc_rqst->assoc_cmd.sqsize = cpu_to_be16(qsize - 1);
> +	assoc_rqst->assoc_cmd.sqsize = cpu_to_be16(qsize);
>   	/* Linux supports only Dynamic controllers */
>   	assoc_rqst->assoc_cmd.cntlid = cpu_to_be16(0xffff);
>   	uuid_copy(&assoc_rqst->assoc_cmd.hostid, &ctrl->ctrl.opts->host->id);
> @@ -1326,7 +1326,7 @@ nvme_fc_connect_queue(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
>   				sizeof(struct fcnvme_lsdesc_cr_conn_cmd));
>   	conn_rqst->connect_cmd.ersp_ratio = cpu_to_be16(ersp_ratio);
>   	conn_rqst->connect_cmd.qid  = cpu_to_be16(queue->qnum);
> -	conn_rqst->connect_cmd.sqsize = cpu_to_be16(qsize - 1);
> +	conn_rqst->connect_cmd.sqsize = cpu_to_be16(qsize);
>   
>   	lsop->queue = queue;
>   	lsreq->rqstaddr = conn_rqst;
> @@ -2484,11 +2484,11 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
>   		goto out_free_tag_set;
>   	}
>   
> -	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> +	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize);

What if the LLDD will allocate based on this argument?

>   	if (ret)
>   		goto out_cleanup_blk_queue;
>   
> -	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> +	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize);
>   	if (ret)
>   		goto out_delete_hw_queues;
>   
> @@ -2539,11 +2539,11 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
>   	if (ctrl->ctrl.queue_count == 1)
>   		return 0;
>   
> -	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> +	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize);
>   	if (ret)
>   		goto out_free_io_queues;
>   
> -	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> +	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize);
>   	if (ret)
>   		goto out_delete_hw_queues;
>   
> 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
