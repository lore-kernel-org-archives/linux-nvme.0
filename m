Return-Path: <SRS0=a356=QC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28B1C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 07:53:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0EFF63211
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 07:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C0EFF63211
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zz6eNvY+ZMMCMytPKAPVYM0kQWcTcxcHpTY3pSfC+9U=; b=3vfAWHFkr61hKqmjaihUOzFIuu
	KWmyshiaywZUU0mAGyU03ks7Lx4ydq3q4LACtW/BEt5P0rmUEXg90BSDVnwhE2w0RrIlxQVPJYf+w
	xCjiJianRlpnOnGwoZVn+IRsRN6zjlIEGQ3cfxNG1z7ZXTwtISDvVcoMmJjc9pdkaTVJxguslrFPm
	nlkFflrHk2B5Tthwhx1SyU50a5cQGUb0FjkCw4oUT0l+ECS2Zzs3UR6BH8mnKkIue9Bbas7y6BxPI
	o/YIPv44XLkuaulKlamqnaWsEVM8jY3Asp9N+vntVfjGgU06Vsb2rL1ToQl5Ab3BWOUAutuB2ug+x
	+45WORRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmWnY-00EaBY-05; Mon, 15 Nov 2021 07:53:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmWnU-00Ea9a-IF
 for linux-nvme@lists.infradead.org; Mon, 15 Nov 2021 07:53:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636962779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zz6eNvY+ZMMCMytPKAPVYM0kQWcTcxcHpTY3pSfC+9U=;
 b=Re9TSco0XkMEn9/U0kid84omPq3AOep2BVm5mhsOgau9Wbv/E4if1df3wrgyHnYvHQ968h
 kOdXr2sBboZhaxitj4HcGtFNFE4NQcI9A7tOhagcBkErQeXVKLYAzxK/5/KjJisAAub0gW
 fPJH45COkrw1g6LhvN714/+UC69KSwQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-BcDTvtiaNxiq0H-UC3zFjw-1; Mon, 15 Nov 2021 02:52:58 -0500
X-MC-Unique: BcDTvtiaNxiq0H-UC3zFjw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 400618799EC;
 Mon, 15 Nov 2021 07:52:57 +0000 (UTC)
Received: from raketa (unknown [10.40.192.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6224D17C58;
 Mon, 15 Nov 2021 07:52:55 +0000 (UTC)
Date: Mon, 15 Nov 2021 08:52:52 +0100
From: Maurizio Lombardi <mlombard@redhat.com>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 hch@lst.de, hare@suse.de, chaitanya.kulkarni@wdc.com
Subject: Re: [PATCH 2/2] nvmet: fix a race condition between release_queue
 and io_work
Message-ID: <20211115075252.GB21836@raketa>
References: <20211021084155.16109-1-mlombard@redhat.com>
 <20211021084155.16109-3-mlombard@redhat.com>
 <54e0464e-0d05-4611-10d9-7b706900af28@grimberg.me>
 <20211028075531.GA4904@raketa>
 <68b69eee-c08c-a449-7e18-96e67a3c0c9d@grimberg.me>
 <20211103113125.GA106365@raketa>
 <24a4036b-4f11-91f4-ee0e-80a43f689b09@grimberg.me>
 <20211112105430.GA192791@raketa>
 <81bb4d6f-8639-7150-d4fd-e18d42007278@redhat.com>
MIME-Version: 1.0
In-Reply-To: <81bb4d6f-8639-7150-d4fd-e18d42007278@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211114_235300_711799_8EBE2EB3 
X-CRM114-Status: GOOD (  20.26  )
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

Hi,

On Fri, Nov 12, 2021 at 10:54:42AM -0500, John Meneghini wrote:
> Nice work Maurizio. This should solve some of the problems we are seeing with nvme/tcp shutdown.
> 
> Do you think we have a similar problem on the host side, in nvme_tcp_init_connection?
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 8cb15ee5b249..adca40c932b7 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1271,8 +1271,12 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
>         memset(&msg, 0, sizeof(msg));
>         iov.iov_base = icresp;
>         iov.iov_len = sizeof(*icresp);
> -       ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
> +
> +       do {
> +               ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
>                         iov.iov_len, msg.msg_flags);
> +        } while (ret == 0);
> +
>         if (ret < 0)
>                 goto free_icresp;
>


At the moment I don't know if there is a similar problem in the host side, I'll have to look
at it a bit.
However, I don't think this patch will work. If the socket has been shut down recvmsg() will
return 0 and it will fall into an infinite loop.

Maurizio


