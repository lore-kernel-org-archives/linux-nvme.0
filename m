Return-Path: <SRS0=3Qb0=PQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14409C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Oct 2021 10:50:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89EA860F58
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Oct 2021 10:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 89EA860F58
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zRx9zELfEHzPYHyNotgDouNdKY73NR23SH0L6gjQgX4=; b=x+7PfJCwOS22fBmk8Jgosj2jsZ
	/dH5KHw0nxfqmOW4hd1HLBL/rQG8M1xNH6t6ywYykDPajBiavCUzaHCFj44zDT0JG5Bq4QwV5cXzt
	fMFKSvJp5yQC1uoXs9AtLHLcu9qUfGcxBqhq4d2FIAVKW7KOEoSZDZ9yQkYlmNiSAjh8H0v/tkFlS
	OVwblYBpWYg1v2u68+KmpxOeMZnZD70HZHvi3PCvXxHZquSspyqtYn55ff/qeHQBcFnW8t0FGBjzi
	KOMUAgt1uR3/RWlEQsUVwLMU2vET4e4xikWhz8Q7/YLtW1U8S5xOXIlWnj04o2gX1P0rPI8Xs+Y8u
	zGDiqpig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mg2yw-007ZpA-IZ; Thu, 28 Oct 2021 10:50:02 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mg2ys-007ZoY-PL
 for linux-nvme@lists.infradead.org; Thu, 28 Oct 2021 10:50:00 +0000
Received: from localhost (varun.asicdesigners.com [10.193.191.24])
 by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 19SAnnCI011579;
 Thu, 28 Oct 2021 03:49:49 -0700
Date: Thu, 28 Oct 2021 16:19:48 +0530
From: Varun Prakash <varun@chelsio.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-tcp: fix data digest pointer calculation
Message-ID: <20211028104947.GA1690@chelsio.com>
References: <1635182214-3958-1-git-send-email-varun@chelsio.com>
 <20211027055725.GA9635@lst.de>
 <26648af7-f459-5d43-bc2a-ef2c63715418@grimberg.me>
 <20211027071316.GA11266@lst.de>
 <252308fb-d557-34ce-5c7f-a6307f92b111@grimberg.me>
 <20211027144914.GA1851@chelsio.com>
 <9dc338a1-d047-0d48-15cd-317b637d5491@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dc338a1-d047-0d48-15cd-317b637d5491@grimberg.me>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211028_034958_855918_AEC94E65 
X-CRM114-Status: GOOD (  17.38  )
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

On Thu, Oct 28, 2021 at 11:26:02AM +0300, Sagi Grimberg wrote:
> 
> >>>>>>diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> >>>>>>index 07ee347..d641bfa 100644
> >>>>>>--- a/drivers/nvme/target/tcp.c
> >>>>>>+++ b/drivers/nvme/target/tcp.c
> >>>>>>@@ -702,7 +702,7 @@ static int nvmet_try_send_ddgst(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
> >>>>>>   	struct nvmet_tcp_queue *queue = cmd->queue;
> >>>>>>   	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
> >>>>>>   	struct kvec iov = {
> >>>>>>-		.iov_base = &cmd->exp_ddgst + cmd->offset,
> >>>>>>+		.iov_base = (u8 *)&cmd->exp_ddgst + cmd->offset,
> >>>>>
> >>>>>Wouldn't be the better fix to divide cmd->offset by 4 instead of the
> >>>>>casts?  I can fix this up inline if that is ok.
> >>>>
> >>>>Don't really mind, what makes it a better fix?
> >>>
> >>>I generally prefer to avoid casts as they paper over bugs.
> >>
> >>I'm fine either way.
> >
> >cmd->offset can have value 0,1,2,3. cmd->offset / 4 will always be 0.
> >If 2 bytes of digest are transmitted in the first call to kernel_sendmsg()
> >then in the second call remaining 2 bytes has to be transmitted so data digest
> >buffer pointer should increase by 2 bytes.
> 
> Right, so let's just change the cast to (void *). Varun, can you respin
> the patches?

Both the patches are already applied to nvme-5.15, should I send v2 or
create a new patch for u8 * -> void * change?

