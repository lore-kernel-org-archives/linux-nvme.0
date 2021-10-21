Return-Path: <SRS0=gxeb=PJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51924C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Oct 2021 14:57:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14CA2610EA
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Oct 2021 14:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 14CA2610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xrYbF/MkWlwZZrwhAXfwpczK1nBeqtmJ3jzEBywP9SA=; b=1ztUdX2ijiNVaMcUF83bX6Cgc6
	6/poNURsK9q/Ch6p48Qkqj2gd+wUwzQPB1+20Rjaj9xQYfo+e92Z3gCadtcmRkrRhmnaRJZex7qs3
	FNNuYUYlh2Bm0Hfg8ocTDWfMJ/RSZoaV9bUfsBms4DyDvDGxvR+lvNDTAMAsQzaVWpB0Sem6neRX+
	fTs63shy2AP7AGOuMI1W7r5/oajKhACE081AKivpimbUMUavfihFtWHBoZMVWH0CrnlXibW50sifd
	cmym9uNOM5oMEK9jimTqqqzMZ05Bp3infoBxfGV9d31z+SBdjojFO6qUxEuUSuKviNqscjFKRyk7Z
	Gb/SwFlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mdZVm-007vpC-Oh; Thu, 21 Oct 2021 14:57:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdZVk-007voP-DJ
 for linux-nvme@lists.infradead.org; Thu, 21 Oct 2021 14:57:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634828258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xrYbF/MkWlwZZrwhAXfwpczK1nBeqtmJ3jzEBywP9SA=;
 b=ZzEkvSuCK+xZrvgf4Ar3WqavaCwHycUD2HSYGIaPcyeC3C9jjPx5LmVoJpRHc1HYEL4LVg
 Nvb6a4MioTeZDnVCjwSMzflNknfhPbyLciFryfvQ2vQmT25+1nYH+cv8e1HypjXYfYBk27
 J9Qs+7bLo/u3D/S7hVVbqStHGlbdBHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-ykeBRNf2M96Xx3SMSJ9S1Q-1; Thu, 21 Oct 2021 10:57:34 -0400
X-MC-Unique: ykeBRNf2M96Xx3SMSJ9S1Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9595280A5D5;
 Thu, 21 Oct 2021 14:57:33 +0000 (UTC)
Received: from jmeneghi.bos.csb (unknown [10.22.16.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6A005F4E9;
 Thu, 21 Oct 2021 14:57:32 +0000 (UTC)
Subject: Re: [PATCH 2/2] nvmet: fix a race condition between release_queue and
 io_work
To: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, hare@suse.de, chaitanya.kulkarni@wdc.com,
 John Meneghini <jmeneghi@redhat.com>
References: <20211021084155.16109-1-mlombard@redhat.com>
 <20211021084155.16109-3-mlombard@redhat.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
Message-ID: <7af03d77-670d-fa5b-fb84-b6f90cc3cd41@redhat.com>
Date: Thu, 21 Oct 2021 10:57:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211021084155.16109-3-mlombard@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211021_075740_716718_70E1A3DB 
X-CRM114-Status: GOOD (  24.36  )
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

Reviewed-by: John Meneghini <jmeneghi@redhat.com>

On 10/21/21 4:41 AM, Maurizio Lombardi wrote:
> If the initiator executes a reset controller operation while
> performing I/O, the target kernel will crash because of a race condition
> between release_queue and io_work;
> nvmet_tcp_uninit_data_in_cmds() may be executed while io_work
> is running, calling flush_work(io_work) was not sufficient to
> prevent this because io_work could requeue itself.
> 
> * Fix this bug by preventing io_work from being enqueued when
> sk_user_data is NULL (it means that the queue is going to be deleted)
> 
> * Ensure that all the memory allocated for the commands' iovec is freed
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/target/tcp.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 2f03a94725ae..1eedbd83c95f 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -551,6 +551,7 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
>   	struct nvmet_tcp_cmd *cmd =
>   		container_of(req, struct nvmet_tcp_cmd, req);
>   	struct nvmet_tcp_queue	*queue = cmd->queue;
> +	struct socket *sock = queue->sock;
>   	struct nvme_sgl_desc *sgl;
>   	u32 len;
>   
> @@ -570,7 +571,10 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
>   	}
>   
>   	llist_add(&cmd->lentry, &queue->resp_list);
> -	queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &cmd->queue->io_work);
> +	read_lock_bh(&sock->sk->sk_callback_lock);
> +	if (likely(sock->sk->sk_user_data))
> +		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &cmd->queue->io_work);
> +	read_unlock_bh(&sock->sk->sk_callback_lock);
>   }
>   
>   static void nvmet_tcp_execute_request(struct nvmet_tcp_cmd *cmd)
> @@ -1427,7 +1431,9 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
>   
>   	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
>   		if (nvmet_tcp_need_data_in(cmd))
> -			nvmet_tcp_finish_cmd(cmd);
> +			nvmet_req_uninit(&cmd->req);
> +		nvmet_tcp_unmap_pdu_iovec(cmd);
> +		nvmet_tcp_free_iovec(cmd);
>   	}
>   
>   	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
> @@ -1447,11 +1453,10 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
>   	mutex_unlock(&nvmet_tcp_queue_mutex);
>   
>   	nvmet_tcp_restore_socket_callbacks(queue);
> -	flush_work(&queue->io_work);
> +	cancel_work_sync(&queue->io_work);
>   
>   	nvmet_tcp_uninit_data_in_cmds(queue);
>   	nvmet_sq_destroy(&queue->nvme_sq);
> -	cancel_work_sync(&queue->io_work);
>   	sock_release(queue->sock);
>   	nvmet_tcp_free_cmds(queue);
>   	if (queue->hdr_digest || queue->data_digest)
> 


