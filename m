Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF5FC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 17:26:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2768A6187F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 17:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2768A6187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9YLelIVKRh1FFr/42xd50Ui/1Lkq+mjGOGb8laEXPo8=; b=fmrYnwJAlqzYXST3PeRHSc+DqN
	YSU7dBfjPhbqGqUmmigmhX/wtrIvR6Eupom6fbrD7gNcME2gLEe0rpCMKYxCYY8W1mtEAF21Z3Okw
	rl0bWHgKL3k3ViSj+SDByTCppHMKZe88fakYjPzIYsHkpURHXEH3R3QPPyYl9faxLPMLZMS2IrWOF
	T0y7zdrrKvpWDUbgw65xXqYARvgrHrzTCx03I07WWK0DwstMACKvT0PUK27h/4MI4EUDyIxBv+Ki5
	NjuMnhoai9FF4htFwhfee9kRyUGLG1VtXhwIE9TGFHlqNB6EIroaj+UNgtmC7lqGu9H2bMmhrziwX
	3L5PgcLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mn2Dw-002S1c-0M; Tue, 16 Nov 2021 17:26:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mn2Ds-002S0r-Jf
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 17:26:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637083579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9YLelIVKRh1FFr/42xd50Ui/1Lkq+mjGOGb8laEXPo8=;
 b=fYdtoj8RWqJRyx+xfeAZmGy9nNXleB6dEGAm3KpWaH9r0EnZbVECpSxWcBmlDQkXDKj4FH
 zJo24bGl1WflTxK5R0fGwNYqilmvSsB89F0NtLGWnk4769AiVPi/4hGqs5Hx8yn8ploPUm
 krjer0V8bDIFFjZ6lnoHool9mqixaoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-EdI-SbTcMUyGnEMG1-eY_A-1; Tue, 16 Nov 2021 12:26:00 -0500
X-MC-Unique: EdI-SbTcMUyGnEMG1-eY_A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F007DF8A4;
 Tue, 16 Nov 2021 17:25:59 +0000 (UTC)
Received: from [10.22.34.91] (unknown [10.22.34.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DD1219D9B;
 Tue, 16 Nov 2021 17:25:57 +0000 (UTC)
Message-ID: <089e5781-d84b-1585-ec91-9df938d6e307@redhat.com>
Date: Tue, 16 Nov 2021 12:25:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH V3 2/3] nvmet-tcp: add an helper to free the cmd buffers
To: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, chaitanya.kulkarni@wdc.com
References: <20211116154920.87279-1-mlombard@redhat.com>
 <20211116154920.87279-3-mlombard@redhat.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20211116154920.87279-3-mlombard@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211116_092620_762115_416D1A94 
X-CRM114-Status: GOOD (  21.66  )
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

On 11/16/21 10:49, Maurizio Lombardi wrote:
> Makes the code easier to read and to debug.
> 
> Sets the freed pointers to NULL, it will be useful
> when destroying the queues to understand if the commands'
> buffers have been released already or not.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/target/tcp.c | 28 +++++++++++++++++++---------
>   1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 18f36256095f..786b1440a9af 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -166,6 +166,8 @@ static struct workqueue_struct *nvmet_tcp_wq;
>   static const struct nvmet_fabrics_ops nvmet_tcp_ops;
>   static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
>   static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
> +static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
> +static void nvmet_tcp_unmap_pdu_iovec(struct nvmet_tcp_cmd *cmd);
>   
>   static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
>   		struct nvmet_tcp_cmd *cmd)
> @@ -297,6 +299,16 @@ static int nvmet_tcp_check_ddgst(struct nvmet_tcp_queue *queue, void *pdu)
>   	return 0;
>   }
>   
> +static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd)
> +{
> +	WARN_ON(unlikely(cmd->nr_mapped > 0));
> +
> +	kfree(cmd->iov);
> +	sgl_free(cmd->req.sg);
> +	cmd->iov = NULL;
> +	cmd->req.sg = NULL;
> +}
> +
>   static void nvmet_tcp_unmap_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>   {
>   	struct scatterlist *sg;
> @@ -306,6 +318,8 @@ static void nvmet_tcp_unmap_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>   
>   	for (i = 0; i < cmd->nr_mapped; i++)
>   		kunmap(sg_page(&sg[i]));
> +
> +	cmd->nr_mapped = 0;
>   }
>   
>   static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
> @@ -387,7 +401,7 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
>   
>   	return 0;
>   err:
> -	sgl_free(cmd->req.sg);
> +	nvmet_tcp_free_cmd_buffers(cmd);
>   	return NVME_SC_INTERNAL;
>   }
>   
> @@ -632,10 +646,8 @@ static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
>   		}
>   	}
>   
> -	if (queue->nvme_sq.sqhd_disabled) {
> -		kfree(cmd->iov);
> -		sgl_free(cmd->req.sg);
> -	}
> +	if (queue->nvme_sq.sqhd_disabled)
> +		nvmet_tcp_free_cmd_buffers(cmd);
>   
>   	return 1;
>   
> @@ -664,8 +676,7 @@ static int nvmet_try_send_response(struct nvmet_tcp_cmd *cmd,
>   	if (left)
>   		return -EAGAIN;
>   
> -	kfree(cmd->iov);
> -	sgl_free(cmd->req.sg);
> +	nvmet_tcp_free_cmd_buffers(cmd);
>   	cmd->queue->snd_cmd = NULL;
>   	nvmet_tcp_put_cmd(cmd);
>   	return 1;
> @@ -1406,8 +1417,7 @@ static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd)
>   {
>   	nvmet_req_uninit(&cmd->req);
>   	nvmet_tcp_unmap_pdu_iovec(cmd);
> -	kfree(cmd->iov);
> -	sgl_free(cmd->req.sg);
> +	nvmet_tcp_free_cmd_buffers(cmd);
>   }
>   
>   static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
> 


