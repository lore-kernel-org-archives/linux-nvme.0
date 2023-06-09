Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3350C7EE29
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jun 2023 12:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i/MJTUeDZzlx42IR4b00ab5UFRMqUbHmDFYZj2cxqws=; b=lpPTDKqG24BQmpYv7tHSZiZkeb
	ktruepOKoPgX4KWE+IV/9C1O1YLMJ2QhHV+NLl9vQ9Lqm0PkvUEu8AQDirJf3W6uP+slhfdu6Nphh
	94fVJEtrm+mc/6rmWmo/03SsabnCnFLXH8Q6iPE5rO0yg3n/T0jaPCD+/5q/qIXIYzK301jfk2uJe
	P09ZUHA4Jl5uEAp60rAr88oogKHHL8KH9qtXKD457xcJBZRzGFy7RiDrQve3OH/jfDk5zFHZZiaQE
	S60jYg/1w8ACc8XlkCnwcsOHJk0MdkMTGRqrjYMPafE5INJxChf2/y2mkfu2Jsj6oYK0SOBTsfjmn
	4IkAAUtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7bb4-00D2Jo-0p;
	Fri, 09 Jun 2023 12:52:06 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7bb0-00D2Hh-1X
	for linux-nvme@lists.infradead.org;
	Fri, 09 Jun 2023 12:52:04 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 74AA31FDF9;
	Fri,  9 Jun 2023 12:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686315119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i/MJTUeDZzlx42IR4b00ab5UFRMqUbHmDFYZj2cxqws=;
	b=vjQuoMKATJ5i0NjZWQPLIbymLEKHNphMb/w57LuuY15zXpfP/Cw2cQ1Ik/KKGO2JuyHREm
	fh8nAqPI2iOPnVHfpPwGsh2Tz/FaFqbdPHnwMmbVRBVsFjg2CflyT9ras7wfFX6uuDUP/l
	Dkea67LLVCC2OZYymH55WczhCVup0gk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686315119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i/MJTUeDZzlx42IR4b00ab5UFRMqUbHmDFYZj2cxqws=;
	b=MXRSZC0Kn9nDXdaleumWbkBGFgI7mgGfcmhVsFKr6LrXqAcHFIr/n19d4fPsQe1gPzCX20
	6VNPwxDU0peGkyCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 5FB2D2C143;
	Fri,  9 Jun 2023 12:51:59 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 5482251C48C1; Fri,  9 Jun 2023 14:51:59 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/4] net/tls: handle MSG_EOR for tls_device TX flow
Date: Fri,  9 Jun 2023 14:51:51 +0200
Message-Id: <20230609125153.3919-3-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230609125153.3919-1-hare@suse.de>
References: <20230609125153.3919-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230609_055202_664417_74BD8566 
X-CRM114-Status: GOOD (  11.89  )
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

tls_push_data() MSG_MORE / MSG_SENDPAGE_NOTLAST, but bails
out on MSG_EOR.
But seeing that MSG_EOR is basically the opposite of
MSG_MORE / MSG_SENDPAGE_NOTLAST this patch adds handling
MSG_EOR by treating it as the negation of MSG_MORE.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 net/tls/tls_device.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index a7cc4f9faac2..9603a3c9ec24 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -449,7 +449,7 @@ static int tls_push_data(struct sock *sk,
 	long timeo;
 
 	if (flags &
-	    ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_SENDPAGE_NOTLAST))
+	    ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_SENDPAGE_NOTLAST | MSG_EOR))
 		return -EOPNOTSUPP;
 
 	if (unlikely(sk->sk_err))
@@ -529,6 +529,10 @@ static int tls_push_data(struct sock *sk,
 				more = true;
 				break;
 			}
+			if (flags & MSG_EOR) {
+				more = false;
+				break;
+			}
 
 			done = true;
 		}
@@ -603,6 +607,8 @@ int tls_device_sendpage(struct sock *sk, struct page *page,
 
 	if (flags & MSG_SENDPAGE_NOTLAST)
 		flags |= MSG_MORE;
+	if (flags & MSG_EOR)
+		flags &= ~(MSG_MORE | MSG_SENDPAGE_NOTLAST);
 
 	mutex_lock(&tls_ctx->tx_lock);
 	lock_sock(sk);
-- 
2.35.3


