Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDEBECAAD3
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 15:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+ANIC5SaRnjz9kfPIsLV+WYrkY9Kf6FbMwQz5Ec/v6M=; b=lB/BxPIi+y2/2kfQ3B8+gVpPQy
	FiunBN+p5HDfOmuApbNjgnDRLoIyNUdeGr77ZFIEccfdwXRdkd8GEO5M+JhIl2dtgbfwFhHtRyPZn
	kzeKN5U2EUdxb6mNB44dWjMQ2Gvn74YF7c3PpvZ+leFxLFjHbnni4adSRDXuzVivIr79Y0Iyk5w4w
	zJujmIwPQXGnwLbR8JHZ1xgBaJ5fR8QMpoXJx8wzHdGObeIobt0tUclr56vlB/JabJfWfc2spGEYW
	6xI6LylK1DwHzwVALk56t8wMxfTDlDYpnhWUi9B/m+6fxM61DljYVuh6gT2ky1Se9oLzHfzLBVxsn
	ESadtP7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVE02-005vDX-Dp; Mon, 05 Sep 2022 15:26:58 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVArd-001n7Z-6D
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 12:06:08 +0000
Received: by mail-wr1-f50.google.com with SMTP id c11so6840345wrp.11
        for <linux-nvme@lists.infradead.org>; Mon, 05 Sep 2022 05:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+ANIC5SaRnjz9kfPIsLV+WYrkY9Kf6FbMwQz5Ec/v6M=;
        b=gPsfI9L6rNmgegsH754dHTjE0S5Eu3P6m1i+G7R6pOuPCU25VgckN37b+PC7Uz8oJU
         VbHIpzYQmYzYEptMVnWpbLts0uc+BLdAmJPSH+2/bIFaKxSCCzDbNmRoHbdvWl8SskaM
         1rLqQvLhr6bO+TvKXbOnDZPv/llKKJ8NIxvogfqj79To+ymjFYO6jB+9zudEFPt0WwUG
         Ojw5e8Z7ZQP8/RWFPRXaGSG4IZ31R6WYyxIvBFRBJXS7DSupefP9Ke1TG1iRpW1N2pek
         Brd5I2aQ6HpLayYrY61gvwxyvJFLuHz2DMWbAqTIzpctXBi2xmPBn8iEtF44dyjgSkPU
         xi7Q==
X-Gm-Message-State: ACgBeo3JZPjK0XIFv9UHc63ht6nhs3RP97lICEuopWL2vXSuKJbNd9zl
	GjHlib/cR3+KbfortxDSrZQN5JL3PIk=
X-Google-Smtp-Source: AA6agR7EFbOXRkzZjA3LWGS5uFQyibMeXdzjwWyBo4cMfJYmDI6CT65/do9TcXcAb1KAt14bFa2Wbg==
X-Received: by 2002:a05:6000:168d:b0:226:da6a:6d78 with SMTP id y13-20020a056000168d00b00226da6a6d78mr20175067wrd.180.1662379561921;
        Mon, 05 Sep 2022 05:06:01 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y1-20020adfd081000000b00228c8ed21c8sm927002wrh.17.2022.09.05.05.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 05:06:01 -0700 (PDT)
Message-ID: <db927303-525f-6925-7b26-a0f4d8545dad@grimberg.me>
Date: Mon, 5 Sep 2022 15:05:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] nvme-auth: retry command if DNR bit is not set
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Martin George <marting@netapp.com>
References: <20220830124925.40711-1-hare@suse.de>
 <20220830124925.40711-2-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220830124925.40711-2-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_050605_361030_B8201615 
X-CRM114-Status: GOOD (  23.69  )
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



On 8/30/22 15:49, Hannes Reinecke wrote:
> If the cqe returns a status with the DNR bit not set we should
> retry the command; otherwise we might incur spurious failures.
> 
> Reported-by: Martin George <marting@netapp.com>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/auth.c |  2 +-
>   drivers/nvme/host/core.c | 20 ++++++++++++++++++--
>   include/linux/blk-mq.h   |  2 ++
>   3 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index c8a6db7c4498..4ca3f7d042f1 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -69,7 +69,7 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
>   
>   	ret = __nvme_submit_sync_cmd(q, &cmd, NULL, data, data_len,
>   				     qid == 0 ? NVME_QID_ANY : qid,
> -				     0, flags);
> +				     0, BLK_MQ_REQ_RETRY | flags);

Surely there is a local way to have this than to leak a flag to
blk-mq...

>   	if (ret > 0)
>   		dev_warn(ctrl->device,
>   			"qid %d auth_send failed with status %d\n", qid, ret);
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 66ae23e9cb0e..a77f406512eb 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -355,7 +355,8 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
>   	if (likely(nvme_req(req)->status == 0))
>   		return COMPLETE;
>   
> -	if ((nvme_req(req)->status & 0x7ff) == NVME_SC_AUTH_REQUIRED)
> +	if ((nvme_req(req)->status & 0x7ff) == NVME_SC_AUTH_REQUIRED &&
> +	    !(nvme_req(req)->status & NVME_SC_DNR))
>   		return AUTHENTICATE;
>   
>   	if (blk_noretry_request(req) ||
> @@ -1037,15 +1038,30 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>   	if (IS_ERR(req))
>   		return PTR_ERR(req);
>   	nvme_init_request(req, cmd);
> +	if (flags & BLK_MQ_REQ_RETRY)
> +		nvme_req(req)->retries = nvme_max_retries;

Maybe just rename this to __nvme_submit_sync_cmd_retries() that accepts
retries argument, and then __nvme_submit_sync_cmd becomes:

int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command 
*cmd,
                 union nvme_result *result, void *buffer, unsigned bufflen,
                 int qid, int at_head, blk_mq_req_flags_t flags)
{
	return __nvme_submit_sync_cmd_retries(q, cmd, result,
			buffer, bufflen, qid, at_head, flags, 0)
}

And nvme_auth_submit() can call it with nvme_max_retries...

>   
>   	if (buffer && bufflen) {
>   		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
>   		if (ret)
>   			goto out;
>   	}
> -
> +retry:
>   	req->rq_flags |= RQF_QUIET;
>   	ret = nvme_execute_rq(req, at_head);
> +	if (ret > 0) {
> +		struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
> +
> +		if (ctrl->kas)
> +			ctrl->comp_seen = true;
> +
> +		switch (nvme_decide_disposition(req)) {
> +		case COMPLETE:
> +			break;
> +		default:
> +			goto retry;
> +		}
> +	}

Why is this needed? isn't nvme_complete_rq called on this request?

>   	if (result && ret >= 0)
>   		*result = nvme_req(req)->result;
>    out:
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index effee1dc715a..acd833f37cd4 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -713,6 +713,8 @@ enum {
>   	BLK_MQ_REQ_RESERVED	= (__force blk_mq_req_flags_t)(1 << 1),
>   	/* set RQF_PM */
>   	BLK_MQ_REQ_PM		= (__force blk_mq_req_flags_t)(1 << 2),
> +	/* Retry reserved commands */
> +	BLK_MQ_REQ_RETRY	= (__force blk_mq_req_flags_t)(1 << 3),

I don't think this is appropriate for what this is trying to do...

