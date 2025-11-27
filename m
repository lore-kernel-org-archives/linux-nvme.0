Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FA6CFD2F6
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Nov 2025 07:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CA1J++IumGuqFEDhX4wc1h4bdmuNyr417RLnZ5gnfPI=; b=0d8q50YWT2IDNDsoBwXKaYCJ+A
	Ho1aE6/7U40WQlwlAJwQFTZxFxBvN7V0u8BjOVdsf4rXOmYqoHJ3lEc9XupLBgsEQjVdX/veDfAPq
	GVZjpp5WGRd40+xhO2uTUpf45OL81ebn9rLOgygdhT6l5w1DbFzdGs1D3im9OqjGDFTgYal9T2C7p
	Ew4h5Fzyo6V7Rw/b8cm0r+Ff7AtWhYH0p3K8IeSH/WlYfFIdGTFf+j7KP7QRMcnPMcnxoSpdphMoG
	ENfwV4uF1/ZQg0eOXlKly6W4h6kwBGBe/NzaW0+XxAfzYer6qEK+Gsu0S9EoIZAOvKznuP0gCB9cx
	Ju0/Zl6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOWpF-0000000GAEN-3Ysh;
	Thu, 27 Nov 2025 07:54:01 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOWpC-0000000GADY-2ppQ
	for linux-nvme@lists.infradead.org;
	Thu, 27 Nov 2025 07:54:00 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C971D5BCCC;
	Thu, 27 Nov 2025 07:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764230036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CA1J++IumGuqFEDhX4wc1h4bdmuNyr417RLnZ5gnfPI=;
	b=UhkORaNwI5HOi+5l209Lyrs5EnSOMVMRwME+Gbxvy3vMuj6J7duZPopaGqGKl7gJfXCjqh
	tRWYX1fSuiCWBFRexVJALXYYuDJNGIXpqrRyBh8Q7p+Iw+wS8xG9KBa0M1Bt99ba3gKb2l
	Ks7Tu1c/YASw+S44HuByk7Z/SutV0DM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764230036;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CA1J++IumGuqFEDhX4wc1h4bdmuNyr417RLnZ5gnfPI=;
	b=4txFoqP5gjnh+eC3jmAbifoSp8s+GmhVdSBPTAWQNRKJfLbStVQ9PF1xQU4f+bVpFDzIq8
	6smIQIb8m29w07Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764230036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CA1J++IumGuqFEDhX4wc1h4bdmuNyr417RLnZ5gnfPI=;
	b=UhkORaNwI5HOi+5l209Lyrs5EnSOMVMRwME+Gbxvy3vMuj6J7duZPopaGqGKl7gJfXCjqh
	tRWYX1fSuiCWBFRexVJALXYYuDJNGIXpqrRyBh8Q7p+Iw+wS8xG9KBa0M1Bt99ba3gKb2l
	Ks7Tu1c/YASw+S44HuByk7Z/SutV0DM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764230036;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CA1J++IumGuqFEDhX4wc1h4bdmuNyr417RLnZ5gnfPI=;
	b=4txFoqP5gjnh+eC3jmAbifoSp8s+GmhVdSBPTAWQNRKJfLbStVQ9PF1xQU4f+bVpFDzIq8
	6smIQIb8m29w07Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E87D3EA63;
	Thu, 27 Nov 2025 07:53:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RCoRIZQDKGn+BwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 27 Nov 2025 07:53:56 +0000
Message-ID: <4f151d8c-c9ed-474c-b11d-3f595e2e7d4a@suse.de>
Date: Thu, 27 Nov 2025 08:53:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-tcp: Implement recvmsg() receive flow
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20251020085815.20657-1-hare@kernel.org>
 <42d6103c-3cbe-49e9-a8c3-6a6c652a60e7@grimberg.me>
 <532a1000-521a-47b3-afec-e9ac0a5ba673@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <532a1000-521a-47b3-afec-e9ac0a5ba673@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_235358_929898_B76501B2 
X-CRM114-Status: GOOD (  15.85  )
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

On 11/26/25 09:58, Sagi Grimberg wrote:
> 
> 
> On 26/11/2025 9:32, Sagi Grimberg wrote:
>>
>>
>> On 20/10/2025 11:58, Hannes Reinecke wrote:
>>> The nvme-tcp code is using the ->read_sock() interface to
>>> read data from the wire. While this interface gives us access
>>> to the skbs themselves (and so might be able to reduce latency)
>>> it does not interpret the skbs.
>>> Additionally for TLS these skbs have to be re-constructed from
>>> the TLS stream data, rendering any advantage questionable.
>>> But the main drawback for TLS is that we do not get access to
>>> the TLS control messages, so if we receive any of those message
>>> the only choice we have is to tear down the connection and restart.
>>> This patch switches the receive side over to use recvmsg(), which
>>> provides us full access to the TLS control messages and is also
>>> more efficient when working with TLS as skbs do not need to be
>>> artificially constructed.
>>
>> Hannes,
>>
[ .. ]>>> @@ -940,25 +965,22 @@ static int nvme_tcp_recv_data(struct
>>> nvme_tcp_queue *queue, struct sk_buff *skb,
>>>           }
>>>             /* we can read only from what is left in this bio */
>>> -        recv_len = min_t(size_t, recv_len,
>>> -                iov_iter_count(&req->iter));
>>> +        memset(&msg, 0, sizeof(msg));
>>> +        msg.msg_iter = req->iter;
>>> +        msg.msg_flags = MSG_DONTWAIT;
> 
> Shouldn't this be initialized outside of the loop? then the loop becomes 
> while (msg_data_left(&msg)) ?
> 
I'll check.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

