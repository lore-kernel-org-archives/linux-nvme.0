Return-Path: <SRS0=tSwM=QE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AF5C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 15:25:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05809613C8
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 15:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 05809613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YVMkHF/q6EZ0fCW1eTxtUM6Zn/lwhXCZaFeEZGJnKC8=; b=WtcSqJAGLHJCxQuNnkbsNYZSxc
	q55KCfL+I2CgjyeASI8o2O9/d8AEI1kWm4KCJL3evEgNXFhDHeTaII6kggfwDV2qPyV3VQ34RcHF2
	XVAgzNYid/fbc8KnCCqgHhlHz6UbAhFziInopQ8GJ7yH6snuC/yH5qDg6lWMNRxnTSX1PPCLbdIc0
	fDN5hos9VE36pJG5fBJhE3CaVt7no3IODub0p946HroeM2GWh0HBZSbsI/zYpyQQHTrcoM+NCMnmV
	sLy+usGBhXOda1MQnVTtwkGAI07GQnKhOOyUv1wzP2Wf9WRnaSo3jofA2yVsUyURu8G86OMtBVR4A
	p1KPwm1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnMo8-005NgI-OU; Wed, 17 Nov 2021 15:25:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnMo5-005Nee-81
 for linux-nvme@lists.infradead.org; Wed, 17 Nov 2021 15:25:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637162701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YVMkHF/q6EZ0fCW1eTxtUM6Zn/lwhXCZaFeEZGJnKC8=;
 b=Zb6JFCL+Haffn/SmsE8YsD3rK0sbmNz/jcu+w5Nj9bODlfQqCC62dwJT6qrRlkjx8hqR3d
 a6oQW1FTcKNwKcIYOENNTOq16HOfpAG6IQ3fZeQEV4E4jI6lS4uBchb+OmZMn7FTV5RdCR
 FW3YxFSOXeY8DfLXPliogQ3ANHQX38c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-D2LVTH4pM1ewxPWmSajTmQ-1; Wed, 17 Nov 2021 10:24:58 -0500
X-MC-Unique: D2LVTH4pM1ewxPWmSajTmQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 565D1802C91;
 Wed, 17 Nov 2021 15:24:57 +0000 (UTC)
Received: from raketa.redhat.com (unknown [10.40.192.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ECEDA5DEFB;
 Wed, 17 Nov 2021 15:24:55 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Subject: [PATCH RFC] nvmet: fix tmpfs-based backstores support
Date: Wed, 17 Nov 2021 16:24:54 +0100
Message-Id: <20211117152454.122014-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211117_072505_398571_FA48CF5C 
X-CRM114-Status: GOOD (  12.22  )
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

commit 50a909db36f2 ("nvmet: use IOCB_NOWAIT for file-ns buffered I/O")
optimized the read command behaviour  when buffered file-ns
configurations are used.
It issues the read commands with the IOCB_NOWAIT flag set to try
to access the data from the cache.

However, the patch was buggy because both read and write commands are
issued with IOCB_NOWAIT, this broke tmpfs-based backstores because tmpfs
doesn't accept write commands with IOCB_NOWAIT.

Fix this bug by restricting IOCB_NOWAIT to read commands only.

Fixes: 50a909db36f2 ("nvmet: use IOCB_NOWAIT for file-ns buffered I/O")

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/io-cmd-file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 6aa30f30b572..1d9b41190583 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -266,6 +266,7 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 
 	if (req->ns->buffered_io) {
 		if (likely(!req->f.mpool_alloc) &&
+				req->cmd->rw.opcode == nvme_cmd_read &&
 				nvmet_file_execute_io(req, IOCB_NOWAIT))
 			return;
 		nvmet_file_submit_buffered_io(req);
-- 
2.27.0


