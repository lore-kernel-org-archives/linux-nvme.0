Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF65C761A6
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 13:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m4eUoDWNw1Z+l6YYHfOywwPEfIF8+TCWzoLU7qfq1dA=; b=CJ6G96RYfwXPSyqx2T2M2ALvou
	+FRShLvMVisc1WxNEuxJhMhtpEwz8h0qbdItbuNcuqWBjexXkwVHdmrnRv0o7ic8+1og/9hqGS+r0
	C9g3i1joY/fY36fZv5VkvCFQIil/laZc0AGxMlwKRNQAmpXByMvu/Q/8tq36jQkYIKagX+wMScly8
	afHfFUDqamKj2XCOYXdPJpGVM9K1Cy/OhCX0Z/i5gRGISOBfnJ/qLEwLTmg8OC7UPbLLBQzMC9Lzi
	y1IcRU7K3/KtQ1YIATmPmbvI3oxIiSVcfYH99c/K4cIxM8GYvEAF70V34LvKM9QFpVGjQr9Iayj6B
	PDinoT1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pecJy-00CaX1-10;
	Tue, 21 Mar 2023 13:46:38 +0000
Received: from mail-ed1-f48.google.com ([209.85.208.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pecJw-00CaVg-15
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 13:46:37 +0000
Received: by mail-ed1-f48.google.com with SMTP id x3so59826549edb.10
        for <linux-nvme@lists.infradead.org>; Tue, 21 Mar 2023 06:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679406391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m4eUoDWNw1Z+l6YYHfOywwPEfIF8+TCWzoLU7qfq1dA=;
        b=dHqbewjdzEoZGeusQPb+xQyH9t7JnKn4S19oHahJq6DlQNn98PVTtp4WEsZxhjkjlV
         J2CNfeHrkyb3ancuY6kOUtnvJWeavqdnqD8PMNBJ+dmWk0X5kYFIW0+N1wefjsQyvvC3
         6eUyYtU0gTyDngedAoPz10rjOWingXrk64g38o/oiUSG0YGUSqgb/ASH4IlEXVluQWLY
         Oqe+iy8DEwSKOGvFBLnAf1skxzIhCizKousB3NV00VzuDHmT+NjUdkVcinBTmP+Qa04O
         a22hJwJysj2lkmuzcLFHeZhXtOTnZJZmXXNdreV3U/se2kUVWvwdMuMhlN7GfIzfr61j
         wjnA==
X-Gm-Message-State: AO0yUKVcEuh3V8lWEzihMY3D5cWNY7ob0LTJp0UxDtrbFMIv+Ry2NPFm
	Z+ycdOADciB122sp7Ut4R8y0Av2iuGc=
X-Google-Smtp-Source: AK7set/wFcrBQ14K5RnVnsMUhn9ELzmqIBnZ9rv9Hbd2LMbTpTgTTuSchlRAx8M6y1/uJN9uTU7IZg==
X-Received: by 2002:a17:906:749d:b0:92c:fc0:b229 with SMTP id e29-20020a170906749d00b0092c0fc0b229mr2864965ejl.0.1679406391347;
        Tue, 21 Mar 2023 06:46:31 -0700 (PDT)
Received: from [10.100.102.14] (85.65.253.165.dynamic.barak-online.net. [85.65.253.165])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090666c900b0092b606cb803sm5932709ejp.140.2023.03.21.06.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 06:46:31 -0700 (PDT)
Message-ID: <ed711471-e914-93d6-2b20-a0d2cb14d1b4@grimberg.me>
Date: Tue, 21 Mar 2023 15:46:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 03/18] nvme: add TCP TSAS definitions
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-4-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230321124325.77385-4-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_064636_376298_B1221077 
X-CRM114-Status: GOOD (  16.65  )
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



On 3/21/23 14:43, Hannes Reinecke wrote:
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   include/linux/nvme.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 779507ac750b..ea961ca2022d 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -108,6 +108,13 @@ enum {
>   	NVMF_RDMA_CMS_RDMA_CM	= 1, /* Sockets based endpoint addressing */
>   };
>   
> +/* TSAS SECTYPE for TCP transport */
> +enum {
> +	NVMF_TCP_SECTYPE_NONE = 0, /* No Security */
> +	NVMF_TCP_SECTYPE_TLS12 = 1, /* TLSv1.2, NVMe-oF 1.1 and NVMe-TCP 3.6.1.1 */
> +	NVMF_TCP_SECTYPE_TLS13 = 2, /* TLSv1.3, NVMe-oF 1.1 and NVMe-TCP 3.6.1.1 */
> +};

I think these should be located in nvme-tcp.h
Otherwise looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


> +
>   #define NVME_AQ_DEPTH		32
>   #define NVME_NR_AEN_COMMANDS	1
>   #define NVME_AQ_BLK_MQ_DEPTH	(NVME_AQ_DEPTH - NVME_NR_AEN_COMMANDS)
> @@ -1458,6 +1465,9 @@ struct nvmf_disc_rsp_page_entry {
>   			__u16	pkey;
>   			__u8	resv10[246];
>   		} rdma;
> +		struct tcp {
> +			__u8	sectype;
> +		} tcp;
>   	} tsas;
>   };
>   

