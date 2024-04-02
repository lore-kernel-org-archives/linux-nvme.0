Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2067CD1284
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 16:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z/jt/DeSPhwxFgcYrXiIr2FB32hsEXPOOkbqK8aJ9ZE=; b=mlZE7jbRVaLvGREELo88iU8cV7
	3mJldHwMMmY8oprzsLqEADZitow5EOJiX7eLxA2N9iVRh+VO/G9v0jkBFremO6ncvMx37SZGPKdnr
	MVPCnl3jA8RRoqWggD2l4vSQIBBJWzDuPLRrDBhYPLjbrLV2mSxdxpWWALGD/apTZgW4q/w5JPO+m
	T5scZHJvKDYpqsgUl8CSsv3kpbTs5FhF77PsqWlooDL3FnJw1agYmKp1B90lV06FvNxQdbB8TG1hY
	0JWGrJxy9xrc9TQrJdo4nI9oNlVPZSGjaQwwKPbdWXVsqhYdj+h23Gao+oMIM/t1pQ7iK+Sqn3b2E
	a8thp55A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrggE-0000000BxjK-0QL3;
	Tue, 02 Apr 2024 16:08:10 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrggB-0000000Bxif-1nMv
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 16:08:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 459D761035;
	Tue,  2 Apr 2024 16:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3F2C433C7;
	Tue,  2 Apr 2024 16:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712074085;
	bh=v7GW57i9E9k0EfqiWo2KVoW23hWJbROx8FjWEao2q4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IXVpxTBeREZDDlnPbDi7GFMTwk+Wyz5Iujn/4RO4km6aEiZO7T8fYxPac6iQmcY8U
	 60qK79cHg3kMF/Sx9IpO/u+y0UDZjc/NkHm3HhM+fsLFMGMMMImpctbsk8BqxV9lhF
	 8FboASrngFqQEADgtvPAHrBcfdsYL/TbQjLki6BcT8T9LKs7k0a+iHIEs2jpusg8x0
	 Y/MGL4T6zQwsXLqjo2fqlkfBao+Ym7+0epd1VsxGqHRXrcNivGJ8kKKdsKosWsB0eF
	 APcBK/Uc8GBVfIZV528bwKfJuMAkceB6g1HP+kYtj6wCE5R+5YRTs8IRirut/3thRu
	 flvSSe+lLBDqA==
Date: Tue, 2 Apr 2024 10:08:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Georg Gottleuber <g.gottleuber@tuxedocomputers.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Georg Gottleuber <ggo@tuxedocomputers.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Add sleep quirk for Samsung 990 Evo
Message-ID: <ZgwtYpbcyM_ffjaF@kbusch-mbp.dhcp.thefacebook.com>
References: <20240328130923.61752-1-wse@tuxedocomputers.com>
 <20240402131658.GA31963@lst.de>
 <230e3f41-9f6b-42fd-a411-567abbaebbbe@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <230e3f41-9f6b-42fd-a411-567abbaebbbe@tuxedocomputers.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_090807_544904_19137736 
X-CRM114-Status: GOOD (  19.70  )
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

On Tue, Apr 02, 2024 at 05:13:48PM +0200, Georg Gottleuber wrote:
> Am 02.04.24 um 15:16 schrieb Christoph Hellwig:
> > On Thu, Mar 28, 2024 at 02:09:22PM +0100, Werner Sembach wrote:
> > > From: Georg Gottleuber <ggo@tuxedocomputers.com>
> > > 
> > > On some TUXEDO platforms, a Samsung 990 Evo NVMe leads to a high
> > > power consumption in s2idle sleep (2-3 watts).
> > > 
> > > This patch applies 'Force No Simple Suspend' quirk to achieve a
> > > sleep with a lower power consumption, typically around 0.5 watts.
> > 
> > Does this only apply to a specific SSD or all SSDs on this platform?
> > How do these platforms even get into the conditional?  Probably
> > through acpi_storage_d3 setting, which probably is set incorrectly
> > for the platform?  Any chance to just fix that?
> 
> Yes, this only apply to a specific SSD. I tested these SSDs (on
> PH4PRX1_PH6PRX1):
> * Kingston NV1, SNVS250G
> * Samsung 980, MZ-V8V500
> * Samsung 970 Evo, S46DNX0K900454D
> * Samsung 980 Pro, S69ENX0T709932L
> 
> S2idle consumes around 0.4 watts with these SSDs. But with a Samsung 990 Evo
> s2idle on this platform consumes 3.7 to 4.4 watts (6.8 vs 6.5 kernel).

For all these different SSDs you tested in this platform, do you see the
"platform quirk: setting simple suspend" in the dmesg? I just want to
confirm if the platform is changing the reported acpi_storage_d3 value
for different SSD models or if they're all the same.

