Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF8AC77B76
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Apr 2023 05:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P4No43ZKEl1utDQ4+hUc8IIQ8EmV6YA+zJppOylJESI=; b=zqnNqOlWUecfBYVgI3AMfVcH90
	xSTeN8ZPTxN+fo8p/ipDOeFOvTNBlrCrIGoOEDBQA6qaVrXEl6gW8tEGtW6x6QgJFjYuf5cDPXpPr
	5Z4d3tO4jNbRNs/GtsSpwTOTyZc+xB4GjHybMZwPpXs7FJF/Bog+JlH1g5p0WXWyJNYkLcq6Ja4AU
	4bcgCgqNRmTts9g0RkBx8+f3iUWSRFB3iTl1z4eeIqEkrZ5FCA/La0lNG/1IjLhHh1u5G1744KqcO
	YxkT7vo2wyi7b/YeFxKcmUT074z3RzrM1FTX3K0f95I7dl619wUk4FjXSmRI65W2JNPdKQNn2ocK3
	6trGJ47w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqoRf-00FLFi-1x;
	Mon, 24 Apr 2023 05:08:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqoRc-00FLF0-2N
	for linux-nvme@lists.infradead.org;
	Mon, 24 Apr 2023 05:08:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D845F67373; Mon, 24 Apr 2023 07:08:43 +0200 (CEST)
Date: Mon, 24 Apr 2023 07:08:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Breno Leitao <leitao@debian.org>
Cc: Christoph Hellwig <hch@lst.de>, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, asml.silence@gmail.com,
	axboe@kernel.dk, leit@fb.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, sagi@grimberg.me, kbusch@kernel.org,
	ming.lei@redhat.com
Subject: Re: [PATCH 1/2] io_uring: Pass whole sqe to commands
Message-ID: <20230424050843.GA9252@lst.de>
References: <20230419102930.2979231-1-leitao@debian.org> <20230419102930.2979231-2-leitao@debian.org> <20230420045712.GA4239@lst.de> <ZEKno++WWPauufw0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZEKno++WWPauufw0@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230423_220856_943123_C6412A41 
X-CRM114-Status: GOOD (  15.93  )
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

On Fri, Apr 21, 2023 at 08:11:31AM -0700, Breno Leitao wrote:
> On Thu, Apr 20, 2023 at 06:57:12AM +0200, Christoph Hellwig wrote:
> > On Wed, Apr 19, 2023 at 03:29:29AM -0700, Breno Leitao wrote:
> > >  	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
> > > -	const struct nvme_uring_cmd *cmd = ioucmd->cmd;
> > > +	const struct nvme_uring_cmd *cmd = (struct nvme_uring_cmd *)ioucmd->sqe->cmd;
> > 
> > Please don't add the pointless cast.  And in general avoid the overly
> > long lines.
> 
> If I don't add this cast, the compiler complains with the follow error:
> 
> 	drivers/nvme/host/ioctl.c: In function ‘nvme_uring_cmd_io’:
> 	drivers/nvme/host/ioctl.c:555:37: error: initialization of ‘const struct nvme_uring_cmd *’ from incompatible pointer type ‘const __u8 *’ {aka ‘const unsigned char *’} [-Werror=incompatible-pointer-types]
> 	  const struct nvme_uring_cmd *cmd = ioucmd->sqe->cmd;

Oh.  I think then we need a helper to get the private data from
the io_uring_cmd as an interface that requires casts in all callers
is one asking for bugs.

