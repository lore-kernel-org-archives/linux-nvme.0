Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A061C61DA3
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Mar 2023 23:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/VcIwlpbQjilMqeqGqNNvup9AAK4SHeZ6ZnkXd/39Dk=; b=nvFI0FPfGmNcSkORMVas+WuUKp
	O9rEfWmnpT9pL6pZZ5VFZMvHhjsRhbrv0uc3+pEjW2/PpX5u0/ULKWGhrbou7urCmMPeiWuUE+y9p
	4BXQiL9kEoC0dK6oN6BRrcvGdIbfGalj54Ykv+kFm0RjMEAME9wutVJMCmI8Rlk1QcdXO3tP27cQR
	zra2l5c/tY1G4sJP3/QnWJhdI9Qso5335ffWbK7Pl7ylvprJSBFBSVPWbl0JOlS80lki9rmpRzcEk
	Q5UUXLciJto6kAt44sOd0LgbRHX86WY0wB7wLMADAllL5iILv2CDpCyzrkM2/G/aC2whRwgYOrKb2
	dgljUXYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYEbD-007n0m-Am; Fri, 03 Mar 2023 23:14:03 +0000
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYEb7-007n0M-ID
	for linux-nvme@lists.infradead.org; Fri, 03 Mar 2023 23:13:58 +0000
Received: by mail-qv1-xf35.google.com with SMTP id y3so2854563qvn.4
        for <linux-nvme@lists.infradead.org>; Fri, 03 Mar 2023 15:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677885235;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/VcIwlpbQjilMqeqGqNNvup9AAK4SHeZ6ZnkXd/39Dk=;
        b=j+NyMeSQe0lHYQ/vJQJGds4oPEEaRhdRxhG/k0nxCpbWvzDpnXloyGJxCiY3jvdG2u
         VfkxMbyNiLSXmfhZxcn3P2hSd0Q1ai8/dw+CZHl0SbCVwDhdv+ZfaeMcqeBpIjkCYTJY
         ALSrtWKqu4rpepjYFY+bX1uYdbPWOVEL5b8YaTX6chgyY9UjTdl8Tji2mxAcgooA5Ufv
         6YJdTnUt+maBeWC7e/WY07RvWFbVxzL57pBYegwdKZ0TSSnsmL4dq8yPAkjnJamUPfY9
         Uqh3ObjEXt0EqXlPQ6Tt+LDh3beCFlltdRgOR1Nk3PHpeXipUaEF8odpKjeTjGLIYhKW
         /4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677885235;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/VcIwlpbQjilMqeqGqNNvup9AAK4SHeZ6ZnkXd/39Dk=;
        b=T5EyKbn5xgVObWCh0PP6WRrtBdA7RolqJMOkl665B2FMHWQ/W3G2E00ym0b73R9pi9
         LpEzaQChIanEDtSGpx48XnwOrTKWhDOlBSAHEF/QksFbtB7y7oll6Oj/DJcBEeRAmR08
         AArapfWQgbWDrYE91srrqlXPD+aNUvRcsleTinMn9IIWOIxBHAWjsFAA5YdN9ISyDfpe
         EABhs/Ot1zRTP+/TiP2Dtyi+PsO1dqmJWN3b+552nq61ZFdSCmtKr3q5qnFywIMJFyKv
         YUgbZKoa9+DP4V84vtMZmWZdQmShzbs/LzjWRtE5NFIMMlqndNGRLzyi4CtVVhkDcm9T
         SEzg==
X-Gm-Message-State: AO0yUKX0Y/iQPqTS4DOg2klCxaItvEYAJnklX0SIFxRoPXASNwqVo8z3
	B3NiijQ8/JoZzz2F5rWMfnI=
X-Google-Smtp-Source: AK7set/KyY/n/68rbQrofcVQDfFDrTPyGY3LWti+/AGRgZHhcQKwFrnqBQk0V61eq6JvY99e3UqY6g==
X-Received: by 2002:a05:6214:238e:b0:572:5a16:51c0 with SMTP id fw14-20020a056214238e00b005725a1651c0mr5543802qvb.16.1677885234924;
        Fri, 03 Mar 2023 15:13:54 -0800 (PST)
Received: from [10.69.46.142] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n67-20020a37bd46000000b0073ba2c4ee2esm2598497qkf.96.2023.03.03.15.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 15:13:54 -0800 (PST)
Message-ID: <e70f3b0c-5049-0bbe-fb13-41efc0425e0f@gmail.com>
Date: Fri, 3 Mar 2023 15:13:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC v1 0/3] Unifying fabrics drivers
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
References: <20230301082737.10021-1-dwagner@suse.de>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20230301082737.10021-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230303_151357_671991_63D35B62 
X-CRM114-Status: GOOD (  18.84  )
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

On 3/1/2023 12:27 AM, Daniel Wagner wrote:
> The two fabrics rdma and tcp share a lot of common code. This here is my attempt
> to consolidate the common code.
> 
> I've picked just one function (setup admin queue) for this RFC to get a feeling
> and feedback if this is a valid approach or if people hate it. I've left out fc
> for the time being because it differs too much two the other two drivers.
> 
> I've tested quickly tcp, rdma is only compile tested.
> 
> Daniel Wagner (3):
>    nvme-rdma: stream line queue functions arguments
>    nvme-rdma: factor rdma specific queue init code out
>    nvme-fabrics: move configure admin queue code to fabrics.c
> 
>   drivers/nvme/host/fabrics.c |  52 ++++++++++++++
>   drivers/nvme/host/fabrics.h |  12 ++++
>   drivers/nvme/host/nvme.h    |   3 +
>   drivers/nvme/host/rdma.c    | 132 +++++++++++++++++++-----------------
>   drivers/nvme/host/tcp.c     |  94 ++++++++-----------------
>   5 files changed, 165 insertions(+), 128 deletions(-)
> 

Initial reaction:
The resulting nvmf_configure_admin_queue() routine does look nice. 
However, I'm not sure the callback chain is all that easier to follow.

I guess I'm most disappointed that more of the logic isn't actually 
being commonized.

Examples:
alloc_queue():
   At least pass queue_size as an arg. I assume we should to match up
   with the fabric connect routine.
init_queue():
   I'd like to see setting of ctrl.max_segments/hw_sectors in the common
   code. Unfortunately, likely needs to be a fops call. At least it
   makes sure its done at the same point in controller creation.
start_queue():
   can't common code do the nvmf_connect_admin_queue() call ?
      If its too tied to the LIVE bit - then perhaps the queue LIVE
      bits should actually be getting set by the common code after
      the successful start_queue - or has routines transport can call
      from start/stop to set/clear it.
   If LIVE bit can be dealt with - this whole block in rdma/tcp moves to
   common code.

Also I'd really like to get rid of the "new" argument everywhere. It 
should just be a state flag set on the common ctrl.

I guess not bad, but not helping much (yet).

-- james


