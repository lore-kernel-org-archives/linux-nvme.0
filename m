Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E68D26293
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jan 2026 19:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2toW5blsnA7RcEXEjNfuEbhMouSI7kVVmotrjenAV6A=; b=3m6ZJr53FHJtLCELzeCYzC8jKx
	Bo6abFrvDv+fdaT5M/Hd6UbvUxrkZEP2hVg2WcogwA/mPPEoxvG3LxjsWzHiOMlM+oLDd3BGmfeNP
	SWomoUReN9xVgwmHTLZ07j3wQ7gfegztO5N3r/tHEzuNSR7RCkTlxBkCDHEzBPK4JlGYQukf3ENUw
	Z4oA4V4qMJLrJpYN33yzhcV/vsV7d7l+0wIDS8vjwcTwln6GPb3qRjBhPm361D7jwlBA1iHn1wbLB
	QZ0wPIcIT/OceaIgxv+LvU41JxFLt2AqcpxDFhy+iJmTpCh4meoP33EP4g7AhprXzY07NgGUgrgLK
	6jE2V/Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viHVO-00000004NTt-26HE;
	Tue, 20 Jan 2026 19:35:10 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viHVN-00000004NTQ-2MT4
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jan 2026 19:35:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A11DA6001A;
	Tue, 20 Jan 2026 19:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEA4C16AAE;
	Tue, 20 Jan 2026 19:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768937708;
	bh=FdvzVeldSGdLuYK3JnxXfDDD8Cc+1OUefdPqDkOGSY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZDKAYP8Qr52CFN9n4n1NuYYNiafs1qxWoZWrTPmt9j2hlmj2noXdZU9JqqfbVOXpj
	 oTJq/ifYep30l3FqFe09NW/uT749R463DnOUbvQGgPDX7w6qk33/Bm8A8Uy0QRGg2A
	 yzVgR/uyzzFVe4peU1Gn1nrQ/JKUNl3JbAORgB2M7ApwbrDNMJUT1FA3NStqTkf/0v
	 2E1pit4thKOqM4IIcTFMBA8OTOrB06aUcuPOBROwjt/wU0TflBpfMZFFp7+CevclOj
	 jMGn6euvAYDqWXBdOVh86wwBw5GB9q3uSD1TgpP11M92avgjlqr37edKZ1t97OjmG4
	 jP8X1mClorqHQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Yi Zhang <yi.zhang@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.18-6.6] nvmet-tcp: fixup hang in nvmet_tcp_listen_data_ready()
Date: Tue, 20 Jan 2026 14:34:50 -0500
Message-ID: <20260120193456.865383-7-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120193456.865383-1-sashal@kernel.org>
References: <20260120193456.865383-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.6
Content-Transfer-Encoding: 8bit
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

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit 2fa8961d3a6a1c2395d8d560ffed2c782681bade ]

When the socket is closed while in TCP_LISTEN a callback is run to
flush all outstanding packets, which in turns calls
nvmet_tcp_listen_data_ready() with the sk_callback_lock held.
So we need to check if we are in TCP_LISTEN before attempting
to get the sk_callback_lock() to avoid a deadlock.

Link: https://lore.kernel.org/linux-nvme/CAHj4cs-zu7eVB78yUpFjVe2UqMWFkLk8p+DaS3qj+uiGCXBAoA@mail.gmail.com/
Tested-by:  Yi Zhang <yi.zhang@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Let me understand the context of the commit better - it might be that
the commit requires a minor adjustment for backport since it uses
`nvmet_wq` but in the current tree (and stable trees), the workqueue is
called `nvmet_tcp_wq`. Looking at the diff more carefully:

The diff shows:
```c
+       if (port)
                queue_work(nvmet_wq, &port->accept_work);
```

Wait, the space before `queue_work` in the diff context shows this is
the EXISTING code (no + sign). But wait, looking at the current code:
```c
schedule_work(&port->accept_work);
```

So there's a discrepancy. The commit I'm analyzing might be from a tree
where `schedule_work` was changed to `queue_work(nvmet_wq, ...)` in
another commit.

For the purpose of backporting analysis, the KEY FIX is:
1. **Check `sk->sk_state != TCP_LISTEN` BEFORE acquiring the lock** -
   this is the essential fix for the deadlock
2. The change from `schedule_work` to `queue_work(nvmet_wq, ...)` is
   secondary

For stable backports, minor adjustments may be needed (using
`schedule_work` instead of `queue_work(nvmet_wq, ...)`), but the core
fix (early state check before lock acquisition) is applicable.

## SUMMARY

**What the commit fixes**: A deadlock that occurs when
`nvmet_tcp_listen_data_ready()` is called during socket cleanup with
`sk_callback_lock` already held. The fix checks the socket state before
acquiring the lock.

**Why it matters for stable users**: This is a deadlock/hang that can
occur during NVMe-over-TCP disconnect scenarios. Systems using NVMe-
over-TCP will hang, requiring a hard reset.

**Meets stable kernel rules**:
- Obviously correct: Yes - simple early return check before lock
  acquisition
- Fixes a real bug: Yes - deadlock reported and reproduced via blktests
- Small scope: Yes - 10 lines changed in one function
- No new features: Correct - pure bug fix
- Tested: Yes - "Tested-by" tag from Red Hat QE

**Risk assessment**: Very low. The fix simplifies the logic and cannot
cause regression.

**Dependencies/Backport notes**: The commit uses `queue_work(nvmet_wq,
...)` but older stable trees use `schedule_work(&port->accept_work)`. A
minor adjustment may be needed for clean backport, but the essential fix
(early state check) applies cleanly.

**YES** - This is a clear deadlock fix that should be backported to
stable kernels. The commit:
1. Fixes a real, reproducible deadlock
2. Is minimal and obviously correct
3. Has been tested and reviewed
4. Affects users of NVMe-over-TCP (a production storage protocol)
5. Has very low regression risk

**YES**

 drivers/nvme/target/tcp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 470bf37e5a637..2e9a3e698b700 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1992,14 +1992,13 @@ static void nvmet_tcp_listen_data_ready(struct sock *sk)
 
 	trace_sk_data_ready(sk);
 
+	if (sk->sk_state != TCP_LISTEN)
+		return;
+
 	read_lock_bh(&sk->sk_callback_lock);
 	port = sk->sk_user_data;
-	if (!port)
-		goto out;
-
-	if (sk->sk_state == TCP_LISTEN)
+	if (port)
 		queue_work(nvmet_wq, &port->accept_work);
-out:
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
-- 
2.51.0


