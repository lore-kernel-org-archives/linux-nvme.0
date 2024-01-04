Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD4AC47073
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 13:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=trEnkqQra4icgZANuNy6/vtZQkCyNvtcqB1SqhxSZ/U=; b=qtMAHLfCF2aV6kPL9nIpLNJsgy
	Mi8/1AwB0WZmEDt+MklwGzUVIIRVv/heKJ56OhIZDq+JNLk0BmNWJTX1gcFeXdrirF7/VonJdbQV0
	UEDq2aQdoWtzYrb649wpumfJinMYRpydOJfu8DoiEUrEQK8nfZ7R7MGSKoBwvzrBFFzOzcm+zBmus
	vv21nEhFL+0UWEqZofySbENOqBGOars3IWK+8VdS1XwK6ciJ9VG3VLeYWwg53oyMnuct8hOvJC4gI
	GZADROmMoSUzEs+y+5WavYqrGxp8c8+1idh3kLmzk6AZJ02UTlFufKG70SyU0/lYG15EAc3GfzTyB
	+q6/5rvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLNUU-00E5UV-2M;
	Thu, 04 Jan 2024 13:10:30 +0000
Received: from mail-lf1-f44.google.com ([209.85.167.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLNUR-00E5Sl-0F
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 13:10:28 +0000
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e7e6239e1so66412e87.0
        for <linux-nvme@lists.infradead.org>; Thu, 04 Jan 2024 05:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704373821; x=1704978621;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=trEnkqQra4icgZANuNy6/vtZQkCyNvtcqB1SqhxSZ/U=;
        b=jOWF8O9LMJ6llYXS0I2kXwvXA1RrnMj+F9EE3gvVE9SQtwRwTIJ2F5e3MQmeFd+JYh
         r7FIXBXwyAmJdluT/cWaiEtJ3OFqHYwqr6WW77Vljz0OG1mhMblg1/Io2Hqxk07tQsbL
         8Z/yoFIlS/AxK+/Y73XMkZP3cRnf0sKB43iB4wbvHLb7z6q7vP5ZH+Ux9JvopvduCM5w
         U4tQcAtUWYvgmUZfsfci52EdTYixv+rFTpTCe/h81G9kpV7qDIDN2OFDIDbaNSny1uUC
         i7BCqjt0VvdbamRq4AIBgQ8tLL3sSNyenk+PAcxznBo/LIH5JAjY4xanXtzo/v6Y/D4x
         /0nQ==
X-Gm-Message-State: AOJu0YwzEpPa54je4RORVvjuM1LZErpd7LiV13Hllmc9tUzYEedIPuD2
	8M51iwoH9fKtccS05Yit5Ic=
X-Google-Smtp-Source: AGHT+IGu218zghMI0mP0fxSxTgbk4byfZQwRtzwHQVdPQqKylTPz7/cmOLrL4kpqo+ml3ci1AmlElA==
X-Received: by 2002:a05:6512:3c9f:b0:50e:76e0:b9c5 with SMTP id h31-20020a0565123c9f00b0050e76e0b9c5mr880436lfv.0.1704373820830;
        Thu, 04 Jan 2024 05:10:20 -0800 (PST)
Received: from [10.100.102.14] (46-116-232-10.bb.netvision.net.il. [46.116.232.10])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c469400b0040d85a304desm5762448wmo.35.2024.01.04.05.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 05:10:20 -0800 (PST)
Message-ID: <1c92e8cf-2a46-418a-8a31-b9f43a1f151c@grimberg.me>
Date: Thu, 4 Jan 2024 15:10:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: Fix the H2C expected PDU len calculation
Content-Language: en-US
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: zahavi.alon@gmail.com, chaitanyak@nvidia.com,
 linux-nvme@lists.infradead.org, kbusch@kernel.org
References: <20240103110804.129921-1-mlombard@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240103110804.129921-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_051027_140877_014F684C 
X-CRM114-Status: GOOD (  17.46  )
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

> The nvmet_tcp_handle_h2c_data_pdu() function should take into
> consideration the possibility that the header digest and/or the data
> digests are enabled when calculating the expected PDU length before
> comparing it to the value stored in cmd->pdu_len.
> 
> Fixes: efa56305908b ("nvmet-tcp: Fix a kernel panic when host sends an invalid H2C PDU length")
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/target/tcp.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 3569c1255c5e..717ea1e5f4c3 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -979,7 +979,7 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
>   {
>   	struct nvme_tcp_data_pdu *data = &queue->pdu.data;
>   	struct nvmet_tcp_cmd *cmd;
> -	unsigned int plen;
> +	unsigned int expected_len;
>   
>   	if (likely(queue->nr_cmds)) {
>   		if (unlikely(data->ttag >= queue->nr_cmds)) {
> @@ -999,9 +999,12 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
>   		goto err_proto;
>   	}
>   
> -	plen = le32_to_cpu(data->hdr.plen);
> +	expected_len = le32_to_cpu(data->hdr.plen);
> +	expected_len -= nvmet_tcp_hdgst_len(queue);
> +	expected_len -= nvmet_tcp_ddgst_len(queue);
> +	expected_len -= sizeof(*data);

I think we should call it exp_data_len.

Why not do:
	exp_data_len = le32_to_cpu(data->hdr.plen) -
			nvmet_tcp_hdgst_len(queue) -
			nvmet_tcp_ddgst_len(queue) -
			sizeof(*data);

>   	cmd->pdu_len = le32_to_cpu(data->data_length);
> -	if (unlikely(cmd->pdu_len != (plen - sizeof(*data)) ||
> +	if (unlikely(cmd->pdu_len != expected_len ||
>   		     cmd->pdu_len == 0 ||
>   		     cmd->pdu_len > NVMET_TCP_MAXH2CDATA)) {
>   		pr_err("H2CData PDU len %u is invalid\n", cmd->pdu_len);

