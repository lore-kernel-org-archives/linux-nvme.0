Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B14ACA5FFF
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Oct 2026 06:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KNeBlRDhLuvSlW19PDNWI8lXjRKHSv4aD2eWMu6B5hg=; b=TD+bxj9GRSEudZ5IAiZqfwnDS+
	7zF9LYdRm+gJRE5tM7ljM2nUBNqyiAvygwGcWQEjavpYvQhgXtbT+lDGfCEzHW0ZuWsU1n79zZ8ZB
	taOEiM6TpBkbMlBsP4znZJOoFQs4WEtur+/V8dxeJ66HFltcM3el48tXq8yulDTYidH21tSfkzxuy
	wU9WMITfBbqVByA+09oiAGZXz0TE04m8Bf8oQf6c7aHJ6YQk+6VIlxdGnypv3NORs/jvHFHSbUCx5
	cYka5B7xo1hhAcgiUp1d8WfyY1oeVmEHcxctU5oWXAjOwbiHTshXrRub7k44ueVlTKT8aiEMeW/ep
	imtN4WPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xELB1-00000001mVS-0lLz;
	Wed, 07 Oct 2026 06:30:55 +0000
Received: from cvsmtppost11.nm.naver.com ([114.111.35.156])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xELAx-00000001mTw-3Xwp
	for linux-nvme@lists.infradead.org;
	Wed, 07 Oct 2026 06:30:53 +0000
X-Originating-IP: 115.136.205.4
Received: from cvsendbo016.nm ([10.112.24.39])
  by cvsmtppost11.nm.naver.com with ESMTP id bRhAgle3R6iIWGoxIHjFmA
  for <linux-nvme@lists.infradead.org>;
  Wed, 07 Oct 2026 06:30:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791354646; bh=8ACVOPTsirzXruxTCL98z2WkWIVfHykvp/nYPXJ+w5Q=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=lN04n+vPtjo+9Z+kYg4Su3JNG2KKKacBfdYSJZqgxGJnnGV/HsGFm+vGz4IjwLWYD
	 E6Trz4wNG24/e585yj3kUy4h6eeYOIH5Cv31YeRvmXQjpg2F37xDsKjReyyA0p4CTZ
	 UE1Xf8WsINIQWQS1f1YB5lbKhNj5pMV8nkQfr3JwT49Pq1t8G51CPLGvF9POLL8BsL
	 T7HvKyM+QcediMmC/R0EIvboZaEMskJK94ZDb8N0VICECsdp5F9dGNjHYUqact2B7e
	 u3YkCRJ0U77DEMEAFx2f2hYTjVwsLB0mQSwdI9o0C/iKHWsnS2ouMG0tgtwmvA3XyZ
	 aFlXj5kl65Fnw==
X-Session-ID: 0VQtJRbBQsiFunXLn6ZtXg
X-Originating-IP: 115.136.205.4
X-Works-Send-Opt: OPFwpzGdjHmdKHFOMr39Ko3YKHmdjAudFqM9KqMqFxIYkEljxBmwjAg=
X-Works-Smtp-Source: XZnZKqulFqJZ+HmrFAUZ+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by mvnsmtp06.nm.naver.com with ESMTP id 0VQtJRbBQsiFunXLn6ZtXg
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Wed, 07 Oct 2026 06:30:46 -0000
From: Sung Byeongchan <tjdqudcks0424@naver.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: require authentication before property set
Date: Wed,  7 Oct 2026 15:30:41 +0900
Message-ID: <20261007063041.26180-1-tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_233052_274352_F9380C85 
X-CRM114-Status: GOOD (  11.36  )
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

I/O queues do not perform independent DH-HMAC-CHAP authentication.  They
instead rely on authentication of the controller's admin queue.  Fabrics
property commands, however, are dispatched before the general admin command
authentication check.

An unauthenticated peer can consequently set CC.EN, connect an I/O queue,
and access a namespace after admin CONNECT reported that authentication was
required.  Reject PROPERTY_SET until the admin queue has authenticated.
Targets without a configured authentication key are unchanged.

This was found by source review with AI assistance.  A localhost NVMe/TCP
wire reproducer retrieved a known 4 KiB namespace block in two independent
boots without completing AUTH_SEND or AUTH_RECEIVE.  With this change,
PROPERTY_SET returned NVME_SC_AUTH_REQUIRED and the namespace data was not
returned; the no-authentication control continued to work.

Fixes: c91a20129185 ("nvmet-auth: authenticate on admin queue only")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Sung Byeongchan <tjdqudcks0424@naver.com>
---
 drivers/nvme/target/fabrics-cmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 42d1d18116715..b451029ab8f49 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -14,6 +14,10 @@ static void nvmet_execute_prop_set(struct nvmet_req *req)
 
 	if (!nvmet_check_transfer_len(req, 0))
 		return;
+	if (!nvmet_check_auth_status(req)) {
+		status = NVME_SC_AUTH_REQUIRED | NVME_STATUS_DNR;
+		goto out;
+	}
 
 	if (req->cmd->prop_set.attrib & 1) {
 		req->error_loc =
-- 
2.43.0


