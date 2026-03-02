Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53461EA4E08
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 14:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0ZQx7lu/7uIg7DorXl9M30VifeZ6jj4GAfa8Z7V5O9w=; b=Ep4CDc7IPqeor8zzGhzTCVLr2U
	RAG8pjkOukNz/cNmtw3evXPqeYdTLu4907wAn1idixNwjcHtDqO5xb3xC65wASLRRu7BZC6SAO4D5
	P/W7+1J+637bgXbfsPjk/kuFvfzE9bCj+g+Gykw3VXLRH80C6mqb/Dk1sWQxK+Y48mw/qbLjUwo2H
	/j+pXE0PXHwFVCk6O4Eqkau5I6gVvD9fNglSZ+iLYTM0VtGBQ8xPLts3iuvr/b4+nIkcc5DRdOMsx
	jfRodmJRJKe3d+vn4iRcm23g3JIDSBrC+JlHgNzebefssoVfl3JSUxHDR5lQHm40+tQJEI3qQb3QC
	eYRXz+oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx3tL-0000000DCKm-1ShO;
	Mon, 02 Mar 2026 14:04:59 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx3tJ-0000000DCKb-2qES
	for linux-nvme@bombadil.infradead.org;
	Mon, 02 Mar 2026 14:04:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0ZQx7lu/7uIg7DorXl9M30VifeZ6jj4GAfa8Z7V5O9w=; b=Wj1D2PBb2B1Lc66TZskQePUdS7
	wEZE/5P5l4wwocFQSjIxVBV+ZtOw3lLnmWvJ1lzZKWHY3LUBfTD6LUxNXPHyrmlBCQYJwyUR1D+XF
	6Es5IOBWo+w48MKiua3FeJnEx31jciiL81hAwOol8Jp+aI2HPRS2dXHbZpaEwSa6FSd53fNC4xOyo
	jb1qU9ErS1r3Gh1XyESsszqAmoQTYNlCwQQnBBBCFuD7OH5ThR2R8bt8spOaTHFnr3b+g5lg6iGye
	K01sPixNqNw6JP64bzA5YdM0U6TsCcsZY2r9dfwFQSlXy+MLG7nQNuxBrMbTYHN3DqGCfJ77LhN46
	im0ReD3Q==;
Received: from smtp-out1.suse.de ([195.135.223.130])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx3tG-00000000FOz-2rFG
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 14:04:56 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E81633F4F1;
	Mon,  2 Mar 2026 14:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772460293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZQx7lu/7uIg7DorXl9M30VifeZ6jj4GAfa8Z7V5O9w=;
	b=mr84YaUeCukcum3974iBnJnzIJ5Z8fT52JvJn8yso3nW6mKULjx8387X0OlT/r4Ez4F39o
	4fWbhikeKqBK1jteSuoPgagMMA+Ii+sEmffyIBe+AM3GusqWRG7dK120J0KRgJuJAkMGco
	82jtjJKWzePO9d8uqi4giX/v7hxB7E0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772460293;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZQx7lu/7uIg7DorXl9M30VifeZ6jj4GAfa8Z7V5O9w=;
	b=C3mvUk+DXYMPK2eNqC3jSHsAvpK9DIgsap622aXIHvC0BO1AhOo4yzfBQAZH7rME2oQ5F+
	SctBo8RkNiHENyBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772460292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZQx7lu/7uIg7DorXl9M30VifeZ6jj4GAfa8Z7V5O9w=;
	b=PPzQ8hPetqQlG90oK1xbE2cYAgbV+vyxgzHrMJ0A6w9lRRJ1IJOdyIQkAfErWutmuvU2fz
	GYvXst3avLYdkB0hNimQbaEE9aEXwOoA3GQHXKiX8RNxH/eVeaZCYMvEAeuZ+N+NKnV0cw
	/qTiniFgjZZYF3NLXCeVS2iezE5xSCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772460292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZQx7lu/7uIg7DorXl9M30VifeZ6jj4GAfa8Z7V5O9w=;
	b=V9vLpUja9J0uyaQa6sXXXpEc05IsstcgrASynzDgwk04V0UVDBFKhjcl7iIKeJfD8WYVGP
	3N/1pi2Hdj/KApAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBE813EA69;
	Mon,  2 Mar 2026 14:04:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7ZUOMASZpWnUIAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 02 Mar 2026 14:04:52 +0000
Date: Mon, 2 Mar 2026 15:04:52 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Guangwu Zhang <guazhang@redhat.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Thomas Gleixner <tglx@kernel.org>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] Revert "lib/group_cpus.c: avoid acquiring cpu
 hotplug lock in group_cpus_evenly"
Message-ID: <eb461226-1b64-4b67-a419-5b5886792d68@flourine.local>
References: <20260226-revert-cpu-read-lock-v1-0-eb005072566e@kernel.org>
 <20260226-revert-cpu-read-lock-v1-3-eb005072566e@kernel.org>
 <aaBS4pvtiFHL1LSz@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaBS4pvtiFHL1LSz@fedora>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_140454_897298_43ED12AF 
X-CRM114-Status: GOOD (  23.77  )
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

Hi Ming,

Sorry for the late response. Last week the mail server did take a break...

On Thu, Feb 26, 2026 at 10:04:18PM +0800, Ming Lei wrote:
> On Thu, Feb 26, 2026 at 02:40:37PM +0100, Daniel Wagner wrote:
> > This reverts commit 0263f92fadbb9d294d5971ac57743f882c93b2b3.
> > 
> > The reason the lock was removed was that the nvme-pci driver reset
> > handler attempted to acquire the CPU read lock during CPU hotplug
> > offlining (holds the CPU write lock). Consequently, the block layer
> > offline notifier callback could not progress because in-flight requests
> > were detected.
> > 
> > Since then, in-flight detection has been improved, and the nvme-pci
> > driver now explicitly updates the hctx state when it is safe to ignore
> > detected in-flight requests. As a result, it's possible to reintroduce
> > the CPU read lock in group_cpus_evenly.
> 
> Can you explain your motivation a bit? Especially adding back the lock
> causes the API hard to use. Any benefit?

Sure, I would like to add the lock back to group_cpus_evenly so it's
possible to add support for the isolcpu use case. For the isolcpus case,
it's necessary to access the cpu_online_mask when creating a
housekeeping cpu mask. I failed to find a good solution which doesn't
introduce horrible hacks (see Thomas' feedback on this [1]).

Anyway, I am not totally set on this solution, but I having a proper
lock in this code path would make the isolcpu extension way cleaner I
think.

What do you exactly mean with 'API hard to use'? The problem that the
caller/driver has to make sure it doesn't do anything like the nvme-pci
driver? 

[1] https://lore.kernel.org/linux-nvme/87cy7vrbc4.ffs@tglx/

Thanks,
Daniel

