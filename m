Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEF3C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 18:43:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E3964F1B
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 18:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E3964F1B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LRmUhmaBJpgELxKQHA3AQNb8HIoY6Dqw+jNlwC5s03g=; b=VzSrD2zPuCFmI9Fblui1/rm05
	dXM++VFBfJ8zun+My/Wqo6oLaWXNnSlzBJELqpJ9z0aVNXCRX+Rd/cXqIXkXCa1SKeq3BfImesaLG
	YqPoDeknVsJK9xMKQ3GWqvDYX6bhBRT2Y7DzOrkOJV91kYMfZ7CkDp/5TvK8JhZbTAIx8mSGK7ZO+
	d6lr7Aalj+jzOwCHB5LPjtxynCXU4YHwG8xEkBWs0rDxDFQdy2/kzN2K3ePrg3dgMP5+tl4/KupkD
	9tfB8GsyzkbLiOrIp93tj+3OCCXUGx1J66nRRbj1+jWW1ytNW2JMjd2c0tqQHSLNc5UH/qAVKXy5R
	fSz+MNRnw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMxbw-005rvU-8W; Thu, 18 Mar 2021 18:43:08 +0000
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMxbt-005ruw-3J
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 18:43:06 +0000
Received: by mail-io1-xd33.google.com with SMTP id z3so3383128ioc.8
 for <linux-nvme@lists.infradead.org>; Thu, 18 Mar 2021 11:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GAfAjjIzpAnMtL+e+2rg+bzNmZbbBb4hoURr3TnuGmg=;
 b=HBjVNr3ZI3O21Z4iiMNWqaEbye2kw38MoSNoiuZrmgo8OnBsFemlVxnIPVqUmkoPnQ
 5uiBVXR6p6CZU+pSqbWSe01XaMq2BDcgkkii6idM9cmuKD2DKrlXyfycWgxaIz9wlvLM
 ZrrmVaeCWgv3ob0H5qh0ChPEg5m3l/Ki+j6tt4l3YZArZCNy7Aatj41wCw1p1+hb2hXd
 BWJzy3WRPX3Tqv36tklFVxyhigTU219w6sezgzxOjUyS4/u9b1kYmbsRD1a+1g9Pn4WQ
 kDFeZID2X1HFIVZxnTM1LQZ2UzZKxNgMe7wq8wKELzv2sboGco+bD4hjIAcbabcxV3NH
 vDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GAfAjjIzpAnMtL+e+2rg+bzNmZbbBb4hoURr3TnuGmg=;
 b=sCa2dFfwnRcxKpCXq+6vWrXtLO6pKgmM1N/45UphTMP3hrZjGCx7goO+IpZjqZwh15
 lBucJJ8wkMJ+SWoo8iIfRY1xyF0sK+s56Aw4efqJaq8emHCohugynX81AczK4W3HcAP+
 KDOVfVVEbU/nPiv+t1cQL94ioXj4b+haJUHgFOVoIvB5Yk3dUd7bOzjfinSAQNqG0jYU
 PJ1v6TwLYguPNFALDdZDnkayFaU0KUT3CqBSFJnKjdr+FOBIb0QiJwuaZpR9TNzRpL2+
 KDHnuTQClpXziw3XhxLxEfpmlXpjvYLGQn7QzhCTheyW2mNmIjDJwUDI5RdkThpYmo6B
 9gbQ==
X-Gm-Message-State: AOAM530dC86sL1o2Ec+c950aJqA8UQsmyDQiuKtFS6TasTmacGAkumdB
 Nn4thhV1GYqHzbBHI8jPORFjTg==
X-Google-Smtp-Source: ABdhPJzWzPzho8ZT0+KUlv1G3Jurw1DDsHU7AjdcFIe66b8PLKXWcO2VCObNi0d/rVtOh7VPQnN7Eg==
X-Received: by 2002:a02:9986:: with SMTP id a6mr8288138jal.46.1616092983893;
 Thu, 18 Mar 2021 11:43:03 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id r18sm1444188ilj.86.2021.03.18.11.43.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Mar 2021 11:43:03 -0700 (PDT)
Subject: Re: [PATCH 4/8] io_uring: add support for IORING_OP_URING_CMD
To: Christoph Hellwig <hch@lst.de>
Cc: io-uring@vger.kernel.org, joshi.k@samsung.com, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, metze@samba.org
References: <20210317221027.366780-1-axboe@kernel.dk>
 <20210317221027.366780-5-axboe@kernel.dk> <20210318054254.GC28063@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <97b0c789-7230-e38b-4c06-97dc3c42b858@kernel.dk>
Date: Thu, 18 Mar 2021 12:43:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210318054254.GC28063@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_184305_186031_377DCACA 
X-CRM114-Status: GOOD (  30.41  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/17/21 11:42 PM, Christoph Hellwig wrote:
> On Wed, Mar 17, 2021 at 04:10:23PM -0600, Jens Axboe wrote:
>> +/*
>> + * Called by consumers of io_uring_cmd, if they originally returned
>> + * -EIOCBQUEUED upon receiving the command.
>> + */
>> +void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret)
>> +{
>> +	struct io_kiocb *req = container_of(cmd, struct io_kiocb, uring_cmd);
>> +
>> +	if (ret < 0)
>> +		req_set_fail_links(req);
>> +	io_req_complete(req, ret);
>> +}
>> +EXPORT_SYMBOL(io_uring_cmd_done);
> 
> This really should be EXPORT_SYMBOL_GPL. But more importantly I'm not

Did make that change in my tree yesterday.

> sure it is an all that useful interface.  All useful non-trivial ioctls
> tend to access user memory, so something that queues up work in the task
> context like in Joshis patch should really be part of the documented
> interface.

Agree, and I made some comments on that patch to how to make that situation
better. Should go in with this part, to have in-task completions for
finishing it up.

>> +static int io_uring_cmd_prep(struct io_kiocb *req,
>> +			     const struct io_uring_sqe *sqe)
>> +{
>> +	const struct io_uring_cmd_sqe *csqe = (const void *) sqe;
> 
> We really should not need this casting.  The struct io_uring_sqe
> usage in io_uring.c needs to be replaced with a union or some other
> properly type safe way to handle this.
> 
>> +	ret = file->f_op->uring_cmd(&req->uring_cmd, issue_flags);
>> +	/* queued async, consumer will call io_uring_cmd_done() when complete */
>> +	if (ret == -EIOCBQUEUED)
>> +		return 0;
>> +	io_uring_cmd_done(&req->uring_cmd, ret);
>> +	return 0;
> 
> This can be simplified to:
> 
> 	if (ret != -EIOCBQUEUED)
> 		io_uring_cmd_done(&req->uring_cmd, ret);
> 	return 0;

Good point, will do that.

>> + * Note that the first member here must be a struct file, as the
>> + * io_uring command layout depends on that.
>> + */
>> +struct io_uring_cmd {
>> +	struct file	*file;
>> +	__u16		op;
>> +	__u16		unused;
>> +	__u32		len;
>> +	__u64		pdu[5];	/* 40 bytes available inline for free use */
>> +};
> 
> I am a little worried about exposting this internal structure to random
> drivers.  OTOH we need something that eventually allows a container_of
> to io_kiocb for the completion, so I can't think of anything better
> at the moment either.
> 


-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
