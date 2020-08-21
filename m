Return-Path: <SRS0=kXjr=B7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ED6C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 05:57:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8EF420732
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 05:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WYuSx3Ay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8EF420732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=j4qjwvHp9TvWY/OWZRugufKhALGKEQpeyeQt6D7YR7s=; b=WYuSx3AyE34CkrUwLveneQ3qK
	EoMbx/EeTh1QghmGwCq4JrLJK+aCsFr8fjeVqBqvgpZSq+j44U00lZq6oTz+j03wEQ4RW8Yh1GLFY
	gwoeaBR5Wj43/9fmAwALLkIOOuGP4jrCV1rFDVUENCMBKJDaCEyqEtNc99M1/gJigZxsuIQkLLnQT
	JphitsYtvWp2DuW8jESnax7IY9QMoF95ms32LLPySB2ygWFM6z7qyJ5yjQkBMj9WmZqW3fZn0Pjkw
	y/LUsSA7SkanLMQaJBl+1h4cZSL8nGeO9MtdaIB6Jle+yixV+Gw0pfAHcPO7LvTHFdHCj17pPMyxk
	C1zlNBckA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k903k-0003U3-Mc; Fri, 21 Aug 2020 05:57:52 +0000
Received: from mail-pj1-f66.google.com ([209.85.216.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k903i-0003TW-1v
 for linux-nvme@lists.infradead.org; Fri, 21 Aug 2020 05:57:51 +0000
Received: by mail-pj1-f66.google.com with SMTP id d4so355243pjx.5
 for <linux-nvme@lists.infradead.org>; Thu, 20 Aug 2020 22:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cHmBO4GrouG+0CD2NPhvi0bLCQMEqAohjAf0LddtTTY=;
 b=So6f8UzKeKsl3t6by57s7GkZAibZEdCmKwG0JIdQuAnDWR9fMDmbHu6IdZZH2IeUvm
 xb98dyHU52BVuZQbYcvDrvReaxOo1+5tar77icscMFa1OSJMTjSLm41fSIaeWajD9/Ra
 8J16j7M0BZeKNsAxBhdsnFV4edyjLUHzB7b7s9H+Fg/FJPkHYWL7X3Nwnv0m17RhuFew
 zv7by/eF2QYs1HtUEM5UO7ErgM+yHYhn331gPA/boeVnX/h3Z6QRppOH5VnFw2TBy9+/
 KPTF0Micy0Tlc4ij6tnzX8OfnI78x8z1bAMiYKPqSf2MMwxsMa1O6BscZpae84Kx/YeD
 HEMA==
X-Gm-Message-State: AOAM532d3UVCdySobTUcVTRb9SpkJ1vjZn5muq0SnsEUoJbx4QK8Gvae
 y+cKkDxGrKkN1ggS24HQSPjNpbRAcyFb0w==
X-Google-Smtp-Source: ABdhPJzebNXmfaLXMp0jKL9yjItHRc9PoviIEnnPmY9sBrPJg7g4eVQzzK5QjgjeBlkR0s3wytwClA==
X-Received: by 2002:a17:902:c40d:: with SMTP id
 k13mr1153172plk.220.1597989467477; 
 Thu, 20 Aug 2020 22:57:47 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:95a5:8a0f:6e94:b712?
 ([2601:647:4802:9070:95a5:8a0f:6e94:b712])
 by smtp.gmail.com with ESMTPSA id 3sm1129265pfv.109.2020.08.20.22.57.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 22:57:46 -0700 (PDT)
Subject: Re: [PATCH] nvmet/tcp: Solve coredump issue while initiator sends
 write CapsuleCmd
To: Ziye Yang <ziye.yang@intel.com>, linux-nvme@lists.infradead.org
References: <20200821150252.40800-1-ziye.yang@intel.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e87116e2-f633-9656-3ef8-1621367b28a2@grimberg.me>
Date: Thu, 20 Aug 2020 22:57:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821150252.40800-1-ziye.yang@intel.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200821_015750_141452_697D7028 
X-CRM114-Status: GOOD (  26.59  )
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

Hey Ziye,

> When the initiator sneds write CapsuleCmd without incapsuledata, we
		     sends                          in-capsule data

> can use the queue->connect command to handle. If we do not do that,
> we will have a coredump because queue->cmds are not initialized.

This issue is specific to the I/O queue connect where the payload
comes solicited via r2t.

I suggest to document the change log to the following:

nvmet-tcp: Fix NULL dereference when a connect data comes in h2cdata pdu

When handling commands without in-capsule data, we assign the ttag
assuming we already have the queue commands array allocated (based on
the queue size information in the connect data payload).

However if the connect itself did not send the connect data in-capsule
we have yet to allocate the queue commands, and we will assign a bogus
ttag and suffer a NULL dereference when we receive the corresponding
h2cdata pdu.

Fix this by checking if we already allocated commands before
dereferencing it when handling h2cdata, if we didn't, its for sure
a connect and we should use the preallocated connect command.

> Signed-off-by: Ziye Yang <ziye.yang@intel.com>
> ---
>   drivers/nvme/target/tcp.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 9eda91162fe4..9d3eeb9338cc 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -866,7 +866,11 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
>   	struct nvme_tcp_data_pdu *data = &queue->pdu.data;
>   	struct nvmet_tcp_cmd *cmd;
>   
> -	cmd = &queue->cmds[data->ttag];
> +	if (likely(queue->nr_cmds)) {
> +		cmd = &queue->cmds[data->ttag];
> +	} else {
> +		cmd = &queue->connect;
> +	}

No need for brackets on one-liner conditionals.

Also, I think it'd make sense to set the ttag to 0xffff if we hit
this condition, otherwise we are sending a bogus ttag.

Something like:
--
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index dfcbc6522aba..3fec5119ec90 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -159,6 +159,10 @@ static void nvmet_tcp_finish_cmd(struct 
nvmet_tcp_cmd *cmd);
  static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
                 struct nvmet_tcp_cmd *cmd)
  {
+       if (unlikely(cmd == queue->connect)) {
+               /* We didn't allocate cmds yet, send 0xffff */
+               return USHRT_MAX;
+       }
         return cmd - queue->cmds;
  }
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
