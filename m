Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD2BC433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Apr 2022 15:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:Subject:From:References
	:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h+kt4USVeW0qRvqjcIwwOgZ6DD+sxajdKeh1AWu5gS8=; b=j33oknQ/PcYrOwIn3dQfyJ0ViA
	tPeg1YX3G8JDYLukW3vKMAiggKkLyIsk2PlVJSgkxTFTBchGeTrecNB6LtVH2mKbtYI22mRQn6mej
	zGnkRah/VhDB3+zzoW9/YjFxEO0xiwlraq/W0PhJpEsRASdYenMmgOmP0jiK9ZibyyJy39swd0N2h
	T8rdg2Pn6oWBwcxhTaVpHTdU1IOzTPWbNRN/Kg5Ynsv57BHISNCUnttI39QwcbDLwvtCFLZNmTAHG
	dcQUHOyXj9ELFXTe5yUnwDQDkdXC4YhpV7q+7Q5XpZO/AYT448ku4oLLCLnNG677SXibIkMQCsziN
	UviGQruw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbOwJ-00Fbdc-2r; Mon, 04 Apr 2022 15:48:23 +0000
Received: from marcansoft.com ([2a01:298:fe:f::2] helo=mail.marcansoft.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbOw7-00FbaA-7l; Mon, 04 Apr 2022 15:48:13 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: marcan@marcan.st)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 2E1F0419BC;
 Mon,  4 Apr 2022 15:48:01 +0000 (UTC)
To: Rob Herring <robh@kernel.org>, Sven Peter <sven@svenpeter.dev>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Arnd Bergmann <arnd@arndb.de>,
 Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-6-sven@svenpeter.dev>
 <5eed58a1-ee56-8aee-e73b-76b162d59873@kernel.org>
 <35f5fdbf-faac-457b-a225-35d7141f6b2e@www.fastmail.com>
 <YksIhWQIUHsoWEMi@robh.at.kernel.org>
From: Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 5/9] soc: apple: Add RTKit IPC library
Message-ID: <5441c5a7-5535-a8c3-c6ad-71d81754b9b1@marcan.st>
Date: Tue, 5 Apr 2022 00:47:59 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YksIhWQIUHsoWEMi@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_084811_469696_4A389541 
X-CRM114-Status: GOOD (  32.61  )
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

On 05/04/2022 00.02, Rob Herring wrote:
> On Sat, Apr 02, 2022 at 03:51:46PM +0200, Sven Peter wrote:
>> On Wed, Mar 23, 2022, at 12:19, Krzysztof Kozlowski wrote:
>>> On 21/03/2022 17:50, Sven Peter wrote:
>>>> Apple SoCs such as the M1 come with multiple embedded co-processors
>>>> running proprietary firmware. Communication with those is established
>>>> over a simple mailbox using the RTKit IPC protocol.
>>>>
>>>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>>>> ---
>>>>  drivers/soc/apple/Kconfig          |  13 +
>>>>  drivers/soc/apple/Makefile         |   3 +
>>>>  drivers/soc/apple/rtkit-crashlog.c | 147 +++++
>>>>  drivers/soc/apple/rtkit-internal.h |  76 +++
>>>>  drivers/soc/apple/rtkit.c          | 842 +++++++++++++++++++++++++++++
>>>>  include/linux/soc/apple/rtkit.h    | 203 +++++++
>>>>  6 files changed, 1284 insertions(+)
>>>
>>> Isn't this some implementation of a mailbox? If so, it should be in
>>> drivers/mailbox. Please don't put all stuff in soc/apple, that's not how
>>> Linux is organized. To drivers/soc usually we put drivers which do not
>>> fit regular subsystems.
>>>
>>
>> I put this into soc/apple because I don't think it fits within the mailbox
>> framework very well.
>> (It actually uses the mailbox framework for the actual communication
>> with the hardware with a driver that's already upstream.)
>>
>> Essentially, the mailbox subsystem provides a common API to send and
>> receive messages over indepedent hardware channels and devicetree bindings
>> to describe the relationship between those channels and other drivers.
>>
>> One of the features that doesn't really fit is that we need to be able
>> to start, shutdown and re-start these co-processors. The NVMe driver
> 
> remoteproc does that. Did you look at it? Most remoteproc drivers use 
> some combination of mailboxes and shared memory.

Remoteproc seems to be mostly about providing a standard interface for
loading firmware images and kickstarting somewhat generic remote
processors, as well as some high-level stuff for virtio. None of that is
useful to us as far as I can tell, because Linux doesn't load the
firmware for these things, it is pre-loaded by the bootloader and
therefore they might as well be fixed-function hardware as far as we're
concerned.

I can certainly see some similarities between the resourceproc API and
what we're doing, but I don't see what it would do for us other than
cause an impedance mismatch. Does it actually *do* something we can use?
Keep in mind these are Apple copros running Apple firmware that will
only ever talk to drivers we write for Apple machines, and we don't
control the firmware.

Impediance mismatches on first glance:

- The assumption that firmware is loaded by Linux seems to be hard-coded
into the subsystem
- Only one boot/shutdown path, while we need different power states and
boot modes depending on the specific instance
- The concept of the "resource table"; we have something similar for at
least one copro, but it's brokered via exchanged messages after it is
booted, and not something we can just look up in the firmware (our plan
was to just put the requested regions in the DT reg node and name them;
the firmware then *after boot* provides a list of mappings it wants from
that list and they can be mapped at that point). At least one other
copro does a subset of this an entirely different way altogether. Apple
aren't consistent and we can't do anything about that.
- Rproc trace buffers: Apple does syslogs but a different, incompatible way.
- ELF coredumps: even if this were useful for the blobs we get, the
blobs loaded by the bootloader themselves are Mach-O binaries, not ELF,
so that'd require some funny binary format conversion on one end or the
other to be able to line them up for postmortem debugging. And Apple's
crashdump format is a custom tag/value type thing.

I'm certainly willing to be convinced to use a kernel subsystem if it
actually does something useful for us, but last time we did that when it
wasn't entirely clear we should (mailbox, for the hardware underlying
these coprocessors) it just resulted in a bunch of headaches because
that subsystem is poorly designed and doesn't seem to have bought us
anything other than limitations. e.g. it is using suboptimal queueing
right now, and we had to switch to the atomic API to make SMC work,
which ends up even lower level, and isn't even properly documented and
different drivers interpret differently, so now it's just pure added
complexity and confusion for ~no gain over just reading/writing the
mailbox registers, which would've been *much* simpler (and more
performant than introducing additional queuing, since the hardware
*does* queuing now which we can't use because mailbox doesn't support
it). Remoteproc kind of seems like an even worse fit here...

Oh, and these device producer/consumer relations cannot be computed
statically as far as I can tell, so each one we introduce is another
special case in distro initramfs image building, since they need to
encode magic additional device-specific module dependency information
somehow since it isn't available in depmod, but only encoded in DTs
which are not necessarily known at initramfs build time.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub

