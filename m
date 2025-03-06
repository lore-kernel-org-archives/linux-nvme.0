Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29630C28B23
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 10:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8uwMk9eSw4+RYYUHHE2kXRw73rPJMGHwqh0fMuQwsaI=; b=w47OK4AaZicjiBwouNdGABAlZE
	v034DeJahsYtMRYRCUdT2iEpFrb2b83WECUlfv6thBGFwPdfMd5G34kU9YDnvWAxhuy2XTmLzN1l+
	7EiBGZUi8u9dgL9PFOsGkSKrEJU4EHe5bwWfKLFHSJS25H3SY3z1v3A0qg8BHJ5ULlzAPnphmVtvy
	3ElHbf7B7Nru8Mh7BqdOIe7CMcHmj/XnEembB1zTwmOQW0xi+0q3VzlkQQM9LArWpqOkrefwrcsgs
	f4/NCFlJo6XIYHFcUvNaPRNbWCz+ZXBpNKIuNQhdVzxi6DBRRQImwyfJGCJkilWrz+q0uxcNjRtHG
	HqeDFU2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tq8Cb-0000000AaxN-3SK8;
	Thu, 06 Mar 2025 10:11:41 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tq87G-0000000AaK2-2nU0
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 10:06:14 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B3196211AD;
	Thu,  6 Mar 2025 10:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741255567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uwMk9eSw4+RYYUHHE2kXRw73rPJMGHwqh0fMuQwsaI=;
	b=Ap9xXNtuRcm/s44PvuG5kMeaQNAwIgN09BgSPKd0OGbauxWuZbC4xUxCCiuPlv4ag47rKD
	4jk20a1jgmhPv+BYCm9usk5u6LKbEAtfvQ4nReYOC6EvZrTV6einSvrWS3Jwd2Whja40vq
	4xCvMp5gWXqGLIjLi0EtqIqVDpNe/cI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741255567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uwMk9eSw4+RYYUHHE2kXRw73rPJMGHwqh0fMuQwsaI=;
	b=t7xhbWFYi6/K9zuDgmmKrcZKPQcLd7HfmzwNNyO7J3FKO24Mrpw7sgZuudrIc7PiWTJlS0
	Jt0BX/hG7uDKWZDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ap9xXNtu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=t7xhbWFY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741255567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uwMk9eSw4+RYYUHHE2kXRw73rPJMGHwqh0fMuQwsaI=;
	b=Ap9xXNtuRcm/s44PvuG5kMeaQNAwIgN09BgSPKd0OGbauxWuZbC4xUxCCiuPlv4ag47rKD
	4jk20a1jgmhPv+BYCm9usk5u6LKbEAtfvQ4nReYOC6EvZrTV6einSvrWS3Jwd2Whja40vq
	4xCvMp5gWXqGLIjLi0EtqIqVDpNe/cI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741255567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uwMk9eSw4+RYYUHHE2kXRw73rPJMGHwqh0fMuQwsaI=;
	b=t7xhbWFYi6/K9zuDgmmKrcZKPQcLd7HfmzwNNyO7J3FKO24Mrpw7sgZuudrIc7PiWTJlS0
	Jt0BX/hG7uDKWZDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3D8813676;
	Thu,  6 Mar 2025 10:06:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 384EJ49zyWfnIwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 06 Mar 2025 10:06:07 +0000
Date: Thu, 6 Mar 2025 11:06:03 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: James Smart <james.smart@broadcom.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] nvmet-fcloop: add ref counting to lport
Message-ID: <bc38d0fc-0e3e-4196-b698-1528dc57421e@flourine.local>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-2-c0bd83d43e6a@kernel.org>
 <20250305141740.GC18065@lst.de>
 <0efdf3e7-e49e-4e2f-846b-b072169de318@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0efdf3e7-e49e-4e2f-846b-b072169de318@flourine.local>
X-Rspamd-Queue-Id: B3196211AD
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_020610_895363_28719DA2 
X-CRM114-Status: GOOD (  12.16  )
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

On Thu, Mar 06, 2025 at 10:26:40AM +0100, Daniel Wagner wrote:
> There is nothing which updates the ctrl in nvme_fc_unregister_localport.
> Not really sure what to do here. fcloop obviously is now behaving
> differently to the hw drivers. But still, this looks very fragile that
> there is no sort of synchronization between port unregistration and ctrl
> state.

Ah I see what's supposed to happen in this scenario.
nvme_fc_unregister_localport will return -EINVAL when the port is still
in use. That means fcloop is not allowed to pull the rug yet.

