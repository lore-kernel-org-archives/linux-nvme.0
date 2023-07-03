Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57651C001DE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 09:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gvILd7sk13wwDq+N4D5AU+ZHek+MVfhla4H8J9D8dBw=; b=nbmtGT1WP+NrV2vNQPUhb6QTuh
	ROIlCkJM4H4RwL9ea1vL//02z5TPWj/RcZ+4h5hoeaIJ0eX2YVV6i8h0HwxEL2Ib/XLkoK+YVQURB
	CKvB9Cvexmt54Via+Cq1l7wJ8Yuauao9jkDIFOEZ559FUYNK6VLLy9Wxxw6L7ULa0KTD3Ad6MiSM4
	2xfVgTbtS7A8fIEO8LXuQUZCQAh0WQgU1nphn699B9mStsghXNWVQXuDYJuKtn9KKcPXK/PnoN81q
	2rAmA5aa1uC5F7++bxdAMjl9Iigu7lrILVh+ZR7HVCHxnOspdllK8bHIjSJs90xn2MGEWVlNm7J02
	BCzaXeCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGFUW-009qVd-2Q;
	Mon, 03 Jul 2023 09:05:04 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGFUT-009qRt-0A
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 09:05:02 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 386981FD6E;
	Mon,  3 Jul 2023 09:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688375096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvILd7sk13wwDq+N4D5AU+ZHek+MVfhla4H8J9D8dBw=;
	b=Yt2igoZPRAzpCKyiqGaoOs2ZE505VDw53e134u/B6UcN1VZckIFl/Ceao0nsU0eFvGKy96
	yQGRH5NdjsqXChq91wNRLoCTTp99QuY4UrB2F/t99K4I4zpkWxKKgG1VwLvZFuxRAkWtGS
	UnKMimHlP2HPVgZ7KY8W4DSvFl1F5nM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688375096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvILd7sk13wwDq+N4D5AU+ZHek+MVfhla4H8J9D8dBw=;
	b=0X6f8x0/BwCdebB4yKKyaIoiSNIqCiSd+MifARQrAdUJmSTHw3C6PFSy9FmHP8Cj+Q1dlu
	ZXosCTrDTryOXCAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id E4EAD2C141;
	Mon,  3 Jul 2023 09:04:55 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id D5F0151C5D87; Mon,  3 Jul 2023 11:04:55 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/5] net/tls: handle MSG_EOR for tls_sw TX flow
Date: Mon,  3 Jul 2023 11:04:40 +0200
Message-Id: <20230703090444.38734-2-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230703090444.38734-1-hare@suse.de>
References: <20230703090444.38734-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_020501_256963_153F84C6 
X-CRM114-Status: GOOD (  13.25  )
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

tls_sw_sendmsg() already handles MSG_MORE, but bails
out on MSG_EOR.
Seeing that MSG_EOR is basically the opposite of
MSG_MORE this patch adds handling MSG_EOR by treating
it as the negation of MSG_MORE.
And erroring out if MSG_EOR is specified with MSG_MORE.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 net/tls/tls_sw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 53f944e6d8ef..9aef45e870a5 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -984,6 +984,9 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 	int ret = 0;
 	int pending;
 
+	if (!eor && (msg->msg_flags & MSG_EOR))
+		return -EINVAL;
+
 	if (unlikely(msg->msg_controllen)) {
 		ret = tls_process_cmsg(sk, msg, &record_type);
 		if (ret) {
@@ -1193,7 +1196,7 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	int ret;
 
 	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
-			       MSG_CMSG_COMPAT | MSG_SPLICE_PAGES |
+			       MSG_CMSG_COMPAT | MSG_SPLICE_PAGES | MSG_EOR |
 			       MSG_SENDPAGE_NOPOLICY))
 		return -EOPNOTSUPP;
 
-- 
2.35.3


