Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094D9C2FC0E
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 08:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ahNsNqh7rZTOkYwrKcGyDiTGNMLjVSvTqLMcB7iy7qA=; b=4nYNGFkx3k36/A/mUra1f1ncH2
	gES/SlmkPxVvKuxf2BUYbtQeHXzRsVYmOMti6SNxC37og7VnsHGwnuproPqZp6T6RqI1MufhYUtXc
	A3ZosNaAKhY5fcQaxX5IJe/RnerJZDQaz/dNodHSlMJL1xMAFJCN0jZ0gBp1p8oV4Yv7IVAKUVDUN
	nWQldMc6kvI6edyMXHoTxjzZw09OmnG7lMRsDXTpBA0M8DZQ7MO9C6Jvv/jCH6lAz24ulibYvmJIj
	bTtDt+ZVAT6zcXnhlmaUjM92jCq7hR8IAj7ec901TiFFxcfHW4ExN3L756vuWwbWhC0HguYKQXXyL
	ub6SdPSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWYlv-005sE8-0B;
	Thu, 17 Aug 2023 08:54:27 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWYls-005sDW-0R
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 08:54:25 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3174ca258bbso1568870f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 17 Aug 2023 01:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262462; x=1692867262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahNsNqh7rZTOkYwrKcGyDiTGNMLjVSvTqLMcB7iy7qA=;
        b=N9PUPuEnXAxMHjHltrV1z8CM+9/n7H1hcV0avjEX0fp+DeCahiu3nFH7wFtqndS5o7
         dD+HwoBoazTKtVC1UNfGM4WDXUK59LAkEYG+nxRrUb1zT7AUC0XXKRURw8Qzxq+2LdpY
         t6yrOInMFrT59+i5Ue8v6zKXKcXdLk1DKkyu1mvj5j0Ou8xkjbuqBbgNyfwGNTK7gkrZ
         sLMmQ2QDcS+4UApzrQULYCH7Do7tOvNaywJc1yMxPWYse0n10o/Tk84z1DPYSlRzp7Wb
         IO8cuS1KlonO8vzPpA1H/bP4+WeWB1X1GeAib8bqyHKF8QLKvfDKre9+qYUeceSPUZJe
         AIhw==
X-Gm-Message-State: AOJu0Yw+DBFi0q3cnUeQys1/6qzIFJyijry2mO92PnZMXNgtQ8S4k9na
	39htEJhzBDez/WgddkeACDDds22aqs0=
X-Google-Smtp-Source: AGHT+IGb24YMGPlSLfHrvnppPGhZLQOQlIZcrpCQcAaKlYV+KjniexzlO2HjOgqsH8YF+K+JPZiAZw==
X-Received: by 2002:a5d:43c5:0:b0:319:6ce2:e5a2 with SMTP id v5-20020a5d43c5000000b003196ce2e5a2mr3300876wrr.4.1692262462094;
        Thu, 17 Aug 2023 01:54:22 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id w17-20020adfee51000000b00317eee26bf0sm24084107wro.69.2023.08.17.01.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 01:54:21 -0700 (PDT)
Message-ID: <05b7479a-5243-00fb-4a5a-a063bce65378@grimberg.me>
Date: Thu, 17 Aug 2023 11:54:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] nvmet-tcp: avoid circular locking dependency on
 install_queue()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230810132006.129365-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230810132006.129365-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_015424_195327_CB176550 
X-CRM114-Status: GOOD (  23.59  )
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



On 8/10/23 16:20, Hannes Reinecke wrote:
> nvmet_tcp_install_queue() is driven from the ->io_work workqueue
> function, but will call flush_workqueue() which might trigger
> ->release_work() which in itself calls flush_work on ->io_work.
> 
> To avoid that check for pending queue in disconnecting status,
> and return 'controller busy' until all disconnects are completed.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/tcp.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index f131b504aa01..97d07488072d 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1845,8 +1845,18 @@ static u16 nvmet_tcp_install_queue(struct nvmet_sq *sq)
>   		container_of(sq, struct nvmet_tcp_queue, nvme_sq);
>   
>   	if (sq->qid == 0) {
> -		/* Let inflight controller teardown complete */
> -		flush_workqueue(nvmet_wq);
> +		struct nvmet_tcp_queue *q;
> +		int pending = 0;
> +
> +		mutex_lock(&nvmet_tcp_queue_mutex);
> +		list_for_each_entry(q, &nvmet_tcp_queue_list, queue_list) {
> +			if (q->state == NVMET_TCP_Q_DISCONNECTING)
> +				pending++;
> +		}
> +		mutex_unlock(&nvmet_tcp_queue_mutex);
> +		/* Retry for pending controller teardown */
> +		if (pending)
> +			return NVME_SC_CONNECT_CTRL_BUSY;

Overall I'm fine with the approach.

That will most likely be the case for a controller reset or a "reset
storm". Maybe it is better to keep it at some reasonably allowed pending
to say 10 or something... The whole point is to not let the removals
accumulate and continue creating new ones...

Can you please test this with a host that does a loop like:
while true; do nvme reset /dev/nvme0; done

And let it run for some time...
Or even better create a test that does this for 100 iterations
or a log/short variants of this?

The same would be needed by nvmet-rdma btw.

