Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A63C54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 08:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=McjNzVbWLVcLMxAv9J45iM+3v24Kb1Qbrj8kZmKwJbU=; b=SLtg7Y/c5dEHzWKVCPVucSnZI9
	Zj8gbBFYU2dp846SmsvarQHUoN5meHMAByYhQGe2mjmhZP30TKO3SdIaK4xwyI6Dn/lNyyuxsEhJI
	nB3vRm4Hs3r9dP1kGi062NayMmufUSzaJGKEYPc/eabv2mG+KGwD2Eh/3f4OEK7F51IXOwnH++IsJ
	ItOluEUdeQwqGMz9lHdCO/fMxLZomOKbA3DgIRZweQcXbYyYs2zhmD8qSkV9HIcIxoxj4zCcQqtIY
	2P8MO4f1mXqm+pufOpsoJaAp59CpjGxnEydzGe0lJfZSBRjfSmWOwSsx3Af1dO8Y/BTdzIrBTk209
	csRiCbog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplNu-0000000D8M3-00Nr;
	Thu, 28 Mar 2024 08:45:18 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplNg-0000000D8DI-2kij
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 08:45:16 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D36C922C35;
	Thu, 28 Mar 2024 08:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711615500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=McjNzVbWLVcLMxAv9J45iM+3v24Kb1Qbrj8kZmKwJbU=;
	b=sDkWEKgPoWPM6iPzsp6NxY7riDSaDf7gKl7PiUgFWKY0Ot73XKYsgXZEfWSbqpJbH+ZLjk
	6UWSqA9iMynSSZSJ0SWtbCVzMiDnZ3e579ywcNeivgJx2jgk9cbe2cydKInX2GlutAT1HZ
	LQtZ7ITSXOjDvRhMzvk/UDH/z0GhPz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711615500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=McjNzVbWLVcLMxAv9J45iM+3v24Kb1Qbrj8kZmKwJbU=;
	b=W22wfyJwT/Fgk21CCM5gvBoGM7ichP3k53BVwxb5icZByBSNySyjih53s9CYiHQMVeK7ud
	kdeRLkpaCwWyK9Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711615500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=McjNzVbWLVcLMxAv9J45iM+3v24Kb1Qbrj8kZmKwJbU=;
	b=sDkWEKgPoWPM6iPzsp6NxY7riDSaDf7gKl7PiUgFWKY0Ot73XKYsgXZEfWSbqpJbH+ZLjk
	6UWSqA9iMynSSZSJ0SWtbCVzMiDnZ3e579ywcNeivgJx2jgk9cbe2cydKInX2GlutAT1HZ
	LQtZ7ITSXOjDvRhMzvk/UDH/z0GhPz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711615500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=McjNzVbWLVcLMxAv9J45iM+3v24Kb1Qbrj8kZmKwJbU=;
	b=W22wfyJwT/Fgk21CCM5gvBoGM7ichP3k53BVwxb5icZByBSNySyjih53s9CYiHQMVeK7ud
	kdeRLkpaCwWyK9Cg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BEA1713AB3;
	Thu, 28 Mar 2024 08:45:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id tJ8SLQwuBWbpYAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 28 Mar 2024 08:45:00 +0000
Date: Thu, 28 Mar 2024 09:45:00 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, axboe@fb.com, 
	Gregory Joyce <gjoyce@ibm.com>
Subject: Re: [Bug Report] nvme-cli commands fails to open head disk node and
 print error
Message-ID: <j37ytzci46pqr4n7juugxyykd3w6jlwegwhfduh6jlp3lgmud4@xhlvuquadge4>
References: <c0750d96-6bae-46b5-a1cc-2ff9d36eccb3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0750d96-6bae-46b5-a1cc-2ff9d36eccb3@linux.ibm.com>
X-Spamd-Result: default: False [-2.47 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.67)[92.93%]
Authentication-Results: smtp-out1.suse.de;
	none
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_014504_902847_7559D737 
X-CRM114-Status: UNSURE (   9.48  )
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

On Thu, Mar 28, 2024 at 12:00:07PM +0530, Nilay Shroff wrote:
> From the above output it's evident that nvme-cli attempts to open the disk node /dev/nvme0n3
> however that entry doesn't exist. Apparently, on 6.9-rc1 kernel though head disk node /dev/nvme0n3
> doesn't exit, the relevant entries /sys/block/nvme0c0n3 and /sys/block/nvme0n3 are present. 

I assume you are using not latest version of nvme-cli/libnvme. The
latest version does not try to open any block devices when scanning the
sysfs topology.

What does `nvme version` say?

