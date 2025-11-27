Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1120D11183
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Nov 2025 11:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h29iefDfELdSEm0KDeLqC9ogavztg/bPBiOU3Urpgw8=; b=k2g/Ykr25rQgR4EswzsfSLUX7u
	apivowTGY5SW16HEs/R+mJ6O5k8XznRDKEMTCv7gZY0DY/ds2s0swcCCDDynfgap70uA3kwZXi/OX
	3TVC4riKOvbBBfH90MkBY7H9IiFC8sKMXpBASlkElAopkzAYFvnvMg/afVU2WZCJ8lwVwhHXRByLN
	hBnYQBxRdLWNZL9w/iSR7pzw5W1ZxyijXLH1cqFCx/eQXSAxcMmzQ73328PK6lgu3/2JLTNJlBf32
	WnuR2CNoz9Va6SSjcy2I76ZWTE4ZMpKvjgVZw+Iq3WdqQvbzXLU+Q3ZJL6K+tMy2a5hMDyDwz7u/w
	7rcST24Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOaJE-0000000GSuK-0d83;
	Thu, 27 Nov 2025 11:37:12 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOaJB-0000000GStv-1b0T
	for linux-nvme@lists.infradead.org;
	Thu, 27 Nov 2025 11:37:10 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 37D8E3369A;
	Thu, 27 Nov 2025 11:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764243427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h29iefDfELdSEm0KDeLqC9ogavztg/bPBiOU3Urpgw8=;
	b=DFECTEjtZmzND+c+PyEYyT/AT1WGbtBzosLfWH/eAob4XnAlDgBgcY33a6OkUEndus7kfv
	u42zS7tFCJoV5+Ibpm/o8HtyGMsTud+glDO4a4UsMcoQiJKcf5NcaqBrfzefFMLG/VzaS1
	fQ+cugJLjakEYKabt5vQbdOqU7FyU1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764243427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h29iefDfELdSEm0KDeLqC9ogavztg/bPBiOU3Urpgw8=;
	b=372+jVtycSiygExcsQ5yg4zDPYBCicS1aC9k3VTtmAoszOXK/6YLux1qwIj0lwy6OJWK6g
	l8xl5e/MKhj+/KBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=emGgu31l;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mOTmbpCd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764243426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h29iefDfELdSEm0KDeLqC9ogavztg/bPBiOU3Urpgw8=;
	b=emGgu31l4pT3oqX0KTvVt4O3mMkakZXzQsgBUFxP/QPRkosknDIQdpvVR9mdteYxI2sSue
	2KwXzyBTRm8Ptv8nsFRyU6lBjmieZNIKdv/fPs9M3EQnuR1A6Voqpm7dpkH+hK4PE6ZJCv
	ZgTalcAeLNmWT+Uhzbau7GeNYvLLGhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764243426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h29iefDfELdSEm0KDeLqC9ogavztg/bPBiOU3Urpgw8=;
	b=mOTmbpCdgNnSRotMP3OIlh8mI6h8tOj+GywY+qHTeJ4061rT3WCsy6uj/W/+6nStH/0ovl
	kcBPxUTeHIULiKDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 261F63EA63;
	Thu, 27 Nov 2025 11:37:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GlHQCOI3KGnRYQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 27 Nov 2025 11:37:06 +0000
Message-ID: <fdf54fe7-c69a-4254-9a15-2e347f3e15d5@suse.de>
Date: Thu, 27 Nov 2025 12:37:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-tcp: Implement recvmsg() receive flow
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20251020085815.20657-1-hare@kernel.org>
 <42d6103c-3cbe-49e9-a8c3-6a6c652a60e7@grimberg.me>
 <532a1000-521a-47b3-afec-e9ac0a5ba673@grimberg.me>
 <4f151d8c-c9ed-474c-b11d-3f595e2e7d4a@suse.de>
Content-Language: en-US
In-Reply-To: <4f151d8c-c9ed-474c-b11d-3f595e2e7d4a@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 37D8E3369A
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_033709_566566_3FBCDEA8 
X-CRM114-Status: GOOD (  16.89  )
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

On 11/27/25 08:53, Hannes Reinecke wrote:
> On 11/26/25 09:58, Sagi Grimberg wrote:
>>
>>
>> On 26/11/2025 9:32, Sagi Grimberg wrote:
>>>
>>>
>>> On 20/10/2025 11:58, Hannes Reinecke wrote:
>>>> The nvme-tcp code is using the ->read_sock() interface to
>>>> read data from the wire. While this interface gives us access
>>>> to the skbs themselves (and so might be able to reduce latency)
>>>> it does not interpret the skbs.
>>>> Additionally for TLS these skbs have to be re-constructed from
>>>> the TLS stream data, rendering any advantage questionable.
>>>> But the main drawback for TLS is that we do not get access to
>>>> the TLS control messages, so if we receive any of those message
>>>> the only choice we have is to tear down the connection and restart.
>>>> This patch switches the receive side over to use recvmsg(), which
>>>> provides us full access to the TLS control messages and is also
>>>> more efficient when working with TLS as skbs do not need to be
>>>> artificially constructed.
>>>
>>> Hannes,
>>>
> [ .. ]>>> @@ -940,25 +965,22 @@ static int nvme_tcp_recv_data(struct
>>>> nvme_tcp_queue *queue, struct sk_buff *skb,
>>>>           }
>>>>             /* we can read only from what is left in this bio */
>>>> -        recv_len = min_t(size_t, recv_len,
>>>> -                iov_iter_count(&req->iter));
>>>> +        memset(&msg, 0, sizeof(msg));
>>>> +        msg.msg_iter = req->iter;
>>>> +        msg.msg_flags = MSG_DONTWAIT;
>>
>> Shouldn't this be initialized outside of the loop? then the loop 
>> becomes while (msg_data_left(&msg)) ?
>>
> I'll check.
> 
Ah, no, we can't.
The conditional above might move to the next bio, and reset 'req->iter'
to point to the next bio iterator.
So we need re-initialize the message here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

