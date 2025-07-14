Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAF6C83F1A
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 17:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pob3xibbFtM0VnCu/LeXClpl3A6/0vjvNJWjLi6J/bY=; b=AQwogRG1ju2Xc93ENmMcLTCR/S
	luX560uh9f1ehI794soo0QJssSDjiVqQwV16tUbpA5+wHh12LOGKb58SHjB5qbspN7G2uSorWGntm
	kdfLMpF8vw6WDLNCFAUea6MY/OqkVMbfjLRxD1N+Qrb2MLcGQtjVeeJ4d+m0uPLtBNg+yAaPtFkwA
	3Lb/ZvLtq1ach/Vf23RouEiOJfYAiBXBDxVn4/7zxKFCOVDvbgjD8GAVdw6pxAuLA2CngTcxL97MD
	v1t1efN3GUc/LXzdrXecS1NI/riX6aiALfqU9z76NsXB5gV/C8OJTLz2JL2yusJbwdzfml387JZht
	x1dLkbYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubN9Y-00000002zB3-3wdi;
	Mon, 14 Jul 2025 17:39:48 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubLes-00000002mqy-2IkA
	for linux-nvme@lists.infradead.org;
	Mon, 14 Jul 2025 16:04:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id AC8E7A57290;
	Mon, 14 Jul 2025 16:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AA6C4CEF0;
	Mon, 14 Jul 2025 16:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752509041;
	bh=AHdmcwDk69P0bsuDXUAUbKZgYi6IjvT1mhl/qsg2pFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/0Zk/DlO4/RGceMRxhdRCcVamfcty52cZZds5h1ZtTGD1N/s0qVnZzVVIKATF5ZN
	 fcnomUp7Nkq/zyNgKumD3M1G+Ba7iz7qM4ukSEeQB75MYfTZoKNX0vcb2QdXttFS2L
	 yEtEAIY1YMM8L4JsLctZ7G8gMSB5Wy1ElbNlTRaLV1zsdR5pwSWVatXFVbLKiEffB7
	 2avLGgmbKkY6WRDjGX5P50O45SlosYxfPpw8BB3BI3NPNRmirTrqANymHNgHm7sm7F
	 J44cYxkml4vMF/IHRcuS6CF2UwQF5rjPTCMuiXqUU9w7o5umLg8GnMKhjtrTJ9GzeW
	 RknHjdOMVGf4Q==
Date: Mon, 14 Jul 2025 09:04:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Theodore Ts'o <tytso@mit.edu>, John Garry <john.g.garry@oracle.com>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250714160400.GK2672049@frogsfrogsfrogs>
References: <20250714131713.GA8742@lst.de>
 <20250714132407.GC41071@mit.edu>
 <20250714133014.GA10090@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714133014.GA10090@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_090402_653532_0416F423 
X-CRM114-Status: GOOD (  16.96  )
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

On Mon, Jul 14, 2025 at 03:30:14PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 14, 2025 at 09:24:07AM -0400, Theodore Ts'o wrote:
> > > Is is just me, or would it be a good idea to require an explicit
> > > opt-in to user hardware atomics?
> > 
> > How common do we think broken atomics implementations; is this
> > something that we could solve using a blacklist of broken devices?
> 
> I don't know.  But cheap consumer SSDs can basically exhibit any
> brokenness you can imagine.  And claiming to support atomics basically
> just means filling out a single field in identify with a non-zero
> value.  So my hopes of only seeing it in a few devices is low,
> moreover we will only notice it was broken when people lost data.

Do you want to handle it the same way as we do discard-zeroes-data and
have a quirks list of devices we trust?  Though I can hardly talk,
knowing the severe limitations of allowlists vs. product managers trying
to win benchmarks with custom firmware. :(

--D

