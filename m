Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453B2EB64DD
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 15:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w0qJW+Fpj4R0Tn7LLno6v2AXMGHLc0wPKAhbOwxgea0=; b=HtS9YqPSX8F3vUBRRnWAaZdGai
	zEL8usGFCbHdI72SP6FRqfvmRjbYQgiaJNVJUhNkS5RiDylGk5FAUdYgFbOQMsURFpw3jImYafeNT
	NWajXJnvxTbOPOVf6itjkuiF6RJ1dZSE9wcPAnm8s5Y3tEZIiYcGwr+3/Q4MHsMMiyOK5pS4VIfAN
	KQX3Jl2LZK3CK/9KvwuuX3PNLdgfM6pNIi8ENIrY2M2o69CnRmLgGOPluB7cHIRhs6jrV9b72V3EC
	kCQeVTDTpfVc/jRcJ3tUIAKrhG6OjdgGwHIWldCx+9rtXq88571dbjLtrH3AsaW+Jupo1rDnokFAO
	m+4l+cqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJFMl-00FFhB-12;
	Tue, 11 Jul 2023 15:33:27 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJFMj-00FFgZ-1r
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 15:33:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A492261566;
	Tue, 11 Jul 2023 15:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CD4C433BA;
	Tue, 11 Jul 2023 15:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689089604;
	bh=TwIX0LdPSn6QFf/+bhLDt4k9PZasqoFbG8wsVCBkykU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uesnTDfxr9Mw1W6bKVehQQrXFnGc3Q/qnGXQFX0DlZK1Zroidz2QJzysCg/Iwctg8
	 FJVqH884K6S86Pp27cjCNJSOPiTiKNWolPqbkgqTWez6fDCu2N+8XkQSDk6+/WE31r
	 jPzqfi8+tead8uV/+TmpPgtITltRPfsTwjvdWXdwxKXrdeVFOctousDE9JRMxJHfnt
	 S4NddV+ZRdBA9Z9f1mrtaIE62o/AFUPmcLW5QjVT4ik7cQUw8pMpOeHygy4sKv3L+L
	 Mwih5cq6i47mvAZkfZ6/91OLzErbwUSKIxZ42iKSlfmD7921sU8cGLtLx8EtwJKYTq
	 hpT+E0AHgDKoA==
Date: Tue, 11 Jul 2023 09:33:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Clemens S." <cspringsguth@gmail.com>,
	Martin Belanger <martin.belanger@dell.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux NVMe <linux-nvme@lists.infradead.org>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Javier Gonzalez <javier.gonz@samsung.com>,
	=?utf-8?B?67CV7KeE7ZmY?= <jh.i.park@samsung.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
Message-ID: <ZK12QT9C7avQOjxU@kbusch-mbp.dhcp.thefacebook.com>
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
 <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com>
 <6f333133-2cc4-406a-d6c2-642ac6ccabca@leemhuis.info>
 <CGME20230710155902eucas1p2b464a29adc35e983c73b00d18ab5344c@eucas1p2.samsung.com>
 <ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com>
 <f0fdf86e-4293-8e07-835d-b5a866252068@samsung.com>
 <462e0e1e-98ea-0f3c-4aaa-8d44f0a8e664@leemhuis.info>
 <20230711120609.GB27050@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711120609.GB27050@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_083325_673388_18705D0F 
X-CRM114-Status: GOOD (  16.76  )
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

On Tue, Jul 11, 2023 at 02:06:09PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 11, 2023 at 11:39:11AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> > Well, that "They keep pumping out more and more devices with the same
> > breakage" and the "new device" comment from Pankaj below bear the
> > question: should we stop trying to play "whack a mole" with all those
> > quirk entries and handle devices with duplicate ids just like Windows does?
> 
> As far as I can tell Windows completely ignores the IDs.  Which, looking
> back, I'd love to be able to do as well, but they are already used
> by udev for the /dev/disk/by-id/ links.   Those are usually not used
> on desktop systems, as they use the file system labels and UUIDs, but
> that doesn't work for non-file system uses.

It's also an inescapable requirement for supporting multipath, and a
number of the devices being quirked bizarrely also report CMIC/NMIC
capabilities.

