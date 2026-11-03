Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4811606A332
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ooumfc3D;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jy8+sq2w
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=R+3LXC/kAAN0pkfEywpZQiY0T08sQdAAVwXMi0BkDg0=; b=Ooumfc3D+W3f86
	PXHtQHMp7rACkr1UHGenLsLHB1EwwRFl3wltjOgWxDfazvmsT4HeJtGb1iR1z5IiSjtG0Uhwb5kQD
	w6hnUNS/hs3lrVh6+omojqMdOLnC7H+fM1gUt82i4czIpQlsqUAcQ+E0P+tTfTT1ATAYk7/8eYUxO
	zbQ+xphEXAwwxaVzbiKS8XKLaO0Q9OY6JM1cn9HosHnUpeDPlgbYgGgo0cJUgtUrLZPgJfYcziQuZ
	yMFPk6dqF0gmeos33MNeHBmLDiDRqZODE2miYslplPl01pCTgvQCRJddsbGHHZMkUhSkbL98XPusA
	AVcg+KIjsMIbFnuUyPcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOKfn-00000003aP4-3qbt;
	Tue, 03 Nov 2026 19:59:59 +0000
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOKfk-00000003aOj-2Onz
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 19:59:58 +0000
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-475920b9ca2so20007fac.1
        for <linux-nvme@lists.infradead.org>; Tue, 03 Nov 2026 11:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793735995; x=1794340795; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R+3LXC/kAAN0pkfEywpZQiY0T08sQdAAVwXMi0BkDg0=;
        b=jy8+sq2wnTACZczmPBRLv1uLhOPMjER+IfDZCqC4KIcW+h4FKfzy+RVDgAEGgErIdg
         FAUjyjEnhOWeEXIpHmWCu/7HHFNMlgtP2d5Sfrk8KK78JUSkMmA/gLCNNoFG8B69vMXN
         bpV0K2ql9llag4Twp8y7fyQW/ADh/ha8MOIyS/4tlXZbpbUs7BdP6i7l1c1avyUngoyi
         iL6aWFGciRl8MYPSFPLQrv/u6/nXovfhHRboerefBQ8RoLrHUeOVKDuKfxIddLLgUiog
         TMH6LkgpjvTKxzxq8wNO4PJd5H/KjcKHZuKfChEOBbZO/7laTtunjFyCbn+95d9KTalX
         7aCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793735995; x=1794340795;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R+3LXC/kAAN0pkfEywpZQiY0T08sQdAAVwXMi0BkDg0=;
        b=Dm+IUtv25SB+sLos8kQX/Z3Y0wY9uqhZhqcZfyrmxVKmHcY915h9iXTzwaPxc7hLm0
         11hpKg5nMRvu4hf5zj+Zvl/4GIpVWvHBdqiJm3V1RvcahpC9XB+k8XMAXsoQPdmxfmj9
         2axDJkxBl6A+hUQ8IVBvIDcWEtje2ahlLQQByPwb+2BfRysoJ6070Zh9oJqJ5OkcQknc
         TFBmePQQmG0E5Id7cAjq8ZLSUgrgTkC5D7lhDEahwRoZsqBUOycMw8jNbNnBJvGs+Jfn
         a/acOo2QbpfOG31M4W6P/Hbn+Es//Qd1FvTJzwRzAZJywh79FNxQF7E6xCE6SiBVnfgX
         W/Ew==
X-Forwarded-Encrypted: i=1; AKwUvBxasb9sfge2m/6FTFiyvkgpmok/p3feUX9QVfMzU+sq8d2O89RnTEk20jTfDtR7XyBCvN1AWJDMiyzr@lists.infradead.org
X-Gm-Message-State: APuU4Z+mCnDpkf8knt12UwPLnVwvWhPqeOXaYcmyOKfuqCGIEqsvhfP/
	XoyzzsCIv8/0irtvUAi9kofA7XrltGyB27s1iMBv5T6Mycedly0HFSKRNavRmUH/CmI=
X-Gm-Gg: AYBFou2L3Llo5p9RdEXElyrf1oLNO8gSW/eCnDbcSJMLMu20cZhbNPv5b8CegrNqqL2
	JDtTtAMy6uowWwZsD5MH7aHvLTy71dRkcFIh6XDkhZer/enhgj53bvasVYmRVn2EdFoL3nl4/1o
	Owq/cvudgR4bRfSd+mJ+/lzSfUAq+GOjCy3UhOZo0Sq5lLxwW76I4d1M+MKtw235E9MKjdpEVti
	iPWORRze85MVRtYUnHJgnfjjCAlbGCFELE3sVsYGyzyjVmGOh5dMPvBwbVsj50SlXygg/RbU+1c
	fuQVOakOhuhBqbvUlhkXiz234Xkzc6JFTq7G9Q3HZCVYaY/IXOpiNmwZaqQ2Gq6wL4i1Of6pu/F
	q9iVUWs/r5EbMlwfWnrAGPaF2WvqvfsukAV7nZUljtwPHJBVXf8j6Y4hXjgz40uciDt7NBo3cKE
	U3N3Qx3+NJj1SVXlHa0+y4UqBe1O6rKNYJvTOXFQr1K++MKoram+0qib4taRPzMtbHsFqwJGUxa
	yn4MT9SxvhfdsjMjxSb6y2sq13WfZ8IStRhD3brtK75ZoWs5ziNKH1WONqONc+gXMJtrLkU+wcB
	3RwL87H+hHy9Z8kOFMqnu/ef9I8nFk69DT2OR957mknl8bFoiKK2MMUYraekveeThJfjk10/P5R
	/OORBWF3I
X-Received: by 2002:a05:6870:d208:b0:475:a112:126e with SMTP id 586e51a60fabf-4a90767d20emr9273826fac.27.1793735995301;
        Tue, 03 Nov 2026 11:59:55 -0800 (PST)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a95d970b9bsm5262679fac.8.2026.11.03.11.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 11:59:53 -0800 (PST)
Message-ID: <09701274-ad31-456a-9f62-9d0a3889957a@kernel.dk>
Date: Tue, 3 Nov 2026 12:59:50 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: reject completions for requests that are not in
 flight
To: Mauricio Faria de Oliveira <mfo@igalia.com>,
 Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chao Shi <coshi036@gmail.com>, kernel-dev@igalia.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261103-nvme-double-cmpl-uaf-blk-mq-v1-1-b10fea474423@igalia.com>
 <auo5a1kRTSWsAYtF@kbusch-mbp> <352cfcec6865cbf636a22442511f16b1@igalia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <352cfcec6865cbf636a22442511f16b1@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_115956_624141_F2DE3B80 
X-CRM114-Status: GOOD (  28.39  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 12:54 PM, Mauricio Faria de Oliveira wrote:
> On 2026-11-03 16:43, Keith Busch wrote:
>> On Tue, Nov 03, 2026 at 04:18:25PM -0300, Mauricio Faria de Oliveira wrote:
>>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>>> index 2d8f681079e85601a92624d196e77f1ba3ace34a..3ba0666da7be6a3de2e5f0fd50155af115b4e1f6 100644
>>> --- a/drivers/nvme/host/nvme.h
>>> +++ b/drivers/nvme/host/nvme.h
>>> @@ -708,6 +708,11 @@ static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
>>>  			tag, genctr, nvme_genctr_mask(nvme_req(rq)->genctr));
>>>  		return NULL;
>>>  	}
>>> +	if (unlikely(blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT)) {
>>> +		dev_err(nvme_req(rq)->ctrl->device,
>>> +			"completion for request %#x not in flight\n", tag);
>>> +		return NULL;
>>> +	}
>>>  	return rq;
>>>  }
>>
>> Is there something special about the NVMe protocol that makes this
>> problem unique to it? If not, why doesn't this check go into the generic
>> block layer instead?
> 
> Thanks for taking a look.
> 
> I noticed you asked the latter question in the previous
> submission/review (Link: trailers), and addressed it in the commit
> message; pasting it here for reference:
> 
> In Chao Shi's patch, there's been feedback/question of whether this
> should
> be done in blk-mq, as this is not specific to nvme. I'd say no, at
> first:
> - Some blk-mq calls for completion have no return value (e.g.,
> completion
>   on other CPUs), which suggests maybe an API change and updates to many
>   callers, all for an edge case.
> - An alternative available currently might be blk_mq_ops.complete(), but
>   that is handled in the driver anyway, with risk of hitting an error in
>   blk-mq (like this) as the code changes, and seems semantically wrong,
>   i.e., completing a request that should not have been completed.
> - Keeping in mind a small fix for stable, for now, should this be
> merged.
> - But happy to take suggestions if blk-mq is indeed the way to go.
> 
> For the former question, I'd imagine other block drivers might be
> subject to a similar issue, under incorrect completions, and can take a
> look at this later. I'd appreciate feedback on the points above before
> trying to address it generically in the block layer, if at all possible.

This is either a protocol problem, in which case the driver should
handle it. Or it's not a problem at all in the first place, and
this is some kind of misguided defensive programming. In which case
the patch should go away.

If this is possible because of a poor API in the kernel, then we
fix the poor API. We don't add silly work-arounds.

-- 
Jens Axboe


