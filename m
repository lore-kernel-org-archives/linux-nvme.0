Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664B6606A32F
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2026 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mCyr5QpV;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=atnBbJw1;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=84QKghRm;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=atnBbJw1;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=84QKghRm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n3c2w26KsSTcK+AA9X+7eCM/ZIuC+BG4JEbsHnBMOyg=; b=mCyr5QpVebchZkOB01OK8uiOPt
	xgifB8Qqzy2R7vJYoYPM8WNVRvk8I7BUugXDH0fjrwNBm7zNc7FwpjpeZ16PxdkFH28Wb/ihEAX/Y
	Y9Zt7ERxNLmoNC3hZ4+6irTv8TX7WDWDY6YrXnL3y4yOrme370dLzs7woISwrlAnDNvjXBom8xt/n
	NxDCp3N/BzBoHNZbxNSE2hKaEgwmhsWI0VR2yy/N+Wi0MLY1/XwPpwAaT7EFMF4JiROZVOkvwoc/u
	U7SdA2WY+/iERSA8XQWHd5PtyrEgmqfzy0FBoEfyRHLa9Yrs5DM5k/vFWWl0WP7l1n48uIr/pKqvw
	0Fqs+apw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ9bd-00000009kGX-0eDb;
	Tue, 20 Oct 2026 13:10:17 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ9ba-00000009kFs-29kT
	for linux-nvme@lists.infradead.org;
	Tue, 20 Oct 2026 13:10:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 54C0E1F7BB;
	Tue, 20 Oct 2026 13:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792501812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n3c2w26KsSTcK+AA9X+7eCM/ZIuC+BG4JEbsHnBMOyg=;
	b=atnBbJw1BmlzTfriyeneZOWSkzc+BXzaq67dEjv4EPyMIWtBBJZa1wR3yEEvhIvmpOZJch
	fffufcHJPzcKsoGN8gLE8Bc8PSpNWh1p0u8Rwzv4KrZ40wmu2sJq4jRbhQDoYCYf2lPb/t
	IIpUwz/jW18W2Fh8XDkW4kIehkiDM7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792501812;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n3c2w26KsSTcK+AA9X+7eCM/ZIuC+BG4JEbsHnBMOyg=;
	b=84QKghRmfw7LKg4Zune3dioCzBfIMwafChVMyvd9N9pGprIltujQ4vrQTsfO5Bo/+EOdFD
	u14lt3WGwOGgzoDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=atnBbJw1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=84QKghRm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792501812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n3c2w26KsSTcK+AA9X+7eCM/ZIuC+BG4JEbsHnBMOyg=;
	b=atnBbJw1BmlzTfriyeneZOWSkzc+BXzaq67dEjv4EPyMIWtBBJZa1wR3yEEvhIvmpOZJch
	fffufcHJPzcKsoGN8gLE8Bc8PSpNWh1p0u8Rwzv4KrZ40wmu2sJq4jRbhQDoYCYf2lPb/t
	IIpUwz/jW18W2Fh8XDkW4kIehkiDM7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792501812;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n3c2w26KsSTcK+AA9X+7eCM/ZIuC+BG4JEbsHnBMOyg=;
	b=84QKghRmfw7LKg4Zune3dioCzBfIMwafChVMyvd9N9pGprIltujQ4vrQTsfO5Bo/+EOdFD
	u14lt3WGwOGgzoDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E98E136CC;
	Tue, 20 Oct 2026 13:10:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G3/UOjNo12qhagAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 20 Oct 2026 13:10:12 +0000
Date: Tue, 20 Oct 2026 15:10:11 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Justin Tee <justin.tee@broadcom.com>, Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, 
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>, 
	Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v6 07/18] nvme: Introduce FENCING and FENCED controller
 states
Message-ID: <7e73057c-698a-4ce6-b153-3b8b1077f77c@flourine.local>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-8-mkhalfella@purestorage.com>
 <179242929827.3619480.8550407233438315193.b4-review@b4>
 <20261019212630.GN2931-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019212630.GN2931-mkhalfella@purestorage.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 54C0E1F7BB
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	URIBL_BLOCKED(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,broadcom.com,gmail.com,nvidia.com,purestorage.com,lists.infradead.org,vger.kernel.org,suse.de];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Spam-Score: -4.51
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_061014_706112_5CB8894D 
X-CRM114-Status: GOOD (  13.84  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 02:26:30PM -0700, Mohamed Khalfella wrote:
>  Description:
>  		Shows the current state of the controller. Possible values:
> -		"new", "live", "resetting", "connecting", "deleting",
> -		"deleting (no IO)", "dead".
> +		"new", "live", "fencing", "fenced", "resetting", "connecting",
> +		"deleting", "deleting (no IO)", "dead".
> 
>  What:		/sys/class/nvme/nvmeX/numa_node
>  Date:		November 2018
> 
> 
> How about a diff like the one above? Similar to CIRN and CIU, I am not
> sure what to put in "KernelVersion".

I think the KernelVersion is when it first appeared. I would leave it as
it is and instead extend the description

  		Shows the current state of the controller. Possible values:
 		"new", "live", "resetting", "connecting", "deleting",
 		"deleting (no IO)", "dead".
        v7.5 introduced additionally:
        "fencing", "fenced"

Obviously, this is not idea. If someone starts to complain we might have
to filter out these two new states.

