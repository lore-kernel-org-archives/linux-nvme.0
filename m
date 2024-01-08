Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCA8C3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jan 2024 17:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JVBLuH6KLV50/kT4mCamB9potsQo1JHVj8HELfpksxk=; b=4xyNJEVb3ReqWPiAHYGKbludca
	3l4CCgEa2mui6PzjdihSdTGv0ijGg0hsTqOrCV37dIMJ9gKTpbPsEUiMgzu/fc3jI8+NPpfR8bqx+
	zG2dAQIps7z1vpBi/YlmhfO9Rolq6JRWbEW5ZkRlZyx6NtdUEzQ5mBE5wyvnyTl7NnKkNGQT9kUvw
	3AhLxVZVRuJE295kztSk9KvlxQmT/KtbmHk9+41OGswlSWA26gQG+Jka3UFs9TJUxpVeEC7Vfl06N
	zXQSkQZ6dP5x6vRX2Mu0yEtsi9W2kQpBtwWjKGVnZOlyW48WuqB8UGSxRAYgfnjm4cNwY0Zf4iCsu
	IGHp644g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMtdj-005mUm-1O;
	Mon, 08 Jan 2024 17:42:19 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMtdg-005mTI-0v
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jan 2024 17:42:17 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d5a733823so3387695e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 08 Jan 2024 09:42:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704735732; x=1705340532;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVBLuH6KLV50/kT4mCamB9potsQo1JHVj8HELfpksxk=;
        b=tBNIE3GhMf674Ru81xupp7KKkwm6iDG8unJfSxZx42/S7kb+bgsoZ4AcfiAMmt+QVm
         nrCkOFZh6zFJUie/e1ilpzB0mSWy+pS/SUbQiZHLpVGFxIuD7GmsV9j6xOGy2aic0NZ6
         pdp8tVxvMk6Vwq56iiXiyU+5JBsp4Ig98P3gYMFsCo9G3KZ5hGHcQ1bxr9T20nFdGBLY
         MMoYNoiX3FxSKA4mWJ6AYjPTKILEVpCWDgwwLYkvw/ZJ3r5GXZrdX4FmFNuD0PQEnCVq
         xN3ZGBUmRruK+CcI0JlEEYlkzB1h8H+Rl2BhCe/F/CLHJ494U1U6ZyJ419WhzuKCp0fT
         t8dw==
X-Gm-Message-State: AOJu0YzPzifePoum8yhmMnasMOD59emIBvm7zHKvh6qU9UzVphlt93Pg
	2M0J7p1rf8zUu+jcyAEUsjQ=
X-Google-Smtp-Source: AGHT+IF33jil/SaRB/KWZKuTcc0TUkT0UwGyiLkQfQYK09evURSimatVt+yZtx2dTEOGAfRnwQ+UEw==
X-Received: by 2002:adf:9d90:0:b0:337:3cf6:ed4c with SMTP id p16-20020adf9d90000000b003373cf6ed4cmr4139573wre.4.1704735731694;
        Mon, 08 Jan 2024 09:42:11 -0800 (PST)
Received: from [10.100.102.14] (46-117-114-124.bb.netvision.net.il. [46.117.114.124])
        by smtp.gmail.com with ESMTPSA id j12-20020adfe50c000000b00336710ddea0sm211158wrm.59.2024.01.08.09.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 09:42:11 -0800 (PST)
Message-ID: <989ca551-865c-44fc-87b0-1401b43afcb3@grimberg.me>
Date: Mon, 8 Jan 2024 19:42:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] nvme: Change 'bool shutdown' into an enum
 shutdown_type.
Content-Language: en-US
To: Jeremy Allison <jra@samba.org>, Jeremy Allison <jallison@ciq.com>,
 tansuresh@google.com, hch@lst.de, gregkh@linuxfoundation.org,
 rafael@kernel.org, bhelgaas@google.com, linux-nvme@lists.infradead.org
References: <20240103210405.3593499-1-jallison@ciq.com>
 <20240103210405.3593499-4-jallison@ciq.com>
 <4486c671-af66-4466-bfca-e184584d884b@grimberg.me>
 <ZZbuQsCg6jXMjl2u@jeremy-HP-Z840-Workstation>
 <ZZb8lvXz0sEiy6Dz@jeremy-HP-Z840-Workstation>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZZb8lvXz0sEiy6Dz@jeremy-HP-Z840-Workstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240108_094216_331562_67DD7DA3 
X-CRM114-Status: GOOD (  29.10  )
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



On 1/4/24 20:44, Jeremy Allison wrote:
> On Thu, Jan 04, 2024 at 09:43:30AM -0800, Jeremy Allison wrote:
>> On Thu, Jan 04, 2024 at 03:26:11PM +0200, Sagi Grimberg wrote:
>>>
>>>
>>> On 1/3/24 23:04, Jeremy Allison wrote:
>>>> Convert nvme_disable_ctrl() and nvme_dev_disable()
>>>> inside drivers/nvme/host/pci.c to use this:
>>>>
>>>> bool shutdown = false == NVME_DISABLE_RESET
>>>> bool shutdown = true == NVME_DISABLE_SHUTDOWN_SYNC.
>>>>
>>>> This will make it easier to add a third request later:
>>>> NVME_DISABLE_SHUTDOWN_ASNYC
>>>>
>>>> As nvme_disable_ctrl() is used outside of drivers/nvme/host/pci.c,
>>>> convert the callers of nvme_disable_ctrl() to this convention too.
>>>>
>>>> Signed-off-by: Jeremy Allison <jallison@ciq.com>
>>>> ---
>>>> drivers/nvme/host/apple.c  |  4 ++--
>>>> drivers/nvme/host/core.c   |  6 +++---
>>>> drivers/nvme/host/nvme.h   |  7 +++++-
>>>> drivers/nvme/host/pci.c    | 44 +++++++++++++++++++-------------------
>>>> drivers/nvme/host/rdma.c   |  3 ++-
>>>> drivers/nvme/host/tcp.c    |  3 ++-
>>>> drivers/nvme/target/loop.c |  2 +-
>>>> 7 files changed, 38 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
>>>> index 596bb11eeba5..764639ede41d 100644
>>>> --- a/drivers/nvme/host/apple.c
>>>> +++ b/drivers/nvme/host/apple.c
>>>> @@ -844,8 +844,8 @@ static void apple_nvme_disable(struct apple_nvme 
>>>> *anv, bool shutdown)
>>>>          * NVMe disabled state, after a clean shutdown).
>>>>          */
>>>>         if (shutdown)
>>>> -            nvme_disable_ctrl(&anv->ctrl, shutdown);
>>>> -        nvme_disable_ctrl(&anv->ctrl, false);
>>>> +            nvme_disable_ctrl(&anv->ctrl, NVME_DISABLE_SHUTDOWN_SYNC);
>>>> +        nvme_disable_ctrl(&anv->ctrl, NVME_DISABLE_RESET);
>>>>     }
>>>>     WRITE_ONCE(anv->ioq.enabled, false);
>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>> index 50818dbcfa1a..e1b2facb7d6a 100644
>>>> --- a/drivers/nvme/host/core.c
>>>> +++ b/drivers/nvme/host/core.c
>>>> @@ -2219,12 +2219,12 @@ static int nvme_wait_ready(struct nvme_ctrl 
>>>> *ctrl, u32 mask, u32 val,
>>>>     return ret;
>>>> }
>>>> -int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
>>>> +int nvme_disable_ctrl(struct nvme_ctrl *ctrl, enum shutdown_type 
>>>> shutdown_type)
>>>> {
>>>>     int ret;
>>>>     ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
>>>> -    if (shutdown)
>>>> +    if (shutdown_type == NVME_DISABLE_SHUTDOWN_SYNC)
>>>>         ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
>>>>     else
>>>>         ctrl->ctrl_config &= ~NVME_CC_ENABLE;
>>>> @@ -2233,7 +2233,7 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, 
>>>> bool shutdown)
>>>>     if (ret)
>>>>         return ret;
>>>> -    if (shutdown) {
>>>> +    if (shutdown_type == NVME_DISABLE_SHUTDOWN_SYNC) {
>>>>         return nvme_wait_ready(ctrl, NVME_CSTS_SHST_MASK,
>>>>                        NVME_CSTS_SHST_CMPLT,
>>>>                        ctrl->shutdown_timeout, "shutdown");
>>>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>>>> index 6092cc361837..1a748640f2fb 100644
>>>> --- a/drivers/nvme/host/nvme.h
>>>> +++ b/drivers/nvme/host/nvme.h
>>>> @@ -187,6 +187,11 @@ enum {
>>>>     NVME_MPATH_IO_STATS        = (1 << 2),
>>>> };
>>>> +enum shutdown_type {
>>>> +    NVME_DISABLE_RESET = 0,
>>>> +    NVME_DISABLE_SHUTDOWN_SYNC = 1
>>>> +};
>>>
>>> I also don't find this a bit awkward especially when another
>>> enumeration value is added later on.
>>>
>>> An alternative approach would be to stick with nvme_disable_ctrl that
>>> accepts shutdown bool, and add nvme_disable_ctrl_nowait() wrapper for it
>>> that call-sites can use. Or even better, because we only have a nowait
>>> variant for shutdown, perhaps we can add nvme_shutdown_ctrl_nowait()
>>> wrapper that accepts only the ctrl instead (this will require splitting
>>> nvme_disable_ctrl to the disabling phase and the waiting phase, but that
>>> is hidden in the core as static functions).
>>
>> OK. Let me take a look at this. It would certainly remove the
>> changes in unrelated files such as drivers/nvme/host/apple.c,
>> drivers/nvme/host/tcp.c and drivers/nvme/target/loop.c.
>>
>> This change might take me a little longer to get right, so
>> please bear with me.
> 
> Yeah, the tricky part is that call chain for nvme_shutdown()
> looks like (inside drivers/nvme/host/pci.c):
> 
> nvme_shutdown() ->
>      nvme_disable_prepare_reset() ->
>          nvme_dev_disable() ->
>              nvme_disable_ctrl()
> 
> Adding a new function nvme_shutdown_ctrl_nowait()
> that sets the bit without waiting is trivial, but
> the problem is nvme_dev_disable() does a lot of
> things before calling nvme_disable_ctrl() which
> obviously should not be duplicated in a separate
> "twopass" code path.

Ugh.

> 
> There needs to be some way to pass a use
> "two-pass" flag down from nvme_shutdown()
> into nvme_dev_disable()
Ideally nvme_dev_disable can be broken in a way that
nvme_shutdown can have 2-3 helpers and the rest of the
code can remain intact calling nvme_dev_disable (internally
calling these helpers).

> 
> I guess I could add a second bool flag passed
> down from nvme_shutdown() all the way to
> nvme_dev_disable(), which then calls the
> nvme_shutdown_ctrl_nowait() varient instead
> of nvme_disable_ctrl() if both "bool shutdown"
> and "bool twopass" are set but that seems kind
> of ugly and confusing to me.

Probably.. Maybe call it dontwait (bool).
And yes, it is ugly, but better than moving the
ugliness to the core.

> 
> How about keeping the enum internal to
> drivers/nvme/host/pci.c
> and making it:
> 
> enum shutdown_type {
>      NVME_DISABLE_RESET,
>      NVME_DISABLE_SHUTDOWN,
>      NVME_DISABLE_SHUTDOWN_TWOPASS
> };

NVME_PCI_

> 
> and changing 'bool shutdown' to enum shutdown_type
> inside the static functions nvme_disable_prepare_reset()
> and nvme_dev_disable() only ?
> 
> That way we don't have to have the confusing
> double bool:

Neither are great. I'll defer to Keith and Christoph on this one.

