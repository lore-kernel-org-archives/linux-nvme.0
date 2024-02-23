Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFF4C5478C
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Feb 2024 13:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9PaDQudpN1vutNl5gkBN88rZa7w+94lTsoZIkzXyW/U=; b=Ont7h4I+qNBfIKrOb2X3XeGo/t
	kHsJqjJHXmyH87GYYZmbiCeqNmjH5v3GxT9uF3/A/sczuSdNjsZi8FFPXClU7OU0dkfpMPiMkqeQI
	ywxBaqoS2W1ABtRi33grCUCrGR6b9aTx/XkfZFhryYnv0FNg2yoquioZN+hmtyOfimYQQF0rDNjmj
	8HjkD5QiNyb9lqCVjo/07loVqId1VC0AvM6MtUuRqjN3gF3JmNCcXpi7wZNqezEuy5KFuNnLtuXha
	ivOYeZEEXjUswcJqJouUIi+y0A6LKASnHy9JtXqoa4pTtwz4punQtHD31AgLSUGe9i8cj+LzpsL6J
	ael3yNsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdVc7-00000009WmT-1WLx;
	Fri, 23 Feb 2024 13:29:19 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdVbx-00000009WkA-0IuA
	for linux-nvme@lists.infradead.org;
	Fri, 23 Feb 2024 13:29:12 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 70FDA21F3E;
	Fri, 23 Feb 2024 13:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708694943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9PaDQudpN1vutNl5gkBN88rZa7w+94lTsoZIkzXyW/U=;
	b=UqCs8Rgw2SYd1F86vzfCiSnfAYMREN7/Z0iu7syzxLPZCJN2bB05Gj+8FD1VGPe9zwAky2
	Ohk2FV2mUfp/pKdpSjDZRl3cIXfPeF7sei6FVkWbVtjN1Hc3xj9uwSeLm+GpYsMSU0ymJy
	TlYz6L/H8MEk7qyCvv8CuIGW9YgBgTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708694943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9PaDQudpN1vutNl5gkBN88rZa7w+94lTsoZIkzXyW/U=;
	b=Kxca1ZDNzfZg+22qen+zY478o4wUYx4not+UkoSnLhBSYeCbJSf5Fbay2GhscaCVY/CNvX
	0srxc9f16ljx3YCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708694943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9PaDQudpN1vutNl5gkBN88rZa7w+94lTsoZIkzXyW/U=;
	b=UqCs8Rgw2SYd1F86vzfCiSnfAYMREN7/Z0iu7syzxLPZCJN2bB05Gj+8FD1VGPe9zwAky2
	Ohk2FV2mUfp/pKdpSjDZRl3cIXfPeF7sei6FVkWbVtjN1Hc3xj9uwSeLm+GpYsMSU0ymJy
	TlYz6L/H8MEk7qyCvv8CuIGW9YgBgTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708694943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9PaDQudpN1vutNl5gkBN88rZa7w+94lTsoZIkzXyW/U=;
	b=Kxca1ZDNzfZg+22qen+zY478o4wUYx4not+UkoSnLhBSYeCbJSf5Fbay2GhscaCVY/CNvX
	0srxc9f16ljx3YCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D2EB13776;
	Fri, 23 Feb 2024 13:29:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id jIA/FZ+d2GXudwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 23 Feb 2024 13:29:03 +0000
Date: Fri, 23 Feb 2024 14:29:02 +0100
From: Daniel Wagner <dwagner@suse.de>
To: hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: authentication error are always non-retryable
Message-ID: <c7mv5rb3wfpjlttvgycihgn7fxlngrewpdtuhucqhodde6y3m6@nk7hvf4rwzdj>
References: <20240223105804.44473-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223105804.44473-1-hare@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UqCs8Rgw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Kxca1ZDN
X-Spamd-Result: default: False [-1.37 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.56)[92.12%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 70FDA21F3E
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_052909_287565_A3DC9BAB 
X-CRM114-Status: UNSURE (   8.58  )
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

On Fri, Feb 23, 2024 at 11:58:04AM +0100, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Any authentication errors which are generated internally are always
> non-retryable, so set the DNR bit to ensure they are not retried.

This still keeps nvme-fc in the retry loop. It fails with -126 which is
-ENOKEY:

[ 2267.185691] nvme nvme0: qid 0: no key
[ 2267.187596] nvme nvme0: qid 0: authentication setup failed
[ 2267.188866] nvme nvme0: NVME-FC{0}: create_assoc failed, assoc_id 2a3022dff0fe0000 ret -126

