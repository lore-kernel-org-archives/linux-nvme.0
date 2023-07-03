Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C5DEB64DC
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 13:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qTPPuOy0fLOWkWFxmPGwKo0zoZKMu8As8Gl2gXMrGWY=; b=s4H/wzyLWB2myL9rX13RaIwteR
	Fb5YU1lQr7MrtINTRRCQp1MQCrU/f77hvRPqZ4hDGJ1RPHukkKj/q09DGxutj8RR7tdrj87flELkz
	7/zMwPtZ8haZiZqR+dxTnTqSm2zQGRubMYOffAGHXHn+bMAoZXzFdHqUkqwZxlnm82ErDWixi1PAX
	zchG8XcVuhfcc2AlmyT2sWZNt0+sPkjF5/Aaea+RGf1eqw9nvSHnl20p+Z6U6QxnoMK2zzZvjJOku
	vU3gZVoGuSnib+SGI12V/tiLOBYgnwARLr5J8qcuaP42GGa7UuHlH0BY+9azmbog0FyLgM68jwvMx
	qBfaJhEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGJt5-00Afbe-1m;
	Mon, 03 Jul 2023 13:46:43 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGJt3-00AfaG-02
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 13:46:42 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0ACD021A09;
	Mon,  3 Jul 2023 13:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688391996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTPPuOy0fLOWkWFxmPGwKo0zoZKMu8As8Gl2gXMrGWY=;
	b=BrkSskJWAHK4FswRrmNtWKWGh10ymV6VZKNQyBh05BhP0cPuQnSaaxQi8nVByrqQ+bZs69
	xma6+HvFDjYQWnv0XQJ7G+lpn5wcb88UMnhUNgNpyjm88bxHrX0u3Odi9+NSTZ920iCpOg
	vSbGjPVArpGHYPHguGopDOuK6T97wdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688391996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTPPuOy0fLOWkWFxmPGwKo0zoZKMu8As8Gl2gXMrGWY=;
	b=kIEYpBKnuCmQZZNlzz8lQvMQuPe9RIARAbsC/joB/lxb7vgS61ULuJjerhz6Iu5VA+i4Oq
	J1vDO32/1Bl2CSBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7D7513276;
	Mon,  3 Jul 2023 13:46:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id D7EeODvRomRXJgAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 03 Jul 2023 13:46:35 +0000
Message-ID: <656f77b1-caf6-ea3c-6d32-54637f70a629@suse.de>
Date: Mon, 3 Jul 2023 15:46:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv6 0/5] net/tls: fixes for NVMe-over-TLS
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, David Howells <dhowells@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <03dd8a0d-84b9-c925-9547-99f708e88997@suse.de>
 <20230703090444.38734-1-hare@suse.de>
 <8fbfa483-caed-870f-68ed-40855feb601f@grimberg.me>
 <e1165086-fd99-ff43-4bca-d39dd1e46cf1@suse.de>
 <bf72459d-c2e0-27d2-ad96-89a010f64408@suse.de>
 <873545.1688387166@warthog.procyon.org.uk>
 <12a716d5-d493-bea9-8c16-961291451e3d@grimberg.me>
 <b33737ab-d923-173c-efcc-9e5c920e6dbf@suse.de>
 <173e27fe-18bb-6194-2af3-1743bc0f8f61@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <173e27fe-18bb-6194-2af3-1743bc0f8f61@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_064641_196692_772386EE 
X-CRM114-Status: GOOD (  18.92  )
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

On 7/3/23 15:42, Sagi Grimberg wrote:
> 
>>>> Hannes Reinecke <hare@suse.de> wrote:
>>>>
>>>>>> 'discover' and 'connect' works, but when I'm trying to transfer data
>>>>>> (eg by doing a 'mkfs.xfs') the whole thing crashes horribly in
>>>>>> sock_sendmsg() as it's trying to access invalid pages :-(
>>>>
>>>> Can you be more specific about the crash?
>>>
>>> Hannes,
>>>
>>> See:
>>> [PATCH net] nvme-tcp: Fix comma-related oops
>>
>> Ah, right. That solves _that_ issue.
>>
>> But now I'm deadlocking on the tls_rx_reader_lock() (patched as to 
>> your suggestion). Investigating.
> 
> Are you sure it is a deadlock? or maybe you returned EAGAIN and nvme-tcp
> does not interpret this as a transient status and simply returns from
> io_work?
> 
>> But it brought up yet another can of worms: what _exactly_ is the 
>> return value of ->read_sock()?
>>
>> There are currently two conflicting use-cases:
>> -> Ignore the return value, and assume errors etc are signalled
>>     via 'desc.error'.
>>     net/strparser/strparser.c
>>     drivers/infiniband/sw/siw
>>     drivers/scsi/iscsi_tcp.c
>> -> use the return value of ->read_sock(), ignoring 'desc.error':
>>     drivers/nvme/host/tcp.c
>>     net/ipv4/tcp.c
>> So which one is it?
>> Needless to say, implementations following the second style do not
>> set 'desc.error', causing any errors there to be ignored for callers
>> from the first style...
> 
> I don't think ignoring the return value of read_sock makes sense because
> it can fail outside of the recv_actor failures.
> 
Oh, but it's not read_actor which is expected to set desc.error.
Have a look at 'strp_read_sock()':

         /* sk should be locked here, so okay to do read_sock */
         sock->ops->read_sock(strp->sk, &desc, strp_recv);

         desc.error = strp->cb.read_sock_done(strp, desc.error);

it's the ->read_sock() callback which is expected to set desc.error.

> But to be on the safe side, perhaps you can both return an error and set
> desc.error?
> 
But why? We can easily make ->read_sock() a void function, then it's 
obvious that you can't check the return value.

Cheers,

Hannes


