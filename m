Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F47C5321D
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Aug 2024 14:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/DdJ30NrFAMS4Lyxc4w3S9M+WomD05Ey94qnG/1AcaI=; b=dEAVdns0whPENdFolksvzlEIC/
	Ic3fcW5IVJu3AR0sHS+qd/5xq/9PvitXRXuo0FrcXdlTSbTQakuODICwtbdrPot4zr+po6WZyxNzo
	aVLJKJtaltBcgqF2ott87GXOqenug5jisxO02/6k8uD+7uDTiFuTnC28RJdrhlUmchQy511v4SvEl
	Dlp/oMgJ8LyyGy/U/K2yDKPutIQ5CAXjq8wJFkUNhaU30lg76m9lj0WLJ5Iy+QcpTL2cIGJz4WEb/
	z+Ma3wCVnjdNhxU+NprCPEli3u17TO6xqkYZpdqL3zLeZWuS5r4HDrixxvH8dnQse+8remdPNvJaQ
	zTkFDP/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgmKU-00000009J9D-2C2B;
	Wed, 21 Aug 2024 14:28:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgmKS-00000009J5N-0WGa
	for linux-nvme@lists.infradead.org;
	Wed, 21 Aug 2024 14:28:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724250531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/DdJ30NrFAMS4Lyxc4w3S9M+WomD05Ey94qnG/1AcaI=;
	b=JzEH9YHYPb+DsuRlCXlEWZCyIK3Q/a5SZ0rxn3u1hUFL1aiUXeocytT1d1+TPWZ6gk8JHW
	8y0WC5XUjpYN4//imHqElcpai7YWJd1LZ2ng0H+D+3jbyO9CyWOp/Xg2Evx4LWarAx4TGz
	ak9e0vdoJEe5D8le6viLIYUfOWlazfk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-lEQi-cCiMY-_4oLVlCJaFw-1; Wed,
 21 Aug 2024 10:28:50 -0400
X-MC-Unique: lEQi-cCiMY-_4oLVlCJaFw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CEE1190ECE5;
	Wed, 21 Aug 2024 14:28:43 +0000 (UTC)
Received: from kinzhal.redhat.com (unknown [10.45.224.134])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7710D1957652;
	Wed, 21 Aug 2024 14:28:28 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: axboe@kernel.dk,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	me@yawk.at
Subject: [PATCH V2] nvmet-tcp: fix kernel crash if commands allocation fails
Date: Wed, 21 Aug 2024 16:28:26 +0200
Message-ID: <20240821142826.69366-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240821_072852_256798_C2A9FE58 
X-CRM114-Status: GOOD (  12.30  )
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

If the commands allocation fails in nvmet_tcp_alloc_cmds()
the kernel crashes in nvmet_tcp_release_queue_work() because of
a NULL pointer dereference.

  nvmet: failed to install queue 0 cntlid 1 ret 6
  Unable to handle kernel NULL pointer dereference at
         virtual address 0000000000000008

Fix the bug by setting queue->nr_cmds to zero in case
nvmet_tcp_alloc_cmd() fails.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---

V2: add the Fixes tag

 drivers/nvme/target/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5bff0d5464d1..7c51c2a8c109 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2146,8 +2146,10 @@ static u16 nvmet_tcp_install_queue(struct nvmet_sq *sq)
 	}
 
 	queue->nr_cmds = sq->size * 2;
-	if (nvmet_tcp_alloc_cmds(queue))
+	if (nvmet_tcp_alloc_cmds(queue)) {
+		queue->nr_cmds = 0;
 		return NVME_SC_INTERNAL;
+	}
 	return 0;
 }
 
-- 
2.43.5


