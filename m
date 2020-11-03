Return-Path: <SRS0=7iC9=EJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B79C2D0A3
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 09:26:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C28223BD
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 09:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NnpNUMsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C28223BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jRvfG0Wtr09zjoE0gMmebDj5t35dO9VEkZCU2oR8m9U=; b=NnpNUMshSyvIAjHYmHO8kbVWE
	QKrvBwiHPE7RRHInmTWvpAvMQEs2SxJpvDyJFxBRQmRNTofiy/1NUMxxfLZem7eZdMsfIByl+evZa
	8nO6ztBZn89Hu3kxvQTidBY00BZYKV+qZpKPevsswkBGWxBE+499zjzMXH28zbQbaz9s/DenGhHXU
	g5+DuJ//H7hPEMk0fETfgV+5JHGknZZNfKC8fPXfXpKKWrNWMYHsQ8HZY3O1MRb6KsiPLLlx48D8N
	fI283DfpZb9Rmp+x/hveZQrdO30xuVx9I9hN94qSWlnNIkCLKOztK8FQe1eV/3HFncctFhnWz/tdQ
	E1XRfLGuA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kZsaW-0005uy-Q7; Tue, 03 Nov 2020 09:26:48 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kZsaT-0005uD-9w
 for linux-nvme@lists.infradead.org; Tue, 03 Nov 2020 09:26:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 181B868B02; Tue,  3 Nov 2020 10:26:42 +0100 (CET)
Date: Tue, 3 Nov 2020 10:26:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v2 1/5] nvme-core: introduce sync io queues
Message-ID: <20201103092641.GA17061@lst.de>
References: <20201022021500.11022-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201022021500.11022-1-lengchao@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201103_042645_501637_010C573A 
X-CRM114-Status: UNSURE (   7.24  )
X-CRM114-Notice: Please train this message.
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

I've applied the series to nvme-5.10.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
