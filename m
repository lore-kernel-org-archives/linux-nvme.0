Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87319C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 15:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7ug3iu3bEXF78gnrgDTdjFOkTTSr8wz2XMT9Oa9w0AI=; b=eYJWTrFWUsyOOvEoyPXJYtE/wM
	Z99tGCl9WY29keWr/OydyxWg3TIMKVn1L7SxOSDLbi0BwSV8pJaoCywLBA9dktGQc5YCU9SestoqS
	mN9NNHOBcvCA50AAs0QKrril4P35SvvbcgeQlq2EJI89YxpS/WwGJ4PdEYzVM3abigKzqlmRIG1VJ
	PDjri+ezy91vSlWBmyN/uzGkFAX64MnVIE9ELEG9FsliHfxuafV4CguDXTTorBXbsKQIPBKk5NJLU
	kuoka+tblFILYED4OZ87s11t8FimHwaH7V1fzvYjDjc0Qxt/g3vo2XRcO5AtOthmN3RwfNprhds1T
	28SkUUOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeHkm-00A6mb-4w; Fri, 30 Sep 2022 15:16:40 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeHkQ-00A6Yr-Ad
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 15:16:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 724EECE25F7;
	Fri, 30 Sep 2022 15:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD10C433D6;
	Fri, 30 Sep 2022 15:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664550972;
	bh=ivbMMPx0EIBUlLwHU3p53chkbIAEt6dlqzQqe+SbtnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c6E++ATP+ikY3/hEwW7knO0JNWDL39kWA84nMeRTFeyIWYIuJ1WHgMs+zECY/v3nc
	 CtQ4lFModWKWf7u5ddwgbqTLwV8wlybjyyIBTc4MljG8riW79tlhMYt6SqMVHiqjuO
	 cOXih0t2YsMTUTkPLivfkyNjFzWKeIrF1X9vXSnLOOwkGV82azg+rC+TYalh4uOFGZ
	 N4JrInxUuzOOEqtfSiJZA1K7pPejZ0lU0gsmpSxoxpH7RCuOChFV/oW+TwxPSaKgpk
	 lqjdOjOmpwVqP5Od89E7wR38g0ET9HAgbC/PumcwyIin5/vTpqtQ13yyP+ivXsSgOf
	 S3KIQR6uvuu2w==
Date: Fri, 30 Sep 2022 09:16:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Message-ID: <YzcINzNpZ+4zkupd@kbusch-mbp.dhcp.thefacebook.com>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
 <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
 <YzWzvOKgoAqltAA0@kbusch-mbp.dhcp.thefacebook.com>
 <e5299b5e-5e9a-5a2a-b7dc-30de2bf43adc@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5299b5e-5e9a-5a2a-b7dc-30de2bf43adc@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_081618_557822_858FDFA2 
X-CRM114-Status: GOOD (  18.63  )
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

On Thu, Sep 29, 2022 at 07:32:39PM +0300, Sagi Grimberg wrote:
> 
> > > > 3. Do you have some performance numbers (we're touching the fast path
> > > > here) ?
> > > 
> > > This is pretty light-weight, accounting is per-cpu and only wrapped by
> > > preemption disable. This is a very small price to pay for what we gain.
> > 
> > It does add up, though, and some environments disable stats to skip the
> > overhead. At a minimum, you need to add a check for blk_queue_io_stat() before
> > assuming you need to account for stats.
> 
> But QUEUE_FLAG_IO_STAT is set by nvme-mpath itself?
> You mean disable IO stats in runtime?

Yes, the user can disable it at any time. That actually makes things a bit
tricky since it can be enabled at the start of an IO and disabled by the time
it completes.

