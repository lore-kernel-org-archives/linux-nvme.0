Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BDCCD1284
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Apr 2024 10:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IIAwJz0GObbxBDJn2wJSoNHuQav7F5P1yXLLLey4EDo=; b=CngGK/AKM29iGJHkwkw8xUSCGX
	SfOrTqtnCGDiW72cOOuwe0qRykxdJAJVkpD0bjXP32enBUSVpy6/niVS7q6CJNs2cupKdGEiqfFO+
	GsAyPTvYq1CcpHCElUC2xYI25nbdNFk+p95cUPAvds/2FVp5nS2XsZrYcEWQRjsXJcMBREgiSRIWe
	FgYTBdDl8JgWWqCG8zUddPC3Z4BXyYYvAxvPr9vX3CGMIHFsQmxFBpmwvCtMj9zgSCHRDVMmXDCg8
	/3o3hhbEM4BBxXGvP8yL9+LiY8FFbjburK7m4RdBER2gY8vT5aphBeCAhcv8lYwiR6rBCC/VgrXsD
	QguQRwSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ru8Nd-00000001MFn-2PED;
	Tue, 09 Apr 2024 10:07:05 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ru8NV-00000001ME4-2r4z
	for linux-nvme@lists.infradead.org;
	Tue, 09 Apr 2024 10:07:00 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2ADC220909;
	Tue,  9 Apr 2024 10:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712657216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IIAwJz0GObbxBDJn2wJSoNHuQav7F5P1yXLLLey4EDo=;
	b=TQ4w6Fx+dnIX/gZHPIOPkec9h6w1VZIeiWblv8YjIWpaFvtogP7VpvxGF1M4msCjxVJBuh
	lBjNUWJHoxrXtiHwbUexZADN/aduVTjRGf7AE6yYFTRmMjwphR4ratGpOr+TqgdQvAA+6R
	ajRyZkt92NcchQrxey5XQnK2EHD0z0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712657216;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IIAwJz0GObbxBDJn2wJSoNHuQav7F5P1yXLLLey4EDo=;
	b=fe/R8IS80RHj3mpNrqXriHkkbo0Xi4JH9NspRjex6YPTGbI2Gy/hdfV/5bbu7vt9WwWunw
	vUQPDG+1GXl3pjDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TQ4w6Fx+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="fe/R8IS8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712657216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IIAwJz0GObbxBDJn2wJSoNHuQav7F5P1yXLLLey4EDo=;
	b=TQ4w6Fx+dnIX/gZHPIOPkec9h6w1VZIeiWblv8YjIWpaFvtogP7VpvxGF1M4msCjxVJBuh
	lBjNUWJHoxrXtiHwbUexZADN/aduVTjRGf7AE6yYFTRmMjwphR4ratGpOr+TqgdQvAA+6R
	ajRyZkt92NcchQrxey5XQnK2EHD0z0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712657216;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IIAwJz0GObbxBDJn2wJSoNHuQav7F5P1yXLLLey4EDo=;
	b=fe/R8IS80RHj3mpNrqXriHkkbo0Xi4JH9NspRjex6YPTGbI2Gy/hdfV/5bbu7vt9WwWunw
	vUQPDG+1GXl3pjDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D7A813253;
	Tue,  9 Apr 2024 10:06:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GdLZAUATFWZ+TgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 09 Apr 2024 10:06:56 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org,
	Nilay Shroff <nilay@linux.ibm.com>
Cc: Daniel Wagner <dwagner@suse.de>,
	kbusch@kernel.org,
	gjoyce@ibm.com
Subject: Re: [PATCH nvme-cli] nvme-print: Print cntlid number for controller
Date: Tue,  9 Apr 2024 12:06:49 +0200
Message-ID: <171265719902.16891.1124257166325374631.b4-ty@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405121057.297071-1-nilay@linux.ibm.com>
References: <20240405121057.297071-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.67 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	BAYES_HAM(-0.16)[69.43%];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2ADC220909
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_030657_887714_57E76B8C 
X-CRM114-Status: UNSURE (   7.39  )
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


On Fri, 05 Apr 2024 17:40:36 +0530, Nilay Shroff wrote:
> Print the controller identifier number (cntlid) for the
> nvme controller. The cntlid is printed if nvme list
> verbose is specified.
> 
> 

Applied, thanks!

[1/1] nvme-print: Print cntlid number for controller
      commit: 764b9a18d67f08f9f9cbe5302826550a3bb2d270

Best regards,
-- 
Daniel Wagner <dwagner@suse.de>

