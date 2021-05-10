Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACF7C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 09:31:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5BBC6161F
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 09:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BBC6161F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=N7+CtV36PODJkRpXLo/jFofM81EktHGwFSH5I5dM/wk=; b=JLzNURXeadAKnOwS9kboJ7lUd
	I4Qe2VHAX5sS2zKvNv6Z4zdkJfmDj63UVjAnzUQiGxMvYfXpAPWaFh6gQc8CNsfdSR0c12Di7PVIX
	Uc304bi51F18XbkI6B5w0yeS1ScBR6DlAgNve0nd/pVQCmM72IuoM4dCW8QnP3IDZMUIYx1ZURdVL
	hKu5wemNScKhhM3ZROGeXtUYhdNxAC2zfFcuL96kZlvn5lCDrJbaFDCeKV+puTdlFblBCGs0R4ht1
	MNBdm27G7FtUvI60K4dupZ40V6TQ3QM4WGoMVCe+821DazeMHXsQ2K6QJmOqX7TzNG59osMj8cZOJ
	D0xPy9uqw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgOih-00GhUp-Oc; Tue, 11 May 2021 09:30:27 +0000
Received: from [2607:7c80:54:e::133] (helo=bombadil.infradead.org)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgD89-00FjG1-Gb
 for linux-nvme@desiato.infradead.org; Mon, 10 May 2021 21:08:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=9u4kw2qYhyzstNdIdGlasIcH7CfUy1l5kwZ9LlKv060=; b=l8pSmt9PWUgDOIq+2k8UYREL0D
 Hs1heBfhHl0mPnpD+SbZjMU8njuiDCItJDp+JQK4O4C6MLkqqrrPYbw1d3LP3VYXkBbPNL2UYCf8U
 gtYEwKhjYgLKBsxuT9hOj2mUIinqtDfLMaI2FlF3zI++IihsV8/nIJb891FM2rkM4ptpQbco/6pzK
 VGexHO7D47lEAcmT4C6aBhEvqTePd+0YZ/urSddSJdfoW153iAvckV06hgZoxORjLvZpOH5/2uvBb
 3tOpnQlAHC/AGS8xKYKOH38QjMjVbOlsaSqRaaZJ1RbrpFGyASMTHOx72JAXVcp+cf0Vsr8kPMdNz
 F7yvckNg==;
Received: from mail-pg1-f169.google.com ([209.85.215.169])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgD84-0097h8-3v
 for linux-nvme@lists.infradead.org; Mon, 10 May 2021 21:07:53 +0000
Received: by mail-pg1-f169.google.com with SMTP id m190so14271406pga.2
 for <linux-nvme@lists.infradead.org>; Mon, 10 May 2021 14:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9u4kw2qYhyzstNdIdGlasIcH7CfUy1l5kwZ9LlKv060=;
 b=cZ2FpBKykJb8wCBuugTZXF29lt1eQ6CuWV7UeAr4IEjXTKGBDz9CCEA8RxeNvi/2rS
 +OEgGD4VsJ4hf3dUbNUEQ+3wRTTOMnbnYm5rNUTOUa2Tj73H40UA6Lu/SM6Z7DM/+MlW
 Z7t7VZOvgRQuJp4Z7REeLOAQZF4LxgztHisgWhkuEuaLO2zcFRkaB+Rd3TM7Rco5S9My
 qF5Sqx6pQxIJKza5lZEXWEPh0zMMPY0PeRa3b1D0T2/OA6Prptx6mCuJn+nQUCt3dOXj
 qVn5KLASbeNNP005MkG7bDt+v22c6AzbMvoW5866Xz4sgTjg92cUGUg3tpKWRUKOCqi1
 ja1A==
X-Gm-Message-State: AOAM532II+J32nZ6LhsV5X0jSa7pYm49gXrSGfkCyx+fHM9sw2mrHS95
 ybWq+cIFpqNngOZUeH4yLeJfcWwBkVo=
X-Google-Smtp-Source: ABdhPJwHviEmCJkPOECvVxNapEcprl9Y3sKh4iRX3rH0rY/s+6P9zpiJUDuZ4b7LrDH9KegjpzxUSg==
X-Received: by 2002:a63:2542:: with SMTP id l63mr28280361pgl.128.1620680869736; 
 Mon, 10 May 2021 14:07:49 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:1522:1d2e:7c9d:185c?
 ([2601:647:4802:9070:1522:1d2e:7c9d:185c])
 by smtp.gmail.com with ESMTPSA id n11sm11864140pfu.121.2021.05.10.14.07.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 May 2021 14:07:49 -0700 (PDT)
Subject: Re: nvme tcp receive errors
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <20210503142848.GB910137@dhcp-10-100-145-180.wdc.com>
 <8932c0f7-1d9d-90a0-dd9d-32ba43d03d76@grimberg.me>
 <bd69eafa-9f1d-4cdf-f1b5-8b71ffd78917@grimberg.me>
 <20210503194404.GA910455@dhcp-10-100-145-180.wdc.com>
 <ba05ff5a-b6bd-b6e4-a96b-fb9ee4e01f66@grimberg.me>
 <20210504143633.GC910455@dhcp-10-100-145-180.wdc.com>
 <76a715f5-6a37-8535-3fbe-1aa0f3a54dbc@grimberg.me>
 <20210504191441.GA911866@dhcp-10-100-145-180.wdc.com>
 <20210510180633.GB1857448@dhcp-10-100-145-180.wdc.com>
 <6838b8da-7e05-a08d-b67f-1fe28b0d880b@grimberg.me>
 <20210510183040.GC1857448@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9a6fed85-2f8b-8398-1e8b-cd44e6004f40@grimberg.me>
Date: Mon, 10 May 2021 14:07:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210510183040.GC1857448@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_140752_197377_92ABEBD0 
X-CRM114-Status: GOOD (  29.12  )
/bin/ln: failed to access
 'reaver_cache/texts/20210510_140752_197377_92ABEBD0': No such file or
 directory
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_140752_197377_92ABEBD0 
X-CRM114-Status: GOOD (  24.18  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Sagi,
>>>
>>> Just wanted to give you an update on where we're at with this.
>>>
>>> All tests run with your earlier patch removing the inline dispatch from
>>> nvme_tcp_queue_request() are successful. At this point, I am leaning to
>>> remove that optimization from mainline.
>>
>> Thanks Keith,
>>
>> Did you run it with the extra information debug patch I sent you? What
>> I'm concerned about is that given that you have the only environment
>> where this reproduces, and this is removed it will be very difficult
>> to add it back in.
>>
>> Also, what about the read issue? that one is still unresolved from
>> my PoV.
> 
> The test team reports no issues for both read and write tests with the
> inline dispatch removed. That single patch appears to resolve all
> problems. Sorry, I should have clarified that initially.
> 
> We will go back to the extra debug from last week on top of a pristine
> mainline kernel. There's been some confusion of which patches to apply
> on top of others in the mix, but I'm getting better at coordinating
> that.

Keith,

I may have a theory to this issue. I think that the problem is in
cases where we send commands with data to the controller and then in
nvme_tcp_send_data between the last successful kernel_sendpage
and before nvme_tcp_advance_req, the controller sends back a successful
completion.

If that is the case, then the completion path could be triggered,
the tag would be reused, triggering a new .queue_rq, setting again
the req.iter with the new bio params (all is not taken by the
send_mutex) and then the send context would call nvme_tcp_advance_req
progressing the req.iter with the former sent bytes... And given that
the req.iter is used for reads/writes, it is possible that it can
explain both issues.

While this is not easy to trigger, there is nothing I think that
can prevent that. The driver used to have a single context that
would do both send and recv so this could not have happened, but
now that we added the .queue_rq send context, I guess this can
indeed confuse the driver.

There are 3 possible options to resolve this:
1. Never touch the command after the last send (only advance the
request iter after we check if we are done):
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c51b70aec6dd..5c576eda5ba1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -933,7 +933,6 @@ static int nvme_tcp_try_send_data(struct 
nvme_tcp_request *req)
                 if (ret <= 0)
                         return ret;

-               nvme_tcp_advance_req(req, ret);
                 if (queue->data_digest)
                         nvme_tcp_ddgst_update(queue->snd_hash, page,
                                         offset, ret);
@@ -950,6 +949,7 @@ static int nvme_tcp_try_send_data(struct 
nvme_tcp_request *req)
                         }
                         return 1;
                 }
+               nvme_tcp_advance_req(req, ret);
         }
         return -EAGAIN;
  }
--

2. only initialize the request/cmd/pdu (nvme_tcp_setup_cmd_pdu)
when we have taken the send_mutex (say in nvme_tcp_fetch_request
or something), which is more cumbersome as this stuff may be
called multiple times in the life of a request.

3. Add refcounting to never complete an I/O before both send
and receive has fully completed on this command, besides having some
more overhead on the datapath, there maybe also some challanges with
moving the request state machine that may be based on the refounting.

I suggest that you guys give (1) a shot and see if the theory holds...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
