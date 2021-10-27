Return-Path: <SRS0=8pqL=PP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDB4C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 05:57:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19DF960FBF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 05:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 19DF960FBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OuV8ztPeM7u/iN/TZqyWcpIoNBNFCR1A84brwM+Ul1A=; b=SQOTaigWX2aHMHIxJvyRWCC2sX
	/5px9j7sKKBuhjHL1nj/b5C0rhdLKIWV7BkrLRkMfQNPrdfytuzWNMvQTQ/HXJ6CD3dF9at8ogHCu
	SQrHnIywZeaPI/M1SxQ9IGgTu79DeIxIJJpnN2N1W0T2Vmb52ZYyorqQypYqgp42OavCB46F0eOUn
	dAcsN1Cx8AvrIDvg1AUNVdNIYJnw+RLzHnfOU690F9HUQyHzl4VR1f6hb+GYnj9BGodayaSPduh7k
	Il/wIITaCOyNf+OXm+hjYGRNLTKftzXAMZrCz0TmT9K/+69+15fdf8vdSPDW7b4B9/9K2U75QqiC7
	IRt4cbTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfbwL-003wRv-BT; Wed, 27 Oct 2021 05:57:33 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfbwI-003wR1-D7
 for linux-nvme@lists.infradead.org; Wed, 27 Oct 2021 05:57:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9241767373; Wed, 27 Oct 2021 07:57:25 +0200 (CEST)
Date: Wed, 27 Oct 2021 07:57:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Varun Prakash <varun@chelsio.com>
Cc: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-tcp: fix data digest pointer calculation
Message-ID: <20211027055725.GA9635@lst.de>
References: <1635182214-3958-1-git-send-email-varun@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635182214-3958-1-git-send-email-varun@chelsio.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211026_225730_618490_419C9B55 
X-CRM114-Status: GOOD (  20.05  )
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

On Mon, Oct 25, 2021 at 10:46:54PM +0530, Varun Prakash wrote:
> exp_ddgst is of type __le32, &cmd->exp_ddgst + cmd->offset
> increases &cmd->exp_ddgst by 4 * cmd->offset, fix this by
> type casting &cmd->exp_ddgst to u8 *.
> 
> Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
> Signed-off-by: Varun Prakash <varun@chelsio.com>
> ---
>  drivers/nvme/target/tcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 07ee347..d641bfa 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -702,7 +702,7 @@ static int nvmet_try_send_ddgst(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
>  	struct nvmet_tcp_queue *queue = cmd->queue;
>  	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
>  	struct kvec iov = {
> -		.iov_base = &cmd->exp_ddgst + cmd->offset,
> +		.iov_base = (u8 *)&cmd->exp_ddgst + cmd->offset,

Wouldn't be the better fix to divide cmd->offset by 4 instead of the
casts?  I can fix this up inline if that is ok.

