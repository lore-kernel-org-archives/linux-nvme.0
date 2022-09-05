Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF82ECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 19:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YkAsFTgHmBSUcqnccHKMVQXt2aTap5h6NkkjSRteSPg=; b=ZxabdY5z+In+ovXoWXTxYN9pUg
	ppIOcvlS53RGpDS5xiLqv7bcx8zgVC8bsj/JJmvtA/O8WqhlmwduzPidNH49n5sGXq/Rnqqb08IqV
	aOOn4kBwWYB8ZExajDbFD1+zaAvAqKaf8k+p3oefwPHar2KYf556C7GfWfBKaT2dyyFitTQc58yHd
	zEJC84EVFVaGafNykRD2VPJBbpYRe5zq4tUlh9nag/NW0XAxROEMC4U0qY6KBGWm+JXLvERxRpMz3
	F7f5VCUDP7VdyUXg5nGXP9xDRIW4zB/Mjh20T+ctTdJnGPkqGVfJnw4D7VkPiywgIJhkDdI/+EFcj
	duBo2q2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVIDM-009mpC-7K; Mon, 05 Sep 2022 19:57:00 +0000
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVEp3-006jpZ-95
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 16:19:42 +0000
Received: by mail-yb1-xb2d.google.com with SMTP id k80so2090928ybk.10
        for <linux-nvme@lists.infradead.org>; Mon, 05 Sep 2022 09:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=YkAsFTgHmBSUcqnccHKMVQXt2aTap5h6NkkjSRteSPg=;
        b=KsutWxkBsfHXak/Xg16AIA750aSQbDXUSdNphO0Kpg1TC+wxPdokTY20Yz/fquw4T0
         W6J3UWsW1j9tcUWdgYWJXD24DWVaH0asxt6dD5+QZZWn8hWyKR7uetf7R4l8uRMxWusJ
         irKQ7eafMqRC/+6iD3ewx7wzcS8UVArL0Yp+j14+p+394JrwCI8+nWbf9gBSs/l3du6m
         8R/dJbTZFYHcL/RP5oemq+NQ+yhBbQLE6/0hd5PASEFTTmjV6wBUr27/QOpKk7+i8h6w
         m6ffxcQM/GHBmAYCYpZqSQo3q88wlRt2IUKn0LTG6VSf+jMTZTswyAPE/+VLzSJBzaX9
         0i4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YkAsFTgHmBSUcqnccHKMVQXt2aTap5h6NkkjSRteSPg=;
        b=BuiLxEt3l3C3Qx9kti5/QKxiXuYFl7XaiZRCUeXpM9y5kvp2JVeKUMgcm7YLkLnQ7N
         GUeiiAPVd2ghHJ9uD0c9A3x1nGTNBd3TfrKMEwK7gLKyZtP2lmI1s2HVr1o2v/FBhe+Z
         rtJjA9fpvdZoqgRi+HHrQAJTG4GrDZrhHcUT+CgkR7O2dOpQcwZ1WAR6KV1jwJlNTpII
         mPIYS7XsMfFGWR/XW1G8X72ELDjInjn3CZv+wkr1kNReOIryA2yMfNSBJknCYSkgOrR7
         4DpuzT8RWq6uCoYTPyeWhAJvm4vmDBjyFdfD20/UgPYOJyUoSZiac4mRw4FhEo02cz9/
         DeqA==
X-Gm-Message-State: ACgBeo0meCKVXR/E1RYz6RLCYkPeIeL+LUSbV/wa51ihaPdSA2H7Hrmb
	u8awXz62xBe/f1D9U3ZRf/o10eKzC4eCBoMoOM6ygQ==
X-Google-Smtp-Source: AA6agR4JHFKV8TOP4g2pTrOsdz4/wHdEpSOlld5iolAoTQ7Z12pbsk/gDLljBh/ZcDpFff7rdPsv1mJrTnyxbgtWmms=
X-Received: by 2002:a05:6902:154b:b0:695:5ae9:a79b with SMTP id
 r11-20020a056902154b00b006955ae9a79bmr33992933ybu.493.1662394778338; Mon, 05
 Sep 2022 09:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220905150706.1529358-1-sagi@grimberg.me>
In-Reply-To: <20220905150706.1529358-1-sagi@grimberg.me>
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Mon, 5 Sep 2022 12:19:02 -0400
Message-ID: <CAHex0crb9CA+x0h8K07=ZReweXH7XFBL7FJRXG80QWvLpO=T8g@mail.gmail.com>
Subject: Re: [PATCH] nvme-tcp: Fix regression that causes sporadic requests to
 time out
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_091941_421504_22594F52 
X-CRM114-Status: GOOD (  27.25  )
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

Thanks, Sagi. I have tested the changes to eliminate queue->more_requests and
confirm that it addresses the bug (1000 runs of the repro scenario executed
without issue).

Tested-by: Jonathan Nicklin <jnicklin@blockbridge.com>

On Mon, Sep 5, 2022 at 11:07 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
> When we queue requests, we strive to batch as much as possible and also
> signal the network stack that more data is about to be sent over a socket
> with MSG_SENDPAGE_NOTLAST. This flag looks at the pending requests queued
> as well as queue->more_requests that is derived from the block layer
> last-in-batch indication.
>
> We set more_request=true when we flush the request directly from .queue_rq
> submission context (in nvme_tcp_send_all), however this is wrongly
> assuming that no other requests may be queued during the execution of
> nvme_tcp_send_all.
>
> Due to this, a race condition may happen where:
> 1. request X is queued as !last-in-batch
> 2. request X submission context calls nvme_tcp_send_all directly
> 3. nvme_tcp_send_all is preempted and schedules to a different cpu
> 4. request Y is queued as last-in-batch
> 5. nvme_tcp_send_all context sends request X+Y, however signals for
> both MSG_SENDPAGE_NOTLAST because queue->more_requests=true.
> ==> none of the requests is pushed down to the wire as the network
> stack is waiting for more data, both requests timeout.
>
> To fix this, we eliminate queue->more_requests and only rely on
> the queue req_list and send_list to be not-empty.
>
> Fixes: 122e5b9f3d37 ("nvme-tcp: optimize network stack with setting msg
> flags according to batch size")
> Reported-by: Jonathan Nicklin <jnicklin@blockbridge.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/tcp.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 54b4e8a7fe42..d5871fd6f769 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -121,7 +121,6 @@ struct nvme_tcp_queue {
>         struct mutex            send_mutex;
>         struct llist_head       req_list;
>         struct list_head        send_list;
> -       bool                    more_requests;
>
>         /* recv state */
>         void                    *pdu;
> @@ -320,7 +319,7 @@ static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
>  static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
>  {
>         return !list_empty(&queue->send_list) ||
> -               !llist_empty(&queue->req_list) || queue->more_requests;
> +               !llist_empty(&queue->req_list);
>  }
>
>  static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
> @@ -339,9 +338,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
>          */
>         if (queue->io_cpu == raw_smp_processor_id() &&
>             sync && empty && mutex_trylock(&queue->send_mutex)) {
> -               queue->more_requests = !last;
>                 nvme_tcp_send_all(queue);
> -               queue->more_requests = false;
>                 mutex_unlock(&queue->send_mutex);
>         }
>
> --
> 2.34.1
>

