Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7629FC52D7C
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Aug 2024 14:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bdSOL4xrNiFJQg93SF6XEUOaRD8vcV/nxfFZn7TZYPM=; b=loPv9ybKpGNHN96mGFV5R3ZyXC
	VvwJFKP11rsRP1Qz8cl7Pyg0gwfIxIFBWZzs2cqywm3H4D9Rrt/5KM0tGfZ5UpoCMBxhzt5GruB2w
	5rOY2gvfWFnZvShuUCbheuIIMciCrvTbzeM9bsnpLwPkU3Ap5r7yrV2gvzOksU8xrGUPr1vwEwb3b
	tZCS49fi+NhBuOvttumQphkKZJExPTnOMwgHSDxP+8DzzJkCJTB+3iKLwXLHDQBp2lBQmy/z5/h/O
	xt1SiV6hmqB18f7rmt3bD1NAdHP5wQy3RhwDMD67iLkR5x9ZvrZ8L728mIyAq3dhgqfX83T/2yIpI
	Yo0amlgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdW2D-00000000Zgl-2Skj;
	Mon, 12 Aug 2024 14:28:33 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdW28-00000000Zem-1mRV
	for linux-nvme@lists.infradead.org;
	Mon, 12 Aug 2024 14:28:31 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F1791F8AB;
	Mon, 12 Aug 2024 14:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723472906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdSOL4xrNiFJQg93SF6XEUOaRD8vcV/nxfFZn7TZYPM=;
	b=GiRNM7SI9qu3yl8tDjo3NzDGuhmFwpUjaZqdP4VwIUzbxGvyyo4tmk7PQjI/mU5jKzhXwH
	gXh6+Yfz/jCed+o1jjeBlg8YaRalvWjCNca61ZSbrWa5YYq53ue4OLLwUPVDMDTcd6NM8F
	35jv2/fI8QakWORXTt4DreI1R9NE2Mk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723472906;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdSOL4xrNiFJQg93SF6XEUOaRD8vcV/nxfFZn7TZYPM=;
	b=8k/3f53SQCVrMBL9l1nUD5KNc1/0Zf/aAaIK53My/BRsILbRv+RP8r4agygXVISH0pPaYQ
	ihPhyKlLBvdimCBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GiRNM7SI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="8k/3f53S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723472906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdSOL4xrNiFJQg93SF6XEUOaRD8vcV/nxfFZn7TZYPM=;
	b=GiRNM7SI9qu3yl8tDjo3NzDGuhmFwpUjaZqdP4VwIUzbxGvyyo4tmk7PQjI/mU5jKzhXwH
	gXh6+Yfz/jCed+o1jjeBlg8YaRalvWjCNca61ZSbrWa5YYq53ue4OLLwUPVDMDTcd6NM8F
	35jv2/fI8QakWORXTt4DreI1R9NE2Mk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723472906;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdSOL4xrNiFJQg93SF6XEUOaRD8vcV/nxfFZn7TZYPM=;
	b=8k/3f53SQCVrMBL9l1nUD5KNc1/0Zf/aAaIK53My/BRsILbRv+RP8r4agygXVISH0pPaYQ
	ihPhyKlLBvdimCBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F6D613A23;
	Mon, 12 Aug 2024 14:28:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 60OlHgocumbPEAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 12 Aug 2024 14:28:26 +0000
Message-ID: <e3626d04-cde3-40dd-bd54-b642d18d73ef@suse.de>
Date: Mon, 12 Aug 2024 16:28:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2] nvme: basic RMEDIA support for host
To: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: Wang Yugui <wangyugui@e16-tech.com>, linux-nvme@lists.infradead.org
References: <20240723232419.19753-1-wangyugui@e16-tech.com>
 <20240724123052.49185-1-wangyugui@e16-tech.com>
 <6bb781f7-1895-4c8e-8501-dc21732c5e37@kernel.org>
 <ZqJcyw9haCcDvK1r@infradead.org>
 <1b8f549d-4d24-48af-baea-952076d37834@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1b8f549d-4d24-48af-baea-952076d37834@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8F1791F8AB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240812_072828_740112_216A7102 
X-CRM114-Status: GOOD (  17.51  )
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

On 7/26/24 00:59, Damien Le Moal wrote:
> On 7/25/24 23:10, Christoph Hellwig wrote:
>> On Thu, Jul 25, 2024 at 09:43:45AM +0900, Damien Le Moal wrote:
>>> Why not do that now in another patch, at least for the loop target ?
>>> Given that they are not that many NVMe-HDD out there, that would be
>>> nice to have to test this.
>>
>> The code would be in the bdev backend, so it applies to all transport
>> equally.  And yes, I'd love to see a patch for that to, but I don't
>> want to gate a simple flag check on it.
> 
> OK. Will look into it then. I have the setup to test this anyway.
> 
> That said, while setting only the rotational media bit should be fairly easy, I
> am worried about spec compliance as setting that flag to 1 mandates support for
> endurance groups as well. Do we care about this ? I am tempted to say no but not
> following the specs is generally a dangerous path we do not want to follow...
> 
I'd got for the usual minimal-viable implementation way like adding 
static logpages for the endurance group information (with just a single 
endurance group '1') and for endurance group event aggregate (with no 
events :-).

Shouldn't blow up the code _that_ much.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


