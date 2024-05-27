Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128BFC41513
	for <linux-nvme@archiver.kernel.org>; Mon, 27 May 2024 05:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LmcGjsJZ463IkrT5oXhaiEtlofZD3BPMewR5/JX7cYo=; b=iVZSaPNLy94cGlz3XCab4fs4lw
	yvr2STDIsaXlTt3AP3Qd2NUfxUy87ZMEXjHeQ/P354cW8uUiwnHJWHwXBxi8biGcZS8lu5go6Ez8t
	hvGlmcLus3dMeV9+zXElM1lJNgXijcZBok93rhiab9LC07V2PYyBp7fztT3K3XR+XJnWn+wKFWV8i
	C8+9mEzebpfs7a/sL7ffvKx8YQPW6dNAZ9XebaMtNPrq5RSeqPCmo4wY7xfRnYaMdN7Y30DctHnnZ
	ABbQw7fC94nZWBpZee7EllCjkTlb+ri8YgxdRCDOogENq2K2Hhnf2IHeq6TvZFHOI0q1/luZ+DVaz
	9KdVzT0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBSiC-0000000DoXb-0otw;
	Mon, 27 May 2024 05:15:56 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBSi7-0000000DoV0-1e3R
	for linux-nvme@lists.infradead.org;
	Mon, 27 May 2024 05:15:53 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4511121C4A;
	Mon, 27 May 2024 05:15:45 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3185C13A6B;
	Mon, 27 May 2024 05:15:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /RJrCgEXVGanYgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 27 May 2024 05:15:45 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 6/7] nvme-fcloop: implement 'host_traddr'
Date: Mon, 27 May 2024 07:15:24 +0200
Message-ID: <20240527051525.762-7-dwagner@suse.de>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527051525.762-1-dwagner@suse.de>
References: <20240527051525.762-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 4511121C4A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240526_221551_916707_F618FA3A 
X-CRM114-Status: GOOD (  11.84  )
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

From: Hannes Reinecke <hare@kernel.org>

Implement the 'host_traddr' callback to display the host transport
address for nvmet debugfs.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fcloop.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 913cd2ec7a6f..e1abb27927ff 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -492,6 +492,16 @@ fcloop_t2h_host_release(void *hosthandle)
 	/* host handle ignored for now */
 }
 
+static int
+fcloop_t2h_host_traddr(void *hosthandle, u64 *wwnn, u64 *wwpn)
+{
+	struct fcloop_rport *rport = hosthandle;
+
+	*wwnn = rport->lport->localport->node_name;
+	*wwpn = rport->lport->localport->port_name;
+	return 0;
+}
+
 /*
  * Simulate reception of RSCN and converting it to a initiator transport
  * call to rescan a remote port.
@@ -1074,6 +1084,7 @@ static struct nvmet_fc_target_template tgttemplate = {
 	.ls_req			= fcloop_t2h_ls_req,
 	.ls_abort		= fcloop_t2h_ls_abort,
 	.host_release		= fcloop_t2h_host_release,
+	.host_traddr		= fcloop_t2h_host_traddr,
 	.max_hw_queues		= FCLOOP_HW_QUEUES,
 	.max_sgl_segments	= FCLOOP_SGL_SEGS,
 	.max_dif_sgl_segments	= FCLOOP_SGL_SEGS,
-- 
2.45.1


