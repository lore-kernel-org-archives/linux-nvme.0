Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF52C64ED6
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Feb 2023 16:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9faJd8dd2eC431kJmoSYxmUD9zaYXVCQPSTJIWyYC4c=; b=IGaRogvG+eYDR3/+cjCZ77SHiS
	yVFQtWFTm5FfbeWc2uTVOBzH0DKdTiM/zEDP2OAgJrez+HLzhsf3NpbTYT9vbQmMvQea9IifOzWhT
	UoU7YNsP+PhxC9JX/BMNY+u9z/f5txZvOU9YVzHAhZuRHuEatqk0yyWbw1GD4AKW0dqbYAnuMbbas
	Mv5eJ47oO/ea+Xwe0yMgr443kFM5gqlEn6xKR16PGb2TRyhA2hV9MfzRSOJMT5TC0djeIT1UVEqE2
	BdgJST0DTq8FULFn0XzDmF/G2BzXwb0+wdqHy+tNELtNc+lA/O6n1qJnn+ewIuvYlRz6JSka6Uvt7
	4rZ7HsDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pX2xp-00Dm4N-ET; Tue, 28 Feb 2023 16:36:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pX2xm-00Dm3a-Jm
	for linux-nvme@lists.infradead.org; Tue, 28 Feb 2023 16:36:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677602182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9faJd8dd2eC431kJmoSYxmUD9zaYXVCQPSTJIWyYC4c=;
	b=ODshp4nFoEFF49ybYU8rtG/SoGNKk9OSXsJqZWMl138iKfWIAykIdQEiZU8wC6D+kG4nmI
	9u+JU5tY6xlwmHAmMljDrUKW1iPLmwwiB99LnZjT4rBjzUsBkB/wltCKJxLwez9E3CSK9O
	FEIPNEEkkXWNh69uBvdRg2BwHWlPRSw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-Rdwpu6XkNJeCgydUOTd9dQ-1; Tue, 28 Feb 2023 11:36:20 -0500
X-MC-Unique: Rdwpu6XkNJeCgydUOTd9dQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02DD43C0E444;
	Tue, 28 Feb 2023 16:36:19 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.35.206.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3B0FD140EBF6;
	Tue, 28 Feb 2023 16:36:16 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: hch@lst.de
Cc: sagi@grimberg.me,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	hare@suse.de
Subject: [PATCH] nvmetcli: set up the target only after the network is configured
Date: Tue, 28 Feb 2023 17:36:15 +0100
Message-Id: <20230228163615.436692-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230228_083626_810508_47542CB6 
X-CRM114-Status: GOOD (  12.40  )
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

network.target only indicates that the network stack is up, but it
doesn't mean that the network devices have been configured.

Replace it with network-online.target, this fixes the following
error when systemd restores the target configuration during boot:

[   19.613251] nvmet_tcp: failed to bind port socket -99
[FAILED] Failed to start Restore NVMe kernel target configuration.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 nvmet.service | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/nvmet.service b/nvmet.service
index 5c7991e..6f97a91 100644
--- a/nvmet.service
+++ b/nvmet.service
@@ -1,7 +1,8 @@
 [Unit]
 Description=Restore NVMe kernel target configuration
 Requires=sys-kernel-config.mount
-After=sys-kernel-config.mount network.target local-fs.target
+After=sys-kernel-config.mount network-online.target local-fs.target
+Wants=network-online.target
 
 [Service]
 Type=oneshot
-- 
2.31.1


