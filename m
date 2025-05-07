Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E217FC3ABC6
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4iPgqhoayMe3zcDnDhjT6VS71oNH4/EEsD7p6lChhXY=; b=bjiD10hQ7cVoHkmAD8P5D9LXk+
	r+SpK795jywwI+YGw0vVvDf5/ZUUWB0PZg82YhuQqRScfcuu2a6MKtFZOMgk1InBd0m+4cBL1V2qm
	rB1fuq7ZpYu1t05pPwBfM+ZLsAAncL6VZZZcWGwD3u7fuDco/FjqGznMxsBev5jThwaX28/OyqWa5
	yP3q6l9s3roVV52+31JaJGTegBDSXe9vpfPE5W237gZocIqG5KYh6K/BtqLTEN9hvA1IULsqUGpz4
	uaP0HDM4KHd+zPUZmvWX7sXQtwYtkXqGUcb+/mI4Zt+k9vwXSgc+ODHeSjbTWoXkyvO6RrDn9dV13
	bOn01gGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCaEE-0000000Eka3-0j6f;
	Wed, 07 May 2025 08:34:10 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZDV-0000000EX8t-1O3s
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:29:22 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9EDE11F38C;
	Wed,  7 May 2025 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746602958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4iPgqhoayMe3zcDnDhjT6VS71oNH4/EEsD7p6lChhXY=;
	b=Hz/DO9a5M5DBqg3UlGRyS02GCpsz1Pqmq++OeMCSMDrthtF+NOGTeMsfOkh4+5eg/d2f5P
	LpAxWQhWXUgSWNkV6P6LH4B/TSPsg5faiNvicdmlTmMTf/jolQsG6ttSPRZOEg17qraM88
	RDFqBQ8ItbUHEkZokhGi1vWq8/GY+yA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746602958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4iPgqhoayMe3zcDnDhjT6VS71oNH4/EEsD7p6lChhXY=;
	b=KHp9kEvQ8mL5kLGVv9Ym59SUzXguBJrgXwQk8l/Ft9fOyeSKPQTiORRbtAz6xL1VcssEP+
	N25A8Hag3+QZdECg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Hz/DO9a5";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KHp9kEvQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746602958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4iPgqhoayMe3zcDnDhjT6VS71oNH4/EEsD7p6lChhXY=;
	b=Hz/DO9a5M5DBqg3UlGRyS02GCpsz1Pqmq++OeMCSMDrthtF+NOGTeMsfOkh4+5eg/d2f5P
	LpAxWQhWXUgSWNkV6P6LH4B/TSPsg5faiNvicdmlTmMTf/jolQsG6ttSPRZOEg17qraM88
	RDFqBQ8ItbUHEkZokhGi1vWq8/GY+yA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746602958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4iPgqhoayMe3zcDnDhjT6VS71oNH4/EEsD7p6lChhXY=;
	b=KHp9kEvQ8mL5kLGVv9Ym59SUzXguBJrgXwQk8l/Ft9fOyeSKPQTiORRbtAz6xL1VcssEP+
	N25A8Hag3+QZdECg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 625A713882;
	Wed,  7 May 2025 07:29:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KMbqFc4LG2gWVgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 07 May 2025 07:29:18 +0000
Message-ID: <17b5d757-15b2-4ae3-97f3-7697c31127da@suse.de>
Date: Wed, 7 May 2025 09:29:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] nvme-auth: modify nvme_auth_transform_key() to
 return status
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20250425094927.102656-1-hare@kernel.org>
 <20250425094927.102656-2-hare@kernel.org> <20250507072429.GA2347@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250507072429.GA2347@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9EDE11F38C
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_002921_511323_674A579C 
X-CRM114-Status: GOOD (  12.10  )
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

On 5/7/25 09:24, Christoph Hellwig wrote:
> On Fri, Apr 25, 2025 at 11:49:16AM +0200, Hannes Reinecke wrote:
>> Modify nvme_auth_transform_key() to return a status and provide
>> the transformed data as argument on the command line as raw data.
> 
> Well, it's pretty obvious that you do this from the code changes.
> 
> But why do you change it?
> 
You are right, the description is incorrect.
Main point here is to return a raw byte string containing the
transformed key data (and not a key structure).
Doing so makes the following modifications easier to read.
One hopes.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

