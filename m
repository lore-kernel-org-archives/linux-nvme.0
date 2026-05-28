Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BE9CD5BD0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 03:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1BY3fIUX8gmKju1y5veWjmaxgiak/EkCD3JD09YnoAM=; b=Tm817mHRldVQ3PYK8uEhHIJ7+8
	ZA5f97IjxwXkKqlRQsrfJsZDy6nm3DrYEHqEIFUV4oCK0GOq42kvp99xzycM7qE62/EJxHvTACAH0
	HGogiFS+l8RpfOy3zBxb3/Hr9ohRu9CjHjEl2Xmg+L5ffbq/mrTSsWy0eCHlz1K+5ZnKVI8Xa7Qvq
	yvfhMK86IEXn7jRp5AvZosbhCY7ZUX1LaihiFx8wDqleeWdzJi0uiE341tH99glX5KLRt5YEPpp2Q
	LARwI9mKWbCaI03jl8FnTdWN85Q/bKjXG7rzI1ZCOClQ+cf3CSPnlNM3tBzCcpoxOwFimL56+iVcg
	peA9vkjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSRAJ-000000052Tf-1cYt;
	Thu, 28 May 2026 03:12:11 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSRAI-000000052T7-0zmN
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 03:12:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AB3D3605D2;
	Thu, 28 May 2026 03:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3841F00A3A;
	Thu, 28 May 2026 03:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779937929;
	bh=1BY3fIUX8gmKju1y5veWjmaxgiak/EkCD3JD09YnoAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l5Z84dXJwZHwM8LCJ5dq+U73AaYLFztuK9cmtaW1jlZREj3nwjCvjF4sShtwV6O6c
	 Tgg/MlMajgZi2b7Cz3+wrk7OYrR2evwR0/SOlpJADHsMpjdwHsqukan7bDUai5ugQn
	 tfEVkaoSmzKeEcts1aAQ1qtgXax1E/XYsfuobOUVSFYy+KLG6C3WzbtPIWPWCXPRSs
	 +1bmlYKcq+Igioln952z7zpRSMDUXV9HylVnUoOpHKcn9a8cbY/1mGWxRTelKQCZX6
	 foAOTqjNORZ9N6/x7IIsoMGE05f4cvb0PfOLCs9/NT7Ht3CvL3fxP3CEYYtoCQL6tj
	 TdqI0kPFMQ5xA==
From: Geliang Tang <geliang@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Randy Jennings <randyj@purestorage.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH 06/11] nvme-fabrics: compare transport in ip_options_match
Date: Thu, 28 May 2026 11:10:40 +0800
Message-ID: <148800f6002bae1448d8dfc279f2e22f0851ee03.1779934709.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779934709.git.tanggeliang@kylinos.cn>
References: <cover.1779934709.git.tanggeliang@kylinos.cn>
MIME-Version: 1.0
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

From: Geliang Tang <tanggeliang@kylinos.cn>

When checking for an existing controller, nvmf_ip_options_match() does
not compare the transport type. This can cause a TCP connection request
to incorrectly match an existing MPTCP controller, or an MPTCP connection
request to match an existing TCP controller, resulting in a false
-EALREADY error.

Fix this by adding strcmp(opts->transport, ctrl->opts->transport) to the
matching condition.

Cc: Hannes Reinecke <hare@suse.de>
Cc: John Meneghini <jmeneghi@redhat.com>
Cc: Randy Jennings <randyj@purestorage.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/fabrics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ac3d4f400601..e086e61e8f94 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1220,6 +1220,7 @@ bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 		struct nvmf_ctrl_options *opts)
 {
 	if (!nvmf_ctlr_matches_baseopts(ctrl, opts) ||
+	    strcmp(opts->transport, ctrl->opts->transport) ||
 	    strcmp(opts->traddr, ctrl->opts->traddr) ||
 	    strcmp(opts->trsvcid, ctrl->opts->trsvcid))
 		return false;
-- 
2.53.0


