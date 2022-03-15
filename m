Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A3FC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 08:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sbOTUaj4XuhiPBp35MM71d+BOt+rDxjEICtrwnWLUp0=; b=gdEGZAgsIMDgDL1Gd8QW2AHo/5
	3RoWipxZNvymb9pY/jKurLLy0VWIeTxSHfaWOPDkbOnu/ttALd8vbKLe4BUF4KfxNY4UNXjXHejxK
	/uaeFsE3xvqKEVe2hAWvOSch8ZAhsufAdSsMepk3u/W1uU8SPsNocA9lKGdSE+pnKMmf9D4Pelq6x
	TIEeFxbAdDxjmn+5MpFgXti1q76PjSpBZp7zkefc8DI3uZBXkwFLwr1E/8lyOO5lUJQxlMPtOx++t
	MCG7MyUqKaUQARdq+LqYHrSNnp4etC6El9yWNM17c1LwlEuU4ClwqTeenD0uaaXuZVKU5orwThqRO
	J8UOe37g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU309-008O8f-8h; Tue, 15 Mar 2022 08:57:57 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU300-008O49-R6
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 08:57:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 11FEF68AA6; Tue, 15 Mar 2022 09:57:46 +0100 (CET)
Date: Tue, 15 Mar 2022 09:57:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 sbates@raithlin.com, logang@deltatee.com,
 Pankaj Raghav <pankydev8@gmail.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 14/17] io_uring: add polling support for uring-cmd
Message-ID: <20220315085745.GE4132@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152723epcas5p34460b4af720e515317f88dbb78295f06@epcas5p3.samsung.com>
 <20220308152105.309618-15-joshi.k@samsung.com>
 <20220311065007.GC17728@lst.de>
 <CA+1E3rKKCE53TJ9mJesK3UrPPa=Vqx6fxA+TAhj9v5hT452AuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rKKCE53TJ9mJesK3UrPPa=Vqx6fxA+TAhj9v5hT452AuQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_015749_046547_AB19C9A2 
X-CRM114-Status: GOOD (  13.67  )
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

On Mon, Mar 14, 2022 at 03:46:08PM +0530, Kanchan Joshi wrote:
> But, after you did bio based polling, we need just the bio to poll.
> iocb is a big structure (48 bytes), and if we try to place it in
> struct io_uring_cmd, we will just blow up the cacheline in io_uring
> (first one in io_kiocb).
> So we just store that bio pointer in io_uring_cmd on submission
> (please see patch 15).
> And here on completion we pick that bio, and put that into this local
> iocb, simply because  ->iopoll needs it.
> Do you see I am still missing anything here?

Yes.  The VFS layer interface for polling is the kiocb.  Don't break
it.  The bio is just an implementation detail.

