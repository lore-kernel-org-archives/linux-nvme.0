Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEE7EC1429
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 10:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jcb0lruLwTXSC5ez0bpWblqLuFGHwcYa05RTdv/1Lzc=; b=ujM+qxBznKBC+1MVbSeuqY2EAW
	5Ncz1dR1zwM66wzI5uynAvBwU66ALH9OjVPCFqIr5tpN651zMGpWIL8lTnWMwtQrVBRSqFyB0uxSX
	zo4gznqtAp0cNY81zZISCnDrkDp9fFxC9X3fqGOAr/whj2fkHnNl+mD3+A1BbHchp674ImW5dUzeY
	gJooC5CZuRAIQvAHj2CS0FPNyhhjv44Qf2bGTPCnRwzI5/f9mDsR5x9hg8AqSV4zaP0/K2wv69Dvn
	N3oIkbLcILLPRNhs89sAcTf9j6Fl9u/LJEv1KVm4kfF6rdu4/p5Oa1SA0duXuMnjh2xAzurUOhKb/
	wN8aJF0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxNTd-0000000F1bZ-456U;
	Tue, 03 Mar 2026 10:59:45 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxNTW-0000000F1YZ-1Pdd
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 10:59:44 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 0d520796 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Mar 2026 11:59:32 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Mar 2026 11:59:32 +0100
Message-Id: <DGT3F4OEHJB9.218JVJM25CWAV@arkamax.eu>
Subject: Re: [PATCH] nvmet-tcp: add bounds checks in
 nvmet_tcp_build_pdu_iovec
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Guenter Roeck" <linux@roeck-us.net>, "YunJe Shin"
 <yjshin0438@gmail.com>
Cc: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>,
 <gregkh@linuxfoundation.org>, "Christoph Hellwig" <hch@lst.de>,
 <security@kernel.org>, <sagi@grimberg.me>, "YunJe Shin"
 <ioerts@kookmin.ac.kr>, <joonkyoj@yonsei.ac.kr>
X-Mailer: aerc 0.21.0
References: <678f42fb-521e-4b5e-b662-331e424ca003@grimberg.me>
 <20260128004136.946596-1-ioerts@kookmin.ac.kr>
 <1bceff87-87ab-4ac7-9a1f-76c990171247@roeck-us.net>
In-Reply-To: <1bceff87-87ab-4ac7-9a1f-76c990171247@roeck-us.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_025938_722068_6B9E70B6 
X-CRM114-Status: GOOD (  19.28  )
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

On Wed Feb 25, 2026 at 9:06 PM CET, Guenter Roeck wrote:
> An experimental AI agent provided the following review feedback.
>
>  If we return early here (or in the other bounds checks added below),
>  cmd->recv_msg.msg_iter is left uninitialized because we skip the
>  iov_iter_bvec() call at the end of the function.
>
>  Since nvmet_tcp_build_pdu_iovec() returns void, callers are unaware
>  of the failure. For example, in nvmet_tcp_handle_h2c_data_pdu():
>
> 	nvmet_tcp_build_pdu_iovec(cmd);
> 	queue->cmd =3D cmd;
> 	queue->rcv_state =3D NVMET_TCP_RECV_DATA;
>
>  Even though nvmet_tcp_fatal_error() correctly sets rcv_state to
>  NVMET_TCP_RECV_ERR, the caller immediately overwrites it with
>  NVMET_TCP_RECV_DATA.
>
>  Does this cause the state machine to proceed and attempt to receive
>  data using the uninitialized cmd->recv_msg.msg_iter? Should this
>  function return an error code so callers can handle the failure?


In my opinion this is a valid concern.
I suspect that it's really possible to create a malicious sequence
that would make the target crash.

I would change nvmet_tcp_build_pdu_iovec() to return an error
code and its caller so they propagate it up to nvmet_tcp_done_recv_pdu()

Something like this:

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index acc71a26733f..3d97257075d3 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -351,7 +351,7 @@ static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp=
_cmd *cmd)

 static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue);

-static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
+static int nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 {
 	struct bio_vec *iov =3D cmd->iov;
 	struct scatterlist *sg;
@@ -364,22 +364,19 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tc=
p_cmd *cmd)
 	offset =3D cmd->rbytes_done;
 	cmd->sg_idx =3D offset / PAGE_SIZE;
 	sg_offset =3D offset % PAGE_SIZE;
-	if (!cmd->req.sg_cnt || cmd->sg_idx >=3D cmd->req.sg_cnt) {
-		nvmet_tcp_fatal_error(cmd->queue);
-		return;
-	}
+	if (!cmd->req.sg_cnt || cmd->sg_idx >=3D cmd->req.sg_cnt)
+		return -EPROTO;
+
 	sg =3D &cmd->req.sg[cmd->sg_idx];
 	sg_remaining =3D cmd->req.sg_cnt - cmd->sg_idx;

 	while (length) {
-		if (!sg_remaining) {
-			nvmet_tcp_fatal_error(cmd->queue);
-			return;
-		}
-		if (!sg->length || sg->length <=3D sg_offset) {
-			nvmet_tcp_fatal_error(cmd->queue);
-			return;
-		}
+		if (!sg_remaining)
+			return -EPROTO;
+
+		if (!sg->length || sg->length <=3D sg_offset)
+			return -EPROTO;
+
 		u32 iov_len =3D min_t(u32, length, sg->length - sg_offset);

 		bvec_set_page(iov, sg_page(sg), iov_len,
@@ -394,6 +391,7 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_=
cmd *cmd)

 	iov_iter_bvec(&cmd->recv_msg.msg_iter, ITER_DEST, cmd->iov,
 		      nr_pages, cmd->pdu_len);
+	return 0;
 }

 static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
@@ -931,7 +929,7 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queu=
e *queue)
 	return 0;
 }

-static void nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
+static int nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd, struct nvmet_req *req)
 {
 	size_t data_len =3D le32_to_cpu(req->cmd->common.dptr.sgl.length);
@@ -947,19 +945,19 @@ static void nvmet_tcp_handle_req_failure(struct nvmet=
_tcp_queue *queue,
 	if (!nvme_is_write(cmd->req.cmd) || !data_len ||
 	    data_len > cmd->req.port->inline_data_size) {
 		nvmet_prepare_receive_pdu(queue);
-		return;
+		return 0;
 	}

 	ret =3D nvmet_tcp_map_data(cmd);
 	if (unlikely(ret)) {
 		pr_err("queue %d: failed to map data\n", queue->idx);
 		nvmet_tcp_fatal_error(queue);
-		return;
+		return ret;
 	}

 	queue->rcv_state =3D NVMET_TCP_RECV_DATA;
-	nvmet_tcp_build_pdu_iovec(cmd);
 	cmd->flags |=3D NVMET_TCP_F_INIT_FAILED;
+	return nvmet_tcp_build_pdu_iovec(cmd);
 }

 static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
@@ -1011,7 +1009,8 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet=
_tcp_queue *queue)
 		goto err_proto;
 	}
 	cmd->pdu_recv =3D 0;
-	nvmet_tcp_build_pdu_iovec(cmd);
+	if (nvmet_tcp_build_pdu_iovec(cmd))
+		goto err_proto;
 	queue->cmd =3D cmd;
 	queue->rcv_state =3D NVMET_TCP_RECV_DATA;

@@ -1074,8 +1073,10 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_=
queue *queue)
 			le32_to_cpu(req->cmd->common.dptr.sgl.length),
 			le16_to_cpu(req->cqe->status));

-		nvmet_tcp_handle_req_failure(queue, queue->cmd, req);
-		return 0;
+		ret =3D nvmet_tcp_handle_req_failure(queue, queue->cmd, req);
+		if (unlikely(ret))
+			nvmet_tcp_fatal_error(queue);
+		return ret;
 	}

 	ret =3D nvmet_tcp_map_data(queue->cmd);
@@ -1092,8 +1093,10 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_=
queue *queue)
 	if (nvmet_tcp_need_data_in(queue->cmd)) {
 		if (nvmet_tcp_has_inline_data(queue->cmd)) {
 			queue->rcv_state =3D NVMET_TCP_RECV_DATA;
-			nvmet_tcp_build_pdu_iovec(queue->cmd);
-			return 0;
+			ret =3D nvmet_tcp_build_pdu_iovec(queue->cmd);
+			if (unlikely(ret))
+				nvmet_tcp_fatal_error(queue);
+			return ret;
 		}
 		/* send back R2T */
 		nvmet_tcp_queue_response(&queue->cmd->req);


Maurizio

