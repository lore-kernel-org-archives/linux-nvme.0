Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6D4C87FCA
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Aug 2025 21:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xBHP4PRm+HWtA7byEiIkUfGiMu/b7EVlr7Qw1Gmd8/c=; b=mEjJrMGijiY+cwmS7XEGBQfAPH
	Xq2uVuXrfaYkeWE0jqlpenaeQKw8CngfPMjpoR4Xlpo7J4K1OvOVC+3K4RPxnaYsvN4MNW+U2QYNu
	EcqaMhDIjCc0vSQiXrGgR4w/6c6YV33ypHu39m+hxrMLV6HKPH5FJZrwzM8vfikgt+5IbqRMeJMiv
	I5TFyh9HKH4DC1k7hxqybVYTt1SNmTNJU0cm6G9vERAURnAKlpU7X2nJf2oOsU5rsY84TRBstrp1Y
	XwMxIIJPqrkWmVoP6/vqFg+7kcrunAtCTmX5kQ9FOS2MpOSYrZdB3GPHydigQrEOYc+6LNwevDQ+r
	vM4SWfXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uigAr-00000009AiP-1fj8;
	Sun, 03 Aug 2025 21:23:21 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uig6r-000000099Wi-2Q1s
	for linux-nvme@lists.infradead.org;
	Sun, 03 Aug 2025 21:19:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CF958A54D5B;
	Sun,  3 Aug 2025 21:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB6CC4CEF8;
	Sun,  3 Aug 2025 21:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754255952;
	bh=d1yVetX8aerPMO3B5Hzujmr72qW21koOX/V+ry9klWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nwiFP8hrCUFK/M1GAzDgNcaF2KaW4qOfvWeMkK6AP/uwvQby0X7xyv+3yy/RKCIAz
	 dmimp7G/FE8BgAbugaPEIO7MWCqJdnYEx2kiHhd5/NhgIJ3Et41ImgoS8yTciiZ44k
	 hA8GU7WdchJ2KbSuGzn34Pp+61GZSPF6xDT8+ccRMoggmRcCb5I438zdz41hfCg6nP
	 ZuJUKlQXXkOLO/DUBD4ZSdUcTwlXcyRprzt6CDIMU5YZ0cyKP2YYoh5HgWqQNhXj2m
	 0/R+QL09c3ZqkntumBtf713QhkFKHeal8pA0jljCxSAv+A1dPjRmg8qxXTypSselHg
	 dpCrhAXrv2fpA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Laurence Oberman <loberman@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.15 14/34] nvme-tcp: log TLS handshake failures at error level
Date: Sun,  3 Aug 2025 17:18:16 -0400
Message-Id: <20250803211836.3546094-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250803211836.3546094-1-sashal@kernel.org>
References: <20250803211836.3546094-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15.9
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250803_141913_742023_7CAB611B 
X-CRM114-Status: GOOD (  15.32  )
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

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit 5a58ac9bfc412a58c3cf26c6a7e54d4308e9d109 ]

Update the nvme_tcp_start_tls() function to use dev_err() instead of
dev_dbg() when a TLS error is detected. This ensures that handshake
failures are visible by default, aiding in debugging.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Fixes a Real Debugging Issue**: The commit addresses a genuine
   problem where TLS handshake failures were being logged at debug level
   (`dev_dbg()`), making them invisible in production environments
   unless debug logging is explicitly enabled. This change promotes
   error visibility by using `dev_err()` for actual error conditions.

2. **Small and Contained Change**: The patch is minimal - it only
   changes logging behavior by:
   - Adding a conditional check `if (queue->tls_err)`
   - Moving the error case from `dev_dbg()` to `dev_err()`
   - Keeping successful handshakes at debug level

   The diff shows only about 10 lines changed with no functional
modifications.

3. **No Architectural Changes**: This is purely a logging improvement
   that doesn't alter any control flow, data structures, or protocol
   behavior. It simply makes existing errors more visible.

4. **Important for Production Debugging**: TLS handshake failures in
   NVMe-TCP can be caused by various issues (certificate problems, key
   mismatches, network issues) that are critical to diagnose in
   production. Having these errors hidden at debug level severely
   hampers troubleshooting.

5. **Mature Feature Area**: NVMe-TCP TLS support was introduced in
   kernel 6.5 (around August 2023 based on commit be8e82caa685), making
   it a relatively mature feature that's likely deployed in production
   systems requiring proper error visibility.

6. **No Risk of Regression**: The change only affects logging output and
   cannot introduce functional regressions. The worst case is slightly
   more verbose kernel logs when TLS errors occur, which is the intended
   behavior.

7. **Follows Stable Rules**: This meets the stable kernel criteria as
   it's a small fix that improves debuggability of an existing feature
   without introducing new functionality or risks.

 drivers/nvme/host/tcp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index b882ee6ef40f..d0ee9e2a3294 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1776,9 +1776,14 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 			qid, ret);
 		tls_handshake_cancel(queue->sock->sk);
 	} else {
-		dev_dbg(nctrl->device,
-			"queue %d: TLS handshake complete, error %d\n",
-			qid, queue->tls_err);
+		if (queue->tls_err) {
+			dev_err(nctrl->device,
+				"queue %d: TLS handshake complete, error %d\n",
+				qid, queue->tls_err);
+		} else {
+			dev_dbg(nctrl->device,
+				"queue %d: TLS handshake complete\n", qid);
+		}
 		ret = queue->tls_err;
 	}
 	return ret;
-- 
2.39.5


