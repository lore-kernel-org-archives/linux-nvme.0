Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1483DC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Mar 2022 05:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+L9Dck955/ialolBqFJSTIyRZMfgoE3bO2HASwSRLOk=; b=N1p+JLjAQM7qm9nbNKISykKOSo
	yn2bSGt1GJhcrL/uSfxHMAddgc08k29o8GQyAQFinbPTHEB/bCbVMNXTPvknB09aJJXQfOZmWV74t
	QvwAzra3MBihr4O3g2AMm9JsrJ02vI6nNMdsxXAsz3WQArkbLfNygtfQ9RqG02g1HrpTw+r8gMBBg
	S2l+s7UmFzYSP59rE51M0yE0hER/RW4imcsil9qBhuSH7gc9AwVRKBsNVMfycs1V55/vrXx8aofMF
	xufA0D1uu+h6ZHiSY1mXd9Fmtx/o/dop328O1uGCeAqVHNChje0Ct/yMzQlpk3KMB652X4f+/br/s
	6U8wje3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nZ4NF-00B5y6-Js; Tue, 29 Mar 2022 05:26:33 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nZ4N3-00B5wa-4n
 for linux-nvme@lists.infradead.org; Tue, 29 Mar 2022 05:26:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id C812BB8128A;
 Tue, 29 Mar 2022 05:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD36C2BBE4;
 Tue, 29 Mar 2022 05:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1648531578;
 bh=F94j0WiJmE2n0U54lTd9JyGb37irQw7Kn+4tBx3Tek8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rfKOAIHc3UKdfQCh+KF0GLb4Ygz1rsSRoqsaN84U/rjKkufMQbBDESgGP71GMbPRB
 llDZ5wx/fJIZ16qJwRp0QHtsq7IJqi1JgBVHVqJDZp6dVfGR+KLr/7rhPq76AqBd9H
 JXsh0GTY+o2gfJf8MwG4LgrU4wShbcwBMR65lAXs=
Date: Tue, 29 Mar 2022 07:26:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tanjore Suresh <tansuresh@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Asynchronous shutdown interface and example
 implementation
Message-ID: <YkKYd3DIduUyuEso@kroah.com>
References: <20220328230008.3587975-1-tansuresh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328230008.3587975-1-tansuresh@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220328_222621_508553_3DED9600 
X-CRM114-Status: GOOD (  29.50  )
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

On Mon, Mar 28, 2022 at 04:00:05PM -0700, Tanjore Suresh wrote:
> Problem:
> 
> Some of our machines are configured with  many NVMe devices and
> are validated for strict shutdown time requirements. Each NVMe
> device plugged into the system, typicaly takes about 4.5 secs
> to shutdown. A system with 16 such NVMe devices will takes
> approximately 80 secs to shutdown and go through reboot.
> 
> The current shutdown APIs as defined at bus level is defined to be
> synchronous. Therefore, more devices are in the system the greater
> the time it takes to shutdown. This shutdown time significantly
> contributes the machine reboot time.
> 
> Solution:
> 
> This patch set proposes an asynchronous shutdown interface at bus level,
> modifies the core driver, device shutdown routine to exploit the
> new interface while maintaining backward compatibility with synchronous
> implementation already existing (Patch 1 of 3) and exploits new interface
> to enable all PCI-E based devices to use asynchronous interface semantics
> if necessary (Patch 2 of 3). The implementation at PCI-E level also works
> in a backward compatible way, to allow exiting device implementation
> to work with current synchronous semantics. Only show cases an example
> implementation for NVMe device to exploit this asynchronous shutdown
> interface. (Patch 3 of 3).
> 
> Tanjore Suresh (3):
>   driver core: Support asynchronous driver shutdown
>   PCI: Support asynchronous shutdown
>   nvme: Add async shutdown support
> 
>  drivers/base/core.c        | 39 ++++++++++++++++++-
>  drivers/nvme/host/core.c   | 28 +++++++++----
>  drivers/nvme/host/nvme.h   |  8 ++++
>  drivers/nvme/host/pci.c    | 80 ++++++++++++++++++++++++--------------
>  drivers/pci/pci-driver.c   | 17 ++++++--
>  include/linux/device/bus.h | 10 +++++
>  include/linux/pci.h        |  2 +
>  7 files changed, 144 insertions(+), 40 deletions(-)
> 
> -- 
> 2.35.1.1021.g381101b075-goog
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

