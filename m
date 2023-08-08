Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9570FC001B0
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 08:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V3d2+v7y/PyULri2AdK40qQb0NeoftMXMjNiLimMCAM=; b=wH+5tBT09nwucJ2K7pq79EVSl3
	XGqCDE8N8acEJ0+q10uh8uGkkvyYXqI+anifUgJ8y5dEwKG7MfduGJO3d29BfNGDj3ItQzvqKNMAc
	e5/cnMt7kY30yIcmRMGfTqfIFVTBAJ5tO0fdcSIXldJpyE1MXe+ZRsM14mvYKHtPV7o/wbzl8l8G/
	LqxQiWs6MLuMwKKWzQu/Od5KHBNprXPMo+kR+pRRqC55xPxLVVx+l/A+R1FFsmHdM+jjNy8KCEZnI
	ZE0qYsjQ2A2UiZDwxDpyUOUvOXFRKa3d8bzFRorsReotPgR2LWyMRjxHQySuZwZB7VVdJenHJ6tZc
	dlatRnvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTIRX-0025K1-0A;
	Tue, 08 Aug 2023 08:51:55 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTIRU-0025JN-0i
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 08:51:53 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 204A22244B;
	Tue,  8 Aug 2023 08:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691484707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V3d2+v7y/PyULri2AdK40qQb0NeoftMXMjNiLimMCAM=;
	b=nmW6Y8BaM5yKKueK6PtEOKDSva/oCRVrkD9BLkzw4dUi8u7UWviSuzuPgwjw47YoDrC0hC
	b9Mobw13l8rbCS8HijEUoLOYwr1HPsH/j9+0CXAjD0KnsqbnzYlUrga7F4/mz9OhD/0s3e
	M94m7Un4b9B4AxbabLm8kAb7H5Pxb7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691484707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V3d2+v7y/PyULri2AdK40qQb0NeoftMXMjNiLimMCAM=;
	b=uFP22AzVGRHKwEd7i/2YF/Flx2XKDFDmEUBNRkgxb+dPo74E5ZRgAz3V5Hnyn14FM9MgUG
	MgHujX4DYKLFdKDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D586139D1;
	Tue,  8 Aug 2023 08:51:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id KqP0GCIC0mTSBwAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 08 Aug 2023 08:51:46 +0000
Message-ID: <e297b28a-dd74-7fe2-ad63-6f3b103b50b7@suse.de>
Date: Tue, 8 Aug 2023 10:51:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] nvme-tcp: control message handling for recvmsg()
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-10-hare@suse.de>
 <5c12f391-c5cb-2d1a-40b3-b93f45292c6c@grimberg.me>
 <5127f18a-7a15-71d0-4ae3-b7caa62e5d80@suse.de>
 <41f9e217-374e-2cfa-b912-147686fe7ee6@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Autocrypt: addr=hare@suse.de; keydata=
 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
 YwtooKEemPj2lg==
In-Reply-To: <41f9e217-374e-2cfa-b912-147686fe7ee6@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_015152_422518_148FEE7F 
X-CRM114-Status: GOOD (  17.36  )
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

On 8/8/23 10:41, Sagi Grimberg wrote:
> 
> 
> On 8/8/23 09:39, Hannes Reinecke wrote:
>> On 8/7/23 10:22, Sagi Grimberg wrote:
>>>
>>>
>>> On 8/3/23 13:50, Hannes Reinecke wrote:
>>>> kTLS is sending TLS ALERT messages as control messages for recvmsg().
>>>> As we can't do anything sensible with it just abort the connection
>>>> and let the userspace agent to a re-negotiation.
>>>>
>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>>>> ---
>>>>   drivers/nvme/host/tcp.c | 18 +++++++++++++++++-
>>>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>>> index 98400ad5f969..4d0e3de39c26 100644
>>>> --- a/drivers/nvme/host/tcp.c
>>>> +++ b/drivers/nvme/host/tcp.c
>>>> @@ -14,6 +14,7 @@
>>>>   #include <net/sock.h>
>>>>   #include <net/tcp.h>
>>>>   #include <net/tls.h>
>>>> +#include <net/tls_prot.h>
>>>>   #include <net/handshake.h>
>>>>   #include <linux/blk-mq.h>
>>>>   #include <crypto/hash.h>
>>>> @@ -1369,6 +1370,10 @@ static int nvme_tcp_init_connection(struct 
>>>> nvme_tcp_queue *queue)
>>>>   {
>>>>       struct nvme_tcp_icreq_pdu *icreq;
>>>>       struct nvme_tcp_icresp_pdu *icresp;
>>>> +#ifdef CONFIG_NVME_TCP_TLS
>>>> +    char cbuf[CMSG_LEN(sizeof(char))] = {};
>>>> +    u8 ctype;
>>>> +#endif
>>>>       struct msghdr msg = {};
>>>>       struct kvec iov;
>>>>       bool ctrl_hdgst, ctrl_ddgst;
>>>> @@ -1406,11 +1411,22 @@ static int nvme_tcp_init_connection(struct 
>>>> nvme_tcp_queue *queue)
>>>>       memset(&msg, 0, sizeof(msg));
>>>>       iov.iov_base = icresp;
>>>>       iov.iov_len = sizeof(*icresp);
>>>> +#ifdef CONFIG_NVME_TCP_TLS
>>>> +    msg.msg_control = cbuf;
>>>> +    msg.msg_controllen = sizeof(cbuf);
>>>> +#endif
>>>>       ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
>>>>               iov.iov_len, msg.msg_flags);
>>>>       if (ret < 0)
>>>>           goto free_icresp;
>>>
>>> Is the cmsg passed unconditionally? meaning this does not
>>> impact non-tls?
>>>
>>> If so, why is the ifdef needed?
>>>
>> Passing in a cmsg (and a controllen) always enables the use of
>> control messages, irrespective of the type.
>> As we never enabled control messages prior to this we would
>> change the implementation when TLS is not enabled; who knows,
>> someone might have been sending us control messages all along,
>> but we never checked. So I thought it prudent to only enable
>> it for TLS where we know that we might be getting control messages.
> 
> But you are doing this only based on the compile-time config option, not
> based on a runtime setting. I am not sure I follow your logic.

For TLS I actually check the cmsg type, so even if we were to receive 
other control messages they would be caught.
If I were to enable control messages in general I would need to check 
for control messages on every packet, which may well impact performance.
Do we want that?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
(HRB 36809, AG Nürnberg)


