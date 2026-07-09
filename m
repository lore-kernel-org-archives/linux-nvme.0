Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578A1C44501
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 13:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FG05wROpNXQ5A4NP/wpuFsj+niQ3vmP4S2MZMsiIHwM=; b=ieGxjBI2qIE8IjaMq6yF44JUrJ
	FsGwFUCxPLyYSWUYywoqiL63STCgnoohIn0aC5KgAc2liU0K5Gi2fHa46A0YxWIkbk8UJteJ2zcpZ
	R1wZtkRz11FAm1W5NSN8gU5xHAl2Zueyea2Jca/7CaQS4s6wEvxE3xx9miU1/xJmn1aJul7Etfu7G
	0k6HxnrxkbhypXzba8pfuYV6u0E4b+sIbe68fdjhrmGM8oM1R+21lYsFzlUjyWg3JOssGX5sJZDVf
	tuowHQxf1DQXijReP9CDiKNsgw8xzTIDbjmjxazpZfg5iYrMP4MErJziXykSTkOtoeT/UdEYU5Mxa
	uVe/Z/Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whol5-00000002Y3N-0Ul4;
	Thu, 09 Jul 2026 13:25:43 +0000
Received: from sender-op-o17.zoho.eu ([136.143.169.17])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whol2-00000002Y21-0DiZ
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 13:25:41 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1783603526; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=MBXmD6lprk+tzVYZPdbQk3D8DK77Kl2/5lbPZoKsjdbHXqZME713pqAfWYK9Urx4x0nV02faXVkxxvAupPewEpj+nULOBqjSRD3/bQs6zUJbx8CdjWgpzEMKxxreyPrzc+vEVp/LeRWThph5jBUFJ+Q0WqNM6ZLWr5HA3YbsuXo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783603526; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FG05wROpNXQ5A4NP/wpuFsj+niQ3vmP4S2MZMsiIHwM=; 
	b=ABPdxrMXJHFCX8PchEAo6ED19U/v8k4H/JHiQebS5q7bdQI9IftlrPN+MrtybNsWh3hWcw0UIKGYZdWDVqFn12FD2hWDLv5TG5j/FJqoOdVNKb6wo6TpuwvCc+cCKzveO8aU7k5mWIoUdVgRh2qApSUk79ilGxC5UBTzxCcFg/s=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783603526;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=FG05wROpNXQ5A4NP/wpuFsj+niQ3vmP4S2MZMsiIHwM=;
	b=FZZ/GhW5SqCGwcwWt73x18J081jcM3SJLzT+AcDZgjVmH1ue8vMFPKiyO8Rd+ZmT
	N0yxxJDf4UwtpVFR82F8fRDe/4FzfOxx8LyHvVosraM6W7ZrWwa/hk2s6uI/fAl6AbT
	UsJZJTIib3UL0E9H1HQW1p4se2/HLTibY6EXO46U=
Received: by mx.zoho.eu with SMTPS id 1783603523567628.0675131386766;
	Thu, 9 Jul 2026 15:25:23 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] nvmet-auth: fix uninitialized-memory leak in AUTH_RECEIVE
Date: Thu,  9 Jul 2026 15:25:20 +0200
Message-ID: <20260709132520.44160-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_062540_700752_F29A728D 
X-CRM114-Status: GOOD (  18.74  )
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

nvmet_execute_auth_receive() allocates its response buffer with the
attacker-controlled AUTH_RECEIVE `al` (data length) field:

    al = nvmet_auth_receive_data_len(req);
    ...
    d = kmalloc(al, GFP_KERNEL);
    ...
    switch (req->sq->dhchap_step) {
    case NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE:
            nvmet_auth_challenge(req, d, al);
    ...
    status = nvmet_copy_to_sgl(req, 0, d, al);

nvmet_check_transfer_len() only enforces al == req->transfer_len, a
pure equality check with no upper bound tied to the message actually
being produced. nvmet_auth_challenge() computes its own data_size
(sizeof(challenge header) + hash_len, 48 bytes for SHA-256 with no DH
group) and only checks "al < data_size" as a floor -- it memset()s and
fills exactly data_size bytes of the buffer. The same pattern applies
to nvmet_auth_success1()/nvmet_auth_failure1(), which only memset()
sizeof(*data) bytes of `d`.

Whichever handler runs, nvmet_execute_auth_receive() then streams the
entire al-byte buffer back to the remote host with
nvmet_copy_to_sgl(req, 0, d, al). Since a remote NVMe-oF/TCP host
chooses `al` and can set it far larger than data_size (e.g. 4096 vs.
48), the tail [data_size, al) of the kmalloc()'d buffer is returned to
the peer without ever having been written by the kernel -- a remote,
pre-authentication disclosure of uninitialized kernel heap contents,
confirmed with KASAN by planting a marker byte in
a freed kmalloc-4096 object and observing it echoed back in the tail
of the CHALLENGE response. This is reachable as soon as
CONFIG_NVME_TARGET_AUTH is enabled (the default on Fedora/RHEL/Ubuntu
distro kernels) and a subsystem uses/allows the DH-CHAP auth path; no
secret needs to be proven first, since the leak occurs on the
CHALLENGE step of the handshake.

Fix it the same way nvmet_execute_disc_get_log_page() already handles
an analogous host-controlled-length response buffer
(drivers/nvme/target/discovery.c: "buffer = kzalloc(alloc_len,
GFP_KERNEL);"): zero the allocation up front instead of only zeroing
the sub-range each per-step helper happens to fill. This keeps the fix
to a single line, covers all three dhchap_step handlers that share
this buffer and the common copy-back site (CHALLENGE, SUCCESS1,
FAILURE1), and does not change the wire format, the transfer-length
checks, or any success/error paths.

Testing: the uninitialized-tail disclosure itself was confirmed live
under KASAN before this fix, by planting a marker byte in a freed
kmalloc-4096 object and observing it (or other live heap bytes)
echoed back in the CHALLENGE response tail; a CONTROL request with
al == data_size returned no such tail on every run, and an EXPLOIT
request with al = 4096 leaked up to 4048 bytes of stale heap on two
separate runs. The fix itself is verified by code inspection rather
than a fresh KASAN run: kzalloc() zeroes the whole al-byte allocation
before any dhchap_step handler executes, so the tail past whatever
bytes a handler's own memset()/fill writes is guaranteed zero instead
of leftover slab content, for all three handlers and the single
shared nvmet_copy_to_sgl() copy-back site. Re-running the KASAN
harness against a kernel built with this patch to reconfirm a
zero tail is currently blocked by an nvme-tcp loopback livelock in
the test stand; a controlled A/B check showed the same livelock on
the unpatched baseline as well, so it is a pre-existing harness
limitation, not something introduced by this one-line kzalloc()
change.

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
 drivers/nvme/target/fabrics-cmd-auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 45820a12750d..2b617d3b8bba 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -557,7 +557,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 		return;
 	}
 
-	d = kmalloc(al, GFP_KERNEL);
+	d = kzalloc(al, GFP_KERNEL);
 	if (!d) {
 		status = NVME_SC_INTERNAL;
 		goto done;
-- 
2.50.1 (Apple Git-155)


