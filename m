Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247C6C27C4F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Jun 2024 16:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IbPD88wHeIbMByJw6Ni+dWXf+0prdKlH7gqjYAmu0lk=; b=IBjHye2hX8c00yGMxiJgmska4G
	57EbKGcnwGiIS0VvKmQbo21Fhy/X7HPIWx3tuFG4xyQ+vH/W44vTccKBe2IXXMuoDIs57k2Xib5o3
	uljfVwaHki0ovRgsAu21bkjVj0nnMQkRzpFJb5NA+OYC3UESMf7+IZFx4ZNjYAvaQw8Nbioi9w7ea
	YJfXWqCl9/jHA2cpgZdCP6x0g7xUODvbsUM4EuXZSpqeAXwmbf9WNTWknpzM5bkYo38nemCK/JGDg
	nfJF5lZBNQ0glzbgC4lPqwTU3NQy+ZGBgI0inQJ9ExlFBp4UnGrmehpI7KYmEjkHOpw8CpAv/7Tx7
	fQSuRB1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJbN4-0000000Fklc-1GdM;
	Tue, 18 Jun 2024 16:07:46 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJbMy-0000000FkhJ-0cNP
	for linux-nvme@lists.infradead.org;
	Tue, 18 Jun 2024 16:07:44 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4W3WqX0FBqzlgMVS;
	Tue, 18 Jun 2024 16:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1718726852; x=1721318853; bh=IbPD88wHeIbMByJw6Ni+dWXf
	+0prdKlH7gqjYAmu0lk=; b=tG4lcb0F1Wu1/8hhoO2kVSihdMXuai9iJp4BMfgs
	BtGa/2oQsgolAErZu/Q0KEYh52oKWNi22iJypwgI6e2MYxn4l05JxYkTeNNPYuwl
	r4lfq3C/BJ0Htwsq3261nwwBwWT84fWxJy3u1x9bHLeCybfeZlD/LVjdl9+ty3m7
	uzzDcxac2+Yofwa9vhVx67wxwq/vt4B1L+CKMC/wUMPXRcL6UyAzSXxwn7XmKtxv
	OoZcDb8mWUBziAz1NS2MuqcagB2ow2AkBU+9Fi+6jtRsq/36W3xM6/emvcKygqxO
	6kO94ySyAfxJQl9U91qOBC3rktTs4x9eSBusWvmCws/DHQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id zRDhB_nSnvNl; Tue, 18 Jun 2024 16:07:32 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4W3WqP3flczlgMVR;
	Tue, 18 Jun 2024 16:07:29 +0000 (UTC)
Message-ID: <244b708e-be75-435a-8b27-c48e976d4cdd@acm.org>
Date: Tue, 18 Jun 2024 09:07:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] IB/core: add support for draining Shared receive
 queues
To: Max Gurtovoy <mgurtovoy@nvidia.com>, leonro@nvidia.com, jgg@nvidia.com,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 chuck.lever@oracle.com
Cc: oren@nvidia.com, israelr@nvidia.com, maorg@nvidia.com,
 yishaih@nvidia.com, hch@lst.de, shiraz.saleem@intel.com, edumazet@google.com
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
 <20240618001034.22681-2-mgurtovoy@nvidia.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240618001034.22681-2-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240618_090740_276210_0C87828F 
X-CRM114-Status: UNSURE (   7.99  )
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

On 6/17/24 5:10 PM, Max Gurtovoy wrote:
> +	if (wait_for_completion_timeout(&qp->srq_completion, 10 * HZ) > 0) {
> +		while (polled != cq->cqe) {
> +			n = ib_process_cq_direct(cq, cq->cqe - polled);
> +			if (!n)
> +				return;
> +			polled += n;
> +		}
> +	}

Why a hardcoded timeout (10 * HZ) instead of waiting forever?

Thanks,

Bart.


