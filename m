Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB57E77197
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 16:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vKEYPwzHb0s6ehp+WUOFVjn5LiDLyqowuPo93MSyWFE=; b=BM9pYnLTRg/mQyzrK56oiX7/kQ
	doAzYy2gJt5LvCJU+S4SgBxf636BOT3TYh/aPw03b7BG2WLI/THhKFJyI5fmeLm1xuKhcqYXpdhVG
	2nsIshfHig4rS5JRPtVy4MpEzRM0dS+cAgoK2gyIlFWnZnpRQ3CTsX1Crf/YrSsTsfjHMFqUB94wd
	VYpI50sEZ9GZax5Sj/eZ7jYLqJdcOet1BLup7jk0M+kejegxAKCl1bJ9AbFPz5W527X/+5fUrn0QG
	/nOghyjl7wlsTdbMtnKEXAbpkUpyZwHSC18ZKxE2pYcJx2qr++AAtOFCSEPjqDF3L06g4oYFTCV/g
	5FnmX0Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVC1p-00000005Y36-3B72;
	Tue, 07 Jan 2025 16:02:01 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVC1n-00000005Y2g-2c6k
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 16:02:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 951F7A418DD;
	Tue,  7 Jan 2025 16:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949DEC4CED6;
	Tue,  7 Jan 2025 16:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736265718;
	bh=/+HU5/mhBCkZO+L3TK8D5nHLBv1ZlgsdC7b2RZqpOHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qa+KrZQ2z2ugfWnWhPpGnqH+0sv7sGYp+j8LP37ft0cETM0XnTAsfm1+KRjBmeRWK
	 SqC+LlphIhNo4bDPW+jWxi4Sm2qZeP76GBlHO/tGwGl5bUCkc8uC3CP14uWW062z4x
	 ev3YE+YyCNi/IYHuj8gbz+K3vx43rnvSHdixYl3fX1eG8ujq90leODTd7/iqJ/WRH6
	 fq7Mcx6qfRN0+IvTXMU4wMSHa3kNq4G5/Ka1jL4H25Ny/11iJSh1E/w5iVAOP1pS/v
	 wdWnjt3+2r4eNXkkfTlOMEDktR1LkTXIxav0yphRvpaAH5pOL7oTTjJkS7KDJCVg4A
	 hbnCHoe6AXkhg==
Date: Tue, 7 Jan 2025 09:01:55 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Remove namespace when nvme_identify_ns_descs()
 failed
Message-ID: <Z31P8wBVJ9Y-oXfb@kbusch-mbp>
References: <20241129140608.115282-1-hare@kernel.org>
 <Z09Y30pUtAg0xwoR@kbusch-mbp>
 <4ba05af4-9464-4cdf-a306-60585793c46e@suse.de>
 <Z1CF2vn1_xkNIVAM@kbusch-mbp>
 <99025917-e201-4ec9-ba04-e979f61c411b@suse.de>
 <Z1HRkKr5LhfvfLAs@kbusch-mbp.dhcp.thefacebook.com>
 <c737d451-f8b9-47cc-a411-4b2ed349fab0@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c737d451-f8b9-47cc-a411-4b2ed349fab0@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_080159_786251_D5B2C695 
X-CRM114-Status: GOOD (  27.39  )
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

On Fri, Dec 06, 2024 at 01:41:08PM +0100, Hannes Reinecke wrote:
> On 12/5/24 17:15, Keith Busch wrote:
> > On Thu, Dec 05, 2024 at 01:30:39PM +0100, Hannes Reinecke wrote:
> > > On 12/4/24 17:39, Keith Busch wrote:
> > > > > 1) AEN triggers a rescan
> > > > > 2) List of active namespace is retrieved
> > > > > -> NSID A gets unmapped (or moved to another node in the cluster)
> > > > > 3) Scan of NSID A returns an error with DNR set.
> > > > > Without this patch we keep the namespace around, so eventually we'll
> > > > > trip over the 'non-matching UUID' check once the NSID is reused.
> > > > 
> > > > I'm still not sure that makes sense. The target shouldn't attach the new
> > > > namespace until the host acknowledges the removal of the older NSID via
> > > > the Namespace Change List log. Until the log is read, the inventory for
> > > > removed namespaces should be latched. Otherwise, timing might remove+add
> > > > a specific NSID before the host requests the NS Descriptor for the
> > > > racing removal, then it would just get the "non-matching UUID" issue
> > > > anyway.
> > > 
> > > But we read the Namespace Change List log in step 2)
> > > (Not that we're doing anything with it, but that's another story...)
> > > Hmm?
> > 
> > Indeed. So maybe we should just move the log page retrevial *after* we
> > scan the identify active namespace list processing?
> 
> Not sure how that would help. We are getting an 'ANA inaccessible' with DNR
> set status when retrieving the NS descriptor list for the namespace.
> And this has to happen after we read the list of active namespace.
> Perfectly legit, but doesn't tell us anything if the namespace is present at
> all.
> All we know is that we cannot get information about that, and my argument is
> that we should treat this as equivalent to a namespace
> not present.
> 
> And I really don't want to delay clearing of the AEN, as that would
> open the door for us to miss subsequent AENs, getting even more out-of-sync
> with the target.

I just thought it would be cleaner if the driver could observe the
removed namespace is not present in the active namespace list
identification, so that all removals can happen in a single path.

What I'm worried about with your proposal is that it indicates we can
get a rapid remove + add sequence such that timing may create a
condition where instead of getting "ANA inaccessible w/ DNR", we'd
observe a mismached UUID.

