Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CBEC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Dec 2021 15:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lbZiPTjEZJ+4tFjbZFClKO95AX52MJ4QX8SZzHt5ZvE=; b=3kmncM4o5+zSmwXGN0HWyUZ979
	Yp0fIVj0qzheqWP+WdgQgf8k+PXqKkzy9ICp1WKv5kZhUYiR6le8fZ6ipfqvtOYis5E7+Re2fKBNa
	0Y+TV/VvfYC3ECERP4mQzaeJF03ZnbHk6pCr9vNZ1DrYiFW0YmEQWEC7ITDt3I5JMaCm/QAkKakUs
	qWpSbJupLwqQgNnd845lWBNb1yQXOTjqu4bml5PlwqMqn4FT4QNBF0bjifQ8AIQUncUCESdQakbMt
	4BScib6oyIKe0ZLvsPs2CUb/nD4lNCg0sgJ1bqbrYusvw9s1UqVqaLNrsuOhk79sgagzpvTp+0X4R
	aab/c+DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1muyqS-00DEgz-2f; Wed, 08 Dec 2021 15:27:00 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muyeV-00D8F4-GQ
 for linux-nvme@lists.infradead.org; Wed, 08 Dec 2021 15:14:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A994FB8169E;
 Wed,  8 Dec 2021 15:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAA6C00446;
 Wed,  8 Dec 2021 15:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638976476;
 bh=1hd0/Eis5O26s4WUYAgC0rOKieGckzFKJMNfXGIPya4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ABVIbfNnCQR6iaO/HC2edSH0/4URxwFN7b1MfmeBSp51WuKjzkiDlDhnxz1spjY+X
 NSLXFcXQBjwRjMdymfUOnXxwkskaU6tP87CWyXgzOT5459ufYss3QiWRVOu8JuZDGL
 LdkJoI58TFjSfp9oJH9hmyDq8PcGsYBz1Z8pq5Y8hBVxGKSRRBOBvbYArioNnMyN7x
 /Tnoyy8tkhb06OpoQYYO61Dzp/9EOoLtmn18xQs1jlV8g1pMd8qIj/accK/erC6Nr6
 P/lhM9/YJMpdhGid+fdU9LuJjafD/jVdtiIuAmTz+ti6/YqWGsEDD/G1z+EUmzPRlz
 P2cIP5rI7PHDQ==
Date: Wed, 8 Dec 2021 07:14:34 -0800
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvmet-tcp: fix possible list corruption for unexpected
 command failure
Message-ID: <20211208151434.GA3852685@dhcp-10-100-145-180.wdc.com>
References: <20211208133506.92918-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208133506.92918-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211208_071439_733253_BA41D471 
X-CRM114-Status: GOOD (  27.05  )
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

On Wed, Dec 08, 2021 at 03:35:06PM +0200, Sagi Grimberg wrote:
> nvmet_tcp_handle_req_failure needs to understand weather to prepare
> for incoming data or the next pdu. However if we misidentify this, we
> will wait for 0-length data, and queue the response although nvmet_req_init
> already did that.
> 
> The particular command was namespace management command with no data,
> which was incorrectly categorized as a command with incapsule data.
> 
> Also, add a code comment of what we are trying to do here.
> 
> Reported-by: Witold Baryluk
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/target/tcp.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index cb6a473c3eaf..7c1c43ce466b 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -922,7 +922,14 @@ static void nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
>  	size_t data_len = le32_to_cpu(req->cmd->common.dptr.sgl.length);
>  	int ret;
>  
> -	if (!nvme_is_write(cmd->req.cmd) ||
> +	/*
> +	 * This command has not been processed yet, hence we are trying to
> +	 * figure out if there is still pending data left to receive. If
> +	 * we don't, we can simply prepare for the next pdu and bail out,
> +	 * otherwise we will need to prepare a buffer and receive the
> +	 * stale data before continuing forward.
> +	 */
> +	if (!nvme_is_write(cmd->req.cmd) || !data_len ||
>  	    data_len > cmd->req.port->inline_data_size) {
>  		nvmet_prepare_receive_pdu(queue);
>  		return;
> -- 

Let me see if I can get this understood:

 1. nvmet_req_init() will queue a response from tcp's RECV_PDU state if
    the current command is a read, no data, or a write with data length
    exceeding inline length.
 2. nvmet_tcp_handle_req_failure(), which is called immediately after
    nvmet_req_init(), will abandon the current cmd if it's a read, a
    zero data command, or a data length exceeding inline length;
    otherwise it will later queue the response.

It sounds like all the cases are covered to ensure exactly one response
gets enqueued for this error case. I think this works, however, a little
confusing with the dependency on tcp's .queue_response special handling.
:)

Anyway,

Reviewed-by: Keith Busch <kbusch@kernel.org>

