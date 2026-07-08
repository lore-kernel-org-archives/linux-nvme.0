Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229FDC43458
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2026 08:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kK3XH3FhYHQdO+CUL/JXCIjjTGIDm8/tA14tCxEPi1c=; b=SddHpGQx1wuC6/rHkexR5ILu9A
	kAn7ayqPRdtfuV2jRWTpw/LJ4oARvCIuWCdNpO60aNfmR8KzFczRZyxic1EGCm5O2eH16XRgdr4dP
	Y1ZvOmnyVLwFydBjyqe1BvbyNV2FpmO8ndlR23USij60od37GyxvszwAaP3BO0zIwR9DeFKaUTJMw
	pg+axA9yfY96X6I5GVeHDXonZdws22wOXjohmVJzdA0X4wAEFMO78EyhvUa3jkglfFvwoDZ8R+RtZ
	16bsUk5rA0Gdi5atdm9/qaC6h523M+obvvWNXDmNhOVvgEoJFT0HuYaqv6Zp4UoPQq3V1LUNVcfEc
	HW1b+3hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whNm1-0000000GdWB-13qn;
	Wed, 08 Jul 2026 08:36:53 +0000
Received: from mail.nearlyone.de ([2a01:4f8:1c1e:abde::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whNly-0000000GdUq-0KVd
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jul 2026 08:36:51 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4473AE4110;
	Wed,  8 Jul 2026 10:35:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1783499748; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=kK3XH3FhYHQdO+CUL/JXCIjjTGIDm8/tA14tCxEPi1c=;
	b=xzmcYp2TYaNYVVkWhTA3YzpwocW75tdcp0OPQD6N61okm6A4ZpZdoS7DkCOAkxD0ExN8lq
	H/q2uKGU55yGuJbq7MbjWdMUYxNvtNU1lHhGT7aZSizguB9TeEl+ArylX+TpNxS6ItvOxG
	RGWRxJ1Ag30vZSp8LczZrFe/IzmN5qST8DcGqH6vJqGppCuRvDIImp59S6wpCIHDpIAJ4l
	2UMtirOdxcnuMsyrX0gM0laz+ETEDRtw3jjqGsGO65kKIodFxM/sOZ5fEGY+BINRJKqjXO
	E0Ra+bgtxcNzb88nGj26CgpAGF1Fa7jJhNwfTBvq7nKzT0KXgTckboU7x6UDaw==
Date: Wed, 8 Jul 2026 10:35:30 +0200
From: Daniel Wagner <wagi@monom.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Maurizio Lombardi <mlombard@redhat.com>, hch@lst.de, hare@suse.de, 
	sagi@grimberg.me, mlombard@bsdbackstore.eu, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmetcli: allow running arbitrary commands
 non-interactively
Message-ID: <5da0ddf9-955a-4d39-9406-713484d847b3@nitrogen.local>
References: <20250728155504.403426-1-mlombard@redhat.com>
 <2973b3de-ad03-4900-8153-d7d37af1623e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2973b3de-ad03-4900-8153-d7d37af1623e@linux.ibm.com>
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_013650_494337_3EBC277D 
X-CRM114-Status: GOOD (  18.09  )
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

On Thu, Jul 31, 2025 at 05:58:49PM +0530, Nilay Shroff wrote:
> On 7/28/25 9:25 PM, Maurizio Lombardi wrote:
> > This patch refactors the command-line argument handling
> > to allow for the execution of any valid shell command directly
> > from the system's command line, without entering the interactive mode.
> > 
> > Previously, only a limited, hardcoded set of
> > commands (`save`, `restore`, `clear`, `ls`) could be run
> > non-interactively.
> > This change removes the special case for the `ls` command and
> > introduces a generic mechanism that concatenates all command-line
> > arguments and executes them as a single command within the
> > `nvmetcli` shell.
> > 
> > This enhancement improves the scriptability of the tool.
> > 
> > For example, users can now run complex commands like:
> > $ nvmetcli /subsystems create nqn.2024-07.org.example:sub1
> > $ nvmetcli /ports ls
> > 
> > The usage information has been updated to reflect this new functionality.
> > 
> > Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> 
> IMO this is a useful addition to the nvmetcli tool.
> I have also tested changes and looks good to me:
> 
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

I've applied the patch to the integration tree.

Thanks,
Daniel

