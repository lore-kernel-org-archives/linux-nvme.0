Return-Path: <SRS0=M30F=P7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00122C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 15:54:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B33B060F45
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 15:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B33B060F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TN/9oJHM2LXr4ulxjjtaIRRjPwyXlpDaGVMxRmM/SbY=; b=Lk+ybklYBB8X+eFDjBo/b2qRb4
	VYLSzCdO9ynFB7cbuHG45+/ukh7MVgYfyvIkBXHaKebjuqd96kQb3Km1DK8nbaL0FlY2qPKM/VPhT
	MFCHclTzXDfjkTy0tJ97QfzCkSGP508fyhKd8avLZl3VG040GY1nT1UsRZXtMLJfPEmG0Cj4GtuC0
	gZ812DWZUX1jZD/vi1IxObpw9mFNIL1sDS4YgzvNQf1+zX/erJKlkmze5O8o1i3RpxByvwq754gT0
	ll1ReszXcBvWYM/irniC4RcfAQkNM2aKLHF6S8VFUSmeaOj5MFcQ2RbFjG/sLl20z7JivCcdq67c9
	M/21IMeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mlYtA-00BAtp-16; Fri, 12 Nov 2021 15:54:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlYt7-00BAt0-1F
 for linux-nvme@lists.infradead.org; Fri, 12 Nov 2021 15:54:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636732486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TN/9oJHM2LXr4ulxjjtaIRRjPwyXlpDaGVMxRmM/SbY=;
 b=FQbSMYJK5qmx4hFEg45bwRxf7lh70lzGhTnD07fQEy0iMdMKEki6kVroc5tz8NEUtFCTue
 rLe1o2gtptFxNO8yAIXq7Tgt5c7oomW0Iczcf10MATJDJrYrOWnr1zangLGJcwNb2Yu8+b
 hlZlWFp07VgUnkp2m1/LKZcfj3r6fG4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-VVPBYndSOnSqVH7Zoz9Rgw-1; Fri, 12 Nov 2021 10:54:45 -0500
X-MC-Unique: VVPBYndSOnSqVH7Zoz9Rgw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 462EE1927800;
 Fri, 12 Nov 2021 15:54:44 +0000 (UTC)
Received: from [10.22.33.237] (unknown [10.22.33.237])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33C42101E59D;
 Fri, 12 Nov 2021 15:54:43 +0000 (UTC)
Message-ID: <81bb4d6f-8639-7150-d4fd-e18d42007278@redhat.com>
Date: Fri, 12 Nov 2021 10:54:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] nvmet: fix a race condition between release_queue and
 io_work
To: Maurizio Lombardi <mlombard@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, hare@suse.de,
 chaitanya.kulkarni@wdc.com
References: <20211021084155.16109-1-mlombard@redhat.com>
 <20211021084155.16109-3-mlombard@redhat.com>
 <54e0464e-0d05-4611-10d9-7b706900af28@grimberg.me>
 <20211028075531.GA4904@raketa>
 <68b69eee-c08c-a449-7e18-96e67a3c0c9d@grimberg.me>
 <20211103113125.GA106365@raketa>
 <24a4036b-4f11-91f4-ee0e-80a43f689b09@grimberg.me>
 <20211112105430.GA192791@raketa>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20211112105430.GA192791@raketa>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211112_075449_337059_35878A6A 
X-CRM114-Status: GOOD (  30.21  )
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

Nice work Maurizio. This should solve some of the problems we are seeing with nvme/tcp shutdown.

Do you think we have a similar problem on the host side, in nvme_tcp_init_connection?

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8cb15ee5b249..adca40c932b7 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1271,8 +1271,12 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
         memset(&msg, 0, sizeof(msg));
         iov.iov_base = icresp;
         iov.iov_len = sizeof(*icresp);
-       ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
+
+       do {
+               ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
                         iov.iov_len, msg.msg_flags);
+        } while (ret == 0);
+
         if (ret < 0)
                 goto free_icresp;



On 11/12/21 05:54, Maurizio Lombardi wrote:
> Hi Sagi,
> 
> On Thu, Nov 04, 2021 at 02:59:53PM +0200, Sagi Grimberg wrote:
>>
>> Right, after the call to cancel_work_sync we will know that io_work
>> is not running. Note that it can run as a result of a backend completion
>> but that is ok and we do want to let it run and return completion to the
>> host, but the socket should already be shut down for recv, so we cannot
>> get any other byte from the network.
> 
> 
> I did some tests and I found out that kernel_recvmsg() sometimes returns
> data even if the socket has been already shut down (maybe it's data it received
> before the call to kernel_sock_shutdown() and waiting in some internal buffer?).
> 
> So when nvmet_sq_destroy() triggered io_work, recvmsg() still returned data
> and the kernel crashed again despite the socket was closed.
> 
> Therefore, I think that after we shut down the socket we
> should let io_work run and requeue itself until it finishes its job
> and no more data is returned by recvmsg(),
> one way to achieve this is to repeatedly call flush_work() until it returns
> false.
> 
> Right now I am testing the patch below and it works perfectly.
> 
> Note that when the socket is closed recvmsg() might return 0,
> nvmet_tcp_try_recv_data() should return -EAGAIN
> in that case otherwise we end up in an infinite loop (io_work
> will countinously requeue itself).
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 2f03a94725ae..7b441071c6b9 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1139,8 +1139,10 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
>   	while (msg_data_left(&cmd->recv_msg)) {
>   		ret = sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
>   			cmd->recv_msg.msg_flags);
> -		if (ret <= 0)
> +		if (ret < 0)
>   			return ret;
> +		else if (ret == 0)
> +			return -EAGAIN;
>   
>   		cmd->pdu_recv += ret;
>   		cmd->rbytes_done += ret;
> @@ -1446,8 +1450,10 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
>   	list_del_init(&queue->queue_list);
>   	mutex_unlock(&nvmet_tcp_queue_mutex);
>   
> +	kernel_sock_shutdown(queue->sock, SHUT_RD);
> +
>   	nvmet_tcp_restore_socket_callbacks(queue);
> -	flush_work(&queue->io_work);
> +	while (flush_work(&queue->io_work));
>   
>   	nvmet_tcp_uninit_data_in_cmds(queue);
>   	nvmet_sq_destroy(&queue->nvme_sq);
> 


