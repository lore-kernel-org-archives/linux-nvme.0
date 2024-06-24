Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE77C2D0D1
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jun 2024 19:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zG+cCltDsg+D/mNrCf0JRHkT87oIkxO7aXF53z3VitA=; b=AxLAiRHs3kFJWbzV3hfywuFxgB
	28N6FYWJYpMJBRYWuQe8Wzn0R+xf86ezOZVakMF26SGWI/aCJF4TlJBKKEkPjL8TFAWswelHPu12T
	NnaRKLBfy2mT6YxfrhowepiGvEksbnCTeM8xo/rzFR/Pd/WkEr52AUVucBFNBmKOzRBszAGv/3IHp
	md8AWahR0O/K83cwEkTDSgMu5DljrfZSCYC/O0qOO7fULjaqduRFcE1JTxKzqpKj4YjbJR9LqS2OI
	sXrKraF/mChcR60i2k588ZQNTiVrJetbXiEDv59WWwYzbm1JFuyiVugxmWXdw0OoebMmde+jxoihH
	As5XU+Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLpQX-00000000RJh-18NS;
	Mon, 24 Jun 2024 19:32:33 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLpQT-00000000RIa-40UJ
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jun 2024 19:32:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CE2C360B37;
	Mon, 24 Jun 2024 19:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D298BC32789;
	Mon, 24 Jun 2024 19:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719257548;
	bh=+dKYKA+KRJXy5GwuVBU1HjqUIkH8MLi3m5UtIKIps70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rQ680HL0uMuMNPv+RbGdynN36hAwAgr3JPIRLstxjw6F9XIgsnhNVdstSLP2pmPvS
	 vJHp9TBOhZQ7GnLWXqVSIgx2fQ4vXrG/0zturbN6vBr20bN1ZACNYtY4NQbY8ytiZi
	 zEtw95sUXuyeN8d2MV035DeGnkFIRpnojEA7qyKIvYyPpHjH68/zBCsPvke+hCS7M1
	 yiegl8qzMp/6+3HGXRY3TiU7so6nctRfSLCh1iwo4X1Y1rXDzVPvEYCa7WocfwbCbz
	 KvkrIqolDYANOrHVx/QCO2CUWQg7y+/7fwTYlUdRvGNY+63nNncDEHkbnA0l3xms8m
	 B+xvE2+YLUZ1A==
Date: Mon, 24 Jun 2024 13:32:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: dwagner@suse.de, linux-nvme@lists.infradead.org, hch@lst.de,
	sagi@grimberg.me, gjoyce@ibm.com, msmurthy@imap.linux.ibm.com,
	axboe@fb.com
Subject: Re: [PATCH nvme-cli] nvme: warn about attaching a namespace to
 unknown controller
Message-ID: <ZnnJyfZDg4xbxYDv@kbusch-mbp.dhcp.thefacebook.com>
References: <20240620125604.3017138-1-nilay@linux.ibm.com>
 <ZnWXc8wrNR_ijnTH@kbusch-mbp>
 <702e63dd-8fe6-4c23-89fd-7075573bb445@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <702e63dd-8fe6-4c23-89fd-7075573bb445@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_123230_196914_27111361 
X-CRM114-Status: GOOD (  25.30  )
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

On Sat, Jun 22, 2024 at 04:05:01PM +0530, Nilay Shroff wrote:
> 
> 
> On 6/21/24 20:38, Keith Busch wrote:
> > On Thu, Jun 20, 2024 at 06:25:45PM +0530, Nilay Shroff wrote:
> >> Sometime it's possible for a multi-controller NVMe disk to have only
> >> one of its controller discovered by the kernel. And if this happens
> >> then it's also possible for a user to create and then attach a namespace
> >> to a controller which has not been discovered by the kernel. In such a
> >> case the attached namespace can't be used for IO because there's no path
> >> to reach such namespace from the kernel.
> > 
> > Isn't that a pretty normal thing to do, though? Like for an sriov
> > situation, a primary controller attaches namespaces to secondaries, but
> > not to itself.
> Yes correct, but in case of sriov, AFAIK, the "nvme list-secondary ...." shall 
> not list any secondary controller unless the secondary controller's corresponding 
> VF is enabled (i.e. /sys/class/nvme/nvmeX/device/sriov_numvfs set to at least the 
> secondary controller's VF number). 
> 
> So it means that before attaching namespace to secondaries, user would first set 
> sriov_numvfs. Setting numvfs would then enable the kernel to discover all secondary
> controllers. 

You'd usually bind those to vfio, not nvme. So while the kernel knows
those pci functions exist, the nvme driver doesn't necessarily know
about these.

And that's not even an sriov exclusive thing. You can bind other PFs
just the same, though they just don't have the resource provisioning
features that VFs can do. But you can still attach and detach namespaces
to/from them all the same.
 
> However, in the proposed patch we're trying to address a case where "nvme list-ctrl ..."
> shows multiple controller entries however only one of those controllers is discovered
> by kernel. All controllers shown in the output of "nvme list-ctrl ..." are physical
> controllers on the nvme disk. In this case attaching a namespace to any of the 
> undiscovered controller has a side effect due which the namespace rendered unusable.  

Unusable from the driver the admin ran the command from. Some other
machine (real or virtual) may be able to use it, or maybe even the same
machine that you handed some function to a user space driver, and that's
not really an error.

> This patch tries to address this issue by showing a WARNING to the user and optionally
> allowing user to cancel the attach operation. However if user still prefers to go 
> ahead without cancelling the attach operation then nvme-cli would execute this command
> as usual. 

Have you received bug reports of people mistakenly attaching namespaces
to the wrong controller or something?

