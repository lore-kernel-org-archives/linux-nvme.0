Return-Path: <SRS0=a356=QC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6574CC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 10:57:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F9863210
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 10:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 35F9863210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IALHDxT9XUmy2DAZ6JXat+S+5qmCvMmJ7DnN42dwwYQ=; b=mdaDv1gXBrwiDsTRZmGbjCK+Op
	hacJV8IqFq8rUKsQOuD6D11ezdgnR+o/BLy6z5HgOwu+EvewoUdTbleqivr9ZM/BKfG/S6VnON0RC
	7kqWikjNMonO/FcvB49uYcD+WOk6Incs8jdFQZrlwrL0HYwwJQJi+9bjsBYFo8oan+HtcZ+dMSsMX
	FAdb1BpMpdq6kZOtOYQdyWRzrXePgmB0xOhqI3UYvrQwGSJrPEHkn8qhbTbTXLUVMhtlw1UVEasAs
	rHeGML0abbWzOyrBaCYQUOr3L2ic9Q6lHZ0HZHgL4pJQjvqacDoNaQ2wIwu+rDIyV0F3Jua9g4UmW
	p+3Fy4RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmZg7-00FHwJ-AI; Mon, 15 Nov 2021 10:57:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmZg4-00FHvY-Rd
 for linux-nvme@lists.infradead.org; Mon, 15 Nov 2021 10:57:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636973851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IALHDxT9XUmy2DAZ6JXat+S+5qmCvMmJ7DnN42dwwYQ=;
 b=YR1jmC4XaCjzjWwwcaNj5BpjsAlW/vGkPAAuuom0XuM/B8JHHLycB94PZDSsxkjn4G/hzo
 G5x2MxdL4ZigVoAwnn4bQ1Ov70c2srZjEW8xtWsiQdgWnzxD2M0D5rICMSEJstGwgdbUBN
 PY+RpKlYGEJU6KnzkiYdJWVsBxa68Pc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-79TjAQPkNS6vsHgNEg8tqg-1; Mon, 15 Nov 2021 05:57:30 -0500
X-MC-Unique: 79TjAQPkNS6vsHgNEg8tqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5F93100D699;
 Mon, 15 Nov 2021 10:57:28 +0000 (UTC)
Received: from raketa (unknown [10.40.192.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FA295D6D5;
 Mon, 15 Nov 2021 10:57:19 +0000 (UTC)
Date: Mon, 15 Nov 2021 11:57:15 +0100
From: Maurizio Lombardi <mlombard@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, hare@suse.de,
 chaitanya.kulkarni@wdc.com, jmeneghi@redhat.com
Subject: Re: [PATCH 2/2] nvmet: fix a race condition between release_queue
 and io_work
Message-ID: <20211115105715.GD21836@raketa>
References: <54e0464e-0d05-4611-10d9-7b706900af28@grimberg.me>
 <20211028075531.GA4904@raketa>
 <68b69eee-c08c-a449-7e18-96e67a3c0c9d@grimberg.me>
 <20211103113125.GA106365@raketa>
 <24a4036b-4f11-91f4-ee0e-80a43f689b09@grimberg.me>
 <20211112105430.GA192791@raketa>
 <ee5a0405-a8a5-0d8a-d3be-11fe1011c073@grimberg.me>
 <20211115074720.GA21836@raketa>
 <60f43502-c641-6177-4b1e-95f6179ddc42@grimberg.me>
 <20211115100004.GC21836@raketa>
MIME-Version: 1.0
In-Reply-To: <20211115100004.GC21836@raketa>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211115_025732_992264_74E6D738 
X-CRM114-Status: GOOD (  14.63  )
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

On Mon, Nov 15, 2021 at 11:00:04AM +0100, Maurizio Lombardi wrote:
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index fb72e2d67fd5..d21b525fd4cb 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1450,7 +1450,9 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
>         mutex_unlock(&nvmet_tcp_queue_mutex);
>  
>         nvmet_tcp_restore_socket_callbacks(queue);
> -       flush_work(&queue->io_work);
> +       cancel_work_sync(&queue->io_work);
> +       /* stop accepting incoming data */
> +       queue->rcv_state = NVMET_TCP_RECV_ERR;
>  
>         nvmet_tcp_uninit_data_in_cmds(queue);
>         nvmet_sq_destroy(&queue->nvme_sq);
> 
> If you don't perform a cancel_work_sync() you may race against a running
> io_work thread that may overwrite rcv_state with some other value.

This one works correctly.
Unless an unforseen problem arises, I am going to resubmit
the patchset soon.

Maurizio


