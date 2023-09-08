Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4E0EE57C0
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Sep 2023 05:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QQhkJAyeX2RFjNddtb7bnQt1fhTJYz1Tq51AB0Z0tqs=; b=S3P9eA6TfGedx/OBvPwUpOdCfI
	6nx/50elzd9kEl3xs6Gr1Oe7xphw8zBjhVNBudmXuQTLyPbeMQgyap4fXmA7JQidXxhl1zvCJr2tj
	sA8yQbajg0Y/iU+whEoQl9TgQkTlknl3P9eiM3fcgCRlMkiyOv1TiJ1km+GmKB6pz9UWRyj+Ju/OS
	4+2tmsIT3O2Y4oykwZTUvgItHSxPFxHLkigdfmDJs/yPD9YoBRvDAo7XK2/llgt8+5vPF7WoHPcDS
	WYoQCn5V099UL/xlS/c/6zTQpd3kY2IQx108v6YK+NI/EYm53CcJ8t5MLhF1jkB0TqxaY5RcZaIIT
	ovwyFeVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeUTS-00D7EH-2A;
	Fri, 08 Sep 2023 05:56:10 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeUTM-00D7Cm-1K
	for linux-nvme@lists.infradead.org;
	Fri, 08 Sep 2023 05:56:09 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A5A4F1F749;
	Fri,  8 Sep 2023 05:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694152558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQhkJAyeX2RFjNddtb7bnQt1fhTJYz1Tq51AB0Z0tqs=;
	b=xPAh9iPGzZnnKb0A2UugQwYTTMD2+nZv2GtmUPEceRRuvQTR+G/fPH/4GqvhjVXMRVzrhe
	RCt4hrXtnb7tr/M1wqMAtdjlz08Zi0cyyN9EgvzC3rBz6QA8haZxX60mdLsCBGDL289l7U
	gt31cy5JlR8TAz6bOmgxy1EvgI5jL34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694152558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQhkJAyeX2RFjNddtb7bnQt1fhTJYz1Tq51AB0Z0tqs=;
	b=7d0pBCEKDR0+2TM2hweNW7CefzSWRB1yKDUt2QWSK+Wn99P/7tXcs9r56lvXQyfdpvMkm1
	HL5FiKiLWSjHKwAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DE78131FD;
	Fri,  8 Sep 2023 05:55:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id EJUhCm63+mSyZAAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 08 Sep 2023 05:55:58 +0000
Message-ID: <9b524f00-35f1-4f6c-896e-40f2879040d2@suse.de>
Date: Fri, 8 Sep 2023 07:55:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 03/12] block: add copy offload support
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 martin.petersen@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com,
 Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20230906163844.18754-1-nj.shetty@samsung.com>
 <CGME20230906164312epcas5p397662c68dde1dbc4dc14c3e80ca260b3@epcas5p3.samsung.com>
 <20230906163844.18754-4-nj.shetty@samsung.com>
 <b0f3d320-047b-4bd8-a6fc-25b468caf5b3@suse.de>
 <20230907071611.rgukw7fory2xh5sy@green245>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230907071611.rgukw7fory2xh5sy@green245>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_225604_621255_EAB752EB 
X-CRM114-Status: GOOD (  15.62  )
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

On 9/7/23 09:16, Nitesh Shetty wrote:
> On 07/09/23 07:49AM, Hannes Reinecke wrote:
>> On 9/6/23 18:38, Nitesh Shetty wrote:
>>
>> Hmm. That looks a bit odd. Why do you have to use wait_for_completion?
> 
> wait_for_completion is waiting for all the copy IOs to complete,
> when caller does not pass endio handler.
> Copy IO submissions are still async, as in previous revisions.
> 
>> Can't you submit the 'src' bio, and then submit the 'dst' bio from the 
>> endio handler of the 'src' bio?
> We can't do this with the current bio merging approach.
> 'src' bio waits for the 'dst' bio to arrive in request layer.
> Note that both bio's should be present in request reaching the driver,
> to form the copy-cmd.
> 
Hmm. I guess it would be possible, but in the end we can always change
it later once the infrastructure is in.

So:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


