Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827F9C76196
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 14:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bLpFONyeWmg77NEhAMrnhIbrTGKUAtsQEDH7HhcrL+k=; b=jID6qbRFvApvlFOt8iH3hFHEFL
	3Uzx2XSBkCBf8TREvrSXBndOF9z7yMH0oF+EdqZarlsSbIRn4euT8yZSiktA/3P2LLrQAPOVNdPpV
	4NWTeBLDt1HE/E5wIZ+Pm0qArUcxKMDPc0+utxIsAsQVruYLuPuU3w+KB9iIzlcgHPf3LCLA7Vfn+
	NGm2dOAapUakAd0OdTcvrd7l49RB9eBqz0Usqy4YWONErEf75jBNTKX+KuqULG4FQeAIOFn2AzVey
	rXFXUwo8KfXQ0Fvo7UbbbLLXnf91HsAha22cU4YSIMR2H8444snmkNN6mJIRB7iMZSBVv7UHn2vjq
	9CuGc4GQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjKuJ-00FalT-1N;
	Mon, 03 Apr 2023 14:11:39 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjKu7-00Fake-2e
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 14:11:29 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62F1421DBF;
	Mon,  3 Apr 2023 14:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680531086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bLpFONyeWmg77NEhAMrnhIbrTGKUAtsQEDH7HhcrL+k=;
	b=MfIO+ZENyNavpDDR8TVBLA7tw7na5NBSTW0qUd6IH0LyUw2UoiChAO8Ml+WMKaQPp5YOH4
	FQ+plNSnOV2RzcSnP5ea2Boiv0bvmNtvedDIVthCXta2Wj7CrIbaWX+/Vx2K0xSNnsUPkL
	KeX5yfFJldER4atbonMUAMn0S4yCxB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680531086;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bLpFONyeWmg77NEhAMrnhIbrTGKUAtsQEDH7HhcrL+k=;
	b=CH0l+2sNivOdQ7hz0INjges84auzMUe4Nx6XpUdBYpXSZuW/wwPsPtMkIr9xQHs/hbBPQX
	9u89QgzJPg2e+0CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3531013416;
	Mon,  3 Apr 2023 14:11:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id zHykDI7eKmRTDgAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 03 Apr 2023 14:11:26 +0000
Message-ID: <32a81d27-2c16-b71b-e9da-d704acda93f6@suse.de>
Date: Mon, 3 Apr 2023 16:11:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-13-hare@suse.de>
 <677f3f9a-872d-27fe-9a21-b41bbe1c44ff@grimberg.me>
 <daf1e19e-119b-3ceb-7808-b74d8b113e05@suse.de>
 <f1bfbb7c-d8df-0386-1048-f141cb6e22bc@grimberg.me>
 <d67d9932-96eb-3548-cf40-b48a6db95739@suse.de>
 <a22946d2-e22d-a361-8768-8b34cbec1b03@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 12/18] nvme-fabrics: parse options 'keyring' and 'tls_key'
In-Reply-To: <a22946d2-e22d-a361-8768-8b34cbec1b03@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_071128_004962_B43DEBFA 
X-CRM114-Status: GOOD (  24.30  )
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

On 4/3/23 15:07, Sagi Grimberg wrote:
> 
>>>>>> Parse the fabrics options 'keyring' and 'tls_key' and store the
>>>>>> referenced keys in the options structure.
>>>>>
>>>>> Can you explain the reasoning to why a user need to pass a keyring
>>>>> given that we already set up one?
>>>>>
>>>> Choice.
>>>> With a single keyring we can only have a single identity.
>>>> But there might be configurations where we want to have different PSKs
>>>> for the same identity (eg for key rotation).
>>>
>>> How do you expect that rotation would work with this?
>>>
>> The user creates a new keyring, adds the necessary keys to it, and then
>> either
>> - updates the keyring for nvmet (via configfs)
>> or
>> - reconnects using the new keyring
> 
> And the user cannot update the nvme keyring?
> 
Sure, he can. All I'm saying is that he might choose to create a 
different one (Different tenants, setups, what do I know).

>>> How does nvmet handle a non-nvme keyring?
>>>
>> There is a configfs attribute 'param_keyring', allowing you to use a 
>> different keyring (the nvme one is just the default).
> 
> OK.
> 
>>>> With this option we can prepare a new keyring, and use that instead 
>>>> of the old one.
>>>
>>> On an existing controller?
>>>
>> Sure; when we are updating the keyring and the key id the controller 
>> will use that after the next reset.
>> Much like we do for DH-CHAP nowadays.
>>
>>>> (And it really doesn't add much complexity...)
>>>
>>> I know, it just adds one more argument, and I want to understand if it
>>> is really needed.
>>
>> I do agree that the keyring argument would not necessarily required if 
>> we pass in the key id, but I'll be needing the keyring for secure 
>> concatenation. And plan is to move DH-HMAC-CHAP over to keyrings, too.
> 
> I'm not sure I understand why authentication move to keyrings requires
> that the user is able to bring its own keyring.
> 
>> So I'd prefer to keep it.
> 
> I'm not against it, but I failing to understand in what situation a user
> _must_ send a different keyring to the driver (and not use the nvme
> keyring).

Oh, there is no 'must'. He _can_. And under certain circumstances
(in a multi-tenant environment, say) there are reasons to keep the keys 
separate into several keyrings.
Bit like the '--key' parameter; the code will try to select the 
'default' key, but if the user wants to use a different one by all 
means, do.
Same for the keyring; we do have the default keyring, but if the user 
for whatever reason doesn't want to use it we're giving him the 
possibility for that.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
(HRB 36809, AG Nürnberg)


