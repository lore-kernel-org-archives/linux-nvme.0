Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36396C54E68
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 13:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KD1qSGcmdEIYXZfgtS9DhxyACY9ZKoYaNPq4TP51Ecg=; b=D+RtlC9phxKAF9kcIQEoOxdhA7
	JG4fE8gNPlwKTSf9rND1sCCzuh8eKsEUplJkjb0dcS0HxgtI4miAs/htN0ENOz8s/BBWVzHV34iG/
	1T0ir0TaOr6B0YUDKYid3A9l2IHpu5ohPa8sildawJtrc51tLX0Rnnk2QAmzfLnfiEnv/1nx/8wKh
	LKtkBefeuePYHghvkXgCKSZHx3kxf8bqmDPbJRZAKZ8Ls7szvnHyD6FcRv3+RfmfFcIKdG3EB01X2
	XoXhbstaJijezwNANWgNJjAi9RpH8hs9W9/2ZjCi9rcDZln/Lhd542ms/3fXLhx2yu9HgamhEYeZI
	PynrdpRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnImR-000000039tJ-1Jqb;
	Thu, 21 Mar 2024 13:48:27 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnImN-000000039sN-23SK
	for linux-nvme@lists.infradead.org;
	Thu, 21 Mar 2024 13:48:26 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 800C43748C;
	Thu, 21 Mar 2024 13:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711028897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KD1qSGcmdEIYXZfgtS9DhxyACY9ZKoYaNPq4TP51Ecg=;
	b=WxWu1HK9MsEAU2pSi3bfi7HfSh7pU/mEDeljFf/xl6y2VInNTdfkAY8HS/X6HIHY7tm8D5
	CwtE8De0Uo6TnUUWHEqKqRV7LhtdwgrS09znhfjHYubG0laIfs64QY+0a90/o0j1dDm8YQ
	p3WQQEWOa/vkeRqLpBme9ZoSVCjUWlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711028897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KD1qSGcmdEIYXZfgtS9DhxyACY9ZKoYaNPq4TP51Ecg=;
	b=JaFcdrHJt/MJU4dNX4TMnuZAGilq0F9XfJ+IAD7Ku6Q2vS7hyyGRgax8z3JffWs+UbL1Af
	wAwWE4B5lYrGdgBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711028897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KD1qSGcmdEIYXZfgtS9DhxyACY9ZKoYaNPq4TP51Ecg=;
	b=WxWu1HK9MsEAU2pSi3bfi7HfSh7pU/mEDeljFf/xl6y2VInNTdfkAY8HS/X6HIHY7tm8D5
	CwtE8De0Uo6TnUUWHEqKqRV7LhtdwgrS09znhfjHYubG0laIfs64QY+0a90/o0j1dDm8YQ
	p3WQQEWOa/vkeRqLpBme9ZoSVCjUWlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711028897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KD1qSGcmdEIYXZfgtS9DhxyACY9ZKoYaNPq4TP51Ecg=;
	b=JaFcdrHJt/MJU4dNX4TMnuZAGilq0F9XfJ+IAD7Ku6Q2vS7hyyGRgax8z3JffWs+UbL1Af
	wAwWE4B5lYrGdgBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EAC213976;
	Thu, 21 Mar 2024 13:48:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wlq0GaE6/GVWYgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 13:48:17 +0000
Date: Thu, 21 Mar 2024 14:48:16 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, gjoyce@ibm.com
Subject: Re: [PATCH libnvme] libnvme : record the nvme pci adapter physical
 slot
Message-ID: <l5plt4rl6hxyss4g6ucc73cn5qzntmqpecjzfdsumw7m7vq6f6@2maivyhuusl5>
References: <20240321132424.3362887-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321132424.3362887-1-nilay@linux.ibm.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WxWu1HK9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JaFcdrHJ
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.84 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.83)[94.02%]
X-Rspamd-Queue-Id: 800C43748C
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_064823_704319_237E3735 
X-CRM114-Status: GOOD (  10.26  )
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

On Thu, Mar 21, 2024 at 06:46:17PM +0530, Nilay Shroff wrote:
> There is a subtle bug in the nvme controller physical
> slot lookup code due to which the readdir() prematurely
> aborts the lookup and hence libnvme fails to record the
> pci slot address of the nvme controller. This patch helps
> to fix this issue.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Patch applied. Thanks!

