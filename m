Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9BED41D5F
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 06:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BRpvORTOMFzy5qFd27VOLPt2ACsbt+yf/TI9iXuBles=; b=yl3Zulb+2sdgqEA2Q+RyLm+aAT
	pzeqAJ2u2Q00VT3zAp5McdwNuqIbn9rSbWossn1dSRnMQBSjzWhLAyXlBxjUuHZ+szo5p3f322AHd
	Gi0hL+TF7t3gYdBoeE8uuH6AiO/kEyC9zrJiOvu4eYVBvzW2DWCjub5gup6prCekGGpnVno0wHXlb
	jfjZsqXTXrIJdD7XmFKXbp+4iFK3DlyAcYFHsycXWc5Mtpa3Jy39ZWjkKG6QSsjcWaqGyCSdUmzSi
	AGn6wLAAd4VWidIKn6vDh/Q+6OwA7rhld4yCqf2gQ4zBaojB8xjGm7jgmV7j6uFuMd/aGMWPSD1kx
	wXmg2Tvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAks3-00000002OIG-3o4R;
	Tue, 12 Nov 2024 06:59:27 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAkqQ-00000002O1y-0TPt
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 06:57:50 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7CF8C1F392;
	Tue, 12 Nov 2024 06:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731394662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRpvORTOMFzy5qFd27VOLPt2ACsbt+yf/TI9iXuBles=;
	b=fCGfEesdcxvN5BNO8T+wCFiHCjyTi9VttrEF7bpAeRVDE0oUtz+V+dyT1CWptFWnLOixau
	NlKt9xoX3eRdloMla0c53wki6aGDnlJ1bCF1aVQCYa9pGpylRP4tDPXbJCMK6txYpSCL6A
	lZ3XFb4hk3Cn6HRDKaJ1kYtRou7UseQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731394662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRpvORTOMFzy5qFd27VOLPt2ACsbt+yf/TI9iXuBles=;
	b=Qf2a27RRga0enIvmtMSrLjfc1RkioKRPtBGGqbi+pX91Q4mrDi9wPqBryqh4vAFLRnVvbl
	OsrLY85/NmhRovDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fCGfEesd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Qf2a27RR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731394662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRpvORTOMFzy5qFd27VOLPt2ACsbt+yf/TI9iXuBles=;
	b=fCGfEesdcxvN5BNO8T+wCFiHCjyTi9VttrEF7bpAeRVDE0oUtz+V+dyT1CWptFWnLOixau
	NlKt9xoX3eRdloMla0c53wki6aGDnlJ1bCF1aVQCYa9pGpylRP4tDPXbJCMK6txYpSCL6A
	lZ3XFb4hk3Cn6HRDKaJ1kYtRou7UseQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731394662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRpvORTOMFzy5qFd27VOLPt2ACsbt+yf/TI9iXuBles=;
	b=Qf2a27RRga0enIvmtMSrLjfc1RkioKRPtBGGqbi+pX91Q4mrDi9wPqBryqh4vAFLRnVvbl
	OsrLY85/NmhRovDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5181613301;
	Tue, 12 Nov 2024 06:57:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bX93EWb8Mmd1bQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 12 Nov 2024 06:57:42 +0000
Message-ID: <07ba0b79-1438-4068-a901-18d5713d52f2@suse.de>
Date: Tue, 12 Nov 2024 07:57:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 6/8] nvme/031: open-code helper functions
To: Daniel Wagner <dwagner@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org
References: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
 <20241107111354.80606-7-shinichiro.kawasaki@wdc.com>
 <724ac06f-b502-49a8-b50a-d8d7cbb850a1@flourine.local>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <724ac06f-b502-49a8-b50a-d8d7cbb850a1@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7CF8C1F392
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_225746_337723_F3AE177C 
X-CRM114-Status: GOOD (  10.81  )
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

On 11/11/24 11:42, Daniel Wagner wrote:
> On Thu, Nov 07, 2024 at 08:13:52PM +0900, Shin'ichiro Kawasaki wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> The default helper functions are doing quite some things which are unneccesary for
>> this test, so open-code them to call just the required functions.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 
> This will make it impossible to use 'remote targets':
> 
> https://lore.kernel.org/linux-nvme/20240627091016.12752-1-dwagner@suse.de/

You might be right. Let's see if I can rework the patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

