Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AB6C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jun 2022 16:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4SIqs3gbZs3xBzinqWl/p/Sena3DcXQodasDZMAZIyQ=; b=WkYjoUHpt8cOqPV27Q3qvbj63b
	VGKXLJbV7DNeycQhi+BFTCqszM16lFysS4pA2YgygjFqfoyb9A8qsU3Tk0I+OLK6cgIlVaO235v8m
	EsEAQhvcRisgyp3AX7ojGLW712jYqyecsMooGH8DnpYSSBEtBqokp5THo5RZc7p31UiWhorcEh684
	lik18PyKkXe0jyPnClodOD+ziOAl2r+Xuc5Focw5epoG3KkhHf8sYG4EeF00pTuQ944va4pph9B5f
	X4WrAUkILLn2jFfGeZ4i24uJf0K5sTWCHOAaZBOkaHFytq8ppKraWBNJMlYJDx2UtucX5+zPPUPcR
	onvBN3ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyFkD-0026FM-Fk; Mon, 06 Jun 2022 16:38:21 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyFkA-0026D5-4f
	for linux-nvme@lists.infradead.org; Mon, 06 Jun 2022 16:38:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id A78E6CE1BF6;
	Mon,  6 Jun 2022 16:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F07CC385A9;
	Mon,  6 Jun 2022 16:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654533490;
	bh=m3OKX/0tOW57YAFAXNwERMVq2/lnf8KwKOn8zar2Lso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XpVN7csIWXjt7AI3jZa9ap09T2BX5+GW1R8WvxJ+/sTWSY7qAFWlQDB02FqogZqLE
	 rH7zpQ0H9V6UHsyLhf0nAk6fBkcqmwDPpre2zP7Edy2Heb/jLXc0E7TT3v0Od/dijR
	 h8ydbzzaKRZ2Ag56D9ddTCDEaw+/TGySb1RA03IpX7QVlajkor5DYIJwvRqjJ4CZHE
	 rmp4xeAZzPjtJNPjTSjt9B89qaywMyO0kBQKBeDMpS9C52iBYCa6tWGJ8qqToFbDOE
	 G6C3txMShThaNGvigGRetLZDuBpDvExbxIS7CSlmSDpM9PBOVvig0SW2QBlOGdtruH
	 yuXXMbyDvsfCA==
Date: Mon, 6 Jun 2022 10:38:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc: "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Caroline Subramoney <Caroline.Subramoney@microsoft.com>,
	Richard Wurdack <riwurd@microsoft.com>,
	Nathan Obr <Nathan.Obr@microsoft.com>
Subject: Re: [PATCH v2 2/2] nvme: handle persistent internal error AER from
 NVMe controller
Message-ID: <Yp4tbtPZzDe038Kz@kbusch-mbp.dhcp.thefacebook.com>
References: <1654278961-81423-1-git-send-email-mikelley@microsoft.com>
 <1654278961-81423-2-git-send-email-mikelley@microsoft.com>
 <Yppfm5n41NEcrRlU@kbusch-mbp.dhcp.thefacebook.com>
 <PH0PR21MB3025781A702070304BB8A282D7A09@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB3025781A702070304BB8A282D7A09@PH0PR21MB3025.namprd21.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_093818_397927_0E8F9FFA 
X-CRM114-Status: GOOD (  22.44  )
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

On Sat, Jun 04, 2022 at 02:28:11PM +0000, Michael Kelley (LINUX) wrote:
> From: Keith Busch <kbusch@kernel.org> Sent: Friday, June 3, 2022 12:23 PM
> > 
> > On Fri, Jun 03, 2022 at 10:56:01AM -0700, Michael Kelley wrote:
> > 
> > This series looks good to me. Just one concern below that may amount to
> > nothing.
> > 
> > > +static void nvme_handle_aer_persistent_error(struct nvme_ctrl *ctrl)
> > > +{
> > > +	u32 csts;
> > > +
> > > +	trace_nvme_async_event(ctrl, NVME_AER_ERROR);
> > > +
> > > +	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts) != 0 ||
> > 
> > The reg_read32() is non-blocking for pcie, so this is safe to call from that
> > driver's irq handler. The other transports block on register reads, though, so
> > they can't call this from an atomic context. The TCP context looks safe, but
> > I'm not sure about RDMA or FC.
> 
> Good point.  But even if the RDMA and FC contexts are safe, if a
> persistent error is reported, the controller is already in trouble and
> may not respond to a request to retrieve the CSTS anyway.  Perhaps
> we should just trust the AER error report and not bother checking
> CSTS to decide whether to do the reset.  We can still check ctrl->state
> and skip the reset if there's already one in progress.

That sounds good to me. Christoph noted RDMA isn't safe to do this in the
callback anyway, and it's probably a bad idea in general to dispatch new
requests within another's completion: that may prevent reclaiming the only
available tag, and then deadlock.

So with that in mind, this AER persistent error handler could call
nvme_should_reset() with NVME_CSTS_CFS as a constant value for the csts
parameter.

