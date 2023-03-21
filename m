Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1049BC74A5B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 16:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GqVzzSqnA3FCwWAgaYVXPoEM56h3wCXUdoQ1Q6PkvY4=; b=hVUikC9LhKacGxVmkvbRUior9r
	c0ByPGRg7xZ5h3J/KrVAHEdg1ZZ452eGiK6fLGywRos6c/qBsLDa/fZ9SWWUVmNV/lAUiD15c83qV
	z4pU8non0g6SCj+JLAFm8c6/3CiqJ2c6NjjdrTpFzS6ViAg/TIwR70FLvLHq5LHVtNuwLWbAFT2eJ
	JYshIRipwMfGHBMcm29SLruxYw1j3qDTHChHbSsKHm7Gi5vae/t8WqiNqHihm6rtSNIpcWajL2jK4
	ntZ5pY5l5/8RDaTf3me9Kx3gbpC0OiwiBDivMrdB9+hU7Ju6iXzijdJ8GAu019SoAmsu7PX8Q2+uK
	6BnpmNsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peesh-00D57R-2U;
	Tue, 21 Mar 2023 16:30:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peesd-00D55n-1r
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 16:30:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679416231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqVzzSqnA3FCwWAgaYVXPoEM56h3wCXUdoQ1Q6PkvY4=;
	b=dngRvLLzdsuIM5tHIiqF2C9ak79IpitPUjOLsAOqrPmR/9OcJyYe5x0WXPF5y0yOHaMnII
	ZODfrRrB9ZbyWWDMGFF0FvLVIf+7xayzm2v/mLuLEdX7MHDT+x601srUJ1qjZR5BDASngr
	5XOxRpIqUHA/zp8lBaGl9IRYrM3czBQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-wlQaLI5SN8yPXTcKSMKpdQ-1; Tue, 21 Mar 2023 12:30:29 -0400
X-MC-Unique: wlQaLI5SN8yPXTcKSMKpdQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35B73886464;
	Tue, 21 Mar 2023 16:30:29 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.2.17.90])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C4E4E1121314;
	Tue, 21 Mar 2023 16:30:28 +0000 (UTC)
From: Chris Leech <cleech@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: John Meneghini <jmeneghi@redhat.com>
Subject: [PATCH v2 1/1] nvme-tcp: fence TCP socket on receive error
Date: Tue, 21 Mar 2023 09:30:25 -0700
Message-Id: <20230321163025.9437-1-cleech@redhat.com>
In-Reply-To: <20230320220947.3244247-1-cleech@redhat.com>
References: <20230320220947.3244247-1-cleech@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_093035_689920_6D3DEAB1 
X-CRM114-Status: GOOD (  12.23  )
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

Ensure that no further socket reads occur after a receive processing
error, either from io_work being re-scheduled or nvme_tcp_poll.

Failing to do so can result in unrecognised PDU payloads or TCP stream
garbage being processed as a C2H data PDU, and potentially start copying
the payload to an invalid destination after looking up a request using a
bogus command id.

Signed-off-by: Chris Leech <cleech@redhat.com>
---
 drivers/nvme/host/tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 42c0598c31f2..99ad715210af 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -888,6 +888,9 @@ static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 	size_t consumed = len;
 	int result;
 
+	if (unlikely(!queue->rd_enabled))
+		return -EFAULT;
+
 	while (len) {
 		switch (nvme_tcp_recv_state(queue)) {
 		case NVME_TCP_RECV_PDU:
-- 
2.39.2


