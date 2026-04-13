Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796F7E9380A
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Apr 2026 01:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:From:
	To:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HIgFlCTGhvg9igqdDCcCerVgAfeMs+cP/wv54/EWCOM=; b=jpoL20l/j0rnbURBoKM0hZlTyH
	X3EI5CCFvTrPqaQS1DNoRzKiRVWN6ZzyGHyrlX0zM9EZFqXSV7yxKGUi/lBTCNb30apNebIZYacgF
	LgumK9FFqtVBtIhBwD79sb0cpzGMbjC6Dt4UYgd1iodBnVo2XMEWy3qqbeaQqu/Pai/PCK5wV8vA3
	SYBB02xuLZxDhmcOUcU/6iVlfeYD/LZKFIxgxiPNAonuyYDED2ILc+W/hsJ8ajEUtJn82c7HxFQvK
	Ea8BCokPhBIOuhb6qJ077NIfbYmopHC4gzeeTU/DxMZhvJQN7E3fJ5M/zIKv4blSSEOw3zhBvw3BA
	6l3NNQSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wC6V1-0000000Er1d-0hCk;
	Mon, 13 Apr 2026 01:54:03 +0000
Received: from mail-244118.protonmail.ch ([109.224.244.118])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wC6Ux-0000000Er0g-3367
	for linux-nvme@lists.infradead.org;
	Mon, 13 Apr 2026 01:54:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1776045232; x=1776304432;
	bh=HIgFlCTGhvg9igqdDCcCerVgAfeMs+cP/wv54/EWCOM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZY4q7rT0dP9aOhlvYlQIYzo1BOF7UXms0PvLjbKL3xsSk7Q+SG17L5biVn24dLOY2
	 oiJnms7MRPR4TQfptWcQLpSxMs1Qt4BIYc6exrRykyMj674qeSHhpzwe4m/A62NIfL
	 8Rbj3bdvYbPY4X+JQomtu45gv2XQWRkdKmHN1Guj+dbKgzP9OH+RThBCdn4ZZWnRrR
	 YQlVCoP88BSzN+ewW+9lT/mEMpli6IyBSg0nK35loP7soO2KotqMHORHHLRnS4H7NU
	 SHwHQU7w7NEiBBaDIL9L3lYBI/5wguMLjUeFJZqIVE4WkjmyHBxN38sZVWZ3G6NczU
	 4kataNQwC//0A==
Date: Mon, 13 Apr 2026 01:53:47 +0000
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
From: Paul Moses <p@1g4.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Hannes Reinecke <hare@suse.de>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, "okorniev@redhat.com" <okorniev@redhat.com>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme: fix handling of tls alerts
Message-ID: <VGL4G3cfyG8s03AdVDAMOGsthbFIVqSeMjv7fcp7IM9ncScPJ8M9RoByY7u1s13Tx0sAqkucy-UjcC7GleS3jSJL2jX1Smsp9ok-yOu5RlI=@1g4.org>
In-Reply-To: <84c3b656-9406-4869-9214-aff1ee0f1607@nvidia.com>
References: <Ozwl9wDbyugg3Ytnr80omDUS6JPqCHgq_k8gkqtMIP2KbHBMt6CYRRMk6LKGOTNPwtj_wNimbH0mZiAe8-9zcRmS_UgArtcI6poZ1PZjMoU=@1g4.org> <2026041239-engross-edition-66eb@gregkh> <N8h5xrK8_cznpQNTzRIDl6Ofz_nN1Hvl1DVSXnL9rSR6zHyQGIPDKEDURE7uf2PgGOCe2jTRcEiamFmAzw-xhQPCBdbPoUu_BelZ8Mrzmg0=@1g4.org> <84c3b656-9406-4869-9214-aff1ee0f1607@nvidia.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: f13ae6ddd313bfc57c91f6f038c9ef5c02f8d452
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260412_185400_485041_0BC852DD 
X-CRM114-Status: GOOD (  14.57  )
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


>   (+linux-nvme)
>=20

>=20
> Hannes,
>=20
> can you look at the tls code and provide an input ?
>=20
> -ck
>=20

> Enclosed is only the splat and repro below, any patch I could produce wil=
l be
> derivative of Olga's, so I'll leave the opportunity to them or maintainer=
s.

> https://lore.kernel.org/stable/20250729164023.46643-4-okorniev@redhat.com=
/

Adding the missing context.

From previous conversions, it seemed plausible that a fix for this
already exists, so I decided to wait for more info.

I'll send the patch out properly with credit to Olga too, I don't
care. Would I put co-author in that case?

Thanks,=20
Paul

From 06f541d70f5f7efb832c466faeb4bd8f37936dad Mon Sep 17 00:00:00 2001
From: Paul Moses <p@1g4.org>
Date: Sun, 12 Apr 2026 01:02:07 -0500
Subject: [PATCH] nvmet-tcp: rewind kvec iterators before TLS alert parsing

nvmet_tcp_tls_record_ok() may call tls_alert_recv(), which reads
msg->msg_iter.kvec. The kvec-based receive paths in nvmet-tcp call
this after recvmsg has already advanced the iterator, so alert parsing
can read past the consumed segment.

Rewind the kvec iterator before parsing TLS alerts in the PDU, digest,
and peek receive paths. The inline data receive path uses a bvec-backed
iterator, so stop arming a control buffer there and fail the queue if a
TLS control message is reported while receiving inline data.

Fixes: a1c5dd8355b1 ("nvmet-tcp: control messages for recvmsg()")
---
 drivers/nvme/target/tcp.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index acc71a26733f..67591428ad23 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -120,7 +120,6 @@ struct nvmet_tcp_cmd {
 =09u32=09=09=09=09pdu_len;
 =09u32=09=09=09=09pdu_recv;
 =09int=09=09=09=09sg_idx;
-=09char=09=09=09=09recv_cbuf[CMSG_LEN(sizeof(char))];
 =09struct msghdr=09=09=09recv_msg;
 =09struct bio_vec=09=09=09*iov;
 =09u32=09=09=09=09flags;
@@ -1189,6 +1188,7 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_qu=
eue *queue)
 =09if (unlikely(len < 0))
 =09=09return len;
 =09if (queue->tls_pskid) {
+=09=09iov_iter_revert(&msg.msg_iter, len);
 =09=09ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
 =09=09if (ret < 0)
 =09=09=09return ret;
@@ -1245,19 +1245,22 @@ static void nvmet_tcp_prep_recv_ddgst(struct nvmet_=
tcp_cmd *cmd)
 static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 {
 =09struct nvmet_tcp_cmd  *cmd =3D queue->cmd;
-=09int len, ret;
+=09int len;
=20
 =09while (msg_data_left(&cmd->recv_msg)) {
 =09=09len =3D sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
 =09=09=09cmd->recv_msg.msg_flags);
+=09=09if (queue->tls_pskid &&
+=09=09    (cmd->recv_msg.msg_flags & MSG_CTRUNC)) {
+=09=09=09cmd->recv_msg.msg_flags &=3D ~(MSG_CTRUNC | MSG_EOR);
+=09=09=09if (len =3D=3D 0 || len =3D=3D -EIO) {
+=09=09=09=09pr_err("queue %d: unexpected TLS control message while receivi=
ng data\n",
+=09=09=09=09       queue->idx);
+=09=09=09=09return -EIO;
+=09=09=09}
+=09=09}
 =09=09if (len <=3D 0)
 =09=09=09return len;
-=09=09if (queue->tls_pskid) {
-=09=09=09ret =3D nvmet_tcp_tls_record_ok(cmd->queue,
-=09=09=09=09=09&cmd->recv_msg, cmd->recv_cbuf);
-=09=09=09if (ret < 0)
-=09=09=09=09return ret;
-=09=09}
=20
 =09=09cmd->pdu_recv +=3D len;
 =09=09cmd->rbytes_done +=3D len;
@@ -1295,6 +1298,7 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_=
queue *queue)
 =09if (unlikely(len < 0))
 =09=09return len;
 =09if (queue->tls_pskid) {
+=09=09iov_iter_revert(&msg.msg_iter, len);
 =09=09ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
 =09=09if (ret < 0)
 =09=09=09return ret;
@@ -1481,10 +1485,6 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queu=
e *queue,
 =09if (!c->r2t_pdu)
 =09=09goto out_free_data;
=20
-=09if (queue->state =3D=3D NVMET_TCP_Q_TLS_HANDSHAKE) {
-=09=09c->recv_msg.msg_control =3D c->recv_cbuf;
-=09=09c->recv_msg.msg_controllen =3D sizeof(c->recv_cbuf);
-=09}
 =09c->recv_msg.msg_flags =3D MSG_DONTWAIT | MSG_NOSIGNAL;
=20
 =09list_add_tail(&c->entry, &queue->free_list);
@@ -1764,6 +1764,7 @@ static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_qu=
eue *queue)
 =09=09return len;
 =09}
=20
+=09iov_iter_revert(&msg.msg_iter, len);
 =09ret =3D nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
 =09if (ret < 0)
 =09=09return ret;
--=20
2.53.GIT



