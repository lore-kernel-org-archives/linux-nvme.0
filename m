Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C00D3A67C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 18:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ukNkLMgZZXSaX7d+63ia+3d8xLI00k/zQ9P1ujwup2Y=; b=0Uz/0nHpcDoo5P809wAbC8WiqQ
	C/GXG/ReRcFSQzLFupBShM4V9LBQQ5oiELzwNnI1w1/jfi3lyheQt8iiMJxTjEjOfJc1uAX/G7EFj
	n+pwN0L5rSurWdVtbQEcut+appUEm32H/CnfrIIRJMfRm7Y7RVfbdMwVY9ARU2ZtRwUGsoNbRtPKk
	PSI6RWv5w6wG1klTRQMWid6DsSMNi4qhQGRimX6VypzP7773jwO0PC4MyBcfzlg857UL7fxkTys+u
	fGWpD5oVNW8Cqt3g2BTsVN0nZYVx5k6ORq8eUhbODp4IxJSmepPVuJGT34IpaVSkJtOV76uYBJ/H7
	hKsxSVQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5rFL-0000000FY7F-3jEF;
	Tue, 29 Oct 2024 18:47:15 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5pIW-0000000F9j0-2jiQ
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 16:42:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 138ED5C5A14;
	Tue, 29 Oct 2024 16:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816E3C4CECD;
	Tue, 29 Oct 2024 16:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730220143;
	bh=q4SkXxi/+TmNiwqZCXC+HkzXdL70CJhuEds3SKHlDpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rlWnRulN9xrWOvj8FopBdWiJKrzKt2slCXBZRnIHE006q+9Medtdmpt2PZYtIKNJg
	 IOvJ5obz2YvkHyOHLuzU7UoAUXs1QmUmJQjlyB3010G/fEB0FbAhrgvraXuoI2ox7m
	 Lo74t0qwJlwPfiVtRK9DxpzVxhd+hOWGb8xMoESdbs87pvl9Pj8ziFMDYV9LDd+/F+
	 f5NTsY06lK1BAxmGwux9PpZY3JGgHxOorwKER34ucBctaT3jB5ApoxJgdM9UewNiCq
	 H3JLDjThwN7PF4zb3kR8U+EQOdQDbD9oYZQlGrP1EP/NF+HD9OPuRPSrCNEukW1Mqh
	 eEQX4AKQnB4Qw==
Date: Tue, 29 Oct 2024 10:42:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Laurence Oberman <loberman@redhat.com>
Cc: "busch, keith" <keith.busch@intel.com>, linux-nvme@lists.infradead.org
Subject: Re: nvme: machine check when running nvme subsystem-reset /dev/nvme0
 against direct attach via PCIE slot
Message-ID: <ZyEQbcV_KPJnu6j7@kbusch-mbp.dhcp.thefacebook.com>
References: <b73005ac327784e740bb6b362870c15d0c7788fa.camel@redhat.com>
 <Zv8G8l5cyzDRwLJA@kbusch-mbp>
 <5325b263817024d0ca617b114f0a30aab0e0e2bc.camel@redhat.com>
 <bdd5b88fbd3325ae16ec9791b0719c373bbefed9.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdd5b88fbd3325ae16ec9791b0719c373bbefed9.camel@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_094224_756999_2E6C15FB 
X-CRM114-Status: GOOD (  13.55  )
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

On Tue, Oct 29, 2024 at 12:07:26PM -0400, Laurence Oberman wrote:
> Finishing this thread off but have a final question. 
> Bottom line is certain server hardware sees the nvme reset command
> create a machine check for PCIE plugged NVME devices going back quite
> far in kernel versions,  and we panic.
> 
> As Keith had said, that nvme reset command is too much impact

Sure, it takes the PCIe link down, and handling for that, if at all, is
platform specific.
 
> There is a final simple question for M2 connected NVME devices. 
> Are these expected to auto-re-connect after an nvme reset is issued. 
> 
> The complaint is the following
> 
> nvme subsystem-reset /dev/nvme0 
> Device is disconnected as expected but requires the following to
> reconnect
> 
> echo 1 >  /sys/bus/pci/devices/0000:02:00.0/remove
> echo 1 > /sys/bus/pci/rescan
> 
> Then it is reconnected.

For platforms that don't support link detected hotplug, that sequence
should get the device back to usable.

