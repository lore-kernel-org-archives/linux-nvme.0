Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3945AC61DBD
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2026 02:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xLCheLjG9F/EP8loAps9XPSc04PPekeCu+0cjI0/ZsE=; b=Z+Mi/UMGd2FIiE6vjaFuomDzd8
	++odNK2VYVWVAFa8D6Bf5f+JeOQMzfHl+0wi9TV+g6RHnUSmFrPElI7VnB3Ip1x4Zdda11DyC9xrq
	VGaNsJ4hTIC6iC2n0g8QHfnlTw0jr3ZmGOmAfMyrd2pnika4sIHqYKZwBzmukpDBSI9R/5pBmoI3M
	p3AKFa4Lt9jaQyU8vOeHsEW0jn4lIumXWkzzhdwcSSHMHSiRk2dTmTejtbRN845YdLdJGin0N/kgv
	bv5h6fUPtUu+1K/qOy0Wdsi3x4IpflglAiOQZcPjuxMTRLQPZftsytkBFzRUzI/cIHQNhg4ZfaD8v
	q3QQlnaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz3YU-00000001nrq-0Zkh;
	Wed, 26 Aug 2026 02:39:58 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz3YR-00000001nrL-08jH
	for linux-nvme@lists.infradead.org;
	Wed, 26 Aug 2026 02:39:56 +0000
X-UUID: 68ddaf7ea0f711f19a56ed5b684f684d-20260826
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:2c452175-38b1-4e27-911a-106137048327,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:d184f2d287596130b25f736e7f823e22,BulkI
	D:nil,BulkQuantity:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 68ddaf7ea0f711f19a56ed5b684f684d-20260826
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1218028887; Wed, 26 Aug 2026 10:39:50 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, hare@suse.de, dwagner@suse.de, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v1 0/1] nvme-tcp: fix wrong status on deferred digest error
Date: Wed, 26 Aug 2026 10:15:00 +0800
Message-ID: <cover.nvme-tcp-req-status.v1.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260825_193955_392853_DBAD0463 
X-CRM114-Status: UNSURE (   8.48  )
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

Hi,

A C2HData digest error stores a host status code in the per-request
status field. Without DATA_SUCCESS the request is completed later from
the rsp path. That path used to pass the stored value straight into
complete, which expects CQE status field encoding and shifts right, so
DATA_XFER_ERROR could be reported as INVALID_FIELD.

This series keeps the per-request status as a host status code. On the
rsp path, shift left when a host error was already stored, otherwise use
the completion status field.

To hit the TCP DATA_XFER_ERROR path without DATA_SUCCESS, enable data
digest and temporarily change the target in
drivers/nvme/target/tcp.c, nvmet_setup_c2h_data_pdu, after the digest
is calculated:

  if (queue->data_digest) {
          pdu->hdr.flags |= NVME_TCP_F_DDGST;
          nvmet_tcp_calc_ddgst(cmd);
          cmd->exp_ddgst ^= cpu_to_le32(1);
  }

The default target path does not set DATA_SUCCESS on C2HData, so the
host stores the digest error and completes from the later rsp.

Verified on linux-next with an nvmet-tcp loopback target. Unpatched:

  nvme nvme0: data digest error: recv 0x2542708 expected 0x2542709
  nvme nvme0: Identify Controller failed (2)

Patched:

  nvme nvme0: data digest error: recv 0x7ebd5719 expected 0x7ebd5718
  nvme nvme0: Identify Controller failed (4)

Status code 0x2 is INVALID_FIELD. Status code 0x4 is DATA_XFER_ERROR.
recv and expected differ by one in both runs.

Thanks,
Xixin Liu

---

Xixin Liu (1):
  nvme-tcp: fix wrong status on deferred digest error

 drivers/nvme/host/tcp.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

-- 
2.53.0


