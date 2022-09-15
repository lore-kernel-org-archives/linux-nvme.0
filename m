Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37CFECAAA1
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Sep 2022 22:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZLUj75T80VTCd3MCk+1uA7yofZgULgc4TieYgwThZSQ=; b=1QnAMUhASChjCAXY4PSI//1v0u
	+WxsU1/2YWJ8UkhCzu6JoKkC/OP7r/u+Xv4RPyfHVh9ofvUreGYQc/wEyQRf1q6xSdWiMcpdSTD2m
	hGXQ6sINDhKhtlaaV0PHIBQKHcymG72kNN2984MTcbGCUYrF9mfCqUA0VJO5sHxouqOzr0W1WU6ew
	0jd3+5YMwilvj8acvIf85Jo3mCJqZyEscSEwPKMzJANdzRYYtZoEulLoDrWiRextxLfNArB2OpYtm
	BvEmClqrLsfb1W7WAcTWD+5zcYlxyfnrh1KWimplsLZV6YnvqGiddyDH8vJH2N9U5m6lH1qV2/o/u
	4AEa57qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYxHw-0015Y6-Bc; Thu, 15 Sep 2022 22:24:52 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYxHt-0015Mz-N3
	for linux-nvme@lists.infradead.org; Thu, 15 Sep 2022 22:24:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 291CAB822AB;
	Thu, 15 Sep 2022 22:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D42C433D6;
	Thu, 15 Sep 2022 22:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663280686;
	bh=36GI720A9K10qvDDcwbW2T7hsA3bBfCkivMXn8z7jsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cvYbJkSqR1FR5vKaKL3NHyZyBcZWJEzqRj8+bT/ySR6tsw0i2zNwf3oM/Ih5uhWzY
	 fF4DKDpLpLDmdjCmv1d40ZgOOdl+ewcx8TAyt7shheJKDT8T/rG6XdWqFTZl1yWM0/
	 1yCWLVdT+85L6bS6sW6hZw+uf+joB2hbMt6Hb3HsGCamEg0/76gD5NWsL9NDJh9ORV
	 Q4nsk4WaNerv0NGyOzPokKiHRsgzFYIMa8kjIx5OMvrPfsE/7vr3ewzfAsGAcCWPpd
	 875WwmuKPLhHPWKNpbwnraZEYU1pbIc83MlZruaBOJV7v08TnRXwQDKgumLjhuoAnJ
	 fQGqjihJMwhBw==
Date: Thu, 15 Sep 2022 23:24:42 +0100
From: Keith Busch <kbusch@kernel.org>
To: Nick Neumann <nick@pcpartpicker.com>
Cc: y@kbusch-mbp.dhcp.thefacebook.com, linux-nvme@lists.infradead.org
Subject: Re: smartctl "kills" specific drives on kernel 5.13 but works fine
 on 5.15 - why?
Message-ID: <YyOmKiQXdpORZwbB@kbusch-mbp.dhcp.thefacebook.com>
References: <CADqNVTpcFuPh8w3Gcx2ftYh_4EjObxpenA2Ps2y=055W0o13=A@mail.gmail.com>
 <CADqNVTp0KfQsegsEQn09-Tuc0b76_jWuir9UbDCe44o+rHr=0w@mail.gmail.com>
 <YyOFAvJR9mWo+57C@kbusch-mbp.dhcp.thefacebook.com>
 <CADqNVTqMcQvZ8_+BPez=ti3-V0wE2jOQCuOSoy5eT43RauFPAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADqNVTqMcQvZ8_+BPez=ti3-V0wE2jOQCuOSoy5eT43RauFPAg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220915_152449_935436_1D8FB2DB 
X-CRM114-Status: GOOD (  25.81  )
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

On Thu, Sep 15, 2022 at 03:48:01PM -0500, Nick Neumann wrote:
> On Thu, Sep 15, 2022 at 3:03 PM Keith Busch <kbusch@kernel.org> wrote:
> > Not sure what MDTS has to do with this. The error log was originally defined to
> > be a max 4k size which is below the smallest possible MDTS.
> >
> > My guess is smartclt tricked the driver into allocating a PRP List, but the
> > controller instead accessed it as a PRP entry, which could corrupt memory or
> > fail the transaction if data direction is enforced by the memory controller.
> > Why that causes the nvme controller to fail as you've described is weird,
> > though.
> 
> I definitely don't know this stuff very well - the smartctl bug
> commentary was referencing the nvme-cli commit where log pages are
> transferred in 4k chunks to avoid having to worry about exceeding the
> MDTS value. The problematic drives have error logs larger than 4K.
> 
> I believe the logic in the smartctl commentary was along the lines of
> "well, the MDTS is large enough that we should be able to transfer
> more than 4k at a time, but we're currently crashing. And nvme-cli
> does it 4k at a time always, and if we change to that, the crash goes
> away, so let's do that."
> 
> As to the allocation, smartctl calls into nvme with
> nvme_admin_get_log_page and passes a buffer (that smartctl allocates)
> of size n * sizeof(nvme_error_log_page), where n is the number of
> error log entries it is trying to read. The fix in smarmontools moved
> from trying to read all of the error log entries at once via a single
> call to nvme_adming_get_log_page, to doing 4K bytes at a time.
> 
> Not sure how helpful any of that is; it's where my current understanding is at.

If 'n' is > 64, then that would tell the driver to allocate a PRP list, and I
am pretty sure based on the observations that the drive believes the address is
a PRP entry. That doesn't readily explain why your ssd became unresponsive
immediately after dispatching the command, but the drive definitely sounds
broken.

