Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D4FE77188
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jan 2025 22:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vgo7P96F60sWL32Sfr6j/TrxOK6Tt74Hyg4mryZBpN0=; b=XRCChFZhZWS5ZKF8P0x5lE/SO4
	I8L2oExx9RTiCU2ozup77hr7PaTXAg7b+BFwucq7qg/VqxLjPj1C8oRErywpacF6rGblH+XCnhxpf
	XVsrA+f6XrbJ4jBLFzBxg+In40dHfSkWnPKY+henZ7OWTfg5SBoBkMdTV4GrQ5d/xuiXaMTl/ef0l
	Vs3BfSBrQSNGl2nVhqStvVCxDj8ZrxkfxSg9HUq3nnNtVrH6kf9JO1uI6xCZU1UhOmmOgYVRldKsz
	PGXGg3KlL0tDm2a0muT6FMdMzTTiNjLzkx4tNRsS4uWNcCnZF/FzqU69ViSq7rsDToxsy2FC2dgTg
	/ZNfF2gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tX6be-00000003YPq-0dux;
	Sun, 12 Jan 2025 22:38:54 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tX6bb-00000003YPN-1fGp
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jan 2025 22:38:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 068295C4859;
	Sun, 12 Jan 2025 22:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAE4C4CEDF;
	Sun, 12 Jan 2025 22:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736721530;
	bh=L/WlMsAx9Yvm4+ufvt5prp58wny7PmlcIpSSmtlcHiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JWoc+oMiFNNlzDTb8qvgemE68/vrA8F6gHGghPvwTlCnWrc5+fP/4VHbwVcyl6NqN
	 emjaXezJiekE3fiV1AJnzNfdNzw6rPa6yWtN0Z0BOlmJkRK/gil3hrgklXx1doTG3B
	 FAA8ucwLbCjU6ZpN+sbAW7X303R1iT7BDGkJlbANJFo4oOVRdkbdLkbPFmgAUKeQ5k
	 9jB77V9fB3+kIqOsdoKlXfUWP3Xd5rQ3NywrxHYDdPL5kzsqaGML31gKxZ9MI61SEM
	 pJPs0/WRMTAAO9fFyEWwyTAl/rb2M19t2UlxR/+3XMbz4vBDP39ciiQ/yw1Ia88qDS
	 Uerap0t/ypyiQ==
Date: Sun, 12 Jan 2025 15:38:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 09/10] nvmet-tcp: support secure channel concatenation
Message-ID: <Z4REeAUzXi3z2jeb@kbusch-mbp>
References: <20241203110238.128630-1-hare@kernel.org>
 <20241203110238.128630-11-hare@kernel.org>
 <Z36o7IqZnwkuckwF@kbusch-mbp>
 <69208b76-71ac-464f-bdb9-50c9c5558ac6@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69208b76-71ac-464f-bdb9-50c9c5558ac6@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250112_143851_476537_BA67527A 
X-CRM114-Status: GOOD (  18.81  )
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

On Thu, Jan 09, 2025 at 08:33:51AM +0100, Hannes Reinecke wrote:
> On 1/8/25 17:33, Keith Busch wrote:
> > On Tue, Dec 03, 2024 at 12:02:37PM +0100, Hannes Reinecke wrote:
> > > Evaluate the SC_C flag during DH-CHAP-HMAC negotiation and insert
> > > the generated PSK once negotiation has finished.
> > 
> > ...
> > 
> > > @@ -251,7 +267,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
> > >   	uuid_copy(&ctrl->hostid, &d->hostid);
> > > -	dhchap_status = nvmet_setup_auth(ctrl);
> > > +	dhchap_status = nvmet_setup_auth(ctrl, req);
> > >   	if (dhchap_status) {
> > >   		pr_err("Failed to setup authentication, dhchap status %u\n",
> > >   		       dhchap_status);
> > > @@ -269,12 +285,13 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
> > >   		goto out;
> > >   	}
> > 
> > This one had some merge conflicts after applying the pci endpoint
> > series from Damien. I tried to resolve it, the result is here:
> > 
> >    https://git.infradead.org/?p=nvme.git;a=commitdiff;h=11cb42c0f4f4450b325e38c8f0f7d77f5e1a0eb0
> > 
> > The main conflict was from moving the nvmet_setup_auth() call from
> > nvmet_execute_admin_connect() to nvmet_alloc_ctrl().
> 
> I'll give it a spin and check how it holds up.

Sorry, I had to drop this from 6.14 for now. The build bot tagged us
with the following error. It looks easy enough to fix but I can't do it
over the weekened before the first merge window pull :)

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
branch HEAD: f28201922a357663d4a2a258e024481e19269c2c  Merge branch 'for-6.14/block' into for-next

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202501120730.Nix2qru3-lkp@intel.com

    auth.c:(.text+0x986): undefined reference to `nvme_tls_psk_refresh'
    csky-linux-ld: auth.c:(.text+0xa00): undefined reference to `nvme_tls_psk_refresh'

Error/Warning ids grouped by kconfigs:

recent_errors
`-- csky-randconfig-001-20250112
    |-- auth.c:(.text):undefined-reference-to-nvme_tls_psk_refresh
    `-- csky-linux-ld:auth.c:(.text):undefined-reference-to-nvme_tls_psk_refresh

