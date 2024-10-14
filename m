Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F367CFC501
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 07:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mHsDS60Rm1dSdUgdHqMu/DcQZGrwEio7XUYkvQmC2tw=; b=H/TNj2vOvvdA/z12/Qkp3h+kLj
	A3OJx5N4hYgsJgonss2R8LlVH5UY/r9VaW/pL/A3+ua2ejeRbREZZsHuFnOu24yBOkVwnr+F/Y/D+
	HpsTzwi8iSJ9yKoHWaFs9/wWXV2YXWJfRpzlhPXaFWg4fZBJ7mARN4mky9F8OWfXS07Nt0ZPk+uWJ
	WEmFao5JaXUz/oMvwvGznBU1geNNycD3wPXjB4PG+3Ik0NcxWvCYFjvftoIMHH2EOM2EeZz1UzghM
	qaiFc5KYmWIkCqnzkjEDacOq5KtwomqQb6TqlT/grlDDe0OvXcIkST31oXh0UovgNh3HVgfZ+Mqu5
	ZGIAwKKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0FyT-00000004ArD-2JcB;
	Mon, 14 Oct 2024 07:58:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0FnP-0000000480f-0Y1o
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 07:47:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 14511227AAC; Mon, 14 Oct 2024 09:47:09 +0200 (CEST)
Date: Mon, 14 Oct 2024 09:47:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Javier Gonzalez <javier.gonz@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>, "hare@suse.de" <hare@suse.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"jack@suse.cz" <jack@suse.cz>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"bcrl@kvack.org" <bcrl@kvack.org>,
	"dhowells@redhat.com" <dhowells@redhat.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>,
	"asml.silence@gmail.com" <asml.silence@gmail.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-aio@kvack.org" <linux-aio@kvack.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>,
	"vishak.g@samsung.com" <vishak.g@samsung.com>
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241014074708.GA22575@lst.de>
References: <20241009092828.GA18118@lst.de> <Zwab8WDgdqwhadlE@kbusch-mbp> <CGME20241010070738eucas1p2057209e5f669f37ca586ad4a619289ed@eucas1p2.samsung.com> <20241010070736.de32zgad4qmfohhe@ArmHalley.local> <20241010091333.GB9287@lst.de> <20241010115914.eokdnq2cmcvwoeis@ArmHalley.local> <20241011090224.GC4039@lst.de> <5e9f7f1c-48fd-477f-b4ba-c94e6b50b56f@kernel.dk> <20241014062125.GA21033@lst.de> <34d3ad68068f4f87bf0a61ea8fb8f217@CAMSVWEXC02.scsc.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34d3ad68068f4f87bf0a61ea8fb8f217@CAMSVWEXC02.scsc.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_004715_369562_CC9E7867 
X-CRM114-Status: GOOD (  21.89  )
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

On Mon, Oct 14, 2024 at 07:02:11AM +0000, Javier Gonzalez wrote:
> > And exactly that is the problem.  For file systems we can't support
> > that sanely.  So IFF you absolutely want the per-I/O hints we need
> > an opt in by the file operations.  I've said that at least twice
> > in this discussion before, but as everyone likes to have political
> > discussions instead of technical ones no one replied to that.
> 
> Is it a way forward to add this in a new spin of the series - keeping the 
> temperature mapping on the NVMe side?

What do you gain from that?  NVMe does not understand data temperatures,
so why make up that claim?  Especially as it directly undermindes any
file system work to actually make use of it.

> If not, what would be acceptable for a first version, before getting into adding
> a new interface to expose agnostic hints?

Just iterate on Kanchan's series for a block layer (and possible user level,
but that's less urgent) interface for stream separation?

