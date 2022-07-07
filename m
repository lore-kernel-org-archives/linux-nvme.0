Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632BDC43334
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jul 2022 06:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2i5F2UHThDDLZFRDG81pmWSGKESPA47Dqg69Q/GCOAk=; b=FUHd3CpSJsXdZH2ePGR4GyQP5F
	jCuN1fDFYRHFcEmWd35qYeiusRgPHfrSiko9fy4iKXmNWI8KpJLfZ+1bU67MtvEXsupCHnzr4jr8g
	+oVhq1b1DDBmorAWWaY61QrIDFh2aaKtfmKob5bKXKo+l9FnP9DuuR/Xy/aYlahkEp5kW9xPMJqPg
	nc2sYJ3FVWF/0PkGw7mBzwMDmsR+836Jxz9czKhajl3353xKnLXAp3o5vhkvvoK78cBRjKYyf+X0T
	ZTo5qv/YwhTryJDpsMYViLdEeSoYVio4w5+ae6C2vlKZq5Ft9hswI627rUBOSF4azd0v817mUPK3d
	WnxML+/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9L1a-00E1qJ-9L; Thu, 07 Jul 2022 06:30:06 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9L1Y-00E1oW-0M
	for linux-nvme@lists.infradead.org; Thu, 07 Jul 2022 06:30:05 +0000
Received: by mail-wr1-f50.google.com with SMTP id bk26so9772617wrb.11
        for <linux-nvme@lists.infradead.org>; Wed, 06 Jul 2022 23:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2i5F2UHThDDLZFRDG81pmWSGKESPA47Dqg69Q/GCOAk=;
        b=H1n1x3Kw6ndeSIgbpMaYh1d3ayClS6sjhyirBfYkP1IH5i+9b5cqoiuftX6xllsx9f
         kDElUwopMBPmQcBeqm8LeVH4uJyhPskB/+CD/1aDtoNs3zZLwIFjon5Cuu0hlpEmxYmF
         sz++eR2EintUm9a9d3rKYLzCSYQR85LM+i7RGWAFaKYbjF5Nhzs8AmJU19R/XukVo83F
         1AGLAnMAWlEUoxLlJySfZTVloHlSdyN7vC3XSha7DjcOgiiWKQN4Mxd44PX6H3XSCGuo
         NzSGERn9cJZMlg3tF2SbA88/Q/PfOMeED6Rnohbddw0HpY9Gmo3wakfZBLIUlTisd0/J
         5apg==
X-Gm-Message-State: AJIora+wWCQ+bFXbUG7jHegDvbCJpvcpu+J08xC1IUu1F7bnQbKNx/6V
	OvOfLuWGuHfWPfWdSiWsNyU=
X-Google-Smtp-Source: AGRyM1v16Fs0Ghh79Bpws457/qctEl+jdR55D9UHvaeiOC18No4UsdiuYlrICgxV7gdzvh15rsGzhQ==
X-Received: by 2002:a05:6000:1243:b0:21d:6123:7a80 with SMTP id j3-20020a056000124300b0021d61237a80mr25181685wrx.354.1657175400866;
        Wed, 06 Jul 2022 23:30:00 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id l26-20020a1ced1a000000b003a03ae64f57sm7148137wmh.8.2022.07.06.23.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 23:30:00 -0700 (PDT)
Message-ID: <4cfe8116-bb6c-735d-0bb3-ce5e2612505b@grimberg.me>
Date: Thu, 7 Jul 2022 09:29:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] nvme/tcp: use in-capsule data for fabrics commands
Content-Language: en-US
To: Caleb Sander <csander@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
References: <20220616144915.1004305-1-csander@purestorage.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220616144915.1004305-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_233004_087643_63298AA8 
X-CRM114-Status: GOOD (  19.91  )
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


>> The maximum amount of in-capsule data for Fabrics and Admin Commands
>> is 8,192 bytes ... NVMe/TCP controllers must support in-capsule data
>> for Fabrics and Admin Command Capsules
> 
> Currently, command data is only sent in-capsule on the admin queue
> or I/O queues that indicate support for it.
> Send fabrics command data in-capsule for I/O queues too to avoid
> needing a separate H2CData PDU.

The only fabrics command that is sent on an I/O queue is connect.
But I guess that if ioccsz=0 that would cause connect to use h2cdata...


> 
> Signed-off-by: Caleb Sander <csander@purestorage.com>
> ---
>   drivers/nvme/host/tcp.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index bb67538d2..f1869ab3c 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -207,12 +207,15 @@ static inline u8 nvme_tcp_hdgst_len(struct nvme_tcp_queue *queue)
>   static inline u8 nvme_tcp_ddgst_len(struct nvme_tcp_queue *queue)
>   {
>   	return queue->data_digest ? NVME_TCP_DIGEST_LENGTH : 0;
>   }
>   
> -static inline size_t nvme_tcp_inline_data_size(struct nvme_tcp_queue *queue)
> +static inline size_t nvme_tcp_inline_data_size(struct nvme_tcp_queue *queue,
> +		struct nvme_tcp_request *req)
>   {
> +	if (nvme_is_fabrics(req->req.cmd))
> +		return NVME_TCP_ADMIN_CCSZ;
>   	return queue->cmnd_capsule_len - sizeof(struct nvme_command);
>   }
>   
>   static inline bool nvme_tcp_async_req(struct nvme_tcp_request *req)
>   {
> @@ -227,11 +230,11 @@ static inline bool nvme_tcp_has_inline_data(struct nvme_tcp_request *req)
>   		return false; /* async events don't have a request */
>   
>   	rq = blk_mq_rq_from_pdu(req);
>   
>   	return rq_data_dir(rq) == WRITE && req->data_len &&
> -		req->data_len <= nvme_tcp_inline_data_size(req->queue);
> +		req->data_len <= nvme_tcp_inline_data_size(req->queue, req);

We can just pass req and reference the queue from the request itself.

