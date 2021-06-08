Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C264BC47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 23:46:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7959360FF2
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 23:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7959360FF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cHQQJD5N9raWgED+Zyv/s3RWPIFy+ZEzlEaJgTYr87Q=; b=ij8m0UgpWoL7t63cyk22KCxZyb
	e/KNnliKJXCNqq+y/77HOzvavkWOBFFagcBvB5m/+mcnfz6dkMJOy1OhFVljRQEPy3qHNASd8WnDW
	Zp9epGHLn9WP3BjZzVeUAgwXbKKB5jctBxonF3Sucj/60gnHD+VAPI8NOgrwsfN5H9XGe9grxJ626
	x8vK3bg7laP5Idcb1wDW8qsw4lKVukyQJOclFGt7OZMw6ndZeZKlMMDaD62Wxp89F9ebXRQpRr0OQ
	QOfFbfaAgUKiE7byxkZmhbm386KYs9aFy9Kpl8tBnrWApqK/AVOTHVDnqIcDVVBXWg8D72F3uMghE
	zHbo8YCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqlQR-00AmCB-D4; Tue, 08 Jun 2021 23:46:27 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqlQO-00AmBd-Jc
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 23:46:25 +0000
Received: by mail-wr1-f47.google.com with SMTP id y7so18708021wrh.7
 for <linux-nvme@lists.infradead.org>; Tue, 08 Jun 2021 16:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EYb05XKlFu6xGcxADa6yps1pgReyUz5ovez6/7l6yZM=;
 b=hXCFiSqZ8EqhQ6tj6HDQl4aHSrkU9Pnp5GKUGFX21EQX96MZyqGMoF4itT8SzXaiU6
 1EJ+Uj1tiOaFu815Z5fyN6jflYea8DDwuPWKlVIEc142ps79HnrDrzwS9gfNiTGyRIwH
 xg1sClg00DXYAR7k8c3Nc0fDcdV51vtQ0QkfAqDUWo+8G3z0ulvdh4pc/zkA82innSa9
 4ZHANcxjInbW3xqV72NZM2EKbxIqn87Hm6NyGMBNcuViy0Cyqmq5gOsqHnLnQqvuuSur
 kHui11DVCnkZDVKAhVp75DZp0qDseqxlfzkbBTgn9c2TjfzY6PgqiywrW/6F+E6IF0U6
 Ei4A==
X-Gm-Message-State: AOAM532D3G/FL+YrYz+Btv8h62qDy89epCtB+vLWBcrb7dmDAH0amse6
 vGg+MUtLO11AC5Y/ZlHOBP3IqGhFWvY=
X-Google-Smtp-Source: ABdhPJwBb6ADFz1GCZ3N2YJbxi8P6JooirEgxV9GKZ5u0AI2hyrH6CyFl/gX35v4KlMu5ttqinDXhA==
X-Received: by 2002:adf:a193:: with SMTP id u19mr25451820wru.9.1623195982915; 
 Tue, 08 Jun 2021 16:46:22 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:12a9:2416:ca98:264f?
 ([2601:647:4802:9070:12a9:2416:ca98:264f])
 by smtp.gmail.com with ESMTPSA id p5sm22359486wrd.25.2021.06.08.16.46.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jun 2021 16:46:22 -0700 (PDT)
Subject: Re: [PATCH] nvmet-tcp: fix memory leak when having inflight commands
 on disconnect
To: elad.grupi@dell.com, linux-nvme@lists.infradead.org
References: <20210601160234.5200-1-elad.grupi@dell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e1170f50-dc26-4eee-87cc-dff2e3690f2d@grimberg.me>
Date: Tue, 8 Jun 2021 16:46:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210601160234.5200-1-elad.grupi@dell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_164624_683827_414AA485 
X-CRM114-Status: GOOD (  21.15  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> From: Elad Grupi <elad.grupi@dell.com>
> 
> Some nvme commands might get completed during the execution of
> nvmet_tcp_release_queue_work. Those commands are being added to
> resp_list on the queue and never processed after cancel_work_sync
> is done, causing memory leak of the resources allocated for those commands.
> 
> Signed-off-by: Elad Grupi <elad.grupi@dell.com>
> ---
>   drivers/nvme/target/tcp.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index f9f34f6caf5e..04d53b532ae2 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1426,6 +1426,31 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
>   	}
>   }
>   
> +static void nvmet_tcp_free_resp_list(struct nvmet_tcp_queue *queue)
> +{
> +	struct nvmet_tcp_cmd *cmd;
> +	int c = 0;
> +
> +	nvmet_tcp_process_resp_list(queue);
> +
> +	list_for_each_entry(cmd, &queue->resp_send_list, entry) {
> +		kfree(cmd->iov);
> +		sgl_free(cmd->req.sg);
> +		c++;
> +	}
> +
> +	WARN_ON(c != queue->send_list_len);
> +
> +	if (queue->snd_cmd) {
> +		kfree(queue->snd_cmd->iov);
> +		sgl_free(queue->snd_cmd->req.sg);
> +		c++;
> +	}
> +
> +	pr_debug("qid %u send_list_len %d, free %d unprocessed commands\n",
> +			queue->nvme_sq.qid, queue->send_list_len, c);
> +}
> +
>   static void nvmet_tcp_release_queue_work(struct work_struct *w)
>   {
>   	struct nvmet_tcp_queue *queue =
> @@ -1441,6 +1466,7 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
>   	nvmet_tcp_uninit_data_in_cmds(queue);
>   	nvmet_sq_destroy(&queue->nvme_sq);
>   	cancel_work_sync(&queue->io_work);
> +	nvmet_tcp_free_resp_list(queue);

Can't this be combined with nvme_tcp_free_cmds? Maybe consolidate
the sgl and iov free to something like nvme_tcp_free_cmd_data that
will free these and make it null-free-safe?

>   	sock_release(queue->sock);
>   	nvmet_tcp_free_cmds(queue);
>   	if (queue->hdr_digest || queue->data_digest)
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
