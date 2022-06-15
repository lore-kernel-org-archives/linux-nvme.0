Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDA2C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 11:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+R+gwYnExpqPohDJn+o7Gel9vHv+3UbhOqXvNiZjaVQ=; b=jyBdlPdVTsEMskWMUvP8ZZcsgL
	pE6aT+B9cj+kz3mZgabt7TWINlQdBYKSgtWy0In+iYkNNm3rXHe/Ci82SQGeXISTMEYCqwuuIh4ig
	SPvpzLFBqEXzSNWL/iMOdRaaO3/BdyJCRVB8F+aZpS8QKC6jP4lRO4EgEfJdAlf8V87rl523noh/O
	Vy5nnFI4hm4Pi+GfomJmvAc2RII4Q2pv5uuJ4+1aC/tu36CynC2emQ8lU59KHAmcLTxGHOc91COfE
	AjlrPi91UmOxssmEYlzH3ty/HvX/+HhapFZspTOA+v0D5+T4LeAvpF2mGIBekezuN9yNGfEYAwoEO
	T9VbRSFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1REu-00EBej-N5; Wed, 15 Jun 2022 11:31:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1REs-00EBdF-CY
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 11:31:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 43DD768AA6; Wed, 15 Jun 2022 13:31:06 +0200 (CEST)
Date: Wed, 15 Jun 2022 13:31:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <pankydev8@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
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
Message-ID: <20220615113106.GA10697@lst.de>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com> <Ykyf5Zuz1W8yHhNY@zx2c4.com> <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com> <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com> <SA2PR11MB5115DCE45778910C96813CA1C3A79@SA2PR11MB5115.namprd11.prod.outlook.com> <YqG/pybFg0P5yQ9a@zx2c4.com> <20220610061449.GD24331@lst.de> <YqMMo2Dv9SZRtR7B@zx2c4.com> <20220613135549.GA1714@lst.de> <20220615102757.ugvs6vdxf66nrmyn@quentin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615102757.ugvs6vdxf66nrmyn@quentin>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_043110_616857_62F9C9BA 
X-CRM114-Status: GOOD (  18.98  )
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

On Wed, Jun 15, 2022 at 12:27:57PM +0200, Pankaj Raghav wrote:
> Hi Christoph,
> On Mon, Jun 13, 2022 at 03:55:49PM +0200, Christoph Hellwig wrote:
> > It all appears as PCIe, but the pci_dev has an is_thunderbolt flag.
> > 
> > Thanks to both of you for the information.  I'd like to wait until the
> > end of the week or so if we can hear something from Samsung, and if we
> > don't we'll have to quirk based on the model number.
> Our FW team has started looking into the issue. They said they will try
> to come up with a solution before 5.20. If not, we can add this quirk
> based on the FW ver. and a proper solution can be added by 5.21.

I don't think we can wait for 5.20 - the "offending" commit is in
5.19-rc and -stable.  So I'll plan to prepare a patch based on the model
number for now, still hoping we can come up with something better
eventually.

