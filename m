Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF397C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jun 2022 16:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WdcUbJ7ic4JxVVUrI2lsQv0sl1i278D3Qyk8PJBuGjI=; b=cBVrwlT8amErTMEEX0OaoRxP41
	V6wgMNdy6KELlbixCqb01GN/JHMoJo2WVDFdOUUEjNVqdtoe5s6VM6ZHZt5SQV12u5pakTKIue4h3
	v7+3pGkKP36cK3qwifXkJ/P8qaXIJJJgy2kZEoT0e6RECm+Jp2QddDtCVTp+7Cd/YxzQV7o6XcZup
	Xp7nLXmvkRIPakh8//1Op690O/dRbbi+yDOmGk/jyxRCXaxbsTFhX1RDe9uhDl1nVMaNdUENOlVCh
	1K33GBfKkZgeNZ/JP3BBuAYDu5kBwt8hYDa0IIG3V13+3UY8nM7EcWHtY0rmJt2VWRkcSGomIBTEl
	lLtB6Dfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyFWy-0021Ra-Sc; Mon, 06 Jun 2022 16:24:40 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyFWw-0021R0-Ju
	for linux-nvme@lists.infradead.org; Mon, 06 Jun 2022 16:24:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0333F60ACC;
	Mon,  6 Jun 2022 16:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87627C385A9;
	Mon,  6 Jun 2022 16:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654532677;
	bh=mtLfee9Bx8DrJcwaPAKjPVfMgxAETeU+QPZ4CTQzjBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WqlXho3KkCXDVeD8FWClwQMjaafep83RRtbb/+MdH1SuT4Hl617EsdNKGyCwUIt9W
	 rlNMcnglwPjc2BuK7NyZ+XZKf/BpjzCI1GdNOpS7ktM/vkLzwg3g1ZbNqlJSownkco
	 2SmEIG92dMWvfhICruLW7EvgMhxD7z4yYxLAWIo6q838M3NMh/MwXiiSH3PcLWzLAF
	 O0eMEZc/lvNVwO+JOc2X+2MbCScUAbABo8xfOPiN+DQi2ywwfZQW62I0bp4YIs8o4Q
	 MFp8MKWVNcaqjZRQxTyrc+mra2k+Kzr3Jrvpys8sfiG5s8tP/TafeDOmHAex17ymcj
	 dWRTBtuYFkDcQ==
Date: Mon, 6 Jun 2022 10:24:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
	bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
	pankydev8@gmail.com
Subject: Re: [PATCHv5 00/11] direct-io dma alignment
Message-ID: <Yp4qQRI5awiycml1@kbusch-mbp.dhcp.thefacebook.com>
References: <20220531191137.2291467-1-kbusch@fb.com>
 <YpcRLKwZpN+NQRxn@sol.localdomain>
 <Ypd3j9ABXhIuQDbt@kbusch-mbp.dhcp.thefacebook.com>
 <YpeP6u0XXAPra3MV@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpeP6u0XXAPra3MV@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_092438_737157_0A374C66 
X-CRM114-Status: GOOD (  18.20  )
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

On Wed, Jun 01, 2022 at 10:12:26AM -0600, Keith Busch wrote:
> On Wed, Jun 01, 2022 at 08:28:31AM -0600, Keith Busch wrote:
> > On Wed, Jun 01, 2022 at 12:11:40AM -0700, Eric Biggers wrote:
> > > I still don't think you've taken care of all the assumptions that bv_len is a
> > > multiple of logical block size, or at least SECTOR_SIZE.  Try this:
> > > 
> > > 	git grep -E 'bv_len (>>|/)'
> > 
> > There are only 8 drivers that set the request_queue's dma alignment, which are
> > the only ones that could be affected from this patch series.
> 
> It's actually even simpler to audit than that. Of the 8 drivers that explicitly
> set dma alignment, only 3 set it to something smaller than a sector size. None
> of them assume any particular bv_len, so I think we're fine.

Eric,

Do you have any more concerns on this area? I'm reasonably confident this is
safe with all the existing users, and I have a new series ready to go with the
trivial fix-ups from the last round. I don't want to post it, though, if you
think I've missed something.

Thanks,
Keith

