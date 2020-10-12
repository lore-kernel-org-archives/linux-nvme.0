Return-Path: <SRS0=YdFy=DT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5434C433E7
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2020 17:13:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B3AC20838
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2020 17:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ieeAUBj9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/P38IvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3AC20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RJn8W1n3SX+CmJtev6vtaiRqFIY99cXIkjpPBHl0XKo=; b=ieeAUBj9m1Qdn6m+60JgnwMRN
	gfM+2cH6QyZ6rtRV8Q7stsmN0gUzGDhV2gQBI7q/Ylmx4elek2dpgmzXHXv4lkBeSOdCDv/I9yc2T
	As/xjxEt5JiYQAu9MZdsOCe9pL+JFulnDPWY1e3zq1Arx91fTA3X1YGof0a/2A+sfhIQm5RDLLbeq
	3SMC5QttdAEaiExbOevc/M8UkyQmBmFoNiGY3cWoKAdV4ciwkGuxu40KYYUe8KAS3xbQpqa/IVI3p
	EjGPNNLXEgtqUderuY2LPnmBqYGku3/IKTSFft7U+fPoC/XBJ66zSPebGgXsNTdDY8H9og2463FoZ
	N9nPDNkiQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kS1OH-00050s-Gw; Mon, 12 Oct 2020 17:13:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kS1OD-00050H-3o
 for linux-nvme@lists.infradead.org; Mon, 12 Oct 2020 17:13:38 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8547920838;
 Mon, 12 Oct 2020 17:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602522815;
 bh=FIkuwRAaY7y7O+MMfYSn9Ca2fOBcEiYxW0UU6GMyRIc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T/P38IvGOIfZuRwOvvyUsNNFgvbbr4RX3uMayFMbFk9vGxI0+4iatYIFnwfDcxSVD
 S/oZX2nceBgTgsyZHLGMvIbMC0JjMDwDiRm3g4HoE+9Or4Wv4QeLmpra0AxHKREbHc
 Br8UlBw+Q7/1BnwBRor/vO48Npj+kT1JM8LfOIQM=
Date: Mon, 12 Oct 2020 10:13:33 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chris Friesen <chris.friesen@windriver.com>
Subject: Re: NVME, isolcpus, and irq affinity
Message-ID: <20201012171333.GA1032168@dhcp-10-100-145-180.wdl.wdc.com>
References: <2a4a5174-d1b9-86b7-f3c8-03b041fa093e@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2a4a5174-d1b9-86b7-f3c8-03b041fa093e@windriver.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201012_131337_213910_3CDD3075 
X-CRM114-Status: GOOD (  20.28  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Oct 12, 2020 at 09:49:38AM -0600, Chris Friesen wrote:
> I've got a linux system running the RT kernel with threaded irqs.=A0 On
> startup we affine the various irq threads to the housekeeping CPUs, but I
> recently hit a scenario where after some days of uptime we ended up with a
> number of NVME irq threads affined to application cores instead (not good
> when we're trying to run low-latency applications).
> =

> Looking at the code, it appears that the NVME driver can in some scenarios
> call nvme_setup_io_queues() after the initial setup and thus allocate new
> IRQ threads at runtime.=A0 It appears that this will then call
> pci_alloc_irq_vectors_affinity(), =


Yes, the driver will re-run interrupt setup on a controller reset.

> which seems to determine affinity without any regard for things like
> "isolcpus" or "cset shield".
>
> There seem to be other reports of similar issues:
> =

> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1831566
> =

> Am I worried about nothing, or is there a risk that those irq threads wou=
ld
> actually need to do real work (which would cause unacceptable jitter in my
> application)?
> =

> Assuming I'm reading the code correctly, how does it make sense for the N=
VME
> driver to affine interrupts to CPUs which have explicitly been designated=
 as
> "isolated"?

The driver allocates interrupts, but doesn't affine them. The driver
lets the kernel handle that instead.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
