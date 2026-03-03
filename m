Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A79E67A8D
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 08:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fdvlZQLMecCp4iVDrx4FwePf2t0qECbN1F0Byz5D0ic=; b=lyONYnt9d3VQL4tQnFsMsy53uV
	OryWlk9OYgaWdUhdlue4CdGPdwACpnU7xSTx9yrGvCMq0aM89a5dgbzT66FgZxqC8GXKsm+3ASrxs
	uLZTPCdH9WaMuouXJLlns9HOOTImyFpj6h4wU1gYStvPHlMUqn2sX6e0KqMxPy7I4NnhSAM9LxOo6
	3k+iVwAOA6VT9tWdAhO2iR0TKmlcEXv0ycUqzLihG05yXkb37mKhyiw9hDzbtHGQASL6scrO8OuIt
	59UU3iB4w4OTO2Iom4huUZ28vNafIWuhRq3RVy0Bg0LHLpyDit0WtyFOw2PiJAOvJ+74eQJncBAzM
	apbW8P8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxKgq-0000000EkAy-3Hc2;
	Tue, 03 Mar 2026 08:01:12 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxKgl-0000000EkAI-2fgR
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 08:01:11 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 03AFE5BDE8;
	Tue,  3 Mar 2026 08:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772524865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdvlZQLMecCp4iVDrx4FwePf2t0qECbN1F0Byz5D0ic=;
	b=g+dkNDxI46LZ0Su7x7L9MY1MVi4RHKcw6Sg7AYNNlsWyPzRwQfsnAgjiw9ivDb1kbyvDcO
	ywK3rLa5Ll0vzJNrV38sbcB2SY8YWuCkr1JFFnpp4481LuUQvpMNEsy7rN6FI7qseHOyxZ
	rqqHJLa1pjvhsb4xh81TfRiMe5jlF3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772524865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdvlZQLMecCp4iVDrx4FwePf2t0qECbN1F0Byz5D0ic=;
	b=dE6xoQ9UGiXxqaECVOW/IHyRM7T6DUqUyBOLKSpDZ14uUqWGYmcjrzaa2EOtgDdDtciObV
	NbfSNviAl09g7lDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=g+dkNDxI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dE6xoQ9U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772524865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdvlZQLMecCp4iVDrx4FwePf2t0qECbN1F0Byz5D0ic=;
	b=g+dkNDxI46LZ0Su7x7L9MY1MVi4RHKcw6Sg7AYNNlsWyPzRwQfsnAgjiw9ivDb1kbyvDcO
	ywK3rLa5Ll0vzJNrV38sbcB2SY8YWuCkr1JFFnpp4481LuUQvpMNEsy7rN6FI7qseHOyxZ
	rqqHJLa1pjvhsb4xh81TfRiMe5jlF3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772524865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdvlZQLMecCp4iVDrx4FwePf2t0qECbN1F0Byz5D0ic=;
	b=dE6xoQ9UGiXxqaECVOW/IHyRM7T6DUqUyBOLKSpDZ14uUqWGYmcjrzaa2EOtgDdDtciObV
	NbfSNviAl09g7lDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75C6B3EA69;
	Tue,  3 Mar 2026 08:01:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XD0iG0CVpmkqawAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Mar 2026 08:01:04 +0000
Message-ID: <003612c1-ff07-466c-93e8-d7766a9ec2db@suse.de>
Date: Tue, 3 Mar 2026 09:01:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/24] scsi-multipath: introduce basic SCSI device support
To: Benjamin Marzinski <bmarzins@redhat.com>,
 John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
 martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
 hare@suse.com, jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, michael.christie@oracle.com, snitzer@kernel.org,
 dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260225153627.1032500-1-john.g.garry@oracle.com>
 <20260225153627.1032500-3-john.g.garry@oracle.com>
 <aaT0Taxs6WgX6m-j@redhat.com>
 <784abca8-9dc1-4fca-b72f-62d55b4cc3f1@oracle.com>
 <aaZ0Kf9n79QF4gbR@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aaZ0Kf9n79QF4gbR@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	RCPT_COUNT_TWELVE(0.00)[17];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 03AFE5BDE8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_000107_933414_218BF3A7 
X-CRM114-Status: GOOD (  15.49  )
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

On 3/3/26 06:39, Benjamin Marzinski wrote:
> On Mon, Mar 02, 2026 at 11:39:28AM +0000, John Garry wrote:
>> On 02/03/2026 02:22, Benjamin Marzinski wrote:
>>>> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
>>>> index 19d0884479a24..cfab7ad1e3c2c 100644
>>>> --- a/drivers/scsi/Kconfig
>>>> +++ b/drivers/scsi/Kconfig
>>>> @@ -76,6 +76,16 @@ config SCSI_LIB_KUNIT_TEST
>>>>    	  If unsure say N.
>>>> +config SCSI_MULTIPATH
>>>> +	bool "SCSI multipath support"
>>> At least until this supports ALUA, it should probably be marked
>>> EXPERIMENTAL, just so people trying it out aren't surprised if it
>>> doesn't multipath their device in the way they expect.
>>
>> I think that ALUA support will be mainline acceptance criteria, and I am
>> looking to add it now.
>>
>> BTW, Hannes suggested to not use the DH ALUA support, so that means to
>> separate out the core ALUA support from the DH stuff. So you have any
>> opinion on that approach?
> 
> I would (perhaps naively) have thought that the device handlers would be
> a useful abstraction for dealing with ALUA devices. But, Hannes knows
> this code much better than me. like I said before, I'm no scsi expert.
> 
The main point of the device handlers was to inject a 'start' command
whenever paths needed to be switched (Like you need to do for some
active/passive arrays).
But that really caused quite some issues with complexity, as you easily
can get into array path ping-pong on path failure with no I/O being 
transmitted.

So for this implementation I would stick with implicit ALUA
(most modern implementations have done so already anyway), and
then there's no need using the device handlers.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

