Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE5E606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OdXj2zQm;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YXH4IGKh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=DWu8RTq4M1mT4SAcEK2jsmnlCAu63IAngi1ivrZyiJ0=; b=OdXj2zQmo7/st+
	FuW7QpvMCYKLMj8zfZXPCoXd+lPlZNgXT5P/TaGER4/9riXuv5Tz51aBO07dMycfmbPuLkN1Cgev9
	/SaAn5NpDgRV7AU9jWvDA57AgbcaocXsnEWV1U9+lCSbA3I10WepwWg4M/7yrbE/p1LQ7c4A1ke6T
	0tf88pJWSFYoJR8NJQ9E8nOXl5+nVHfCGUTz7aXWfsDiQyPIX09oZeJ0ClXkXrBJj/87NAKLNM1zA
	f8a7zJnWziCOvsp4jgxCvJIQpMuKMl2dECnJuaL2YjW3rGM+2tw+Vqq5mHzNlzcq575LqYp8S3XhQ
	JefCiMpqKaNIf56NtA0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVSl4-00000003Gm1-0mLW;
	Mon, 23 Nov 2026 12:02:54 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVSkz-00000003GlU-2DVo
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 12:02:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795435365; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DWu8RTq4M1mT4SAcEK2jsmnlCAu63IAngi1ivrZyiJ0=;
	b=YXH4IGKhc0WzrngSYu/1GkYdCYyc1l6d9t8ER8zpnZZwb4ADZwXK4+WuQVo5+nb6M1vemUkZMODYGgqtGJ+lDvlaJuDIPiYmzQNpIaJCX1sH/xcHNFzH3aSxDgWC6lcF7pu9f8LYV7ZFgAS2UiFL8Y4hPH6IqtjhbPavrsPI1Lg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XFIfL2x_1795435364;
Received: from 30.178.68.101(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XFIfL2x_1795435364 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Nov 2026 20:02:44 +0800
Message-ID: <2ba54f54-d04a-4c59-9b24-19653debbd6f@linux.alibaba.com>
Date: Mon, 23 Nov 2026 20:02:43 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] nvme-auth: fix data race on ctrl->transaction
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>
References: <20261116081211.1757155-1-kanie@linux.alibaba.com>
 <20261116081211.1757155-3-kanie@linux.alibaba.com>
 <6dc083eb-7286-418b-92fe-f7245f653ba0@suse.de>
 <e048eab7-b8b9-4782-8f91-e79309d8be12@linux.alibaba.com>
 <cccc262a-a35f-4c6b-96df-c55fe7815818@suse.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <cccc262a-a35f-4c6b-96df-c55fe7815818@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_040250_137188_3F483385 
X-CRM114-Status: GOOD (  15.60  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/17 15:31, Hannes Reinecke 写道:
> On 11/17/26 3:16 AM, Guixin Liu wrote:
>>
>>
>> 在 2026/11/16 21:22, Hannes Reinecke 写道:
>>> On 11/16/26 9:12 AM, Guixin Liu wrote:
>>>> nvme_ctrl_auth_work() queues the DH-HMAC-CHAP exchange of every queue
>>>> on nvme-auth-wq without waiting for them, so multiple
>>>> nvme_queue_auth_work() instances run concurrently and all increment
>>>> ctrl->transaction in nvme_queue_auth_work(). The plain increment is a
>>>> data race, and the lost updates hand the same transaction id to
>>>> concurrent queues.
>>>>
>>>> The counter does not need to be shared at all: the controller only
>>>> echoes the transaction id within a queue, so a per-queue counter is
>>>> sufficient. Increment chap->transaction instead, drop the reset in
>>>> nvme_auth_reset_dhchap() so the id stays monotonic across
>>>> re-authentication, and remove the now unused ctrl->transaction field.
>>>>
>>> I disagree. The authentication transaction ID identifies the
>>> transaction itself, and is used to differentiate between different
>>> transactions. As such it needs to be unique within each queue.
>>> But as it carries controller-specific data we should also ensure
>>> the ID is unique per controller, ensuring we catch any possible
>>> misdirected authentication packet.
>> A misdirected packet is caught regardless of the transaction id.
>> Each queue's exchange carries its own random challenge:
>> nvmet_auth_challenge() fills req->sq->dhcahp_c1 with get_random_bytes()
>> per exchange, and the response digest covers that challenge.
>> A response computed for queue A fails the digest check on queue B even
>> when the transaction id and the step happen to match, because the
>> expected digest is different.
>>
>> So controller-level uniqueness would only detect a case the crypto
>> layer already rejects, while within a queue the id is unique either
>> way.
>>
> True, but that's valid only for challenge and response.
> Success (and, more importantly, Failure) are not protected
> in a similar manner. So spoofing any of these will be quite
> easy if we only have per-queue transaction ids.
>
> But as mentioned in my response to Keith: these are
> primarily security concerns, and really are just stop-gap
> measures to cover the most obvious issues.
> In the end it's still a number and as such
> not _that_ hard to guess.
> So if the consensus is that the protocol provisions
> are good enough it's fine with me.
Hi Hannes,
  Fair point. The digest only protects the challenge and response;
Success and Failure have no such protection, and the cross-queue
distinguishability costs nothing.

Hi Keith,
  Could you take this patch's v2 version instead, with the fixes
tag from v3 added (Fixes: f50fff73d620 ("nvme: implement In-Band authentication"))?

v2: https://lore.kernel.org/all/20261109022646.290792-4-kanie@linux.alibaba.com/

Best Regards,
Guixin Liu
>
> Cheers,
>
> Hannes


