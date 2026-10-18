Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD9DCCF2C4
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Oct 2026 01:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NrMAm653jgk0Ds4yvw9+dcPjY4fE0gNo3bbkGC9GffA=; b=x8NTNsCUVjOi6zo6zRyHClXCbb
	vDo09gndTt+g6TADFRvawtNdVozaWCskJ6L2LMexPAWSsA//pX5CflCt8ucz9al5UYr9n3gkysbK/
	RC9pokm9X6YLQpAuPhFeHdToXEl8XnCfh6w/lDbRoXGUVUSy2db1kpkb/Vi5dlVbO+7BFh0lWXJKW
	N3F22KQZilVcBJkxPNoUCIn21K5tGSc3KYb69mbXtTgcRF1X4QEd8wFs3RUCHzxbhWwgrEAKkq3nJ
	3Vfr9Eci3+7qSIXV+NU5GzFsgBzZkDk7QMNY4xcZox4s97cITOj5sPryjUv92rrhIhNmkPLnZPp6L
	vfOehT7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIFUc-00000005Oor-1J7N;
	Sun, 18 Oct 2026 01:15:18 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIFUb-00000005Ooi-0eC1
	for linux-nvme@lists.infradead.org;
	Sun, 18 Oct 2026 01:15:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 936DE60142;
	Sun, 18 Oct 2026 01:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AF71F000C4;
	Sun, 18 Oct 2026 01:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792286115;
	bh=NrMAm653jgk0Ds4yvw9+dcPjY4fE0gNo3bbkGC9GffA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Mm8y5rQYeCSoBs4Pxm5dsNGVm4E5zN9WoBZAkJVIGkXmfgK93wq7R6mbU9EfPDLmK
	 XfEvb1YILhXzXJFzXIlA3aLfRCT1VdadnwroT24EvVyB3+OyHmyXABte/zc8NBQBD1
	 09jmuwU4ZE8RmrYhLq1k0R9jbMdltjkWcYhbNLZyAloNbaAim/U24QBIAbZYEMFFND
	 XVeHBAUOrYwWNaabRXpE/anrVmuYkVjxbO4p+vq4Lx+qNSN1X02aJGBcZjp6SCzOXL
	 bZ6NGoUy0pNlaOu6hMXT5qMOeHz2977wG+YdMXGL3m/u1kZ6urz8XYkzt/Z8+K8pQ2
	 IviRFk3uY4yfA==
Message-ID: <sashiko-outbox-175868@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] nvme-tcp: allow setting per-queue io_cpu through
 sysfs
To: "Saravanan D" <saravanand@crusoe.ai>, linux-nvme@lists.infradead.org
In-Reply-To: <20261018010059.83120-3-saravanand@crusoe.ai>
References: <20261018010059.83120-1-saravanand@crusoe.ai>
 <20261018010059.83120-3-saravanand@crusoe.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 01:15:14 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] nvme-tcp: sysfs io_cpu exposed before nvme_tcp_set_queue_io_cpu(=
) runs
--

commit e947efa489c70b4e98e2f6a3345b13b02a0aef83
Author: Saravanan D <saravanand@crusoe.ai>

nvme-tcp: allow setting per-queue io_cpu through sysfs

This commit exposes per-queue io_cpu and managed sysfs attributes under
/sys/class/nvme/nvmeX/queues/<qid>/ so userspace can view and override
the CPU placement for NVMe-TCP I/O queue socket work.

Link: https://lore.kernel.org/linux-nvme/13c160d0-0657-47ce-9a16-58d348267a=
b0@grimberg.me/

> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index ec678ed07af8d..699997c0e8e24 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
[ ... ]
> @@ -1917,7 +2038,11 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *=
nctrl, int qid,
> =20
>  	queue->sock->sk->sk_allocation =3D GFP_ATOMIC;
>  	queue->sock->sk->sk_use_task_frag =3D false;
> -	queue->io_cpu =3D WORK_CPU_UNBOUND;
> +	/* no store races here, the lock is for the write helper */
> +	spin_lock(&nvme_tcp_cpu_queues_lock);
> +	if (!test_bit(NVME_TCP_Q_IO_CPU_USER, &queue->flags))
> +		nvme_tcp_queue_change_io_cpu(queue, WORK_CPU_UNBOUND);
> +	spin_unlock(&nvme_tcp_cpu_queues_lock);
>  	queue->request =3D NULL;
>  	queue->data_remaining =3D 0;
>  	queue->ddgst_remaining =3D 0;
> @@ -1985,6 +2110,9 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *n=
ctrl, int qid,
> =20
>  	set_bit(NVME_TCP_Q_ALLOCATED, &queue->flags);
> =20
> +	if (qid)
> +		nvme_tcp_add_queue_sysfs(queue);
> +
>  	return 0;

[Severity: Medium]
In nvme_tcp_setup_queue_async(), nvme_tcp_alloc_queue() runs before
nvme_tcp_start_queue(), where nvme_tcp_set_queue_io_cpu() is called:

nvme_tcp_setup_queue_async()
  nvme_tcp_alloc_queue()
    if (!test_bit(NVME_TCP_Q_IO_CPU_USER, &queue->flags))
      nvme_tcp_queue_change_io_cpu(queue, WORK_CPU_UNBOUND);
    ...
    nvme_tcp_add_queue_sysfs(queue);
  nvme_tcp_start_queue()
    if (idx) {
      nvme_tcp_set_queue_io_cpu(queue);
      ret =3D nvmf_connect_io_queue(nctrl, idx);
    }

Because nvme_tcp_add_queue_sysfs() publishes the sysfs attributes in
nvme_tcp_alloc_queue() before nvme_tcp_set_queue_io_cpu() runs in
nvme_tcp_start_queue(), can a userspace control plane reading io_cpu and
managed as soon as the queue directory appears observe io_cpu as -1
(unbound) with managed=3D1 even when wq_unbound is false?

Also, during parallel reconnects in nvme_tcp_setup_io_queues(), a queue
with NVME_TCP_Q_IO_CPU_USER set does not re-increment
nvme_tcp_cpu_queues[io_cpu] until it reaches nvme_tcp_set_queue_io_cpu()
after completing the blocking TCP, TLS, and ICReq handshakes in
nvme_tcp_alloc_queue(). If a driver-managed queue finishes its handshake
first, could nvme_tcp_set_queue_io_cpu() pick a CPU without accounting for
the user-assigned queue's load?

Would it make sense to either call nvme_tcp_set_queue_io_cpu() before
nvme_tcp_add_queue_sysfs() in nvme_tcp_alloc_queue(), or defer
nvme_tcp_add_queue_sysfs() until after nvme_tcp_set_queue_io_cpu() has
run?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018010059.8312=
0-1-saravanand@crusoe.ai?part=3D2

