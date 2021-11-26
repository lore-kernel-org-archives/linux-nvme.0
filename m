Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1C1C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Nov 2021 18:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w7CM3ybXkX6FdnmkDgtC04LvePrjVXFwUyZ4uxrkvxw=; b=fGs9CBl+nfnBtA8RJOgOgfa2HA
	EmDJw7gtQCW7JXv9/jHXbs7Jiv7oexWzYBH1dqlwbd8dPmWAx5Of+rI8uh8j3SuoQTMYGQ1TjBiuf
	oFBsmscak5m4yvFcudLYMDSNCjOuqfbaGc7dUdueRir73MdcwzvFF0Q2WkRwevAM7r738mcUqKjuU
	IFhw11KUapO30UGD4ENh/SJ05ILqMg7CqvT8VKEyTIdAYFrRuXvhWGTssCSPdwSNncgCoB8k6TBo9
	AHy8ec4uRp3ULfvX/pP3L4g7LLHp0De75zGPIL0tCnjS/XUyBOV8uubScZKcE15TU0M9FOavBKqtD
	/LhrzObg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mqfft-00BS8V-Ap; Fri, 26 Nov 2021 18:10:17 +0000
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mqffo-00BS6d-DY
 for linux-nvme@lists.infradead.org; Fri, 26 Nov 2021 18:10:14 +0000
Received: by mail-io1-xd2a.google.com with SMTP id x10so12413079ioj.9
 for <linux-nvme@lists.infradead.org>; Fri, 26 Nov 2021 10:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=w7CM3ybXkX6FdnmkDgtC04LvePrjVXFwUyZ4uxrkvxw=;
 b=P8Ix0b+8pqLzJ0JCQMU2IsK8LUujjsUrb3I7IY1MpjfctmRfdlJ4p5tQIRJzkm1aOz
 NEkeOe/Fpw0bltwzcwIBsjrvsMFs+atSgWqaJBoi1ve+1El4o+XCYCZk7ONPmcUPhr0Q
 VY2Y363OEpPx+MVKPTIo7svhG2nMbqSLtYfjGO7290AYp504mY/rhBkFJqwLmxNGmdCC
 IR6hV7/8/Ng6R2bTvHJ81I08OFXyRyKS6gBHjJKWfVSk5khiZDKwJlCNGwfwUBkXrYO0
 yr6CtDeMftUyZMd+0437LW51xaN8/Ora/MppBtTIvenEiWXu06d1T0X1om2tC4k/M9DP
 NNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w7CM3ybXkX6FdnmkDgtC04LvePrjVXFwUyZ4uxrkvxw=;
 b=yz9/DGZbAVwjBzx9fKNCaxx1pQ3UMf7zQhrPsHxUs3RzJ36OSwzQlwZ+2kY+MOEYDh
 tkAGUdtnnucV6AtCSUi1mPPvyFiJStH8nIeT230Uo0EAt6IOjb+Xsf8UV8iHeCKUUV0d
 l2z1Hb4oOYVvDvGfTIGbyHm7Bv9sXfyNklJes+Sv1+CILtwlvqezQnnUyMGDcIEb1gVo
 /dcd7VQJhJ7euCW9Ubse3ZbU9Oz5m+O1uFF3HiRAHnifJ8pyE6kz+fux4EpYH8P+i3Oc
 Xs6+zBEN2XpL+iq0Uar+ElvLVSH+rdAbQnavvBiofmZ0fxlOSr4pwI92GywQy8exZ/v7
 3NQA==
X-Gm-Message-State: AOAM533m+N0mSEwxL3Am1AwJTzLfKl5d0vGmoMtcVBh4K2lcsy9AJt7R
 qyt77Hib+Ry5FzHl36fc5kR3Sw==
X-Google-Smtp-Source: ABdhPJxGCB354MvIlJjaIRBZzlJPUUDQyfSJlCoz2hhDCkTQKLQVSnsDHVTgVFm+cuSMnozo2m/8Xw==
X-Received: by 2002:a05:6638:3014:: with SMTP id
 r20mr20589348jak.146.1637950211126; 
 Fri, 26 Nov 2021 10:10:11 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id d137sm3510617iof.16.2021.11.26.10.10.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Nov 2021 10:10:10 -0800 (PST)
Subject: Re: Write I/O queue hangup at random on recent Linus' kernels
To: "Kenneth R. Crudup" <kenny@panix.com>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-nvme@lists.infradead.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
 <b9c2681f-e63a-4d3b-913d-d8a75e2c2ea0@kernel.dk>
 <be6a783-97db-c3bf-b16f-e8c62b14755d@panix.com>
 <17206ea6-506d-b1de-09e8-c935ff308bd6@kernel.dk>
 <903be817-4118-f34e-1b35-a0108045590f@kernel.dk>
 <986e942b-d430-783b-5b1c-4525d4a94e48@panix.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ddc41b84-c414-006a-0840-250281caf1e5@kernel.dk>
Date: Fri, 26 Nov 2021 11:10:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <986e942b-d430-783b-5b1c-4525d4a94e48@panix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211126_101012_646727_90AA853F 
X-CRM114-Status: GOOD (  15.58  )
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

On 11/26/21 10:58 AM, Kenneth R. Crudup wrote:
> 
> On Fri, 26 Nov 2021, Jens Axboe wrote:
> 
>> Can you apply this on top of 5.16-rc2 or current -git and see if it fixes
>> it for you?
> 
> Since it's related to writeback throttling, is there anything I can try to
> taunt it? I was thinking "iozone" or "bonnie++", but if there's something
> better, let me know.

I'd just do what you usually do, that's usually the best way to gain
confidence in the fix. But it's related to writeback throttling _and_
racing with eg iostats grabbing a reference to the request, so it would
be more likely to trigger with a heavier combination of those two.

That said, I'm pretty confident in the fix, so if you'd just use it for
a day or two, then with the previous amount of hangs you saw on -rc2 it
should provide a good level of confidence in it.

-- 
Jens Axboe


