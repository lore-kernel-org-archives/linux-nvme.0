Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4E4C5B552
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jun 2025 13:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uKW3Cfvalb+2oY++bzVaa607j97UwyDfoW0m+uRaSw8=; b=qzVsNnR1d5OnNSZSUbS/Mni+DI
	qT1g0dR7ktMAAyUOaNwsoB0dI4PSc7AIe1WjyTnZtLc4oIGRXjqLU8kStdGKukyRE9cbnZVdKkUPt
	3m4o+OElo65IGc6hes6mqf31yA4bua9XbQ3NW3iiwCOb/DXgbAP8JwHXyCMqIZtgzmjhWF/2uY0jd
	yZH4NqPFktZqxgYhTuC+MEopW6LwPOt03WHCWw+FbOxikVncW9qkotcs4O7jMd29pLnWLXQ6umkn+
	2TpLL2/enXlt0Xu/dGZJP18/giaPaVcF1LpeR9d0oz3UHcf822fl7c9V+GU8DihQqLqHZ20iLt3I9
	QLguIvdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOco0-00000004Gr9-1ZyB;
	Mon, 09 Jun 2025 13:44:52 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOcnA-00000004GkI-3jSt
	for linux-nvme@lists.infradead.org;
	Mon, 09 Jun 2025 13:44:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B2814A50E71;
	Mon,  9 Jun 2025 13:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FA4C4CEED;
	Mon,  9 Jun 2025 13:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749476639;
	bh=MZ58BKQTnrXbbZUX0MnHfuVfbB5/LOr6WdYGvCVq9/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ORc4zYVPUcSL3pP8+VTlf1EImdHygPAMcKEVLCljnwJreUjLAcuOvh4e+3zqHOVnU
	 ulkDhJ278vXPdZGPfK+O6A2qakOL6LlVI8aAIX3/bcRmd97giKVtBgM/iyXPLWAqMe
	 mRMe+cqR7We1IUAr7QnFM6z3yczK50Vwf/AQTpY2uaQGPuBdGaapV1gYD+wWvHlLyo
	 IhcTI63uKMvafZK2A3euXUutlwmwAw0Va7Z3+2DDf3tJaApBRymJxhCWOZ2dJxUdMh
	 VqUmGQ0TOiMpBmFKRsMEHh0cyJLZaXJ2dgY1KfdalaUWs+bS+2Yng1RWSU2hkjEtpv
	 XTsOExDN68BZw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Chris Leech <cleech@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.15 02/35] nvme-tcp: fix I/O stalls on congested sockets
Date: Mon,  9 Jun 2025 09:43:18 -0400
Message-Id: <20250609134355.1341953-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250609134355.1341953-1-sashal@kernel.org>
References: <20250609134355.1341953-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15.1
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250609_064401_059173_6BBAA36C 
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

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit f42d4796ee100fade86086d1cf98537fb4d326c8 ]

When the socket is busy processing nvme_tcp_try_recv() might return
-EAGAIN, but this doesn't automatically imply that the sending side is
blocked, too.  So check if there are pending requests once
nvme_tcp_try_recv() returns -EAGAIN and continue with the sending loop
to avoid I/O stalls.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Acked-by: Chris Leech <cleech@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of the commit and comparison with similar commits,
here is my determination:

**YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Fixes a real user-impacting bug**: The commit addresses I/O stalls
   on congested sockets, which is a serious issue that can cause system
   hangs or severe performance degradation. When the socket is congested
   and `nvme_tcp_try_recv()` returns -EAGAIN, the current code
   incorrectly assumes that the sending side is also blocked, leading to
   I/O stalls.

2. **Small and contained fix**: The changes are minimal and localized to
   the `nvme_tcp_io_work()` function:
   - Changes `nvme_tcp_try_recv()` to return 0 instead of -EAGAIN to
     prevent premature exit
   - Adds a check after receive processing to see if the socket became
     writable
   - Only 5 lines of actual code changes

3. **Clear logic fix**: The patch addresses a specific logic error
   where:
   - The receive side returns -EAGAIN (socket would block on receive)
   - But this doesn't mean the send side is also blocked
   - The fix checks if there are pending requests and if the socket is
     writable after receive processing

4. **Similar to other backported fixes**: Looking at the historical
   commits:
   - Commit #2 (backported): Fixed hangs waiting for icresp response
   - Commit #3 (backported): Fixed wrong stop condition in io_work
   - Commit #4 (backported): Fixed UAF when detecting digest errors
   - Commit #5 (backported): Fixed possible null deref on timed out
     connections

   All these commits that were backported involved fixing hangs, stalls,
or error conditions in the nvme-tcp driver.

5. **No architectural changes**: The commit doesn't introduce new
   features or change the architecture. It simply adds a missing check
   to prevent I/O stalls, which aligns with stable kernel criteria.

6. **Critical subsystem**: NVMe-TCP is used for storage access, and I/O
   stalls can have severe consequences for system stability and data
   integrity.

The specific code changes show:
- `return consumed == -EAGAIN ? 0 : consumed;` - prevents treating
  EAGAIN as an error
- The new check `if (nvme_tcp_queue_has_pending(queue) &&
  sk_stream_is_writeable(queue->sock->sk))` ensures that if there are
  pending requests and the socket is writable after receive processing,
  we continue processing instead of stalling.

This is exactly the type of bug fix that should be backported to stable
kernels to ensure reliable storage operation.

 drivers/nvme/host/tcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index aba365f97cf6b..599f7406b5945 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1348,7 +1348,7 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 	queue->nr_cqe = 0;
 	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
 	release_sock(sk);
-	return consumed;
+	return consumed == -EAGAIN ? 0 : consumed;
 }
 
 static void nvme_tcp_io_work(struct work_struct *w)
@@ -1376,6 +1376,11 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		else if (unlikely(result < 0))
 			return;
 
+		/* did we get some space after spending time in recv? */
+		if (nvme_tcp_queue_has_pending(queue) &&
+		    sk_stream_is_writeable(queue->sock->sk))
+			pending = true;
+
 		if (!pending || !queue->rd_enabled)
 			return;
 
-- 
2.39.5


