Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC95C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 23:40:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 787BB613FB
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 23:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787BB613FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0RWLX3qVFiym55KGlto8Inh6fzNKCT83l6axhO//5kg=; b=e/gVmM3KXUY/WeoRLB6Wj2zP7
	xt13Dt/FzbXYz/yVDk4nlvl+dyjSU9DEnNnn4UkicssfNDYMcHaf+3Bl6qJ7wIiEdPvkmBC34p8yY
	H9hhS7OOXZrjSu8MnG1VRYiKKgJYu6rzHzqVzdniKAJ1JAwRzH72N0GCMi5N97EX2wWAstMtYCjf+
	07lpKxoMsCfgpm53h65fBy3u2vqNT/trDD3OpZjKIQRkJes6qh+TXFmAfC7mgv0R1lmcw/OxOKFIa
	jFXzikygGVcxRqBmeXT4C4BmgDZL06Z154TKeJfdJ0s5Hpc1cYiqRETEbEHDqgTKGiH1gFvOjm11V
	669YXG84g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbXJJ-002Qev-Ir; Tue, 27 Apr 2021 23:40:09 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbXJH-002Qem-MA
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 23:40:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=EneL1/ORY+URGP3zWWphwgNM2YTeThiul4iVkQXgXPI=; b=eV9NDvjB/YhXna1qoBGFzs6WbV
 dpGispTsOsJenUCvT6Umbc2LwSrVLXP+u+uBGT1QMmmIR3dAMVj6ARB+/StmpscjVhNJG5geJmr2K
 wwwVFI123ZIJzbd9ImwtxS7DKyXmwfLQaNGN3w99/fjHeZbJHqDfJKQ1GDilxbGvhZVLF3vGZ5rzD
 02fNl0NeAIn9nZCRG/hIkzMW8WiAhXNZzlunbJA3nd4xc34XtsYInTy54cs54YeHxIDhMUgjPJ9ex
 zXE6XNkZ9d2EqqkMc/s6E9O/zyCvJwDdIzFTDMXBtwY/SJC6777iHNlXFBlPill734YgMLQSpqXTv
 Uc07lKUQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbXJE-00H66T-7m
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 23:40:06 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33F72613FB;
 Tue, 27 Apr 2021 23:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619566800;
 bh=Urzu+W521fAue242Uh9l0IFl7bbNpMTes93MPo25vPk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=P7jM7/US8HnwfG3396eq6xflWn+ruD0DO+pJIU8nYXydkha9sQw7u6y0zpuxw8MTp
 kf8NBN0HXbyXF+ADNWE09Lt0scaqOzLYavZlknkTmPLw0zk+55DbJSGUPrFtNmLrTo
 4a4X2r/jUAvImfpQ+3zQItZwY/RWZJZbwkROK4qZFb3RGoItkHwhcdW1HLnX/6RwEH
 9XueBl70BC9IxiE5he7ExRm/0/v+FgsUu2SOeu3cH3STtPVce3U1fK7VsDh6h0yRNt
 VyRpHdu7Zh9oaNc79XGjHWGIVmoQUzDcLDOSxQDj/QYOYO7dQ5hwPZT5Y4pi4FeJhg
 SG36MlK+nMKsw==
Date: Tue, 27 Apr 2021 16:39:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: nvme tcp receive errors
Message-ID: <20210427233956.GA631292@dhcp-10-100-145-180.wdc.com>
References: <20210331161825.GC23886@redsun51.ssa.fujisawa.hgst.com>
 <0976ff40-751e-cb95-429a-04ffa229ebf0@grimberg.me>
 <20210331204958.GD23886@redsun51.ssa.fujisawa.hgst.com>
 <20210402171141.GA1944994@dhcp-10-100-145-180.wdc.com>
 <53a11feb-bc49-d384-3b7b-481a0dfc70e6@grimberg.me>
 <20210405143702.GA20598@redsun51.ssa.fujisawa.hgst.com>
 <20210407195319.GA30623@redsun51.ssa.fujisawa.hgst.com>
 <8d8c5c82-f1d3-5599-ae3e-5af5ff12eb9d@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8d8c5c82-f1d3-5599-ae3e-5af5ff12eb9d@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_164004_371339_02CBF87A 
X-CRM114-Status: GOOD (  45.15  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Apr 09, 2021 at 02:38:38PM -0700, Sagi Grimberg wrote:
> 
> > > > > > This was observed on the recent 5.12-rc4, so it has all the latest tcp
> > > > > > fixes. I'll check with reverting 0dc9edaf80ea and see if that makes a
> > > > > > difference. It is currently reproducible, though it can take over an
> > > > > > hour right now.
> > > > > 
> > > > > After reverting 0dc9edaf80ea, we are observing a kernel panic (below).
> > > > 
> > > > Ah, that's probably because WRITE_ZEROS are not set with RQF_SPECIAL..
> > > > This patch is actually needed.
> > > > 
> > > > 
> > > > > We'll try adding it back, plust adding your debug patch.
> > > > 
> > > > Yes, that would give us more info about what is the state the
> > > > request is in when getting these errors
> > > 
> > > We have recreated with your debug patch:
> > > 
> > >    nvme nvme4: queue 6 no space in request 0x1 no space cmd_state 3
> > > 
> > > State 3 corresponds to the "NVME_TCP_CMD_DATA_DONE".
> > > 
> > > The summary from the test that I received:
> > > 
> > >    We have an Ethernet trace for this failure. I filtered the trace for the
> > >    connection that maps to "queue 6 of nvme4" and tracked the state of the IO
> > >    command with Command ID 0x1 ("Tag 0x1"). The sequence for this command per
> > >    the Ethernet trace is:
> > > 
> > >     1. The target receives this Command in an Ethernet frame that has  9 Command
> > >        capsules and a partial H2CDATA PDU. The Command with ID 0x1 is a Read
> > >        operation for 16K IO size
> > >     2. The target sends 11 frames of C2HDATA PDU's each with 1416 bytes and one
> > >        C2HDATA PDU with 832 bytes to complete the 16K transfer. LAS flag is set
> > >        in the last PDU.
> > >     3. The target sends a Response for this Command.
> > >     4. About 1.3 ms later, the Host logs this msg and closes the connection.
> > > 
> > > Please let us know if you need any additional information.
> > 
> > I'm not sure if this is just a different symptom of the same problem,
> > but with the debug patch, we're occasionally hitting messages like:
> > 
> >    nvme nvme5: req 8 r2t len 16384 exceeded data len 16384 (8192 sent) cmd_state 2
> 
> According to this message, this means the host got an r2t for 16384
> bytes after it already sent 8192 (which can only happen if it previously
> got an r2t soliciting 8192 bytes or more that accumulate to that). Can
> you share for each r2t pdus in this sequence:
> r2t_length
> r2t_offset

This one took a bit to go through. The traces all only have a single r2t
pdu with 0 offset for the full length of the requested transfer. I had
to add trace events to see what the heck the driver is thinking, and
the result is even more confusing.

The kernel message error:

    nvme5: req 5 op 1 r2t len 16384 exceeded data len 16384 (4096 sent)

And all the new trace events for this request are:

    fio-25086   [011] ....  9630.542669: nvme_tcp_queue_rq: nvme5: qid=4 tag=5 op=1 data_len=16384
    fio-25093   [007] ....  9630.542854: nvme_tcp_cmd_pdu: nvme5: qid=4 tag=5 op=1 page_offset=3664 send_len=72
    <...>-22670 [003] ....  9630.544377: nvme_tcp_r2t: nvme5: qid=4 tag=5 op=1 r2t_len=16384 r2t_offset=0 data_sent=4096 data_len=16384

The fact "data_sent" is non-zero on the very first r2t makes no sense to me.
I so far can not find any sequence where that could happen.

Here's the tracepoints patch (I think something like this is worthy of being
included in the driver):

---
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9c1f3d273fcf..931197fa4ef4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -141,6 +141,9 @@ struct nvme_tcp_ctrl {
 	u32			io_queues[HCTX_MAX_TYPES];
 };
 
+#define CREATE_TRACE_POINTS
+#include "trace-tcp.h"
+
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
 static struct workqueue_struct *nvme_tcp_wq;
@@ -582,10 +585,13 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
 	struct request *rq = blk_mq_rq_from_pdu(req);
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	u8 ddgst = nvme_tcp_ddgst_len(queue);
+	unsigned r2t_offset = le32_to_cpu(pdu->r2t_offset);
 
 	req->pdu_len = le32_to_cpu(pdu->r2t_length);
 	req->pdu_sent = 0;
 
+	trace_nvme_tcp_r2t(rq, req, r2t_offset);
+
 	if (unlikely(!req->pdu_len)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"req %d r2t len is %u, probably a bug...\n",
@@ -595,17 +601,16 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
 
 	if (unlikely(req->data_sent + req->pdu_len > req->data_len)) {
 		dev_err(queue->ctrl->ctrl.device,
-			"req %d r2t len %u exceeded data len %u (%zu sent)\n",
-			rq->tag, req->pdu_len, req->data_len,
-			req->data_sent);
+			"req %d op %d r2t len %u exceeded data len %u (%zu sent) pdu offset %u\n",
+			rq->tag, req_op(rq), req->pdu_len, req->data_len,
+			req->data_sent, r2t_offset);
 		return -EPROTO;
 	}
 
-	if (unlikely(le32_to_cpu(pdu->r2t_offset) < req->data_sent)) {
+	if (unlikely(r2t_offset < req->data_sent)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"req %d unexpected r2t offset %u (expected %zu)\n",
-			rq->tag, le32_to_cpu(pdu->r2t_offset),
-			req->data_sent);
+			rq->tag, r2t_offset, req->data_sent);
 		return -EPROTO;
 	}
 
@@ -943,6 +948,7 @@ static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
 static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 {
 	struct nvme_tcp_queue *queue = req->queue;
+	struct request *rq = blk_mq_rq_from_pdu(req);
 
 	while (true) {
 		struct page *page = nvme_tcp_req_cur_page(req);
@@ -956,6 +962,7 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 		else
 			flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
 
+		trace_nvme_tcp_data(rq, req, offset, len, last);
 		if (sendpage_ok(page)) {
 			ret = kernel_sendpage(queue->sock, page, offset, len,
 					flags);
@@ -977,9 +984,9 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 				nvme_tcp_ddgst_final(queue->snd_hash,
 					&req->ddgst);
 				req->state = NVME_TCP_SEND_DDGST;
-				req->cmd_state = NVME_TCP_CMD_DATA_DONE;
 				req->offset = 0;
 			} else {
+				req->cmd_state = NVME_TCP_CMD_DATA_DONE;
 				nvme_tcp_done_send_req(queue);
 			}
 			return 1;
@@ -996,7 +1003,8 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	int len = sizeof(*pdu) + hdgst - req->offset;
 	int flags = MSG_DONTWAIT;
-	int ret;
+	struct request *rq = blk_mq_rq_from_pdu(req);
+	int offset, ret;
 
 	if (inline_data || nvme_tcp_queue_more(queue))
 		flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
@@ -1006,8 +1014,10 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 	if (queue->hdr_digest && !req->offset)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
-	ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
-			offset_in_page(pdu) + req->offset, len,  flags);
+	offset = offset_in_page(pdu) + req->offset;
+	trace_nvme_tcp_cmd_pdu(rq, req, offset, len);
+	ret = kernel_sendpage(queue->sock, virt_to_page(pdu), offset,
+			len,  flags);
 	if (unlikely(ret <= 0))
 		return ret;
 
@@ -1034,14 +1044,16 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 	struct nvme_tcp_data_pdu *pdu = req->pdu;
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	int len = sizeof(*pdu) - req->offset + hdgst;
-	int ret;
+	struct request *rq = blk_mq_rq_from_pdu(req);
+	int offset, ret;
 
 	if (queue->hdr_digest && !req->offset)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
-	ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
-			offset_in_page(pdu) + req->offset, len,
-			MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
+	offset = offset_in_page(pdu) + req->offset;
+	trace_nvme_tcp_h2c_pdu(rq, req, offset, len);
+	ret = kernel_sendpage(queue->sock, virt_to_page(pdu), offset,
+			len, MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
 	if (unlikely(ret <= 0))
 		return ret;
 
@@ -2367,6 +2379,7 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (!nvmf_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
 		return nvmf_fail_nonready_command(&queue->ctrl->ctrl, rq);
 
+	trace_nvme_tcp_queue_rq(rq);
 	ret = nvme_tcp_setup_cmd_pdu(ns, rq);
 	if (unlikely(ret))
 		return ret;
diff --git a/drivers/nvme/host/trace-tcp.h b/drivers/nvme/host/trace-tcp.h
new file mode 100644
index 000000000000..0fc8f4c51ee2
--- /dev/null
+++ b/drivers/nvme/host/trace-tcp.h
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM nvme_tcp
+
+#if !defined(_TRACE_NVME_TCP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_NVME_TCP_H
+
+#include <linux/nvme.h>
+#include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+
+#include "nvme.h"
+
+TRACE_EVENT(nvme_tcp_queue_rq,
+	TP_PROTO(struct request *rq),
+	TP_ARGS(rq),
+	TP_STRUCT__entry(
+		__field(unsigned, ctrl_id)
+		__field(unsigned, qid)
+		__field(unsigned, op)
+		__field(unsigned, tag)
+		__field(unsigned, len)
+	),
+	TP_fast_assign(
+		__entry->ctrl_id = nvme_req(rq)->ctrl->instance;
+		__entry->qid = nvme_req_qid(rq);
+		__entry->op = req_op(rq);
+		__entry->tag = rq->tag;
+		__entry->len = blk_rq_payload_bytes(rq);
+	),
+	TP_printk("nvme%u: qid=%u tag=%x op=%x data_len=%u",
+		__entry->ctrl_id, __entry->qid, __entry->tag, __entry->op,
+		__entry->len
+	)
+);
+
+TRACE_EVENT(nvme_tcp_cmd_pdu,
+	TP_PROTO(struct request *rq, struct nvme_tcp_request *req, unsigned offset, unsigned len),
+	TP_ARGS(rq, req, offset, len),
+	TP_STRUCT__entry(
+		__field(unsigned, ctrl_id)
+		__field(unsigned, qid)
+		__field(unsigned, op)
+		__field(unsigned, tag)
+		__field(unsigned, page_offset)
+		__field(unsigned, len)
+	),
+	TP_fast_assign(
+		__entry->ctrl_id = nvme_req(rq)->ctrl->instance;
+		__entry->qid = nvme_req_qid(rq);
+		__entry->op = req_op(rq);
+		__entry->tag = rq->tag;
+		__entry->page_offset = offset;
+		__entry->len = len;
+	),
+	TP_printk("nvme%u: qid=%u tag=%x op=%x page_offset=%u send_len=%u",
+		__entry->ctrl_id, __entry->qid, __entry->tag, __entry->op,
+		__entry->page_offset, __entry->len
+	)
+);
+
+TRACE_EVENT(nvme_tcp_h2c_pdu,
+	TP_PROTO(struct request *rq, struct nvme_tcp_request *req, unsigned offset, unsigned len),
+	TP_ARGS(rq, req, offset, len),
+	TP_STRUCT__entry(
+		__field(unsigned, ctrl_id)
+		__field(unsigned, qid)
+		__field(unsigned, op)
+		__field(unsigned, tag)
+		__field(unsigned, page_offset)
+		__field(unsigned, len)
+	),
+	TP_fast_assign(
+		__entry->ctrl_id = nvme_req(rq)->ctrl->instance;
+		__entry->qid = nvme_req_qid(rq);
+		__entry->op = req_op(rq);
+		__entry->tag = rq->tag;
+		__entry->page_offset = offset;
+		__entry->len = len;
+	),
+	TP_printk("nvme%u: qid=%u tag=%x op=%x page_offset=%u send_len=%u",
+		__entry->ctrl_id, __entry->qid, __entry->tag, __entry->op,
+		__entry->page_offset, __entry->len
+	)
+);
+
+TRACE_EVENT(nvme_tcp_data,
+	TP_PROTO(struct request *rq, struct nvme_tcp_request *req, unsigned offset, unsigned len, bool last),
+	TP_ARGS(rq, req, offset, len, last),
+	TP_STRUCT__entry(
+		__field(unsigned, ctrl_id)
+		__field(unsigned, qid)
+		__field(unsigned, op)
+		__field(unsigned, tag)
+		__field(unsigned, page_offset)
+		__field(unsigned, len)
+		__field(unsigned, sent)
+		__field(bool, last)
+	),
+	TP_fast_assign(
+		__entry->ctrl_id = nvme_req(rq)->ctrl->instance;
+		__entry->qid = nvme_req_qid(rq);
+		__entry->op = req_op(rq);
+		__entry->tag = rq->tag;
+		__entry->page_offset = offset;
+		__entry->len = len;
+		__entry->sent = req->pdu_sent;
+		__entry->last = last;
+	),
+	TP_printk("nvme%u: qid=%u tag=%x op=%x page_offset=%u send_len=%u pdu_sent=%u last=%u",
+		__entry->ctrl_id, __entry->qid, __entry->tag, __entry->op,
+		__entry->page_offset, __entry->len, __entry->sent, __entry->last
+	)
+);
+
+TRACE_EVENT(nvme_tcp_r2t,
+	TP_PROTO(struct request *rq, struct nvme_tcp_request *req, unsigned offset),
+	TP_ARGS(rq, req, offset),
+	TP_STRUCT__entry(
+		__field(unsigned, ctrl_id)
+		__field(unsigned, qid)
+		__field(unsigned, op)
+		__field(unsigned, tag)
+		__field(unsigned, len)
+		__field(unsigned, offset)
+		__field(unsigned, sent)
+		__field(unsigned, data_len)
+	),
+	TP_fast_assign(
+		__entry->ctrl_id = nvme_req(rq)->ctrl->instance;
+		__entry->qid = nvme_req_qid(rq);
+		__entry->op = req_op(rq);
+		__entry->tag = rq->tag;
+		__entry->len = req->pdu_len;
+		__entry->offset = offset;
+		__entry->sent = req->data_sent;
+		__entry->data_len = req->data_len;
+	),
+	TP_printk("nvme%u: qid=%u tag=%x op=%x r2t_len=%u r2t_offset=%u data_sent=%u data_len=%u",
+		__entry->ctrl_id, __entry->qid, __entry->tag, __entry->op,
+		__entry->len, __entry->offset, __entry->sent, __entry->data_len
+	)
+);
+
+#endif /* _TRACE_NVME_TCP_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace-tcp
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
