Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9C8C3601E
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 15:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yWr2egWo+USWK1z1SRY9dFO3FG4q5w5qm7DUihHpRas=; b=VrKVqTteiTbKJHIU3QUXTzEzfc
	9/40ID1XUrwi3yKUXfajHxzSkRGP8rSxt86uI3pC9ijOEu3Dv5zVWdLm3otSqK+0ha1PXx9OEKcvo
	9AAgAuUSx262D1hal2WJfmBPN/ZR7Xg04sGC1XOxv0acTfHLoTUXYs9GzpMmgyzp52aXvBp1hdK1y
	6Qp9vHGPlSFk/wdhw2IOPEW4DC3kMuQlSQjavPEXsabgYb6+IPAqJYQNHf7phWTHFAz/6edJP+NCE
	a4du5xt695S96AUSGLTj/PGUXn2wNQm+QU7HqsJ3IenAFLbA+Jy86Mpi3/AIbPLaApQc8OSzb6tkD
	ZHsO0gdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Mdr-00000009Fgz-40CL;
	Thu, 03 Apr 2025 15:38:07 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0MYx-00000009F22-1gru
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 15:33:04 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6934F1F38A;
	Thu,  3 Apr 2025 15:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743694380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWr2egWo+USWK1z1SRY9dFO3FG4q5w5qm7DUihHpRas=;
	b=geWg4NzfoRRAzN5i2B1013va9qsyVxgMRFpuLL0qEcTg9uEfagckhpmqcMsFSgn9leRssv
	nIX4CCTg8NY62efNCFe89Wi/ELRUClbrOn7vgNZ/z30bfdqwX4WY5IwHCpvOPH73+TuOxH
	7RfAXrm96l0ZYoBiY3GDnI1kyPgdGU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743694380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWr2egWo+USWK1z1SRY9dFO3FG4q5w5qm7DUihHpRas=;
	b=AOlxThh/pfMBqGLDIbv94rzxRK31KAEsRYU8tpIP+6F79c5ZsxUIwz11noLdQn94gci1J6
	xkJ6jRCLgMgariAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=geWg4Nzf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="AOlxThh/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743694380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWr2egWo+USWK1z1SRY9dFO3FG4q5w5qm7DUihHpRas=;
	b=geWg4NzfoRRAzN5i2B1013va9qsyVxgMRFpuLL0qEcTg9uEfagckhpmqcMsFSgn9leRssv
	nIX4CCTg8NY62efNCFe89Wi/ELRUClbrOn7vgNZ/z30bfdqwX4WY5IwHCpvOPH73+TuOxH
	7RfAXrm96l0ZYoBiY3GDnI1kyPgdGU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743694380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWr2egWo+USWK1z1SRY9dFO3FG4q5w5qm7DUihHpRas=;
	b=AOlxThh/pfMBqGLDIbv94rzxRK31KAEsRYU8tpIP+6F79c5ZsxUIwz11noLdQn94gci1J6
	xkJ6jRCLgMgariAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B03D13A2C;
	Thu,  3 Apr 2025 15:33:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /9EuDSyq7mdgawAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 03 Apr 2025 15:33:00 +0000
Message-ID: <c304f189-cc59-4ae3-b42a-282eb74f02cf@suse.de>
Date: Thu, 3 Apr 2025 17:32:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: re-read ANA log page after ns scan completes
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20250403071930.52154-1-hare@kernel.org>
 <20250403071930.52154-3-hare@kernel.org> <Z-6haRYmf7PMn3vW@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Z-6haRYmf7PMn3vW@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6934F1F38A
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_083303_605131_97D88DB1 
X-CRM114-Status: GOOD (  11.86  )
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

On 4/3/25 16:55, Keith Busch wrote:
> On Thu, Apr 03, 2025 at 09:19:30AM +0200, Hannes Reinecke wrote:
>> When scanning for new namespaces we might have missed an ANA AEN,
>> so we should always re-read the ANA log page after scanning to ensure
>> we don't miss updates there.
> 
> Worst case we might check a log page that hasn't changed. Rescans should
> be rare, so I guess it's fine. But I'm not sure why scanning might cause
> an ANA AEN to be missed. ?
>   
Well, it's not that we're _missing_ AENs here.
As per quoted spec ANA change events are not sent if there had been
an event (on the controller) which would have caused both an ANA change
event and an NS changed AEN to be sent.

So any NS changed event really needs to be treated as a combination of
NS changed _and_ ANA changed, and after each namespace rescan we need
to re-read the ANA log page.

Sigh.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

