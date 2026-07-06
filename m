Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A014C43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 07:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1RMnnzt2sFIGcPxzcms87mPbIu3C83fpvr+EHjzF/co=; b=A+SBupcy2OeDf/tNyifbgkRGPQ
	ypWuvUMpz32aJpRBCgDYyOi6YUrvYBCsDSiQRw8DU4cqhvnqxURwmJzHISDRr8qKCezrXNnRTfsHM
	1nLJcEtSjCaxM53u6AhX9AE7NZuUdzJsCZAKbeLWEnnSqbF1f3jH9KUh10gvG83WcemFDl1B+qRKV
	wI2M8FnomkDlhwKrdTVgmqav28PYKxWCbOS5Q2dbk2fmhXAg1k//cm06mgBu1EO6AvwVpDjPn8fWh
	MDp9c1C+S1qaUEec0nlRKv/OJRchaKLc01uJNeTGAn8L3o2PoxJ7iQig7xVHZZpuIEFTtembxpcDt
	cGBoUcUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wge5s-0000000BlOf-2oBx;
	Mon, 06 Jul 2026 07:50:20 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wge5q-0000000BlOE-29Rx
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 07:50:19 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6B1BF75839;
	Mon,  6 Jul 2026 07:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783324216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1RMnnzt2sFIGcPxzcms87mPbIu3C83fpvr+EHjzF/co=;
	b=EhwuQydYk1+eOZySq3SetIQDjJoj9dUU7z9gVMz41tC753xSfn2L9kH1SN9RqWougrn+Nc
	r00cQ7+OrjJu1w7sUPqNrVvlkV+y01GNdYH5MX40z8R/aypQH+NX+U6tI/eHnHt9mOxAaV
	4jtDGUI2KygYwVFdssJ6181t36Zg53c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783324216;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1RMnnzt2sFIGcPxzcms87mPbIu3C83fpvr+EHjzF/co=;
	b=j6DhzsUXaw4gZFsRDfMvamElnY1JSrXY/H5q0FnyVYTxQylb1FDbDsaiclkAgv6H9PRXfL
	k1aIgBE6gZYewbBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ty9x7hjC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tExl5qDO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783324215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1RMnnzt2sFIGcPxzcms87mPbIu3C83fpvr+EHjzF/co=;
	b=Ty9x7hjCpKjW2JXQb7At18mzy2dx07UL/qyDTP/m1R7vdsYzwGc00H8vnLV4RwDulQtUFU
	dOZwYezNQOLg1lx/zoOnmWrl4bKYOZiz3sZgYDygA4SaRX8J6RleDgijOlLM1vj1XgLkqb
	dtLh56KTuB8yYVPSJN6jVbFhOodg9FE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783324215;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1RMnnzt2sFIGcPxzcms87mPbIu3C83fpvr+EHjzF/co=;
	b=tExl5qDO/Wb9v22iDXZzYTUJkOFh5h8ESNTeBxUpyMNcpTUZjCP5hYbRWGEfVN3QzPDkg9
	cooWQ+Nbltcz/gAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51501779AA;
	Mon,  6 Jul 2026 07:50:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jyYgEjdeS2r3BwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 06 Jul 2026 07:50:15 +0000
Date: Mon, 6 Jul 2026 09:50:10 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	John Garry <john.g.garry@oracle.com>, Nilay Shroff <nilay@linux.ibm.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, xlpang@linux.alibaba.com, 
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v3 3/3] MAINTAINERS: add missing NVMe documentation files
Message-ID: <ba0bd2f7-48e2-4a79-ae92-4c856c991d62@flourine.local>
References: <20260706023439.3054578-1-kanie@linux.alibaba.com>
 <20260706023439.3054578-4-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706023439.3054578-4-kanie@linux.alibaba.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6B1BF75839
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,flourine.local:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_005018_702986_912A8917 
X-CRM114-Status: UNSURE (   8.72  )
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

On Mon, Jul 06, 2026 at 10:34:39AM +0800, Guixin Liu wrote:
>  T:	git git://git.infradead.org/nvme.git
> +F:	Documentation/ABI/testing/configfs-nvmet
>  F:	drivers/nvme/target/

Didn't catch this in the previous path, but why do think these API
should be in testing section?

