Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023B0C2D0CD
	for <linux-nvme@archiver.kernel.org>; Thu, 15 May 2025 14:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wh5FmGth+MVytkaPVvezAtLRvQ2uuF7dgbMjfFOALrc=; b=npIfqODrKVFtr3qQPC6fxUL59W
	O4TpHPGYEFgQ5QbBtlvO7UUd368Fr9t+8urXLTGcwVT2t55O8mCq73YgDK7ImmJ98sYETa3IFd0Qu
	+zQQSc+QeqpzjtCMXYGzXZyorZPYN9/kIAx6eTC84bDy048WkT8KiTfI0Xxbb0lPOMo/nn5K1Kzh8
	cLpDkuQswqL8xDWaQC2t32+j6zZR8azzl1Ekh/cwVvknzWTZKPXgwNVnQNl2Y3OP//jWf1WncGLZk
	CzNWKbAgm/0DHg4sTHMKUgfGpR0OdtKvEhE6tvT6OaLbpoFefiGf8aqbaVaIbeO/Qbhw16lcfJFaz
	Vx+M5Wrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFZfy-00000000toH-28Nv;
	Thu, 15 May 2025 14:35:10 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFZPa-00000000rDd-2jQG
	for linux-nvme@lists.infradead.org;
	Thu, 15 May 2025 14:18:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3DDAB43BF5;
	Thu, 15 May 2025 14:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C3CC4CEE7;
	Thu, 15 May 2025 14:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747318692;
	bh=9uTPydBldNilMeLFt9DhQvR1n5CyR0MJLnn/v4oaBZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U6xSgRL4GLeXcziJKx0UEobpg6PdS8bVKLwt+2X+czTLfG7rErNOZ14IhXlbcI28S
	 zwa8pyUvVeiwJ4R3q8shFQzOjQBABOvSVRLonBGRXmF/G3teXJeMCLE98sTfX4rs0B
	 MpTSHBByWoa+2aouqjle8AJCqZhwNLpNVZSJo0Jnlc3sA2x9zjw7bAENT7NrbzL/3A
	 WTEdfe20fieXZL+QbxPVh4y7PwGQLLNTHBweWlTpdKViBI3O3f/2t7BHyzDwzpXlTG
	 xRAiB3NdFcfROKHxshBHg4j1eIMmCMExz3SETvel5rvN9nVv1NibnuLjCtdYz7WyaH
	 3NuxTHf0omUJw==
Date: Thu, 15 May 2025 08:18:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jeffrey Lien <Jeff.Lien@sandisk.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Avinash M N <Avinash.M.N@sandisk.com>
Subject: Re: NVMe CLI Invalid PRP Entry Status Failures
Message-ID: <aCX3offAfe1k0_KE@kbusch-mbp>
References: <MW3PR16MB3897F0E659B34877C4D5197CF391A@MW3PR16MB3897.namprd16.prod.outlook.com>
 <MW3PR16MB38975C2057D1EF440FBD60B0F390A@MW3PR16MB3897.namprd16.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR16MB38975C2057D1EF440FBD60B0F390A@MW3PR16MB3897.namprd16.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250515_071814_715694_DC33885F 
X-CRM114-Status: GOOD (  11.93  )
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

On Thu, May 15, 2025 at 02:01:50PM +0000, Jeffrey Lien wrote:
> 
> We are seeing invalid PRP entry status failures with transfer lengths
> 0x2000 on nvme cli admin-passthru commands.  This started happening on
> the 6.10 linux kernel version and the commands were working on kernels
> <= to the 5.15 version.   See example commands below.   I didn't find
> any obvious commits in that time frame that might be causing these
> failures.  Does anyone have any insight to any of the changes that
> might be causing these errors?
> 
> Example command: sudo nvme admin-passthru /dev/nvme0 --opcode=0xD2 --cdw10=0x12600 --cdw12=0x00010132 -l 0x2000 -r -b
>  
> .	Initially any transfer length > 0x2000 fails in invalid PRP entry status
> $ sudo nvme admin-passthru /dev/nvme0 --opcode=0xD2 --cdw10=0x12600 --cdw12=0x00010132 -l 0x2000 -r -b Admin Command Vendor Specific is Success and result: 0x00000000

The only thing that comes to mind is that we allow dword aligned buffers
now. The driver used to require 4k aligned, but nvme spec doesn't
require that. My guess is your device is incorrectly rejecting admin
commands that have a dword offset in PRP1. Do you have any visibility
into the device's reasoning for this response here?

