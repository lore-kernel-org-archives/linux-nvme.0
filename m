Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26001C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 14:38:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2CBA64DDC
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 14:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2CBA64DDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=llh6dQeQMhWhFXDeEQ9dCQQiZiSybCj9mb21P2pCSvI=; b=tKDVFB2qZTEYKfu0zqW8mYthk
	gnM/jhZ7yi4YyGml3Z9n41Y/U1CSJZi8wTjknd3rT1+66oWj1217UVJlYxR4yTS6CAN6cCEAsOl9X
	P3GpcDddWfx/XsrC+vJ5WAL2LapMYcWGcsifZb05LU69L/UtglZ7fQ2RZoPmRf1llDhL+jCxwkAVA
	tGCqkxi7iyuzbigv8GqODZkw2Sc83xjq3dKas48f0PalTw6qN2PZP2tg7D/5yBIf6kdpzx3DFwiCB
	rVS0TjN8ok+l5l8HHopbA7rNTA7Y03VCOQBuXKGE/XAuHuhyUpfe6RebIeUXNLtzr7+GWYwVqj7ej
	ut/QjnoaA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l58R3-0007pE-QO; Thu, 28 Jan 2021 14:38:13 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l58Qy-0007od-DC
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 14:38:10 +0000
Received: by mail-pf1-x430.google.com with SMTP id u67so4114229pfb.3
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 06:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+K9aRikhzkU/M83eoE775gCY9CV/6b9E2oecU5axx5g=;
 b=UMAxMG1FLhDbDsBf51QXNFGmn0mwp++nMNGqrEfynUCJ3cWwcCSGds0fZsfDoQcBak
 fsOVcl9etsXuKbnwhMZaLdlg4Yk13sr4vdMkubJLJ4PNmbcG0h1JAhdI8+5M9cz7Xi8D
 YLOnI+VT7aOwynM7CQhRpsjkkP3o2bSU0Go28TanqY25/coaBtUgo5t4X2jpI1g9Ce6w
 vivCVWOe1k+QAwpqX5tkcfXer2T9txbbdWncaalBy+TrL+oaiWfsWhxbuw53sZyVNibV
 w3YEc9V2PEX+gLzWSsQedWAzZDBW87S0K5flsI7JSdkqpG/9TMmwqoIlURSlPYxOmtYT
 yuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+K9aRikhzkU/M83eoE775gCY9CV/6b9E2oecU5axx5g=;
 b=AGs/8r27cO3oQeZAG3qDsGhitwESBjtmEin7bTNPDhmE/LSD6KPctIHtNdPNYej23I
 7pQ56x7nY/BiAEOi033Oi2MwVG/Pttkm+cuXrJQwfGzWl0I5zgI8sME0+AdYwq2/8aCg
 llAP6l0Fn/TUOfazbjhOB/EKjPvP7ZGBBQh4nE1T2J5UaWGPAWj1dJTPEirkc35X8zHL
 vKQ+2TmfwbHy6F08ngEFZviwv1mTS9YKA5Zn5LmhQ4ZzmO0MBCpi2XyYOWNES3fyaB8Z
 5T+3c/yVFYEOfzF5UEf0/20mgUMa5tWJv+jkGbmPiLJGycn2LexZJMi4iFN0oDNOFPsm
 xG7g==
X-Gm-Message-State: AOAM530raz3VRRVhApEzhbW9xaxlp3ojEKycTCGk3K0OU1zIEXJJEzx4
 ygDQhda7Mqga20n3o02v5EmSYQ==
X-Google-Smtp-Source: ABdhPJxoXLGAyp++HZF4CXIJUzkqE1H0ePUwPy8jBDvALyGIXU+gMp1KP4aQg31Mh8+DlsvT8IOp8w==
X-Received: by 2002:a63:e109:: with SMTP id z9mr16757589pgh.5.1611844685941;
 Thu, 28 Jan 2021 06:38:05 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 b62sm6249262pfg.58.2021.01.28.06.38.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Jan 2021 06:38:05 -0800 (PST)
Subject: Re: [RFC PATCH 0/4] Asynchronous passthrough ioctl
To: Kanchan Joshi <joshiiitr@gmail.com>,
 Pavel Begunkov <asml.silence@gmail.com>
References: <CGME20210127150134epcas5p251fc1de3ff3581dd4c68b3fbe0b9dd91@epcas5p2.samsung.com>
 <20210127150029.13766-1-joshi.k@samsung.com>
 <489691ce-3b1e-30ce-9f72-d32389e33901@gmail.com>
 <a287bd9e-3474-83a4-e5c2-98df17214dc7@gmail.com>
 <CA+1E3rJHHFyjwv7Kp32E9H-cf5ksh0pOHSVdGoTpktQrB8SE6A@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2d37d0ca-5853-4bb6-1582-551b9044040c@kernel.dk>
Date: Thu, 28 Jan 2021 07:38:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+1E3rJHHFyjwv7Kp32E9H-cf5ksh0pOHSVdGoTpktQrB8SE6A@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_093808_464250_678BC0F4 
X-CRM114-Status: GOOD (  24.71  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Selvakumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 linux-fsdevel@vger.kernel.org, Nitesh Shetty <nj.shetty@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 io-uring@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/28/21 5:04 AM, Kanchan Joshi wrote:
> On Wed, Jan 27, 2021 at 9:32 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 27/01/2021 15:42, Pavel Begunkov wrote:
>>> On 27/01/2021 15:00, Kanchan Joshi wrote:
>>>> This RFC patchset adds asynchronous ioctl capability for NVMe devices.
>>>> Purpose of RFC is to get the feedback and optimize the path.
>>>>
>>>> At the uppermost io-uring layer, a new opcode IORING_OP_IOCTL_PT is
>>>> presented to user-space applications. Like regular-ioctl, it takes
>>>> ioctl opcode and an optional argument (ioctl-specific input/output
>>>> parameter). Unlike regular-ioctl, it is made to skip the block-layer
>>>> and reach directly to the underlying driver (nvme in the case of this
>>>> patchset). This path between io-uring and nvme is via a newly
>>>> introduced block-device operation "async_ioctl". This operation
>>>> expects io-uring to supply a callback function which can be used to
>>>> report completion at later stage.
>>>>
>>>> For a regular ioctl, NVMe driver submits the command to the device and
>>>> the submitter (task) is made to wait until completion arrives. For
>>>> async-ioctl, completion is decoupled from submission. Submitter goes
>>>> back to its business without waiting for nvme-completion. When
>>>> nvme-completion arrives, it informs io-uring via the registered
>>>> completion-handler. But some ioctls may require updating certain
>>>> ioctl-specific fields which can be accessed only in context of the
>>>> submitter task. For that reason, NVMe driver uses task-work infra for
>>>> that ioctl-specific update. Since task-work is not exported, it cannot
>>>> be referenced when nvme is compiled as a module. Therefore, one of the
>>>> patch exports task-work API.
>>>>
>>>> Here goes example of usage (pseudo-code).
>>>> Actual nvme-cli source, modified to issue all ioctls via this opcode
>>>> is present at-
>>>> https://github.com/joshkan/nvme-cli/commit/a008a733f24ab5593e7874cfbc69ee04e88068c5
>>>
>>> see https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-fops
>>>
>>> Looks like good time to bring that branch/discussion back
>>
>> a bit more context:
>> https://github.com/axboe/liburing/issues/270
> 
> Thanks, it looked good. It seems key differences (compared to
> uring-patch that I posted) are -
> 1. using file-operation instead of block-dev operation.

Right, it's meant to span wider than just block devices.

> 2. repurpose the sqe memory for ioctl-cmd. If an application does
> ioctl with <=40 bytes of cmd, it does not have to allocate ioctl-cmd.
> That's nifty. We still need to support passing larger-cmd (e.g.
> nvme-passthru ioctl takes 72 bytes) but that shouldn't get too
> difficult I suppose.

It's actually 48 bytes in the as-posted version, and I've bumped it to
56 bytes in the latest branch. So not quite enough for everything,
nothing ever will be, but should work for a lot of cases without
requiring per-command allocations just for the actual command.

> And for some ioctls, driver may still need to use task-work to update
> the user-space pointers (embedded in uring/ioctl cmd) during
> completion.
> 
> @Jens - will it be fine if I start looking at plumbing nvme-part of
> this series on top of your work?

Sure, go ahead. Just beware that things are still changing, so you might
have to adapt it a few times. It's still early days, but I do think
that's the way forward in providing controlled access to what is
basically async ioctls.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
