Return-Path: <SRS0=8pqL=PP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7526C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 14:49:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D9A60F38
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 14:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69D9A60F38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3eZ91952l1NUb9L1x0oO+swp3+55gSpTudawp4QPa5Y=; b=TKTTEL7MlNfwEH2JtX87ziClPD
	CdtXPv6IPaqExAgnDBvcFgDF7h3WW2K2FtSgmUujWbLo5Cs4Dv68iwfZW+g1kjZKWfsU9wRx4VM+W
	8rN5bFuTsgPlECVw4PG6wcAHotF6SZpP/yUg2nj4/ak1X7+MMZIpDbVtLKLzUlTBhWAsManWhrWJX
	/FspDysBuSy5q5Tr0FhghUrGxCBr8wg+5kWK8w9Pmk/PT1ZRH0Lo2vgDjPBnJOQbuzmAzxJoaJOiA
	0m/m5p5Zvbq/eVwkG09AL/lBWtNYQoGYghbBYnHwmL6YD13aM6X8Q9cL9ZVaIew1sj3IDxZ/Np6vm
	AGE3hMAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfkF3-005BVm-1I; Wed, 27 Oct 2021 14:49:25 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfkEz-005BUW-KO
 for linux-nvme@lists.infradead.org; Wed, 27 Oct 2021 14:49:22 +0000
Received: from localhost (varun.asicdesigners.com [10.193.191.24])
 by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 19REnGlO008457;
 Wed, 27 Oct 2021 07:49:17 -0700
Date: Wed, 27 Oct 2021 20:19:16 +0530
From: Varun Prakash <varun@chelsio.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-tcp: fix data digest pointer calculation
Message-ID: <20211027144914.GA1851@chelsio.com>
References: <1635182214-3958-1-git-send-email-varun@chelsio.com>
 <20211027055725.GA9635@lst.de>
 <26648af7-f459-5d43-bc2a-ef2c63715418@grimberg.me>
 <20211027071316.GA11266@lst.de>
 <252308fb-d557-34ce-5c7f-a6307f92b111@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <252308fb-d557-34ce-5c7f-a6307f92b111@grimberg.me>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211027_074921_706598_248B6787 
X-CRM114-Status: GOOD (  14.85  )
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

On Wed, Oct 27, 2021 at 12:49:31PM +0300, Sagi Grimberg wrote:
> 
> >>>>diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> >>>>index 07ee347..d641bfa 100644
> >>>>--- a/drivers/nvme/target/tcp.c
> >>>>+++ b/drivers/nvme/target/tcp.c
> >>>>@@ -702,7 +702,7 @@ static int nvmet_try_send_ddgst(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
> >>>>   	struct nvmet_tcp_queue *queue = cmd->queue;
> >>>>   	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
> >>>>   	struct kvec iov = {
> >>>>-		.iov_base = &cmd->exp_ddgst + cmd->offset,
> >>>>+		.iov_base = (u8 *)&cmd->exp_ddgst + cmd->offset,
> >>>
> >>>Wouldn't be the better fix to divide cmd->offset by 4 instead of the
> >>>casts?  I can fix this up inline if that is ok.
> >>
> >>Don't really mind, what makes it a better fix?
> >
> >I generally prefer to avoid casts as they paper over bugs.
> 
> I'm fine either way.

cmd->offset can have value 0,1,2,3. cmd->offset / 4 will always be 0.
If 2 bytes of digest are transmitted in the first call to kernel_sendmsg()
then in the second call remaining 2 bytes has to be transmitted so data digest
buffer pointer should increase by 2 bytes.

There is one more bug in nvmet_try_send_ddgst() it currently does not check
whether digest is send successfully. For successful digest send
cmd->offset + ret should be equal to NVME_TCP_DIGEST_LENGTH.

