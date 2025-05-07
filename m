Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD13C3ABCA
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J6/Svaf8PrK2AUv9aG75LSG6DNXu0gsyTznPNmOHQ3o=; b=tVD7c0KKJMjYKGPK//FksbLSYe
	IIiCYPzt++B1yY7+2ZoCE4RFsS4pMtQQToBVn+E8iCwbu17fbmScZv9Vn84oS8/s4E0WGJhr+Qz0r
	BWHZXULLkBnV3BwQDaFUohFGS2wMW5yUCZubYzaX/7jh8yqML9RtsNAzvkuSiuX4d6B+ucRY7/DiW
	YuWST1dei5bOoG968I7mX7jJdgUY5fAxlRW1+L2Qo7vMvhTc8p8Thnn0uju3xvQKz7mOGPJGpBRLE
	f5+G8XgIXpXyxyGPBSMS/wgd9Nt8uW7vCK3Hr8IzBYjQjEmY6SeSJlnP+0LE2sIDF7QMo/gWEmL3q
	OQi5o7Lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCaEF-0000000EkbS-2UTy;
	Wed, 07 May 2025 08:34:11 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZEH-0000000EXLn-3yOu
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:30:11 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4640F2118B;
	Wed,  7 May 2025 07:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746603008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6/Svaf8PrK2AUv9aG75LSG6DNXu0gsyTznPNmOHQ3o=;
	b=Ib7WcbyXj9qGrK4X/y5RdbQKE2NDuVirnKrOtwzpHfa/HDnEyKlTuZGXmEGl4Z/LFoyOge
	LAdQr6k2Q2W5n93poSS6EKpWNttUcZdC2prDjv/KsSMPzBPSFFJFX7eMKu7dAlmks3IoHb
	UCbZe7akA0QgMl3bk0um9dUg2CV+4MQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746603008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6/Svaf8PrK2AUv9aG75LSG6DNXu0gsyTznPNmOHQ3o=;
	b=HfA1vgPblEz0p4V6t4D1zKsJQeKXaxP93feozHCPluo3BbzqLeUN+38oAn2Aj07eZ9WFk/
	ZxcEGvxq4kSGqeDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ib7WcbyX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HfA1vgPb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746603008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6/Svaf8PrK2AUv9aG75LSG6DNXu0gsyTznPNmOHQ3o=;
	b=Ib7WcbyXj9qGrK4X/y5RdbQKE2NDuVirnKrOtwzpHfa/HDnEyKlTuZGXmEGl4Z/LFoyOge
	LAdQr6k2Q2W5n93poSS6EKpWNttUcZdC2prDjv/KsSMPzBPSFFJFX7eMKu7dAlmks3IoHb
	UCbZe7akA0QgMl3bk0um9dUg2CV+4MQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746603008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6/Svaf8PrK2AUv9aG75LSG6DNXu0gsyTznPNmOHQ3o=;
	b=HfA1vgPblEz0p4V6t4D1zKsJQeKXaxP93feozHCPluo3BbzqLeUN+38oAn2Aj07eZ9WFk/
	ZxcEGvxq4kSGqeDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10B4E13882;
	Wed,  7 May 2025 07:30:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FgSLAgAMG2ibVgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 07 May 2025 07:30:08 +0000
Message-ID: <61b8f3fc-5677-4aaa-9165-500adb159bf1@suse.de>
Date: Wed, 7 May 2025 09:30:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] nvme-auth: drop nvme_dhchap_key structure and
 unused functions
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20250425094927.102656-1-hare@kernel.org>
 <20250425094927.102656-8-hare@kernel.org> <20250507072616.GC2347@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250507072616.GC2347@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4640F2118B
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_003010_126469_17512B8F 
X-CRM114-Status: UNSURE (   9.85  )
X-CRM114-Notice: Please train this message.
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

On 5/7/25 09:26, Christoph Hellwig wrote:
> On Fri, Apr 25, 2025 at 11:49:22AM +0200, Hannes Reinecke wrote:
>> Drop the hand-crafted nvme_dhchap_key structure and the now unused
>> functions.
> 
> This should go into the previous patch instead of just creating dead
> code there.
> 
Will be doing so for the next round.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

