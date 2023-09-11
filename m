Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D30EE801F
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Sep 2023 07:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OBms2MbanL4wowScFpok83vxiu9MRRYrFtiJ5kFMiJE=; b=4ikRGH3L+kuxW728wYuRCQnr5N
	IIerOt//B5HMnDblCqu8HAvfrNBsY0r1AkZxOFuAslfIx0IEQnYajWcByqIMZ3EgatQ2EBG9UROrx
	70np5NR3BF5NsamL28sX5SQmgfeztyAwgDCBlRuelzrJky9CWRxx3aNcCPfZtBKRrr6RWtDLtK/ZI
	d9V0L02NNXPcMjf/vTZox1ZTe3U9Z11tElC9dDO/qCDpFzoTydy8WgLRxVuR9re//igQzVbSlyz6Q
	vHzNN8haHqpMCWPWBIkl8Eb9A2aRWKdZbUpWvZDvEYCpzoUkFDRf3gwHPORZkrW6XkcoRxFTc50VN
	5IR7RWOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfbWN-00HQtc-2o;
	Mon, 11 Sep 2023 07:39:47 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfbWK-00HQs4-1s
	for linux-nvme@lists.infradead.org;
	Mon, 11 Sep 2023 07:39:46 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 84077218E2;
	Mon, 11 Sep 2023 07:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694417978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OBms2MbanL4wowScFpok83vxiu9MRRYrFtiJ5kFMiJE=;
	b=Q5EX8/qmTXzGMeQWXuJS40ntpaFw6uw7YuzJLn4QC1cRBcdVuZhlurw12eoTsd+Qrc7uSQ
	KJBjLOHROwY8WXSmX+JHN6Pi3NE8nwDeN8So4vWuhQSOK7lyCHwDvtYR1Q+UIb3mZ06QDD
	B9MT/yvLWruHEjdBXDkzV33IRfxLSmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694417978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OBms2MbanL4wowScFpok83vxiu9MRRYrFtiJ5kFMiJE=;
	b=LMm4dmczMri57uE8kWxOMnIlLIQex3ylAcOwrBlFAC+AdFCYxBx9BJBABNDOvjlGWvWW5+
	X3k9Qg/oKPfViKBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA7F6139CC;
	Mon, 11 Sep 2023 07:39:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id e2KjNznE/mT1aAAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 11 Sep 2023 07:39:37 +0000
Message-ID: <ec35111d-ba31-497b-ab01-b198d3feb814@suse.de>
Date: Mon, 11 Sep 2023 09:39:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 04/12] block: add emulation for copy
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 martin.petersen@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com,
 Vincent Fu <vincent.fu@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20230906163844.18754-1-nj.shetty@samsung.com>
 <CGME20230906164321epcas5p4dad5b1c64fcf85e2c4f9fc7ddb855ea7@epcas5p4.samsung.com>
 <20230906163844.18754-5-nj.shetty@samsung.com>
 <e6fc7e65-ad31-4ca2-8b1b-4d97ba32926e@suse.de>
 <20230911070937.GB28177@green245>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230911070937.GB28177@green245>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_003944_790926_D5AA28DD 
X-CRM114-Status: GOOD (  22.47  )
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

On 9/11/23 09:09, Nitesh Shetty wrote:
> On Fri, Sep 08, 2023 at 08:06:38AM +0200, Hannes Reinecke wrote:
>> On 9/6/23 18:38, Nitesh Shetty wrote:
>>> For the devices which does not support copy, copy emulation is added.
>>> It is required for in-kernel users like fabrics, where file descriptor is
>>> not available and hence they can't use copy_file_range.
>>> Copy-emulation is implemented by reading from source into memory and
>>> writing to the corresponding destination.
>>> Also emulation can be used, if copy offload fails or partially completes.
>>> At present in kernel user of emulation is NVMe fabrics.
>>>
>> Leave out the last sentence; I really would like to see it enabled for SCSI,
>> too (we do have copy offload commands for SCSI ...).
>>
> Sure, will do that
> 
>> And it raises all the questions which have bogged us down right from the
>> start: where is the point in calling copy offload if copy offload is not
>> implemented or slower than copying it by hand?
>> And how can the caller differentiate whether copy offload bring a benefit to
>> him?
>>
>> IOW: wouldn't it be better to return -EOPNOTSUPP if copy offload is not
>> available?
> 
> Present approach treats copy as a background operation and the idea is to
> maximize the chances of achieving copy by falling back to emulation.
> Having said that, it should be possible to return -EOPNOTSUPP,
> in case of offload IO failure or device not supporting offload.
> We will update this in next version.
> 
That is also what I meant with my comments to patch 09/12: I don't see 
it as a benefit to _always_ fall back to a generic copy-offload 
emulation. After all, that hardly brings any benefit.
Where I do see a benefit is to tie in the generic copy-offload 
_infrastructure_ to existing mechanisms (like dm-kcopyd).
But if there is no copy-offload infrastructure available then we really 
should return -EOPNOTSUPP as it really is not supported.

In the end, copy offload is not a command which 'always works'.
It's a command which _might_ deliver benefits (ie better performance) if 
dedicated implementations are available and certain parameters are met. 
If not then copy offload is not the best choice, and applications will 
need to be made aware of that.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


