Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269E9D78333
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2024 16:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z1lnDhodjxL9Pgw35UgDeFKu6RDVs6wEUm6Ya3n3pxM=; b=hHretroTsPM04u+Su9YjlN+Iug
	T6rIF6PPq7R4QOhEMx3HdYEKuDb1gn7+C7SqO8iP+OU/J39MPUtaMnNrQUuNoEScabwqgAcPhoYCU
	18ub07fvUqx9CUMRRBnbQzjS+33b0x99/esUARqm+SvY4KSXd+c/CTW4aALpKRlBgXiWq4Chp8asH
	vf21E5ovflz21mQ8vf9UnvGLFdKxgGS6IqFVio+BkZQPxv+FMJiul0J7F7DyQwI98jSmqLoxaAzX+
	KY8b1655m/iK7aruY5sQ8bNMsUQV92fuffpRFySu3oQAZM8XhGhtfRwhTn8mAwqdbZjBNG1yO1fP8
	yXsVN83A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tI8zl-00000006myd-2CxN;
	Mon, 02 Dec 2024 16:09:57 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tI8gF-00000006iwy-3uXZ
	for linux-nvme@lists.infradead.org;
	Mon, 02 Dec 2024 15:49:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D3E4BA40D9D;
	Mon,  2 Dec 2024 15:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84859C4CED1;
	Mon,  2 Dec 2024 15:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733154586;
	bh=QdQoYqoeYQip7Q7QGokpyu0AQ2Wk4ZISkghXpUP4p3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXJpVpMSIWvDiklkFOb3J1AqyCpUKjwglx7gbIiY41jOJ1OoUdbaHoFFD+kW6CGRj
	 b0s8/kjK8aaLSStwr41iX0SQwtjRpxFN1jwitoSiWBnhpe0MqGSgHAETMfT+T4pzz+
	 ueTQy3vV2fJilKaOd1jFmqHORpHKBO5tpWngTMA9TmgBP8En1ZtvvuGKkNX0REirWl
	 AaU61N9uBSjYYimSp+VRLSFaoDJk4pBQfdoucj2XGMlLTyZKB2k886h6/iIwWBBSx7
	 a0+a07EWIEykgwnycV3CMc6rka6K0A/QFrcrizHI3I+h2e3QHgCYiL7h7zErmWDGFb
	 qZ852TwOpCu2w==
Date: Mon, 2 Dec 2024 08:49:44 -0700
From: Keith Busch <kbusch@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: New warning `nvme nvme0: using unchecked data buffer`
Message-ID: <Z03XGL6wh1xV2zx5@kbusch-mbp.dhcp.thefacebook.com>
References: <20241118155738.2737423-1-kbusch@meta.com>
 <20241118155738.2737423-4-kbusch@meta.com>
 <ed59976f-d8ef-411a-b159-0bb1c6bdfa8c@molgen.mpg.de>
 <Z03Mq9xaMXbJtm0d@kbusch-mbp.dhcp.thefacebook.com>
 <3a851b3a-dfad-4796-94cb-42ced213e901@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a851b3a-dfad-4796-94cb-42ced213e901@molgen.mpg.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_074948_093940_2712D789 
X-CRM114-Status: GOOD (  34.88  )
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

On Mon, Dec 02, 2024 at 04:15:03PM +0100, Paul Menzel wrote:
> Am 02.12.24 um 16:05 schrieb Keith Busch:
> > On Mon, Dec 02, 2024 at 08:56:03AM +0100, Paul Menzel wrote:
> > > Am 18.11.24 um 16:57 schrieb Keith Busch:
> > > > From: Keith Busch <kbusch@kernel.org>
> > > > 
> > > > If the device supports SGLs, use these for all user requests. This
> > > > format encodes the expected transfer length so it can catch short buffer
> > > > errors in a user command, whether it occurred accidently or maliciously.
> > > > 
> > > > For controllers that support SGL data mode, this is a viable mitigation
> > > > to CVE-2023-6238. For controllers that don't support SGL, log a warning
> > > 
> > > For the layman, what is this security problem?
> > 
> > The passthrough interface can't validate buffer lengths against the
> > command's actual payload. NVMe traditionally did not have explicit
> > buffer sizes encoded in commands, so this only works correctly if the
> > device and host both agree on what the implicit transfer size actually
> > is. More recent NVMe features fixed that problem with explicit buffer
> > sizes in the commands.
> > 
> > Whether by accident or on purpose, user space can request a smaller
> > buffer than the device is going to transfer into it. That will corrupt
> > memory.
> 
> Does the Linux kernel know the buffer size?

Not necessarily. The kernel just knows what the user requested. There
are some commands that the kernel could validate to make sure what the
user requested makes sense for the command it is sending, but there are
vendor specific commands and command sets that the kernel has no idea
how to decode, as well as new spec features always being added that
change how to decode existing commands, so we just have to trust the
user isn't abusing the interface.
 
> > >      [   14.399238] nvme nvme0: using unchecked data buffer
> > > 
> > > What should a user do about it?
> > 
> > Nothing for a user to do. This is an indication that the passthrough
> > interface has been used with a device that can only use implicit
> > transfer lengths. It's more of an indication that improper use of this
> > interface might be the cause of memory corruption observations.
> 
> Could it be fixed by a firmware update?

Sure, it's just a spec feature that a firmware update could enable. But
I suspect devices supporting the feature also have hardware capabilities
to make it faster too, so I'm not sure if implementating in firmware is
desirable for all devices.
 
> I wonder if the level should be reduced then to info, or if it can be
> elaborated. Maybe:
> 
> The PC300 NVMe SK hynix 512GB can only use implicit transfer length.
> Improper use might be the cause of memory corruption observations.

There was a proposal to lock the interface down to known commands, which
I am absolutely against doing. I'm open to changing the log level or
message text to something better, though.

