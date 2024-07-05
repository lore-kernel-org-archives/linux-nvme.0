Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE4EC3271F
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jul 2024 08:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tiGUa6DYGC5pVPivDy4o/t96kXlnu57+QS3U5DUYdXk=; b=pl8oydVhS17M94FVRXNkx9A2L3
	txfWczBTrXhLg3+7mN7Fy7QKOXiJ/hB7kS6gYbkPyDNdDXmud+PDLs6eZRUXmsGn4fgQw0B7TqjC4
	ZB44uYmLDNOKhWHuxFXInljgoIITcBtJn9QswW79uWUGyZeQ/Q1ccaU81CQqerDruJYIgb16s2d8F
	1wTpg/t3iDzDwKa+6I9wjFIDkHe+UCpzatXYqWG6ygPMcGVZ+30KXuaQRxcrZWt03NoyKlYOJPfd2
	d5VlzLvv7baupyosDoQInLi9XmH0rC45UOZxxnziFu4THwV/UsVWYmFYDBHWnDUUNZEGh0s5VKDbA
	71hFaYUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPe2S-0000000FEpM-4BxQ;
	Fri, 05 Jul 2024 08:11:29 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPe2O-0000000FEn1-34xv
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jul 2024 08:11:27 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9F60221B46;
	Fri,  5 Jul 2024 08:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720167082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tiGUa6DYGC5pVPivDy4o/t96kXlnu57+QS3U5DUYdXk=;
	b=NWnx6xWDpiIk7Vc776J0t6oorFn8oSKztvanmf8Zymz5PbadEKRd2SFLjptW4UqBUEUuED
	RtNz1ZxsUXh/s+t5kcXNEGYZET8CVV/6jAy3w2MKwxv9r6YU29qLhrOpKMxuvSQ4vURif8
	fYpU6OrMgow8trevaSbd0h0G8VcpvNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720167082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tiGUa6DYGC5pVPivDy4o/t96kXlnu57+QS3U5DUYdXk=;
	b=GcVQ/8lrYPS+e2qinx0KU9egv807xU07s2R63Uan8KyvxzOMcmjZJ0apdp5sV8Lw7eZq2E
	8TRLAUcAezjia0Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NWnx6xWD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="GcVQ/8lr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720167082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tiGUa6DYGC5pVPivDy4o/t96kXlnu57+QS3U5DUYdXk=;
	b=NWnx6xWDpiIk7Vc776J0t6oorFn8oSKztvanmf8Zymz5PbadEKRd2SFLjptW4UqBUEUuED
	RtNz1ZxsUXh/s+t5kcXNEGYZET8CVV/6jAy3w2MKwxv9r6YU29qLhrOpKMxuvSQ4vURif8
	fYpU6OrMgow8trevaSbd0h0G8VcpvNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720167082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tiGUa6DYGC5pVPivDy4o/t96kXlnu57+QS3U5DUYdXk=;
	b=GcVQ/8lrYPS+e2qinx0KU9egv807xU07s2R63Uan8KyvxzOMcmjZJ0apdp5sV8Lw7eZq2E
	8TRLAUcAezjia0Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BB4D1396E;
	Fri,  5 Jul 2024 08:11:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t0uwIaqqh2Z3NQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 05 Jul 2024 08:11:22 +0000
Message-ID: <8beb0e36-af31-4633-ae2a-afa6bcec5a14@suse.de>
Date: Fri, 5 Jul 2024 10:11:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] nvme-tcp: per-controller I/O workqueues
To: Christoph Hellwig <hch@lst.de>
Cc: Tejun Heo <tj@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-2-hare@kernel.org>
 <7e4444d0-f156-439e-9363-4beb86bb6248@grimberg.me>
 <c9f73300-9860-4965-88af-9a7b4d7b0e1b@suse.de>
 <ad15b94b-9414-4ec1-9acf-465a8b190fe5@grimberg.me>
 <ZoWFOnvgWEiKipW6@slm.duckdns.org>
 <aaa404b1-72ac-4b15-8c30-a62ef2216004@grimberg.me>
 <ZoWjxtyjHTC2r285@slm.duckdns.org>
 <9de5d83c-4b05-4f69-8ab4-b4aa65e5ec62@suse.de>
 <20240705071022.GA13302@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240705071022.GA13302@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9F60221B46
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240705_011124_945113_9371842B 
X-CRM114-Status: GOOD (  10.31  )
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

On 7/5/24 09:10, Christoph Hellwig wrote:
> Btw, I don't think brd is what we should optimize for.  brd does
> synchronous I/O from ->submit_bio which makes it very non-typical.
> Trying to get this as good as possible for QD=1 might be fine,
> but once we have deeper queue depth and/or bigger I/O size it will
> use a lot more time in the submission context (aka the workqueues here)
> than a real device.
> 
Hmm. brd was the simplest choice to get a high-bandwidth target.
I'll check if a get a similar performance with null-blk.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


