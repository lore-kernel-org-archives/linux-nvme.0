Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC2ECF34AD
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2024 21:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q+rwCEY81oQ4sjtoyBBhHoecmyoZiPylOeaC6XfifYc=; b=ijOK9OC3G8+GpZB2TOHUHxxEsl
	jWU+d0guJlsQJ34TyYX+X9lVwFZpZfOcgoT44CJDBGBJYK14Z8nBQxIcynJe89j17hoZp/iaWDF1t
	EuOiTl7WhpeVz7XIAH+gpBIGqJQ0FxBKO+CqPsoOzcfyvyJJkjeB9zS9tQG+sXn8qQfMk9QmiFlS/
	NkSK5Bs59UuU5c2634r5gFV/YS/itwas1shrCAu6d83m4EqhuvvYQ4O18GBrQmjZvq7c3w8UDtrug
	ELFvROpoQ98AjEpERiVb2vWU8V47ii4Erz87fk82bEPPcr2EcYDfueZKG8SuGUZinDOD9Htlu5XUn
	Kp3oT5dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swT0K-0000000ALSP-0K4w;
	Thu, 03 Oct 2024 21:04:56 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swT0I-0000000ALRx-0AdH
	for linux-nvme@lists.infradead.org;
	Thu, 03 Oct 2024 21:04:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E58A5A4196F;
	Thu,  3 Oct 2024 21:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B371EC4CEC5;
	Thu,  3 Oct 2024 21:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727989493;
	bh=Q9k3k/m5fSxJzcDEz1vohdGeGNvVWjyNN8523HjrykU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mpF2JjSuvnFLJ1Yg/yxg/9N854l98M7J8g1k4PXcaJmsMO3jGT7sduUH/pf4SXzO7
	 qzWR5BUxX5n84/tA9hOgXTJqRAJRWcxTDtI+nMPZOIGIUeqyOqFZGGC2FcR+zEAIyt
	 CWDdK9zcV5Q4GXftyIE32YmHCdA8phm4VjNxHfvcXINP77UgFHnHz3oN5sxFAK3BTa
	 qC3swWvzU5dNYaxpcRfq0k8HnWbBJQoSjsUgAr/CvIUjrO1pXlB/Cv4uNT4Er2sofZ
	 JAxuVtlxqI3ts6N3pGC9zWNniQDWxIqI3Q5Sjg4cmjkoq2A0db/mr8sfMRIvX4Rv0t
	 Q3cXcVtNLPhPA==
Date: Thu, 3 Oct 2024 15:04:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Laurence Oberman <loberman@redhat.com>
Cc: "busch, keith" <keith.busch@intel.com>, linux-nvme@lists.infradead.org
Subject: Re: nvme: machine check when running nvme subsystem-reset /dev/nvme0
 against direct attach via PCIE slot
Message-ID: <Zv8G8l5cyzDRwLJA@kbusch-mbp>
References: <b73005ac327784e740bb6b362870c15d0c7788fa.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b73005ac327784e740bb6b362870c15d0c7788fa.camel@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_140454_163309_0ED8F27B 
X-CRM114-Status: GOOD (  16.30  )
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

On Thu, Sep 26, 2024 at 05:11:05PM -0400, Laurence Oberman wrote:
> It was reported to Red Hat, seeing issues with using a
> "nvme subsystem-reset /dev/nvme0" command to test resets.

I really dislike that command. The side effects are overkill for the pci
transport...
 
> On multiple servers I tested on two types of nvme attached devices
> These are not the rootfs devices
>
> 1. The front slot (hotplug) devices in a 2.5in format 
> reset and after some time recover (what is expected)
> 
> Example of one working
> 
> Does not trap and land up as a machine-check

<snip>

> 2. Any kernel upstream latest 6.11, RHEL8 or RHEL9 causes 
> a machine check and panics the box when its against a nvme in a 
> PCIE slot
> 
> [  263.862919] mce: [Hardware Error]: CPU 12: Machine Check Exception: 5 Bank 6: ba00000000000e0b
> [  263.862924] mce: [Hardware Error]: RIP !INEXACT! 10:<ffffffff8571dce4> {intel_idle+0x54/0x90}

So this wasn't failing before 6.11? As Nilay mentioned, there are some
changes on how nvme subsystem reset is handled. The main thing being
this ioctl doesn't automatically trigger an nvme reset. I expected
delayed recovery might happen, but machine checks are not expected. If
this was working before, I can only guess right now that the previous
behavior was accessing MMIO and config quicker and triggered a different
error path. If you're successful with the PPC patch reverted, I would be
interested to hear about it.

