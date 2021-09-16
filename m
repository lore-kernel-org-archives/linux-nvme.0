Return-Path: <SRS0=Ydhk=OG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FA5C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Sep 2021 16:46:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50CFB63156
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Sep 2021 16:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 50CFB63156
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QIc1NJe9oNLgyqnlN05Ksz5UiPlUOXxOEjr6YTn4GmM=; b=KgKKVGPPuClYmh
	v3ibIEq33O92tvdJwJlqLG1/unvXbp6gwvDZrE4/tHILDAgGekuAln5maAB+8qB1qc1lymoDyTDuk
	yC+2oMvAs/BwhJ7RjBgTXTVvkUYDmWVQfd/9uPHdFP8Sucx7TV4ZQ4BdI1kDkezq9JqFGwt4BwWle
	MLg2ujEZ8Gsj0cLJAYK8Y7eXwfARGBcw1gcN0H1BmoRfxAfOerPo1otW8kkmrwLgse5x7g6BWVFZi
	engoT/4PTDFwbt7RefJ7wsD1UvXl4L/24gG3MyNP8tIOCCDTg2ibvB8GWV/F4N2iunVbnhtAGYPlG
	YFCx7YwryZumN+F/VjTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQuWY-00Bjbx-Kf; Thu, 16 Sep 2021 16:46:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQuWQ-00BjZV-PF
 for linux-nvme@lists.infradead.org; Thu, 16 Sep 2021 16:46:04 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9EA261CF1;
 Thu, 16 Sep 2021 16:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631810762;
 bh=jP5fTIs88LGdjnSrW+yfsUCcjaX6LkhsJHWs7bAvVn8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RzNEmLaKUdnHwIjUMVGQNJdR1Wm7PIiE0BS+pYHE/vgoxAHknsMMhUvjdI0D4EfKx
 qT4pqaxIBeCOVjOMTapiOKfvWvkyj+ng9Eq/3Qzb9+usGtTRev4nNAKC4tEFZIK1Rp
 3oanUlXKZiJgCXcY/BtajSIk/QRlVHg+41H/nWrw1yDlfJV2U+bblmyKGR1Di8wCMn
 Bi/qfo4Z8gfJkcILI/gJVHXS4mBHdk73Uiao2gepEWGSGAdnDFPmphob892CNaG509
 etLSTu7UIxUbOClKjdFs3STbd2emQ7BjtGhMU2inAsdus8i+s9+sp7EgkoXKP7lMAg
 4a1YmaVDIfeoA==
Date: Thu, 16 Sep 2021 09:45:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme-tcp: fix incorrect h2cdata pdu offset accounting
Message-ID: <20210916164559.GB3908552@dhcp-10-100-145-180.wdc.com>
References: <20210914153855.16177-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210914153855.16177-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210916_094602_859657_0D6C2167 
X-CRM114-Status: GOOD (  26.05  )
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

On Tue, Sep 14, 2021 at 06:38:55PM +0300, Sagi Grimberg wrote:
> When the controller sends us multiple r2t PDUs in a single
> request we need to account for it correctly as our send/recv
> context run concurrently (i.e. we get a new r2t with r2t_offset
> before we updated our iterator and req->data_sent marker). This
> can cause wrong offsets to be sent to the controller.
> 
> To fix that, we will first know that this may happen only in
> the send sequence of the last page, hence we will take
> the r2t_offset to the h2c PDU data_offset, and in
> nvme_tcp_try_send_data loop, we make sure to increment
> the request markers also when we completed a PDU but
> we are expecting more r2t PDUs as we still did not send
> the entire data of the request.
> 
> Fixes: 825619b09ad3 ("nvme-tcp: fix possible use-after-completion")
> Reported-by: Nowak, Lukasz <Lukasz.Nowak@Dell.com>
> Tested-by: Nowak, Lukasz <Lukasz.Nowak@Dell.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> - Keith, can you ask the WD team to test this as well?
> 
>  drivers/nvme/host/tcp.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 645025620154..87b73eb94041 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -607,7 +607,7 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
>  		cpu_to_le32(data->hdr.hlen + hdgst + req->pdu_len + ddgst);
>  	data->ttag = pdu->ttag;
>  	data->command_id = nvme_cid(rq);
> -	data->data_offset = cpu_to_le32(req->data_sent);
> +	data->data_offset = pdu->r2t_offset;

Shouldn't this be "le32_to_cpu(pdu->r2t_offset)"?

>  	data->data_length = cpu_to_le32(req->pdu_len);
>  	return 0;
>  }
> @@ -939,7 +939,15 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
>  			nvme_tcp_ddgst_update(queue->snd_hash, page,
>  					offset, ret);
>  
> -		/* fully successful last write*/
> +		/*
> +		 * update the request iterator except for the last payload send
> +		 * in the request where we don't want to modify it as we may
> +		 * compete with the RX path completing the request.
> +		 */
> +		if (req->data_sent + ret < req->data_len)
> +			nvme_tcp_advance_req(req, ret);
> +
> +		/* fully successful last send in current PDU */
>  		if (last && ret == len) {
>  			if (queue->data_digest) {
>  				nvme_tcp_ddgst_final(queue->snd_hash,
> @@ -951,7 +959,6 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
>  			}
>  			return 1;
>  		}
> -		nvme_tcp_advance_req(req, ret);
>  	}
>  	return -EAGAIN;
>  }
> -- 
> 2.30.2

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
