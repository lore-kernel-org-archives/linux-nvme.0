Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90D4E7B604
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Oct 2023 12:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/eoQ+gE0DAEWa8dzBNEpuzvp9IR+53HqwX/wgEBE55Y=; b=sIbCnBAbd91tz3GJrsdJEXKhE3
	C9t0rHxSh6hygy91v2rWvhiiqf/GBI2atk71tkXxRQIqEsl/cbB0h4+M9Zg2YnsrLsiHsF9LU+vRl
	/CGSuI167EvJcH8o59sbIMUffLsEIeBZg6jUsw5/UOkTGGoIPGK9higUe/iDH0+6wbySAsYWUehef
	0qkOkufKSld9yPHiE2ukLxK6QgrnNE0u61xSLOqSxWD+iInoBsvXhi9T0PEwUNo7Op5X9koE72Ws4
	GiLA3M0QL+Lre8N48cXh8YXufxdAVu9+Ab5Ch5Re9GMvIhRugkK8plYfDibRdZ4dV4yXfgfQosUPQ
	O0M/a17A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qo0x2-00Hax1-2i;
	Wed, 04 Oct 2023 12:26:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qo0wy-00HawO-2R
	for linux-nvme@lists.infradead.org;
	Wed, 04 Oct 2023 12:26:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B32CF61519;
	Wed,  4 Oct 2023 12:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02474C433C8;
	Wed,  4 Oct 2023 12:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696422358;
	bh=/+k15foB42xwn1SO0nA4WG6oVVxx5pbkztYvznyKKcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vRDJcgP8MEYq3+aYyQHEC9YzNXyC1qwgn9X6YC7HCyni1XmC4gkZ75hXi2KiDX8ub
	 hH0nClqCrTq6Pj2EKA0G6fIGmZFIHb3Ing9oFANX3sQ/O9xhK46EbMVZ7Z30BMGDUF
	 VZJrB9hx+loATVabEstZnHPGOKMiwnUd6Alq92Qc=
Date: Wed, 4 Oct 2023 14:25:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: sj@kernel.org, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	zahavi.alon@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: Fix a possible UAF in queue intialization
 setup
Message-ID: <2023100445-twisted-everyone-be72@gregkh>
References: <20231003164638.2526-1-sj@kernel.org>
 <1ed79a61-0e74-7264-cb70-c65531cf60e2@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ed79a61-0e74-7264-cb70-c65531cf60e2@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231004_052600_837838_8594DC9A 
X-CRM114-Status: GOOD (  22.56  )
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

On Wed, Oct 04, 2023 at 12:41:30PM +0300, Sagi Grimberg wrote:
> 
> > Hello,
> > 
> > On Mon, 2 Oct 2023 13:54:28 +0300 Sagi Grimberg <sagi@grimberg.me> wrote:
> > 
> > >  From Alon:
> > > "Due to a logical bug in the NVMe-oF/TCP subsystem in the Linux kernel,
> > > a malicious user can cause a UAF and a double free, which may lead to
> > > RCE (may also lead to an LPE in case the attacker already has local
> > > privileges)."
> > > 
> > > Hence, when a queue initialization fails after the ahash requests are
> > > allocated, it is guaranteed that the queue removal async work will be
> > > called, hence leave the deallocation to the queue removal.
> > > 
> > > Also, be extra careful not to continue processing the socket, so set
> > > queue rcv_state to NVMET_TCP_RECV_ERR upon a socket error.
> > > 
> > > Reported-by: Alon Zahavi <zahavi.alon@gmail.com>
> > > Tested-by: Alon Zahavi <zahavi.alon@gmail.com>
> > > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > 
> > Would it be better to add Fixes: and Cc: stable lines?
> 
> This issue existed since the introduction of the driver, I am not sure
> it applies cleanly that far back...
> 
> I figured that the description and Reported-by tag will trigger stable
> kernel pick up...

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

