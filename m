Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453E2E8FDD6
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Dec 2025 09:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jgcM212eZ5IZC+3tPshHf9Zv88sbBRWIfvekrW2A8FA=; b=M2G2DCyBaxGvIMPRmlBRf1qY3s
	Sr3GtVx2mFgDRPzkXLcazbMLb+pNLf73ttoafYuF14CMvrKUAZ6VZ8JTNTlYUrD04mt8MuytJAQXA
	JBGgBcCr/SI9r/24zIi/dohpp7HGabw36gw0IFz1jdwP/5zRxIy17Fg+IRXsie2AeUu+qVeCEdSzb
	/XHcUCu8/Nofa6yebvj7F78ltE8TERk8JsSNofdOKh+cb3HBSLLlTd5g9BQXvg6ys5YdmVLuUEFl0
	Ap0Zjfbnkod7VMkN+CfrUicnFrc5qk1sv45nQNBEE0FVWWLMGvr9jy35B0cf+4NNHeaYWutpHPrIv
	pjEDkJpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZQyT-00000001qA6-2ZHf;
	Sat, 27 Dec 2025 09:52:37 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZQyQ-00000001q9l-3pwj
	for linux-nvme@lists.infradead.org;
	Sat, 27 Dec 2025 09:52:36 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso75180805e9.3
        for <linux-nvme@lists.infradead.org>; Sat, 27 Dec 2025 01:52:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766829153; x=1767433953;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgcM212eZ5IZC+3tPshHf9Zv88sbBRWIfvekrW2A8FA=;
        b=g7GYNtpZiuxP0rKZdqfANEDdxIf1ljCMPnIzCnLu+jzB0HzM1e7azkjReXD6LnPrOv
         qCLLx3oFb3LiP4wbVg325YFTcKwjbcp2d1+TXYUm0mgrVoIfF2RATp9eZoGaeXx3MwsG
         F9fwZs1XjuRu6EtVqEObKDzUcrCXeVAVL65NpZamlCsOSRrmCDFjMPpqoFJlBtj4OPpm
         qALUq/fiIQUhHtbNcpw7lmkm7ZQOg+OJJTwQvASTK/cdbrpxqAyH1yoxFadNJmRNmrHE
         uB/2fFyLQEAYwlTmFgUx8yPMEmWYnimhUWYBqTLpp9Q3Q1qYcfxtW2gHQBiDUBVROzxg
         ng7g==
X-Forwarded-Encrypted: i=1; AJvYcCVnu3n1a9VhyVjDzPJ3SA3kNOdzOrRQJwWsX5qnfN9yp/tRdfSKfUI9cj+hGuj9lR0L6NUcgTyt018t@lists.infradead.org
X-Gm-Message-State: AOJu0Yyx2NNgoZuYbypUOqoskplaDfohAqdI5IBW9xYhstkitT6OnmAo
	N1zwJnVmP/IFhGqQsRU5x+m3zQjz8p/TciQjqMVPvBhX0eKpmwmejO7y
X-Gm-Gg: AY/fxX51kmHGjOYn1B0czEaazKhAdybiJgfcVVDUY8HykcjX7vbvM9TreEtmo4yqHAy
	56izDeI/Ob2fMYwhlRQYb5vuFxHRKskA8wmXR4nqgBkK/A+O2KP+9w5ttBqGxhL8hprPUsSpCee
	S2JJXHQpcvt7R+JQYq7/N7NKWGEMPMezM3fNDiaZkYVdiaXwWDXP3dY31nDiosWKVkjdxqDaPJf
	ag5T6sHLqU6QXsWkdNXTN6vbn8+g/2ocXNj2lkQLvZuCj5vSuFJQ9d2Srf/APKBEihFwX3WqV+s
	w++JiuGIOg8xU0+3zplkQ/7/VVbdSJ5R9sbQCHNN2YMEGnaBP/xJuoBTIxY0iZvONcVC2dyE8jc
	YNCEtc7l7Oa7x+IQEnbqVU7UnyCGe/HC358dFlsxAkGVTvkk8ccRz6y8YbByD7dtpxBoxeo000I
	o6yJTQXD95lheNBI1mIKcLxcU/mEBsPfpjU6EUorie6qM=
X-Google-Smtp-Source: AGHT+IGF+PTs3/0FBpyzP5pmpET5EtAb9pJL2wZUN/njQ8yeMyhfKj/upxx48WTYQBlPxLJB65Ct5g==
X-Received: by 2002:a05:600c:6388:b0:477:639d:bca2 with SMTP id 5b1f17b1804b1-47d1956ec01mr262967525e9.4.1766829152922;
        Sat, 27 Dec 2025 01:52:32 -0800 (PST)
Received: from [10.100.102.74] (89-138-76-94.bb.netvision.net.il. [89.138.76.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b0d5asm490675175e9.13.2025.12.27.01.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 01:52:32 -0800 (PST)
Message-ID: <fc33dcfe-244c-412a-ab06-a554a66ada1b@grimberg.me>
Date: Sat, 27 Dec 2025 11:52:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/14] nvme: Add RECOVERING nvme controller state
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, John Meneghini
 <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-8-mkhalfella@purestorage.com>
 <e9bb2664-9d96-45f0-a39d-6deaad0829e9@grimberg.me>
 <20251225171709.GA8129-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251225171709.GA8129-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_015235_040264_A3BA07B8 
X-CRM114-Status: GOOD (  18.67  )
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



On 25/12/2025 19:17, Mohamed Khalfella wrote:
> On Thu 2025-12-25 15:29:52 +0200, Sagi Grimberg wrote:
>>
>> On 26/11/2025 4:11, Mohamed Khalfella wrote:
>>> Add NVME_CTRL_RECOVERING as a new controller state to be used when
>>> impacted controller is being recovered. A LIVE controller enters
>>> RECOVERING state when an IO error is encountered. While recovering
>>> inflight IOs will not be canceled if they timeout. These IOs will be
>>> canceled after recovery finishes. Also, while recovering a controller
>>> can not be reset or deleted. This is intentional because reset or delete
>>> will result in canceling inflight IOs. When recovery finishes, the
>>> impacted controller transitions from RECOVERING state to RESETTING state.
>>> Reset codepath takes care of queues teardown and inflight requests
>>> cancellation.
>> Is RECOVERING really capturing the nature of this state? Maybe RESETTLING?
>> or QUIESCING?
> Naming is hard. QUIESCING sounds better, I will renaming it to
> QUIESCING.
>
>>> Note, there is no transition from RECOVERING to RESETTING added to
>>> nvme_change_ctrl_state(). The reason is that user should not be allowed
>>> to reset or delete a controller that is being recovered.
>>>
>>> Add NVME_CTRL_RECOVERED controller flag. This flag is set on a controller
>>> about to schedule delayed work for time based recovery.
>>>
>>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>>> ---
>>>    drivers/nvme/host/core.c  | 10 ++++++++++
>>>    drivers/nvme/host/nvme.h  |  2 ++
>>>    drivers/nvme/host/sysfs.c |  1 +
>>>    3 files changed, 13 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index aa007a7b9606..f5b84bc327d3 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -574,6 +574,15 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>>>    			break;
>>>    		}
>>>    		break;
>>> +	case NVME_CTRL_RECOVERING:
>>> +		switch (old_state) {
>>> +		case NVME_CTRL_LIVE:
>>> +			changed = true;
>>> +			fallthrough;
>>> +		default:
>>> +			break;
>>> +		}
>>> +		break;
>> That is a strange transition...
> Why is it strange?
>
> We transition to RECOVERING state only if controller is LIVE. This is
> when we expect to have inflight user IOs to be quiesced by CCR. We do
> not care about inflight requests in other states.

Sorry, got confused myself - I read it as the other way around...
I am missing RECOVERING -> RESETTING transition in this patch.

