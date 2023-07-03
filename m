Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82134EB64DD
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 13:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=739dHYzg5oExmvbSo2BuS/tkAu90YM6Fl3+TFCGLX6A=; b=dtZfwK9l7c6rabJ49lT0QwTX4c
	8TtPjULX3aTvJ4UouDVaAIa/HtcVWtT8PU46on8EVz4InD+uc3/v+t7oNC5lPw2hobNpvLqqZYZyJ
	KKpgQKCkvQA8ALUizMfom4H4CQUzeD5vkCJ5gptYknlW3TMkf8QHNbXGEnmPlLAujenVAagdUjO2a
	TiWZVj6wFURqdFY4rvXWi0k5olw3/EqPEEQ+JeG6w2J87N9lz/+/c6kL7mC1QWxskkW+AAi1KSOOx
	PJ6DBV0TZ0CsPpXwUtaduGxOWhyDC+TS+aMv7NJiQmUl9SJN2GNRTF0+PYuL6emvlZinjcYILcPXl
	pSzTRzMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGJP5-00AbZu-2L;
	Mon, 03 Jul 2023 13:15:43 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGJP2-00AbYv-31
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 13:15:42 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B28C31FE51;
	Mon,  3 Jul 2023 13:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688390137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=739dHYzg5oExmvbSo2BuS/tkAu90YM6Fl3+TFCGLX6A=;
	b=cuQeM096io5t/AxOPgR6RHQZYZHAm2485B+SxdX9HvZoSGkQhZ7FTKsAA5YyMtvYfiTK8N
	ouIDnihpA2IMiz9ox7KmrrlPftO4soWPJl70WETmN5W7YsYmiMgp1SnQZyvjMGGH0Kw0uo
	xS5t1jeXLeibvMgvvmU3yoPbIypj34U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688390137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=739dHYzg5oExmvbSo2BuS/tkAu90YM6Fl3+TFCGLX6A=;
	b=XiSeRMlV4U2sb/8AK7UKj9ehbVZZxebCEFqW2LaWhnCCy9tyCWkb74SrGKyH3YtvRIiU1B
	vpj3uNAHXz+UUXCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98DF1138FC;
	Mon,  3 Jul 2023 13:15:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id b8vzJPnJomS4EgAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 03 Jul 2023 13:15:37 +0000
Message-ID: <b33737ab-d923-173c-efcc-9e5c920e6dbf@suse.de>
Date: Mon, 3 Jul 2023 15:15:37 +0200
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
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <12a716d5-d493-bea9-8c16-961291451e3d@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_061541_141498_3EDF52BE 
X-CRM114-Status: GOOD (  12.86  )
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

On 7/3/23 14:33, Sagi Grimberg wrote:
> 
>> Hannes Reinecke <hare@suse.de> wrote:
>>
>>>> 'discover' and 'connect' works, but when I'm trying to transfer data
>>>> (eg by doing a 'mkfs.xfs') the whole thing crashes horribly in
>>>> sock_sendmsg() as it's trying to access invalid pages :-(
>>
>> Can you be more specific about the crash?
> 
> Hannes,
> 
> See:
> [PATCH net] nvme-tcp: Fix comma-related oops

Ah, right. That solves _that_ issue.

But now I'm deadlocking on the tls_rx_reader_lock() (patched as to your 
suggestion). Investigating.

But it brought up yet another can of worms: what _exactly_ is the return 
value of ->read_sock()?

There are currently two conflicting use-cases:
-> Ignore the return value, and assume errors etc are signalled
    via 'desc.error'.
    net/strparser/strparser.c
    drivers/infiniband/sw/siw
    drivers/scsi/iscsi_tcp.c
-> use the return value of ->read_sock(), ignoring 'desc.error':
    drivers/nvme/host/tcp.c
    net/ipv4/tcp.c
So which one is it?
Needless to say, implementations following the second style do not
set 'desc.error', causing any errors there to be ignored for callers
from the first style...
Jakub?

Cheers,

Hannes


