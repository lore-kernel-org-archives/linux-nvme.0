Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F8CC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 20:49:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1897207DE
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 20:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WTG06xCw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HsX9PyQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1897207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hWkkGZ4KYA39/7KzXZ4vdqCxyqnrkMR1Sug5aFZ278M=; b=WTG06xCwSI6nQc+etVVUJndC0
	vqCNJ5kiL2dWHgcUbKuoqNbtO+oh6Kdev+XB4esHHeXWqrf0nzIlFsWar7R+vnzgcttq3D/AjlcBT
	Q08UBBoImEB74ULWzHgvdG6BWAZcFcY87CePKu/3S0K/Of1TIkal1UrbuMCf2FDAdy0HfIrAC6Y7b
	RhXAfxIOQQ31/H4R82K19sV//M8Sd3p0AMAd/RxVrPyDvYjyyH7KkpYwFJz3wfnLTwrgXulSsOQPO
	IYjBgZbF5Gw3JGjNo0Jd/53pLXV45bBpfrm2OTRJwTo5Sma08tDkGhk3usXa14rQZBfKp5uwNtjrm
	x7PyI/XzQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8rUs-0001vy-Jr; Thu, 20 Aug 2020 20:49:18 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8rUp-0001vQ-PK
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 20:49:16 +0000
Received: by mail-pf1-x442.google.com with SMTP id x25so1633721pff.4
 for <linux-nvme@lists.infradead.org>; Thu, 20 Aug 2020 13:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=KzL+H7CWU+GRE2NdlyOq7ACubX38ovQr8Z31uLdph0Q=;
 b=HsX9PyQLwoXdRW+cthiMyjutlsFhL86FQ7eRFDJxpAemDgB4aLbL0pJzaHsTLHpLK6
 XfzuJHMfJYZtkSzNFmHbXAWq/iJvwiZJAIClLsvN31IIdO0H7cj7UFfgmAlTqZAYgzuQ
 7F70fhLy3BeWijthI4rSKXjun9fySZRgVL91w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=KzL+H7CWU+GRE2NdlyOq7ACubX38ovQr8Z31uLdph0Q=;
 b=QIp7cwVQVHDnXF6bqhAq02V/UF/CEYEbQjeRaG02aGUh383uQ4cDL3YdmmHja3jHLc
 YyVjxsE9UFR6YVlHS77jKjLm1d23SiDEvmG6vIvRKKFUJsrWexu47Jn8jdGPgh8ADcby
 QP3Yr6j4X7BnlRR0FGuS8OmO5SqH1C+qEc7ReZp/tukpMKch/yeEgZ0FKpObeVpu5x/Z
 flXrInmah648yCaJzNahjZMlPh0q6Ge2AkstGzwwW9G/I9z2Aj8CYAhzwgsAbU391D2v
 jL8zK2z7RvRkHZzbNciRNPF9VfmGzGDqzWsas2e9TU2hIHhoREcQNKR9S9S4qUBm4iYB
 84Ow==
X-Gm-Message-State: AOAM531XMellSl2tsfVEk5Yo2DLzMllJPTFFHTinaze1AP+hvrHuqA1b
 TN8PodNlQe5Bhv+vnMrlRCNNv4bL80dZ1w==
X-Google-Smtp-Source: ABdhPJz7osfZM0M4tZuP7TRz3vbvZxRO95KuOy/hvhE70+sZyQaKsZa2Sm4UUsBPIJ3eGrpoZuJ9Cg==
X-Received: by 2002:a63:67c5:: with SMTP id b188mr420952pgc.412.1597956553415; 
 Thu, 20 Aug 2020 13:49:13 -0700 (PDT)
Received: from [10.69.69.102] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id s6sm2974659pjn.48.2020.08.20.13.49.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 13:49:12 -0700 (PDT)
Subject: Re: [PATCH v3 1/9] nvme-fabrics: don't check state NVME_CTRL_NEW for
 request acceptance
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <20200820053651.197057-2-sagi@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <a035ab33-3c40-5f62-2742-17dd70ee6551@broadcom.com>
Date: Thu, 20 Aug 2020 13:49:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200820053651.197057-2-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_164915_861827_F33B66FD 
X-CRM114-Status: GOOD (  19.32  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 8/19/2020 10:36 PM, Sagi Grimberg wrote:
> NVME_CTRL_NEW should never see any I/O, because in order to start
> initialization it has to transition to NVME_CTRL_CONNECTING and from
> there it will never return to this state.
>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/fabrics.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 4ec4829d6233..32f61fc5f4c5 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -576,7 +576,6 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
>   	 * which is require to set the queue live in the appropinquate states.
>   	 */
>   	switch (ctrl->state) {
> -	case NVME_CTRL_NEW:
>   	case NVME_CTRL_CONNECTING:
>   		if (nvme_is_fabrics(req->cmd) &&
>   		    req->cmd->fabrics.fctype == nvme_fabrics_type_connect)

Reviewed-by: James Smart <james.smart@broadcom.com>

-- james

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
