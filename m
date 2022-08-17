Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A217C25B08
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Aug 2022 15:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oqajguHcG8CjO5CsDKLe0kZuBMPf9Xm8jrSUnhbNhkc=; b=oha0HARk91UPV8E4bRzTs10fMg
	A+Xb7skFE08D+ZI9NGAd94gAwJxnKuNL7LonfJh9dedfT3bsYpwncmr2delcsxIV0fO2wOwU6aEH0
	/1YL2sTGTdIYw7pa+N9SoHGFrV0TSmPlFGnvq2koAL2vcx2ouzAcarqgoPCE6IurelNZV1OjlxMD0
	t4xlbPx8VoTmCDebUNXGsW66Sb352t7VfoZxaXIt58F5rPv4n9wh+AZk2Xuk9L03OkX6FTIx/msZ9
	LglnoFfHLMLKEM15Eeo90Mha8e0yNt05CQGBBLh1YcelNn4wAkoCEYLsjnW4/J8gqFMreKZZtqkgq
	lZi2l03A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOKeL-0036lF-LC; Wed, 17 Aug 2022 15:08:05 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOKeI-0036jY-Oz
	for linux-nvme@lists.infradead.org; Wed, 17 Aug 2022 15:08:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 59A1BB81DBA;
	Wed, 17 Aug 2022 15:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90091C433D6;
	Wed, 17 Aug 2022 15:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660748880;
	bh=hC4lz02MICHYsL+/UOx+piwliAc535Zna75HJ58qQ3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tgYi1rMZD4QnYrIkX0474nZyk3ysqqMZayoT85QjRgtyttTjPlbGJTm5HkVECvwZn
	 BFeQUZEDzDJfZFzofxz3h/Ndt7AMp6evsjlHXBtRZ/AvKisJ5dMrfYWwXEczImC/DR
	 QLbTEiO2EYTvTRVFFAu15pZgERno7fMN6Qs/UZh/j+z26TmoyU6C1TMtexMCgENb+p
	 I6kIRoMoaHwuR1uCqYbXeVyn+S9XAeHJ1sWz9BvW2+2qThxi3xQvculSOT+FoLo4rr
	 WNc9MRUTEHoxwC0L4Xl66OKidL4wZFqWXx29RvgOrL5uX6DHw3jF5/0IiPOfHLpBel
	 WbfBk2fgSDcgg==
Date: Wed, 17 Aug 2022 09:07:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@fb.com>,
	linux-nvme@lists.infradead.org, hch@lst.de,
	Jonathan Derrick <Jonathan.Derrick@solidigm.com>
Subject: Re: [PATCH] nvme: don't flush scan work with non-idle request
Message-ID: <Yv0ETKzC9QUDUvKI@kbusch-mbp.dhcp.thefacebook.com>
References: <20220812182147.1564958-1-kbusch@fb.com>
 <e034ba1d-b43e-6813-37b8-7b341dbdb573@huawei.com>
 <35b13f23-25fd-cff6-1e79-7f8d5ef3790f@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35b13f23-25fd-cff6-1e79-7f8d5ef3790f@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220817_080803_018643_56773115 
X-CRM114-Status: GOOD (  13.84  )
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

On Wed, Aug 17, 2022 at 01:29:37PM +0300, Sagi Grimberg wrote:
> 
> > > +
> > > +    /*
> > > +     * Ensure the namespace inventory is up-to-date before returning if
> > > +     * this command can change it.
> > > +     */
> > > +    if (ret >= 0 && effects & (NVME_CMD_EFFECTS_NIC |
> > > NVME_CMD_EFFECTS_NCC))
> > > +        flush_work(&ctrl->scan_work);
> > Maybe it is better to move nvme_queue_scan together here.
> 
> I agree, why not move the scan here as well?

Then I'd need to duplicate this to nvmet_passthru_execute_cmd_work(), and I
didn't want to do that. :)

