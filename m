Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DC6C4345F
	for <linux-nvme@archiver.kernel.org>; Fri,  3 May 2024 05:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n0iCVTcmN2qd9yHTavLeKroH1EWobLSRI2om8FAtnWM=; b=AbFarVQVSJH7IiJ1nZjg21r6PL
	7c5Ep3m0FrmZscE4T84LqGhKXI67IDLuc/s50YPcTzW8gIiXd9XNBfpPbkg730OUGiciajrMNNnhA
	IbDmPELKeRpKT4EaSByzEogW/FMXAyPzzPdbepFUiESzGsHlRNsfWxslYOCYZ/mNpmMcbX9LZTQEO
	4IaUJWuB2UxwO60LIlAzHTIidYDTfkyCoDWJJfEOqn05QKVRlkTC7fv35Er+00u1ZDp79QpcTYavE
	/yjb+DOMy1IO7u9jNA7BUFgjb3yZ7vv46DTHxwHhLGWY8TlC7Ipy3q8lpNbJErtG/R9vjNRYh3K4m
	nUc/ilIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2lrH-0000000FD0S-1SuL;
	Fri, 03 May 2024 05:53:23 +0000
Received: from mx3.molgen.mpg.de ([141.14.17.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2lrD-0000000FCwJ-0Umc
	for linux-nvme@lists.infradead.org;
	Fri, 03 May 2024 05:53:21 +0000
Received: from [10.50.1.206] (unknown [89.187.201.15])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 75D4361E5FE35;
	Fri,  3 May 2024 07:52:33 +0200 (CEST)
Message-ID: <32828674-eafc-435b-9497-3ee715c56231@molgen.mpg.de>
Date: Fri, 3 May 2024 07:52:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: `nvme_disable_ctrl()` takes 411 ms on a Dell XPS 13 with SK hynix
 PC300 NVMEe
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <19a6071a-7fb8-4e0f-8050-6f3ba5ee4774@molgen.mpg.de>
 <20240501045145.GA32110@lst.de>
 <ZjH2Coc8Wz9QrdRM@kbusch-mbp.dhcp.thefacebook.com>
 <93c29602-b162-47b3-9a03-a18158b9f6ef@molgen.mpg.de>
 <ZjK8IjHfwpAMQajT@kbusch-mbp>
 <1c826b9a-4b21-43c8-9064-c3ab095307c5@molgen.mpg.de>
 <522a8fd6-5865-4e8a-b8e8-b0288dfe384a@molgen.mpg.de>
 <ZjNSOEfDMgqJW01F@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <ZjNSOEfDMgqJW01F@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240502_225319_335941_F9C48A13 
X-CRM114-Status: GOOD (  25.54  )
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

Dear Keith,


Thank you for your reply with a lot of background. This is much appreciated.


Am 02.05.24 um 10:43 schrieb Keith Busch:
> On Thu, May 02, 2024 at 08:12:39AM +0200, Paul Menzel wrote:
>>>> That doesn't seem too hard to believe to me. A safe shutdown can often
>>>> take a while time for an SSD. I've seen other implementations orders of
>>>> magnitude worse than what you're showing.
>>>
>>> But why? Due to physics or due to "slow" firmware?
> 
> Maybe both? The run time metadata doesn't necessarily match the on-disk
> format, and constructing that can take a moment. These device's CPUs are
> usually the cheapest the vendor could get that satisfies a run-time
> performance target, so may be under powered for computational tasks.
> 
> And it may also have to flush pending user data from its internal
> memory, which could be a few GB.
> 
> Lower end devices don't even have memory, so may have to make many round
> trips to host memory to retrieve its metadata then manipulate that to
> its on-disk format.

Thank you for the details. Indeed “slow” firmware can be caused by 
low-performant chips.

> Maybe this could be better optimized, but vendors may not consider
> shutdown time to be a high priority.

As this is all a black box, it’s hard to know. If this is more visible, 
vendors might make it a higher priority.

> This gets worse as you add more nvme devices to your system because
> shutdown is serialized. Some of us have proposed patches parallelizing
> this process. I wish I could spend more time on helping see that to
> completion, but other priorities get in the way. :(

I didn’t know. I only have systems with one NVMe device. Also in other 
parts like initializing CPU cores and applying microcode updates they 
try to parallelize the initialization to decrease boot time.

>>> So this confirms the ftrace findings. Excuse my ignorance, so the
>>> time-out is in seconds? And how does this relate to the rtd3e value (410
>>> ms /= 60 ms /= 5 s(?)?
> 
> The driver provides a user tunable parameter to specify the minimum
> timeout value, and it defaults to 5 seconds.
> 
>    nvme_core.shutdown_timeout=<time_in_seconds>
> 
> The driver selects this or the advertised rtd3e, whichever is greater.

Reading the code, that is in `nvme_init_identify()`:

	if (id->rtd3e) {
		/* us -> s */
		u32 transition_time = le32_to_cpu(id->rtd3e) / USEC_PER_SEC;

		ctrl->shutdown_timeout = clamp_t(unsigned int, transition_time,
						 shutdown_timeout, 60);

		if (ctrl->shutdown_timeout != shutdown_timeout)
			dev_info(ctrl->device,
				 "D3 entry latency set to %u seconds\n",
				 ctrl->shutdown_timeout);
	} else
		ctrl->shutdown_timeout = shutdown_timeout;

> We can't trust device's to report this correctly (and NVMe 1.0 didn't
> even provide a way for a device to report an expected shutdown time), so
> this exists to prevent unsafe shutdowns. Devices are supposed to survive
> an unsafe shutdown, but it's best to avoid that path.

So it’s like this in my case, as the SK hynix reports 60 ms, but 
actually takes 411 ms?

> The parameter is in granularity of seconds because the NVMe 1.0 spec
> said to "wait at least one second" for a shutdown to complete. Not the
> most clear wording for a spec, but that's where we started.

Thank you for the details. I am not a spec writer, but my gut feeling 
says, there should always be a polling(?) solution and only upper 
boundaries, that means “no longer than”, should be used.


Kind regards,

Paul

