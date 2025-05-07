Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD3DC3ABCB
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8zlK2BCRLZ6n+qq0Kbo994C3j63Gw1W1tNJ+bofvdWE=; b=JfPXVyTmBz+oPsb1EPwjtQ6PPW
	RoHN6H9djaWo+gkbQxAGX1cp38mSbeso08RuPtl6wh4wiY64O/HLelv4bFs1VXHuoZp2PXghxzvJg
	jr4AuZ1u/a18nB+mR2d4onElyh6waRK1aq9F0+bvUZJbHsWUT5F3j5L47ehRQPamEXGaFKp3Knamm
	h2T8RHXYYr5lm+Tkfqi0EW1xwC9vGraTzOti+xvMXAvvynS7A7akNVWinEbH1yZEYGP0rUMl9OgbN
	i67/IhfGlSxZxPJw4OrEEMbOkwP6CpvHyhlIHnWdaQsR8f7q4KCPkyvAUCdAl+YEIsR8D66qFUvwv
	6lwVFbXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCaEH-0000000Ekcu-0FPF;
	Wed, 07 May 2025 08:34:13 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZFB-0000000EXfF-3Mzn
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:31:07 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 63BB32118B;
	Wed,  7 May 2025 07:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746603062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zlK2BCRLZ6n+qq0Kbo994C3j63Gw1W1tNJ+bofvdWE=;
	b=CX6/perpdzOLx0ILComh28A5OoEFQ7rgzMGTpdtoyRbjh76usS8Y6Y9parzQ3OPDbgyo15
	CdiYvLlRJVcdqgT6AtPyylp3J0yh5z3/Pz4IBQENqDEaF4HqgUBat37WHoU+M90RzW93nh
	gvn24OrQJmky7ROU/DDFsajpVWGzINg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746603062;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zlK2BCRLZ6n+qq0Kbo994C3j63Gw1W1tNJ+bofvdWE=;
	b=rQyX8xlBGyEBuXJT7IibeWmIct093tTVjKfgUa6SwN/1ZdJ2pmsy6ODrdBbxrj/auRO+hY
	7LrH9Y8xvaFudtDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="CX6/perp";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rQyX8xlB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746603062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zlK2BCRLZ6n+qq0Kbo994C3j63Gw1W1tNJ+bofvdWE=;
	b=CX6/perpdzOLx0ILComh28A5OoEFQ7rgzMGTpdtoyRbjh76usS8Y6Y9parzQ3OPDbgyo15
	CdiYvLlRJVcdqgT6AtPyylp3J0yh5z3/Pz4IBQENqDEaF4HqgUBat37WHoU+M90RzW93nh
	gvn24OrQJmky7ROU/DDFsajpVWGzINg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746603062;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zlK2BCRLZ6n+qq0Kbo994C3j63Gw1W1tNJ+bofvdWE=;
	b=rQyX8xlBGyEBuXJT7IibeWmIct093tTVjKfgUa6SwN/1ZdJ2pmsy6ODrdBbxrj/auRO+hY
	7LrH9Y8xvaFudtDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26A7713882;
	Wed,  7 May 2025 07:31:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ho6NBzYMG2hZVwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 07 May 2025 07:31:02 +0000
Message-ID: <e8294618-b953-4b4b-a129-b66b407dac6b@suse.de>
Date: Wed, 7 May 2025 09:30:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] nvme: Unify Kconfig settings
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20250425094927.102656-1-hare@kernel.org>
 <20250425094927.102656-13-hare@kernel.org> <20250507072306.GB1839@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250507072306.GB1839@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 63BB32118B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_003105_995208_7053E107 
X-CRM114-Status: GOOD (  13.50  )
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

On 5/7/25 09:23, Christoph Hellwig wrote:
> On Fri, Apr 25, 2025 at 11:49:27AM +0200, Hannes Reinecke wrote:
>> As authentication now requires the keyring to be present streamline the
>> Kconfig setting to always select the same symbols for both host and target.
> 
> This fails to apply with the select tcp fixes from Alistair.
> 
> But I also totally fail to understand the commit message.  Either
> some library code is needed and we need to select it, or it is not
> and we don't need it.  Being uniform should not matter.
> 
> So when respinning this please explain what is fixed, and split it into
> separate host vs target patches.
> 
Sure.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

