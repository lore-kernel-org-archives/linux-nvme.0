Return-Path: <SRS0=a356=QC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3D4C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 07:49:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB74C63211
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 07:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CB74C63211
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7jA1ECaPdUoAJA4s4TXp8QNusK6zH3xXVRN2+lx8OsQ=; b=WB1CrgfBpxyV+JISVyiiM53Ce7
	L5Zz95DL9PAIBesVO/dzv7J8j0RulgcNMnaFaLbYQvqvt54BSA2DknTEtZLB5PtSUOXwzzwK6n8sB
	kmsVFEkjMBZDCyKSTnHo775PHWx2jESzOKMceOsSTsI9FhvrupLw0AXWTs84TUee9M3dtXic215lM
	d189avU9bEgLGChasmKazVpqxusS5DygTSSfDksQ6zxVTpwHnvdBH8yqhW51TwiQ7+hFH3nRGezOt
	eMA5xvMsueVxg2b77cPxiHVBaXbAvC5CAe48yxumLv7HvZwNjOcV22nsYGHvrajoA2HScL0H7urky
	8RoQg3Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmWjv-00EYTG-1D; Mon, 15 Nov 2021 07:49:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmWiC-00EXLN-44
 for linux-nvme@lists.infradead.org; Mon, 15 Nov 2021 07:47:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636962449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7jA1ECaPdUoAJA4s4TXp8QNusK6zH3xXVRN2+lx8OsQ=;
 b=fw13KNIzfy9IAB9ACW87bmh0PiueYOVxj2vdZL3fJ+Ge9jLCMPKrdnaf34gyEd9T6heDlx
 FLxozVJk5s7f5WEi2LS2yHwGPZjjfN3ld+iscRO9EARxir1ZY6fDXtxVGAEzfO57+vAHlv
 xcTKhG1JOpi5/3JGH6FNQc9YO/OK7nc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-R_oW3Fx4OvKQILGID0WOcQ-1; Mon, 15 Nov 2021 02:47:26 -0500
X-MC-Unique: R_oW3Fx4OvKQILGID0WOcQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9DB51B18BC2;
 Mon, 15 Nov 2021 07:47:24 +0000 (UTC)
Received: from raketa (unknown [10.40.192.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 263C460C04;
 Mon, 15 Nov 2021 07:47:22 +0000 (UTC)
Date: Mon, 15 Nov 2021 08:47:20 +0100
From: Maurizio Lombardi <mlombard@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, hare@suse.de,
 chaitanya.kulkarni@wdc.com, jmeneghi@redhat.com
Subject: Re: [PATCH 2/2] nvmet: fix a race condition between release_queue
 and io_work
Message-ID: <20211115074720.GA21836@raketa>
References: <20211021084155.16109-1-mlombard@redhat.com>
 <20211021084155.16109-3-mlombard@redhat.com>
 <54e0464e-0d05-4611-10d9-7b706900af28@grimberg.me>
 <20211028075531.GA4904@raketa>
 <68b69eee-c08c-a449-7e18-96e67a3c0c9d@grimberg.me>
 <20211103113125.GA106365@raketa>
 <24a4036b-4f11-91f4-ee0e-80a43f689b09@grimberg.me>
 <20211112105430.GA192791@raketa>
 <ee5a0405-a8a5-0d8a-d3be-11fe1011c073@grimberg.me>
MIME-Version: 1.0
In-Reply-To: <ee5a0405-a8a5-0d8a-d3be-11fe1011c073@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211114_234732_291834_B0D16AF3 
X-CRM114-Status: GOOD (  21.23  )
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

Hello Sagi,

On Sun, Nov 14, 2021 at 12:28:45PM +0200, Sagi Grimberg wrote:
> 
> 
> I think you should shutdown the socket after you restore the socket
> callbacks, and after that cancel_work_sync to deny a self-requeue.
> 
> > -	flush_work(&queue->io_work);
> > +	while (flush_work(&queue->io_work));
> >   	nvmet_tcp_uninit_data_in_cmds(queue);
> >   	nvmet_sq_destroy(&queue->nvme_sq);
> > 
> 
> How about something like this:
> --
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 6eb0b3153477..6425375faf5b 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1436,7 +1436,9 @@ static void nvmet_tcp_release_queue_work(struct
> work_struct *w)
>         mutex_unlock(&nvmet_tcp_queue_mutex);
> 
>         nvmet_tcp_restore_socket_callbacks(queue);
> -       flush_work(&queue->io_work);
> +       /* stop accepting incoming data */
> +       kernel_sock_shutdown(queue->sock, SHUT_RD);
> +       cancel_work_sync(&queue->io_work);
> 
>         nvmet_tcp_uninit_data_in_cmds(queue);
>         nvmet_sq_destroy(&queue->nvme_sq);
> --
> 

This one doesn't work, remember that nvmet_sq_destroy() will start io_work
again and, as I wrote in my previous email, recvmsg() might still return some
data after the socket has been shut down.

[ 1034.234574] nvmet: creating controller 2 for subsystem test-nqn for NQN nqn.2014-08.org.nvmexpress:uuid:a5f7dc87-f3f0-ea44-bfd1-0019ebbb4112. 
[ 1034.764498] nvmet: creating controller 1 for subsystem test-nqn for NQN nqn.2014-08.org.nvmexpress:uuid:a5f7dc87-f3f0-ea44-bfd1-0019ebbb4112. 
[ 1035.291398] nvmet: creating controller 2 for subsystem test-nqn for NQN nqn.2014-08.org.nvmexpress:uuid:a5f7dc87-f3f0-ea44-bfd1-0019ebbb4112. 
[ 1038.471686] nvmet: creating controller 1 for subsystem test-nqn for NQN nqn.2014-08.org.nvmexpress:uuid:a5f7dc87-f3f0-ea44-bfd1-0019ebbb4112. 
[ 1039.002853] general protection fault, probably for non-canonical address 0x51ede3866dd88e22: 0000 [#1] SMP PTI 
[ 1039.006622] CPU: 1 PID: 4869 Comm: kworker/1:2H Kdump: loaded Tainted: G        W        --------- ---  5.14.0_nvmet1+ #1 
[ 1039.008778] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011 
[ 1039.009840] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp] 
[ 1039.011040] RIP: 0010:memcpy_erms+0x6/0x10 
[ 1039.011841] Code: cc cc cc cc eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe 
[ 1039.015216] RSP: 0018:ffffc02c4059fb30 EFLAGS: 00010206 
[ 1039.016176] RAX: 51ede3866dd88e22 RBX: 000000000000248e RCX: 0000000000001000 
[ 1039.017472] RDX: 0000000000001000 RSI: ffff99d7c397948e RDI: 51ede3866dd88e22 
[ 1039.018767] RBP: ffff99d7cc02b000 R08: 0000000000000001 R09: 000000000000fe88 
[ 1039.020074] R10: 000000000000012a R11: 0000000000003ed6 R12: 0000000000000000 
[ 1039.021371] R13: 0000000000001000 R14: ffff99d7cc02b010 R15: 0000000000001a48 
[ 1039.022668] FS:  0000000000000000(0000) GS:ffff99d8f7d00000(0000) knlGS:0000000000000000 
[ 1039.024134] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 
[ 1039.025181] CR2: 00007ffbf45c1658 CR3: 00000001051e4003 CR4: 00000000003706e0 
[ 1039.026497] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 
[ 1039.027836] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400 
[ 1039.029185] Call Trace: 
[ 1039.029696]  _copy_to_iter+0x44d/0x710 
[ 1039.030483]  ? __virt_addr_valid+0x45/0x70 
[ 1039.031284]  ? __check_object_size.part.0+0x45/0x140 
[ 1039.032200]  __skb_datagram_iter+0x19b/0x2d0 
[ 1039.032990]  ? zerocopy_sg_from_iter+0x50/0x50 
[ 1039.033788]  skb_copy_datagram_iter+0x33/0x80 
[ 1039.034568]  tcp_recvmsg_locked+0x299/0x960 
[ 1039.035338]  tcp_recvmsg+0x72/0x1d0 
[ 1039.036023]  ? bpf_lsm_socket_sendmsg+0x10/0x10 
[ 1039.036929]  inet_recvmsg+0x57/0xf0 
[ 1039.037624]  nvmet_tcp_try_recv.constprop.0+0xcb/0x310 [nvmet_tcp] 
[ 1039.038913]  ? pick_next_task_fair+0x39/0x3b0 
[ 1039.039771]  nvmet_tcp_io_work+0x44/0xabd [nvmet_tcp] 
[ 1039.040684]  ? dequeue_task_fair+0xb1/0x370 
[ 1039.041430]  ? finish_task_switch.isra.0+0xb1/0x290 
[ 1039.042305]  process_one_work+0x1e6/0x380 
[ 1039.043061]  worker_thread+0x53/0x3d0 
[ 1039.043720]  ? process_one_work+0x380/0x380 
[ 1039.044467]  kthread+0x10f/0x130 
[ 1039.045059]  ? set_kthread_struct+0x40/0x40 
[ 1039.045806]  ret_from_fork+0x22/0x30 


Maurizio


