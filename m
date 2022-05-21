Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11033C433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 21 May 2022 20:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AFWqLDpbize32sDjl8hs8oq3vq5BENhhlqZqfscTpmk=; b=MFK1p+zXLhrpKNJ5Qob65T09ko
	XKr2899PUqyvsMm6ROyOZDI8jAl9wmeXd6cfeVglrhE+IVhdkAby60PDyXg1HNmCzLmTrWccknynd
	CkIIpmsY759siy6KDXhWZ2ZJ8ZJplyzSqCpLPbgp1C3S9b3JfGZC+z3bpXCU30twJIXjFop7fSCdE
	mNegZpzgIToHGrsvUey2eNENesSVN0QXKhPI4FD+5wNyfg4OZ5Y8fur3wtLWOJjYrqoIYWhlDjDHD
	cBu8J91k7ChYR383I1uJ0Holpo2hVAehkbiSAo8euR5/VjDkKogr5D9KMeZEgPCaYTzrArK46P6SL
	xDGQWnnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nsVIJ-00HNSn-2v; Sat, 21 May 2022 20:01:47 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nsVIG-00HNSB-FL
 for linux-nvme@lists.infradead.org; Sat, 21 May 2022 20:01:45 +0000
Received: by mail-wr1-f51.google.com with SMTP id e2so4005541wrc.1
 for <linux-nvme@lists.infradead.org>; Sat, 21 May 2022 13:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=AFWqLDpbize32sDjl8hs8oq3vq5BENhhlqZqfscTpmk=;
 b=4s0IpZxJ6mIAshzGHXMQeLiJApQhULnftVKWNB5Ebxfkso+o9K2Y0BH17kckhzwc1i
 xd4ejU9eNEGAG+GMiiVM/4gGHGVep/+rd7sQk8zUS0nQa568YXTiZtwkGEVouVqu5J8Z
 zCHxZK4sq3UpSEb1mtAXdNNeYsOZcLCsMrRhWoXTPvSZvAJjf8mmc54rnoUqluH/e9Fy
 n4CSFON5kc9FnexMhtHcfpoRNi4JlNOZ5HpL2Q0U0oonBT88YeUa9SJ0REowXey1iDDD
 dnFzB2bmLtzeZtaGX5j2pSQe0UQfYmmxcwSPEhal4CWMCiZ1jppgcnHST5IQ8JMByZgq
 Ab9g==
X-Gm-Message-State: AOAM531k+Fr6m4km83rbf/D9I8kvp7VNimWiWojLGnupS0GOyyUqhS96
 pjwdIETzAPhrZMLHOBB/OwU=
X-Google-Smtp-Source: ABdhPJy5MSWjxo2/yzwT2LlXCoACQ73IvH1/4S0C9Gg46Ix4PDQ74/39s8uTzVtW9IWv+Ig/fRpg4g==
X-Received: by 2002:a05:6000:18a5:b0:20f:c1e8:c7cc with SMTP id
 b5-20020a05600018a500b0020fc1e8c7ccmr5850761wri.434.1653163301236; 
 Sat, 21 May 2022 13:01:41 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il.
 [46.117.125.14]) by smtp.gmail.com with ESMTPSA id
 h19-20020adfaa93000000b0020c5253d8f7sm5955815wrc.67.2022.05.21.13.01.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 May 2022 13:01:40 -0700 (PDT)
Message-ID: <ac3d4746-9eab-8349-fef0-eb8bca1cb5f7@grimberg.me>
Date: Sat, 21 May 2022 23:01:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/3] nvme-tcp: Check for write space before queueing
 requests
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220519062617.39715-1-hare@suse.de>
 <20220519062617.39715-3-hare@suse.de>
 <bd99d7d6-c9b2-7448-1eaa-d645f7372694@grimberg.me>
 <6b373301-e8fa-abfb-d27f-9e90ef2eef13@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <6b373301-e8fa-abfb-d27f-9e90ef2eef13@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220521_130144_562335_64F39874 
X-CRM114-Status: GOOD (  22.34  )
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


>>> The current model of always queue incoming requests lead to
>>> write stalls as we easily overload the network device under
>>> high I/O load.
>>> To avoid unlimited queueing we should rather check if write
>>> space is available before accepting new requests.
>>
>> I'm somewhat on the fence with this one... On one end, we
>> are checking the sock write space, but don't check the queued
>> requests. And, this is purely advisory and not really a check
>> we rely on.
>>
>> The merit of doing something like this is that we don't start
>> the request timer, but we can just as easily queue the request
>> and have it later queued for long due to sock being overloaded.
>>
>> Can you explain your thoughts to why this is a good solution?
>>
> Request timeouts.
> As soon as we call 'blk_mq_start_request()' the I/O timer is called, and 
> given that we (currently) queue _every_ request irrespective of the 
> underlying device status we might end up queueing for a _loooong_ time.
> 
> Timeouts while still in the queue are being handled by the first patch, 
> but the underlying network might also be busy with retries and whatnot.
> So again, queuing requests when we _know_ there'll be a congestion is 
> just asking for trouble (or, rather, spurious I/O timeouts).
> 
> If one is worried about performance one can always increase the wmem 
> size :-), but really it means that either your testcase or your network 
> is misdesigned.
> And I'm perfectly fine with increasing the latency in these cases.
> What I don't like is timeouts, as these will show up to the user and we 
> get all the supportcalls telling us that the kernel is broken.

Can you run some sanity perf tests to understand if anything unexpected
comes up from this?

