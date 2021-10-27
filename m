Return-Path: <SRS0=8pqL=PP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE88C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 07:13:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CDB06109E
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 07:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5CDB06109E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AZUWrWlFQY9zeqeSZmTmGiB116l2niUUjjPOfIDAdzQ=; b=Y/07FdsgE4XINILw/XhdL5NRrp
	JFWzUD3MNphKArfEvKrAwU+hMVC8mEFDF6jhkuoMsVXqa65EGEG7CotBr7KUYG73IkgzbvUNzIad5
	Eg/aaCVXC4+0G7cooXKoc611eZ9OohNiL67xBYGePhWBhh4ShzdXEVqKaxSXSo1X1cv5b2/pzu0QM
	8aZvPRKDUwHRzD6J0Qg6ABX1+PWk8IVW/fNsKMb/+syHNUdd+EqL0jr2p2E4szApaJTXhJblG8fjD
	6pk5RRL5OE6zgBHV7TEdyqufd61NwFm6C8flTObZZt7xrNfDnvk8hki1Z01YFcljQ6hOp9XbTy9G6
	IIi4RkWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfd7l-0047Ol-4r; Wed, 27 Oct 2021 07:13:25 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfd7i-0047No-L2
 for linux-nvme@lists.infradead.org; Wed, 27 Oct 2021 07:13:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id EB74868AFE; Wed, 27 Oct 2021 09:13:16 +0200 (CEST)
Date: Wed, 27 Oct 2021 09:13:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Varun Prakash <varun@chelsio.com>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-tcp: fix data digest pointer calculation
Message-ID: <20211027071316.GA11266@lst.de>
References: <1635182214-3958-1-git-send-email-varun@chelsio.com>
 <20211027055725.GA9635@lst.de>
 <26648af7-f459-5d43-bc2a-ef2c63715418@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26648af7-f459-5d43-bc2a-ef2c63715418@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211027_001322_863388_97237713 
X-CRM114-Status: GOOD (  15.99  )
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

On Wed, Oct 27, 2021 at 10:11:01AM +0300, Sagi Grimberg wrote:
>>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>>> index 07ee347..d641bfa 100644
>>> --- a/drivers/nvme/target/tcp.c
>>> +++ b/drivers/nvme/target/tcp.c
>>> @@ -702,7 +702,7 @@ static int nvmet_try_send_ddgst(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
>>>   	struct nvmet_tcp_queue *queue = cmd->queue;
>>>   	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
>>>   	struct kvec iov = {
>>> -		.iov_base = &cmd->exp_ddgst + cmd->offset,
>>> +		.iov_base = (u8 *)&cmd->exp_ddgst + cmd->offset,
>>
>> Wouldn't be the better fix to divide cmd->offset by 4 instead of the
>> casts?  I can fix this up inline if that is ok.
>
> Don't really mind, what makes it a better fix?

I generally prefer to avoid casts as they paper over bugs.

