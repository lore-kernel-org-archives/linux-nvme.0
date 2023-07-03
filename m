Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D6CEB64DD
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 10:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4PXiRM0a3dmypsrorncIWVWJXTdEOFXIDi7ZTxVgIG4=; b=eBvrbo7ZDhmWELOd7BuDnSHuuS
	DN3imBW/JvCsBBdiHCFDfKls6eWAvclVkU7Xjj5NkX3g94+p6aq/JiT4cxFVtuiHdGdTxdmBlvyMI
	omBqorG8ZZcAEZyGjSyxQDVhK26p+swdSmbenqVUbFCMj+q4K+ZgbZ3xm8hg+FwCWBvwYdefhRP9x
	szRKFWsPSQZtHULS5kq+/CpRk7TRV3XPOcWUXjj1QSP5W6DOayuva9CgImMyMEyxa3k61X5D+ncQu
	P9orC3TOcR5q6kPcCGxLx/TtsG324MZDe3Yam07wWDa2ofB+PpeyiHLe3VLdzEDcb6WN2yifNf2Ld
	yVcbfssQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGGge-00A9bt-2s;
	Mon, 03 Jul 2023 10:21:40 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGGgc-00A9WL-0U
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 10:21:39 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D9F6218F4;
	Mon,  3 Jul 2023 10:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688379693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4PXiRM0a3dmypsrorncIWVWJXTdEOFXIDi7ZTxVgIG4=;
	b=LojkcgkK68Qv8Yy5Fy+4+fJYiuWyRbK8H74bfbuYW0qRvzVOj8IhkVYkhU8mOD1D6GVjHn
	8Zw3Xif+hqdYtcTOxXXBv53NiOqQt/xRwNIN+B1nU6UXjGrbRqx+7REYDDNqvmL2juuv9p
	2EQq0GMV9xvFEQkjvBSpYAUlA+PXR3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688379693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4PXiRM0a3dmypsrorncIWVWJXTdEOFXIDi7ZTxVgIG4=;
	b=MoQU04qAqnrIUvOwxvZ2ArrPDOzcpOltKo4doJg8eiyoxlfUsUKgCLrWp5oL18J6Ab85WH
	ZK0mjM8IJw2RH1Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A959138FC;
	Mon,  3 Jul 2023 10:21:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id zsSpDS2homSWMAAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 03 Jul 2023 10:21:33 +0000
Message-ID: <0e230fdf-6af6-926f-305e-2f34ac6a6812@suse.de>
Date: Mon, 3 Jul 2023 12:21:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/5] net/tls: split tls_rx_reader_lock
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20230703090444.38734-1-hare@suse.de>
 <20230703090444.38734-5-hare@suse.de>
 <1ebc60c1-c094-98a0-5735-635a8af5bf63@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1ebc60c1-c094-98a0-5735-635a8af5bf63@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_032138_333784_72C06C3F 
X-CRM114-Status: GOOD (  12.99  )
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

On 7/3/23 12:06, Sagi Grimberg wrote:
> 
> 
> On 7/3/23 12:04, Hannes Reinecke wrote:
>> Split tls_rx_reader_{lock,unlock} into an 'acquire/release' and
>> the actual locking part.
>> With that we can use the tls_rx_reader_lock in situations where
>> the socket is already locked.
>>
>> Suggested-by: Sagi Grimberg <sagi@grimberg.me>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   net/tls/tls_sw.c | 38 ++++++++++++++++++++++----------------
>>   1 file changed, 22 insertions(+), 16 deletions(-)
>>
>> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
>> index 9aef45e870a5..d0636ea13009 100644
>> --- a/net/tls/tls_sw.c
>> +++ b/net/tls/tls_sw.c
>> @@ -1848,13 +1848,10 @@ tls_read_flush_backlog(struct sock *sk, struct 
>> tls_prot_info *prot,
>>       return sk_flush_backlog(sk);
>>   }
>> -static int tls_rx_reader_lock(struct sock *sk, struct 
>> tls_sw_context_rx *ctx,
>> -                  bool nonblock)
>> +static int tls_rx_reader_acquire(struct sock *sk, struct 
>> tls_sw_context_rx *ctx,
>> +                 bool nonblock)
> 
> Nit: I still think tls_rx_reader_enter/tls_rx_reader_exit are more
> appropriate names.

I don't mind either way, but I've interpreted the comments from Jakub 
that he'd like this naming better.

Jakub?

Cheers,

Hannes


