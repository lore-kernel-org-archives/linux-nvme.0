Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61308C4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Apr 2024 07:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CurLk1twoCV4guDqbPk4rzn3JSSHHowvA8NQMqmgj0w=; b=vsrcMbnWQzf7BhYyaqlIYJnx2A
	3sjVeNeRz17b0y8qYA++Jqa0UuIicvcVQXIRHDDVkZHF6F77bYepOV65KFb4W6CPrICEyPbvtJ9ik
	LQztvIE9rYPQshKYR3DjZ/WwSmH1YpNsaR0P1nU048v9a1WjGwHzkefp9GtCH4tPZ/1V/7HmsVvUs
	j1ielMGBOiICNicz8Co03JTZmsiAlq7/vupVzR2rbR9b4FSjJEH+Il+dA0tFTxppckS9qgb0Ss/6f
	NzlvWNg8azGNHub44fXRh1OnPc67axR/SYhUvRghZ5ehc8ce7QU90uSQcCIdii56NNzf9v4IIsrk2
	AkN0W+Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx01Q-0000000F5pN-3yv9;
	Wed, 17 Apr 2024 07:48:00 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx01N-0000000F5o0-008j
	for linux-nvme@lists.infradead.org;
	Wed, 17 Apr 2024 07:47:59 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D45D2050A;
	Wed, 17 Apr 2024 07:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713340075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CurLk1twoCV4guDqbPk4rzn3JSSHHowvA8NQMqmgj0w=;
	b=LGDF7jbC6hCpJC+qeEugFpGgGVR9IvEfxqAyHcwHGuru6MbeJtvYlJxKoGnZKZcWnwuznl
	6SyY/AxNN+rIgHpt4xe7IXfSM1HVwlLLrO8CkVPT4Rtb4eiYKnmPyTbke7K7+Bnj8OM9pY
	zo/te4O8vG0AIh4q+P8ZQawV3qDNE0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713340075;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CurLk1twoCV4guDqbPk4rzn3JSSHHowvA8NQMqmgj0w=;
	b=Wp4kOAcyMl5FbbmV6T6e72TWNEjiPIrOk/+UBQyWZlpkox53+l31T0FYQPOd7Nhkzn4Uzb
	8ju4DrXsz+3q8iCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713340075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CurLk1twoCV4guDqbPk4rzn3JSSHHowvA8NQMqmgj0w=;
	b=LGDF7jbC6hCpJC+qeEugFpGgGVR9IvEfxqAyHcwHGuru6MbeJtvYlJxKoGnZKZcWnwuznl
	6SyY/AxNN+rIgHpt4xe7IXfSM1HVwlLLrO8CkVPT4Rtb4eiYKnmPyTbke7K7+Bnj8OM9pY
	zo/te4O8vG0AIh4q+P8ZQawV3qDNE0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713340075;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CurLk1twoCV4guDqbPk4rzn3JSSHHowvA8NQMqmgj0w=;
	b=Wp4kOAcyMl5FbbmV6T6e72TWNEjiPIrOk/+UBQyWZlpkox53+l31T0FYQPOd7Nhkzn4Uzb
	8ju4DrXsz+3q8iCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7681813957;
	Wed, 17 Apr 2024 07:47:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /eOrG6t+H2YVMwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 17 Apr 2024 07:47:55 +0000
Date: Wed, 17 Apr 2024 09:47:54 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Israel Rukshin <israelr@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, 
	Linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] libnvme: Introduce nvmf_hostid_generate function
Message-ID: <okgtxgle6kqk65azqfx27tlkkpsbn5dbvbkesirw4quiwvvwzm@6lvwpmtisj2k>
References: <1713249176-7837-1-git-send-email-israelr@nvidia.com>
 <1713249176-7837-2-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1713249176-7837-2-git-send-email-israelr@nvidia.com>
X-Spamd-Result: default: False [-3.47 / 50.00];
	BAYES_HAM(-2.67)[98.55%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240417_004757_212987_40CC810E 
X-CRM114-Status: UNSURE (   9.90  )
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

On Tue, Apr 16, 2024 at 06:32:56AM +0000, Israel Rukshin wrote:
>  /**
>   * nvmf_hostnqn_generate() - Generate a machine specific host nqn
> - * Returns: An nvm namespace qualified name string based on the machine
> - * identifier, or NULL if not successful.
> + * @hostid:		Host identifier
> + *
> + * If @hostid is NULL, the function generates it based on the machine
> + * identifier.
> + *
> + * Return: On success, an NVMe Qualified Name for host identification. This
> + * name is based on the given host identifier. On failure, NULL.
> + */
> +char *nvmf_hostnqn_generate(char *hostid);

This breaks the API. The only way around this is to introduce a complete
new function as far I know.

