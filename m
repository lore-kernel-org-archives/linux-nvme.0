Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCBBC25B06
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Aug 2022 07:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=15nsMxAPp4mHi+bxcEkto7U9OB9eAMdiuZr3AjlrJkA=; b=mI7Yre1RXFgixNikAmdjqWU9Mm
	EyWX1367tu4VTfmE0yVYrtUWO5+gUyIilhYhdLYk9I+q8XrmftqOrp60myTPdQ3AdCJC6PfFUqJXc
	ZjU7wqtHHVJ6S0l8lfztfS8Lx6/JVQW49tkY8z33HffXjET8Ur/3ta8hKOXna0KtPQv733sytoxgH
	lzWoBjrR6+IJApdKTdAcH9M8BSdHn/jy4N3YUO9RPfWjnl/AIMOnIYurFrhmN7cbnmVF99mD8zFMw
	XfQNKA+POWMEqe3fzoNTOmC6A6lenPzx6te3gZElseQA/FMVub8sKLfclMHhydUwFkWm4W6G9Ru/x
	VetcRMAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLJVA-002J72-VT; Tue, 09 Aug 2022 07:18:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLJV8-002J5a-Qf
	for linux-nvme@lists.infradead.org; Tue, 09 Aug 2022 07:18:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 082B068B05; Tue,  9 Aug 2022 09:18:04 +0200 (CEST)
Date: Tue, 9 Aug 2022 09:18:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: bvanassche@acm.org, linux-block@vger.kernel.org, dm-devel@redhat.com,
	snitzer@kernel.org, axboe@kernel.dk, hch@lst.de,
	linux-nvme@lists.infradead.org, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com
Subject: Re: [PATCH v2 16/20] scsi: Have sd pr_ops return a blk_status_t
Message-ID: <20220809071803.GB11161@lst.de>
References: <20220809000419.10674-1-michael.christie@oracle.com> <20220809000419.10674-17-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809000419.10674-17-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220809_001807_060172_5B47E917 
X-CRM114-Status: GOOD (  10.61  )
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

On Mon, Aug 08, 2022 at 07:04:15PM -0500, Mike Christie wrote:
> This patch has the sd pr_ops convert from the low level SCSI errors to a
> blk_status_t.

Can you document the why here?

