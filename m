Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74423C83F25
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jul 2025 06:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1AhFSoqrZAYMa7gVD/4LWTXYqScSDyccTYLiq/aygow=; b=wAT1TPDn0Mx985fOGlJCK5mEX8
	9pV5rnc+7WyujAkDxsjVrcLswg6FPN1+cv5MDc5v3GdRyWCTmDS7at6Bj8Oau7heHik0JaAvrNiaY
	KvjEFAh11oK+5/nYrQWOgO4/Mx6m+uFgF+lizHcEo0DtkBZ8T9akpMwY/AmeoSHvsuPBqnDubeV3Y
	EC386dt05Luydj3vBVaB7UMhdKNb0WnMLe0vfizXR/xBSoutgA1RSWE264+ZWAqNK5FzR7utZllBo
	HSScqU08xcw48fH6pq5XiG0GTFo5c5ZWgdFseT1zLJQzgt+xiGDpPZiv64uJG3UhsHs2GandOHG2i
	7KUrYFYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue6TF-00000001Q6E-2CYy;
	Tue, 22 Jul 2025 06:27:25 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue6TD-00000001Q5q-1XjK
	for linux-nvme@lists.infradead.org;
	Tue, 22 Jul 2025 06:27:24 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D31A61F770;
	Tue, 22 Jul 2025 06:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753165641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1AhFSoqrZAYMa7gVD/4LWTXYqScSDyccTYLiq/aygow=;
	b=PQKXMmJxbqPSW4NiI9ouJOt/jbTsxaavymOJfrc58clcbHd5ZFseYluCodtzO4NW21blZx
	f4nXQkTNtNb0JDNSDF3GaYGFuLDhPE/RZdzCc9D5OiK3KD5FoNeVSCmcYrD55VlzaVyYXa
	6yzHzoHaS05QErMu6fovQqfuy+cYD38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753165641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1AhFSoqrZAYMa7gVD/4LWTXYqScSDyccTYLiq/aygow=;
	b=fnCurVe77Gc3qwFvERzny/a0UEcewcZTj3m71BSesVXyrwbiw7Fv2bPNxpCiyqnx9ca0w1
	BqopOBkviHm3cdBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753165641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1AhFSoqrZAYMa7gVD/4LWTXYqScSDyccTYLiq/aygow=;
	b=PQKXMmJxbqPSW4NiI9ouJOt/jbTsxaavymOJfrc58clcbHd5ZFseYluCodtzO4NW21blZx
	f4nXQkTNtNb0JDNSDF3GaYGFuLDhPE/RZdzCc9D5OiK3KD5FoNeVSCmcYrD55VlzaVyYXa
	6yzHzoHaS05QErMu6fovQqfuy+cYD38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753165641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1AhFSoqrZAYMa7gVD/4LWTXYqScSDyccTYLiq/aygow=;
	b=fnCurVe77Gc3qwFvERzny/a0UEcewcZTj3m71BSesVXyrwbiw7Fv2bPNxpCiyqnx9ca0w1
	BqopOBkviHm3cdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B223132EA;
	Tue, 22 Jul 2025 06:27:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wkQBJEkvf2gkaAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Jul 2025 06:27:21 +0000
Message-ID: <c523f9c3-06fb-4aa6-958f-e49e7c5477e4@suse.de>
Date: Tue, 22 Jul 2025 08:27:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] NVMe/TLS connection issues to SPDK
To: Chris Leech <cleech@redhat.com>
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
 Prashanth Nayak <prashanth.nayak@netapp.com>,
 John Meneghini <jmeneghi@redhat.com>
References: <20250721021718.1159879-1-cleech@redhat.com>
 <546f62d0-3f1d-4619-a668-d087da5b44fc@suse.de>
 <aH5gYzXAIGdsCBsn@cleech-thinkpadt14sgen2i.rmtusor.csb>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aH5gYzXAIGdsCBsn@cleech-thinkpadt14sgen2i.rmtusor.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_232723_558731_034C5214 
X-CRM114-Status: GOOD (  19.53  )
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

On 7/21/25 17:44, Chris Leech wrote:
> On Mon, Jul 21, 2025 at 09:11:22AM +0200, Hannes Reinecke wrote:
>> On 7/21/25 04:17, Chris Leech wrote:
>>> ...
>>> The NVMe/TCP host driver then quickly fails when SPDK sends a TLS "New
>>> Session Ticket" message before ICResp.
>>>
>>> While possibly pointless due to the transport specification prohibition
>>> on session resumption and 0-RTT data, I don't think this is necessarily
>>> wrong and the host driver should be able to safely ignore it and
>>> continue.
>>>
>> Sigh. The neverending discussion.
>> Originally I didn't implement key update for NVMe as neither gnutls nor
>> the kernel supported it.
>> Turns out that key update was implemented last year for ktls, and gnutls
>> has support functions (gnutls_session_key_update()) for this, too.
>> So we _could_ start looking into it if nvme wouldn't be using the
>> ->read_sock() interface.
>> This interface just works on skbs, and as such we can't easily get hold
>> on the TLS alert data required for figuring out if a New Session Ticket
>> message had been sent.
> 
> I think this is a bit different, as it's NewSessionTicket and not
> KeyUpdate. NewSessionTicket seems to provide an age-limited PSK for
> session resumption, allowing additional connections or re-connections to
> bypass an expensive certificate handshake. We're only using retained
> PSKs and prohibited from session resumption, so while spdk probably
> shouldn't be sending NewSessionTicket it should also safe for the host
> to just filter it out of the data stream and never use it.
> 
Ah, the NewSessionTicket thingie. Yes, that's completely pointless for
NVMe, as we _never_ re-use tickets for session re-establishment.
We only ever have one session, so the use-case of several short-lived
sessions doesn't apply here.

But with the current ->read_sock based receive workflow we
cannot filter out TLS NewSession messages from the NVMe layer
as we don't have access to the TCP stream itself.
So either we switch to a recvmsg() based workflow or we
need to modify the read_sock() implementation in net/tls
to filter out the NewSession message there.

Personally I'd rather switch over to recvmsg() as I never
liked the read_sock() interface anyway.
But that's my personal opinion; others may have different ideas.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

