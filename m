Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A748C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 10:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PSVJ6Id24TJjCbPzacbLzNCLN0r2IdPBnGze5xA+GWI=; b=hik2dGHAVbRVUNzAbGfUMamMtl
	ny3eFJ55TTAk8u6l2UAEEuyyIjZlWksSSXcoRRqrxqBWxoRXL0TdZrOGiXXAJaA/0YKGV6QiEzjsg
	qjHeXDBzQjHRyUfB8p7AQMJhhRau1z7tpgVjDH6ulY8UuqcjhHpGRyq1Dw/7iF8k4pMS0yRFCyBAy
	bqy41s5nZaFQEftCsGMWjN+HJ5DScgNDnp80zTScgP+rBG9wrQqPmCpE3U8BlN3E9nht7rmPlXykB
	5rLSaUiqmXYV9WduU0mCWBT87ZSzSoRRICByFKI7BPLEhYn/zc5GUY3Bw1CjWL6JbGGjatl3+MrhM
	3xsdFGxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrzVn-00BlyA-DP; Fri, 20 May 2022 10:05:35 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrzVi-00Blwn-KY
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 10:05:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A77911F45B;
 Fri, 20 May 2022 10:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1653041128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PSVJ6Id24TJjCbPzacbLzNCLN0r2IdPBnGze5xA+GWI=;
 b=bj1nFv+y9nz7OlgXb3q7LN56bhlBNVqdnztDJyasZhOHwTg3MP5xFoQ0OTeqUV6ctjfV//
 AH/YJx079sgIpir4vERhfJh5zBqaGbdvmvS179Qirf4lfwpw5ejUpiWS8nOoB1pz87jHv0
 /6+21/M9jl6j+sCRMZVwEt3GvocdoWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1653041128;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PSVJ6Id24TJjCbPzacbLzNCLN0r2IdPBnGze5xA+GWI=;
 b=HV0sMLakBR1R6Wu+Lk4ouA4EiAQ9xR4T+ao6RflN94tWUD9X82Iw+nhs+D2mEXbWAXaAlF
 q+TqOVEyZFDpM9Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89CB113AF4;
 Fri, 20 May 2022 10:05:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +sC9IOhnh2KYAQAAMHmgww
 (envelope-from <hare@suse.de>); Fri, 20 May 2022 10:05:28 +0000
Message-ID: <6b373301-e8fa-abfb-d27f-9e90ef2eef13@suse.de>
Date: Fri, 20 May 2022 12:05:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220519062617.39715-1-hare@suse.de>
 <20220519062617.39715-3-hare@suse.de>
 <bd99d7d6-c9b2-7448-1eaa-d645f7372694@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/3] nvme-tcp: Check for write space before queueing
 requests
In-Reply-To: <bd99d7d6-c9b2-7448-1eaa-d645f7372694@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220520_030530_862151_4CA16FA3 
X-CRM114-Status: GOOD (  21.03  )
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

On 5/20/22 11:17, Sagi Grimberg wrote:
> 
>> The current model of always queue incoming requests lead to
>> write stalls as we easily overload the network device under
>> high I/O load.
>> To avoid unlimited queueing we should rather check if write
>> space is available before accepting new requests.
> 
> I'm somewhat on the fence with this one... On one end, we
> are checking the sock write space, but don't check the queued
> requests. And, this is purely advisory and not really a check
> we rely on.
> 
> The merit of doing something like this is that we don't start
> the request timer, but we can just as easily queue the request
> and have it later queued for long due to sock being overloaded.
> 
> Can you explain your thoughts to why this is a good solution?
> 
Request timeouts.
As soon as we call 'blk_mq_start_request()' the I/O timer is called, and 
given that we (currently) queue _every_ request irrespective of the 
underlying device status we might end up queueing for a _loooong_ time.

Timeouts while still in the queue are being handled by the first patch, 
but the underlying network might also be busy with retries and whatnot.
So again, queuing requests when we _know_ there'll be a congestion is 
just asking for trouble (or, rather, spurious I/O timeouts).

If one is worried about performance one can always increase the wmem 
size :-), but really it means that either your testcase or your network 
is misdesigned.
And I'm perfectly fine with increasing the latency in these cases.
What I don't like is timeouts, as these will show up to the user and we 
get all the supportcalls telling us that the kernel is broken.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

