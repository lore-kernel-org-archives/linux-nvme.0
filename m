Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA6FC4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Dec 2022 10:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wwNZHAnYMP91+VhZBEfshjGbR9tRTeS2Js3B8xnY/bc=; b=kQWIlQmMO5XulwnWtdUXOT4oLo
	0F9Tx120Y3/bpaE+Zggn5Q19NF+IBqWy+cdIzxesSbd/pso2pYJk7woKzPfD/7EjObi7OL4ZZuwHQ
	1zAx6LFSm+jNTicB7ModDv3CUqngLgk8ZOakEovKuSCmX3vBNAIXIFsjx8Jnxweb1dHY3OgRM9fvv
	0gzD588XqAi9j8PgqSfpGgwBN2cGw9I4mb+LukQ9jDnHsSCnj6HWKTmk9qp/QgYknc1nc1OQGVs47
	ALy1zv/Iu52wP1jTOZKoJqf4/YZisPM4YvK6RE+YHDT05C+RMMhxg4NiEOSDGVO347qNWsHGmfUJZ
	VR1i7Caw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9OXK-00AAlD-Ng; Sun, 25 Dec 2022 10:47:22 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9O1u-009tz9-AY
	for linux-nvme@lists.infradead.org; Sun, 25 Dec 2022 10:14:57 +0000
Received: by mail-wr1-f50.google.com with SMTP id z10so8099952wrh.10
        for <linux-nvme@lists.infradead.org>; Sun, 25 Dec 2022 02:14:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwNZHAnYMP91+VhZBEfshjGbR9tRTeS2Js3B8xnY/bc=;
        b=Ub7NtU070tkrzRCXcwgvr1IxQhvAZtY4s+JciPXgDCcPx32g25O9ETYRds2RYjOPzY
         yyOFCYavDHn1rkiExQK6Cl9fw9VF3gCpAPrOUjuzjtOZ73HD/xYN9CtUJvkJKEZUw2SM
         XlB0P7dlHE/cXcL9OzkuDxQnRzZGfsXKQhmMl9vuYYFoCQId+ZsTbyYZ2FCYnCEAb+1K
         whE9N37ildrsC4DdBQm1il34jLzd9z3Gt4DNZy//R410MhOlLDJhTrl0HiHyNcscdfc9
         Lc8w81OA+KqguaLxJhctxLHW8nVpkkKvc00kkHsog8EpMoa8r677s7WNSXlyK7MXJOhJ
         AQJQ==
X-Gm-Message-State: AFqh2kpAA5cmRKe2QDO85GK5UXmetnKj5Ww3ktsrDfcUEjD7AluLPkZE
	2Z9cVrNHAW7xH4esB7FFoU3eJ9a/Ld0=
X-Google-Smtp-Source: AMrXdXuYQJX1IYdfkhsLyvOk0Egp55vltPPVTVbxZGtFQfItuh7Tf0BRv5HHZx4tVe4xN2gWb+eGBw==
X-Received: by 2002:a05:6000:14a:b0:278:25c7:e844 with SMTP id r10-20020a056000014a00b0027825c7e844mr2532806wrx.45.1671963292990;
        Sun, 25 Dec 2022 02:14:52 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m15-20020a056000008f00b00267e918d1ecsm7498309wrx.24.2022.12.25.02.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Dec 2022 02:14:52 -0800 (PST)
Message-ID: <7bede1ec-cb3e-455b-5c41-a8360dbe6b60@grimberg.me>
Date: Sun, 25 Dec 2022 12:14:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/6] nvmet: don't defer passthrough commands with trivial
 effects to the workqueue
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
References: <20221223071814.43564-1-hch@lst.de>
 <20221223071814.43564-5-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221223071814.43564-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221225_021454_449587_9001E2B0 
X-CRM114-Status: GOOD (  22.51  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


On 12/23/22 09:18, Christoph Hellwig wrote:
> Mask out the "Command Supported" and "Logical Block Content Change" bits
> and only defer execution of commands that have non-trivial effects to
> the workqueue for synchronous execution.  This allows to execture admin

allows to execute admin

> commands asynchronously on controllers that provide a Command Supported
> and Effects log page, and will keep allowing to execute Write commands
> asynchronously once command effects on I/O commands are taken into
> account.
> 
> Fixes: c1fef73f793b ("nvmet: add passthru code to process commands")
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/target/passthru.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index 79af5140af8bfe..adc0958755d66f 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -334,14 +334,13 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
>   	}
>   
>   	/*
> -	 * If there are effects for the command we are about to execute, or
> -	 * an end_req function we need to use nvme_execute_passthru_rq()
> -	 * synchronously in a work item seeing the end_req function and
> -	 * nvme_passthru_end() can't be called in the request done callback
> -	 * which is typically in interrupt context.
> +	 * If a command needs post-execution fixups, or there are any
> +	 * non-trivial effects, make sure to execute the command synchronously
> +	 * in a workqueue so that nvme_passthru_end gets called.
>   	 */
>   	effects = nvme_command_effects(ctrl, ns, req->cmd->common.opcode);
> -	if (req->p.use_workqueue || effects) {
> +	if (req->p.use_workqueue ||
> +	    (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))) {
>   		INIT_WORK(&req->p.work, nvmet_passthru_execute_cmd_work);
>   		req->p.rq = rq;
>   		queue_work(nvmet_wq, &req->p.work);

Other than that,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

