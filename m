Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F99C83F17
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 20:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u2hqk4IMiC8gT+JOhPfJzG/+6eMwp3OVyQdyw/vrSrg=; b=IqGndVi5CWK7Q6X7W/uSXD2CvD
	r8turP9ppJxwh+Dqv2gh7U2zK7r50xNErlPOYHwWg2VhV+RgCYAz4yDlIgng1Q5afsSSHp+jAf6R9
	ctMpe5Qzum4ojq36ZvavqCdudoGlaVbNkt/BdCNerEujQQDCqSk61O3eOAT7PIACWa+QpF864AjqF
	NRS+abQEXZWst7ZuS2Xx61fwB5/5erML5lSB144awETiNLWMW8c09kSJkkRBpOfC/E+XU5ltZ0F2c
	r3T26gV8+0uMzeySvI9ulGCSFGLh2HRJtBK3/VIYuaoJ/fELYWFmiKSZRC8axmH/wTnciTLiqwBLS
	WGWH8b8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ublta-000000068W6-0wvt;
	Tue, 15 Jul 2025 20:04:58 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ublsY-000000068Hu-1pds
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 20:03:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2E3BCA57162;
	Tue, 15 Jul 2025 20:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D116C4CEE3;
	Tue, 15 Jul 2025 20:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752609832;
	bh=9s8LdlwXdcYypN+nIN7f6z5gfWpxbZo9Ck1C0HbdBGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQNBvoiMDXt/n8TBQsPZnTtR5ISkLWVF9kcSyFKPI2osHvnFIxQMXWuPXh5bdOBl6
	 uYeFaRi58fxGlw3Py1QZwEmD7mpqf1wue7/Q5i2KwPzBNF9BP3UtisJn5cQCX5htxX
	 hLH+JaE1oMp/+ne5OwEUfH4VvkQRvjM9TtbyuYKxIDalu9tWIQjvilRsMsF4eZB9s/
	 sUNGlGQ6pNGVcLuRBpAffcJ4g+1Qo2jjjH4tRGAO6ETHDPfVv45BaWrSAaWXRxY4GU
	 9ebAKE4ltklBT9Sys3dBS6DAlISgRVUs6PdlNRfPWGH1hXe1Io8ysOWzklznDs0128
	 gSrvehqe2ciUg==
Date: Tue, 15 Jul 2025 14:03:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	james.smart@broadcom.com, dick.kennedy@broadcom.com,
	njavali@marvell.com, linux-scsi@vger.kernel.org, hare@suse.de
Subject: Re: [PATCH v8 7/8] nvme: sysfs: emit the marginal path state in
 show_state()
Message-ID: <aHa0JpsASqGuHdOA@kbusch-mbp>
References: <20250709211919.49100-1-bgurney@redhat.com>
 <20250709211919.49100-8-bgurney@redhat.com>
 <aG7pSA6TOAANYrru@kbusch-mbp>
 <35738598-0733-408c-8597-20c3599a8973@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35738598-0733-408c-8597-20c3599a8973@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_130354_540947_E3C02F53 
X-CRM114-Status: GOOD (  21.54  )
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

On Tue, Jul 15, 2025 at 03:42:32PM -0400, John Meneghini wrote:
> On 7/9/25 6:12 PM, Keith Busch wrote:
> > On Wed, Jul 09, 2025 at 05:19:18PM -0400, Bryan Gurney wrote:
> > > If a controller has received a link integrity or congestion event, and
> > > has the NVME_CTRL_MARGINAL flag set, emit "marginal" in the state
> > > instead of "live", to identify the marginal paths.
> > 
> > IMO, this attribute looks more aligned to report in the ana_state
> > instead of overriding the controller's state.
> > 
> 
> We can't really do this because the ANA state is a documented protocol state.
> 
> The linux controller state is purely a linux software defined state.  Unless I am wrong, there is nothing in the NVMe specification which defines the nvme_ctrl_state.

Totally correct.
 
> This is purely a linux definition and we should be able to change is any way we want.

My kneejerk reaction is against adding new controller states. We have
state checks sprinkled about, and special states just make that more
fragile.
 
> We debated adding a new NVME_CTRL_MARGINAL state to this data structure,
> 
> enum nvme_ctrl_state {
>         NVME_CTRL_NEW,
>         NVME_CTRL_LIVE,
>         NVME_CTRL_RESETTING,
>         NVME_CTRL_CONNECTING,
>         NVME_CTRL_DELETING,
>         NVME_CTRL_DELETING_NOIO,
>         NVME_CTRL_DEAD,
> };
> 
> If you don't like the flag we can do that. However, that doesn't seem worth the effort since Hannes has this working now with a flag.

What you're describing is a "path" state, not a controller state which
is why I'm suggesting the "ana_state" attribute since nothing else
represents the path fitness. If nvme can't describe this condition, then
maybe it should?

Where does this 'FPIN LI' message originate from? The end point or
something inbetween? If it's the endpoint (or if both sides get the same
message?), then an ANA state to non-optimal should be possible, no? And
we already have the infrastructure to react to changing ANA states, so
you can transition to optimal if something gets repaired.

