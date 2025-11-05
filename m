Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DE8CCF9E3
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 01:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aHHGRfAeOQH5OthmYZIoy4wgwTvsag8gemKRZSmlHKg=; b=CT5aD6rVummNDWYVztH6ekn4nB
	NuCC6kZ0EZVTdybRBENeIBqgunkC9pRoCI5ZaM1BQv54au20dLDT2gZZ2H8owlrs3y3ORJsE983A4
	ddoPUQN0taeQOVPJPYCd4IHFRevG4gNaI067GYxh1KtJC59BCJBfwI2scgyg2OGdWOgj4c7gUAIaO
	I1Lqani+Eya0BAgpmkHTR/wBrSjPmMKsnfnFsqdQf8+llpGJVtxDpJFh15mNKcjvCXPB8TBRP0Cbb
	4JUuYkJZaFzwAaLrQl2gUV17204+MgU/PsEtwK5oGDaFRio+gZcrs1TKyDWX5H9PHhjlhrVxWeUbY
	l4SAMqKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGSCh-0000000Cq2I-3KbR;
	Wed, 05 Nov 2025 01:20:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGSCe-0000000Cq1l-1TGa
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 01:20:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762305645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aHHGRfAeOQH5OthmYZIoy4wgwTvsag8gemKRZSmlHKg=;
	b=NENIRkHrW+4jwgz6RWDzvaxYlbjlxQnfUEB/95hLHIEhK6KSuT2DFs0FmrzU7KBSbQP9ui
	D2966Retirkjj4qVo2POWeqTmET/tgoZDvX+N3np1fh4vItExyDJcPRCnJZnfPTEMo32b6
	EH3N2CLcPYV2mTBVaiJw9KYYJvLs3YY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-MGTng0U9NuGsBK03HYhr6Q-1; Tue,
 04 Nov 2025 20:20:44 -0500
X-MC-Unique: MGTng0U9NuGsBK03HYhr6Q-1
X-Mimecast-MFC-AGG-ID: MGTng0U9NuGsBK03HYhr6Q_1762305642
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 413951956089;
	Wed,  5 Nov 2025 01:20:42 +0000 (UTC)
Received: from fedora (unknown [10.72.120.17])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B7A51800577;
	Wed,  5 Nov 2025 01:20:36 +0000 (UTC)
Date: Wed, 5 Nov 2025 09:20:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, chaitanyak@nvidia.com,
	Keith Busch <kbusch@kernel.org>,
	Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCH] nvme: fix admin request_queue lifetime
Message-ID: <aQqmX04KSNE-xctU@fedora>
References: <20251104225939.3641605-1-kbusch@meta.com>
MIME-Version: 1.0
In-Reply-To: <20251104225939.3641605-1-kbusch@meta.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1GK7eaRWucUQZq54a7jc7TREHbuDqzXmKalliAH1zMI_1762305642
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_172048_465862_D7D56966 
X-CRM114-Status: GOOD (  13.07  )
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

On Tue, Nov 04, 2025 at 02:59:39PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The namespaces can access the controller's admin request_queue, and
> stale references on the namespaces may exist. Ensure the request_queue
> is active by moving the controller's 'put' after all references on the
> controller have been released to ensure no one is trying to access the
> request_queue. This fixes a reported use-after-free bug:
> 
>   BUG: KASAN: slab-use-after-free in blk_queue_enter+0x41c/0x4a0
>   Read of size 8 at addr ffff88c0a53819f8 by task nvme/3287
>   CPU: 67 UID: 0 PID: 3287 Comm: nvme Tainted: G            E       6.13.2-ga1582f1a031e #15
>   Tainted: [E]=UNSIGNED_MODULE
>   Hardware name: Jabil /EGS 2S MB1, BIOS 1.00 06/18/2025
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x4f/0x60
>    print_report+0xc4/0x620
>    ? _raw_spin_lock_irqsave+0x70/0xb0
>    ? _raw_read_unlock_irqrestore+0x30/0x30
>    ? blk_queue_enter+0x41c/0x4a0
>    kasan_report+0xab/0xe0
>    ? blk_queue_enter+0x41c/0x4a0
>    blk_queue_enter+0x41c/0x4a0
>    ? __irq_work_queue_local+0x75/0x1d0
>    ? blk_queue_start_drain+0x70/0x70
>    ? irq_work_queue+0x18/0x20
>    ? vprintk_emit.part.0+0x1cc/0x350
>    ? wake_up_klogd_work_func+0x60/0x60
>    blk_mq_alloc_request+0x2b7/0x6b0
>    ? __blk_mq_alloc_requests+0x1060/0x1060
>    ? __switch_to+0x5b7/0x1060
>    nvme_submit_user_cmd+0xa9/0x330
>    nvme_user_cmd.isra.0+0x240/0x3f0
>    ? force_sigsegv+0xe0/0xe0
>    ? nvme_user_cmd64+0x400/0x400
>    ? vfs_fileattr_set+0x9b0/0x9b0
>    ? cgroup_update_frozen_flag+0x24/0x1c0
>    ? cgroup_leave_frozen+0x204/0x330
>    ? nvme_ioctl+0x7c/0x2c0
>    blkdev_ioctl+0x1a8/0x4d0
>    ? blkdev_common_ioctl+0x1930/0x1930
>    ? fdget+0x54/0x380
>    __x64_sys_ioctl+0x129/0x190
>    do_syscall_64+0x5b/0x160
>    entry_SYSCALL_64_after_hwframe+0x4b/0x53
>   RIP: 0033:0x7f765f703b0b
>   Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d dd 52 0f 00 f7 d8 64 89 01 48
>   RSP: 002b:00007ffe2cefe808 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
>   RAX: ffffffffffffffda RBX: 00007ffe2cefe860 RCX: 00007f765f703b0b
>   RDX: 00007ffe2cefe860 RSI: 00000000c0484e41 RDI: 0000000000000003
>   RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
>   R10: 00007f765f611d50 R11: 0000000000000202 R12: 0000000000000003
>   R13: 00000000c0484e41 R14: 0000000000000001 R15: 00007ffe2cefea60
>    </TASK>
> 
> Reported-by: Casey Chen <cachen@purestorage.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


