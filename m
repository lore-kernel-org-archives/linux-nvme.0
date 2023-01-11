Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60C5C5479D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jan 2023 05:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n012qai1OrEvsHinq7NTTDNvs6mEoXWKxJuTKH25hpE=; b=SMjE4aJJ+SczaFgUbQUe6TeD2O
	lL1pPuJpEPvBfLh/klw3Q6D02xc37waRp/iiqO9wXqux6+txS6PqcsmdvH0+l5mq72gVs+Kn3Pr72
	6SWYLo7mYjkVDTv3P2J3Qa6IQAATHY5RoeNj9atdLK3X7UEuneqsKGqfeKZO3/vNs9+0HlKQOsa+N
	tmAEACcCqpg6myZ2QQC0lnkAlOLqOpRGPFSV39S/IIlOj+36ch7bsaxiSxVwAYQeytmgb/e/LbjE5
	0QJ/aupGIQBOrXsCBAby9nFSN3LSTVTlu2NM7n7DFaS2UnPMqwSCArO2QrwkyfPjVv6DeIIooK0V7
	TFxLkkqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFTv6-009lVs-9Y; Wed, 11 Jan 2023 05:45:04 +0000
Received: from marcansoft.com ([212.63.210.85] helo=mail.marcansoft.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFTuu-009lRV-2d; Wed, 11 Jan 2023 05:44:54 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 09CC442165;
	Wed, 11 Jan 2023 05:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1673415888; bh=ZUBDEZ3HqGVgxTGdK2mXvKaJwqs1erYRaHc5pOijmRo=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To;
	b=B4p13oHISRpIZ/9Jtac7401X6Q3uOv/Kc2nrTWLIQKNwud7HuAWege3QXDhDCjgGQ
	 v6dISmgIX55nDfp4jGlmL7Ovq9q8YaqfzkHmkCvNu/NRK69zzKHS+aPBl+tG262fm1
	 hRvAqyZvj7UVeMq8NXKzjjrxhaKAJ+OT9TOqYpVmBYqkihlcrQ9PPXw0A9gvin2ygY
	 HUOrwf+kzh9+gB9RiOu2+lVpB8we4jKasHbFRgraDowZsH1+MvOtMWkkkGkHrzGP4r
	 xPxDfZfqAnkFoAkM4xCWfUnk4t5Jyqe+aeFop+hrzFRg7Wv5Waf6T/GNkMkBJv365a
	 jbN4FQjnuUtFw==
Message-ID: <0e7f9ef4-6660-5842-821b-7492f7ecbc61@marcan.st>
Date: Wed, 11 Jan 2023 14:44:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, Eric Curtin <ecurtin@redhat.com>,
 Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20230111043614.27087-1-marcan@marcan.st>
 <20230111043614.27087-2-marcan@marcan.st> <20230111045402.GB15520@lst.de>
 <fc2e03ea-5404-e768-0cab-e95adcde6da7@marcan.st>
 <20230111051836.GA16576@lst.de>
From: Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 1/2] nvme-apple: Do not try to shut down the controller
 twice
In-Reply-To: <20230111051836.GA16576@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230110_214452_463643_AF057AD1 
X-CRM114-Status: GOOD (  35.84  )
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

On 11/01/2023 14.18, Christoph Hellwig wrote:
> On Wed, Jan 11, 2023 at 02:10:42PM +0900, Hector Martin wrote:
>> OK, so the first question is who is responsible for resetting the
>> controller after a shutdown? The spec requires a reset in order to bring
>> it back up from that state. Indeed the PCIe code does an explicit
>> disable right now (though, judging by the comment, it probably wasn't
>> done with the intent of resetting after a shutdown, it just happens to
>> work for that too :))
> 
> We need to do the reset before banging the registers to make sure
> the controller is in a sane state before starting to set it up.
> 
>> Right now, apple_nvme_reset_work() tries to check for the condition of
>> an enabled controller (under the assumption that it's coming from a live
>> controller, not considering shutdown/sleep) and issue an
>> apple_nvme_disable(). However, this doesn't work when resuming because
>> at that point the firmware coprocessor is shut down, so the device isn't
>> usable (can't even get a disable command to complete properly). Perhaps
>> a better conditional here would be to check for
>> apple_rtkit_is_running(), since apple_nvme_disable() can't work otherwise.
> 
> So on a resume the controller should have previously been shutdown
> properly, and this shouldn't be an issue.  Does the apple implementation
> leave some weird state after a shut down?  In that case the resume
> callback might want to do an explicit controller disable before doing
> the reset.

The controller is *shut down* but it's not *disabled*, and the existing
code was only checking whether the controller is enabled to decide to
issue another disable.

The higher-level resume path can't do a disable since the firmware isn't
up at that point, and the subsequent reset (which is shared with other
conditions that cause a reset) is what brings the firmware back up. So
the disable has to either happen in the suspend path, or in the shared
reset path after we know the firmware is running.

A shutdown but enabled controller is in "limbo"; the only way to know
it's nonfunctional is explicitly checking the shutdown status bits.
Other than that, it looks like a live controller that plays dead. This
is documented in the spec as such.
>> Alternatively, we could just revert to the prior behavior of always
>> issuing a disable after a shutdown. We need to disable at some point to
>> come back anyway, so it might as well be done early (before we shut down
>> firmware, so it works).
> 
> So the disable before shutdown doesn't really make sense from the
> NVMe POV - the shutdown is to cleanly bring the device into a state
> where it can quickly recover.  While a disable is an abprupt shutdown,
> which can have effects on recover time, and might also use way more
> P/E cycles than nessecary.

That's only if you issue a disable *in lieu* of a shutdown (and in fact
if you do that on Apple controllers under some conditions, they crash).
Issuing a disable *after* a shutdown is required by the NVMe spec if you
want to use the controller again (and should basically do nothing at
that point, since the controller is already cleanly shut down, but it is
required to set EN to 0 such that the subsequent 0->1 transition
actually kickstarts the controller again). If you don't do that, the
controller never leaves the shutdown state (how would it know?).

To be clear, the sequence I was attempting to describe (which is what we
were doing before the patch that regressed this) was:

(on sleep)
- NVMe shutdown
- NVMe disable
- Firmware shutdown

After the firmware shutdown, we can't do anything with NVMe again until
we start firmware back up, which requires going through the reset flow.

Right now we're doing:

(on sleep)
- NVMe shutdown
- Firmware shutdown
(wakeup)
- Oops, NVMe is enabled, let's disable it! (times out due to FW being
down but failure isn't propagated)
- Firmware startup
- NVMe enable (thinks it succeeds but actually the controller is still
in the shutdown state since it was never disabled and this persists
across the firmware cycle!)
- I/O (never completes)

- Hector

