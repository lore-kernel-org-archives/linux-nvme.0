Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C56C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 17:25:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44E106187F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 17:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 44E106187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=whIEgQqdNfwtiI2AwVZKRsT3qaazcxc6A5nAPjFmbrU=; b=LK/ftqf+oiL5lEuNKofCdMuc9/
	aZJkgmSRI5AsPkNlz0HGRZ1Wn6EwMaJBTBkwlcOyY0cqpzvTBMYgzx2ocMH+NF/vc7yG4EANj5EF9
	NKB0aUMA9Fbkd5wKGxxGj8/lYtGoxbzNSWEmQn1xq+7oJdAYtSOZC3zLb2fI1ChK51QYhQPwBvhbC
	Lf0qqQz382JTdE0oAWAlENpRIdrBwWHvUWyGoIdSHGiCbuuzCN+umF+9YKRNC9oh4s0Wswo5vLkDz
	Cdq6rLRS3m4zq8cF477gqCWHQja3piGEP9WnaKBfBddjZhGJkV5D6sdjvKt5qQK0xP7yEmLOn8bjO
	MIBrr9yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mn2DG-002RwK-52; Tue, 16 Nov 2021 17:25:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mn2DC-002Rvd-Up
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 17:25:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637083536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=whIEgQqdNfwtiI2AwVZKRsT3qaazcxc6A5nAPjFmbrU=;
 b=DVUVx1l5VzJADrSfScNjirBYAI2zp9wxm4r+tOUFgJx0WhsUbkII66+2T49l7PJcwbDIiL
 8MJRdgwTu8fTFrJInAii8AZ60XfDjfG1lyHfaB921EteKDwCF3snpH+UAdQxSK6mJ/IJA/
 z8ckLU4dB7iliAmfpiNjXwSO1+skNPE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-T1tZG7yyPVm0cJyw_4Yi2Q-1; Tue, 16 Nov 2021 12:25:33 -0500
X-MC-Unique: T1tZG7yyPVm0cJyw_4Yi2Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 142B0102CB79;
 Tue, 16 Nov 2021 17:25:32 +0000 (UTC)
Received: from [10.22.34.91] (unknown [10.22.34.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 381B42271F;
 Tue, 16 Nov 2021 17:25:31 +0000 (UTC)
Message-ID: <f4228f60-2428-55fe-8672-f48a48b7928a@redhat.com>
Date: Tue, 16 Nov 2021 12:25:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH V3 1/3] nvmet-tcp: fix a race condition between
 release_queue and io_work
To: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, chaitanya.kulkarni@wdc.com
References: <20211116154920.87279-1-mlombard@redhat.com>
 <20211116154920.87279-2-mlombard@redhat.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20211116154920.87279-2-mlombard@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211116_092539_119959_A481E813 
X-CRM114-Status: GOOD (  19.32  )
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
> If the initiator executes a reset controller operation while
> performing I/O, the target kernel will crash because of a race condition
> between release_queue and io_work;
> nvmet_tcp_uninit_data_in_cmds() may be executed while io_work
> is running, calling flush_work() was not sufficient to
> prevent this because io_work could requeue itself.
> 
> Fix this bug by using cancel_work_sync() to prevent io_work
> from requeuing itself and set rcv_state to NVMET_TCP_RECV_ERR to
> make sure we don't receive any more data from the socket.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/target/tcp.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 84c387e4bf43..18f36256095f 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1437,7 +1437,9 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
>   	mutex_unlock(&nvmet_tcp_queue_mutex);
>   
>   	nvmet_tcp_restore_socket_callbacks(queue);
> -	flush_work(&queue->io_work);
> +	cancel_work_sync(&queue->io_work);
> +	/* stop accepting incoming data */
> +	queue->rcv_state = NVMET_TCP_RECV_ERR;
>   
>   	nvmet_tcp_uninit_data_in_cmds(queue);
>   	nvmet_sq_destroy(&queue->nvme_sq);
> 


