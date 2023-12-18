Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2536C35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 16:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I2rAwz7LPpCk4EbZE+VaN+BBhYV0IZlo84PrZ/duFPE=; b=PLjaK+c69FbiQxUaUN3iBWoHhp
	yuU6RwKYS86K3Sd5z1Enf6sf2R9Iz0RdQbNka0ClZkjHmmL5G73EMEfh2eG2z33db1r6DF2G3Hmk+
	iNF9dyXKCtxaCyE/5pATwogBCfyF9p3F0unabxvmxI1RXHaPhyf2fuuvsHcZaL7Wdzx0u38xSMYVb
	Zg+oVS0khzI6/reTpV67nDD8f098DJY5XUpzpqGpsI82Blj/X8Ke5GvtWYIjvqiQcQmhqsKm7gtJB
	Yral1qfbc9C00VKF412dmILyatNQIWk63/v5tVQQud570rzTgCGIo2XnB4J1pO3+uQzUdWbaHgDKO
	I28fg90g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFGZ8-00BSyA-28;
	Mon, 18 Dec 2023 16:34:02 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFGZ5-00BSxX-1E
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 16:34:01 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 855801FD49;
	Mon, 18 Dec 2023 16:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702917237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I2rAwz7LPpCk4EbZE+VaN+BBhYV0IZlo84PrZ/duFPE=;
	b=i1qqcN9m8wUSXMq4lXhAQ5mz4IKqAbDozYeHTprolwonjUJjwUEnwxH52USkcIabaiccIQ
	llAo7dfYP3IimPvrC3WzWTK0cbSx6HJ4xNAlu8DbmaZ2owVm1p9C6lD9b2lpt8AMTz1IMX
	4t9jAr1tjnP4XvWVb5caGeFL/SxwK3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702917237;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I2rAwz7LPpCk4EbZE+VaN+BBhYV0IZlo84PrZ/duFPE=;
	b=jRfs1WssbrSjqxuiuZ+kGSGxlJPspVgHUW8biOUEXU6wkTcc9QvOI13Ls+FyShvpkNd4XP
	ML0QjWvJOi6UYnCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702917236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I2rAwz7LPpCk4EbZE+VaN+BBhYV0IZlo84PrZ/duFPE=;
	b=MlbLBbEKXDp8AHnrKNraDTLI4t9Tw1hi3wQ3BZBsXQ0C6KFF7sOKYYwcZXvP+0FzttEDP5
	jnrk1UdfJHM2m1Ng3dGScUzvuQQqNeuaWQQLn2fRjNtBiAwkbNlSSQwPcPRPWkKYg3By7k
	74chDSNL0laVj4lg8lDbWzTedAJz10s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702917236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I2rAwz7LPpCk4EbZE+VaN+BBhYV0IZlo84PrZ/duFPE=;
	b=p+t7bg1/IokIjyNCileJLt59QSuHt4YAfon9M+lIIR8kDir1Q7SxlMnG1ndiTnRIsAzqyn
	ZbkcT6prgLZAboCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7546E13927;
	Mon, 18 Dec 2023 16:33:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 5h0sG3R0gGVyCgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 18 Dec 2023 16:33:56 +0000
Date: Mon, 18 Dec 2023 17:31:37 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, 
	james.smart@broadcom.com, Keith Busch <kbusch@kernel.org>, 
	Maurizio Lombardi <mlombard@redhat.com>, Michael Liang <mliang@purestorage.com>
Subject: Re: [PATCH] Revert "nvme-fc: fix race between error recovery and
 creating association"
Message-ID: <thgwn67qvqjobx5lc4eajwl3v3cdy6osvayigvg5icf7ib475k@fx4ijgzefo7w>
References: <20231218162410.1087788-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218162410.1087788-1-kbusch@meta.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.63 / 50.00];
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
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:url,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.83)[85.10%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_083359_590564_A84B5100 
X-CRM114-Status: UNSURE (   7.97  )
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

On Mon, Dec 18, 2023 at 08:24:10AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The commit was identified to be might sleep in invalid context and is
> blocking regression testing.
> 
> This reverts commit ee6fdc5055e916b1dd497f11260d4901c4c1e55e.
> 
> Link: https://lore.kernel.org/linux-nvme/hkhl56n665uvc6t5d6h3wtx7utkcorw4xlwi7d2t2bnonavhe6@xaan6pu43ap6/
> Link: https://lists.infradead.org/pipermail/linux-nvme/2023-December/043756.html
> Reported-by: Daniel Wagner <dwagner@suse.de>
> Reported-by: Maurizio Lombardi <mlombard@redhat.com>
> Cc: Michael Liang <mliang@purestorage.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Thanks!

Tested-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>

