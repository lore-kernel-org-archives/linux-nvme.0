Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EC3C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 09:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Zq/52Q1AcQELK7fLNIKFlPiXkn+EjSXzQy671KOxIOA=; b=USORVj4exIFAClPSS5SCVNVjxq
	F73Ar6L4hMs15q7pbbZWb57bpS/a9jR1afoHAGGpx0Kr27WmMTqfYiO7zeGdTIjzAMsg0sWDdCI9p
	/TdSWRyCNc3vB46LARz0gxvxBdBW/o2iLkv3p7j9HQrtxyjtNXXvlFIuAmDUPeNH0wQjuzFFWXxvf
	/epUEwVGpF1vbaRAWZw/JNP+jOljVIfxuTErv3nDeYVhRt9K2xzx/r9kG6kL9FoUbkaZuWqhAwXKD
	8P/clS3yZW3CXkx2QaQecbGsfaz4y/6eo1rQFeJhGSOepDcejcalylbgYaVaKSnYAjf37cyYWd1QM
	xQtE9vSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEou8-001fD9-C5; Fri, 22 Jul 2022 09:25:04 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEou5-001f82-PP
	for linux-nvme@lists.infradead.org; Fri, 22 Jul 2022 09:25:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 45A261FAA0;
	Fri, 22 Jul 2022 09:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1658481900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Zq/52Q1AcQELK7fLNIKFlPiXkn+EjSXzQy671KOxIOA=;
	b=eLDlsAPCL2r/bX9FvUn/y/CsmRDyxwaLax2DHHXQ6wMQtzPlUswIsivECWTgPsDHO1Hlll
	hCYcw/IWgUwh7nOER9M7IU9h+ohxv84AFHgbADEpmdrHmokJTi0O1Y9fuaoXNUeuRrZTny
	YPLtpbQCQ2SmDTEcPfabzO9NnmC2Is4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1658481900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Zq/52Q1AcQELK7fLNIKFlPiXkn+EjSXzQy671KOxIOA=;
	b=giB6/y5ZwtlnsK19l7UjBbqCv8jTEaLEDOVZiA3rGpepbLQ8sWOUl+1YRFx/2oe2NKsYkB
	i6quiXjedmak1YCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32F21134A9;
	Fri, 22 Jul 2022 09:25:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id SfjOC+xs2mIPZAAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 22 Jul 2022 09:25:00 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2] nvme: consider also host_iface when checking ip options
Date: Fri, 22 Jul 2022 11:24:56 +0200
Message-Id: <20220722092456.24517-1-dwagner@suse.de>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_022502_151270_5E7AA849 
X-CRM114-Status: GOOD (  11.17  )
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

It's perfectly fine to use the same traddr and trsvcid more than once
as long we use different a host_iface. This is used in setups where
the host has more than one interface but the target exposes only one
IP.

To keep the match logic simple don't allow mixed setups. The user
needs to use host_iface option consistently for all controllers in
such setups.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---


leap154:~ # nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420 

leap154:~ # nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420 
Failed to write to /dev/nvme-fabrics: Operation already in progress
no controller found: failed to write to nvme-fabrics device

leap154:~ # nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420 -f eth1
Failed to write to /dev/nvme-fabrics: Operation already in progress
no controller found: failed to write to nvme-fabrics device

leap154:~ # nvme disconnect -n nvmet-test
NQN:nvmet-test disconnected 1 controller(s)

leap154:~ # nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420 -f eth0

leap154:~ # nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420 -f eth1

 drivers/nvme/host/fabrics.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 604ab0e5a2ad..dc12853d04c9 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -944,7 +944,10 @@ bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 {
 	if (!nvmf_ctlr_matches_baseopts(ctrl, opts) ||
 	    strcmp(opts->traddr, ctrl->opts->traddr) ||
-	    strcmp(opts->trsvcid, ctrl->opts->trsvcid))
+	    strcmp(opts->trsvcid, ctrl->opts->trsvcid) ||
+	    (((opts->mask & NVMF_OPT_HOST_IFACE) &&
+	      (ctrl->opts->mask & NVMF_OPT_HOST_IFACE)) &&
+	       strcmp(opts->host_iface, ctrl->opts->host_iface)))
 		return false;
 
 	/*
-- 
2.37.1


