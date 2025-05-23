Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AA4C54ED0
	for <linux-nvme@archiver.kernel.org>; Fri, 23 May 2025 13:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gv+Cu1VNu8jkjXHy0G/6SVAtV7Y+ResFYJBAHJAmNpY=; b=iYqJBdKVMPXX5qUZ7irszAWVdJ
	RV6MeZstVsPs59oa7oiNM6XDbBhCzCEEtAFHGYEsZ2eZzqaQGxp4nVocs+/9sQ4ei8GMF/GXuoEfN
	ZiWuthoGeM8QNcbJBukE3uSUmtKXRXlde+4EvOAsdVdBpjhclqnlCQZRgKrugzxjPGQJUWfgy0E1j
	L865svU5RRVz1/z9+cGfO9qoqJ3tC/7IrmFsvHr0+YiHG1fK6ssVKtRtGtT42ec9xZooKCbZO0oQt
	Ond26IUzsN8Q26X+rkiX/4kfHWE1mVeagwMhGbmRTrp++aG6bDxOzbbBS3xhDb1ujRihJTCt1rQBZ
	bHxnmruA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uISE0-00000003uwf-3sv8;
	Fri, 23 May 2025 13:14:12 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIRtY-00000003rVJ-3GKW;
	Fri, 23 May 2025 12:53:04 +0000
Date: Fri, 23 May 2025 05:53:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/5] block: another block copy offload
Message-ID: <aDBvsMYTqoRnxa0f@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <2243538c-ca19-4576-af94-ed6e1790c82d@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2243538c-ca19-4576-af94-ed6e1790c82d@acm.org>
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

On Thu, May 22, 2025 at 08:52:19AM -0700, Bart Van Assche wrote:
> Before any copy offloading code is merged in the upstream kernel, a plan
> should be presented for how this partial implementation will evolve into
> a generic solution. As Hannes already pointed out, support for
> copying between block devices is missing. SCSI support is missing.
> Device mapper support is missing. What is the plan for evolving this
> patch series into a generic solution? Is it even possible to evolve this
> patch series into a generic solution?

While I agree with some of this, please keep cross-device copies
out of the picture here.  The cross-namepace copies and cross LUN
copies in SCSI are a horrible misfeature that is almost impossible
to implement in an I/O stack.  If someone ever manages to get them
to work they most certainly would have to use a very different
infrastructure outside the block layer.


