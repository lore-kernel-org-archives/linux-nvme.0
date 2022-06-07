Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19663CCA47C
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 19:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BaAhmDl7gWHSxl7M8kz/wy7INLHPKOk9Tjj7sYfmvU8=; b=XIhxKo4khWBeytMQM9poIHLR5I
	dOmEnsK9bOS/wuGczq0VQ1VXCmSE7USriPX18fudVS26zoVCaTeAZEeoh3+C4kut5w6hu1T7MhDWM
	a6d1nr9Y+hiEyluBxQahZyp3tUWxh42UUUN06dUjx50OALvaQGaPeocg3rfEE1QhWgn7K1j1JZ++R
	VlypG1rQKwxEwBJTbKWF4vaNXtTZqTrsVLPU5D7DL9Fv1gslAp9MX+aioVuN0USrQY7ICheRCQ+9A
	X5M7/g+CBZxlx0b15jrlX4tKFVr/BZfE6UWAK8bWyb2C/j5WGH8KNq+JFgqeugARosdEFytR/mnS7
	mSm7B2yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyeSS-008w6V-7p; Tue, 07 Jun 2022 19:01:40 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyeSQ-008w4x-8D
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 19:01:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C9134617D6;
	Tue,  7 Jun 2022 19:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5A5C34115;
	Tue,  7 Jun 2022 19:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654628497;
	bh=kK3U3avYPYLgG/48fsZBjQ6IVWIEsZcdYueCRUvxPm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckY3qEuhLQgBipufICbhJrsfxz/rSsrqh2wix1doK6Sh9m1YL+iuupKKGkSB3To8y
	 brXK4dvVcpl/ClhPmus60o0leeqqktzF6bB0O8nGKHnxcDCHjxGxlaMvH9UTYDPItk
	 VfEZXvw6RY5VIeFp+RPQRFdWI1x/A30HDTIcDQSfLPDP949DKQ0VkvPOWP/B3AIHkP
	 Od3cbwQ6aYmvWzdcrbMQpCPtIFeEBIfCBeZ3vB6z1WlpqF3aa5HLLF1O2YSrZR1zyN
	 jJr81z9bqwUU1ZXoJIyT0DiTJDMH8D6CAc935ds4Ul5w6HJWySSbg1nU+HyKn2U+up
	 WXhS1h2XDDZFw==
Date: Tue, 7 Jun 2022 13:01:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Klaus Jensen <its@irrelevant.dk>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <Yp+gjvFjy+mepmWo@kbusch-mbp.dhcp.thefacebook.com>
References: <YlB1E/p1uqpl3HiN@bombadil.infradead.org>
 <20220411050533.GB13927@lst.de>
 <20220411055455.GA14480@lst.de>
 <C85067CB-3909-4B62-A86D-467827EBF96E@oracle.com>
 <20220420073641.GA6859@lst.de>
 <26796ED5-859F-4844-B1D1-7C2FF5126E40@oracle.com>
 <Yp5z8b4ec5tFt9qk@kbusch-mbp.dhcp.thefacebook.com>
 <84C629F5-BCDC-45FE-88F0-83DCDA06B93E@oracle.com>
 <Yp54fw/FRQ6KhP0V@kbusch-mbp.dhcp.thefacebook.com>
 <1FC6870F-6BCA-4C9B-8F90-C14469A542AE@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1FC6870F-6BCA-4C9B-8F90-C14469A542AE@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_120138_390693_2C986344 
X-CRM114-Status: GOOD (  20.71  )
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

On Mon, Jun 06, 2022 at 11:11:22PM +0000, Alan Adamson wrote:
> 
> 
> > On Jun 6, 2022, at 2:58 PM, Keith Busch <kbusch@kernel.org> wrote:
> > 
> > On Mon, Jun 06, 2022 at 09:51:55PM +0000, Alan Adamson wrote:
> >>> On Jun 6, 2022, at 2:38 PM, Keith Busch <kbusch@kernel.org> wrote:
> >>> 
> >>> Shouldn't the nvme-passthrough target just change the cntlid so it looks like
> >>> two controllers in the same subsystem? That would just need to stop overriding
> >>> the subsysnqn, which is what currently happens.
> >> 
> >> That was my original proposal a while ago, though I wasn’t certain what to change. Should the UUID/GUID just be zeroed out?  Is it ok to do that for all passthru targets?
> > 
> > Can't the namespace id's be left the unmodified? The loop and pcie targets
> > would just look like two paths to the same namespace, which is essentially what
> > they are.
> 
> nvme_global_check_duplicate_ids() fails when the id’s are the same.  They are kinda
> shared namespaces and we can set nmic on the loop target, but the pcie target is
> unaware of it being shared.

Gotcha, the pcie target potentially lacking cmic/nmic awareness does appear to
make my idea unreasonable to implement. Thanks for the follow up info.

