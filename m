Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706E6C48BF8
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Feb 2024 20:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k+/GlGXnRcFXsy3LEgIo9ZI58ADiQz752Ul04hDyrK4=; b=kyI3Zh/JphXuYKdGqFTJVfaaRa
	6pdPlpo9SShxxQu2HGZZQQc+8GHwld1zqRp0C+PFUXRKE8Ue+0CTCOhik22liD1WauabUTm7UGChv
	H6b2O170j8bNmbCGhG8dTjlHW7WByClQacy7kdfiGfg2HXyq3K0z3183DPXWzWMvUQlSL85GO6SnZ
	zsNMYpBS9QA5wFysQTT1Bztxt3AUoVKIV9Tu7mT/WXcfuQmqjG/VedGMn06QMXAUc2D6plQJB6F1z
	GKzZ0LboFoQJSzy90jqWAuRJc+FL5mECZdVhq5GmoAfCsxtJbYrtbdQZFpH63m+4cCIkVOWuQ4WKG
	4CneHhgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdFo9-00000006WZ4-2rCh;
	Thu, 22 Feb 2024 20:36:41 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdFo3-00000006WYi-1xNa
	for linux-nvme@lists.infradead.org;
	Thu, 22 Feb 2024 20:36:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D3DE063323;
	Thu, 22 Feb 2024 20:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA81C433C7;
	Thu, 22 Feb 2024 20:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708634194;
	bh=JiKEJMqBMWf0r59f8rIUNxIE63i+W+PGvBWycBv+roE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dGpFPsh8jEH0DKn47mjVCA8Y5hPjLzw2sgOfVy+XmGBBBOwsJaGEHgD5P/XbcF3+c
	 hDx3trVAiy8+bS+CmiF6yR5QsOvUICeUnolcDcKuUrsNFvZFYmnHKTdjFw2iN6yg6V
	 +Z7fYCeJnorqCzbJB53uKZq6hdRwT6fLe2uWJRvp0lhRSlojyHCPTIAsSclZJxRnTY
	 /csQdGnOfqPEXiAkR2V73jjCdZ2ypKbWgHwVTVk2OpA+asRcnhb+hAARrlg5AWVkaM
	 YikwTI74/xQkk5O8p8A7paezm5Qq1ujAbwMqxuSJqHHijKvHyEsAohowp9taV0ZQh5
	 gq+J2tektcUew==
Date: Thu, 22 Feb 2024 13:36:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Michael Kropaczek <Michael.Kropaczek@solidigm.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v1 0/1] nvme: Fix problem when booting from NVMe drive
 was leading to a hang.
Message-ID: <ZdewTyX522lO3pTP@kbusch-mbp>
References: <20240221084340.825068-1-michael.kropaczek@solidigm.com>
 <Zdd2BOp6DEC6N51V@kbusch-mbp>
 <PH0PR10MB541949F6392DE75106A93A0192562@PH0PR10MB5419.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR10MB541949F6392DE75106A93A0192562@PH0PR10MB5419.namprd10.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_123635_578313_1C4728DC 
X-CRM114-Status: GOOD (  15.26  )
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

On Thu, Feb 22, 2024 at 08:02:52PM +0000, Michael Kropaczek wrote:
> The function nvme_dev_disable() changed here is called from the nvme_shutdown() subsequently through nvme_disable_prepare_reset() with the flag shutdown being set as true.
> 
> Considering the re-usability of the code, would it be correct to wrap up the change into if(shutdown) statement?
> 
> The reason for asking is that disabling of host memory should follow other calls as well and placing it within the body of nvme_shutdown() would require more adjustments.
> 
> The call to nvme_disable_prepare_reset() with the flag shutdown set as true is made whenever the NVMe controller should be shut down anyway.

Just calling nvme_set_host_mem() should be sufficient; no need to free
the memory here as we may just be giving it back to the device on the
reset or resume side.

And per spec, the device is supposed to automatically clear its host
memory enabling on a reset or shutdown, so this shouldn't be necessary.
Sounds like something isn't spec complaint in your environment.

Going through the git histroy, we use to disable host mem here, but
timeout handling doesn't work within nvme_dev_disable(). All the
operations done from here need to guarantee forward progress, and this
set function command doesn't do that. The only example of admin commands
that handle their own timeout is the queue deletion sequence.

