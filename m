Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBABC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jun 2022 13:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7On3vAvzaXzEqX5m3G9llzX4j7Vxl3+0OPcXmBWDKNk=; b=Ujt3+2k4OEVdXdQQCYVKpQo8SU
	bBUI4bypDmFxzxYNhgcsbDwAw206wAg+4pjT/gbvu/3kXZ8Z9YrMq9sAq5LhljZ5HpvxTEVXDVVhU
	IcemvTsuBmQ5ERklsBzIDy5mQTIVl6BVMKvwkGcZlVlYRc1usVmtfvJFWHb/zJkkVL3H/i8WlShH5
	pa+lkQTA7nMY62PsAdcXMOmG5272Qj7VSgv72lFZhjGqk1C9O7unpnorkHF/voxL7IauLqikBPy2e
	aYrV5FQr898T2grX6tjbdmGo7t/baB+VO8C821kGpbsNSUUCMoE2jN2pOMC6wkDUYFTvbWuIK/Xcg
	/9Nn9Eww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0kXw-0040js-5F; Mon, 13 Jun 2022 13:56:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0kXs-0040Yx-I1
	for linux-nvme@lists.infradead.org; Mon, 13 Jun 2022 13:55:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E1E6A68AA6; Mon, 13 Jun 2022 15:55:49 +0200 (CEST)
Date: Mon, 13 Jun 2022 15:55:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"R, Monish Kumar" <monish.kumar.r@intel.com>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"alan.adamson@oracle.com" <alan.adamson@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>, Yi Zhang <yi.zhang@redhat.com>,
	Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"Rao, Abhijeet" <abhijeet.rao@intel.com>
Subject: Re: 2 second nvme initialization delay regression in 5.18 [Was:
 Re: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2)
 MORE DNR observed during blktests]
Message-ID: <20220613135549.GA1714@lst.de>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com> <Ykyf5Zuz1W8yHhNY@zx2c4.com> <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com> <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com> <SA2PR11MB5115DCE45778910C96813CA1C3A79@SA2PR11MB5115.namprd11.prod.outlook.com> <YqG/pybFg0P5yQ9a@zx2c4.com> <20220610061449.GD24331@lst.de> <YqMMo2Dv9SZRtR7B@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqMMo2Dv9SZRtR7B@zx2c4.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_065556_789065_BFDC20ED 
X-CRM114-Status: GOOD (  13.53  )
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

On Fri, Jun 10, 2022 at 11:19:31AM +0200, Jason A. Donenfeld wrote:
> Right, that seems like the set of variance we're dealing with. If it's a
> firmware version issue, then we revert because people can update? Or can
> we quirk firmware version numbers too?

We can quirk on firmware version and model number as well.  Those quirks
need to go into the core nvme module and not just the PCI driver, though.

> If it's ASIC stepping, I guess we
> need to quirk that. And likewise thunderbolt, but that seems more
> awkward to quirk around, because afaik, it all just appears as PCIe?

It all appears as PCIe, but the pci_dev has an is_thunderbolt flag.

Thanks to both of you for the information.  I'd like to wait until the
end of the week or so if we can hear something from Samsung, and if we
don't we'll have to quirk based on the model number.

