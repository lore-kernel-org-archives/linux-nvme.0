Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0953C3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 12:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=55IkVfY72TJait42Al2900jZtmDO6lWb98751fZl+Bo=; b=FxNAIFxldxD8E5DFnWAVKKd2wc
	nwJ6/o7Nm0KY6KYdPm9lXLYObVSsQLCKT9yR+H5FK8UI6mqA/WWPi8pdcGrJlJNX51JvTL8VHAWjd
	hXAbgOnmfP1sWo4ir38qosbQQo/nmfNf90uVcmfZ61az5vde6FxH4rAkHhgq3JIVXoXGW4Xjbeqr1
	n9KJ28nwGi90V2c5G6KdyCvspdm+7jkNEOpmieIC4URC3ofwD7+CGRESvy1TXWEoHntzt/ECiFJnZ
	LK2vxlx8AKNnVf0RqShUF+F2TxzyUvcZblE4PQTy0Geud23WLJIkDPJ4C/cPMy2xo6M7hyzM1ZrgM
	jpyq1v0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdnx-0000000FMrs-0546;
	Wed, 07 May 2025 12:23:17 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdnu-0000000FMqJ-3gz5
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 12:23:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1945E4365D;
	Wed,  7 May 2025 12:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3A0C4CEF3;
	Wed,  7 May 2025 12:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746620594;
	bh=h35lcOoeDI+WPo72mPb2StqZOw//yaagpxzR2QHffls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XWTmu8ZQ6OMGcQwTdqwRBFSveziCpKdbNI3BbU2xfY4O62Uob7TmG/ak7rbzK0DFd
	 VeQj5G3mEJIzRe2juLQfdNf15Rfm4xcRvU/pnfftrQGcHtwRJ3KMc16j503ojaFsEV
	 iu0FM1revTzJAhEEME3ImpLCGLtSYdY4o2n9I7oKq8uS8TBcJNzXaJPujQ3j0qvX5g
	 SQJyyrD1ASZqQjHgseg/A1C+Gx0KyYMXItD2LMea0RDNyzXhD4L3DI97nPDdxqiy2y
	 6rxMxialmuRLCT1cwrlDVkfaMTXbu4jxr9QbHOkGIFiSBOlEJv4EZZIod+g9GW8xnj
	 ttxspVBqqshfA==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 07 May 2025 14:23:00 +0200
Subject: [PATCH v6 04/14] nvmet-fcloop: refactor fcloop_delete_local_port
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-nvmet-fcloop-v6-4-ca02e16fb018@kernel.org>
References: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
In-Reply-To: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_052314_942699_48E86A41 
X-CRM114-Status: GOOD (  11.33  )
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

Use the newly introduced fcloop_lport_lookup instead
of the open coded version.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index a8134127ad8087190d674251a88545da3f8800d7..1a8ae33c1699be3b7a2a7170dff77e324c127ebb 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1256,32 +1256,32 @@ __fcloop_lport_lookup(u64 node_name, u64 port_name)
 	return NULL;
 }
 
+static struct fcloop_lport *
+fcloop_lport_lookup(u64 node_name, u64 port_name)
+{
+	struct fcloop_lport *lport;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+	lport = __fcloop_lport_lookup(node_name, port_name);
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
+	return lport;
+}
+
 static ssize_t
 fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct fcloop_lport *tlport, *lport = NULL;
+	struct fcloop_lport *lport;
 	u64 nodename, portname;
-	unsigned long flags;
 	int ret;
 
 	ret = fcloop_parse_nm_options(dev, &nodename, &portname, buf);
 	if (ret)
 		return ret;
 
-	spin_lock_irqsave(&fcloop_lock, flags);
-
-	list_for_each_entry(tlport, &fcloop_lports, lport_list) {
-		if (tlport->localport->node_name == nodename &&
-		    tlport->localport->port_name == portname) {
-			if (!fcloop_lport_get(tlport))
-				break;
-			lport = tlport;
-			break;
-		}
-	}
-	spin_unlock_irqrestore(&fcloop_lock, flags);
-
+	lport = fcloop_lport_lookup(nodename, portname);
 	if (!lport)
 		return -ENOENT;
 

-- 
2.49.0


