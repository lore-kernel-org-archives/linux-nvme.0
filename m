Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCDCD49212
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Nov 2024 12:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Rhd6u5eq8rz8ibO1Ep6zjjs0xqfxJSfEHQYUkQ6tZI=; b=D9OERN7E3wFdiInNrqfFnRoTg3
	adIAerY1NMKcmCLfm6kaCW01pxnEWtmmSNjsyIxDuiLqKo13Q2Eb3uqIPC2OYFb5P0nFqHiLOecQk
	Z+NS9dYEsouQfYohDqRBD4BeR06tqenGBdFtCXcWh6zy72CYVZFJFuKz1YhUlV1oJVdMy2l+xBK84
	OI+6YwPspHOJaOtQQ9OMdOmfeDAqeu83ZwFl0oDVS+3zN6G6rRKVE0+/2QRYivTY/QI7orWdGKxEy
	M7EaIC3LYYjCxCRXbqMelQK0rq/fzWkteqgandseQTRPIqpcM5swPokebTXnq1tfkmrxjLqfmfDG6
	kfYoYLKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tD1DD-00000009Rqt-0DfQ;
	Mon, 18 Nov 2024 12:50:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tD1DA-00000009Rp7-2t3H
	for linux-nvme@lists.infradead.org;
	Mon, 18 Nov 2024 12:50:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 106FF68BFE; Mon, 18 Nov 2024 13:50:30 +0100 (CET)
Date: Mon, 18 Nov 2024 13:50:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, hch@lst.de,
	kbusch@kernel.org, martin.petersen@oracle.com,
	anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v9 06/11] io_uring: introduce attributes for read/write
 and PI support
Message-ID: <20241118125029.GB27505@lst.de>
References: <20241114104517.51726-1-anuj20.g@samsung.com> <CGME20241114105405epcas5p24ca2fb9017276ff8a50ef447638fd739@epcas5p2.samsung.com> <20241114104517.51726-7-anuj20.g@samsung.com> <c622ee8c-82f0-44d4-99da-91357af7ecac@gmail.com> <b61e1bfb-a410-4f5f-949d-a56f2d5f7791@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b61e1bfb-a410-4f5f-949d-a56f2d5f7791@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241118_045036_864658_9D5CE4CE 
X-CRM114-Status: GOOD (  13.81  )
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

On Sat, Nov 16, 2024 at 12:32:25AM +0000, Pavel Begunkov wrote:
> We can also reuse your idea from your previous iterations and
> use the bitmap to list all attributes. Then preamble and
> the explicit attr_type field are not needed, type checking
> in the loop is removed and packing is better. And just
> by looking at the map we can calculate the size of the
> array and remove all size checks in the loop.

Can we please stop overdesigning the f**k out of this?  Really,
either we're fine using the space in the extended SQE, or
we're fine using a separate opcode, or if we really have to just
make it uring_cmd.  But stop making thing being extensible for
the sake of being extensible.


