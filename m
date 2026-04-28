Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3575DFF8868
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2026 12:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/5+a2eX4L+0iEOh/ra075pgoXRmCy0MoByO1BQx5GgA=; b=A9KsH6WRwZYRcFaLHuKO83nWAD
	fz0IIC955gcEYu5R9B0q3aVTwxNqtqWgWb5vczqyTuf1zkCwjgKHFHwvbSg2/sAYS1h6HMN6txGb0
	MUj8//jyQ3GY3MosUug6swbnuHZP+NahfBYzCNU4zWnJn0/04LO0Z0LG84rGEth5+/80SX/AsaPxS
	z8oaeihxL0uKJXe68LQRN9AJN6FHBYahyAYKNHfLZxvwUktsxffmqwJ6ZiR0FdXQ4UF9xhupKMXgf
	b9oftohn/LegIa9R236RzJ6UC/VMfR9TKkD5IrmLX1Yl2K2Rr/wq7QwdIUtXy7qUE3qp7hxIZmFQ0
	R12NNNSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHhq4-00000001Se2-2OSX;
	Tue, 28 Apr 2026 12:46:56 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHhq2-00000001Sdc-1pEZ
	for linux-nvme@lists.infradead.org;
	Tue, 28 Apr 2026 12:46:55 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E9F35BD2E;
	Tue, 28 Apr 2026 12:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777380412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/5+a2eX4L+0iEOh/ra075pgoXRmCy0MoByO1BQx5GgA=;
	b=Cc57qxdRvJqRzvmFRkhHxaY3FUFWjCPPN3FZXVuIpmP4UasedR6oGfClQNe6o05e36vzgo
	/207rfBWySGuNL1Z+W6/UF3gJVe6zcHyPHPEskf2z67alUy1t0OwIrkOBqNtCdRGL8vEX9
	tqYUyvq4dsVz3sUOpz7BO/9uBcmYm3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777380412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/5+a2eX4L+0iEOh/ra075pgoXRmCy0MoByO1BQx5GgA=;
	b=Wz3UpnKWxdXPRLxTkXEaoq7dgt+fou/BcX83Tbo3+bKl5xOGti0G8M1UIxsXNOb24QlTje
	/0hodb4iYmey3fCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Cc57qxdR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Wz3UpnKW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777380412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/5+a2eX4L+0iEOh/ra075pgoXRmCy0MoByO1BQx5GgA=;
	b=Cc57qxdRvJqRzvmFRkhHxaY3FUFWjCPPN3FZXVuIpmP4UasedR6oGfClQNe6o05e36vzgo
	/207rfBWySGuNL1Z+W6/UF3gJVe6zcHyPHPEskf2z67alUy1t0OwIrkOBqNtCdRGL8vEX9
	tqYUyvq4dsVz3sUOpz7BO/9uBcmYm3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777380412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/5+a2eX4L+0iEOh/ra075pgoXRmCy0MoByO1BQx5GgA=;
	b=Wz3UpnKWxdXPRLxTkXEaoq7dgt+fou/BcX83Tbo3+bKl5xOGti0G8M1UIxsXNOb24QlTje
	/0hodb4iYmey3fCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87B46593B0;
	Tue, 28 Apr 2026 12:46:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bprrHzys8GmdQQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 28 Apr 2026 12:46:52 +0000
Date: Tue, 28 Apr 2026 14:46:51 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org, 
	mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com, 
	linux-nvme@lists.infradead.org, mkhalfella@purestorage.com, chaitanyak@nvidia.com, 
	hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V3 7/8] nvmet-loop: do not alloc admin tag set during
 reset
Message-ID: <9d30896d-a57f-412d-a3dd-c69ed06e16cc@flourine.local>
References: <20260410073924.61078-1-mlombard@redhat.com>
 <20260410073924.61078-8-mlombard@redhat.com>
 <8babbc78-701d-4308-b325-b4b2bab5d2c2@flourine.local>
 <DI4QV80PTNP9.1ZY7L7GFJ8TX5@arkamax.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI4QV80PTNP9.1ZY7L7GFJ8TX5@arkamax.eu>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9E9F35BD2E
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_054654_641688_2F40E9CE 
X-CRM114-Status: UNSURE (   8.42  )
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

On Tue, Apr 28, 2026 at 01:17:17PM +0200, Maurizio Lombardi wrote:
> It would be something like this (just a compile tested draft,
> I still need to properly test it, but it should give you an idea):

This looks way better to me. Thanks!

