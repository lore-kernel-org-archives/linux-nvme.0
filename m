Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D58C44536
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2026 12:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VzoZBeNkvYMSlZLzpe6T5qS270yKRg+PYHAcaa2goYI=; b=HcDT+txMTbtBc2HE7btoY6sK30
	ZmgTgq4WlWYd27sOQA/9jaKbqyc4tRTHPeKgddBAzY0EhZCtEddrZQDBHtusp6MmkF3VeGMPoO34c
	n3G2/CaZuaP5sgzfv3sJQIuip+togdozykIpc0E4wC3s8+/BgNYJhW8jB3kaWkEaQ7qzSeWQSabLQ
	k1OXOCib02U6NnP0pzbkZ5f0HZY7PFeYnt2UBpRvRRWy1WlahAFJ1RVp+iABhwxAZEVWRcz7CiFoJ
	kQDkNOz3Yi8TBD04L8gEyYribqiSrwZEqUi9nDdkmIoUbwwK2f+TpyTIJ90ZYw2zz4uWYt1CrUr9G
	HwRN0XaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmVr2-0000000Birv-1Otj;
	Wed, 22 Jul 2026 12:15:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmVqy-0000000Biqm-2bJm
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jul 2026 12:15:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AB6F468D32; Wed, 22 Jul 2026 14:15:02 +0200 (CEST)
Date: Wed, 22 Jul 2026 14:15:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
	axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
Subject: Re: [PATCH v4 01/20] list: introduce LIST_HEAD_GUARDED
Message-ID: <20260722121501.GA12774@lst.de>
References: <20260713115444.465704-1-nilay@linux.ibm.com> <20260713115444.465704-2-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713115444.465704-2-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_051512_809551_097A07E3 
X-CRM114-Status: GOOD (  12.66  )
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

On Mon, Jul 13, 2026 at 05:24:02PM +0530, Nilay Shroff wrote:
> Introduce LIST_HEAD_GUARDED(name, lock) to define a struct list_head
> annotated with __guarded_by(lock). This provides a convenient shorthand
> for defining lock-protected list heads and allows compiler context
> analysis to validate accesses to the list against the associated lock.
> 
> The new helper also reduces boilerplate and improves consistency across
> callers that annotate struct list_head objects with __guarded_by().
> 
> This is a preparatory change for subsequent patches that annotate
> LIST_HEAD() instances with their protecting lock.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


