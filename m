Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E31AC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 13:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ODL/RZp3B3RfrFH5GlLl86qa0DgQB+nmVNbtBUgHocc=; b=TM+iKyYkhD+s4ACWvaft9dPu44
	kEVF4tner80GN7SvYB7ov8KAWibEmLK1xCogTDiehsVdW7vgxXzqQTz43IbNbWo4HVcIni4sdhAGZ
	qJ7hlf44oJwJ3PcehzXtpwxgKeljd4PwEznmyGMcim/FXIsENZThtsalBa3jJFwasZexC5ht6fFPy
	eMdQbn3B6dJpAmUAQIR2nYlvO/5g8QHvkEuy4KThA18TNeC9H5sP+mEQR2UKFi5zFzCHaV5+oayWy
	mpB1/RIeCIurqsBUWtK/DVHzQLjHN22U7ED83ZrYMpD12tU7HFak9opp9Fyt99gUxwLZ1YeV857f0
	9+tEvYHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmbwa-00GCNq-TH; Thu, 05 May 2022 13:55:01 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmbvs-00GC3w-Q7
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 13:54:20 +0000
Received: by mail-pf1-x42e.google.com with SMTP id c14so3705968pfn.2
 for <linux-nvme@lists.infradead.org>; Thu, 05 May 2022 06:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=ODL/RZp3B3RfrFH5GlLl86qa0DgQB+nmVNbtBUgHocc=;
 b=NS3DBt+ILaQtVBQLrA0NoEjJCJFhRoyZCB/Kw2nO7Bv80S7rbh8LSdFLipJA/Z/tz+
 WPs3kGZo4JrIR19XIVbSSTyMyuTW0NmioDgx1NXFdzTqA3vtGeTcM8joftbZU0WoOs6Q
 KuDNsgfRC321/2L4zPaFNtEW8aSlvNT5YH2I2Nt+r2IBzjV5fOET5ieWk1spJ2wWsrnL
 N5xm0CCC+DL8jAnEMP2gSpzYAyy4E9byrObe17Hh5g197gXVrmnzYcg77rqvF0N+Mu0E
 u8x9tpv1dVImAfGl/8PVRIZzJn6CRVrQtyKJFGr3mGPmAOEDX6Ke/4N8ryOVn5pdsvmY
 USUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ODL/RZp3B3RfrFH5GlLl86qa0DgQB+nmVNbtBUgHocc=;
 b=okHNYPveR5s6Q4dEthL+eaG/JCwotXwr17nOH0xHSEciL3VL+bU4o/Ysm1IeDQ/tms
 JrG4zykedn3ClPbUDzlPgYzrll0fnozb7oD5LLkwz/l2LwoiB594O3pNyda5SxM1PuUS
 UP9C80GF/fNGkso9E+wB2ERTQFCnDZQ9u7AMNeDbd2KnAQwL80Y5o3iYD9+nWKBsfsVZ
 lQJgSi2Jj9CFv8llOjdV3fz8qgCCnWo1MGm4VayjTFeVKS3mGwWfFQGEtZ4dCQ3yhjh8
 OOz1KgccK22l3/1DFYPirp0jdZJNd3G7O1lR+7ns0J1zn/F/CY4ALnUBZXFdZGurFVwb
 4xxg==
X-Gm-Message-State: AOAM530zJONcuWhaiMF2CSWMCC4S0lv8c+sOwFlkpcxUa37J8/UN7d7j
 k/rhOy1TU6gDMGKmPNl+zkFvuA==
X-Google-Smtp-Source: ABdhPJxWuqQiO4TJLigOa7txXWeQbIwY3pwXIa2+sxXkpiFsFG0B1d7FswwCnpZfv9bi+QTFQiRMMA==
X-Received: by 2002:a63:a18:0:b0:3c6:12b1:a8d0 with SMTP id
 24-20020a630a18000000b003c612b1a8d0mr3114898pgk.534.1651758855507; 
 Thu, 05 May 2022 06:54:15 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 f12-20020aa7968c000000b0050dc762813fsm1409512pfk.25.2022.05.05.06.54.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 May 2022 06:54:15 -0700 (PDT)
Message-ID: <a91d43b7-9d97-385e-190f-a26b078d2f36@kernel.dk>
Date: Thu, 5 May 2022 07:54:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/5] fs,io_uring: add infrastructure for uring-cmd
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 asml.silence@gmail.com, mcgrof@kernel.org, shr@fb.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com, gost.dev@samsung.com
References: <20220505060616.803816-1-joshi.k@samsung.com>
 <CGME20220505061144epcas5p3821a9516dad2b5eff5a25c56dbe164df@epcas5p3.samsung.com>
 <20220505060616.803816-2-joshi.k@samsung.com>
 <f9051783-5105-45ba-99b3-bc5d9254656d@kernel.dk> <YnPVtiRbYBYCGkCi@T590>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YnPVtiRbYBYCGkCi@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_065417_148047_DFAD1DA8 
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

On 5/5/22 7:48 AM, Ming Lei wrote:
> On Thu, May 05, 2022 at 06:52:25AM -0600, Jens Axboe wrote:
>> On 5/5/22 12:06 AM, Kanchan Joshi wrote:
>>> From: Jens Axboe <axboe@kernel.dk>
>>>
>>> file_operations->uring_cmd is a file private handler.
>>> This is somewhat similar to ioctl but hopefully a lot more sane and
>>> useful as it can be used to enable many io_uring capabilities for the
>>> underlying operation.
>>>
>>> IORING_OP_URING_CMD is a file private kind of request. io_uring doesn't
>>> know what is in this command type, it's for the provider of ->uring_cmd()
>>> to deal with. This operation can be issued only on the ring that is
>>> setup with both IORING_SETUP_SQE128 and IORING_SETUP_CQE32 flags.
>>
>> One thing that occured to me that I think we need to change is what you
>> mention above, code here:
>>
>>> +static int io_uring_cmd_prep(struct io_kiocb *req,
>>> +			     const struct io_uring_sqe *sqe)
>>> +{
>>> +	struct io_uring_cmd *ioucmd = &req->uring_cmd;
>>> +	struct io_ring_ctx *ctx = req->ctx;
>>> +
>>> +	if (ctx->flags & IORING_SETUP_IOPOLL)
>>> +		return -EOPNOTSUPP;
>>> +	/* do not support uring-cmd without big SQE/CQE */
>>> +	if (!(ctx->flags & IORING_SETUP_SQE128))
>>> +		return -EOPNOTSUPP;
>>> +	if (!(ctx->flags & IORING_SETUP_CQE32))
>>> +		return -EOPNOTSUPP;
>>> +	if (sqe->ioprio || sqe->rw_flags)
>>> +		return -EINVAL;
>>> +	ioucmd->cmd = sqe->cmd;
>>> +	ioucmd->cmd_op = READ_ONCE(sqe->cmd_op);
>>> +	return 0;
>>> +}
>>
>> I've been thinking of this mostly in the context of passthrough for
>> nvme, but it originally started as a generic feature to be able to wire
>> up anything for these types of commands. The SQE128/CQE32 requirement is
>> really an nvme passthrough restriction, we don't necessarily need this
>> for any kind of URING_CMD. Ditto IOPOLL as well. These are all things
>> that should be validated further down, but there's no way to do that
>> currently.
>>
>> Let's not have that hold up merging this, but we do need it fixed up for
>> 5.19-final so we don't have this restriction. Suggestions welcome...
> 
> The validation has to be done in consumer of SQE128/CQE32(nvme). One
> way is to add SQE128/CQE32 io_uring_cmd_flags and pass them via
> ->uring_cmd(issue_flags).

Right, that's what I tried to say, it needs to be validated further down
as we can (and will) have URING_CMD users that don't care about any of
those 3 things and can work fine with whatever sqe/cqe size we have.
IOPOLL also only applies if the handler potentially can block.

Using the issue_flags makes sense to me, it's probably the easiest
approach. Doesn't take space in the command itself, and there's plenty
of room in that flag space to pass in the ring sqe/cqe/iopoll state.

-- 
Jens Axboe


