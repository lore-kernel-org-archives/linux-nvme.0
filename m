Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1B1CD5BD5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 09:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Vr99dKgIuwz8M7C3a+pEx9DLD0kt0h8Z/YvS8p/zuIg=; b=jvWokCulMO3K5wOe5VZYEB/wGt
	TYcWj7mwQJ2na1XJLFatV+prhDT8vlMTtsAti+ufGneuPYihx+QENMG6gTmDuOE3GC6GdrEZpT016
	7u4V50JbA7ELZ+w5YWQ6itmAS7gzVImbGQ2SbAK47AIgSIaTFpTVmZvJHHw90YD/mdSWipzvS1Xyw
	bmE+vYdJP6Q3rY0eRZXPuPI0fCMqGBo/K6lwp3q2It0AKikvAWa7SzXkSm9lX30grRS5fKeqHAbgP
	qVKLZIbHkV+9gU/6ObC7LeTINwtZ+DK2OqJSqkI6jfOygg19AGv2w8ryWNR23Zr6ebQJDSTAO8GKp
	6gjNm3ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSX1t-00000005VEC-1zMP;
	Thu, 28 May 2026 09:27:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSX1o-00000005VC4-3MvF
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 09:27:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779960466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vr99dKgIuwz8M7C3a+pEx9DLD0kt0h8Z/YvS8p/zuIg=;
	b=JQ620MGN1/CJtCD6Zs35b4gMKoZM4ZIWqYo+k25WFaWv5o7EWodhwogYNFj9RLILQuD9VZ
	wWSa1Fh/7d6y6BivMYvdOxl6OM0QkXut5elTJzoGr9QOT9f+NX8ukwdG0k3rlkuT62hdQY
	mMw7fdIX926XmgL5HNYHVv2pm6yo3WE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-t3Dbr6fQO96EswBMkIowfg-1; Thu,
 28 May 2026 05:27:43 -0400
X-MC-Unique: t3Dbr6fQO96EswBMkIowfg-1
X-Mimecast-MFC-AGG-ID: t3Dbr6fQO96EswBMkIowfg_1779960461
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB9B818002CF;
	Thu, 28 May 2026 09:27:40 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.48.41])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2275A19560AB;
	Thu, 28 May 2026 09:27:36 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: mlombard@arkamax.eu,
	mkhalfella@purestorage.com,
	randyj@purestorage.com,
	hch@lst.de,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	emilne@redhat.com
Subject: [PATCH 0/1] Fix a kernel panic in nvme-fc
Date: Thu, 28 May 2026 11:27:33 +0200
Message-ID: <20260528092734.258899-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WS6ilOSI1moJMb-qEfegE3qshMR7Ppe2oy7PRP76En8_1779960461
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_022748_906227_3D51195E 
X-CRM114-Status: UNSURE (   7.22  )
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

We received a RHEL bug report regarding a kernel panic that occurs
when loading/unloading the lpfc module:

Call Trace:
blk_mq_tagset_busy_iter+0x210/0x440
__nvme_fc_abort_outstanding_ios+0x1d8/0x260 [nvme_fc]
nvme_fc_ctrl_ioerr_work+0x4c/0x90 [nvme_fc]
process_one_work+0x1f4/0x500
worker_thread+0x33c/0x510
kthread+0x154/0x170
start_kernel_thread+0x14/0x18

The following patch, which is part of the Rapid Path Failure patchset,
fixes the crash.

https://lore.kernel.org/linux-nvme/20260328004518.1729186-16-mkhalfella@purestorage.com/

Since this patch is independent of the Rapid Path Failure feature itself,
I propose merging it separately so we don't have to wait for the full
feature to be approved.

Mohamed Khalfella (1):
  nvme-fc: Do not cancel requests in io target before it is initialized

 drivers/nvme/host/fc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.54.0


