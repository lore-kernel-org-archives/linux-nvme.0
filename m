Return-Path: <SRS0=D26X=KB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFE5C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 14:51:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F9FD61078
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 14:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9FD61078
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LxZsrmX60M2SjyrKKX9LU1TP6y/U5D1tyhP/MUdKFsI=; b=nq+O4+u9GUSPj63r0dEC57VYU
	Hh96rU3p3mCujddn1ng8VJNxydM04wQx+VVse01xOYl6WIDy6Hk8K3X26SCzGOBeRe8Lei14DIgnG
	4KR7Pj3b+VTRw4hInApmpGbpLjxqrI5gb+rs/8YVpKXWt2vcSQm/q7OX5zhvFW8M741wEKreTL7Rm
	/G25tYLJvT5wmNnEOiFWrQpARZXxbI/6qvUqV5irgjt/mqprswCj4rhIJfep0yIDhx52fjWmI7UOi
	gSQjZFwqKKlTNv3f782tmGyjH81lpXp2ugKnYeb+Ewq2f4jHZ9HpqzM6/lZPEg4jPCVQ1jQEn/0La
	4ESPmircA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lefLJ-004Tra-UK; Thu, 06 May 2021 14:51:10 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lefLH-004TrP-KR
 for linux-nvme@desiato.infradead.org; Thu, 06 May 2021 14:51:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=/TMtveEPWLScdcHgZ2UDsKWAWwu7lL3VdMsg0MuWSpQ=; b=eH5mvIPdKEMTbdGOAZBY9Kz5GB
 /ZdH2lH+Fd842Sjv9W+wZ2adP6pIzYSOchTFGv/hJ4GjQSC3wonSQOaS3nuH0FNlj3pDe5c+9gl1r
 u2hRcF6coox6KxCb5MY3Tth25PXX50scYzfKfcVF1j+DBoxEqCKBxvnQxl1jnijlGSOA4HqZmPxoQ
 ka0E7cdX161XtfxhwEevAyffegBuXhXIbmoOpekfGEoL+RS67TMsMswy36EIxwoY+fr7sOuSwBWFO
 WcTJV3QP+bmxVySfudRhlnAWxJjRvlrlV7Yx4DXUbxo1b2U+IsbNK0lcXFNIn4+Iny4EcO7aWuzz7
 t2aKMptg==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lefLF-0066qr-58
 for linux-nvme@lists.infradead.org; Thu, 06 May 2021 14:51:06 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7BEF61166;
 Thu,  6 May 2021 14:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620312664;
 bh=oF+gjJpUgKfhAym/Athd3xjGJn9Jk6FEqHI64rIPROg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ODZXjRXeB8jgZO0BiweDW0zP46MXHaf8RjiQjRavv1uPYbV+m8D6HrvzcPRCjpriw
 ANJ1uu/L6iTtYp/rhYCa4OXggpPaCOYUw4lHdKGhLNVZOb6PtQbd71LNZ42YtOPbZu
 ZiAU/dkFPI4TTPUU07sImGLPhvH8FPV2gxFrK56RW3YEp8pnWllaCRwVtpnXOT0v0v
 +stsYo4hTYoDTBS9FGtvNbkogtpXelrCOoMGXdYSQf8cU5cI5wNo4ONH4bCEA6OHum
 Ac2Xqs13+d7quRzN5zlT8RyocHEax27luaWBlLYxsmvx4ZasoyPZAjGHq2CM7ye/o+
 LKHitvPLRq1+Q==
Date: Thu, 6 May 2021 07:51:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH] nvme-multipath: fix double initialization of ANA state
Message-ID: <20210506145101.GB1187199@dhcp-10-100-145-180.wdc.com>
References: <20210506134823.2566853-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210506134823.2566853-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210506_075105_239627_D1D5AB96 
X-CRM114-Status: UNSURE (   8.15  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, May 06, 2021 at 03:48:23PM +0200, Christoph Hellwig wrote:
> nvme_init_identify and thus nvme_mpath_init can be called multiple
> times and thus must not overwrite potentially initialized or in-use
> fields.  Split out a helper for the basic initialization when the
> controller is initialized and make sure the init_identify path does
> not blindly change in-use data structures.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
