Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BC7CAC581
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Sep 2025 17:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7J/5jyC4CPYC1mYA5Nbh128F4Qm/h2p5bihZrP5YpZY=; b=vUlIZn+UgUtDlnvW/8DL++Eypj
	mhumJ6t+z5LeSYaoFr8gU3QUeDVvSRmmlqCOC6GTBihiW7vlcprMC41xAwxoZE6A7PqjjDdlzZ3sh
	EJAbrjkR3dD+5ix8NoVO7SJdgUVK+RqPAgHmSsk4LgsxsQYj0wxD/4w8xDtA3DJSlSaL96qMDZ6x0
	iBV7KJndliiGpW6hJQsWzOwvno6qylMcKMt91UGwCRKtPTzjXOzpCa3TIqDhRf5YuXn4ejKyvxXv7
	lrxAfOjmqEavHhiV9xaQ5iTPfXY1NQtXcSsUcjxdS24JD3I7wngpKoqHWgp3AWa5sptVXtPOiXjPW
	7ua3kGcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvfNO-000000013Je-2EVM;
	Mon, 08 Sep 2025 17:09:58 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvbZG-0000000HFd5-10Fk
	for linux-nvme@lists.infradead.org;
	Mon, 08 Sep 2025 13:05:59 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9727425D8A;
	Mon,  8 Sep 2025 13:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757336755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7J/5jyC4CPYC1mYA5Nbh128F4Qm/h2p5bihZrP5YpZY=;
	b=ON22o27InxEfGG8q4I0/A8vfq9i30a1ijfTzFxUb3d9cmwOo7XbL+4aV0cmYAWS0zXRHBk
	A/AAS8N6LXyAGZ5qbi4JwoxXgnnVuvbfy0etbJQ9w6r/+Xk+K94lju+D7KCKYFvCuXClUJ
	c/cDDkriXa4fSRJNXFB9JOgLJN7Lg3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757336755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7J/5jyC4CPYC1mYA5Nbh128F4Qm/h2p5bihZrP5YpZY=;
	b=J5RPxvOSRKY7Ki3M6Ii6DI0RHS0UD2CYG+Uu0TlslYh3QPU1IHQTR8caeozoaJQrH6bTAH
	CqiYpVwk5MvDzTCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757336755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7J/5jyC4CPYC1mYA5Nbh128F4Qm/h2p5bihZrP5YpZY=;
	b=ON22o27InxEfGG8q4I0/A8vfq9i30a1ijfTzFxUb3d9cmwOo7XbL+4aV0cmYAWS0zXRHBk
	A/AAS8N6LXyAGZ5qbi4JwoxXgnnVuvbfy0etbJQ9w6r/+Xk+K94lju+D7KCKYFvCuXClUJ
	c/cDDkriXa4fSRJNXFB9JOgLJN7Lg3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757336755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7J/5jyC4CPYC1mYA5Nbh128F4Qm/h2p5bihZrP5YpZY=;
	b=J5RPxvOSRKY7Ki3M6Ii6DI0RHS0UD2CYG+Uu0TlslYh3QPU1IHQTR8caeozoaJQrH6bTAH
	CqiYpVwk5MvDzTCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8030213946;
	Mon,  8 Sep 2025 13:05:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QwJkHrPUvmhnMAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 08 Sep 2025 13:05:55 +0000
Date: Mon, 8 Sep 2025 15:05:54 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, Ming Lei <ming.lei@redhat.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, storagedev@microchip.com, 
	virtualization@lists.linux.dev, GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v8 10/12] blk-mq: use hk cpus only when isolcpus=io_queue
 is enabled
Message-ID: <4d006f81-cd3f-4aba-89db-fbc2e8c667b1@flourine.local>
References: <20250905-isolcpus-io-queues-v8-0-885984c5daca@kernel.org>
 <20250905-isolcpus-io-queues-v8-10-885984c5daca@kernel.org>
 <c9ef4fa6-99a4-46fd-8623-b8979556566e@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9ef4fa6-99a4-46fd-8623-b8979556566e@flourine.local>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250908_060558_421197_25BFA7D6 
X-CRM114-Status: GOOD (  14.50  )
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

On Mon, Sep 08, 2025 at 09:36:35AM +0200, Daniel Wagner wrote:
> which resulted in a way cleaner code. Though the kernel test robot
> complained with
> 
>       >> block/blk-mq-cpumap.c:155:16: error: array initializer must be an initializer list
>            155 |         cpumask_var_t active_hctx __free(free_cpumask_var) = NULL;
> 
> I try to figure out if it's possible to get this somehow working with
> some witchcraft (aka pre compiler magic).

What about adding something like this here:


#ifdef CONFIG_CPUMASK_OFFSTACK

#define scoped_cpumask_var(_name)			\
	cpumask_var_t _name __free(free_cpumask_var) = NULL;

#else /* ! CONFIG_CPUMASK_OFFSTACK */

#define scoped_cpumask_var(_name)			\
	cpumask_var_t _name __free(free_cpumask_var);

#endif /* ! CONFIG_CPUMASK_OFFSTACK */


This would make the new code way cleaner.

