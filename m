Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D58C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 14:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=edkE5+9SSca1+ookGv8CwKVo22EVEp7QOvNDb/DuY58=; b=gM4VUG9XS7ShpGr4m8L+Oen5N+
	Usf3N3Ux1cG5Fmch9bqN1IImX7MNCFVYDvAMNoo0J6KUJanlyicByoPwiNx1v6XV9Nxqr9cLwAzL1
	2d3hgNOZdhX5aCu8Qz3xk5pOOR4GrbUXOaXUNGKuTUvDSF1eetflIVero/m8p+AIvFsFDZIACAVQJ
	fpouliybBSA2BQZsBVKdrZFwjaz5/gNdu6scxyr+VD0KtFfpySb0exJTcq3OnbMslf1VWnNCGH6nW
	QsVx3zxtwJ1TyrFxfMgTGK5BJDqSjx0WX4qtnpgvUacQIHDExmdjgV+nHah057nDlgdEk5UgivHXF
	7qjWgbFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSJdx-00D3HU-Le; Thu, 10 Mar 2022 14:19:53 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSJdu-00D3GG-I5
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 14:19:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7E3C068AFE; Thu, 10 Mar 2022 15:19:45 +0100 (CET)
Date: Thu, 10 Mar 2022 15:19:45 +0100
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
Subject: Re: [PATCH 17/17] nvme: enable non-inline passthru commands
Message-ID: <20220310141945.GA890@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152729epcas5p17e82d59c68076eb46b5ef658619d65e3@epcas5p1.samsung.com>
 <20220308152105.309618-18-joshi.k@samsung.com>
 <20220310083652.GF26614@lst.de>
 <CA+1E3rLaQstG8LWUyJrbK5Qz+AnNpOnAyoK-7H5foFm67BJeFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rLaQstG8LWUyJrbK5Qz+AnNpOnAyoK-7H5foFm67BJeFA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_061950_770565_B254B287 
X-CRM114-Status: GOOD (  18.77  )
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

On Thu, Mar 10, 2022 at 05:20:13PM +0530, Kanchan Joshi wrote:
> In sync ioctl, we always update this result field by doing put_user on
> completion.
> For async ioctl, since command is inside the the sqe, its lifetime is
> only upto submission. SQE may get reused post submission, leaving no
> way to update the "result" field on completion. Had this field been a
> pointer, we could have saved this on submission and updated on
> completion. But that would require redesigning this structure and
> adding newer ioctl in nvme.

Why would it required adding an ioctl to nvme?  The whole io_uring
async_cmd infrastructure is completely independent from ioctls.

> Coming back, even though sync-ioctl alway updates this result to
> user-space, only a few nvme io commands (e.g. zone-append, copy,
> zone-mgmt-send) can return this additional result (spec-wise).
> Therefore in nvme, when we are dealing with inline-sqe commands from
> io_uring, we never attempt to update the result. And since we don't
> update the result, we limit support to only read/write passthru
> commands. And fail any other command during submission itself (Patch
> 2).

Yikes.  That is outright horrible.  passthrough needs to be command
agnostic and future proof to any newly added nvme command.

> > Overly long line.
> 
> Under 100, but sure, can fold it under 80.

You can only use 100 sparingly if it makes the code more readable.  Which
I know is fuzzy, and in practice never does.  Certainly not in nvme and
block code.

