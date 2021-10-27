Return-Path: <SRS0=8pqL=PP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B4EC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 21:37:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B600760E0B
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 21:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B600760E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iGCBtK9wKeP5YlgQrMGlmHqO6v6cfoBBqODVaao0c0c=; b=J1mOEV2apENaU2w1UE6AtXXATT
	J+kEhMA5wUu/rxmsgamBeK/LLmw/WefWteXJGHAoT8rmvU/rXUbv2Qr9bQ7wPInGp3J6hDY/g86hm
	JwssRfN2AFe/ReaNG27IFArn92V2KTh2uFRbUQO0LfWMBi5oJJJucnvN7VbbDXLt7MmQLq09eoFRD
	FYbyEh9Nm5ORikHvLbVd5Ryb2uyg7murloK38kVskhNcXvvopVRpOzq06tvem1P8rM08ic+j6fqGw
	cVq0Ix3LJccBapeRbuYB2BIhW9rB3/KJl7D7IVzlO+uDjSEExQYyK+seU+0MwJWq21JxLCqrOe28W
	BvTqvjiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfqc8-006I39-UN; Wed, 27 Oct 2021 21:37:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfqc6-006I2N-Pv
 for linux-nvme@lists.infradead.org; Wed, 27 Oct 2021 21:37:39 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6000B60E0B;
 Wed, 27 Oct 2021 21:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635370657;
 bh=R9qpIdHcRQD24ikwPUy8Cb2FUMN+h+iNK+MYYmfxQkM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fQ5Uk/zq01vrj1v14h36ZE8sNbzYe4WEsC2mQd7vGVYhxopne7c+cIVYpK1tCoVMM
 AIjM8jRFnBxIXy/e0m/9/sMA+/89YbfzHxZ6V8XfFbMoAqoOLnUM6piPKUcVq4vLLF
 lD3Gtsgfgkqrl61zkG6HCECPdCQ8TiKYpsFFrAWK8hnHAfC5IiL2opRwWSw64SUQ7T
 kdw1oKj5mzV37T0zjNy/kV5Kj8CG7D0vcQI0KjO4IiZpYtp/vVfFU46QC+ndIZ9FnQ
 Lm7OPNHhMtjpYu4Mr/gdoBKNKQnq2mpjc/fndP40o/6kFTTecCKTCKBDs6GaRCy3YC
 nPir4OLx/pdGg==
Date: Wed, 27 Oct 2021 14:37:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Varun Prakash <varun@chelsio.com>
Cc: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-tcp: fix data digest pointer calculation
Message-ID: <20211027213735.GC2338303@dhcp-10-100-145-180.wdc.com>
References: <1635182214-3958-1-git-send-email-varun@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635182214-3958-1-git-send-email-varun@chelsio.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211027_143738_898668_268F6564 
X-CRM114-Status: UNSURE (   8.03  )
X-CRM114-Notice: Please train this message.
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
> @@ -702,7 +702,7 @@ static int nvmet_try_send_ddgst(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
>  	struct nvmet_tcp_queue *queue = cmd->queue;
>  	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
>  	struct kvec iov = {
> -		.iov_base = &cmd->exp_ddgst + cmd->offset,
> +		.iov_base = (u8 *)&cmd->exp_ddgst + cmd->offset,

This certainly works too (and it's already applied anyway), though
everywhere else in this driver casts these to 'void *'.

