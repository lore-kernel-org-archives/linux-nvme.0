Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194F4C2B9F8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 16:16:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B13611C2
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 16:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B13611C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lbymMh3L6WwzCjGoZiGEcH0YF6xyo2ZJCRPtqUYgZpw=; b=gIssvexsBZvXNFVE2g04+njRrT
	Scn1tYjmd89ls7t764YC29zqLHSgddNQ0qkndzElN8oYb7Jxu4wRV5NOtWxcqzRtkHZZzNpJncjc9
	68x8iyBTXrYgjn4nP5z5O6rBiztmf9mfHIdCcwxpUex+Nz4g0RptI/niS6hBlaGpwURHChDgpuD9V
	l44mcEtT+VynffdjRsQHyCBuWEkekPvYwTKkzeaG76EFc2N1cVtm9SAxNoRy0bR/LENtw3ig632ty
	/UIMR2C8XJtP21hO5G86KQ0QTicQeDb6lEv1WJCL8NUydl67Ndf4n1yHC0i4CoeABQ/aNhfx2t0Bx
	99NXclZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llZiy-006KjK-1M; Tue, 25 May 2021 16:16:08 +0000
Received: from mail-pj1-f50.google.com ([209.85.216.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llZLx-006ABS-Sx
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 15:52:23 +0000
Received: by mail-pj1-f50.google.com with SMTP id
 o17-20020a17090a9f91b029015cef5b3c50so13492763pjp.4
 for <linux-nvme@lists.infradead.org>; Tue, 25 May 2021 08:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5ItRgpzV0l9pFDmUtM0CNC6wpwRFNt6X+OY+EhIV7f4=;
 b=pL62gtR7/S6y8lK2GUg8+znN2txRrlx8vTlNfyAOLf1gwCrryXaM6XetaFiFqhIXyL
 y3Okz3WwwCJHDD+XiRen+J7Ow1XkWbcHL4gm6Y1LKBksPpvv4/mbkGOad8s0k9rxCIex
 Oh1U4jNX7GmgWnjmcZYQTDlvTFZLut2fZUvU0muB/2LbrTgLvcxKo0+v+/YaLq2UdPBd
 ES4VlIpkxYHS7NTQBFhS/uFYTc+DXQa7s5DuX/QVEwJUCwEcFGRNMtjAwRcoUqgbxGbv
 ERfhnybec3otD6HfWHLonXMus4UvjikksbM2GtK8cOEw4N3xOp4xvHJniLxXuBLhCgyE
 +BFQ==
X-Gm-Message-State: AOAM533hY1HwGlACahjCp5+9Zeb1iJnrT7RQgPidifO9RBZArGcMy/G5
 tUwNqZOWevb6ySPGRopyIL2F++fTKhY=
X-Google-Smtp-Source: ABdhPJwUE12sfDxIidvzi0KplrCT8iOQS3LcSmgl/sCPuIs2CczwHteOXDRBSZzb9+glgb1Z9s+fdA==
X-Received: by 2002:a17:902:c213:b029:f0:bbdf:3852 with SMTP id
 19-20020a170902c213b02900f0bbdf3852mr31269625pll.56.1621957937887; 
 Tue, 25 May 2021 08:52:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4f6:7b8c:d4a2:7714?
 ([2601:647:4802:9070:4f6:7b8c:d4a2:7714])
 by smtp.gmail.com with ESMTPSA id bt4sm12648180pjb.53.2021.05.25.08.52.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 May 2021 08:52:17 -0700 (PDT)
Subject: Re: [PATCH] nvmet-tcp: fix memory leak when having inflight commands
 on disconnect
To: elad.grupi@dell.com, linux-nvme@lists.infradead.org
References: <20210524112441.27400-1-elad.grupi@dell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <18b904e0-dd8b-df6a-feca-bd621b855fd6@grimberg.me>
Date: Tue, 25 May 2021 08:52:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210524112441.27400-1-elad.grupi@dell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_085221_987729_ADCBB717 
X-CRM114-Status: GOOD (  15.77  )
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


> +static void nvmet_tcp_free_resp_list(struct nvmet_tcp_queue *queue)
> +{
> +	struct list_head *p;
> +	struct nvmet_tcp_cmd *cmd;
> +	int c = 0;
> +
> +	nvmet_tcp_process_resp_list(queue);
> +
> +	list_for_each(p, &queue->resp_send_list) {
> +		cmd = list_entry(p, struct nvmet_tcp_cmd, entry);
> +		kfree(cmd->iov);

PDUs need to be unmapped as well in case of writes. That is not
handled in nvmet_tcp_uninit_data_in_cmds ? Or is it just reads (data-out
commands)?

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
> @@ -1441,6 +1468,7 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
>   	nvmet_tcp_uninit_data_in_cmds(queue);
>   	nvmet_sq_destroy(&queue->nvme_sq);
>   	cancel_work_sync(&queue->io_work);
> +	nvmet_tcp_free_resp_list(queue);
>   	sock_release(queue->sock);
>   	nvmet_tcp_free_cmds(queue);
>   	if (queue->hdr_digest || queue->data_digest)
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
