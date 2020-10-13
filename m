Return-Path: <SRS0=D3oK=DU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25212C433E7
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2020 22:19:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CEA0218AC
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2020 22:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SzjU82hW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEA0218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZiehLlmYUG8AtDFF2D//Vb0aLfBk7lehjTuCU7CnwBc=; b=SzjU82hWh21OXUce99j2XWqob
	YW9ZzMqCHs7oOVhCLAhxaneKuw+Spi0d9xtNhGrfw0NMTiQTRmSpR0BqsaI2MV1N7lKK1OD2M3xhZ
	B93+EtYO4Spo7evNhB5vi0dOpk6ioMtLxz7OqweldKu2NGm/6EK2Qlp6Gq9B1WRG1pc8AXKzAG3Ij
	/6qCnIFohnbfFwwUhicCfZFVl+/4cKSFjGV4VnqauD85a+HZqrilD0a7sUe9udcoHozVhmQL4OEF0
	lLfa/tA+jsvMbwvb5zwYCEq/c5OmkZ+dvQigLxtlKf7yHHxZqm2bVfIf+eGQjnqr/01u8N6PkqzRQ
	L6rgCzrng==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSSdK-0001Md-MP; Tue, 13 Oct 2020 22:19:02 +0000
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSSdF-0001M3-7c
 for linux-nvme@lists.infradead.org; Tue, 13 Oct 2020 22:18:59 +0000
Received: by mail-pg1-f193.google.com with SMTP id b193so618012pga.6
 for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2020 15:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5J+JqftU6ifZN1KxMsrqREjbvuZkrZjLOw71HrhLGPI=;
 b=h6DWdPwh9Joo1KzktF6Wxh6bmdo/L6yoAfPmqY90Ecej+Q/D2RWM5weVgP+vRiH4w3
 KOaVgLAM5fKod6Z3Ei6iqgKfQrfYa1MtWMKpQ9ZBKJB7xfU1wCCHgic7DkOR6GQx3ua4
 taRjgh3OiGom2ajgvs8FxqdLA+Fyg67Xc6+eUb0i0/HmWCtDoTsBK2oaYJqaniPuQVII
 9zjkxTElIJ7okdpxZ3igniGjiABa7I/ZivYIH2KEdc/TboWAAQAOTVPtvN/mJBWnxUhq
 q9y5BIZJq08UiiAs09MMgPbvr7QTqmE2LBMynobr7Zk1i0N2F3TSjKBw4uO3QNElF357
 lJzg==
X-Gm-Message-State: AOAM532uXIjGTVX5Of+aSHdVULR612MDOB66iUfJEU61g0vnoXVYWnAH
 k/e5as74JeoC0sC0Ej/v6Os=
X-Google-Smtp-Source: ABdhPJyjCBM/sNIokxxhfFLnmFg5c8GYQ3dccLlv3pIx6CMJOE3U7NqVRRJ//ztXhobI6kFL/uEbqA==
X-Received: by 2002:a63:4854:: with SMTP id x20mr1420189pgk.220.1602627534298; 
 Tue, 13 Oct 2020 15:18:54 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5a09:2d7:19f0:1ee0?
 ([2601:647:4802:9070:5a09:2d7:19f0:1ee0])
 by smtp.gmail.com with ESMTPSA id o78sm693871pfd.105.2020.10.13.15.18.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 15:18:52 -0700 (PDT)
Subject: Re: [PATCH] nvmet: fix uninitialized work for zero kato
To: zhenwei pi <pizhenwei@bytedance.com>, hch@lst.de,
 chaitanya.kulkarni@wdc.com
References: <20201013035233.923889-1-pizhenwei@bytedance.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a75e067a-d0ea-8402-b883-cedd36bb7cf7@grimberg.me>
Date: Tue, 13 Oct 2020 15:18:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201013035233.923889-1-pizhenwei@bytedance.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201013_181857_281447_3A333FE3 
X-CRM114-Status: GOOD (  27.28  )
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> Hit a warning:
> WARNING: CPU: 1 PID: 241 at kernel/workqueue.c:1627 __queue_delayed_work+0x6d/0x90
> with trace:
>    mod_delayed_work_on+0x59/0x90
>    nvmet_update_cc+0xee/0x100 [nvmet]
>    nvmet_execute_prop_set+0x72/0x80 [nvmet]
>    nvmet_tcp_try_recv_pdu+0x2f7/0x770 [nvmet_tcp]
>    nvmet_tcp_io_work+0x63f/0xb2d [nvmet_tcp]
>    ...
> 
> This could be reproduced easily with a keep alive time 0:
> nvme connect -t tcp -n NQN -a ADDR -s PORT --keep-alive-tmo=0
> 
> The reason is:
> Starting an uninitialized work when initiator connects with zero
> kato. Althrough keep-alive timer is disabled during allocating a ctrl
> (fix in 0d3b6a8d213a), ka_work still has a chance to run
> (called by nvmet_start_ctrl to detect dead host).

This should have a "Fixes:" tag.

> 
> Initilize ka_work during allocating ctrl, and set a reasonable kato
> before scheduling ka_work.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/nvme/target/core.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index b7b63330b5ef..3c5b2b065476 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -19,6 +19,8 @@ struct workqueue_struct *buffered_io_wq;
>   static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
>   static DEFINE_IDA(cntlid_ida);
>   
> +#define NVMET_DEFAULT_KATO	5
> +
>   /*
>    * This read/write semaphore is used to synchronize access to configuration
>    * information on a target system that will result in discovery log page
> @@ -385,6 +387,11 @@ static void nvmet_keep_alive_timer(struct work_struct *work)
>   	if (cmd_seen) {
>   		pr_debug("ctrl %d reschedule traffic based keep-alive timer\n",
>   			ctrl->cntlid);
> +
> +		/* run once, trigger from nvmet_start_ctrl to detect dead link */
> +		if (!ctrl->kato)
> +			return;
> +
>   		schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);

It will be better to just schedule/mod the ka_work if kato != 0, other
changes in the patch aren't needed IMO.

>   		return;
>   	}
> @@ -403,15 +410,11 @@ static void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
>   	pr_debug("ctrl %d start keep-alive timer for %d secs\n",
>   		ctrl->cntlid, ctrl->kato);
>   
> -	INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer);
>   	schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
>   }
>   
>   static void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
>   {
> -	if (unlikely(ctrl->kato == 0))
> -		return;
> -
>   	pr_debug("ctrl %d stop keep-alive\n", ctrl->cntlid);
>   
>   	cancel_delayed_work_sync(&ctrl->ka_work);
> @@ -1107,6 +1110,8 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
>   
>   static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
>   {
> +	u32 kato = ctrl->kato ? ctrl->kato : NVMET_DEFAULT_KATO;
> +

The controller shouldn't have a default value, it should receive
the desired value from the host.

>   	lockdep_assert_held(&ctrl->lock);
>   
>   	if (nvmet_cc_iosqes(ctrl->cc) != NVME_NVM_IOSQES ||
> @@ -1126,7 +1131,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
>   	 * in case a host died before it enabled the controller.  Hence, simply
>   	 * reset the keep alive timer when the controller is enabled.
>   	 */
> -	mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
> +	mod_delayed_work(system_wq, &ctrl->ka_work, kato * HZ);
>   }
>   
>   static void nvmet_clear_ctrl(struct nvmet_ctrl *ctrl)
> @@ -1378,6 +1383,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
>   
>   	/* keep-alive timeout in seconds */
>   	ctrl->kato = DIV_ROUND_UP(kato, 1000);
> +	INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer);
>   
>   	ctrl->err_counter = 0;
>   	spin_lock_init(&ctrl->error_lock);
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
