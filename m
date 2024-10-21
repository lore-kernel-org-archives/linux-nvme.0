Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDD3D15DA0
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 14:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IgrvUn8ruxYDInIfZ9nfMFbxoB/1wqap7M1gtz9PtRY=; b=fQXLw9z2jJdUK2sGffmp9OuYuz
	gwiIJyNCvXodJBCV7sTaN7f+eNnkwT/8sz+7cITDjtI3L8pjt/UstabkSnFsurXOd4vrGTxh66HpO
	NLADeYFfFPjgV8mwz81el+OodQ3WtEdCYwSeThAz30VC2WtKeGtjl8HIMPPKs3SUZRUwK/8nreCVz
	bKApaRwWeQghdn4EDXWwUsuwjuYDdtlC5MB5VFsad9pgYA6A6DCDG3ZctYMaGPABSe/NILj/rABuJ
	NC+qd0admLsQYnvuanQrts4w0PG6EYwzodEizHWWj4JMgxQ0Sp5pUbHjOH/O+Vaiab53lF/XCOjpB
	Sge4tM7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2tUa-00000007dIo-0ZhQ;
	Mon, 21 Oct 2024 14:34:44 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2tDT-00000007aeR-1xCY
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 14:17:07 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C212F1FF3F;
	Mon, 21 Oct 2024 14:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729520218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IgrvUn8ruxYDInIfZ9nfMFbxoB/1wqap7M1gtz9PtRY=;
	b=MFQPToW3mZT4Bq67tWZhkAHQZQjBQ94e/x11phTqbOMoZu7S6nILh0mp3jqQFJrDCjaRQ6
	8z+eJGuRjAqYbs0dvueMsRzijyxaXHBiZapePBFI1hLNK/us9Z0/cd9QHOvcIDHR7bbsJ7
	q9ODJXkAOGkuKA8V1YnjVBwoavaC0ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729520218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IgrvUn8ruxYDInIfZ9nfMFbxoB/1wqap7M1gtz9PtRY=;
	b=rrYHmExHXwPkOamJ/sbghGuTWOXjSRoNFZ48s3MZx8k421BH2bIzk2PA55o5SYICSEJSmc
	uLRIBbPCFa+5hBAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MFQPToW3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rrYHmExH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729520218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IgrvUn8ruxYDInIfZ9nfMFbxoB/1wqap7M1gtz9PtRY=;
	b=MFQPToW3mZT4Bq67tWZhkAHQZQjBQ94e/x11phTqbOMoZu7S6nILh0mp3jqQFJrDCjaRQ6
	8z+eJGuRjAqYbs0dvueMsRzijyxaXHBiZapePBFI1hLNK/us9Z0/cd9QHOvcIDHR7bbsJ7
	q9ODJXkAOGkuKA8V1YnjVBwoavaC0ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729520218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IgrvUn8ruxYDInIfZ9nfMFbxoB/1wqap7M1gtz9PtRY=;
	b=rrYHmExHXwPkOamJ/sbghGuTWOXjSRoNFZ48s3MZx8k421BH2bIzk2PA55o5SYICSEJSmc
	uLRIBbPCFa+5hBAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4ACB139E0;
	Mon, 21 Oct 2024 14:16:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VkjcJVpiFmd5UgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 21 Oct 2024 14:16:58 +0000
Date: Mon, 21 Oct 2024 16:16:57 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: sysfs tls_configured_key naming?
Message-ID: <d3fd39eb-0c3b-42d6-baee-b71fdb7a23e0@flourine.local>
References: <d3466e4f-23dc-4a07-a2c3-98bcbf6c7960@flourine.local>
 <f56b5973-81c0-4e1d-8552-ee87066029bf@suse.de>
 <74828866-cc4e-4598-8e7d-779f771955ae@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74828866-cc4e-4598-8e7d-779f771955ae@grimberg.me>
X-Rspamd-Queue-Id: C212F1FF3F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_071703_678782_5BB440AF 
X-CRM114-Status: GOOD (  11.19  )
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

On Mon, Oct 21, 2024 at 01:36:29AM GMT, Sagi Grimberg wrote:
> FWIW, I don't like the tls_configured_key notation either. But I don't have
> a better name.

What about changing the meaning of tls_key? It could always show the key
id the user provided via the command line (or the retained key). And we
introduce a new sysfs entry which could be called tls_active_key,
tls_current_key, etc. which shows the id of the active TLS key.

