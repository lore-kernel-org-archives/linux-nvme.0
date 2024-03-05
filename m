Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031A5C5478C
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 07:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=okZqsyVkJlLTlOrE/hSiaocDDKPy/+6d9gsnodh9WM8=; b=dTfhAf9T3g+Dne8H2jZuv+Wllv
	e6Ebud189vajmWZwA0f+jUyZPwev/xvF5wQd59LD34pFNsJHZOZEvoBMC813wAvYdW90hBh1Stc2n
	ODSPlPW9ypLu5H/4pqHY9gq0scAGzsjxVgKK8TszyDyajXnaoDTJi/2SK0gKxInizzDIdW/gkLFH+
	0YXB/pvd07wwrsOSU1smmg5CSo8kjjBspqYpAPanY0mhyjXi797J8zKzJqsF0EH9Md6vO1t/+xwA0
	ZlSYnAjYVzydmcMKiypwTlALWQX4wNx1e1TyETIJXrwYW3aZx3Bj5HbQPVm/e1CWXO2dY9k/7Slw4
	UXnGcqmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhP6j-0000000CKWz-2l1j;
	Tue, 05 Mar 2024 07:21:01 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhP6e-0000000CKVI-3ULK
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 07:21:00 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 590EF6793D;
	Tue,  5 Mar 2024 07:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709623254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=okZqsyVkJlLTlOrE/hSiaocDDKPy/+6d9gsnodh9WM8=;
	b=odRIbWln/YWyT6IC+esj97wAnzsxP2WPxrg631DqcVHs4fFA6YB6LgqcUjp9XSNzM/fulx
	XxWNUyLy0dHY3hEVhy5fGr+QBEmm3hL8aaI+sGXazfKvLdCQV2EWFV6TWLELOsTE6s0zBK
	ovm3acAY/E9Qe6yH3eP+XHxYIZJze2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709623254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=okZqsyVkJlLTlOrE/hSiaocDDKPy/+6d9gsnodh9WM8=;
	b=hTlBiOMJ0qMlvicOHLJ+8hev66oJ4UbDWVL1Ah3evEwZ80VjGC1cOlapz/4G6KwJpEu/5o
	ZHaVXtHGi5G/JvDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709623254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=okZqsyVkJlLTlOrE/hSiaocDDKPy/+6d9gsnodh9WM8=;
	b=odRIbWln/YWyT6IC+esj97wAnzsxP2WPxrg631DqcVHs4fFA6YB6LgqcUjp9XSNzM/fulx
	XxWNUyLy0dHY3hEVhy5fGr+QBEmm3hL8aaI+sGXazfKvLdCQV2EWFV6TWLELOsTE6s0zBK
	ovm3acAY/E9Qe6yH3eP+XHxYIZJze2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709623254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=okZqsyVkJlLTlOrE/hSiaocDDKPy/+6d9gsnodh9WM8=;
	b=hTlBiOMJ0qMlvicOHLJ+8hev66oJ4UbDWVL1Ah3evEwZ80VjGC1cOlapz/4G6KwJpEu/5o
	ZHaVXtHGi5G/JvDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 37F8A13466;
	Tue,  5 Mar 2024 07:20:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qx/6DNbH5mW+SQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 05 Mar 2024 07:20:54 +0000
Date: Tue, 5 Mar 2024 08:20:54 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Re: [PATCH blktests v2 0/2] make nvme/048 checks more robust
Message-ID: <24jc4uupde6hl75agcdqbjhjeivqmzx2ejohsx3luaearmlasr@ayd64zsnee7n>
References: <20240304134826.31965-1-dwagner@suse.de>
 <6ijuychwshzssoorymvko2b2aycmu5x5oc6zi6j2yzubsegkac@qlg4hs7ii7kp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ijuychwshzssoorymvko2b2aycmu5x5oc6zi6j2yzubsegkac@qlg4hs7ii7kp>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=odRIbWln;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hTlBiOMJ
X-Spamd-Result: default: False [-1.09 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.28)[89.93%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 590EF6793D
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240304_232057_044613_FE65EDFC 
X-CRM114-Status: UNSURE (   9.11  )
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

On Tue, Mar 05, 2024 at 01:29:18AM +0000, Shinichiro Kawasaki wrote:
> Of note is that I removed the left if block in nvmf_check_queue_count(), which I
> believe unnecessary.

This was also what I did. But somehow I managed to send out the wrong
version. Thanks for fixing it!

