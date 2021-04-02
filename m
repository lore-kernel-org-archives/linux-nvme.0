Return-Path: <SRS0=ZbIm=I7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2876C433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 16:17:58 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 481BE61006
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 16:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481BE61006
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3tBJ6KS40XuN8Zg3XNf2vlZXBVIRQA8o/wdxLe/1MtY=; b=ny0mDe13Kl8ddXHkVqUEdSZjN
	qmwaGYMqSCpEci66NgPj4yROwOORpWcdRqIj1XqSN+Ht+1fJzM0Kou2RxPHcE2Sp+kBzdtdKOl8LN
	Jm3XXIZQ17bsZYmud635kz6MUhX7eYdbMy41E/QVlGGRU4zKJChAnPUiQnJyWaZykJU7MQXw+SSJx
	9DgPi/rI+EF4ac9Kp7y54/6PG+Wa0RDM3GsQMr91AHTmyieMCYiza5Qga/e4Zh679yMS3JtunmCAm
	8y0NfDH9RbpK+pP2/7jcNArbQQZzNEzlXCjIg2aNpuN9fvshpLsLxlkSUceBoyMUXGY6Kqk6ysJL1
	JfXSzRfPQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lSMUR-00DNng-0b; Fri, 02 Apr 2021 16:17:43 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lSMUO-00DNnV-Vk
 for linux-nvme@desiato.infradead.org; Fri, 02 Apr 2021 16:17:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Pl4pos0sgJHeknr6GYM24byjqPOI5wBAmgtQaYeIfs8=; b=hWANw9KqJ558akMc/awjGaqs1s
 Bj9pgC/Z80dPs3HCPLePn8LkJw1EuLsR267A3Nw8/4EV1z4DJHMOZgQlkI6vrS132IFPnjNeVo2xi
 MThHkfCc308syXuLdRF3MmEgRjnQmNmj5F84p4PrqoljBSotGzKQtgfu1jtfESUJS0QEwYXGyZBPw
 m9JoP/bRmQeCuifQ02v+svFI3DBRdFpFiqBoB3+IZyKYkRIPmBbDADDXP74qhj6IAJSvL3a+oFSTF
 T+Ezi9ZIQOU3xcgZ26mG8QWaCYCp+kXoNXVTLJpkyMHAz2gCpiW9PtQysi+biEmzS6/yWCvXocl6l
 N1iEvAZg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lSMUG-007r60-Td; Fri, 02 Apr 2021 16:17:34 +0000
Date: Fri, 2 Apr 2021 17:17:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Grupi, Elad" <Elad.Grupi@dell.com>
Cc: Hou Pu <houpu.main@gmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH v5] nvmet-tcp: fix a segmentation fault during io parsing
 error
Message-ID: <20210402161732.GA1872113@infradead.org>
References: <20210331074856.46966-1-houpu.main@gmail.com>
 <20210331091314.48925-1-houpu.main@gmail.com>
 <DM6PR19MB40112E2D348A3FF80009BDBDEF7C9@DM6PR19MB4011.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM6PR19MB40112E2D348A3FF80009BDBDEF7C9@DM6PR19MB4011.namprd19.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

On Wed, Mar 31, 2021 at 01:27:40PM +0000, Grupi, Elad wrote:
> Looks good to me.

Is that a Reviewed-by?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
