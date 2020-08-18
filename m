Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC141C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 07:00:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB023206B5
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 07:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2uGKiyKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB023206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WVTqxJriyJVbrsAJyNssCIPIS4tB3PiBSFDMcFqLKQQ=; b=2uGKiyKMP0LdWzB9Wy3py83u6
	hGz/wbB3/Bx1E8C1mdvtJVyEGC9kx/c4U8oIDNrWN2Oci5WiTVOqXUcia0gk4CpPrcwHv1lD/07pS
	yC3xr38XE8QPxV89BIhRFRGSDucNnBFHDfuG8chJ25+Pn4h42t1f+DMTCZH3WLrErdwQIrqEjzZuj
	UImoaMEkCnGAVObs70gqrpkX4hOCJwI5sE7PHfoDCqk6J3QiVo6mNLpXkYs7pViW+2rHxbBPFZtAq
	eT2wICmMYwfdEPT8L11zsNGwXRx1rynnY2eBAq0EitQz/ANIhtmm3BBFX78evA7OBs6JbYsf89g7m
	jdKze9qwA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7vbT-0008RB-Uz; Tue, 18 Aug 2020 07:00:16 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7vbR-0008QD-B2
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 07:00:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 20B3A68B02; Tue, 18 Aug 2020 09:00:11 +0200 (CEST)
Date: Tue, 18 Aug 2020 09:00:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH v5 1/3] net: introduce helper sendpage_ok() in
 include/linux/net.h
Message-ID: <20200818070010.GA2365@lst.de>
References: <20200816071518.6964-1-colyli@suse.de>
 <CAM_iQpUFtZdrhfUbuYYODNeSVqPOqx8mio6Znp6v3Q5iDZeyqg@mail.gmail.com>
 <20200817054538.GA11705@lst.de>
 <CAM_iQpWnzm=cQZvZMcjKXez1L55tSVfWyadP3d0CUaT=D4nOhw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAM_iQpWnzm=cQZvZMcjKXez1L55tSVfWyadP3d0CUaT=D4nOhw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_030013_544824_D7AC805B 
X-CRM114-Status: GOOD (  11.75  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>,
 Coly Li <colyli@suse.de>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jan Kara <jack@suse.com>,
 Philipp Reisner <philipp.reisner@linbit.com>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 17, 2020 at 12:12:12PM -0700, Cong Wang wrote:
> 
> So netdev people will have to understand and support PageSlab() or
> page_count()?

Yes.  As they came up with that contrived rule what is acceptable
for sendpage.  No one else really knows and other subsystems like the
block layer are perfectly fine with it.

> 
> If it is unusual even for mm people, how could netdev people suppose
> to understand this unusual mm bug? At least not any better.

It is not a mm bug, it is a networking quirk.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
