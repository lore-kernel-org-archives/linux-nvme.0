Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D67C61DA4
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Feb 2023 16:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XsF21pLnMTMVqbB+2ISN8WgMlM8TQJt4vGQfADjw0vA=; b=K4iYkkw8X9utIT9JK2iS+ujEJ/
	TV0s84+hZP4E4r/ZwvytFk4BXVm1lRVaHicSio07Wr6Isj78ARkAOjvFR4rFM21mjHoWTGQM3wN8v
	PQrgRVcD1Zg1jv+QUtEtpQ7aLnaOU+PTCftaNyiNOmQm2D70UsyX5IVsp+4ziJ9d164AtsfCvzGqg
	reqV4rTSipHjNH4Ievyq1ItMxJq8UpCuRUkFtCAJZTVR+pybEDvfW6GN8XENg13eXtzh66nHYsf6d
	RUl56e3Q8pRXIcUOzCDG+QchvpiGTQCFNXTJLjZEyHTFc6BJ6PqQPuvaWO72NRYzYfIE7batutQdp
	71ZgXbYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pShJU-00BE1G-8p; Thu, 16 Feb 2023 16:40:52 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pShJR-00BE0H-SN
	for linux-nvme@lists.infradead.org; Thu, 16 Feb 2023 16:40:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8B56362039;
	Thu, 16 Feb 2023 16:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887BFC433D2;
	Thu, 16 Feb 2023 16:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676565648;
	bh=dz/6alTdHn2I5NxkOALw1FekhE9x9x60dVTsdIVdiPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1nyyh/s7tIzVQFmn/zl0zA46VYXIWOypnfsu+zwr3BvRZp/0/g/gRqT/gZ9bqyEI
	 QVJilOJYrkWCLQe6tio/d+NK7zAj/TSPjzgaSlkpASbESMsBM/R8XpkxKpY68+wctX
	 xS6oqbb4ZfzdYb+tI1baW7z6M2w8Vspfnhn6fF8Gf+taQWisNOFHUvmLhruFlJocYi
	 0msbM17Qx/GmJD8g7PcxWs20AAqyNphMFZu3ityMMsiTdgzBcUOYFwzdQyzcmPMcn5
	 MyJnHKZa+snTJVQIa3JUQl2cK6oH9HQPQgVzNCsuEL1kEbIKuXTUGPneD6XHeebv96
	 FcDMqQUUdj2Ug==
Date: Thu, 16 Feb 2023 09:40:44 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	lsf-pc@lists.linuxfoundation.org
Subject: Re: [LSF/MM/BPF BOF] Userspace command abouts
Message-ID: <Y+5cjPBE6h/IW9VH@kbusch-mbp>
References: <3d3369f1-7ebe-b3b8-804c-ff2b97ec679d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d3369f1-7ebe-b3b8-804c-ff2b97ec679d@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230216_084049_972584_97692661 
X-CRM114-Status: GOOD (  20.47  )
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

On Thu, Feb 16, 2023 at 12:50:03PM +0100, Hannes Reinecke wrote:
> Hi all,
> 
> it has come up in other threads, so it might be worthwhile to have its own
> topic:
> 
> Userspace command aborts
> 
> As it stands we cannot abort I/O commands from userspace.
> This is hitting us when running in a virtual machine:
> The VM sets a timeout when submitting a command, but that
> information can't be transmitted to the VM host. The VM host
> then issues a different command (with another timeout), and
> again that timeout can't be transmitted to the attached devices.
> So when the VM detects a timeout, it will try to issue an abort,
> but that goes nowhere as the VM host has no way to abort commands
> from userspace.
> So in the end the VM has to wait for the command to complete, causing
> stalls in the VM if the host had to undergo error recovery or something.

Aborts are racy. A lot of hardware implements these as a no-op, too.
 
> With io_uring or CDL we now have some mechanism which look as if they
> would allow us to implement command aborts.

CDL on the other hand sounds more promising.

> So this BoF will be around discussions on how aborts from userspace could be
> implemented, whether any of the above methods are suitable, or whether there
> are other ideas on how that could be done.

