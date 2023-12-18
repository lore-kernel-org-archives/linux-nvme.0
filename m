Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14696C46CCD
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 13:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3niOTr287wbxE1Uq7P+/x2M0WDmk0616TQyYeAL9hFI=; b=BsETnZ5xnPZFIPaHIr9iY73gPr
	Ye4hz8w8kaxVEmOJDannqHB7G5JDU6iEdXT2oH0QRgUNiESmMVn/JEQbPabLDbepnJsCrs+KtXIzg
	1cumG6FqNHybck6tTTTfHm3AGpGAZVPgbuxSd1PrrYdS5cllXDXpk69lJvz2OiFeisSqgZ9Gz3IMP
	HbXq52AJFnYhg5sIdQ8jkY7vQtpgi/cG26RYTVhTuTFM+kIDLWqKO7pGHY9LXBv6B6rrHZtf74a/B
	99TkTRgSAh/oi4YV6vMpAHnelz7oQskiooeRsj3put1uXqakt641aB9BG8xlLNEf+l2Df/amX6yZK
	HWJJTjGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFE9V-00AwXy-2O;
	Mon, 18 Dec 2023 13:59:25 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFE9S-00AwX4-1q
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 13:59:24 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 24CC621DBC;
	Mon, 18 Dec 2023 13:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702907959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3niOTr287wbxE1Uq7P+/x2M0WDmk0616TQyYeAL9hFI=;
	b=bUgZWf4CU3rQktfB3pvNXvhTdPSbjsnzdBXB5l81HR5xIToC4sSarA9Qr67qyMXGbWUapY
	2XfYdX/6tWuryOHneY3xSb5gsOnwlBjvBaHOkGhsa3KIm34o5Lyl4MTjtNZsFYm2cCyLvz
	M8IRO6walkCxR0yHraABd+wIPkR3bb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702907959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3niOTr287wbxE1Uq7P+/x2M0WDmk0616TQyYeAL9hFI=;
	b=sm1j86YlZLrNy09kSafwjyXaQNwdGJUYNQa+CiE1bwEMXmwv3BUmylVp6f90+zCtmUXzG8
	KvFqJHdP/dCXneBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702907959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3niOTr287wbxE1Uq7P+/x2M0WDmk0616TQyYeAL9hFI=;
	b=bUgZWf4CU3rQktfB3pvNXvhTdPSbjsnzdBXB5l81HR5xIToC4sSarA9Qr67qyMXGbWUapY
	2XfYdX/6tWuryOHneY3xSb5gsOnwlBjvBaHOkGhsa3KIm34o5Lyl4MTjtNZsFYm2cCyLvz
	M8IRO6walkCxR0yHraABd+wIPkR3bb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702907959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3niOTr287wbxE1Uq7P+/x2M0WDmk0616TQyYeAL9hFI=;
	b=sm1j86YlZLrNy09kSafwjyXaQNwdGJUYNQa+CiE1bwEMXmwv3BUmylVp6f90+zCtmUXzG8
	KvFqJHdP/dCXneBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E6B013BC8;
	Mon, 18 Dec 2023 13:59:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id xk/lAjdQgGX4ZAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 18 Dec 2023 13:59:19 +0000
Date: Mon, 18 Dec 2023 14:57:01 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: ioccsz and iorcsz check failing
Message-ID: <p5sosvqw3z4bajhhobw2eng73dfk6drbjgste4hrik3te4wie4@wxytk76vjlim>
References: <6ib6nyftuap3ubf7uryt6sndmomfif47nkforsitadbda2pdkb@ie35lozrsiqf>
 <ZXyWKKhaDUpyOXsK@kbusch-mbp.dhcp.thefacebook.com>
 <74327ed0-63f6-4e9e-9d7c-2bf0eaf264d3@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74327ed0-63f6-4e9e-9d7c-2bf0eaf264d3@grimberg.me>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.81 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.01)[87.28%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_055922_926270_E2C18341 
X-CRM114-Status: GOOD (  13.39  )
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

On Mon, Dec 18, 2023 at 11:59:32AM +0200, Sagi Grimberg wrote:
> Is anything else in the identify wrong, or is it just these
> fabrics fields?

So what I am seeing on the wire are a few fabrics commands (connect, get
property) followed by the nvme id ctrl command (opcode 0x6).

 nvmet: nvmet_req_init:962
 nvmet: nvmet_parse_admin_cmd:1011
 nvmet: nvmet_parse_discovery_cmd:359 opcode 6

This calls then nvmet_execute_disc_identify, so adding

--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -249,6 +249,7 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
 {
        struct nvmet_ctrl *ctrl = req->sq->ctrl;
        struct nvme_id_ctrl *id;
+       u32 cmd_capsule_size;
        u16 status = 0;

        if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
@@ -289,6 +290,17 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
                id->sgls |= cpu_to_le32(1 << 2);
        if (req->port->inline_data_size)
                id->sgls |= cpu_to_le32(1 << 20);
+       /*
+        * Max command capsule size is sqe + in-capsule data size.
+        * Disable in-capsule data for Metadata capable controllers.
+        */
+       cmd_capsule_size = sizeof(struct nvme_command);
+       if (!ctrl->pi_support)
+               cmd_capsule_size += req->port->inline_data_size;
+       id->ioccsz = cpu_to_le32(cmd_capsule_size / 16);
+
+       /* Max response capsule size is cqe */
+       id->iorcsz = cpu_to_le32(sizeof(struct nvme_completion) / 16);

        id->oaes = cpu_to_le32(NVMET_DISC_AEN_CFG_OPTIONAL);


seems to do the trick for nvme-tcp and nvme-fc. Is this the right fix?

