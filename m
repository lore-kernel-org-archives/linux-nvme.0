Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3D3C624D4
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 20:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UMvbLiMb+sF2mtOC2uLwr9SRzXheSA2PXAvP/FINdPY=; b=iRh7DoOjMmHPzaKdLrFtjNQfW4
	I2EVBD3MZQ28BQoKKf4PMIc5AxNuJitkJQUKhx9+Le7XSy8YGbQGfhUNDZnuDo4lWWvZq5OWuKt4L
	uVQ6k35e/AnOujX6UqkQwFWVVRoZQM5u7Hr2iHtGBFwc4XoI9KUe4syOZTr2JGm/QhXb/hFnz58ZC
	BAJLr4kCfGJbUReH6aGrysUKNWa/vIZ6u3TtznWUE/gkRE+SqocjPcfyA+cMUaJMpWCTjOp3sILr1
	MKOYNveYdN2E1AJT21djB5OyEWdT+/OoCNfbe1nswiRwwzVf50awGl2QD4n9W6GhsuWJamLnlAg4S
	N4FfttWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1rDy-0000000FoTw-2rhg;
	Wed, 02 Sep 2026 20:06:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1rDw-0000000FoSt-0xS4
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 20:06:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788379579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMvbLiMb+sF2mtOC2uLwr9SRzXheSA2PXAvP/FINdPY=;
	b=Z+30KbUg2SfyeYnOIJTkt8hVgRWEo0VfSVZM309hApEBpGNjS2WzWNOuLgcMd6vRvnwUS8
	ZC+pB7dM1qSJ8xMnGkf+fg8HDsp0uvP4HPVYx1NdG+16bwg2Xa8AXYTiiZ818EFV+B/gIb
	A3yWxaWco8j+TkSwU7R8CtMVNOHtYW4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-l6utWQtSM8iZ4kPy_-lR3g-1; Wed,
 02 Sep 2026 16:06:15 -0400
X-MC-Unique: l6utWQtSM8iZ4kPy_-lR3g-1
X-Mimecast-MFC-AGG-ID: l6utWQtSM8iZ4kPy_-lR3g_1788379571
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B45F195DE47;
	Wed,  2 Sep 2026 20:06:11 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.17.16.153])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 247C61955F04;
	Wed,  2 Sep 2026 20:06:08 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: linux-scsi@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Hannes Reinecke <hare@suse.de>,
	Jesse Taube <jtaubepe@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Bryan Gurney <bgurney@redhat.com>,
	Chris Leech <cleech@redhat.com>,
	"Ewan D . Milne" <emilne@redhat.com>,
	shinichiro.kawasaki@wdc.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Muneendra Kumar <muneendra.kumar@broadcom.com>
Subject: [PATCH v2 5/7] nvme: sysfs: emit the marginal path state in show_state()
Date: Wed,  2 Sep 2026 16:05:45 -0400
Message-ID: <20260902200547.184734-6-jtaubepe@redhat.com>
In-Reply-To: <20260902200547.184734-1-jtaubepe@redhat.com>
References: <20260902200547.184734-1-jtaubepe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: x30oUpLz3h8J_xnr5uDb_mkReUbVIZ0eANRcB-4AOSI_1788379571
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_130620_340399_C7DFF65D 
X-CRM114-Status: GOOD (  14.85  )
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

From: Bryan Gurney <bgurney@redhat.com>

If a controller has received a link integrity or congestion event, and
has the NVME_CTRL_MARGINAL flag set, emit "marginal" in the state
instead of "live", to identify the marginal paths.

Co-developed-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: John Meneghini <jmeneghi@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Tested-by: Muneendra Kumar <muneendra.kumar@broadcom.com>
Signed-off-by: Bryan Gurney <bgurney@redhat.com>
---
V10 -> V1:
 - No change
V1 -> V2:
 - Only emit "marginal" if port is "live"
---
 drivers/nvme/host/sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 75b2d69b5957..9ede6b37f27a 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -526,6 +526,9 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
 		[NVME_CTRL_DEAD]	= "dead",
 	};
 
+	if (state == NVME_CTRL_LIVE && nvme_ctrl_is_marginal(ctrl))
+		return sysfs_emit(buf, "%s\n", "marginal");
+
 	if (state < ARRAY_SIZE(state_name) && state_name[state])
 		return sysfs_emit(buf, "%s\n", state_name[state]);
 
-- 
2.55.0


