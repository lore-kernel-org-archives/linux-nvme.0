Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8900CD1288
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 09:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lIM9Bnyln2BPR3WZLcTWcvsiY+xLLtbp4TuzdMOL+QI=; b=3pFIT3CkmF+Tz6agtpmebsSr8Q
	a01B+7ASWGvG2qxuygF1cxmMEba2EaDOAhRZH5mOxDOEleMby16QbBwC11jNsA+V1WkNdP0hI7pf/
	/sxED7B9pvcfkWc61AaCILyCDuC8ZPavsskrshWbMi1trE2BSfY6OV+23/CbP0EbWFdVtM2k7TbdI
	Qgsy9LMOofnTxDp9of0sPVYM1/AfRHu5IIaQJE/yGvitYCb43XZaLfSbO3zUvwv/UVjkoOGdtraEL
	zjeOMx5Lnc1C8n5+0gL3d1n6psPlpg23PGLdLNa28F3XA+d5OfhrVIl71AjMtNVyKEp8xobJy403/
	2sVeobaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrxNd-0000000FL8t-1KRS;
	Wed, 03 Apr 2024 09:58:05 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrxNW-0000000FL6B-2M6A
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 09:58:03 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C7A3A5CAF7;
	Wed,  3 Apr 2024 09:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712138275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIM9Bnyln2BPR3WZLcTWcvsiY+xLLtbp4TuzdMOL+QI=;
	b=k2c9AtEE2VTLUh4eQV8pMSQyadRcrQl2P+6yJm7nc707SsaO/C2t76LDVJDquWbS+m+pQ0
	ISy+/gC6wVmoO2rZfLIjv5NbjnM/mF7daD39HuyAkg+UKHSWnKjlEwz2MlgDXJs6AL0VLF
	8qFIlbgIYHR6h8PxamyN0W67rXuzxJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712138275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIM9Bnyln2BPR3WZLcTWcvsiY+xLLtbp4TuzdMOL+QI=;
	b=sGpEnRKbLmnyZ9J1KKPKKWssrCwGJvDKYbD08bgu1N9wEsKt24pVzsmaNWO28jNCuJN+o9
	8khYEYYHxRlleNCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B68401331E;
	Wed,  3 Apr 2024 09:57:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gt4TKyMoDWYYBAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 03 Apr 2024 09:57:55 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org,
	Nilay Shroff <nilay@linux.ibm.com>
Cc: Daniel Wagner <dwagner@suse.de>,
	kbusch@kernel.org,
	gjoyce@ibm.com
Subject: Re: [PATCH] tree: Add NVM subsystem controller identifier
Date: Wed,  3 Apr 2024 11:57:48 +0200
Message-ID: <171213825993.4820.5202185582244437768.b4-ty@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326065752.164286-1-nilay@linux.ibm.com>
References: <20240326065752.164286-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-2.98)[99.92%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:98:from];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Queue-Id: C7A3A5CAF7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_025758_813242_E9AFE723 
X-CRM114-Status: GOOD (  10.33  )
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


On Tue, 26 Mar 2024 12:27:23 +0530, Nilay Shroff wrote:
> This commit introduces a field "cntlid" for controller,
> that contains the NVM subsystem unique identifier assigned
> to each controller device in an NVM subsystem.
> 
> While attaching a namespace, typically user needs to specify the
> controller identifier (cntlid). The cntlid could be referenced from
> sysfs (/sys/class/nvme/nvmeX/cntlid) but it would be nice to have
> a direct option.
> 
> [...]

Applied, thanks!

[1/1] tree: Add NVM subsystem controller identifier
      commit: d638f037623742003c5ef0ba6127b981e925b351

Best regards,
-- 
Daniel Wagner <dwagner@suse.de>

