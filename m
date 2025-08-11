Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296CACA0ECD
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Aug 2025 15:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fo/fHA7V1dcXf1yHjCu5EFkjKN1ecjhKsoSvyz2n3r0=; b=OydJ3hCk5wzIFrpDhMbh2EZuMx
	dq3dSohwy241JJWTtJ4SMsQeDPKUyFowKuYKBxT7czc/bvQbSdPjy56icbXuw5mBWu6iA8q/l7Z6y
	ZW9pHxpPtSeKsw8oa1zHfXy9hqQkgkTiy6r12Gwko78KCW1J3AkYqltoU7kuRChq7Cg+2h/+3tShN
	0i01B68JepwMJajaAu5laqDhA6SrtK4JSjTvrqQJ2ouq9ZFvNqYPJ2m2J6+vYsvqqxpwJwxZozqE8
	xldbFrfxeQY5/jpgiWAluIYkK8sJ4jFGIbynqMqR2Q/N0OmUWkV+mSOO3j2PFdQ2qelXBI33T006C
	t956WmHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulUl1-00000008G61-0sej;
	Mon, 11 Aug 2025 15:48:19 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulTEG-00000007xva-1Shs
	for linux-nvme@lists.infradead.org;
	Mon, 11 Aug 2025 14:10:26 +0000
Received: from localhost (termgej0-6.customer.nettuno.it [193.207.170.238])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 8f219a75 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Aug 2025 16:10:19 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Aug 2025 16:10:17 +0200
Message-Id: <DBZNQ1EWLBXF.3I29UKEZYHRXX@bsdbackstore.eu>
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Hannes Reinecke" <hare@suse.de>, "Yi Zhang" <yi.zhang@redhat.com>,
 "linux-block" <linux-block@vger.kernel.org>, "open list:NVM EXPRESS DRIVER"
 <linux-nvme@lists.infradead.org>
Cc: "Shinichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, "Maurizio Lombardi"
 <mlombard@redhat.com>
Subject: Re: [bug report] blktests nvme/tcp nvme/060 hang
X-Mailer: aerc
References: <CAHj4cs-zu7eVB78yUpFjVe2UqMWFkLk8p+DaS3qj+uiGCXBAoA@mail.gmail.com> <a2aac6f2-9389-404e-9f5d-b71ead2af0fe@suse.de>
In-Reply-To: <a2aac6f2-9389-404e-9f5d-b71ead2af0fe@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_071024_734430_D97F18A3 
X-CRM114-Status: UNSURE (   9.88  )
X-CRM114-Notice: Please train this message.
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

On Wed Aug 6, 2025 at 12:52 PM CEST, Hannes Reinecke wrote:
> On 8/6/25 03:57, Yi Zhang wrote:
>> tgid:1049  ppid:2      task_flags:0x4208060 flags:0x00000010
>> [  390.467850] Workqueue: nvme-wq nvme_tcp_reconnect_ctrl_work [nvme_tcp=
]
>> [  390.474378] Call trace:
>> [  390.476813]  __switch_to+0x1d8/0x330 (T)
>> [  390.480731]  __schedule+0x860/0x1c30
>> [  390.484297]  schedule_rtlock+0x30/0x70
>> [  390.488037]  rtlock_slowlock_locked+0x464/0xf60
>> [  390.492559]  rt_read_lock+0x2bc/0x3e0
>> [  390.496211]  nvmet_tcp_listen_data_ready+0x3c/0x118 [nvmet_tcp]
>> [  390.502125]  nvmet_tcp_data_ready+0x88/0x198 [nvmet_tcp]
>> [  390.507429]  tcp_data_ready+0xdc/0x3e0
>> [  390.511171]  tcp_data_queue+0xe30/0x1e08
>> [  390.515084]  tcp_rcv_established+0x710/0x2328
>> [  390.519432]  tcp_v4_do_rcv+0x554/0x940
>> [  390.523172]  tcp_v4_rcv+0x1ec4/0x3078
>> [  390.526825]  ip_protocol_deliver_rcu+0xc0/0x3f0
>> [  390.531347]  ip_local_deliver_finish+0x2d4/0x5c0
>> [  390.535954]  ip_local_deliver+0x17c/0x3c0
>> [  390.539953]  ip_rcv_finish+0x148/0x238
>> [  390.543693]  ip_rcv+0xd0/0x2e0
>> [  390.546737]  __netif_receive_skb_one_core+0x100/0x180
>> [  390.551780]  __netif_receive_skb+0x2c/0x160
>> [  390.555953]  process_backlog+0x230/0x6f8
>> [  390.559866]  __napi_poll.constprop.0+0x9c/0x3e8
>> [  390.564386]  net_rx_action+0x808/0xb50
>> [  390.568125]  handle_softirqs.constprop.0+0x23c/0xca0
>> [  390.573082]  __local_bh_enable_ip+0x260/0x4f0
>> [  390.577429]  __dev_queue_xmit+0x6f4/0x1bd8
>> [  390.581515]  neigh_hh_output+0x190/0x2c0
>> [  390.585429]  ip_finish_output2+0x7c8/0x1788
>> [  390.589602]  __ip_finish_output+0x2c4/0x4f8
>> [  390.593776]  ip_finish_output+0x3c/0x2a8
>> [  390.597689]  ip_output+0x154/0x418
>> [  390.601081]  __ip_queue_xmit+0x580/0x1108
>> [  390.605081]  ip_queue_xmit+0x4c/0x78
>> [  390.608647]  __tcp_transmit_skb+0xfac/0x24e8
>> [  390.612908]  tcp_write_xmit+0xbec/0x3078
>> [  390.616821]  __tcp_push_pending_frames+0x90/0x2b8
>> [  390.621515]  tcp_send_fin+0x108/0x9a8
>> [  390.625167]  tcp_shutdown+0xd8/0xf8
>> [  390.628646]  inet_shutdown+0x14c/0x2e8
>> [  390.632385]  kernel_sock_shutdown+0x5c/0x98
>> [  390.636560]  __nvme_tcp_stop_queue+0x44/0x220 [nvme_tcp]
>> [  390.641865]  nvme_tcp_stop_queue_nowait+0x130/0x200 [nvme_tcp]
>> [  390.647691]  nvme_tcp_setup_ctrl+0x3bc/0x728 [nvme_tcp]
>> [  390.652909]  nvme_tcp_reconnect_ctrl_work+0x78/0x290 [nvme_tcp]
>> [  390.658822]  process_one_work+0x80c/0x1a78
>> [  390.662910]  worker_thread+0x6d0/0xaa8
>> [  390.666650]  kthread+0x304/0x3a0
>> [  390.669869]  ret_from_fork+0x10/0x20
>> [  390.673437] task:kworker/u322:77 state:D stack:27184 pid:4784
>> tgid:4784  ppid:2      task_flags:0x4208060 flags:0x00000210
>> [  390.684562] Workqueue: nvmet-wq nvmet_tcp_release_queue_work [nvmet_t=
cp]
>> [  390.691256] Call trace:
>> [  390.693692]  __switch_to+0x1d8/0x330 (T)
>> [  390.697605]  __schedule+0x860/0x1c30
>> [  390.701171]  schedule_rtlock+0x30/0x70
>> [  390.704911]  rwbase_write_lock.constprop.0.isra.0+0x2fc/0xb30
>> [  390.710646]  rt_write_lock+0x9c/0x138
>> [  390.714299]  nvmet_tcp_release_queue_work+0x168/0xb48 [nvmet_tcp]
>> [  390.720384]  process_one_work+0x80c/0x1a78
>> [  390.724470]  worker_thread+0x6d0/0xaa8
>> [  390.728210]  kthread+0x304/0x3a0
>> [  390.731428]  ret_from_fork+0x10/0x20
>>=20
>>=20
> Can you check if this fixes the problem?
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 688033b88d38..23bdce8dcdf0 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1991,15 +1991,13 @@ static void nvmet_tcp_listen_data_ready(struct=20
> sock *sk)
>          struct nvmet_tcp_port *port;
>
>          trace_sk_data_ready(sk);
> +       if (sk->sk_state !=3D TCP_LISTEN)
> +               return;
>
>          read_lock_bh(&sk->sk_callback_lock);
>          port =3D sk->sk_user_data;
> -       if (!port)
> -               goto out;
> -
> -       if (sk->sk_state =3D=3D TCP_LISTEN)
> +       if (port)
>                  queue_work(nvmet_wq, &port->accept_work);
> -out:
>          read_unlock_bh(&sk->sk_callback_lock);
>   }


Hannes,

are you going to send a formal patch?
In case you missed it, the patch is confirmed to work.

Thanks,
Maurizio


