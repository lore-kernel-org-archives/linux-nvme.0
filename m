Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08794C7EE2D
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Mar 2023 16:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q7UYI6z0GeCfYKzfA18dn6nd0JsGEeUMe3g1M4pVlZw=; b=1vjFrPifk+djMk9bLrRHXv0Jdy
	byyt0lzFn9USYLGzh1dLbYKiv4wM8J0johSAYyEhfB+f9fVWA//VSYyMhhc0AhUro4GEPKR2K7OAi
	Y8mFCctQ2Sz+Udauxe4TN/hAQL6hFW+ySB/RIwEs+fgdn+uTeUSlrQ9O1nfRcxRQMsR0qygj0s2qn
	/lMRYeRY5S5PE7zCnplS2jRteTKM8zpg3iEcJZiwbHTn46o9Wf5QG3qXDr6+Fm86Cy3eApmBDp5aw
	M37xdQAdJo8gYq8yYFCYW5t05+a2sxyKAZYPX1ipFi4TIr9a+R5+VX9/u/sPP+nVmYPDsjjvzHsVV
	XhPweefQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pY8WN-006pl8-U0; Fri, 03 Mar 2023 16:44:39 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pY8WK-006pkK-VH
	for linux-nvme@lists.infradead.org; Fri, 03 Mar 2023 16:44:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6E0126187F;
	Fri,  3 Mar 2023 16:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1A9C433EF;
	Fri,  3 Mar 2023 16:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677861874;
	bh=z9Z0WT5p4jcL+T9L805TH7aPHih/jrmatgMcVCxiAiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ie1d+70ikPBpO7DsGyiUoOqEJzNigToIZHGK3tyMSn/p4wVFyzLCe51UXAGjSwHrj
	 BpsW9GmYStaOlYVJvMCl5BscW2pz2cAIRIRr6vymJvZ6e8oTU1K30dX/Zr+8g7u8e7
	 gBCmnueHIVKT6KuvSr3foiV/nfShQY+IfBcUHsESXHMNcceZO8UFMvraVimqq+5m+Q
	 MiQQoKh8UyRGU1tq3tHl4/qKOn1fCLTkKVfJM2r4eWL3BpBq2bet0I/BpSY/7SpPX8
	 NpxM8pcGU2qvGQu3lOSoQNmQ+N9fSmrmTci/HZthsV2MJhMAPH89h8qt1ntW3Qq2xG
	 Hf8ZRVfL4bUmQ==
Date: Fri, 3 Mar 2023 09:44:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Gomez <dagmcr@gmail.com>
Cc: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Gerd Bayer <gbayer@linux.ibm.com>, Sagi Grimberg <sagi@grimberg.me>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: max_hw_sectors error caused by recent NVMe driver commit
Message-ID: <ZAIj7x9r95jgAQs4@kbusch-mbp.dhcp.thefacebook.com>
References: <BYAPR21MB1688B4BBFCCCD01C016A62D4D7DF9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <CAPsT6hnbAA_uCiVjST8VaPgb6TyfBq9nO2S7OPqJX3=YhzBD9g@mail.gmail.com>
 <BYAPR21MB16882541DC2DA7AB91E58A03D7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y+psCbPTfF9JkW2c@kbusch-mbp>
 <CAPsT6hkYqg2N6_Xf5aL2ijydTJfPYemUVKPZFGgdAik=DwTygQ@mail.gmail.com>
 <BYAPR21MB16887CE0FC5AFD717C741524D7A19@BYAPR21MB1688.namprd21.prod.outlook.com>
 <CAPsT6h=HpDjgE42KRPk8SHHVQ9yPTVBpbGrxd1C9nPN=jWoqUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPsT6h=HpDjgE42KRPk8SHHVQ9yPTVBpbGrxd1C9nPN=jWoqUA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230303_084437_121397_0C9C7B5C 
X-CRM114-Status: GOOD (  25.77  )
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

On Fri, Mar 03, 2023 at 05:24:43PM +0100, Daniel Gomez wrote:
> On Fri, Feb 17, 2023 at 5:05 PM Michael Kelley (LINUX)
> <mikelley@microsoft.com> wrote:
> >
> > Yes, that's correct.   But "the device is limited to a lower max_segments
> > value" isn't really because max_segments is limited.  The limit is on
> > max_hw_sectors_kb derived from the NVMe controller MDTS value,
> > as you have shown in your table below.  Then the max_segments value
> > is derived from max_hw_sectors_kb.  For example, if max_hw_sectors_kb
> > is 128 Kbytes, you can never need more than 33 segments.  Each segment
> > can describe 4 Kbytes (a page), so with 128 Kbytes you get 32 segments.
> > Then add 1 segment to handle the case where the memory buffer doesn't
> > start on a page boundary, and you get 33.
> 
> I'm trying to understand and clarify this part. So, I found Keith's
> patch [1] where he addresses (and introduces) the same case (quote
> from the patch: 'One additional segment is added to account for a
> transfer that may start in the middle of a page.'). But I'm not sure
> when that case should be considered when we split an I/O. Is that
> handled in bio_split_rw + bvec_split_segs functions?

The function responsible for splitting bio's to the request_queue's limits is
__bio_split_to_limits(). This happens before blk-mq forms 'struct request' for
the low-level driver in blk_mq_submit_bio().

> So, for mdts=7 and max_segments being now 128, when can we see and
> test that a transfer starts in the middle of a page and therefore,
> that we need an extra segment for that? In that case, shouldn't the
> split max at 128 - 1 (508 KiB)?

You can ensure you start in the middle of a page by allocating page aligned
memory, then adding an offset.

The number of segments you actually get from your allocation depends on how
many discontiguous pages the system provisions your virtual memory. User space
doesn't have direct control over that unless you're using huge pages. It's
entirely possible a 512KiB buffer has just one segment, or 129 (assuming 4k
pages), or any number inbetween.

> In my tests [2], I can see splits are made in chunks of 128 in some
> cases. Whether or not these cases are page-aligned I don’t know but
> I'd like to verify that.
> 
> [1] https://lore.kernel.org/all/1439417874-8925-1-git-send-email-keith.busch@intel.com/
> 
> [2] while true; do sleep 1; dd iflag=direct if=/dev/nvme0n1 bs=1M
> count=1 of=/dev/null status=progress; done

