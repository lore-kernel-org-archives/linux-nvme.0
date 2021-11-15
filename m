Return-Path: <SRS0=a356=QC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3401C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 10:17:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FEA861B4D
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 10:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9FEA861B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XUk5ADpC4sHJnvv04GWcOjeBGYU50ItE1R0f84gHs6U=; b=rGh4NrjTvqt0OhPA4Mw5PdR3eG
	MMaXZm0dLwIaScyOi838qgAbeooTsRmo7K8QHCyfTBxEyJgOQxzXVqkCzIxB5a/wPjC9arnxOaAwd
	U7WZ8aAecm2eNbXmLqkgFQ7MAuJDX5KNW73C1etBnlRCy6Ku27KYJIKKXeRxtQ5YYtEvA9md67/1E
	+spT/IL9shzW/tZ6roQZ9LQOruRPZmTzngRnqbuQiGO8bQtdiHKvzoCpcB9TP5LXL2u2QPO6690Ay
	lyzFPyhJrn9at2bbbDI+uleKPqKCXekGn2MK+TMuN5Ma1j6mRAOzz0QJAnRhhLkMbjbJTawkEnXrq
	5Mw9AAog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmZ3Y-00F8y4-MK; Mon, 15 Nov 2021 10:17:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmYmf-00F3Vv-A6
 for linux-nvme@lists.infradead.org; Mon, 15 Nov 2021 10:00:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636970416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XUk5ADpC4sHJnvv04GWcOjeBGYU50ItE1R0f84gHs6U=;
 b=d1M98T6jo12LAZQEp2urdZh0cRxN/MrFS5p7gVOxK5NQbATCVGd2vCJuUbYjRY+sAs6Y7/
 JpY6WxPKm3UiSi0TzbkYOVBPaIbkBk5KUt4XM0HmwtlpqXMzK75G3GwyHI0iMb9ov1m0Ld
 5lcEtdKKkkDHd4mn2nEFTOPNlzXJ/eU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-E6u8skTFNyK73NU2Wu9ITg-1; Mon, 15 Nov 2021 05:00:11 -0500
X-MC-Unique: E6u8skTFNyK73NU2Wu9ITg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A258802E64;
 Mon, 15 Nov 2021 10:00:09 +0000 (UTC)
Received: from raketa (unknown [10.40.192.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD2125BB12;
 Mon, 15 Nov 2021 10:00:07 +0000 (UTC)
Date: Mon, 15 Nov 2021 11:00:04 +0100
From: Maurizio Lombardi <mlombard@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, hare@suse.de,
 chaitanya.kulkarni@wdc.com, jmeneghi@redhat.com
Subject: Re: [PATCH 2/2] nvmet: fix a race condition between release_queue
 and io_work
Message-ID: <20211115100004.GC21836@raketa>
References: <20211021084155.16109-3-mlombard@redhat.com>
 <54e0464e-0d05-4611-10d9-7b706900af28@grimberg.me>
 <20211028075531.GA4904@raketa>
 <68b69eee-c08c-a449-7e18-96e67a3c0c9d@grimberg.me>
 <20211103113125.GA106365@raketa>
 <24a4036b-4f11-91f4-ee0e-80a43f689b09@grimberg.me>
 <20211112105430.GA192791@raketa>
 <ee5a0405-a8a5-0d8a-d3be-11fe1011c073@grimberg.me>
 <20211115074720.GA21836@raketa>
 <60f43502-c641-6177-4b1e-95f6179ddc42@grimberg.me>
MIME-Version: 1.0
In-Reply-To: <60f43502-c641-6177-4b1e-95f6179ddc42@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211115_020017_491407_90C7E64F 
X-CRM114-Status: GOOD (  18.43  )
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

On Mon, Nov 15, 2021 at 11:48:38AM +0200, Sagi Grimberg wrote:
> I see, the reason why we hit this is because we uninit_data_in_cmds as
> we need to clear the the sq references so nvmet_sq_destroy() can
> complete, and then when nvmet_sq_destroy schedules io_work we hit this.
> 
> I think what we need is to make sure we don't recv from the socket.
> How about this patch:
> --
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 6eb0b3153477..65210dec3f1a 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1436,6 +1436,8 @@ static void nvmet_tcp_release_queue_work(struct
> work_struct *w)
>         mutex_unlock(&nvmet_tcp_queue_mutex);
> 
>         nvmet_tcp_restore_socket_callbacks(queue);
> +       /* stop accepting incoming data */
> +       queue->rcv_state = NVMET_TCP_RECV_ERR;
>         flush_work(&queue->io_work);
> 
>         nvmet_tcp_uninit_data_in_cmds(queue);
> --
> 

Ok I can repeat the test, but you probably want to do this instead:

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index fb72e2d67fd5..d21b525fd4cb 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1450,7 +1450,9 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
        mutex_unlock(&nvmet_tcp_queue_mutex);
 
        nvmet_tcp_restore_socket_callbacks(queue);
-       flush_work(&queue->io_work);
+       cancel_work_sync(&queue->io_work);
+       /* stop accepting incoming data */
+       queue->rcv_state = NVMET_TCP_RECV_ERR;
 
        nvmet_tcp_uninit_data_in_cmds(queue);
        nvmet_sq_destroy(&queue->nvme_sq);

If you don't perform a cancel_work_sync() you may race against a running
io_work thread that may overwrite rcv_state with some other value.

Maurizio


