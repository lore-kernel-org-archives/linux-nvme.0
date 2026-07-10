Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63071C44501
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2026 09:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oDtdeILJ2peez8AaokzA3pC4nRgV4ywb3bIoJcx7oEM=; b=sEoBCs7bzId/aaJxZRp1geSn7Q
	5d+nnXYm1DKTD4JYoneLmXUWHicCaOnE0vB6TNcboa/QEXmbMM3JTO/KwCbZRX2zMIqTjHQ4EnOTP
	QF+YIPTLMHkET95U1kLAICIS/UkNswk27IJCbbpYbQGTHWt0bX9c3+oJlvn4UmcqUID79JfEzJ79W
	dCMB9aWafvuUutP2dte3500+cD1+ED3g2yDeErO+FLM4TVeZQ15D7F59Y4x5jbHg5sjr5MNshpFAZ
	63dsmT9/Qg+n3ar5QEXlC4o3kIrAGT3gNvR9jrUzdDG1N88Fk6GBwB730E1aqjJkzXGFkGXnb3n2s
	N5+jG/rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi7Pt-00000004YSL-2tQc;
	Fri, 10 Jul 2026 09:21:05 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi7Pr-00000004YRu-0mu0
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jul 2026 09:21:04 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-381065a7a03so709603a91.0
        for <linux-nvme@lists.infradead.org>; Fri, 10 Jul 2026 02:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783675262; x=1784280062; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oDtdeILJ2peez8AaokzA3pC4nRgV4ywb3bIoJcx7oEM=;
        b=s3VLsFYh+QUXX3Rev7PXdAR21wD9dlisYWONnWfm/+6VWlBQVAy7OQLUu6KeAo8eC2
         qz6RcJhXfP0aOxqEAD/AnutkuYBcUinmx8XkEEheAYGbSepvKU6jseQ9jdOQP+syEzQQ
         nDyTg6AQ90p+QMgtIj8PxGZ3jCv+Pw18QS7c2PtOtUlJITlP4bdYABEhWaQfIuhvp5Pj
         7xgBk3wcWBo0aIjx/UPeEKxVmupXV6CRqhIYRN/x2WI0b1WAvJH8QxDnbzxx4uXdyD6x
         UtfE7a4bhURXqGF9JAmWRFqHtsbp/1iEk0Sm+OOm3lX2e5GmbelAQBH5zAaM2W0P6hAr
         m92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783675262; x=1784280062;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oDtdeILJ2peez8AaokzA3pC4nRgV4ywb3bIoJcx7oEM=;
        b=Ow/8xIcV7urArN3ocuJdkrmvy9hfJcxznru35Btnhh+DpSwfUvDJyL36rricxHQ4+M
         nN/mByAf7jVoyzSh6abZptucz6L7j7+ChnFTf9MSWaiSahWCQv2eiae38WwQYiEfjmHU
         NKn1OWK2dcmPKDW8k9h73FsUFIlWSHrahW8VcS1MrSRcaRQ8w54rz/FDREhcmK+mr96a
         J2JPey4kdLDrFhVAu7crqYIckJrCQDP6rp7m4/Kn8+B0fLS5tLXUEKEzf1mPB36Wf+l1
         Nil0U9YPokb62J0n2Qe7hIbh2CRAR4nbCI9RpS5lImKv/2iVxlIP2VpbHHyCjKY0WYhi
         JZAw==
X-Forwarded-Encrypted: i=1; AHgh+RpAUT6J/F+okH9gcnvUiTfbbzV/QSaICVhbq/Lh5jovjWvi58XYXWfpCINoYelgzd32GbRu8/sKQOeh@lists.infradead.org
X-Gm-Message-State: AOJu0YykrcqTY/6wu0OQt3Wl4EhGnX6dTBQOkqAn9hnAP5SDiuzFrum3
	Tyk9VWETXXUgs/s2rFiFKfAbO7NBgJYy+yvoW5QYrPK0wQnwvTWprG3ooCQEbhU8
X-Gm-Gg: AfdE7cnIPmBaK3ntaIVtxJ7bpwe95kQmzfHRAQqRRqXQyBki0g620c+qzGC9iDCbD/g
	UGRCkKT3dz383kATmM95WOH6yFkjqEVjA4OHeB4UYVGCqKhAb4uWM/oaDapl6Avq1JSob83adUO
	z22fp0+wgZ9w9Bky0CPqnu3yRuUKTBKXHDPeXnlFWZC09jGUFauby+g1a/ll5t2c0UqwZCRjEQ5
	Kp+7ATtPEaDXQE95zTBI8CQaUBEKpwPqNkS8nAyIlv4W0BRuVaVwfP9vWrOPv7iTFV7Y6ucbYb6
	TLWoG6FRWbLyDpP5dNpVrnsZws2+oJTzKs91It2ZHx323dOUrqH350rI7WUxY8I0PLopfilzbaq
	DogyppCurPa0AZv2VrFEQ3CsBh6WvBLpyJrUHxvxNWhov7Rjj8KlNRkpcyy6eh0QAAh8GIDIDdd
	fmsA5/3MBLmFT7fSM9JMgOTiFwrIu/3ZGd
X-Received: by 2002:a17:90b:4cce:b0:37f:9ce0:af32 with SMTP id 98e67ed59e1d1-389421ac479mr11356288a91.29.1783675261731;
        Fri, 10 Jul 2026 02:21:01 -0700 (PDT)
Received: from [10.0.55.204] ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38d2fdd777csm507508a91.1.2026.07.10.02.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 02:21:01 -0700 (PDT)
Message-ID: <12726bc4-33ce-4602-b2a9-46885f2af1fe@gmail.com>
Date: Fri, 10 Jul 2026 17:20:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: make firmware activation poll interval configurable
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Guzebing <guzebing@bytedance.com>
References: <20260627010610.47768-1-guzebing1612@gmail.com>
 <20260709064233.GA18381@lst.de>
 <7ae65361-f601-4fd9-8eac-5dfb9f6bb7ea@gmail.com>
 <ak-5QnI_lc-EwcNU@kbusch-mbp>
From: guzebing <guzebing1612@gmail.com>
In-Reply-To: <ak-5QnI_lc-EwcNU@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_022103_256280_DDACBFA5 
X-CRM114-Status: GOOD (  16.69  )
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



On 7/9/26 11:07 PM, Keith Busch wrote:
> On Thu, Jul 09, 2026 at 05:06:11PM +0800, guzebing wrote:
>> The Samsung PM9D3a Gen5 SSD reports MTFA = 10, i.e. 1000 ms.
>>
>> I also checked another device, an Intel/Solidigm P5520 Gen4 drive.  It
>> reports MTFA = 100, i.e. 10000 ms, while the observed online activation
>> time is about 800 ms.
>>
>> I agree that deriving the polling interval from MTFA would be better
>> than adding a module parameter.  Given that MTFA is a conservative upper
>> bound rather than a good estimate of the common activation time, would
>> using a small fraction of it, for example MTFA / 100 clamped to 10..100
>> ms, be a reasonable policy for v2?
>>
>> That would give 10 ms for the PM9D3a device above, while keeping the
>> current 100 ms interval for the P5520 case and for large-MTFA devices.
> 
> nvme_wait_ready() has a similar polling loop on the csts register, but
> it does a udelay_range for 1-2 msecs no matter what the ready timeout
> is. Maybe just do the same for consistency?

Keith, using the same 1-2 ms sleep range as nvme_wait_ready() looks
simpler to me as well.

I measured two long-running nvme_wait_ready() calls in the normal
nvme-pci NVMe controller-reset path for a live Intel P5520
(SSDPF2KX076T1), not the PCIe FLR fallback:

  nvme_disable_ctrl() cleared NVME_CC_ENABLE in ctrl->ctrl_config,
  wrote the cached value to CC, and then waited for CSTS.RDY == 0:
  1353 ms

  nvme_enable_ctrl() set NVME_CC_ENABLE in ctrl->ctrl_config, wrote
  the cached value to CC, and then waited for CSTS.RDY == 1: 1070 ms

Both long-running waits used an effective timeout argument of 30
seconds. The same drive reports MTFA = 100 (10 seconds), while its
observed online firmware activation time was about 800 ms. Thus, on
this device, the ready waits already use the 1-2 ms sleep range for
longer than the observed firmware activation.

Thanks both for the suggestions. Christoph, would this approach work
for you as well? If so, I can respin v2 to drop the module parameter
and replace msleep(100) with usleep_range(1000, 2000) in
nvme_fw_act_work().


