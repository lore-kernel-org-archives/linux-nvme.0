Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56769C4167B
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Dec 2022 07:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VxDwiJXpeJ3rz5PIgA1sGcqPRUWOwoBOzzJkJv86ei4=; b=4Yh08tbsDdABQMrFs0oaDOCoCg
	RoBMsM8Ivo0vXcX0HAHobw6VcZDwc7IRFpEto4AS3w+Q75o/ww2uUd6pbgzkXW6nNvp3xTpiFFl73
	KMTD+0McErNGGQmnsprX8zoBG8e3W55GY5bR9OQfwjHy2KEx3eUpMEIoZKyH0Njha8XEpxtZk/C1D
	Pf81q187/ZeSdPnnOG9OqQ10Bs6lNfm9iX7QkhYZaPTw7bEUL4fMk5FDo+GIKD3iXMjL+Adu0MZf3
	VMimjgu3e+v5l753k8r+w8m7WMYBEuzoAz1uyu3pnQais6pAT8PvFDvHzw0uMKrUd20/b8N9pdqmq
	NHsWe7vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p10Hk-00E65N-1g; Fri, 02 Dec 2022 07:16:36 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p10Hf-00E638-W7
	for linux-nvme@lists.infradead.org; Fri, 02 Dec 2022 07:16:34 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F0E81FDB2;
	Fri,  2 Dec 2022 07:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1669965390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VxDwiJXpeJ3rz5PIgA1sGcqPRUWOwoBOzzJkJv86ei4=;
	b=ltyZzGULJVkRgs/zoGzyN5D9REQL8+g1ttF4z71KJEA0QXBDAkfyy+nDwG49rH08MuHuMO
	tVlaCAoRn66PIUYQWZupZzhXSa6mvTo72yTSSwWxMKwi69sk4h6R3w+FmkDYJTHcIQXwRt
	hnAs1t6SS/rbNMA5kTAnBTsus2B2BrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1669965390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VxDwiJXpeJ3rz5PIgA1sGcqPRUWOwoBOzzJkJv86ei4=;
	b=4msXqwTEXyobbt3SEnJkou/wDnv4DpCkE1+c1MyGwRrJ4Lfk+T++1OEccSzltHJxaV1WLm
	nx/4RSPljsN8E6AQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id CEC4D13644;
	Fri,  2 Dec 2022 07:16:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap1.suse-dmz.suse.de with ESMTPSA
	id Z13CMU2miWOmAgAAGKfGzw
	(envelope-from <hare@suse.de>); Fri, 02 Dec 2022 07:16:29 +0000
Message-ID: <72a51a83-c25a-ef52-55fb-2b73aec70305@suse.de>
Date: Fri, 2 Dec 2022 08:16:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
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
 <Y4kC9NIXevPlji+j@casper.infradead.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Y4kC9NIXevPlji+j@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221201_231632_251598_9726D9FB 
X-CRM114-Status: GOOD (  12.63  )
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

On 12/1/22 20:39, Matthew Wilcox wrote:
> On Thu, Dec 01, 2022 at 06:12:46PM +0000, Chaitanya Kulkarni wrote:
>> So nobody can get away with a lie.
> 
> And yet devices do exist which lie.  I'm not surprised that vendors
> vehemently claim that they don't, or "nobody would get away with it".
> But, of course, they do.  And there's no way for us to find out if
> they're lying!
> 
But we'll never be able to figure that out unless we try.

Once we've tried we will have proof either way.
Which is why I think we should have that implementation.
Only then we'll know if it's worth it, both from the hardware and the 
application side.

Without an implementation it'll just degrade to a shouting match.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


