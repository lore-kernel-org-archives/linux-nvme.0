Return-Path: <SRS0=3deH=D5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A81C388F7
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 13:37:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1AC20790
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 13:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pYdUT0MM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B+Pj6DR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1AC20790
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dfGG15TSfoH4hmmKRcLWihZO8neJKQHikyutt3jxdeY=; b=pYdUT0MMA4AMdqe5eReCm8Cw3
	HULxMz0spmYFTFi/mwZrtrX50AUrYqp4QUtIKyQGTljAhCO0lk8Z13pTjzBDH/JUn7Odz1Ez9Vr1h
	071SX9p9Iwh/gNplsn7+plEZROvkNCaCXbcHtT61awv3WUGQVJ4l9tA7Ikqrfx50md3rYqQtt2oDM
	3SN3bLsks4Lh1QsjaKP/K+J5xelwIspYvZJ/wwD16bEDTnXlTlzGIw9If6XSx14k1npMdLAnDmkT5
	3VM+6JQeYpootVDWqKbN4p71fCHOkCdkv66uFS3dnqYeebCS7GC8UmisgcCKhhu3DeQEdydCoyk85
	2yWEk7OrQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVame-0001rw-Oy; Thu, 22 Oct 2020 13:37:36 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVamc-0001qv-20
 for linux-nvme@merlin.infradead.org; Thu, 22 Oct 2020 13:37:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Sq5FTZdZCuJGAIiKXu3zLR9CZVx0uxX1AdIquLrEsgI=; b=B+Pj6DR5yEKu9LB+yUcra1FTbf
 /l8MgobJcmeV/4PXd3HPjTRlhLvY55fQUo41W4EKMA1Tv+LmoNYpEdc8N+I5dHxYvF7yL/QP5UNDY
 Q/OqYM973h3IiYEaSfBcukkbIMRVESdJtFAEmgm/N8wqverAlavRaH/6OkDUPdGLZ8bo3Vgq2xp9Z
 WmXXXtM9XuZi4YBa+nyaIbsLYul4QJh6z+oQ4prBs/JUqbpc56PGgbp1XCakTua26cqojK3d9iVUJ
 GUY02ojVJXmc9FOjHqJSMnfb0aP9vvbHRSIezttMFkS0C7pqzQ7Xg+t5B+lL5TCcN9KNCmW4qg91V
 cVFz4e2A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kVamb-00080U-7m; Thu, 22 Oct 2020 13:37:33 +0000
Date: Thu, 22 Oct 2020 14:37:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH] nvme-fc: wait for queues to freeze before calling
 update_hr_hw_queues
Message-ID: <20201022133733.GC30500@infradead.org>
References: <20201016211724.48707-1-james.smart@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201016211724.48707-1-james.smart@broadcom.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
