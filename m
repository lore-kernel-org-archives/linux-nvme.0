Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73997C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 06:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=idbx7Oz28XmrnCs+JSlADvDPISbMUcS+offRNh0As/k=; b=X0OyQk7DPJ0v/0WPH7kVYEEJPE
	/dxIavToUgeSfDgKwiJC+CWiYNfIOujaF6cyOBxnfvTE7WjL56XwUZ3gG/Y8EQ+zjDQMfn/jThhyu
	QrYwfvvn5s1lG4RRSMs6DgYQH26raGUVoeb42TmG3EXtz1VOVv9QakaFH8nJPzzUuywG6VYST3arB
	Xdaa/nmO7ZtMFEhkR0yrwvLxBAA7sosDdyxQ47kz7lucbDXkyVQeo4N4Zm+Jir/OIsCUO6bIh9wfW
	wZKvQCdoaLT4CJQdwGaWfYWoQbWcT2Eb4GdMgP9b/YaUFm2NUWV7HIK9LXeReYLvFs0XAGDLO/Ce6
	Y7YAdHHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSZ6L-00FGpl-56; Fri, 11 Mar 2022 06:50:13 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSZ6I-00FGos-Q3
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 06:50:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 170F268AFE; Fri, 11 Mar 2022 07:50:08 +0100 (CET)
Date: Fri, 11 Mar 2022 07:50:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com,
 logang@deltatee.com, pankydev8@gmail.com, javier@javigon.com,
 mcgrof@kernel.org, a.manzanares@samsung.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com
Subject: Re: [PATCH 14/17] io_uring: add polling support for uring-cmd
Message-ID: <20220311065007.GC17728@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152723epcas5p34460b4af720e515317f88dbb78295f06@epcas5p3.samsung.com>
 <20220308152105.309618-15-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308152105.309618-15-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_225011_016882_92F194A4 
X-CRM114-Status: GOOD (  12.35  )
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

On Tue, Mar 08, 2022 at 08:51:02PM +0530, Kanchan Joshi wrote:
> +		if (req->opcode == IORING_OP_URING_CMD ||
> +		    req->opcode == IORING_OP_URING_CMD_FIXED) {
> +			/* uring_cmd structure does not contain kiocb struct */
> +			struct kiocb kiocb_uring_cmd;
> +
> +			kiocb_uring_cmd.private = req->uring_cmd.bio;
> +			kiocb_uring_cmd.ki_filp = req->uring_cmd.file;
> +			ret = req->uring_cmd.file->f_op->iopoll(&kiocb_uring_cmd,
> +			      &iob, poll_flags);
> +		} else {
> +			ret = kiocb->ki_filp->f_op->iopoll(kiocb, &iob,
> +							   poll_flags);
> +		}

This is just completely broken.  You absolutely do need the iocb
in struct uring_cmd for ->iopoll to work.

