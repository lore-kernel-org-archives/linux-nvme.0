Return-Path: <SRS0=kXjr=B7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415FEC433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 15:55:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AEE20855
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 15:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="3grkZ9Qn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AEE20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=khPOjXkhhiPAQ/IiqzMrhHYR9viCs3y99X6R1TakiQE=; b=3grkZ9QnnPruvOfMfrt1533l1
	G8f58nIDN/Fvl9vvY0RHForwU7z6f3HJTCON4JGR1czxSJ9GEB/G9PntafK3my0qVtoGLitVziVJQ
	P6VfVr/6e+nl3vJPSGxqPbxSqO2ifp8eTT8+BBv0FRrmxge+g0yhuED727mLra6Si4RCxqWpNUc90
	tuBAOSaUq978frcmeV71AGelftUNLOnzecyCDLLoy87bc/PniWtFed1NPJCtZOcIaDhfULqKR1eyJ
	YljY69JlaJKW0g1E8PYFyNJDEUuMYZGbols7QABGMuJxmECzYFboIHUNkfzFS0zAW3k5QS5BQ/Erw
	W6+VVeTmg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k99ON-0006ea-0E; Fri, 21 Aug 2020 15:55:47 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k99OL-0006do-2B
 for linux-nvme@lists.infradead.org; Fri, 21 Aug 2020 15:55:45 +0000
Received: by mail-pf1-f193.google.com with SMTP id y206so1255854pfb.10
 for <linux-nvme@lists.infradead.org>; Fri, 21 Aug 2020 08:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xMyGTs8UlgLuTF7QrzeT/+5ekSkwmvNII9Yhpaqlj1Q=;
 b=LUCFE/0MF/n/3sLtwG/z3xffonjQ/0WdNTeNFmNC7ClcUwcl768nVtLVo5YskQbLFZ
 ufN6gtVaLWgWLIdB44X3MvAnqy5V0oOhuq6R6Mu912R4adifWj8QuVU2o1sx/LW5pwcI
 X/BoU8RHbPssogFQzl4ErQhS2uVO/ZzT83VzcXS8tmjoT9k7RT5dF1nICc0W1lEh81o2
 /cKThShH2DP8J+c4arILR24wrd98AMVZkw3yJDmPLP5dqHzrQbhbXR0O9BoSAu6f2iP0
 TwVVityj9E50kZ2RI1MN3yLQ8fybFPhI+SBae46ilQ4/puzNRd0CbmxDWA+dHR1JehFD
 rdgQ==
X-Gm-Message-State: AOAM530ngb6wf8SgnnG02dAcYz8sUesDWRGdamgsTMjw5G7J3W5ixPrv
 8jAKGvWs+l58j1zomxu86aowrnd7R/jqtQ==
X-Google-Smtp-Source: ABdhPJz9UPrB9mUOt6AjFv9FGSdLk0BATDc53ud/5BZ+xLQhPoesleuArYcbmG2PSlBRcUTYif9qAQ==
X-Received: by 2002:a62:1a49:: with SMTP id a70mr3066522pfa.297.1598025343436; 
 Fri, 21 Aug 2020 08:55:43 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:95a5:8a0f:6e94:b712?
 ([2601:647:4802:9070:95a5:8a0f:6e94:b712])
 by smtp.gmail.com with ESMTPSA id w187sm2934624pfd.87.2020.08.21.08.55.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 08:55:42 -0700 (PDT)
Subject: Re: [PATCH] nvmet-tcp: Fix NULL dereference when a connect data comes
 in h2cdata pdu
To: Ziye Yang <ziye.yang@intel.com>, linux-nvme@lists.infradead.org
References: <20200821161112.50363-1-ziye.yang@intel.com>
 <20200821164810.8970-1-ziye.yang@intel.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <59671b4a-828e-7b98-507a-181e6dfa55e7@grimberg.me>
Date: Fri, 21 Aug 2020 08:55:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821164810.8970-1-ziye.yang@intel.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200821_115545_121893_03415C4A 
X-CRM114-Status: GOOD (  24.83  )
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


> When handling commands without in-capsule data, we assign the ttag
> assuming we already have the queue commands array allocated (based
> on the queue size information in the connect data payload). However
> if the connect itself did not send the connect data in-capsule we
> have yet to allocate the queue commands,and we will assign a bogus
> ttag and suffer a NULL dereference when we receive the corresponding
> h2cdata pdu.
> 
> Fix this by checking if we already allocated commands before
> dereferencing it when handling h2cdata, if we didn't, its for sure a
> connect and we should use the preallocated connect command.
> 
> Signed-off-by: Ziye Yang <ziye.yang@intel.com>
> ---
>   drivers/nvme/target/tcp.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 9eda91162fe4..8e0d766d2722 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -160,6 +160,11 @@ static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
>   static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
>   		struct nvmet_tcp_cmd *cmd)
>   {
> +	if (unlikely(!queue->nr_cmds)) {
> +		/* We didn't allocate cmds yet, send 0xffff */
> +		return USHRT_MAX;
> +	}
> +
>   	return cmd - queue->cmds;
>   }
>   
> @@ -866,7 +871,10 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
>   	struct nvme_tcp_data_pdu *data = &queue->pdu.data;
>   	struct nvmet_tcp_cmd *cmd;
>   
> -	cmd = &queue->cmds[data->ttag];
> +	if (likely(queue->nr_cmds))
> +		cmd = &queue->cmds[data->ttag];
> +	else
> +		cmd = &queue->connect;
>   
>   	if (le32_to_cpu(data->data_offset) != cmd->rbytes_done) {
>   		pr_err("ttag %u unexpected data offset %u (expected %u)\n",
> 

Ziye, usually we send versioning of the patches with prefix PATCH
v1/2/3,

and also add what was changed since prior versions.

This patch looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
