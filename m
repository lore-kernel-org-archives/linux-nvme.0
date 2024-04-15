Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05A6C4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Apr 2024 20:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mCI08UxRqRdgLWPnXTXShrMmNNIATJiipTj4VitlO2E=; b=440SUCFrpfldjvtap8DOK+WQCP
	vwzr97Qi4sN7rn9CXXKVAJ7qC96RBZPKlgbXIRPtsK+NHgCLvKw05HkohuUcuTIJlqE+vpZKaRipi
	ceE6jJm1YgC9DSv+/hNjxpMheAXoh2IAxwMKvFXd2NEyNZF+7JuRheMV1hHJdVftY0scoeLAQjC26
	LYDY0TeBCs/tNJDs5Oh7SVM6gYa1V3gPE9FR6oDKgCbG4yhCGdMpHgWGvibV8xQfArRI2+RTOQGLP
	wfr913etv8ZJoiwzHWrwRVsddHJL4e/HrJN6TZSGlITC3OIQnF9pW5I5i16TWqgq/kK+BwQcxdBUx
	AWXd6fhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwTIU-00000009szO-3waj;
	Mon, 15 Apr 2024 20:51:26 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwTIS-00000009syq-05RY
	for linux-nvme@lists.infradead.org;
	Mon, 15 Apr 2024 20:51:25 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34560201517so855494f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 15 Apr 2024 13:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713214281; x=1713819081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCI08UxRqRdgLWPnXTXShrMmNNIATJiipTj4VitlO2E=;
        b=gKlYo76Zek4tPj1iT0aGmOAAY0hcpAn3KOLK8ccwuRxu7RMfIy6CWtjG3gxRUKD9UR
         Udcb9krPqawsx9wQEsxfURFVQY4eS7DSTS2KIGX75SrJ06Ho+L8KS11ObpFHxm80gDBM
         UeIVF9TkL0C9OTdEF7BcMUXcxJqFjGdTL9HIoGMAbpiCyy/95ZIzsIXil9OnERIydqlo
         NshEUJ/bvCjTvBHf/2xGthQKS4TLxEvQRg4NkUzG4MGi8dd2np5qudq1tMNGJOlWLZup
         QHBg+5mqbrMnsGdafM6Gdhv26SIzmmVQdsQec4IHisIae0unASS1UXVmkbpqF0pYV2uj
         POAA==
X-Forwarded-Encrypted: i=1; AJvYcCWtDQigzNOBtjy4+Ny3AcOWvWWfH35Hyg5R3cqxOcLZBm2Tx58SGwzHqIEmL+3PKI0U0VJjfITDZM4n3TcsD2qRmszA4abUPlSA+eqp1h4=
X-Gm-Message-State: AOJu0YzIDgymkaZ9ZvDxcj1KCq3FgsV/rtUagup+lRrGNY1Pe5RwfjjP
	vd4MRCs6kahSp1Gg2L5Cy2TIqJT97egypmQgFziabDCkBv8mBnJ/
X-Google-Smtp-Source: AGHT+IFp2XnntHk5/TpHOO8CICGNW8DAnwJCnDWmkKC+18C1Zh/Yf7xngo58Dk9V63seawpyjxLA9A==
X-Received: by 2002:a5d:598c:0:b0:346:408d:4341 with SMTP id n12-20020a5d598c000000b00346408d4341mr8556311wri.1.1713214280910;
        Mon, 15 Apr 2024 13:51:20 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id g9-20020a5d5409000000b00343dc6a0019sm12943563wrv.68.2024.04.15.13.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 13:51:20 -0700 (PDT)
Message-ID: <51fc1a3f-7166-49cf-9652-a95bdc5d2119@grimberg.me>
Date: Mon, 15 Apr 2024 23:51:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] nvme-fabrics: handle transient auth failures
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240415124220.5433-1-dwagner@suse.de>
 <20240415124220.5433-6-dwagner@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240415124220.5433-6-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_135124_085583_3D497699 
X-CRM114-Status: GOOD (  23.00  )
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



On 15/04/2024 15:42, Daniel Wagner wrote:
> Retry authentication a couple of times to avoid error out on transient
> errors. E.g. if a new key is deployed on the host and the target. At the
> same time the connection drops. The host might use the wrong key to
> reconnect.
>
> Suggested-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/auth.c    |  4 ++--
>   drivers/nvme/host/fabrics.c | 10 +++++++++-
>   drivers/nvme/host/fc.c      |  2 ++
>   drivers/nvme/host/nvme.h    |  1 +
>   drivers/nvme/host/rdma.c    |  1 +
>   drivers/nvme/host/tcp.c     |  1 +
>   6 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index a264b3ae078b..368dcc6ee11b 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -797,7 +797,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
>   					 NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1);
>   	if (ret) {
>   		chap->status = ret;
> -		chap->error = -ECONNREFUSED;
> +		chap->error = -EKEYREJECTED;
>   		return;
>   	}
>   
> @@ -818,7 +818,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
>   	ret = nvme_auth_process_dhchap_success1(ctrl, chap);
>   	if (ret) {
>   		/* Controller authentication failed */
> -		chap->error = -ECONNREFUSED;
> +		chap->error = -EKEYREJECTED;
>   		goto fail2;
>   	}
>   
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index d9a73b1b41c4..6dfa45dce232 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -573,8 +573,16 @@ EXPORT_SYMBOL_GPL(nvmf_connect_io_queue);
>    */
>   bool nvmf_should_reconnect(struct nvme_ctrl *ctrl, int status)
>   {
> -	if (status < 0)
> +	if (status < 0) {
> +		/*
> +		 * authentication errors can be transient, thus retry a couple
> +		 * of times before giving up.
> +		 */
> +		if (status == -EKEYREJECTED &&
> +		    ++ctrl->nr_auth_retries < 3)
> +			return true;

I did not suggest nr_auth_retries. Where is the 3 coming from? The 
controller already
has a number of reconnects before it gives up, no reason to add another one.

Just don't return false based on the status if it is a transient 
authentication error.

The patch just needs to be modified from:
     if (status < 0)
to
     if (status < 0 && status != -EKEYREJECTED Plus a comment that 
explains it.

