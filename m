Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CCEC9830E
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2026 07:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2qyMn93MLArveMJYlKmMICSJihx3xi2DTJFGQbj9cFU=; b=k5mjep+3o2Pz8FRjIA3/i8LFf8
	+MnkuEr/1KzM3wwAewnat/vUe+VKURRQRWEAvAbQIMGfr6MbLDxpXoNoe3Rs1BQDbUO7P4aCJ8X5z
	TJSg8QFpiMkiLNKFbEd/+Ol4R5aCZhIe02fMZWHqIs3rBBLWoW2g762LMhEkdaWmKat5QVr0yqiQ+
	5/7iYUhReQYSFcCFAMnct1WYWX8+otqIzJe+PzEKepyQQURvWIoIAxggFwTU/0X+1MIVnq6veZ322
	iSDc/xFZL9jN3Lhkn5IabsYl9JYjx0PRj79umcH06W4004odZT6fW4knIoHXInIq0ovc5Bb4HLABe
	ot9DTCOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA0W3-0000000Cp9x-2EsX;
	Fri, 25 Sep 2026 07:38:43 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA0W2-0000000Cp9r-17It
	for linux-nvme@bombadil.infradead.org;
	Fri, 25 Sep 2026 07:38:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2qyMn93MLArveMJYlKmMICSJihx3xi2DTJFGQbj9cFU=; b=Bw7YvqMRmTWkkz4LYZuqn/ZV31
	WzUfW7ej659gtYJtPe6p0SI6MlfgzmtppmzpA9uxy8rWTiwkFt5xHWtVmvKTnXEEBabw2u/Dwcxwl
	6L+6HpKUznd2ckZXvgkcwEVQv/CHdqRedirAUIbmvdYHuIINahtZPlhFa9okMy2V+1Xhz7PFVHQ81
	0nReovRBnf4AS4b4w1G3pOGzZJCdGap5fb9MBf4R5eId3CyD2QCac29n69BrGXqjYJDZGuwiCHJGh
	H2JErv8E520eHqPdr51pH1pHYSKZXcTZLH6uXAaO9+hSmxNOFnWOTWj5IZdy9Oacn5yHbrc0fLDZV
	ib+pdrPw==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xA0Vz-0000000GhM6-0POI
	for linux-nvme@lists.infradead.org;
	Fri, 25 Sep 2026 07:38:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CACD768C7B; Fri, 25 Sep 2026 09:38:35 +0200 (CEST)
Date: Fri, 25 Sep 2026 09:38:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, sagi@grimberg.me,
	Jens Axboe <axboe@kernel.dk>, john.g.garry@oracle.com,
	wenxiong@linux.ibm.com, gjoyce@linux.ibm.com
Subject: Re: [PATCH 1/2] nvme: keep transport module referenced while head
 node is open
Message-ID: <20260925073835.GA5608@lst.de>
References: <20260831152006.819471-1-nilay@linux.ibm.com> <20260831152006.819471-2-nilay@linux.ibm.com> <20260902133104.GA20945@lst.de> <c725f90c-b119-4669-afb7-6aeb6c4a308b@linux.ibm.com> <20260902141347.GA24385@lst.de> <61165430-a724-40d3-a00d-2cbe1ea656b0@linux.ibm.com> <57629796-d346-4cc4-8c9c-b153a60e1709@linux.ibm.com> <fe4e7f28-14ec-4b8f-81f8-d230569cbdad@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe4e7f28-14ec-4b8f-81f8-d230569cbdad@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_083839_632395_D29CB602 
X-CRM114-Status: GOOD (  12.44  )
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

On Tue, Sep 22, 2026 at 09:03:38PM +0530, Nilay Shroff wrote:
> Hi Christoph, Keith
>
> A gent ping on this one...
> Do you have any further comment/feedback on this one?

I still don't think this is a good idea.  Removing the transport is
valid, and allows to create a valid condition (multipath gendisk without
paths).

