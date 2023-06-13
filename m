Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9519C77B7A
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jun 2023 08:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mEeqTwNzeUy3t5ntNL+0pskfKElCphvbrZ3/VYlHntM=; b=kSQs7Q8GsQ1JQnnv5nRXLa9Qcb
	3lKhw1SLDyaAHFEB2EKQKwEFwVRJFxJeBUEB3Ba5Sbup70aDSp04ap7KhaMHwehxWoVtmOTzoXm3i
	RkpEtIP5XqFnnozycU5bn9zPpdUyDICu2Gi4lH9Pq8BXojaMnerxntrfrM7Tfo0DXKY1Efdiz0CgK
	2wXrXWZ61MW/IEp/LpAT6W5vYpX+04Neb5gX6wHhr51Y2OuWHNXI2SGluzOrJ93R/IQuIdG049C+l
	QzJyjIiZLTFyUXadmTF+Mcxn/KIhnexw73ud2OFKJ15ttYwacjUFfIantWneDgIfq4x5uvhA/HNDZ
	72Fxkj3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8z7U-007KnH-0n;
	Tue, 13 Jun 2023 08:11:16 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8z7R-007Km9-0e
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jun 2023 08:11:14 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 10DCB1FD78;
	Tue, 13 Jun 2023 08:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686643866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mEeqTwNzeUy3t5ntNL+0pskfKElCphvbrZ3/VYlHntM=;
	b=Xt5ztVkwhWMejWLk8U/aueZzDx/KjtXB2jSwR/0UG7RZCQ7pZmHl07dLKE9CY7DxsWylL/
	icQSCSg9Mtkc8OLl2aU4hwHBNGJzmk4wDGBzCtHDuYCXfhBxK/dB8IxfPfmMOMyLw4G4yT
	khyAYJOm5qX/W0EEku+amUpP8usIqwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686643866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mEeqTwNzeUy3t5ntNL+0pskfKElCphvbrZ3/VYlHntM=;
	b=a2HitXy1yN0lU385W1RwWyK4Tiyjh15mBzR5D/t4fb2pYa9chqd+EwUq/u/6U/3/KclTdS
	x5ElHnk/AXPveVDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F149F13483;
	Tue, 13 Jun 2023 08:11:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id y3XiOZkkiGSXKgAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 13 Jun 2023 08:11:05 +0000
Message-ID: <acdb1a68-3180-0099-8520-24feb9a71efa@suse.de>
Date: Tue, 13 Jun 2023 10:11:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] net/tls: handle MSG_EOR for tls_device TX flow
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
References: <20230612143833.70805-1-hare@suse.de>
 <20230612143833.70805-3-hare@suse.de>
 <f560c8fa-d6a1-7bd2-3fd7-728f90207322@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <f560c8fa-d6a1-7bd2-3fd7-728f90207322@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_011113_408996_68826B8C 
X-CRM114-Status: GOOD (  18.05  )
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

On 6/13/23 09:58, Sagi Grimberg wrote:
> 
> 
> On 6/12/23 17:38, Hannes Reinecke wrote:
>> tls_push_data() MSG_MORE / MSG_SENDPAGE_NOTLAST, but bails
>> out on MSG_EOR.
>> But seeing that MSG_EOR is basically the opposite of
>> MSG_MORE / MSG_SENDPAGE_NOTLAST this patch adds handling
>> MSG_EOR by treating it as the absence of MSG_MORE.
>> Consequently we should return an error when both are set.
>>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: netdev@vger.kernel.org
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   net/tls/tls_device.c | 24 ++++++++++++++++++++----
>>   1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
>> index a7cc4f9faac2..0024febd40de 100644
>> --- a/net/tls/tls_device.c
>> +++ b/net/tls/tls_device.c
>> @@ -448,10 +448,6 @@ static int tls_push_data(struct sock *sk,
>>       int copy, rc = 0;
>>       long timeo;
>> -    if (flags &
>> -        ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | 
>> MSG_SENDPAGE_NOTLAST))
>> -        return -EOPNOTSUPP;
>> -
>>       if (unlikely(sk->sk_err))
>>           return -sk->sk_err;
>> @@ -529,6 +525,10 @@ static int tls_push_data(struct sock *sk,
>>                   more = true;
>>                   break;
>>               }
>> +            if (flags & MSG_EOR) {
>> +                more = false;
>> +                break;
>> +            }
>>               done = true;
>>           }
>> @@ -573,6 +573,14 @@ int tls_device_sendmsg(struct sock *sk, struct 
>> msghdr *msg, size_t size)
>>       union tls_iter_offset iter;
>>       int rc;
>> +    if (msg->msg_flags &
>> +        ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_EOR))
>> +        return -EOPNOTSUPP;
>> +
>> +    if ((msg->msg_flags & MSG_MORE) &&
>> +        (msg->msg_flags & MSG_EOR))
>> +        return -EOPNOTSUPP;
> 
> EINVAL is more appropriate I think...
> 
Guess what, that's what I did initially.
But then when returning EINVAL we would arguably introduce a regression
(as suddenly we'll be returning a different error code as previously).
So with this patch we're backwards compatible.

But that's really a quesion for Jakub: what's more appropriate here?
Return a new error code (which describes the situation better) or stick
with the original one (and retain compability)?

Cheers,

Hannes


