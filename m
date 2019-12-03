Return-Path: <SRS0=ysN4=ZZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31346C432C0
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 15:41:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05C632073C
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 15:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bn8Kgo31";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7k+6Vf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C632073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pezSrFSVudvnJN5rW88xZZN7v+wgu9sj4cyFrNxMd+E=; b=Bn8Kgo310JpoBX
	cbhhabS0vZnib55qUMPCfesu9rJRy2ymDL6BXmo7jQv7w2nrvhpijPyS9TdXq+mhpm+iExzc4kKlS
	Iwtz4tTHnMNd67vKbbhFqnGcdnNwrGK5TVapmaUUdP3RPtA0S1q8qyizk1O6lbyabhGSY4VifFQLS
	+t/EmqGRZcXkt8XSFOTESebH2avE6uNHsZBwAc5WEd5OOWYdvt+p0QTeA6HVKXxpfqOa1UC/iga9k
	0IHKoza043SK13dhp9fQNtPTh97s2B8LHoQ0bdsj7XqQu9wQ6Uox4kHkQE9PqvOmfwGennXRssYT6
	IAEXcuFN4zm0bBNxaB+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1icAIn-0005j8-Kc; Tue, 03 Dec 2019 15:41:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icAIl-0005aH-TZ
 for linux-nvme@lists.infradead.org; Tue, 03 Dec 2019 15:41:25 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E233120803;
 Tue,  3 Dec 2019 15:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575387682;
 bh=C1e9qGONs2IJvE11GxXjOyur3iSgPRt4NG/aC8+8Sxk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g7k+6Vf1UqgCsTeaAQ7jsVBd/HGNkNlbYxXRrgPVG9AKcRbmijguR8e5M7RYJTkag
 Q6ukjlSBi7/6+2mf75OBTunbCx8f+SINdZvuZ3/aBsrXmZsMf0N0N/Ru+WaKVg3wPH
 cpZdMGIqMVhKuyC2t+NYxilMNyj3Kymf16sN4aq0=
Date: Wed, 4 Dec 2019 00:41:16 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme/pci: Remove last_cq_head
Message-ID: <20191203154116.GB1996@redsun51.ssa.fujisawa.hgst.com>
References: <20191202221829.1940-1-kbusch@kernel.org>
 <20191203073655.GA23881@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191203073655.GA23881@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191203_074123_976650_8B56C004 
X-CRM114-Status: GOOD (  12.86  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 03, 2019 at 08:36:55AM +0100, Christoph Hellwig wrote:
> On Tue, Dec 03, 2019 at 07:18:29AM +0900, Keith Busch wrote:
> > We had been saving the last_cq_head seen from an interrupt so that a
> > polled queue wouldn't mistakenly trigger spruious interrupt detection. We
> > don't poll interrupt driven queues any more, so saving this value is
> > pointless.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks, applied for-5.5.
 
> Btw, didn't you also have some other patches to shrink the size of
> struct nvme_queue from a few months ago?

Yes, I need to rebase those and do more testing. As long as no kernel
debugging is enabled, I believe we can fit all the nvmeq hot data in
one 64B cache line.

This was just the first patch. I doubt I'll be able to get the rest
completed for the current merge window, though.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
