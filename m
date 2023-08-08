Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACD7C001B0
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 06:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8xTicBPumA+YyHiFJn7HsA2lNlGdn/riWcQuNQhHRqw=; b=lUesKhGGXSgjfb/7tYzg/H17Lb
	hCFmcjHRB9q0MrZBs/V6SeIE1UT1SUG2tEbyKGNeQnEnI++XIXpOFW7iMp9a8UCIO8QLvIlm0lLMz
	we+u/2tE5Ym4R6pnhvOYFgfOP8LJFPaD86xleNHDanOI3SApnMeZcE6GaYd2kEgSJwSUYO0I1rcYk
	adSDqoljAEI83KuX0SsK/8d4BT0TCrLaBrAE7YbieRbtkP7jjDmY3XN/3czmwxcVZjwmS9vmjyPAw
	2wUeUevyuRGmDONPuEMJxMFPS/GMblyvosq0DE/0wr2VYsEkXcy29aBbwoTayFy3yoqZC2T1tR4Tb
	DBgNLBxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTGNK-001pp3-0Z;
	Tue, 08 Aug 2023 06:39:26 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTGNH-001poi-1T
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 06:39:24 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F065721AED;
	Tue,  8 Aug 2023 06:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691476760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8xTicBPumA+YyHiFJn7HsA2lNlGdn/riWcQuNQhHRqw=;
	b=PzN74IoxwdW3gv/UJb4xMe0xk2t3aT4ytivE6QNsm1Tj4sO8HJU3lxIf8J9hU1lfzXbOP1
	hR7UCKc0BAK32Q+Mw2B0m/LItxgbdLvHjr3TF5cbPcQa1EMIb/UjANwYKrlUNdOh5qkBjO
	uho26bBe4V9KISC9+4i2IXFVXHnlJl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691476760;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8xTicBPumA+YyHiFJn7HsA2lNlGdn/riWcQuNQhHRqw=;
	b=FxZtqzXMSR/p6kvwS1Yp60ihJm881jLbaRHxBYl/GJDVSLOy3DdZhUyo5o9zvUugxLkjjg
	0jYO60GoaAb3vYDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D108E139D1;
	Tue,  8 Aug 2023 06:39:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id P1oOMhjj0WRGSQAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 08 Aug 2023 06:39:20 +0000
Message-ID: <5127f18a-7a15-71d0-4ae3-b7caa62e5d80@suse.de>
Date: Tue, 8 Aug 2023 08:39:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 09/14] nvme-tcp: control message handling for recvmsg()
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-10-hare@suse.de>
 <5c12f391-c5cb-2d1a-40b3-b93f45292c6c@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <5c12f391-c5cb-2d1a-40b3-b93f45292c6c@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_233923_664477_A07541E7 
X-CRM114-Status: GOOD (  19.06  )
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

On 8/7/23 10:22, Sagi Grimberg wrote:
> 
> 
> On 8/3/23 13:50, Hannes Reinecke wrote:
>> kTLS is sending TLS ALERT messages as control messages for recvmsg().
>> As we can't do anything sensible with it just abort the connection
>> and let the userspace agent to a re-negotiation.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   drivers/nvme/host/tcp.c | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 98400ad5f969..4d0e3de39c26 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -14,6 +14,7 @@
>>   #include <net/sock.h>
>>   #include <net/tcp.h>
>>   #include <net/tls.h>
>> +#include <net/tls_prot.h>
>>   #include <net/handshake.h>
>>   #include <linux/blk-mq.h>
>>   #include <crypto/hash.h>
>> @@ -1369,6 +1370,10 @@ static int nvme_tcp_init_connection(struct 
>> nvme_tcp_queue *queue)
>>   {
>>       struct nvme_tcp_icreq_pdu *icreq;
>>       struct nvme_tcp_icresp_pdu *icresp;
>> +#ifdef CONFIG_NVME_TCP_TLS
>> +    char cbuf[CMSG_LEN(sizeof(char))] = {};
>> +    u8 ctype;
>> +#endif
>>       struct msghdr msg = {};
>>       struct kvec iov;
>>       bool ctrl_hdgst, ctrl_ddgst;
>> @@ -1406,11 +1411,22 @@ static int nvme_tcp_init_connection(struct 
>> nvme_tcp_queue *queue)
>>       memset(&msg, 0, sizeof(msg));
>>       iov.iov_base = icresp;
>>       iov.iov_len = sizeof(*icresp);
>> +#ifdef CONFIG_NVME_TCP_TLS
>> +    msg.msg_control = cbuf;
>> +    msg.msg_controllen = sizeof(cbuf);
>> +#endif
>>       ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
>>               iov.iov_len, msg.msg_flags);
>>       if (ret < 0)
>>           goto free_icresp;
> 
> Is the cmsg passed unconditionally? meaning this does not
> impact non-tls?
> 
> If so, why is the ifdef needed?
> 
Passing in a cmsg (and a controllen) always enables the use of
control messages, irrespective of the type.
As we never enabled control messages prior to this we would
change the implementation when TLS is not enabled; who knows,
someone might have been sending us control messages all along,
but we never checked. So I thought it prudent to only enable
it for TLS where we know that we might be getting control messages.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


