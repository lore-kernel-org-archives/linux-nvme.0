Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DD8C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 02:48:29 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B1965061
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 02:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B1965061
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6AsPgdNgfAPnH7amAZxD3bWqcAu8gy/AGKRvxikZeMA=; b=lNFUN0XpL1M0nVin84sCqSLY0
	q70kpTEAHbtDHMCGPimIgh3UogA+q5YjrQaw4ZYmBD3dgkVAIqJPbiViGxpx/GOvTTy062QBVVtmn
	lHYdJNQm29NGZ2bwbidJILAGNlFCV6sRlCiac8KFOABCjZmRnJ7hGpYkvx9qsk6yResnREIuvFLw7
	9CK3tDk4VcvHLQOJSBYEyehzi7JrtjMC7jsopybIMdtBjAHqfLllQeyaMFfLc+GsfIoXWL0QQLQOz
	yKj8HCnFm5iKqO/lNzA3sAYH/6dxZIi+vhQnRZR6s4/li6omyStjRb7iN0km3dM05WdpHEAbX44wV
	boEypZgvQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLzka-00HGtO-AY; Tue, 16 Mar 2021 02:48:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLzkT-00HGs7-U5
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 02:48:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615862874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kNILj82YmdGHVZFih3hZWR28pUHa0Uetcz5GjbH+0IY=;
 b=FPpvpxYe3uRay7yFiwKDYyGBLTKSZwRJWAnWuZQLuiyf8joL+hoeyqZ3EWb1DUNdj0CzRg
 2FxjYHnFlcZ0RIY6N0822Bl16/+Jjsmu0jDjYYaQ/rV7khPyproyB6DkyAepv+slTtxmuV
 bODvsLxj1FXQQ+4uquMnuWMvBRMWRLw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-wMnJtWAUPcGyHiEWqem_4g-1; Mon, 15 Mar 2021 22:47:50 -0400
X-MC-Unique: wMnJtWAUPcGyHiEWqem_4g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2131D363A8;
 Tue, 16 Mar 2021 02:47:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-129.pek2.redhat.com
 [10.72.12.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F9E21F04E;
 Tue, 16 Mar 2021 02:47:46 +0000 (UTC)
Subject: Re: [PATCH] nvme-tcp: Fix misuse of __smp_processor_id with
 preemption enabled
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20210315205347.353806-1-sagi@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <7c1ef4a6-2e4e-2403-944c-7cecb0b02e85@redhat.com>
Date: Tue, 16 Mar 2021 10:47:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210315205347.353806-1-sagi@grimberg.me>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yi.zhang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_024758_265400_59A7D47A 
X-CRM114-Status: GOOD (  22.42  )
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

Thanks.

Tested-by: Yi Zhang <yi.zhang@redhat.com>

On 3/16/21 4:53 AM, Sagi Grimberg wrote:
> For our pure advisory use-case, we only rely on this call as a hint
> so fix the warning complaints of using the smp_processor_id variants
> with preemption enabled.
>
> Fixes: db5ad6b7f8cd ("nvme-tcp: try to send request in queue_rq context")
> Fixes: ada831772188 ("nvme-tcp: Fix warning with CONFIG_DEBUG_PREEMPT")
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/tcp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index bd931de44d6c..0ef72568a4dd 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -287,7 +287,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
>   	 * directly, otherwise queue io_work. Also, only do that if we
>   	 * are on the same cpu, so we don't introduce contention.
>   	 */
> -	if (queue->io_cpu == __smp_processor_id() &&
> +	if (queue->io_cpu == raw_smp_processor_id() &&
>   	    sync && empty && mutex_trylock(&queue->send_mutex)) {
>   		queue->more_requests = !last;
>   		nvme_tcp_send_all(queue);


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
