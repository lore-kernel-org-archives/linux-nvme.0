Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369ECCD1292
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 13:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6NgdroIgyj3bP4JS/E63CxE2JRcGGACl5aHMToE/OPI=; b=R1rXy/l/vX1Qz2Cegp5brIdwr6
	h7Lh0S9xC2mVU/JbjgEC6gkKU5kspsVFc3ZhfMin1QC1RiG6CpxI5wjniWpnByYgv5OOxaAwXfml/
	0tCj651266S/bgRUihSUKG1qxfpQFqE0C+UZ44Z89YZXwTejwaWHnWoDujMT3Z1JrbVgGUi0qtMVG
	0Zth+3uHZNSC1NoUxxcLxLmUPwnzl38uql39eY7cZK0LJH3mVtSiBAKoKWNQtj+kFVgjoR7pIbXTz
	TnmSxLjddnpzzKZxcnckzO32YDVU443UZygF48S1uBEdHtdl6c398h5ziEIca+WnAkdCPnGbW/HOr
	Zd/nhf+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs11y-0000000GJIx-35Qa;
	Wed, 03 Apr 2024 13:51:58 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs11t-0000000GJFE-0TKX
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 13:51:56 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3F3E05CD20;
	Wed,  3 Apr 2024 13:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712152309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6NgdroIgyj3bP4JS/E63CxE2JRcGGACl5aHMToE/OPI=;
	b=dlltcFsosc8+2m9/pMCu20eSQLrSOSzasGBr8lYvgAF3a+g1xLL4JD8Jdc/V6SaN4cbsr4
	vhDkF2G2YT7ZBfISGgVO2BWc0+gwDnfap+aAMLh/NV/iaL4ed+YLy1sJA0YNgTCrhZGuel
	9wrlQt+zsPYAWTNtPrfsC4qkiaZ9VMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712152309;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6NgdroIgyj3bP4JS/E63CxE2JRcGGACl5aHMToE/OPI=;
	b=gxypS6VO2ZQrC725Ai1VI8Ow7aLFTgHIWHw7/eqhxn2YfzTtlzBZm8q4uE8OAxIZX4NHOi
	tO7revuew4e3OwAg==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 219D71331E;
	Wed,  3 Apr 2024 13:51:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id fihfBvVeDWYvUwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 03 Apr 2024 13:51:49 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org,
	Nilay Shroff <nilay@linux.ibm.com>
Cc: Daniel Wagner <dwagner@suse.de>,
	Amit.Engel@dell.com,
	kbusch@kernel.org,
	gjoyce@ibm.com,
	Amit Engel <Amit.Engel@Dell.com>
Subject: Re: [PATCH] fabrics : allow host to create duplicate connections to target
Date: Wed,  3 Apr 2024 15:51:45 +0200
Message-ID: <171215230057.21309.17076148857202676100.b4-ty@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403133438.161916-1-nilay@linux.ibm.com>
References: <20240403133438.161916-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.38 / 50.00];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.08)[63.32%];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_065153_426923_84EA5726 
X-CRM114-Status: UNSURE (   8.10  )
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


On Wed, 03 Apr 2024 19:04:16 +0530, Nilay Shroff wrote:
> Apparently the nvmf connect code doesn't allow creating
> duplicate connections from a host to the same target even
> though user specifies option "--duplicate-connect" or "-D".
> This patch help fix this issue.
> 
> 

Applied, thanks!

[1/1] fabrics : allow host to create duplicate connections to target
      commit: fd8ecb054ce53acae504e54666bec6c9976a82dd

Best regards,
-- 
Daniel Wagner <dwagner@suse.de>

