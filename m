Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626F5C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 09:20:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2269760ED7
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 09:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2269760ED7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JOVPmkdmgPwac55TRiPc0RgC4b8qzroUIUE+BonjVkk=; b=gyVCKJCegy8ets
	fkLh1GorSBibZlq/O2m4pLgLoLTyeZ72NPZYGKS5ayGZxXhl0/JxyhMVPzbtewq/huX5qlnJhbToR
	zfNO1VLTXaVjbDvM9/BocnJH3qdySU9F46d2lx6YMEdxdTPdKw9e0+sO+i5N2k016yY27FQOVqM0F
	fdegQDjvwT6UYtyjNIBsEHNvKhzCPNg3bRB3GkdUKDJeedxNkfdDBfiL3ljQgYpR0swsEFM9Ov/w2
	L1/RFACezsw7P0ESh+vK3zhz4THOwSTsWc+2OkFeSaNW8z9ivkDSKFCDFbnhuftm+L6argTD36MQ5
	YYyzjXS4kYXoTaBJQCAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ4bx-004yZY-A4; Tue, 14 Sep 2021 09:20:17 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ4br-004yXD-FT
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 09:20:13 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id A302B200E2;
 Tue, 14 Sep 2021 09:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1631611209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aXMOFohVAzO6sN5gTXO7JBsgcuVaS1dswQOzd4j9vyg=;
 b=u43fm3Ku9uiZ/wUZ6vv86MbfxYidYg8tw8sO+mZTKB5z17xoyNB7fevlbHxvonsU26AzG2
 kGNxoPfep4Vj/DIUdHQ5pvJtVzzb70Ftcz8hR5SO7m8f5H+s+ANPaLxpMOStFiq3s4VPnd
 bZBYANOh2LtEvMmTzXwdhLx11/IchrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1631611209;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aXMOFohVAzO6sN5gTXO7JBsgcuVaS1dswQOzd4j9vyg=;
 b=/mb3eug1Ej/gHrxxauu7kI+B9DbCOXuEO0lyoE7V1Gpxia+RhULkCVDMYlbD1XEOO6JKWj
 SDh95sDRW5XuS2DQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 931DCA3BCC;
 Tue, 14 Sep 2021 09:20:09 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id 7FA71518E627; Tue, 14 Sep 2021 11:20:09 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Ming Lei <ming.lei@redhat.com>, Wen Xiong <wenxiong@us.ibm.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>,
 Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v7 0/3] Handle update hardware queues and queue freeze more
 carefully
Date: Tue, 14 Sep 2021 11:20:05 +0200
Message-Id: <20210914092008.40370-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_022011_823631_A2FD75CE 
X-CRM114-Status: UNSURE (   8.01  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

v7 is addressing the comments from Sagi (wrong commit id and add an
explenation why the queues are empty).

Daniel

v1:
 - https://lore.kernel.org/linux-nvme/20210625101649.49296-1-dwagner@suse.de/
v2:
 - https://lore.kernel.org/linux-nvme/20210708092755.15660-1-dwagner@suse.de/
 - reviewed tags collected
 - added 'update hardware queues' for all transport
 - added fix for fc hanger in nvme_wait_freeze_timeout
v3:
 - https://lore.kernel.org/linux-nvme/20210720124353.127959-1-dwagner@suse.de/
 - dropped 'nvme-fc: Freeze queues before destroying them'
 - added James' two patches
v4:
 - https://lore.kernel.org/linux-nvme/20210802112658.75875-1-dwagner@suse.de/
 - added 'nvme-*: Unfreeze queues on reconnect'
 - added Hannes' reviewed tags
v5:
 - https://lore.kernel.org/linux-nvme/20210818120530.130501-1-dwagner@suse.de/
 - dropped non nvme-fc patches
 - updated 'nvme-fc: fix controller reset hang during traffic'
v6:
 - https://lore.kernel.org/linux-nvme/20210823112351.82899-1-dwagner@suse.de/
 - updated commit message 'nvme-fc: Update hardware queues before using them'
 - dropped 'nvme-fc: fix controller reset hang during traffic'
 - added 'nvme-fc: Remove freeze/unfreeze around update_nr_hw_queues'
v7:
 - updated commit id in last patch
 - added explenation why the queues are empty in last patch

Daniel Wagner (1):
  nvme-fc: Update hardware queues before using them

James Smart (2):
  nvme-fc: avoid race between time out and tear down
  nvme-fc: Remove freeze/unfreeze around update_nr_hw_queues

 drivers/nvme/host/fc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
