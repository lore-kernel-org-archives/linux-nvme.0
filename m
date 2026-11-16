Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D43A606A880
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=b4PkIso+;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KN8FnyeC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=VxAv89LYfn/72Kx82hU8pl1AOR7zFwTlzXMiqMQFm7A=; b=b4PkIso+dbvi3bnmCWalY+94hC
	fBab7EdUkbI6bU8tL5Bfup1Nqtyv2bP632BCnyRL/fzl107mlRtC/EUwI+S66fP6/Et4dtclQGg7d
	427k1h2CH8KwhP0tz06eXAO9/NovfKKvQLyG2iYpOjDJpB7h9ZZW8oReCHTd3cpX5vNLWQtBVoD6J
	eSs1Jeip+VD1znELJT5u+Nud7MOhzlc6sfXe2Xu3hytTZ2s5l/fD8KictAWezLXjTneJYr82uuW2H
	rIHMR8Z/SSDILYBR8axGfw9IF823IY9USo01xsdGop9ekR/Mzm7iISHWrb5GlYON42jBWmadbJ2Nk
	udmXBbLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSrpC-00000001WoY-408n;
	Mon, 16 Nov 2026 08:12:26 +0000
Received: from out199-15.us.a.mail.aliyun.com ([47.90.199.15])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSrp8-00000001Wn2-2ibm
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 08:12:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794816737; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VxAv89LYfn/72Kx82hU8pl1AOR7zFwTlzXMiqMQFm7A=;
	b=KN8FnyeCymAnaQo3nuUxTVk2bRCO99SH/hime9ITtVMh2ErZRznOaPQbTvU0/gThyufLatK6Zq9h8BmrVdsgwG4dSltN6u8HRC9sgMDlK3pKx4XiD8z8mycn75fIfbT+yA6g7JnkBdrN6b8G7BCG+F1nktVFK7HBjNpYKzCUvsw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEp0PdQ_1794816736;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEp0PdQ_1794816736 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Nov 2026 16:12:16 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 0/2] nvme: fabrics and target fixes
Date: Mon, 16 Nov 2026 16:12:09 +0800
Message-ID: <20261116081211.1757155-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_001224_073024_11B1D151 
X-CRM114-Status: GOOD (  11.68  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Two remaining fixes from the previous rounds of this series:

 - a use-after-free in nvme_fc_match_disconn_ls(): no iterator is
   sound across the rport lock drop inside the loop, so the loop is
   reworked to run entirely under the rport lock and to take a
   reference only for the match; reproduced under KASAN through fcloop
 - a data race on the shared authentication transaction counter,
   reworked per review to a per-queue counter, dropping the shared
   ctrl->transaction field entirely

The other three patches from v2 are already resolved: the GFP_KERNEL
persistent reservation change and the tbkas configfs locking are in
nvme-7.4 now, and the reconnect_delay fix was superseded by an earlier
identical patch posted by someone else.

Both patches are verified on an initiator/target VM pair: the fc loop
is compile tested and exercised under KASAN through fcloop with six
controllers on one remote port across tbkas force-reconnect cycles
and concurrent disconnects with no reports; the
DH-HMAC-CHAP authenticated session including I/O covers the auth path.

Changes since v2:

 - rework the nvme-auth fix to a per-queue counter (Keith Busch),
   drop the now unused shared field, and add the Fixes tag (sashiko);
   the Reviewed-by on v2 covered the atomic_t variant and is dropped
 - resend the unchanged nvme-fc patch, still awaiting review
 - drop the reconnect_delay patch (superseded), the GFP_KERNEL patch
   (applied) and the tbkas patch (applied)

Link: https://lore.kernel.org/all/20261109022646.290792-1-kanie@linux.alibaba.com/

Guixin Liu (2):
  nvme-fc: fix use-after-free in nvme_fc_match_disconn_ls()
  nvme-auth: fix data race on ctrl->transaction

 drivers/nvme/host/auth.c |  3 +--
 drivers/nvme/host/fc.c   | 22 ++++++++++++----------
 drivers/nvme/host/nvme.h |  1 -
 3 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.43.7


