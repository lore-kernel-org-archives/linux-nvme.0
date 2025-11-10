Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639CECCF9E3
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Nov 2025 21:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YwkRbSaRWjLN0bjmCmxaA8r5XkXC44OYSeuiWIjvBBw=; b=ZkafTijg3qiYllbPcq6yYqgn0X
	NCnTfKibxkqhxcVUWzCyYM195TUrJhOpbEUEXCRAZ021O9r+LKmZB8btI6GKng2mgpykfQWALC4QA
	zhrMCzWPnphyQ9NnPh9hWP+m7aGXlnUj53g5IpDzkBfjw6XsaLuXnToaOl/lV8U3JLc7hzQM7IjOT
	gBTzUmpzH67sEBTRDDbal/hXgbDTVMcBGuCswDddG8lEAZXONbLyXEtY+E+xGy80u+6qAvS6pnBeB
	6+j4irT74qOun0pq5JADUFq6U0xEWET8dcckbOu3D6PFz+mbFyU6kXyId0420WLoXNVRo4YZupK0c
	89B8TPUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIZJI-000000069ZZ-1CAs;
	Mon, 10 Nov 2025 21:20:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIZJB-000000069Ys-2iw6
	for linux-nvme@lists.infradead.org;
	Mon, 10 Nov 2025 21:20:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762809614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YwkRbSaRWjLN0bjmCmxaA8r5XkXC44OYSeuiWIjvBBw=;
	b=MUYKaNjHOSxYiv8cZpB19d37A5VdCTGM1QZevEUzWraNvfw1JjXlgmSm858Z1HqFXb1Odk
	w22rWzHa1peqXBr8AviMopGLKaqY/stbG65ihv9u88UTYpODQ0Y8rVxeLwd4v6Sjfq1LKY
	6wa2QVhx7CDW5tjvO27EvFzX57As9BI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-ze_qOA5lOnGL22DR3cL4MQ-1; Mon,
 10 Nov 2025 16:20:10 -0500
X-MC-Unique: ze_qOA5lOnGL22DR3cL4MQ-1
X-Mimecast-MFC-AGG-ID: ze_qOA5lOnGL22DR3cL4MQ_1762809609
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AB041956070;
	Mon, 10 Nov 2025 21:20:08 +0000 (UTC)
Received: from emilne-na.westford.csb (unknown [10.45.224.56])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 95D1519560B7;
	Mon, 10 Nov 2025 21:20:03 +0000 (UTC)
From: "Ewan D. Milne" <emilne@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: mpatalan@redhat.com,
	james.smart@broadcom.com,
	paul.ely@broadcom.com,
	justin.tee@broadcom.com,
	sagi@grimberg.me,
	njavali@marvell.com,
	ming.lei@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH 0/2] Two NVMe/FC bug fixes for -stable
Date: Mon, 10 Nov 2025 16:19:59 -0500
Message-ID: <20251110212001.6318-1-emilne@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251110_132017_762424_A2C03EF3 
X-CRM114-Status: UNSURE (   8.67  )
X-CRM114-Notice: Please train this message.
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

This patch series contains two fixes to the NVMe/FC transport code.

The first one fixes a problem where we prematurely free the tagset
based on an observation and a fix originally proposed by Ming Lei,
with a further modification based on more extensive testing.

The second one fixes a problem where we sometimes still had a
workqueue item queued when we freed the nvme_fc_ctrl.

Because both patches touch the same nvme_fc_delete_ctrl() function,
they have to be applied in the correct order to merge cleanly.
However they fix separate issues.

Ewan D. Milne (2):
  nvme-fc: move tagset removal to nvme_fc_delete_ctrl()
  nvme: nvme-fc: Ensure ->ioerr_work is cancelled in
    nvme_fc_delete_ctrl()

 drivers/nvme/host/fc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.43.0


