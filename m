Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35504CD11DD
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 13:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o8T73FQvWrWq2T5wtADh9xrS/dpmmUCLPNtqAXUPyzs=; b=DpF5TxwkzI/w8WeG3yCK01C7FL
	pZmbyWnir5HaOdD+gbIufEoQ4ahNpR651i+pV5/yyR8dgF4LUv2Zu+TYv6fdGxj0UYxjrdEKPB5SG
	6/wFLxWk4yI9jkZmoTOH5WqNo6/0EBJM/GaO+EwvGO5YNEmxZZ6A06ZUlqRuZvOycWHfqys3xNIYh
	Rjs6Q9d8bPzZRLUcu44s2DmeQ/GChd/tFZXhTEX9XqmdFJumK4KSKLypfAASUE/p5rKRwjxwrgMQE
	ykHq2oqcmJyPhROEPorFUtRNe+FXM+6zbR5CHlPnlv3a7ZFWwNQtO5/UPK0cEaekTLS3fdBbdolSH
	HcGOO6lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6w5-00000004geX-2yAC;
	Tue, 26 Mar 2024 13:33:53 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6vq-00000004gcU-031y
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 13:33:50 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 94D735D5B7;
	Tue, 26 Mar 2024 13:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711460015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o8T73FQvWrWq2T5wtADh9xrS/dpmmUCLPNtqAXUPyzs=;
	b=xafBJleRKFqEd0lGxPI1SX/KxZQiXBS/WVJRvv/ne8q2S9BRDRR5IX7OfiJIazUQ94+zb0
	jHXCmzrG91+f+1M6P98LDks7ntFnUt+dZiw2f4yES93cCw5z1eep30o79aLj3lMNkXV3fX
	66OWE9ss5P7DlwgYgNxref0XAnf6vsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711460015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o8T73FQvWrWq2T5wtADh9xrS/dpmmUCLPNtqAXUPyzs=;
	b=8p7CgKbQ4hB3e0+iUFQxK9mRzobpYESHg6OC0crwzzQI2FDLMI+r9rtTZ+7PEwQK9Ior2d
	o5llviSIgbDuChAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711460015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o8T73FQvWrWq2T5wtADh9xrS/dpmmUCLPNtqAXUPyzs=;
	b=xafBJleRKFqEd0lGxPI1SX/KxZQiXBS/WVJRvv/ne8q2S9BRDRR5IX7OfiJIazUQ94+zb0
	jHXCmzrG91+f+1M6P98LDks7ntFnUt+dZiw2f4yES93cCw5z1eep30o79aLj3lMNkXV3fX
	66OWE9ss5P7DlwgYgNxref0XAnf6vsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711460015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o8T73FQvWrWq2T5wtADh9xrS/dpmmUCLPNtqAXUPyzs=;
	b=8p7CgKbQ4hB3e0+iUFQxK9mRzobpYESHg6OC0crwzzQI2FDLMI+r9rtTZ+7PEwQK9Ior2d
	o5llviSIgbDuChAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 782DC13587;
	Tue, 26 Mar 2024 13:33:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id +TD8G6/OAmaiOwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:33:35 +0000
Date: Tue, 26 Mar 2024 14:33:34 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv4 0/7] nvmet: debugfs support
Message-ID: <p6epmhukqjaiomqvxwgpwkoisg25yt46d5texh3sm4lkoump6h@b6ovzgutko77>
References: <20240326120342.105740-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326120342.105740-1-hare@kernel.org>
X-Spamd-Result: default: False [-3.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.71)[98.74%]
Authentication-Results: smtp-out2.suse.de;
	none
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_063338_301305_263C4C77 
X-CRM114-Status: UNSURE (   7.08  )
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

I've gave it a quick test run with blktests triggering resets. Works as
expected.

Tested-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>

