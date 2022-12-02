Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FC8C47088
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Dec 2022 07:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p8xc9/NvQfEQJ4e4z6/baVfh/lD5CFR3fcc+Q0PHSQI=; b=eGuxZMEgwIJg1dCDymHqcohdgE
	qc2cs1k3fVR3PMpOqKy7HVUR2vcFxBZCT8z4lC8KH7ypnIILQXI5nc0KPAWq6qjXJI/+/efC3k1iY
	ScHxQs+HgFAAjLTwTXIPiGu5VK8JwV8dcLoS2N/Q6Cgy9RYM+GmsLccKAUvzs8WOutv/0cBGom4aQ
	tCxwO8/SESLa3HwPgYAZ5gRFpAepYEDT2gWnAuwK6E9AW+QgL1or19hV3uznJWOoL9q74z86akVR8
	yCD/O2+ZhzappE8SI4GAbgMXMJeIO5xEfb8K/V22t40fqOObyoc5lVNCSE+4MAtvis2yfYYBQp6lQ
	RGJE5gFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p10Ek-00E5HK-QE; Fri, 02 Dec 2022 07:13:30 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p10Eh-00E5Dc-MP
	for linux-nvme@lists.infradead.org; Fri, 02 Dec 2022 07:13:29 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 806591FDB2;
	Fri,  2 Dec 2022 07:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1669965201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p8xc9/NvQfEQJ4e4z6/baVfh/lD5CFR3fcc+Q0PHSQI=;
	b=ybjOTPvRHpXwAhn3vINNm69twJGz58PGyPK1sd3JJZbdDiPz2XdYP0ZhZwebDY3UWbwKVN
	wDbUB5l15WW/8w+/RXjEQ/x1eSgM/aHnw1oZfWYT+5bACHpQI3sPlbXhA4JfNpeIOUAKNi
	wP2uRuN6cIXW9o6qJboZbFKuFHljxrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1669965201;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p8xc9/NvQfEQJ4e4z6/baVfh/lD5CFR3fcc+Q0PHSQI=;
	b=pNHg4CJKoV+kTyzOXNJhCE1t7cDzJtp0kSAmdAcNEpT9EoHNSazpnSisumGDH/FUhyIQ0d
	rahTJqu09ovnd6Ag==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id F18E013644;
	Fri,  2 Dec 2022 07:13:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap1.suse-dmz.suse.de with ESMTPSA
	id D8OZOZCliWPifwAAGKfGzw
	(envelope-from <hare@suse.de>); Fri, 02 Dec 2022 07:13:20 +0000
Message-ID: <ab4f15be-2e4a-0a5c-8d36-051b3808be2f@suse.de>
Date: Fri, 2 Dec 2022 08:13:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "djwong@kernel.org"
 <djwong@kernel.org>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "javier@javigon.com" <javier@javigon.com>,
 "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
 "bvanassche@acm.org" <bvanassche@acm.org>,
 "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
 "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>, "clm@fb.com" <clm@fb.com>,
 "dsterba@suse.com" <dsterba@suse.com>, "jack@suse.com" <jack@suse.com>,
 "tytso@mit.edu" <tytso@mit.edu>,
 "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
 "jlayton@kernel.org" <jlayton@kernel.org>,
 "idryomov@gmail.com" <idryomov@gmail.com>,
 "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
 "ebiggers@google.com" <ebiggers@google.com>,
 "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
References: <20220630091406.19624-1-kch@nvidia.com>
 <YsXJdXnXsMtaC8DJ@casper.infradead.org>
 <d14fe396-b39b-6b3e-ae74-eb6a8b64e379@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <d14fe396-b39b-6b3e-ae74-eb6a8b64e379@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221201_231327_904439_89426BD8 
X-CRM114-Status: GOOD (  22.16  )
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

On 12/1/22 19:12, Chaitanya Kulkarni wrote:
> On 7/6/22 10:42, Matthew Wilcox wrote:
>> On Thu, Jun 30, 2022 at 02:14:00AM -0700, Chaitanya Kulkarni wrote:
>>> This adds support for the REQ_OP_VERIFY. In this version we add
>>
>> IMO, VERIFY is a useless command.  The history of storage is full of
>> devices which simply lie.  Since there's no way for the host to check if
>> the device did any work, cheap devices may simply implement it as a NOOP.
> 
> In past few months at various storage conferences I've talked to
> different people to address your comment where device being
> a liar verify implementation or even implementing NOOP.
> 
> With all do respect this is not true.
> 
[ .. ]

Be careful to not fall into the copy-offload trap.
The arguments given do pretty much mirror the discussion we had during 
designing and implementing copy offload.

Turns out that the major benefit for any of these 'advanced' commands is 
not so much functionality but rather performance.
If the functionality provided by the command is _slower_ as when the 
host would be doing is manually there hardly is a point even calling 
that functionality; we've learned that the hard way with copy offload, 
and I guess the same it true for 'verify'.
Thing is, none of the command will _tell_ you how long that command will 
take; you just have to issue it and wait for it to complete.
(Remember TRIM? And device which took minutes to complete it?)

For copy offload we only recently added a bit telling the application 
whether it's worth calling it, or if we should rather do it the old 
fashioned way.

But all of the above discussion has nothing to do with the 
implementation. Why should we disallow an implementation for a 
functionality which is present in hardware?
How could we figure out the actual usability if we don't test?
Where is the innovation?

We need room for experimenting; if it turns out to be useless we can 
always disable or remove it later. But we shouldn't bar implementations 
because hardware _might_ be faulty.

I do see at least two topics for the next LSF:

- Implementation of REQ_OP_VERIFY
- Innovation rules for the kernel
...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


