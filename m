Return-Path: <SRS0=WLLZ=IK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745EDC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 20:00:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C7664F83
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 19:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C7664F83
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nUaZRGaQZ8gnusiJuqe02ujk/2RVXfCxtDK3fqpjBFE=; b=EcwyngcAC1LAvGGFgYhSVl1ob
	CdxzcdESWrrmztnEmwuEfBTOUz67E6p2H5hdgSh4T2Vm+aIxnWRa0UTvF/E0LQmYLYBREuyqp+FDE
	7zzJGx1EleQuTqYnasP426lVjHz47p/0EYagoYQkVSpJN1wUbTN8E3BV0Fa1/8P/MQkddIY3n5WHU
	PrpT+JTGzc3KnAd1TCCcf/W1RUatScFp9tHF8Vmhj61MDzMwqeAP9w+YfbEk+wfs11Cjl3BF2Uy7G
	nKQmLD2309g/n5zsHvuvMNHVL0tmgWAZpSM1nR3m1WnQQyjQemKw6ehWzCtAp8Vj5unIeEZP+ZPqN
	uBWHi0tbQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKnwq-00CJ8q-VX; Fri, 12 Mar 2021 19:59:49 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKnwo-00CJ8j-Tv
 for linux-nvme@desiato.infradead.org; Fri, 12 Mar 2021 19:59:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=z/WVDPyoiYx+3v4MoI6hQ+ccpVUKQN/8sNngspuqCn4=; b=s+c/9ngZmGFynR3M9SEFQGA7T9
 ELHfC718T0Gb3pShqor0e7nFsS8P+xKN8mm/tukmPnT8wpadXRN8dJoICuNgqZuj0UBUmtRQAo/bJ
 IaJoB/P3+/eBywJaGoPW36SOkDqT3dlZxSzXMk18dH2TMxT9Wu6Ss58wwCgM+Bmizdh9KSUHtDABT
 /+eEMdK/OZr4gajPEew5vYIeUUXD3/moByeLkuJjbHAg7BF6i8nix0P4psAr9JzvxwTOceh/jBS3C
 ZbzutXQ0uRqC2V4zz9aGw8e2p5QVq2+Q83p9ctFik58rZ9OBj0UVcI1y5IZOBiCEDPn2+5Z2JkzQa
 SgSCZWoA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lKnwa-00Bbj1-5F; Fri, 12 Mar 2021 19:59:35 +0000
Date: Fri, 12 Mar 2021 19:59:32 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
 linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme fixes for 5.12
Message-ID: <20210312195932.GA2766489@infradead.org>
References: <YEszeMEAQyfTPgHH@infradead.org>
 <2a34717a-b5c5-0a3c-02b0-eb8a144aba15@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2a34717a-b5c5-0a3c-02b0-eb8a144aba15@kernel.dk>
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

On Fri, Mar 12, 2021 at 07:21:39AM -0700, Jens Axboe wrote:
> On 3/12/21 2:25 AM, Christoph Hellwig wrote:
> > The following changes since commit df66617bfe87487190a60783d26175b65d2502ce:
> > 
> >   block: rsxx: fix error return code of rsxx_pci_probe() (2021-03-10 08:25:37 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.infradead.org/nvme.git tags/nvme-5.12-2021-03-12
> 
> Pulled, thanks.

I just sent you another one liner fixup on top of this directly.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
