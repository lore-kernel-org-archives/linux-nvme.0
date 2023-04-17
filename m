Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7C3C77B76
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 14:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U8OluHKc8Dw/IrgZsjhURxbDCGWxp9NjexBQwaudwp4=; b=OOvgMdJtwn++hnvJknQrhkYdNg
	LqLP6mEUNt08TpHiQyLNfT/yM2pVthdsuIMyOy0PNCws+fQKREnb39taB/C/RRuLZ6jNnluEMLWk8
	+oJ0ZXB1hxbphwdSPpWURYYqmQ7C4aa+j85KRrfIrhpxwUX2NQ/VsJFGkPxt/tH9FYCLXS3qbOBJo
	lMkQIcB7C/BUPjCUFMcLeUq7g4rmRVuxRTxhioj/QdLVEDZKe9VL39l1Ft9XCzCqJAnamDlNa70Al
	LUgk6QYGcZwFRUZLWfxy1w/LFgryvg/O4FTDZAJGN9/HhEFVrabIj3fZXUwRHVGobsyXzQZ3Cq+ti
	V+0tlyKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poPQi-00GVnw-2W;
	Mon, 17 Apr 2023 14:02:04 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poPQg-00GVlt-0B
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 14:02:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 31C4321A3F;
	Mon, 17 Apr 2023 14:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681740118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U8OluHKc8Dw/IrgZsjhURxbDCGWxp9NjexBQwaudwp4=;
	b=ogtrEw2bcy5gaw1ADC602eRpbWV7k2SwtzXm74vappvfmpRntO962+SXjbLKJ1gZTv+u9U
	G6xDULFBBTOGZR2Oc5vriTxCtG1bcxxBFn/iRfSU+gZlyMdXLNa5UrKkcyA1gdwu38i2MM
	oTKnYp2LWY/OHqFOI9ahJ7kFVtVVzrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681740118;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U8OluHKc8Dw/IrgZsjhURxbDCGWxp9NjexBQwaudwp4=;
	b=u1Bx+R1519ISkAqLQUhAViShiw7Pfy22mq8NT3PclEjs4luT24sle/tb/yn3dEUhLb/hm8
	8AVJT8zR6MThzFBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C28113319;
	Mon, 17 Apr 2023 14:01:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id N2N9BlZRPWTbAwAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 17 Apr 2023 14:01:58 +0000
Message-ID: <1b9a7d09-1af6-564a-18db-2a73f27435cd@suse.de>
Date: Mon, 17 Apr 2023 16:01:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 18/18] nvmet-tcp: add configfs attribute 'param_keyring'
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-19-hare@suse.de>
 <60ff89b4-5d63-a6db-18b1-e0f28055c5d9@grimberg.me>
 <c7e895f1-1c95-f658-f7a1-c4cee5cf8c91@suse.de>
 <1b018791-9aa3-b988-7045-40b46bc50989@grimberg.me>
 <02e4f6eb-32c2-8f3c-872f-831e70da6166@suse.de>
 <ffb33351-e26b-470e-9849-e195d9b05b52@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ffb33351-e26b-470e-9849-e195d9b05b52@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_070202_242732_311B2031 
X-CRM114-Status: GOOD (  15.95  )
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

On 4/17/23 15:50, Sagi Grimberg wrote:
> 
>>>>>> Add a configfs attribute to list and change the default keyring.
>>>>>
>>>>> is the keyring an attribute of a port? or a subsystem? Why the choice
>>>>> of making it per port?
>>>>>
>>>> As per discussion at fmds each port might want to use different 
>>>> credentials.
>>>> We can move it to subsystems if we decide we don't want to support 
>>>> that use-case.
>>>
>>> I think we should move it to the subsystem in Linux.
>>>
>> Easier said than done.
>>
>> We can only fetch the subsystem once we have the NQN, which we will
>> know after the connect command.
>> But out of necessity the connect command will only be transferred
>> after TLS handshake completed, so there is not subsystem NQN allowing
>> us to figure out the correct subsystem.
>>
>> So we'll have to keep it at the port level, I'm afraid.
> 
> Question, why does nvmet needs to support user defined keyrings?
> I understood your argument for the host, but why should the target
> support it?

Hmm. Originally I implemented it to be similar to the host 
configuration, but from the implementation we don't _actually_ need it 
as we select the key from the entire key store.
Having it is just a nice way of avoiding having to have a daemon 
configuration.
So if you insist we can drop it for the initial implementation.

Cheers,

Hannes



