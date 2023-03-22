Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FB4C6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 16:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0hML6p9VjAVsulxdze1pFl1v7RuVX1tS1vNbrPZcF6E=; b=QuUOVCjrZ1KJPbdmLPBr0yogMb
	e4qnzpk+skPxKDEsz/6UVJMQrLZ3nzHGN0YRi6wGiItytJZNP1BcsyD1AUlU8EpoheOTjxFHFbiYo
	Oi8rvusUSF4JgAgHaQRiWtMY0Bj+U8SpjCiNVCqVgDlaMXkzhAwm0qgqmu8XPCv98my4MRI8xFDS9
	vJOh4ObfAeGVYEIk4w1+qTare1t478D99viiT9aKz/lO/syzrowThNt8tVWFmg+tkLzwip8InnXWB
	Nt/KcuXb4WgVFjQM3p8vzoR531jREbsn7prgKSpCuHh75K+TXAyyOlM4e7o12Mbmee9dGWF0ses0I
	5KJLOx0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pf1Yh-00Gi4Q-2I;
	Wed, 22 Mar 2023 16:43:31 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pf1Ye-00Gi3c-1k
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 16:43:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC59633D1A;
	Wed, 22 Mar 2023 16:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679503406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hML6p9VjAVsulxdze1pFl1v7RuVX1tS1vNbrPZcF6E=;
	b=rGREUI4E4qgdY9G3QFNUUAdX0sZprr7Pv1H+HR9BGkJKAgjJ3iXHy7ZKpD1IxBl5xGbFBh
	tkWO7JP7NyXze3SJH2DSuZZQU+9XK56RbH6RevYO4uBPeiZjjmDD4PcmOPxVTmsJn9E5vr
	4/eCRCLVdFbRu0GkrZPaCw1+yd78PSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679503406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hML6p9VjAVsulxdze1pFl1v7RuVX1tS1vNbrPZcF6E=;
	b=TMbcwjeK5xgKYX/yJxjicv7Q5dYiOy9DYiYDfk1N3bjs9yd+MgWla1f2cjAtqTbYNj/uCv
	UMD9E8h4Xx+eOXDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53DCB13416;
	Wed, 22 Mar 2023 16:43:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id rFI5ES4wG2RaeAAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 22 Mar 2023 16:43:26 +0000
Message-ID: <e016af81-f77e-2eba-a805-838f62ba50f7@suse.de>
Date: Wed, 22 Mar 2023 17:43:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 15/18] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-16-hare@suse.de>
 <6f69983c-17bd-dd72-b941-95f55db10180@grimberg.me>
 <b8a2e1d4-3571-447b-25c6-c6dd25fbad02@suse.de>
 <a1af3f6b-ec9e-4e91-ad70-57fcc9010a91@grimberg.me>
 <c426d104-b7f2-e736-c23a-b94fda54ed37@suse.de>
 <e0620d94-9729-014c-2cb8-8ff826ebbefa@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <e0620d94-9729-014c-2cb8-8ff826ebbefa@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_094328_732293_21726DA4 
X-CRM114-Status: GOOD (  42.28  )
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

On 3/22/23 16:42, Sagi Grimberg wrote:
> 
>>>> The 'data_ready' call might happen at any time after the 'accept' 
>>>> call and us calling into userspace.
>>>> In particular we have this flow of control:
>>>>
>>>> 1. Kernel: accept()
>>>> 2. Kernel: handshake request
>>>> 3. Userspace: read data from socket
>>>> 4. Userspace: tls handshake
>>>> 5. Kernel: handshake complete
>>>>
>>>> If the 'data_ready' event occurs between 1. and 3. userspace 
>>>> wouldn't know that something has happened, and will be sitting there 
>>>> waiting for data which is already present.
>>>
>>> Umm, doesn't userspace read from the socket once we trigger the upcall?
>>> it should. But I still don't understand what is the difference between
>>> us waiking up userspace, from the default sock doing the same?
>>>
>> No, it doesn't (or, rather, can't).
>> After processing 'accept()' (from the kernel code) data might already 
>> be present (after all, why would we get an 'accept' call otherwise?).
>> But the daemon has not been started up (yet); that's only done in
>> step 3). But 'data_ready' has already been called, so by the time 
>> userland is able to do a 'read()' on the socket it won't be seeing 
>> anything.
> 
> Not sure I understand. if data exists, userspace will read from the
> socket and get data, whenever that is. >
That's what I thought, too.
But then the userspace daemon just sat there doing nothing.

>> To be precise: that's the reasoning I've come up with.
>> Might be completely wrong, or beside the point.
>> But what I _do_ know is that without this call userspace would
>> _not_ see any data, and would happily sit there until we close the 
>> socket due to a timeout (which also why I put in the timeout
>> module options ...), and only _then_ see the data.
>> But with this call everything works. So there.
> 
> I may be missing something, and maybe its because I haven't looked at
> the userspace side yet. But if it calls recvmsg, it should either
> consume data, or it should block until it arrives.
> 
> I'm finding it difficult to understand why emulating almost 100% the
> default socket .data_ready is what is needed. But I'll try to understand
> better.
> 
Oh, I don't claim to have a full understanding, either.
I had initially assumed that it would work 'out of the box', without us 
having to specify a callback.
Turns out that it doesn't.
Maybe it's enough to call sk->sk_data_ready() after the upcall has been 
started. But we sure have to do _something_.

If you have other solutions I'm all ears...

> 
> 
>>>> As outlined in the response to the nvme-tcp upcall, on the server 
>>>> side we _have_ to allow for non-TLS connections (eg. for discovery).
>>>
>>> But in essence what you are doing is that you allow normal connections
>>> for a secured port...
>>>
>> Correct.
> 
> That is not what the feature is supposed to do.
> 
Well ... it's a difference in interpretation.
The NVMe TCP spec just says '... describes whether TLS is supported.'.
It does not say 'required'.
But there currently is no way how the server could describe 'TLS 
supported' vs 'TLS required'.

>>> btw, why not enforce a psk for the discovery controller (on this port)
>>> as well? for secured ports? No one said that we must accept a
>>> non-secured discovery connecting host on a secured port.
>>>
>> Because we can't have a PSK for standard discovery.
>> Every discovery controller has the canonical discovery NQN, so every
>> PSK will have the same subsystem NQN, and you will have to provide the 
>> _same_ PSK to every attached storage system.
> 
> Right, because they have the same NQN. Sounds good, what is the problem?
> It is much better than to have sectype be nothing more than a
> recommendation.
> 
> If sectype tls1.x is defined on a port then every connection to that
> port is a tls connection.
> 
See above. Only if we decide to give TSAS a 'TLS required' meaning.
With the this patchset it's a 'TLS supported' syntax.

>> If we had unique discovery controller NQNs everything would be good,
>> but as we don't I guess we have to support normal connections in 
>> addition to secured ones.
> 
> Its orthogonal. the well-known disc-nqn may be "weaker", but tls
> is still enforced. when we add unique disc-nqn, we can use different
> psks.
> 
Not only weaker, but _identical_ for each server.

>> As I said; maybe it's time to revisit the unique discovery NQN patches;
>> with those we should be able to separate the various use-case like
>> having a dedicated secured discovery port.
> 
> I don't see why this would be needed.
> 
We don't if we treat TSAS as 'TLS required', true.
But that's not what the spec says.
And there is also the dodgy statement in section 3.6.1.6:
 > If a host that supports TLS for NVMe/TCP receives a discovery
 > log entry indicating that the NVM subsystem uses NVMe/TCP and
 > does not support TLS, then the host should nonetheless
 > attempt to establish an NVMe/TCP connection that uses TLS.
 >
which really indicates that the TSAS field is a recommendation only.

But really, we shouldn't read too much into what the TSAS field says.
With the upcoming TPAR for TLS clarification all these different 
interpretations should be clarified.

The key question, however, will remain: Do we _want_ to support a 'TLS 
supported' mode for nvmet?
I'd say we should, to have compability with older (client) installations.
And I guess we have to anyway for secure concatenation
(as this _requires_ that we start off unencrypted).
So I'd suggest to leave it for now, have the code to support both, and 
wait for the TPAR to be ratified and then revisit this issue.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


