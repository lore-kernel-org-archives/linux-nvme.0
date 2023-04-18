Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53297C77B75
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 16:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uO0+ihe7m98naK1dK4KksZllWVBHBIkXTey/yLHUHAc=; b=25Q9nHmb2BIKP6f03vwfD/QG4q
	fNNvCSv4LEzM1Gl/SJbMYq/WzbW8RHsSZBXzGx1P2vG5DEp8oyC6p/z5LdAqu7XkRcIN0jbBasUsf
	mDBDkfiIPlm158rAEYwBNr/cxUCnqZ3q5PVeoDT9+fvWmQlA5H+/p/6KMhIGGUB3sDbj/HeZd0m5M
	Uu4g6x+fqcnZogniUrCQ1PCZdSARynlQWl45Cigv4tkODOGxINgNSLjOcAW52RgJVqoRjCd98utze
	xRQ24rAhbS4/WqE/6XogODk5vJKeOpzqdyIHSxAksvgSPMe2Jg9z3QGa1S8snc29R3Y5paqT3m3ci
	sIYRuYUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ponnr-002i9C-03;
	Tue, 18 Apr 2023 16:03:35 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ponnn-002i8H-15
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 16:03:32 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3f05f61adbeso9967305e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 18 Apr 2023 09:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681833805; x=1684425805;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uO0+ihe7m98naK1dK4KksZllWVBHBIkXTey/yLHUHAc=;
        b=Pfa/45qVkNlWyp7fXzzd3xxGk4jlcwRVsVK7MmAVIS68udGhVHYg2PQRrWF3fOWsjy
         7IBn0MdPN9/jESn/VhtOGRWGzMuQhH+JBnadz6+1qEQPyYlboMdo2q22/UMZoBJOq/0C
         TNKydeK72YgUFEYpRtfyjnE3cEE/qzOllPS9s+SE8BrNYqPbPNxwGL/ni7OYEh9a4t+j
         TceIqZd+LMhE3KF/Jmvly6jCM0nJL6CrrtWw9szYSG7cSwv5funw1djIONXoNRTRIRCT
         SaDSJyxNWEd/3SHYJAFqxP3oSk9y/LK8F6L7h/9FYpIVBUwY9eO1SM5uoDEdltlq7rmy
         mkmw==
X-Gm-Message-State: AAQBX9dR1jhIRn6djA5o8tzRL5kk2RdgLBn5XnDKRhnZFxFejogwLarM
	15200zqk8kUaoWxkWJXYWUc=
X-Google-Smtp-Source: AKy350b5chqkWPW/OA32r0RFKB8VTFppTU8dP/hVdfu4dfiT/MtTFp2YYNvwVK4YMmq3M1sQ4Hzrjw==
X-Received: by 2002:a05:600c:1c0a:b0:3f0:5a8c:fee4 with SMTP id j10-20020a05600c1c0a00b003f05a8cfee4mr11445430wms.4.1681833804307;
        Tue, 18 Apr 2023 09:03:24 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id bg20-20020a05600c3c9400b003ee9c8cc631sm19266293wmb.23.2023.04.18.09.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 09:03:23 -0700 (PDT)
Message-ID: <c6fbc05f-5e53-2ce5-5a33-5bb0d23e4f41@grimberg.me>
Date: Tue, 18 Apr 2023 19:03:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/3] nvme: double KA polling frequency to avoid KATO with
 TBKAS on
Content-Language: en-US
To: Uday Shankar <ushankar@purestorage.com>,
 Costa Sapuntzakis <costa@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@fb.com>
Cc: linux-nvme@lists.infradead.org
References: <20230417225558.2890062-1-ushankar@purestorage.com>
 <20230417225558.2890062-2-ushankar@purestorage.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230417225558.2890062-2-ushankar@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_090331_378569_0B88812B 
X-CRM114-Status: GOOD (  23.17  )
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


> With TBKAS on, the completion of one command can defer sending a
> keep alive for up to twice the delay between successive runs of
> nvme_keep_alive_work. The current delay of KATO / 2 thus makes it
> possible for one command to defer sending a keep alive for up to
> KATO, which can result in the controller detecting a KATO. The following
> trace demonstrates the issue, taking KATO = 8 for simplicity:
> 
> 1. t = 0: run nvme_keep_alive_work, no keep-alive sent
> 2. t = ε: I/O completion seen, set comp_seen = true
> 3. t = 4: run nvme_keep_alive_work, see comp_seen == true,
>            skip sending keep-alive, set comp_seen = false
> 4. t = 8: run nvme_keep_alive_work, see comp_seen == false,
>            send a keep-alive command.
> 
> Here, there is a delay of 8 - ε between receiving a command completion
> and sending the next command. With ε small, the controller is likely to
> detect a keep alive timeout.
> 
> Fix this by running nvme_keep_alive_work with a delay of KATO / 4
> whenever TBKAS is on. Going through the above trace now gives us a
> worst-case delay of 4 - ε, which is in line with the recommendation of
> sending a command every KATO / 2 in the NVMe specification.
> 
> Reported-by: Costa Sapuntzakis <costa@purestorage.com>
> Reported-by: Randy Jennings <randyj@purestorage.com>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/core.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 6c1e7d6709e0..1298c7b9bffb 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1150,10 +1150,16 @@ EXPORT_SYMBOL_NS_GPL(nvme_passthru_end, NVME_TARGET_PASSTHRU);
>    *
>    *   The host should send Keep Alive commands at half of the Keep Alive Timeout
>    *   accounting for transport roundtrip times [..].
> + *
> + * When TBKAS is on, we need to run nvme_keep_alive_work at twice this
> + * frequency, as one command completion can postpone sending a keep alive
> + * command by up to twice the delay between runs.
>    */
>   static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
>   {
> -	queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ / 2);
> +	unsigned long delay = (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) ?
> +		ctrl->kato * HZ / 4 : ctrl->kato * HZ / 2;
> +	queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
>   }
>   
>   static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,

This looks fine to me, the only thing that is a bit concerning is that
we may excessively send keep-alive too frequently (default kato is 10
divide by 4 gives every 2 seconds).

