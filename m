Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861DDC77B78
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 18:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Br14S2xHBShF5cY+/ZKxur6OFzjv9jM/SkDf/yPhYJU=; b=m5SpklzzQVE8EtNRbisAKogThB
	QmUcPcYdXS47sGbpCCJvrmevLrPZ5x7QqYbmt5kRpWzx/rtSxj8Mlcpp+3mBPmGPvug3+Y6ppI9si
	WbTBvmCly2V4SRwtaH1ZOM/j/IvMgyN3vucp+9DkaQHTWylkI7sxfMo9CkK53h+NaJAO1ajGqlSuR
	PIOA+0kwXOlSZK+lRg4AbLDPnNG/L4oprJiSTeFp3xmAfjpVaklBJpcdvRFS2tHa9rF89lGu1nshX
	9HMUOPq0fhtfrJ0cph5A6yp/eaaKoGwqEI/zw1HmLfKUFrxmZS6UP5Pf+E640KaHNa/frjrv/7zmV
	YL5VWkHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poq1e-0033pH-27;
	Tue, 18 Apr 2023 18:25:58 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poq1b-0033nq-2m
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 18:25:57 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E65921A93;
	Tue, 18 Apr 2023 18:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681842350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Br14S2xHBShF5cY+/ZKxur6OFzjv9jM/SkDf/yPhYJU=;
	b=qtX6sFgwHmJa3dH3yI1vm5awZn5Z07IQZaZvfsurjenqbff72C+BZqOi0S0Avv8SXXWs8V
	97HH4UzPhM9w2puvhNJyi73AubV8CRNNTbVOL1HIQWlvMIW70yCK2aaeLSuUEvfe4usGc5
	x7B5NBMkDDJ/AG4KJ8MPK81nLmZS7cI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681842350;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Br14S2xHBShF5cY+/ZKxur6OFzjv9jM/SkDf/yPhYJU=;
	b=VNks15dfkl7MD2BAtAI+w+yK7hVz0v4DnLMXiRRHSWDSwHli+MV7ijB+4iBDh2rwmwpAsK
	Gun6cnZjUcPEvfDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3FE7113581;
	Tue, 18 Apr 2023 18:25:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id O5kEDa7gPmTmXwAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 18 Apr 2023 18:25:50 +0000
Message-ID: <29496227-5d78-88b7-39eb-a217350cf346@suse.de>
Date: Tue, 18 Apr 2023 20:25:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 08/18] nvme-tcp: do not set MSG_SENDPAGE_NOTLAST
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
References: <20230417130302.86274-1-hare@suse.de>
 <20230417130302.86274-9-hare@suse.de>
 <36976756-b4c5-f2a5-34b8-e9731a49c477@grimberg.me>
 <654702da-246a-934c-14e4-7b179c46ed98@suse.de>
 <5df08f86-2599-6e47-2fdc-bda8d70edaf2@grimberg.me>
 <20230417131654.427ebd6a@kernel.org>
 <f02fb607-1339-2c68-4bd5-ced65d71b822@suse.de>
 <20230418112139.546aff79@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230418112139.546aff79@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_112556_091150_0DC73FDE 
X-CRM114-Status: GOOD (  17.15  )
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

On 4/18/23 20:21, Jakub Kicinski wrote:
> On Tue, 18 Apr 2023 12:33:03 +0200 Hannes Reinecke wrote:
>> Ah-ha. Found it.
>>
>> Turns out to be an arguably invalid control flow on our side.
>>
>> The initial 'connect' command is a command PDU with inline data.
>> So in our (current) flow we do a 'sendpage()' with the
>> MORE/SENDPAGE_NOTLAST flag set as we have to transfer more data.
>> Ok so far.
>> But for transmitting the actual data we evaluate 'sendpage_ok()', which
>> returns _false_. And then we continue to call 'sendmsg()' for the inline
>> data.
>> This confuses the TLS software stack as sendpage() and sendmsg() are two
>> distinct code paths, and we end up with a TX stall.
>>
>> Solution: check 'sendpage_ok()' when we have inline data and use
>> 'sendmsg' for the command pdu if required.
>>
>> It always pays to dig deeper if one's not exactly sure what's happening ...
>>
>> Will be updating the patchset.
> 
> Hm, yeah, sendpage(NOT_LAST)+sendmsg() could indeed be buggy/untested.
> It wasn't something we could have tested from user space, we'd need
> kunit or some such :(
> 
> Adding it the backlog. And adding Vadim to CC in case he has cycles
> to take a look.
> 
Bear in mind that that distinction will become meaningless once dhowells 
patches for MSG_SPLICE are in, as that will get rid of sendpage() 
altogether.
(At least to my understanding.)

Cheers,

Hannes


