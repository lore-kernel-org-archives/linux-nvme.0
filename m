Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD29CD128A
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 10:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MFTTPSLVoCpbU5T4uiX7ZKEb2DOSwx/mwo8RxYKdm8A=; b=0PFpYUziOAjczz5lk/Yr4y9oXJ
	kOPT+mIq8S3WTAhkrguXXf9BDJuw7erovEGFdA0RgjjZTuHnWx58+q8sVQmd1xitDBM6EyIwaSJ32
	We1nI+ayCR8Jo9ty5VdktG5cqa5h1GdQD+QltJULKBtVQIxp6C4gxFAttI427WJUM48EgGEDSIz0b
	t3RKk/np+wzmmay1oJBpaKzy7Vn8hLB99jER1JxqlMwoHhcox5biPbvFVBo5v2t8j4TZpoF5x3CdE
	8xj/KqCP8NsHVSBii6A0M40IpOVJX7L9Ww8WreiPjSlfv1k671kjaD7nr/BdQN/JclFAMnb27a6WN
	y5osoLSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrxfQ-0000000FRFJ-32OA;
	Wed, 03 Apr 2024 10:16:28 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrxfL-0000000FRCN-0MzI
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 10:16:26 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 32B8B351F7;
	Wed,  3 Apr 2024 10:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712139379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MFTTPSLVoCpbU5T4uiX7ZKEb2DOSwx/mwo8RxYKdm8A=;
	b=F5P0CQ2OO6x9glNG/hI9Cxb/PUKaEaffh5zRuZsZEw6UmputusdB0QNwds8gzUs+BCxwAs
	WbTZbHhPieRk3Ub1VB3OCQaQRFFJJxrwpopnXvRmkMihtVcJvzM8VudU1Y7n/r2GDKBwZv
	qaagcvlpnmUfCXjIHfDusTJA5y2Qb9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712139379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MFTTPSLVoCpbU5T4uiX7ZKEb2DOSwx/mwo8RxYKdm8A=;
	b=CUEXJ5wTbXaCIc2h8V/t9tF7zSKMUI58JZ4huJBKbguxKWQsSz6ah3Km5dlC4V8IAjp84D
	ygtip69BO6/3/qBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E3F81331E;
	Wed,  3 Apr 2024 10:16:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id KPMbB3MsDWbICgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 03 Apr 2024 10:16:19 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>,
	Linux-nvme <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Israel Rukshin <israelr@nvidia.com>
Cc: Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] fabrics: Fix fast_io_fail_tmo option
Date: Wed,  3 Apr 2024 12:16:15 +0200
Message-ID: <171213936329.6483.4612518639759360071.b4-ty@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <1712060292-11054-1-git-send-email-israelr@nvidia.com>
References: <1712060292-11054-1-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.78 / 50.00];
	BAYES_HAM(-0.52)[80.40%];
	NEURAL_HAM_SHORT(-0.15)[-0.743];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from,2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 32B8B351F7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_031623_293619_0990376F 
X-CRM114-Status: UNSURE (   9.15  )
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


On Tue, 02 Apr 2024 12:18:12 +0000, Israel Rukshin wrote:
> The option was partially removed by a refactoring commit.
> Return it back, because it is still supported by the kernel
> driver.
> 
> 

Applied, thanks!

[1/1] fabrics: Fix fast_io_fail_tmo option
      commit: 14ee80dfe872e138dced8eb3f33aee46329eb078

Best regards,
-- 
Daniel Wagner <dwagner@suse.de>

