Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B614BC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 13:13:57 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51B666135C
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 13:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B666135C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3CQdR3/lQi9A88lKeRI08EFpMmeIWr5b0Wa1q6hB+5U=; b=JGDXqIqkjr+p7n++kBxBnrenG
	F85EdQAbiVOnWjce7k8zCGK99tInFBVMYV6GMOnAbTamMHXbtYPzxlkuI7Dmcmar7gBSRh9f9lEdn
	UnqZSHBxNrv+ebgSv7SGrIXPm2WUR/7iEeE9JUyjYJFjY7yyptA4TtaOCt2GWXDP2f/mJ/hXnC9pQ
	aF2GfS4qPVvSyvdxMWdCFYBz1esxgM/1PTv2oTxBK8qrSupMwgnkbrz2DkKAN3/fady510K+evrm4
	erKaiR6rQGe5wEUyJXNzC84tidolUK5bW3OKH4BWFS2icBJLmddV485H9EO5T2IU2E+N2QOfhxqgA
	HEnLrj85w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljM0v-0044Wx-5K; Wed, 19 May 2021 13:13:29 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljLpx-0040WO-Vf
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 13:02:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=xZki6dotslWF49EdIRfH0O9CrV+S1CSCLJdqu9ynE94=; b=rpq5dgEstbq/Qh6hq7HClIP8ek
 OHWeAQUe2Dq+uOzMV0AwbfZIC4jjGUhwPnz5CGev5/jLl9yJJklZ1mNwoy74CoUPnIoTIsW5YmqG9
 Uv8LWkL0S7wMjjpsvBpHsjsnm21B7bLHh33tPHR+L1un048mLbnphY8YcegWeK91eE2Hz4IShvpex
 VIkqOx4jONxodRN09T7EyB7bQxi4V1qROafxJK//xNw4drii6vCUiSAhpzgf6twf62pv49lF5qI00
 92S5fdzCE162CE3mjudWEU6Gac5VGDIW1Z24u6InmXMQJYM663DYOYjk9jnwrQBmyyKtpWjXXvWTO
 5yW2kA9A==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljLpu-00FToG-UY
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 13:02:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DA76167373; Wed, 19 May 2021 15:02:01 +0200 (CEST)
Date: Wed, 19 May 2021 15:02:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 08/15] io_uring: don't sleep when polling for I/O
Message-ID: <20210519130201.GA9474@lst.de>
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-9-hch@lst.de>
 <22a8e5a0-b292-a2c5-148d-287c1a50e2b9@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <22a8e5a0-b292-a2c5-148d-287c1a50e2b9@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_060207_154430_8239E6C8 
X-CRM114-Status: GOOD (  17.23  )
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

On Wed, May 12, 2021 at 02:55:59PM -0700, Sagi Grimberg wrote:
> I think that the combination of oneshot and nosleep flags to replace
> a boolen spin is a little hard to follow (especially that spin doesn't
> mean spinning without sleeping).
>
> Maybe we should break it to:
> 1. replace spin to flags with ONESHOT passed from io_uring (direct
>    replacement)
> 2. add NOSLEEP passed from io_uring as there is no need for it.
>
> Just a suggestion though that would help (me at least) to follow
> this more easily.

I've split it up for the next version.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
