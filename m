Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB3BC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Nov 2022 15:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6bqq/JpoLrtRarQVOd7fvW3b7NNZzrclAPhBlUi6TH8=; b=ibT82ACEWwmdvBub4qG/j6zZqD
	GX3TvInLWmo1RyN6Hv7KmiEYYYtVNKpxN1D5VoSA1vM2FnDxumSWT2FzSCglAmxxIiNHvqT5DP29e
	qPtyFEXdk6Ne4OG9lKogtq3hepcIkIlF0R1KAfrtPM8omRtJDT/eWCIcB6jZWg+aeQa5RcCYx4hDD
	PZ3mWq/qIkZv2knvgGWyQcWolKrPT5KzSGPaKmbbY8tJpeHLXE1nOJx6SOXkfV0csiXPNXGCWNDzn
	pY8RlhdZapsqSdNCV3mBucrDpbOXjgR7ReHb1dlAP9CWLq25MkpBcZrunOIDFxqfgpr0qvTNv+SO6
	gLjOpvlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxUve-00AESz-EP; Tue, 22 Nov 2022 15:11:18 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxUvY-00AEPS-D1
	for linux-nvme@lists.infradead.org; Tue, 22 Nov 2022 15:11:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id AAFEEB81BC3;
	Tue, 22 Nov 2022 15:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1416BC433D6;
	Tue, 22 Nov 2022 15:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669129869;
	bh=IFaVWR8xVmvg4+cInN4UQqY0LO3DH8c1yce/x7ylpfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QyZKFFisJTW0T04B0TWi4PIb3YGQahc0QMCwnLGWm/D8IP0wI+OMEfxBh3smbPI5O
	 nZM5OMxuWIuSxjvJ8UZpRx5XMdJA430ftHRDJR7mMJaBRSkhOxxyH2xeOjZ+6imzDU
	 eO+r1rIij5I205fd4n0F4BJaiJriysu1xbSe8kpigXZt2/gSrLa2FBZGWAYaIfQKCi
	 7NbDmpkNpD3FqolMThsyLRXArgokUn+ZVEj0qwaDd0LPIR0ssyz8ctnYORo3rN1aB2
	 oAbsuL7sTR3iCArq7ZahY9cUPkSxr6xyzFcwtCrQJ2gkzppW+NiokXQSRW012gZ6Zj
	 sRKuSqI8QTI/A==
Date: Tue, 22 Nov 2022 08:11:06 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: block dangerous passthrough operation
Message-ID: <Y3zmik6zHDMZyb5U@kbusch-mbp.dhcp.thefacebook.com>
References: <20221116130104.2186334-1-hch@lst.de>
 <256d34ff-3979-9780-4426-6d913a3a9707@kernel.dk>
 <20221121074647.GD24507@lst.de>
 <Y3uazieJ5xRR8jg7@kbusch-mbp>
 <20221122064743.GA14698@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122064743.GA14698@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_071112_648459_5D5C289B 
X-CRM114-Status: GOOD (  16.97  )
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

On Tue, Nov 22, 2022 at 07:47:43AM +0100, Christoph Hellwig wrote:
> On Mon, Nov 21, 2022 at 08:35:42AM -0700, Keith Busch wrote:
> > It's not like just anyone can do this kind of craziness. It's like a
> > soft equivalent of pulling a cable. There are usually access
> > restrictions for untrusted people.
> 
> Yes, there are.  But that doesn't change us having to deal with the
> fallout.

What exactly happened here? If I got a bug report that says "it broke
when I did this admin command", the answer is "don't do that. *plonk*".

Did you spend too much time on a bug report that didn't include repro
steps or something?

If you really need to do this, I think augmenting the
nvme_known_admin_effects() with a driver specific flag saying "Do Not
Execute" or something like that provides a more centralized location for
this type of check.

