Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D6AE9A03B
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Feb 2026 07:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dYRuqwG/NUpxzBvJza7jNBHIpMXKK4N/DcLmhAb2bIs=; b=td2rY7LQPoCD93DXrxRSUh21ru
	qKLe8zw9okRbBccKGXiIDH+XMWrciNQvqvXPsvEJGzC5UBZWkwQmL9Vy6x6foyI/FRAtpb+FknHtS
	OQsWCE6hpPOvw7nUM+DENXTT7Xt8Mh2VPzyFOKS4iFLR2Reb5tKJaLAs3c5hjP1Bn/BDpE/1laOWr
	lKoktgteNA13DcHVWtOHsTwn3U1t+CZpukVZnWUlHSPaaehwPyU9A4mDkqMYLYsmQHKudgi6UCRAq
	mBa4aRTThpv+I5R+BYtCvzM2R1+yqqn1ittlYn7oPU8ILYMnaK/tnyJhRIcRWPHIW/+3b5qgpWsTR
	q6sbxq2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vscLR-00000009QYo-2Mgf;
	Wed, 18 Feb 2026 07:51:37 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vscLO-00000009QXg-2KID
	for linux-nvme@lists.infradead.org;
	Wed, 18 Feb 2026 07:51:35 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B4E93E6D0;
	Wed, 18 Feb 2026 07:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771401092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dYRuqwG/NUpxzBvJza7jNBHIpMXKK4N/DcLmhAb2bIs=;
	b=vPMEq/SvFwMyxUvu1dFyWtE8+me/qKySzIrbEraiXFYA+itKuLJHJJdL8QJ0DhrJVjKcu/
	Q4jhRnF/BJWPHUZ2CjdnPyNri+7kAB/J4m/LNldeqNvwwlJq3kT4XjGa581MB3QrdvbSj+
	Pf+bC48ye6pF7yMVaCaaG3XOG1ewMgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771401092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dYRuqwG/NUpxzBvJza7jNBHIpMXKK4N/DcLmhAb2bIs=;
	b=p3ngbRmVeZc+PqBfADmIs5n+zERcNEKpS/qGlmgkAfurxo+KiU5WUj4V1PTQkOqCqb4Vz/
	4sNPWUmWMGtF3eBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="vPMEq/Sv";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=p3ngbRmV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771401092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dYRuqwG/NUpxzBvJza7jNBHIpMXKK4N/DcLmhAb2bIs=;
	b=vPMEq/SvFwMyxUvu1dFyWtE8+me/qKySzIrbEraiXFYA+itKuLJHJJdL8QJ0DhrJVjKcu/
	Q4jhRnF/BJWPHUZ2CjdnPyNri+7kAB/J4m/LNldeqNvwwlJq3kT4XjGa581MB3QrdvbSj+
	Pf+bC48ye6pF7yMVaCaaG3XOG1ewMgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771401092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dYRuqwG/NUpxzBvJza7jNBHIpMXKK4N/DcLmhAb2bIs=;
	b=p3ngbRmVeZc+PqBfADmIs5n+zERcNEKpS/qGlmgkAfurxo+KiU5WUj4V1PTQkOqCqb4Vz/
	4sNPWUmWMGtF3eBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCE063EA65;
	Wed, 18 Feb 2026 07:51:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d45RMINvlWlEewAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 18 Feb 2026 07:51:31 +0000
Message-ID: <1a9feff7-5a0d-4385-b582-c9ab60d724db@suse.de>
Date: Wed, 18 Feb 2026 08:51:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/21] nvme: Implement cross-controller reset
 completion
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <jsmart833426@gmail.com>, Aaron Dailey
 <adailey@purestorage.com>, Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-10-mkhalfella@purestorage.com>
 <3b21ccbd-7948-436b-8faa-a5541c65946a@suse.de>
 <20260217182554.GE3435530-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260217182554.GE3435530-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me,purestorage.com,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 4B4E93E6D0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_235134_747698_3A5D3C77 
X-CRM114-Status: GOOD (  19.32  )
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

On 2/17/26 19:25, Mohamed Khalfella wrote:
> On Mon 2026-02-16 13:43:51 +0100, Hannes Reinecke wrote:
[ .. ]
>>
>> We really would need some indicator whether 'ccr' is supported at all.
> 
> Why do we need this indicator, other than exporting it via sysfs?
> 
To avoid false positives.

>> Using the number of available CCR commands would be an option, if though
>> that would require us to keep two counters (one for the number of
>> possible outstanding CCRs, and one for the number of actual outstanding
>> CCRs.).
> 
> Like mentioned above ctrl->ccr_limit gives us the number of ccrs
> available now. It is not 100% indicator if CCR is supported or not, but
> it is enough to implement CCR. A second counter can help us skip trying
> CCR if we know impacted controller does not support it.
> 
> Do you think it is worth it?
> 
Yes. The problem is that we want to get towards TP8028 compliance, which
forces us to wait for 2*KATO + CQT before requests on the failed patch
can be retried. That will cause a _noticeable_ stall on the application
side. And the only way to shorten that is CCR; once we get confirmation
from CCR we can start retrying immediately.
At the same time the current implementation only waits for 1*KATO before
retrying, so there will be regression if we switch to TP8028-compliant
KATO handling for systems not supporting CCR.

So we can (and should) use CCR as the determining factor whether we
want to switch to TP8028-compliant behaviour or stick with the original
implementation.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

