Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60112C54F5F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 07:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oBZlRQN0606okgzk/iuQscD2rVnCeVYnyj0xKtt1sXM=; b=MnDMlalWZcmxVSvrNJWcflu4um
	TIALsjJ/1YZ/dLePefFC3sBZmkMPVYca7Vwv2djTDqLDhfqDq0nk+xSXoBf6Yhqt2Fjr9rFA8Ad7v
	HR3fInQX6M2AJgf2f0F184Ly20O2ZO27TwoebsWazPbz2T1DSIdrV+etsnK+HjnWFyK16T5etYYHb
	1tvmFhjGCpHXi3XtlLTxCytKfkz46AAAfocga6H09Xxv/3IcyEhyC90GRKpfl5k4BP1cV2uw+5U8Q
	cskx9TEL0OLoZ3Vz13G9iXdOqt6xGKUWrFgto78BS7LPPPVss47XmyUuonDoCMueBv2Im+V2Uo3z/
	lsTyVurQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtKtm-0000000DLfm-2WBe;
	Fri, 20 Feb 2026 07:26:02 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtKth-0000000DLfM-464s
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 07:26:01 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0981A5BCC2;
	Fri, 20 Feb 2026 07:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771572356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBZlRQN0606okgzk/iuQscD2rVnCeVYnyj0xKtt1sXM=;
	b=pCZ79un5ZhHDdGcMTmLBbEW9YXC4wqQlequjPtus9zPxIFmEv69tiszB3jCfBVGWHsGNfz
	lRWQ3iTrYjfPsdTba38wNllC/PAT4RcHIbzqWOj5dxIlREA/JOoknFS9G2TIPs9hIVZnYM
	bO4JLDm9nAj8utlygVC4s5N9r0rjf88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771572356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBZlRQN0606okgzk/iuQscD2rVnCeVYnyj0xKtt1sXM=;
	b=qY7GXFmuGozzlLar0ooztBoWRMrSfkfaKEMAIKjYNmtOQmukgzoBgHyLzrMZVWA2Eybgv4
	6Z/VUGwathqbegCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pCZ79un5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qY7GXFmu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771572356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBZlRQN0606okgzk/iuQscD2rVnCeVYnyj0xKtt1sXM=;
	b=pCZ79un5ZhHDdGcMTmLBbEW9YXC4wqQlequjPtus9zPxIFmEv69tiszB3jCfBVGWHsGNfz
	lRWQ3iTrYjfPsdTba38wNllC/PAT4RcHIbzqWOj5dxIlREA/JOoknFS9G2TIPs9hIVZnYM
	bO4JLDm9nAj8utlygVC4s5N9r0rjf88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771572356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBZlRQN0606okgzk/iuQscD2rVnCeVYnyj0xKtt1sXM=;
	b=qY7GXFmuGozzlLar0ooztBoWRMrSfkfaKEMAIKjYNmtOQmukgzoBgHyLzrMZVWA2Eybgv4
	6Z/VUGwathqbegCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C8413EA65;
	Fri, 20 Feb 2026 07:25:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Zqb9BYMMmGnmaQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 20 Feb 2026 07:25:55 +0000
Message-ID: <5dd3f2a9-5b8c-4604-a84d-46532b1802fc@suse.de>
Date: Fri, 20 Feb 2026 08:25:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/21] nvme: Update CCR completion wait timeout to
 consider CQT
To: Randy Jennings <randyj@purestorage.com>,
 Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <jsmart833426@gmail.com>, Aaron Dailey
 <adailey@purestorage.com>, Dhaval Giani <dgiani@purestorage.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-19-mkhalfella@purestorage.com>
 <9d6cf4f9-37d8-4704-bcc1-0b849ad28955@suse.de>
 <20260216184515.GH2392949-mkhalfella@purestorage.com>
 <3bad149e-a0fa-4377-9701-7b35ef6b5b88@suse.de>
 <20260217153530.GI2392949-mkhalfella@purestorage.com>
 <CAPpK+O35BBLnQOuPg37v772g7LtOpo6onxENRObUi7C_xLCoPQ@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAPpK+O35BBLnQOuPg37v772g7LtOpo6onxENRObUi7C_xLCoPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me,purestorage.com,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0981A5BCC2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_232559_324944_7F1BD6C0 
X-CRM114-Status: GOOD (  14.17  )
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

On 2/20/26 03:01, Randy Jennings wrote:
> Hannes,
> 
>> (ctrl->kato * 1000) + ctrl->cqt
> As Mohamed pointed out, we have already received a response from a CCR
> command.  The CCR, once accepted, communicates the death of the
> connection to the impacted controller and starts the cleanup tracked
> by CQT.  So, no need to wait for the impacted controller to figure out
> the connection is down.
> 
> The max(cqt, kato) was just to give some wait time that should allow
> issuing a CCR again from a different controller (in case of losing
> communication with this one).  It certainly does not need to be longer
> than cqt (and it should be no longer than the remaining duration of
> time-based retry; that should get addressed at some point).  I cannot
> remember why kato (if larger; I expect it would be smaller) made sense
> at the time.
> 
Because we have to wait for the AEN, at which point KATO comes into
play yet again.
So max(CQT, KATO) is the appropriate waiting time for that.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

