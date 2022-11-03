Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC80C433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Nov 2022 20:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iZMDL50DKXKECs/VYUnsxXlD87KLe5GbSkGO2hGHXTY=; b=YyA693pZXfbOHu/RkxqSHyNtwp
	WL6O2iWTheJFrq21zh2wgutQ1kLJn0DJWraXMKML/WOhIF0HnsVzM1M3fDUSJjnPerkUDQ+zJn88s
	CpzVqG1ayIZCctSCm+voQyNApkyVCxhryqu24ShEuFGrhsoaGvr+XNg+tEBzlfpmkbuEHkmNtHD7h
	PPR4ulRfd0H4ZIRjaCSc8OWReeYANaGnf97WAqEFhB7m72/TZtWsJPGdhyM671dzg5Ive6/sdb+eJ
	QphY3FhWdB2d9+v52FeO2yD9+kWGQfiziEWhsqq8glBjty3BC1ikwSQcz/3B14mT8AsyOM0rHpB/x
	zwiN+Pdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqgWx-001aOY-VB; Thu, 03 Nov 2022 20:09:40 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqgPI-001Wwg-4s
	for linux-nvme@lists.infradead.org; Thu, 03 Nov 2022 20:01:47 +0000
Received: by mail-wr1-f41.google.com with SMTP id a14so4340799wru.5
        for <linux-nvme@lists.infradead.org>; Thu, 03 Nov 2022 13:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZMDL50DKXKECs/VYUnsxXlD87KLe5GbSkGO2hGHXTY=;
        b=AATrwC+LmcWY/nQlrQ+RngViFzrUct0iUF9OlYhoZP9huyrU3VY8PgpAHgnSL04Upd
         trICvb7EtrBSx//yt8Q34FQeSb9uxcbDG7xR3uk/+afLRjcT5Zox5jmBVl8rCtvqPoJQ
         c7xKd18ixqkDLOr4yoEBgAhpl49RSoFlpztsG7UnF5LYUG+NmYolwQTvR+lH8B4x9cE4
         yyIl27Xi5opbO+3vXmPyl94QUOBv+BcKNlyDAGl33AxaX2Hx8YsstGn1S1hbpN7kNGa3
         6fcj0Uki3sQTu4VKV8RVgC+ZFpNAx4RrSzwU3U9hC8Gt5pW2ihxkhwgan3wRcS3Ed6El
         Si2Q==
X-Gm-Message-State: ACrzQf2+arPbFgmhT4Gd5fOQTP3zcYVT/GDU25tfv4VcHA0Q7Ny/EtnU
	1DseLkGvUYBQCOGknUG3/Q49owXGbIY=
X-Google-Smtp-Source: AMsMyM53Yvhp1UF41WhHKFoXV6A5agDyDYa5P23aoPnVcnsHZrYDWraslt7wMHt16nC9+FKpGtLCpA==
X-Received: by 2002:adf:e78d:0:b0:236:debd:f681 with SMTP id n13-20020adfe78d000000b00236debdf681mr12178644wrm.17.1667505700355;
        Thu, 03 Nov 2022 13:01:40 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id w11-20020a5d608b000000b002366f9bd717sm2035906wrt.45.2022.11.03.13.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 13:01:39 -0700 (PDT)
Message-ID: <be22e517-50da-03a7-7504-1a592e04803c@grimberg.me>
Date: Thu, 3 Nov 2022 22:01:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/6] nvme-auth: allocate authentication buffer only during
 transaction
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20221102075224.70869-1-hare@suse.de>
 <20221102075224.70869-2-hare@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221102075224.70869-2-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221103_130144_302995_5BF415C8 
X-CRM114-Status: GOOD (  22.99  )
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



On 11/2/22 09:52, Hannes Reinecke wrote:
> The authentication buffer is only used during the authentication
> transaction, so no need to keep it around.

Patch is fine, but why do we need the chap context dynamically
allocated? It is always the number of queues and never ever changes.

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/auth.c | 49 +++++++++++++++++++---------------------
>   1 file changed, 23 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 3b63aa155beb..b68fb2c764f6 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -667,8 +667,6 @@ static void __nvme_auth_reset(struct nvme_dhchap_queue_context *chap)
>   	kfree_sensitive(chap->sess_key);
>   	chap->sess_key = NULL;
>   	chap->sess_key_len = 0;
> -	chap->status = 0;
> -	chap->error = 0;
>   	chap->s1 = 0;
>   	chap->s2 = 0;
>   	chap->transaction = 0;
> @@ -687,7 +685,6 @@ static void __nvme_auth_free(struct nvme_dhchap_queue_context *chap)
>   	kfree_sensitive(chap->host_key);
>   	kfree_sensitive(chap->sess_key);
>   	kfree_sensitive(chap->host_response);
> -	kfree(chap->buf);
>   	kfree(chap);
>   }
>   
> @@ -700,6 +697,19 @@ static void __nvme_auth_work(struct work_struct *work)
>   	int ret = 0;
>   
>   	chap->transaction = ctrl->transaction++;
> +	chap->status = 0;
> +	chap->error = 0;
> +
> +	/*
> +	 * Allocate a large enough buffer for the entire negotiation:
> +	 * 4k should be enough to ffdhe8192.
> +	 */
> +	chap->buf_size = 4096;
> +	chap->buf = kzalloc(chap->buf_size, GFP_KERNEL);
> +	if (!chap->buf) {
> +		chap->error = -ENOMEM;
> +		return;
> +	}
>   
>   	/* DH-HMAC-CHAP Step 1: send negotiate */
>   	dev_dbg(ctrl->device, "%s: qid %d send negotiate\n",
> @@ -707,13 +717,13 @@ static void __nvme_auth_work(struct work_struct *work)
>   	ret = nvme_auth_set_dhchap_negotiate_data(ctrl, chap);
>   	if (ret < 0) {
>   		chap->error = ret;
> -		return;
> +		goto out_free;
>   	}
>   	tl = ret;
>   	ret = nvme_auth_submit(ctrl, chap->qid, chap->buf, tl, true);
>   	if (ret) {
>   		chap->error = ret;
> -		return;
> +		goto out_free;
>   	}
>   
>   	/* DH-HMAC-CHAP Step 2: receive challenge */
> @@ -727,14 +737,14 @@ static void __nvme_auth_work(struct work_struct *work)
>   			 "qid %d failed to receive challenge, %s %d\n",
>   			 chap->qid, ret < 0 ? "error" : "nvme status", ret);
>   		chap->error = ret;
> -		return;
> +		goto out_free;
>   	}
>   	ret = nvme_auth_receive_validate(ctrl, chap->qid, chap->buf, chap->transaction,
>   					 NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE);
>   	if (ret) {
>   		chap->status = ret;
>   		chap->error = NVME_SC_AUTH_REQUIRED;
> -		return;
> +		goto out_free;
>   	}
>   
>   	ret = nvme_auth_process_dhchap_challenge(ctrl, chap);
> @@ -790,7 +800,7 @@ static void __nvme_auth_work(struct work_struct *work)
>   			 "qid %d failed to receive success1, %s %d\n",
>   			 chap->qid, ret < 0 ? "error" : "nvme status", ret);
>   		chap->error = ret;
> -		return;
> +		goto out_free;
>   	}
>   	ret = nvme_auth_receive_validate(ctrl, chap->qid,
>   					 chap->buf, chap->transaction,
> @@ -798,7 +808,7 @@ static void __nvme_auth_work(struct work_struct *work)
>   	if (ret) {
>   		chap->status = ret;
>   		chap->error = NVME_SC_AUTH_REQUIRED;
> -		return;
> +		goto out_free;
>   	}
>   
>   	if (ctrl->ctrl_key) {
> @@ -828,10 +838,7 @@ static void __nvme_auth_work(struct work_struct *work)
>   		if (ret)
>   			chap->error = ret;
>   	}
> -	if (!ret) {
> -		chap->error = 0;
> -		return;
> -	}
> +	goto out_free;
>   
>   fail2:
>   	dev_dbg(ctrl->device, "%s: qid %d send failure2, status %x\n",
> @@ -844,6 +851,9 @@ static void __nvme_auth_work(struct work_struct *work)
>   	 */
>   	if (ret && !chap->error)
>   		chap->error = ret;
> +out_free:
> +	kfree(chap->buf);
> +	chap->buf = NULL;
>   }
>   
>   int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
> @@ -863,7 +873,6 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
>   	mutex_lock(&ctrl->dhchap_auth_mutex);
>   	/* Check if the context is already queued */
>   	list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
> -		WARN_ON(!chap->buf);
>   		if (chap->qid == qid) {
>   			dev_dbg(ctrl->device, "qid %d: re-using context\n", qid);
>   			mutex_unlock(&ctrl->dhchap_auth_mutex);
> @@ -881,18 +890,6 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
>   	chap->qid = (qid == NVME_QID_ANY) ? 0 : qid;
>   	chap->ctrl = ctrl;
>   
> -	/*
> -	 * Allocate a large enough buffer for the entire negotiation:
> -	 * 4k should be enough to ffdhe8192.
> -	 */
> -	chap->buf_size = 4096;
> -	chap->buf = kzalloc(chap->buf_size, GFP_KERNEL);
> -	if (!chap->buf) {
> -		mutex_unlock(&ctrl->dhchap_auth_mutex);
> -		kfree(chap);
> -		return -ENOMEM;
> -	}
> -
>   	INIT_WORK(&chap->auth_work, __nvme_auth_work);
>   	list_add(&chap->entry, &ctrl->dhchap_auth_list);
>   	mutex_unlock(&ctrl->dhchap_auth_mutex);

