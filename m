Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CB2C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 17:22:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D4961490
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 17:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D4961490
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=m9ENPGhKJonhnkq3H+yBz3IX6FSnSbKvje4w5GaOsiI=; b=PDU64H769xQLMMjEdipBZJ5ae
	S8KoNgnNruF6o3zJQIdw7CZltMYlmLqXts4ZKvThnZJno1Pk3oIQTzKTAArCF9kFuTNe3i/sUqcmc
	Dh7TlMzre9tq6U2ls3gq10ZCBk5dV37bD9pfLgISe32efXxJ0TgmUhCTSl9wm2KyQEAvnjxZq4Qcl
	kAykyvRb5QFv26LHLhCj5nrSj5Fz3IDM1roHHlNPyL01K35Ou+ePLvbBvqs8AfhDW53GfcvLjb7vw
	TEQnLIntiTFss/7zjbSLSDyegRlSPUNf4jTpKq8Bq2+V7K18v1nhXhHJMk7Rwf2h7O1bc0CHieX09
	0KApremGQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMZrr-003ch5-1F; Wed, 17 Mar 2021 17:21:59 +0000
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMZrn-003cgd-It
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 17:21:57 +0000
Received: by mail-il1-x12a.google.com with SMTP id z9so2237834ilb.4
 for <linux-nvme@lists.infradead.org>; Wed, 17 Mar 2021 10:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CC7Mf0q3EnAE5rDEZdcJka8pLybrmwi+35ZtT7cRNpY=;
 b=R8f/RSCPIzz9NYQuI5TblmZ75ivWjoBIXluRtO7AEotdMv7v7KHCvEai003M94RWSH
 l7ILlTeFi0m1sdeTXej8XNycu+0HFhG6iNN3ZHXCR/4bjs9eo67PDUYjkLZD9x4Y74vb
 OKdz6O6CIbjhSB2kmfLYXL/bOtf6+fmgvHPvvsE9YEdRoMDY+0jEMRjwoOEKaWo+P147
 WAd7wWzTJhC2SZTVkAjqUP+rhpB0cZ4l/w73CkqZMiEj42SrMqdZXG1xDawpQZHR1BVR
 R+kPCGhZLsdQ8NIowpoztRaT8kUyq1r0pVG2oYvOmVRGH4p0yYAmhvxkMfTKFCjkpCBK
 S+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CC7Mf0q3EnAE5rDEZdcJka8pLybrmwi+35ZtT7cRNpY=;
 b=I4rlV5tYWGkqWSrFTQjGJZ96dIL2+dpvsYvB/FBpuDta3d1Bkf99/2Xu+KQiXcQPml
 MHqmKpAWTqDXiMGnA46XtaLfJVRJEvtB0v78MMq+3LSDVaGiA60cvMwmC7IX8wpKjY0S
 8u58ucD1plHg15wYL2xgPs7MzYNMTAMjSw7R+R1KqsYlINfT33swWstlgzCKR+HQJRe6
 hdtkBnUqfB9jJBefAxTfc2rvcmGf7FFxQtnzPqyMUWXXCycNtwhWon1MsFCZbHlYCOtR
 UmaFnvahYQbWo8XTiuAjMAHZOUPWgeGKgC70zKAWLo1p1bdt4xaPtztTyC9Jxnb8Mo8Y
 AcgA==
X-Gm-Message-State: AOAM532l6OgoJGZsAy/rY5V98IDA2eR8xAR3twI5vEyW8pJmFlkxaH8M
 WRG5ILN8SDmcK3qObufNXfIzIA==
X-Google-Smtp-Source: ABdhPJybXw8bDKBlONIbtrQr8SGL+GEIUjjPZXAv+okD787KixQ5uvITZ2lF3f2Rihl32Q2eFqYSNw==
X-Received: by 2002:a05:6e02:1bc2:: with SMTP id
 x2mr8024672ilv.205.1616001714337; 
 Wed, 17 Mar 2021 10:21:54 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id d22sm10108387iof.48.2021.03.17.10.21.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Mar 2021 10:21:53 -0700 (PDT)
Subject: Re: [RFC PATCH v3 3/3] nvme: wire up support for async passthrough
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org,
 chaitanya.kulkarni@wdc.com, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, anuj20.g@samsung.com,
 javier.gonz@samsung.com, nj.shetty@samsung.com, selvakuma.s1@samsung.com
References: <20210316140126.24900-1-joshi.k@samsung.com>
 <CGME20210316140240epcas5p3e71bfe2afecd728c5af60056f21cc9b7@epcas5p3.samsung.com>
 <20210316140126.24900-4-joshi.k@samsung.com> <20210317085258.GA19580@lst.de>
 <149d2bc7-ec80-2e51-7db1-15765f35a27f@kernel.dk>
 <20210317165959.GA25097@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3b383e8e-b248-b8c4-2eea-6f5708845604@kernel.dk>
Date: Wed, 17 Mar 2021 11:21:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210317165959.GA25097@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_172155_762585_6BB100F9 
X-CRM114-Status: GOOD (  24.10  )
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

On 3/17/21 10:59 AM, Christoph Hellwig wrote:
> On Wed, Mar 17, 2021 at 10:49:28AM -0600, Jens Axboe wrote:
>> I will post it soon, only reason I haven't reposted is that I'm not that
>> happy with how the sqe split is done (and that it's done in the first
>> place). But I'll probably just post the current version for comments,
>> and hopefully we can get it to where it needs to be soon.
> 
> Yes, I don't like that at all either.  I almost wonder if we should
> use an entirely different format after opcode and flags, although
> I suspect fd would be nice to have in the same spot as well.

Exactly - trying to think of how best to do this. It's somewhat a shame
that I didn't place user_data right after fd, or even at the end of the
struct. But oh well.

One idea would be to have io_uring_sqe_hdr and have that be
op/flags/prio/fd as we should have those for anything, and just embed
that at the top of both io_uring_sqe (our general command), and
io_uring_whatever which is what the passthrough stuff would use.

Not sure, I need to dabble in the code a bit and see how we can make it
the cleanest.

> On a related note: I think it really should have a generic cmd
> dispatching mechanism like ioctls have, preferably even enforcing
> the _IO* mechanism.

Yes, we could certainly do that. I don't want to turn it into a
free-for-all and the wild west of passthrough, some notion of coherent
definitions would be prudent.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
