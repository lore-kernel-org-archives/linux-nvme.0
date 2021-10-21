Return-Path: <SRS0=gxeb=PJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2601C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Oct 2021 14:58:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A416136F
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Oct 2021 14:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 83A416136F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=33mvsFyHO06g20deWCIZy6AcPLfOXXH+HUF55s+An6k=; b=LrP3irr+RxcbzVmNZm5wQ8iZXn
	gp40RqGCMyJtL+M/eL+1cvQTHN18w4hnEmNbuHmGlDEWS1POcc6b3hxxD5n4m23uhYjFgivl9TKSx
	xbAOiklgCmCrY3mSZ/avGooHYValoLkC4hecm2JgmY6EDwjV+woiQkfK1vctY0cU5fA/gmOOzP8qD
	r5iVdb9Ih9FtoheqOyCPnbXLLcFxxR/ft/VpqRgUbWtZvzYGn7DCGcn+xAcTDar0ztEO9velDppUG
	QwTIHLbnIxnCLJNKwXKc2PTG+rk7N/V0ElgXu4VlM5QlPVJdAwV9CLC4+RgsDbFFAsWYf3RnREYQ8
	+e+ZHOEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mdZWW-007vyK-GW; Thu, 21 Oct 2021 14:58:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdZWR-007vx9-O5
 for linux-nvme@lists.infradead.org; Thu, 21 Oct 2021 14:58:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634828302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=33mvsFyHO06g20deWCIZy6AcPLfOXXH+HUF55s+An6k=;
 b=F7FloaRozL7NbNxSNtxgfKNjYAjQUGC2eovWcLkAdLiQ/vZ/19/Isacl0uI8DSUkBO74Ln
 Gtrut8yUw0RLMMfSHYljE4u56P06dnptQPzty+3DYdnZ3+ID/cMttyeoQ6+hbN4KiwvkS+
 q12hjhqsdZ2gwFmPXfoHnPbOJ27UnIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-VOeJmNPCNCWIIu5-WLae1Q-1; Thu, 21 Oct 2021 10:56:17 -0400
X-MC-Unique: VOeJmNPCNCWIIu5-WLae1Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F4CF8066F2;
 Thu, 21 Oct 2021 14:56:16 +0000 (UTC)
Received: from jmeneghi.bos.csb (unknown [10.22.16.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE2B25F4E9;
 Thu, 21 Oct 2021 14:56:14 +0000 (UTC)
Subject: Re: [PATCH 1/2] nvmet: add an helper to free the iovec
To: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, hare@suse.de, chaitanya.kulkarni@wdc.com,
 John Meneghini <jmeneghi@redhat.com>
References: <20211021084155.16109-1-mlombard@redhat.com>
 <20211021084155.16109-2-mlombard@redhat.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
Message-ID: <56f23216-0b70-972b-7a24-8f496e62992e@redhat.com>
Date: Thu, 21 Oct 2021 10:56:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211021084155.16109-2-mlombard@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211021_075823_924851_37043EDB 
X-CRM114-Status: GOOD (  26.24  )
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

Looks good Maurizio.

You should also mention that you have a simple test you can run which reproduces this bug and results in a kernel panic.

We might want to add that test to the blktests tool.

Reviewed-by: John Meneghini <jmeneghi.redhat.com>


On 10/21/21 4:41 AM, Maurizio Lombardi wrote:
> Makes the code easier to read and to debug.Reviewed-by: John Meneghini <jmeneghi at redhat.com>
> 
> Sets the freed pointers to NULL, it will be useful
> when destroying the queues to understand if the
> iovecs have been released already or not.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/target/tcp.c | 28 +++++++++++++++++++---------
>   1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index c33a0464346f..2f03a94725ae 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -166,6 +166,8 @@ static struct workqueue_struct *nvmet_tcp_wq;
>   static const struct nvmet_fabrics_ops nvmet_tcp_ops;
>   static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
>   static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
> +static void nvmet_tcp_free_iovec(struct nvmet_tcp_cmd *cmd);
> +static void nvmet_tcp_unmap_pdu_iovec(struct nvmet_tcp_cmd *cmd);
>   
>   static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
>   		struct nvmet_tcp_cmd *cmd)
> @@ -297,6 +299,16 @@ static int nvmet_tcp_check_ddgst(struct nvmet_tcp_queue *queue, void *pdu)
>   	return 0;
>   }
>   
> +static void nvmet_tcp_free_iovec(struct nvmet_tcp_cmd *cmd)
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
> +	nvmet_tcp_free_iovec(cmd);
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
> +		nvmet_tcp_free_iovec(cmd);
>   
>   	return 1;
>   
> @@ -664,8 +676,7 @@ static int nvmet_try_send_response(struct nvmet_tcp_cmd *cmd,
>   	if (left)
>   		return -EAGAIN;
>   
> -	kfree(cmd->iov);
> -	sgl_free(cmd->req.sg);
> +	nvmet_tcp_free_iovec(cmd);
>   	cmd->queue->snd_cmd = NULL;
>   	nvmet_tcp_put_cmd(cmd);
>   	return 1;
> @@ -1406,8 +1417,7 @@ static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd)
>   {
>   	nvmet_req_uninit(&cmd->req);
>   	nvmet_tcp_unmap_pdu_iovec(cmd);
> -	kfree(cmd->iov);
> -	sgl_free(cmd->req.sg);
> +	nvmet_tcp_free_iovec(cmd);
>   }
>   
>   static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
> 


