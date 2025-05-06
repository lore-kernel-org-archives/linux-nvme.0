Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA0CC3ABBC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 23:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r0hU5NZ4KbBbDEp5ykYrSzS8QxNddTlWW2mMuuFyv74=; b=CCd+612FTcv0Tu2Ig1f4AY9WT5
	zJ3Pr13bfXn6B8VVaYznyga6xCVoyDBY+PtK6taaYKnpRifXNDHPvW8OBrs6q79uP/BrATA/2Zo0Y
	svzVUtujkFhi3csgHakgIE7ElRXreYxNdveWDMhPS1aqmHkWahjyRJtfwPQjPJCFOdpZerfqMlRhL
	SSBtuNWPm/YqX6jop/bQQkC5wDvxeZAkWCWJ1R/hiO3ZOG8ljIroM5+NeqBlPPzfXFTrpLTIuENqB
	kqCCqQ+naggVjQMui9IU77jN83PkrZKqOwR5GQ98j9nY6VFicLoTPVrTf6TWAhjcWamZALGr321M2
	3oj5Mkgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCRpM-0000000Dfsz-03RW;
	Tue, 06 May 2025 23:35:56 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCMfP-0000000Cvy0-1s9E
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 18:05:20 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A7BFD211BF;
	Tue,  6 May 2025 18:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746554716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0hU5NZ4KbBbDEp5ykYrSzS8QxNddTlWW2mMuuFyv74=;
	b=KIXr2ew1oWlBlBjkfnbjCpSCbtV2XqOrIUYEeKGh7i5uCDpWek/fMsxID+RMwa62qjPUbd
	o6GqPvCe1E7qSklxLHGHWLSC2dl0TkFY1VPS/p1wL5TX0D2h3G1ksWxDAmzDkx0CWwGqj6
	UyEGYqcCrBjvefnbsUZT1h7/vMKTiOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746554716;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0hU5NZ4KbBbDEp5ykYrSzS8QxNddTlWW2mMuuFyv74=;
	b=zX2hhdFGRv4pSiBxXi/X5BLqKcsRJx2vHP6VucvIefHOQuECNxSTsIkEEN+ejYGB22Q6n0
	dptqbmLre18ddHAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KIXr2ew1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zX2hhdFG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746554716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0hU5NZ4KbBbDEp5ykYrSzS8QxNddTlWW2mMuuFyv74=;
	b=KIXr2ew1oWlBlBjkfnbjCpSCbtV2XqOrIUYEeKGh7i5uCDpWek/fMsxID+RMwa62qjPUbd
	o6GqPvCe1E7qSklxLHGHWLSC2dl0TkFY1VPS/p1wL5TX0D2h3G1ksWxDAmzDkx0CWwGqj6
	UyEGYqcCrBjvefnbsUZT1h7/vMKTiOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746554716;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0hU5NZ4KbBbDEp5ykYrSzS8QxNddTlWW2mMuuFyv74=;
	b=zX2hhdFGRv4pSiBxXi/X5BLqKcsRJx2vHP6VucvIefHOQuECNxSTsIkEEN+ejYGB22Q6n0
	dptqbmLre18ddHAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 606FB137CF;
	Tue,  6 May 2025 18:05:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +oexFVxPGmjVDAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 06 May 2025 18:05:16 +0000
Message-ID: <4cff2b68-32e8-4593-8a91-345171ae147f@suse.de>
Date: Tue, 6 May 2025 20:05:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>, Sagi Grimberg
 <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>, hch <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chris Leech <cleech@redhat.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-4-hare@kernel.org>
 <1edc23f5-eb48-4006-a2f4-d303b05bd3e0@suse.de>
 <e7371b8a-e0b3-4387-a941-292e1f46b2aa@grimberg.me>
 <5446ef17-d922-4467-9a3c-5001713cc260@suse.de>
 <dac1d594-cf64-41ce-8a23-4b246db75b83@grimberg.me>
 <eda7a691-037b-442d-bd36-a31f93e95cb1@suse.de>
 <976af4b7-578b-4e47-a2ff-7c74af0b9afa@grimberg.me>
 <30b16579-1a28-4d01-9afd-8ff3996db42d@grimberg.me>
 <BY5PR04MB68490F6DD7F1FDBE6999B54BBC842@BY5PR04MB6849.namprd04.prod.outlook.com>
 <6202ffd4-4a32-4f85-ab87-ac5a087c2f1a@grimberg.me>
 <BY5PR04MB6849D4BF87755B82A073BBDABC89A@BY5PR04MB6849.namprd04.prod.outlook.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <BY5PR04MB6849D4BF87755B82A073BBDABC89A@BY5PR04MB6849.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A7BFD211BF
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_110519_633274_BEA4E6E5 
X-CRM114-Status: GOOD (  20.35  )
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

Hi Kamaljit,

On 5/6/25 19:40, Kamaljit Singh wrote:
> Hi Sagi,
> 
>  >On 26/04/2025 2:47, Kamaljit Singh wrote:
>  >> Sagi,
>  >>
>  >>>> Right after the check sk_stream_is_writeable(), there could have new
>  >>>> room in the socket
>  >>>> send buffer, state_change() fired, and queued io_work, before we get
>  >>>> to the pending
>  >>>> check. This is the "lost event" problem.
>  >>> Actually, this is incorrect. write_space() -> queue_work(io_work) will
>  >>> be re-queued if io_work
>  >>> is currently running. Hence I'm not sure that this flag is needed.
>  >>>
>  >>> Kamaljit, can you run with the below and report if it fixes your 
> problem?
>  >> With the last set of fixes that included list_del_init() you 
> suggested, all
>  >> tests have been stable. I'm not seeing any more issues. Are you 
> asking to
>  >> test this patch regardless? If so, does this need to be in addition to
>  >> previous patches?
>  >
>  >Instead of my patch that introduces WAKE_SENDER - apply just the change
>  >below
>  >that looks at sk_stream_is_writeable() only. I no longer think that the
>  >other changes in that patch solve anything.
> Sorry, I was away on PTO. Working now to get the below patch tested.
> 
Can you please retest with the patchset '[PATCHv5 0/2] nvme-tcp: fixup 
I/O stall on congested sockets' _only_ ?
(on top of nvme-6.16 latest, of course).
I think I _should_ have included all the suggestions floating here,
but we need to have confirmation.

Thanks a bunch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

