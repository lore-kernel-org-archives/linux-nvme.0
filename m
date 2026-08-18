Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE14C5DF7E
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2026 11:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=F00tHSyJsJ6CzdE6v/TT1V5MB6XClnKFlQNlIPg7vzw=; b=eMW+uOqlNb63Lh7JCjUVOhV3g3
	X3ZWXpXD2alxwxr2vJSuOTU2BAgDPVZ75K2Gg6w7AtGHBBSKs9SHLsfvAAKUdUpfVrsMX0VU5n6sZ
	OB1DS3KemGyJZS/TQEwM30wYIEgaZwxqQ8tGbfY8+TdHUdAFJfjGRMTAUzgwkM0FuBrTh58oS2z4G
	+nGetW4vU9/vmCrWiQODQGuUVqsTUDDuxiJTiasXrguWsU2bnxg+plZ2pg7XBktv6YVy0XpSA/uG1
	ynE4XlW3wFHGpv88nnn7IGe7OTOsTTD+Oik/ADhrmVCLgAECLuiY5QYnCyUdGDtFeZ3ONcVkNj80I
	TaAD1l7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwHdI-00000007oEZ-3Sdb;
	Tue, 18 Aug 2026 11:05:28 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwHdG-00000007oDo-0Ghs
	for linux-nvme@lists.infradead.org;
	Tue, 18 Aug 2026 11:05:28 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2cedda2ce6fso29376765ad.1
        for <linux-nvme@lists.infradead.org>; Tue, 18 Aug 2026 04:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1787051124; x=1787655924; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F00tHSyJsJ6CzdE6v/TT1V5MB6XClnKFlQNlIPg7vzw=;
        b=BkGvJk9ma7snUynbxkX3BUrGDqghGvTIv4h27W/WrgCMEclsOxfK2GoAd+YG0IzufP
         3XOJWi/6RFEUEUkjmG9DSdsaArOYQPTD0CrYwXcxVCHM6N/u/BMsosuXaol2RVOKKsIb
         S5z1yCYY3WaxJKf7vKskPh4GPvnRZKSfk/zc6E19q2Ds3gaws/hggH+bNfhwXJLjKhOj
         +5IO2khiwlelsg6n3hQE4vmSmqGN65wg2fEHZjwP2B2hUjFrB/mrB0Q5WFL7QpdyI30/
         1NuGYTUVDlcGFsFJviLgt8RGyAEl4AOcsjV+JHbSknK0NXyndmwNsKijAFA6glHzCZTT
         EH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787051124; x=1787655924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F00tHSyJsJ6CzdE6v/TT1V5MB6XClnKFlQNlIPg7vzw=;
        b=dnYv4hO0jirXyS+WzOeNoLnBTiFvTw/sDMSchNi1jwDKMNRm+WqYymVyGVETS2EZq/
         6QBoyIhNjc1Br1nHRPTJHq5mx0vbA33abxTfNOzzoNiHNxOu5tbyrIJgezpbri8/p3dn
         a6VgZTQn/cfWmcgfRLaeQEPuD6GGpGXaWvicsSQe7u4aTCYjVY+gfWZdgr+5939If5gz
         DzLaDnPTfWTw5WxotDfpcwtDyT0f2X1F3DjAEnadQ7Hq1KcuxPtwO9gV/bLmHWSfMeGO
         2jm7amm4lUktMilDNzPaUUSoEJkFAYkaQD1IrmycLNFKGd6g4KEiTvI+57/vDxRCLdZT
         qztQ==
X-Gm-Message-State: AOJu0Ywazk4r6qcx7hmLCIYRqzOqDPabi3KihC9FljP4Q0OlbJrV9P4r
	EZoz/O7VnjZhgwW7gDcwu4TY3wVBLKF80KI+uarKUChicgNAobh61T/3FI0scpf2WFbzPR+ZLwH
	pR92Wuno=
X-Gm-Gg: AR+sD12MUyaeNkcapkG9yRLn1+gI2C86lEV0mGP7cwckHnuXbqlq5SrNGn5c5Vh272x
	gRV7f4yijDRMsk6JxjH9tus5Lu/LefFnhwkqQI4AnWgPsmW2B0UGOLdZV27tTr9x6gAcpta+4vV
	rBWhnY3uCuPeRVUSPDj1+JbqmKAZXyuJnqAL+68ToN4/ID9XniHm2tN0O4J0LlyztslBZogT+Qr
	pEac9Crk2fArka0e1GRi9hrP/3j/Wvo5uIOsOpr2LWQzQPl5eoQDWB1SIzN2v+V8o4L0rkMgBaA
	jWv3TSElcxvp70Dl6RTJRsLK0ZFNpenDR1ydCC0QRp28gJv/YON225B3GkLlU08kEn6K89h/4sb
	0AO1VsEo/JS17Dt2xvoa/zNAfFw3boLPlqA6xTHlEhDegjylu8ShSdcBBLDQMO6Ri1Kqy9gvB+r
	ZP+H5VM6/tqodtApAmlaRDEAC91n2A36zCfitcWStlpwjK9nsD4tpHlEVlCkQ8LYnC2R4R
X-Received: by 2002:a17:903:2311:b0:2cf:afe8:b722 with SMTP id d9443c01a7336-2d5c5149013mr98394785ad.11.1787051123928;
        Tue, 18 Aug 2026 04:05:23 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bcf36500sm15298765ad.5.2026.08.18.04.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 04:05:23 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-tcp: check the data direction of a C2HData PDU
Date: Tue, 18 Aug 2026 20:04:05 +0900
Message-ID: <20260818110405.590548-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_040526_261736_125317DA 
X-CRM114-Status: GOOD (  21.37  )
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

nvme_tcp_handle_c2h_data() finds the request by command id and checks
that it has a payload, but it does not check that the command asked for
data to be read.  A controller that answers a write command with C2HData
therefore reaches nvme_tcp_recv_data(), where _copy_to_iter() hits
WARN_ON_ONCE(i->data_source) and returns 0.  The receive path turns that
into -EFAULT and resets the controller.

No data is copied, so this is not memory corruption.  What a controller
gets is a kernel warning it can raise at will, which is fatal on a host
booted with panic_on_warn.

The send path already knows the direction - it consults rq_data_dir()
when it builds a command - and nvme_tcp_handle_r2t() checks the length
and the offset of the request it names.  The C2HData path does not check
the direction at all.

Reject a C2HData PDU whose command is not a read.  Rejecting it fails
the command and resets the controller, as the neighbouring check in this
function does; what goes away is the warning.

  [    6.885580] ------------[ cut here ]------------
  [    6.886457] WARNING: lib/iov_iter.c:193 at _copy_to_iter+0x289/0x1330, CPU#0: kworker/0:1H/71
  [    6.888137] CPU: 0 UID: 0 PID: 71 Comm: kworker/0:1H Not tainted 7.2.0-rc5-NVMETCP-gf5098b6bae76 #1 PREEMPT(lazy) 
  [    6.891165] Workqueue: nvme_tcp_wq nvme_tcp_io_work
  [    6.891875] RIP: 0010:_copy_to_iter+0x289/0x1330
  [    6.903739] Call Trace:
  [    6.904085]  <TASK>
  [    6.909254]  __skb_datagram_iter+0x433/0x820
  [    6.911026]  skb_copy_datagram_iter+0x37/0x120
  [    6.911622]  nvme_tcp_recv_skb+0xa07/0x4320
  [    6.913378]  __tcp_read_sock+0x1ab/0x810
  [    6.915788]  nvme_tcp_try_recv+0x152/0x1e0
  [    6.918222]  nvme_tcp_io_work+0x1e4/0x6c0
  [    6.926906]  </TASK>
  [    6.927226] ---[ end trace 0000000000000000 ]---
  [    6.927878] nvme nvme0: queue 1 failed to copy request 0x71 data
  [    6.928709] nvme nvme0: receive failed:  -14

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
Applies on top of "nvme-tcp: do not accept C2HData based on
blk_rq_payload_bytes() alone".

Measured over a user-space target that answers every write with C2HData.
The warning appeared in 5 of 5 runs without this patch and in none of 5
with it, in each of three shapes: a buffered 8 KiB write, a 4 KiB write
carried in the command capsule, and a discard.  In every run the command
ids the target answered matched the ones the kernel named.  A conforming
target is unaffected over 5 runs each way, including writes and a
passthrough read, which rq_data_dir() classifies as a read.

Those runs were on 7.2-rc5 with this patch as the only change.  Repeating
the write, the in-capsule write and the conforming-target arms three
times each on the base this patch applies to - 7.2-rc5 plus that patch
and its predecessor - gave the same counts.

 drivers/nvme/host/tcp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 85a87ed6df936..a62d6e48f7190 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -679,6 +679,13 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 		return -ENOENT;
 	}
 
+	if (rq_data_dir(rq) != READ) {
+		dev_err(queue->ctrl->ctrl.device,
+			"queue %d tag %#x unexpected data for a write\n",
+			nvme_tcp_queue_id(queue), rq->tag);
+		return -EIO;
+	}
+
 	req = blk_mq_rq_to_pdu(rq);
 	if (!blk_rq_payload_bytes(rq) || !req->curr_bio || !req->data_len) {
 		dev_err(queue->ctrl->ctrl.device,
-- 
2.43.0


