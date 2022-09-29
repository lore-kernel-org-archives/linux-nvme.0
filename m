Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64397C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 17:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JUlGEDH5/+wrB54h5MUP1fTTL8BShBCFwTd8Tk8FMT0=; b=pMmlde3hchWIBdttgYqB3Ml+us
	FYPkN3ssQgqMzjQqexUSzu4Hs1WnHaUjxUTi4WV21wb1FrmLwe9LiSqmetWDO8htO9gTOJI0hvYwk
	aHbyee4SyVe4ygqYNohDc3Gk+vbzQZFKZ2RK0GyQ2ha8iTrvD+v7DRxkrIL8Ddy/9XI2G9dMWl8/C
	krwOiOWJu265PHAW7I7zgTwdMPNw5GGoGTynYn3EC7zKJUxatruHXPSmgLxV3E7VR6vtE+bjUheMT
	hCsBySmS0ETRW/c5CjYEFa2Hi/PviRMFSI+Muasn/VUFNmZlckLDMnBb1hcmZJz8PMOIprajo5bzv
	Jt0Zg06Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odxDl-004YSD-VF; Thu, 29 Sep 2022 17:21:13 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odx6c-004UFZ-So
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 17:13:52 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5485F21B6B;
	Thu, 29 Sep 2022 17:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664471625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JUlGEDH5/+wrB54h5MUP1fTTL8BShBCFwTd8Tk8FMT0=;
	b=xGxMsHYowszJAMQFuOQYnjmk298f//XwLvvNextoH5wMjFxVDuqSclkP2cHJYPqnbkUUpl
	ol3xdyzWKTpJgpmRbLOIpnyQDLY4/d+IukCfkkXNm5iZb5hi85sLkQIltSEjbIoPVmaqP8
	F7x+bnFkjZwdLNDgecZ41pEbZwhdNUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664471625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JUlGEDH5/+wrB54h5MUP1fTTL8BShBCFwTd8Tk8FMT0=;
	b=eXpOSDUlDSNaBpHT+qZXqlD2vMRDt/KjIRRugOPdqjfUdTzXKpSAxy+Q4RDghXWGiHaAcw
	6LdasjojL5kjguBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 46C4F13A71;
	Thu, 29 Sep 2022 17:13:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id kyE9EUnSNWP0BQAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 29 Sep 2022 17:13:45 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>,
	yi.zhang@redhat.com,
	Tomas Bzatek <tbzatek@redhat.com>
Subject: [RFC v0] nvme: do not log errors for user commands
Date: Thu, 29 Sep 2022 19:13:37 +0200
Message-Id: <20220929171338.10792-1-dwagner@suse.de>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_101351_123274_904A7886 
X-CRM114-Status: GOOD (  10.31  )
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

User space might issue commands which fail. Currently this gets logged
and irretates users.

libnvme's nvme_scan_topology function is using Namespace
Identification Descriptor list (CNS Value 0x03) for discovering. It
handles the case where it fails but the kernel logs this as error:

 nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) DNR
 nvme1: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) DNR

Thus filter out error logs for user commands.

Link: https://github.com/linux-nvme/libnvme/issues/485
Reported-by: yi.zhang@redhat.com
Reported-by: Tomas Bzatek <tbzatek@redhat.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

Only compile tested, just wanted to ask if this approach would be acceptable?

 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f2786a6b1a85..b86b3b7e37cc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -325,6 +325,9 @@ static void nvme_log_error(struct request *req)
 		return;
 	}
 
+	if (nr->flags & NVME_REQ_USERCMD)
+		return;
+
 	pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%s\n",
 			   dev_name(nr->ctrl->device),
 			   nvme_get_admin_opcode_str(nr->cmd->common.opcode),
-- 
2.37.3


