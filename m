Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF789CA0FF0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Sep 2025 09:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5NNItQtiBSkxwIsvVF62gD4BFcFmFvPJ0ltQD6wGBjM=; b=EWJsKRm4Ji5j2JvzBQWGZoA9ml
	V0YqUe/Oz4xx76Abykh2FMxIRx+4za+prj0mrGl3dpoolJbXTeyf6hf9HBwhiVmsfap/u24DLYfSL
	sxdgCvsYZTw2aihxzsaD1uNfeXk1de6SGAB6kah5icX5Y2vUAfTH4AO8we2RDLpCUDSLYPhTI+bGW
	e/CmHjC7SEwceTkGFGxGh8DkY5KLJRDDRlRJlKuTS78+fdxa9SBeoBbtvHxpnzU1v+7HVGoBJ7yiA
	rMQT9SB99LUJinE9HhImmAk/aT8tyqb7C745zyxsBA3ZzeLqK7BbJRN3/VweZEdY2AKlVOiDr1DKy
	ecaF8T0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut1GD-0000000Bol4-0kE5;
	Mon, 01 Sep 2025 09:55:37 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut0Qc-0000000BgHb-0e6f
	for linux-nvme@lists.infradead.org;
	Mon, 01 Sep 2025 09:02:20 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3047C1F388;
	Mon,  1 Sep 2025 09:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756717336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5NNItQtiBSkxwIsvVF62gD4BFcFmFvPJ0ltQD6wGBjM=;
	b=kEqJM6nywEAUgYQb4LPOCS9x9CjMVjfT2pnsMCSV9DTx/jgNqP8IZLV2t+plzC1sP9wMaL
	GOhKuDM0yWqpfeHp0cfONI9h9TLcBAWteTn9V0Or7jy/w+iMKKO2kGC6yzLNhG0hF6mwka
	bdi0JTTtuJOsZkiBNVwarHRzIqGBH18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756717336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5NNItQtiBSkxwIsvVF62gD4BFcFmFvPJ0ltQD6wGBjM=;
	b=5FxxqrJOXYxi7cIuJhJkfSbGklr2EzNlJDQByDz2Au4l+Js2PvkmKMv5kolMeUygTW4FHp
	T+tOdYG8QsLfJEDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756717336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5NNItQtiBSkxwIsvVF62gD4BFcFmFvPJ0ltQD6wGBjM=;
	b=kEqJM6nywEAUgYQb4LPOCS9x9CjMVjfT2pnsMCSV9DTx/jgNqP8IZLV2t+plzC1sP9wMaL
	GOhKuDM0yWqpfeHp0cfONI9h9TLcBAWteTn9V0Or7jy/w+iMKKO2kGC6yzLNhG0hF6mwka
	bdi0JTTtuJOsZkiBNVwarHRzIqGBH18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756717336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5NNItQtiBSkxwIsvVF62gD4BFcFmFvPJ0ltQD6wGBjM=;
	b=5FxxqrJOXYxi7cIuJhJkfSbGklr2EzNlJDQByDz2Au4l+Js2PvkmKMv5kolMeUygTW4FHp
	T+tOdYG8QsLfJEDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 200681378C;
	Mon,  1 Sep 2025 09:02:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZJoTBxhhtWgnZgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 01 Sep 2025 09:02:16 +0000
Date: Mon, 1 Sep 2025 11:02:15 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.17-rc1 kernel
Message-ID: <7a773833-a193-4243-80f4-fc52243883a9@flourine.local>
References: <suhzith2uj75uiprq4m3cglvr7qwm3d7gi4tmjeohlxl6fcmv3@zu6zym6nmvun>
 <ff748a3f-9f07-4933-b4b3-b4f58aacac5b@flourine.local>
 <rsdinhafrtlguauhesmrrzkybpnvwantwmyfq2ih5aregghax5@mhr7v3eryci3>
 <6ef89cb5-1745-4b98-9203-51ba6de40799@flourine.local>
 <u4ttvhnn7lark5w3sgrbuy2rxupcvosp4qmvj46nwzgeo5ausc@uyrkdls2muwx>
 <629ddb72-c10d-4930-9d81-61d7322ed3b0@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <629ddb72-c10d-4930-9d81-61d7322ed3b0@flourine.local>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250901_020218_341059_95CDC9EE 
X-CRM114-Status: GOOD (  20.71  )
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

On Mon, Sep 01, 2025 at 10:34:23AM +0200, Daniel Wagner wrote:
> The test is removing the ports while the host driver is about to
> reconnect and accesses a stale pointer.
> 
> nvme_fc_create_association is calling nvme_fc_ctlr_inactive_on_rport in
> the error path. The problem is that nvme_fc_create_association gets half
> through the setup and then fails. In the cleanup path
> 
> 	dev_warn(ctrl->ctrl.device,
> 		"NVME-FC{%d}: create_assoc failed, assoc_id %llx ret %d\n",
> 		ctrl->cnum, ctrl->association_id, ret);
> 
> is issued and then nvme_fc_ctlr_inactive_on_rport is called. And there
> is the log message above, so it's clear the error path is taken.
> 
> But the thing is fcloop is not supposed to remove the ports when the
> host driver is still using it. So there is a race window where it's
> possible to enter nvme_fc_create_assocation and fcloop removing the
> ports.
> 
> So between nvme_fc_create_assocation and nvme_fc_ctlr_active_on_rport.

I think the problem is that nvme_fc_create_association is not holding
the rport locks when checking the port_state and marking the rport
active. This races with nvme_fc_unregister_remoteport.

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 3e12d4683ac7..03987f497a5b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3032,11 +3032,17 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)

 	++ctrl->ctrl.nr_reconnects;

-	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE)
+	spin_lock_irqsave(&ctrl->rport->lock, flags);
+	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE) {
+		spin_unlock_irqrestore(&ctrl->rport->lock, flags);
 		return -ENODEV;
+	}

-	if (nvme_fc_ctlr_active_on_rport(ctrl))
+	if (nvme_fc_ctlr_active_on_rport(ctrl)) {
+		spin_unlock_irqrestore(&ctrl->rport->lock, flags);
 		return -ENOTUNIQ;
+	}
+	spin_unlock_irqrestore(&ctrl->rport->lock, flags);

 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: create association : host wwpn 0x%016llx "

I'll to reproduce it and see if this patch does make a difference.

