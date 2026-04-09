Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C2AE9DE76
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2026 09:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5mHoLKB8ALs5A96NW5/P6k1tZqjATUenG9fYiJPotOE=; b=DVeYZTYvX7w24C0Ow5/m7wBKF2
	Ay6Vk7pw3zteQLv8U//FK1iQiK5+drzbZYoVTohkbNs3AeGz715LK5fCQH3EheRdUUKiGf7HykGwQ
	anRN+CPnqZYKneX6bffowuGNEt2Hm++1GOQZ8pY8EkyOtUXIPPun9IXlklHXW2mQGlCbYwUk2yJE/
	baOL3X4u8pdjTNCBupoulQLkm+nOv10eGLNGQZQqq7o36z7aQQsl/3mEBFVp+0uB4xVoTklUTZDku
	KhjpJJ+5FJuTszdZBGMRvBSueJAgAvfBuhI6qkn18PUN4UEy41G90mF3dKKBKysp7eH4oGu4QAViE
	5e+SJZLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAlPn-0000000A0o5-0jk0;
	Thu, 09 Apr 2026 09:11:07 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAlPk-0000000A0mu-0iUG
	for linux-nvme@lists.infradead.org;
	Thu, 09 Apr 2026 09:11:05 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 59E2A4EE69;
	Thu,  9 Apr 2026 09:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775725860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5mHoLKB8ALs5A96NW5/P6k1tZqjATUenG9fYiJPotOE=;
	b=mpvzm0sAR7yqZ5sLLqfIYXf6af8a5XZ5qQukL1/DXvnRLKR7dqEWCdgXyq6/xYQHzSj6u6
	BIpTstr7JGpuilex23BTb6/+gwBXkPWzlGpg5V4BELMJZgaU/pokm/mi5cv+IH/m0p5JLD
	agHwWlUzgPAHP9Hi7NkHk+KN1mGHXfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775725860;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5mHoLKB8ALs5A96NW5/P6k1tZqjATUenG9fYiJPotOE=;
	b=2SjIo1KbBCg4Qv5tfZlI4kBTfUZubtJ0GiS0jR5L7/FFl4uPgO6KFFetNoXjDc6mq4bM7q
	vMimRI/mUZSZ6VAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mpvzm0sA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2SjIo1Kb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775725860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5mHoLKB8ALs5A96NW5/P6k1tZqjATUenG9fYiJPotOE=;
	b=mpvzm0sAR7yqZ5sLLqfIYXf6af8a5XZ5qQukL1/DXvnRLKR7dqEWCdgXyq6/xYQHzSj6u6
	BIpTstr7JGpuilex23BTb6/+gwBXkPWzlGpg5V4BELMJZgaU/pokm/mi5cv+IH/m0p5JLD
	agHwWlUzgPAHP9Hi7NkHk+KN1mGHXfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775725860;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5mHoLKB8ALs5A96NW5/P6k1tZqjATUenG9fYiJPotOE=;
	b=2SjIo1KbBCg4Qv5tfZlI4kBTfUZubtJ0GiS0jR5L7/FFl4uPgO6KFFetNoXjDc6mq4bM7q
	vMimRI/mUZSZ6VAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49DB24A0B3;
	Thu,  9 Apr 2026 09:11:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wjfVECRt12mZOQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 09 Apr 2026 09:11:00 +0000
Date: Thu, 9 Apr 2026 11:10:51 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.com, kbusch@kernel.org, 
	hch@lst.de, gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: Re: [PATCHv2 0/9] libnvme: add support for retrieving additional
 NVMe stat
Message-ID: <19ca03c7-1bb3-4468-b1ad-4c44ea9b8c17@flourine.local>
References: <20260404101504.44539-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404101504.44539-1-nilay@linux.ibm.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 59E2A4EE69
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260409_021104_505058_BCC08A68 
X-CRM114-Status: GOOD (  19.47  )
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

Hi Nilay,

On Sat, Apr 04, 2026 at 03:44:50PM +0530, Nilay Shroff wrote:
> Certain NVMe attributes and statistics can change dynamically at runtime.
> However, the current libnvme implementation caches attribute values while
> scanning and building the topology. Subsequent libnvme API calls return
> these cached values.
> 
> While this approach works well for one-shot nvme-cli commands, it is not
> suitable for use cases that require upto date information. In particular,
> real-time monitoring tools such as nvme-top require access to the latest
> (non-cached) values of such attributes.
> 
> To address this, this patchset introduces support for retrieving
> non-cached values for selected attributes whose values may change
> dynamically. The first three patches disable auto-generated accessors
> for ana_state, numa_nodes, and iopolicy using "!accessors:none", and
> provide custom implementations that always return the latest values.
> 
> In addition, libnvme lacks support for retrieving gendisk statistics, which
> provide useful insight into disk activity (e.g., number of I/Os processed,
> time spent servicing I/O, and in-flight I/O counts). This patchset adds
> support for retrieving gendisk I/O statistics for both per-path and namespace
> gendisks.
> 
> Finally, this series adds support for retrieving diagnostic counters at 
> different levels, including per-path, namespace, nshead, and controller.
> These counters should improve visibility into NVMe native multipath behavior.
> 
> All of the above statistics and counters can be leveraged by tools such as
> nvme-top to provide real-time monitoring and analysis.
> 
> As usual, feedback and suggestions are welcome!

Looks way better. Thanks!

Unfortunately, the big renaming of the API has happened, thus could I
ask to rebase (and rename the symbols accordingly)?

One thing I notices, is the first set of statistic getters have the
'bool diffstat' argument, the second one not. To make this a bit more
consistent I'd say it would be great to have it on all functions. WDYT?

Thanks,
Daniel

