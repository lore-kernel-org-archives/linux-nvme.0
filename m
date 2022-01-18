Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91340C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Jan 2022 19:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ti6VlsDE8lzK29QYADNG1FxoDNtLKt9IJl9F+i1UmvE=; b=vqCHFLJcocvLL7JtMkKx9Cr5vC
	uLpJlVnddz86x/KlJyj2I747BHpXyxN4mtfqUAl6DWDemDb/E8CB5S9Gmh+UBYA/922BBoUPzq7iP
	gyRvotBV7Og/3NARMjleQSGFoB2pXsir0DXd6vgE3T286XrxzLF+HuJCpb4V7XXx4S9PwUDfwx8q5
	tutvos64M1/q5QDIqHaO1u+VxNCTHMhqA3ehy/gR7mitzCglNt9dlh7OQ913dVaHUMoPRX7n0AhOM
	60yCQlinLKqpYoMqyvK4Hu+15CygMSG60hgNYMDXESVL948YtwZ+1d++dPzB64f/KTh9fLHjkb4Ow
	jyDaq9nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n9uFU-002lT4-FM; Tue, 18 Jan 2022 19:34:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n9uFQ-002lSQ-RX
 for linux-nvme@lists.infradead.org; Tue, 18 Jan 2022 19:34:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642534465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=ti6VlsDE8lzK29QYADNG1FxoDNtLKt9IJl9F+i1UmvE=;
 b=Zi0pgRCw24IBORTQhfjFVWpZfQ5IdTpcY73suosMxY7REosmpRs+nWiLl4LZKUkFcxO3H2
 j/wt2uCc+NbglJJojo+OhEFaPZVik8DbRyJdEJ8oKy1uSf5cz7jKPYLUS4ikSjoKFpIgor
 lOrQXV18HgZ0uzxRYqYFGrB/9CGlSP8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-m877JEjcNACiXXgVjtMV6A-1; Tue, 18 Jan 2022 13:36:34 -0500
X-MC-Unique: m877JEjcNACiXXgVjtMV6A-1
Received: by mail-wm1-f70.google.com with SMTP id
 o193-20020a1ca5ca000000b0034d78423625so1156971wme.3
 for <linux-nvme@lists.infradead.org>; Tue, 18 Jan 2022 10:36:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ti6VlsDE8lzK29QYADNG1FxoDNtLKt9IJl9F+i1UmvE=;
 b=WFMsn24y2NyQvkjC0v6/4gN+JLsDK4GeONQMsotZoU7GrogZlGy2AembKk0ld28+CU
 K4b6vXR7dPozcaBYec4z3ZlCBmI3kkNyH5+AeLUSReHDjfpWgOwgzvniF+xAXCpccR58
 2vtTOY1ifC1M5EyeEd2+keQdb19iF+lN5JPFkIR6HGl/Ks4nGIsaM1Kr4rWUj19JnOKd
 +F8N8fxvRauddPvwwzj+/ZekRLHISubuoOBqVICd4YVq5OiHA0ztK6Lh24/lqM6/yQR3
 Pi8jsjXEhkqh0p62N6EIc33DbzSHZzm8EOt2gb83Tkuwffm6WbcizeKyYgsCHfZrUSze
 MPjQ==
X-Gm-Message-State: AOAM533aYjdr8yxxtYgQ62QwKXT/h6d90ZRFWfQDv1X+wu5tvYHquWDh
 xdQF4fBosIRo4WXBH4/dkwF7lLpilO1+2Xf4QlqXcJcEa2qqAMo32hH253VCVamrvRV2oEMbGQR
 TJCAocoH+9U7VKZQhLTIZSxo7IrX7VnYjXcdOTjEgYDM=
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr25688459wmj.35.1642530992856; 
 Tue, 18 Jan 2022 10:36:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSwdJrvd1qLt9UctsfpwHeclqv3Q9e1TKWMk+vAWQ+UJnw/tzkf4F3fqWJWlG18M3BqED344WKJBPrWk3oRXA=
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr25688440wmj.35.1642530992545; 
 Tue, 18 Jan 2022 10:36:32 -0800 (PST)
MIME-Version: 1.0
From: Chris Leech <cleech@redhat.com>
Date: Tue, 18 Jan 2022 10:36:21 -0800
Message-ID: <CAPnfmXLsLwUKU_OdELsxy9gkR+21yTHFst0KUqb-c6Zd7OyB_A@mail.gmail.com>
Subject: ncme-tcp: io_work NULL pointer when racing with queue stop
To: linux-nvme@lists.infradead.org
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cleech@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220118_113429_007532_02F6D0BE 
X-CRM114-Status: GOOD (  15.11  )
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

I'm looking at a reported NULL pointer fault with controller reset
testing under load, and it appears that the nvme_tcp_stop_queue
sequence is racing against scheduled io_work.  The fault occurs when
kernel_sendpage is called from the workqueue context and hits a NULL
sock->ops pointer, which is cleared by kernel_sock_shutdown before the
call to cancel_work_sync.

[ 4353.145377] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
[ 4353.151921] RIP: 0010:kernel_sendpage+0x11/0xc0
[ 4353.157005] Code: ff ff ff 31 db e9 70 ff ff ff be ff ff ff ff e9
49 ff ff ff 0f 1f 44 00 00 0f 1f 44 00 00 55 48 89 fd 48 83 ec 18 48
8b 47 20 <4c> 8b 88 a0 00 00 00 4d 85 c9 74 3b 48 8b 7e 08 48 8d 47 ff
83 e7
[ 4353.177985] RSP: 0000:ffffb5870a7b7d68 EFLAGS: 00010292
[ 4353.189185] RAX: 0000000000000000 RBX: 0000000080000000 RCX: 0000000000000048
[ 4353.189196] RDX: 0000000000000000 RSI: ffffdffa25000000 RDI: ffff981b45de3400
[ 4353.189199] RBP: ffff981b45de3400 R08: 00000000000000c0 R09: ffff98182073b0ec
[ 4353.189202] R10: 000000000000000c R11: 000000000000000c R12: ffff9817c4885e38
[ 4353.226418] R13: 0000000000000048 R14: ffff9817d0018000 R15: 0000000000000000
[ 4353.234393] FS:  0000000000000000(0000) GS:ffff981b2fa00000(0000)
knlGS:0000000000000000
[ 4353.243442] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4353.249871] CR2: 00000000000000a0 CR3: 00000001307ce004 CR4: 00000000003706f0
[ 4353.257850] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 4353.265824] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 4353.273798] Call Trace:
[ 4353.276554]  nvme_tcp_try_send_cmd_pdu+0xf4/0x250 [nvme_tcp]
[ 4353.282901]  ? tcp_rcv_space_adjust+0x1d/0x1c0
[ 4353.287888]  nvme_tcp_try_send+0x15a/0x330 [nvme_tcp]
[ 4353.293553]  ? release_sock+0x43/0x90
[ 4353.297666]  ? nvme_tcp_try_recv+0x73/0xa0 [nvme_tcp]
[ 4353.303334]  nvme_tcp_io_work+0x37/0x90 [nvme_tcp]
[ 4353.308723]  process_one_work+0x1e3/0x3b0
[ 4353.313237]  worker_thread+0x50/0x3b0
[ 4353.317335]  ? rescuer_thread+0x370/0x370
[ 4353.321813]  kthread+0x149/0x170
[ 4353.325440]  ? set_kthread_struct+0x40/0x40
[ 4353.330128]  ret_from_fork+0x22/0x30

It would seem easy enough to cancel the io_work before
kernel_sock_shutdown, but I think that still leaves an opportunity for
it to be rescheduled.  The TCP callbacks do all appear to be protected
by the sk_callback_lock and checks against sk_user_data, so it may be
possible to restore those first?  I'm not sure on the best way to
safely shut down the socket in this case.

I'll try and get some testing on this change, but wanted to get this
on the list and see what other suggestions you might have.

Thanks!
Chris Leech

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4ceb28675fdf..d9e1f875f80d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1567,9 +1567,9 @@ static void nvme_tcp_restore_sock_calls(struct
nvme_tcp_queue *queue)

 static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 {
-       kernel_sock_shutdown(queue->sock, SHUT_RDWR);
        nvme_tcp_restore_sock_calls(queue);
        cancel_work_sync(&queue->io_work);
+       kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 }


