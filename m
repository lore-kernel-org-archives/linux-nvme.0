Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C46BCED60E
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 06:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZUvmNROgTe+zDFbbvN49kzS7CEwuX4nR1G8VwmvuU84=; b=S1sQycgGWZP7InV0YhRxcQDGvY
	sA7x7RSu1Wcbd6eSmEljDx2kVQ9OTEehUjKiJmjzdcdImeVLNXCEAwpYWzoxBUARUm/WneNQ4i6HE
	GMfRmGTs/ieWcWzzP7kMN8ahGTsPRDBVnQlY6qL7BvAVUxat5he3n0chzry+6HDir2b4BXarH/oY1
	PZ6xQIwD9mz8DjioTCbTiCW+BQVgeigF0oLxud4QCt9BRFhRkXeQ4aE7HfseaHLC7v07crNTTrg8G
	nbjkuwxjLDnayQ4YoRQVE7T4Po3R08UX6x4/hjCRXOE8FRRU2+/iiNwnbhhtICZDPrpCiVPwNvTAc
	9hF/FadA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syQ70-000000085if-0XOM;
	Wed, 09 Oct 2024 06:23:54 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syQ6v-000000085hX-3H9G
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 06:23:53 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B294621E84;
	Wed,  9 Oct 2024 06:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728455028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUvmNROgTe+zDFbbvN49kzS7CEwuX4nR1G8VwmvuU84=;
	b=v+m6rvzQ/h/5Rmbngs0hyB7vCRuxb2QmNPndtrTjmaMv2+vLQN0tU7xnu9tNZopgg3etBf
	2fWWkFV/iA0C0gHZ/3cL1F2w2d4PMje7CDs0JBX5F6wuxAODHfEIasVORoEHwcPH6ZpC10
	WVSSq6hQYvqtvalBjZbjckftNsHqV+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728455028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUvmNROgTe+zDFbbvN49kzS7CEwuX4nR1G8VwmvuU84=;
	b=B5pqqtSxJtT7PqKWwsBnTRq11QW/93zBCsOCsduellJSdVIqNuyiuUhFpp2JKerOijT97E
	A6zIifUDzeDLt8Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rjO0IS+S;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ie+vUGRg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728455026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUvmNROgTe+zDFbbvN49kzS7CEwuX4nR1G8VwmvuU84=;
	b=rjO0IS+S5dlPQPk8RKkPB23EyY+sPc0DjyPLypJ2AsP1L5R5pI6QgBKh/RHO1WhtISdhXv
	a2xfvotr3WqsvFQeeopXjqchAGljJ5UU6sX5ZqkhokfEZDr+VpsbTKKbbynmo0bERJj2oI
	5chqfX1NSqtgJQUv86HXZYC3VCsDB/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728455026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUvmNROgTe+zDFbbvN49kzS7CEwuX4nR1G8VwmvuU84=;
	b=ie+vUGRgKlKRp1hsUKSoFixx+5FlSGoG8Ngh9osk2qr8UrNtmKXjx348Q1jF4AvliLe3A5
	hyhMhjRhkR4+SzBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D768136BA;
	Wed,  9 Oct 2024 06:23:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wFb7HHIhBmfeJgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 09 Oct 2024 06:23:46 +0000
Message-ID: <3b8ff898-9529-4506-8c5d-0fcf3423730f@suse.de>
Date: Wed, 9 Oct 2024 08:23:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-multipath: cannot disconnect controller on stuck
 partition scan
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20241007100134.21104-1-hare@kernel.org>
 <20241007100134.21104-3-hare@kernel.org> <ZwQmK6dZ_goSQ4Cg@kbusch-mbp>
 <47968bf9-2b98-4e5e-9040-2db6f15d86a6@suse.de> <ZwWY8d3vOLUaYaJ6@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZwWY8d3vOLUaYaJ6@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B294621E84
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_232349_993515_7CFA71DE 
X-CRM114-Status: GOOD (  10.69  )
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

On 10/8/24 22:41, Keith Busch wrote:
> On Tue, Oct 08, 2024 at 09:17:47AM +0200, Hannes Reinecke wrote:
>> Hmm. Sadly, not really. Still stuck in partition scanning.
>>
>> Guess we'll need to check if we have paths available before triggering
>> partition scan; let me check ...
> 
> I think you must have two paths, and the 2nd path cleared the suppress
> bit before the 1st one finished its called to device_add_disk(). How
> about this one?
> 
Nope. Still stuck, this time in bdev_disc_changed().
With my testcase _all_ paths return NS_NOT_READY during partition scan, 
so I/O is constantly bounced between paths, and partition scan never 
returns. Doesn't matter where you call it, it's stuck.

The only chance we have is to modify I/O handling during scanning
(cf my new patchset).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


