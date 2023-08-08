Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E29DC001DB
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 06:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ckvi+ZLa7lrjTCeg902L3K56TYz3c7CrGZ+vqmebH7E=; b=lKcpOh5u0D1+7uQEKFwceSuqSw
	/EeL1DED4NHC9lIC0qqLex4SxUUUlvP8V2yCjgWnrsT2IoAtd8EPO1jw4Mb2imtdGg+V/1LRZj5Wa
	vQ1lvSxnd2WPj38s2vUW0xxQko7gjl4xw5XzSDodtnO25CJ6z2sGhnpDXk4aDBZdDlq9Wsf2DXIVr
	BZ3y7xOf1T7miJNnbaMurN7IAMbWHqz56WRAlwoI2vv2r1xzimPeKmYMeST5JI5ZE2w+JBjKy3xdg
	Fv5M0L/Uv/t+zsnNFj/lfNkxUagyNcXnB/rv7zzFO+pmiuu00L4KwdufMfBkJuKNLIjnPmhUZ0+qT
	DIBZ/osA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTFts-001mwB-2H;
	Tue, 08 Aug 2023 06:09:00 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTFtq-001mun-15
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 06:08:59 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 06C8222472;
	Tue,  8 Aug 2023 06:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691474934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ckvi+ZLa7lrjTCeg902L3K56TYz3c7CrGZ+vqmebH7E=;
	b=qa3+QosWvLk0Oj84NO1Rs0Eb7tWGsy6Y1m/pss24zqDn3LZuEOe2QlN3Kur01eL9xLIMWJ
	Hs9BZc2PhgoRcbsiWE4P7K5VSvUPyFyOyfRZNiHHIL4HQ8w1U9C51D5TOep4ZNvxZfC4hJ
	tFGGG32DEDFEykc+olIftafuj4HiNTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691474934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ckvi+ZLa7lrjTCeg902L3K56TYz3c7CrGZ+vqmebH7E=;
	b=qgsCXbn9pKRVe6Ip02LrX5EH40+XkbXhlvAiq8wXIZzAGg444a6/PaY3aZVbJeFPKsdj12
	hSC7Doc6BvPxW8Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFFE4139D1;
	Tue,  8 Aug 2023 06:08:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ub4LMfXb0WSyPAAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 08 Aug 2023 06:08:53 +0000
Message-ID: <1b3cc664-ad7d-493c-50a4-6fc473f06f5c@suse.de>
Date: Tue, 8 Aug 2023 08:08:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 12/14] nvmet-tcp: allocate socket file
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-13-hare@suse.de>
 <0ac55b10-6917-9247-59f3-5f3b8e121a9f@grimberg.me>
 <432fd12b-3da0-a3d0-73cc-863a272a0f85@suse.de>
 <8e0a1503-266f-0368-9eb2-ebeb256bd091@grimberg.me>
 <4e14f8b3-27ac-4afa-91e9-8ccb41a8b89b@suse.de>
 <3dca56b7-f981-73a7-386f-099c6f008064@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <3dca56b7-f981-73a7-386f-099c6f008064@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_230858_518570_9C42FCCD 
X-CRM114-Status: GOOD (  13.20  )
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

On 8/7/23 12:42, Sagi Grimberg wrote:
> 
>>>>>> -static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>>>>>> +static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>>>>>>           struct socket *newsock)
>>>>>
>>>>> Why does the function change from retcode to void in this patch?
>>>>
>>>> Because the return code was never evaluated.
>>>
>>> ??
>>>
>>> I see it is evaluated.
>>
>> Yes, but this patch moved the 'sock_release()' call into 
>> nvmet_tcp_alloc_queue(), making the return code obsolete.
>>
>> But I can make it a separate patch if required.
> 
> But now who calls sock_release if you failed before allocating
> the sockfile?
> 
That is done in nvmet_tcp_remove_port(), and independent on
queue release.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


