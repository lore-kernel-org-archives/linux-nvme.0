Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A742C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 21:32:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBC1964E4A
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 21:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC1964E4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3yDnZS3WITBs3OfW/jLSdMDd2uihhRJ3BNtjPdDKVQw=; b=vZWMXpF/hWx8TwGIvrXAyezxr
	D9d+ODB8FRlu0tTfhqV7Np4vrZQ5Jwgxo1em2EpP6CTqDwDGPwor+pgUQdo8IbKEzzRP2vcwnPoaW
	jrpTR8Ui5yG3Eat8hEa5FYW5Er1yGuff1kjH0g5oeTBVy75DkeGWFz7gQryHDtIocyJZtmvu2tajF
	0OmKnlWE05RAcWYRhOkbo4QlBoxxJq4l+Ru647vFow6c/EOQM8tJiWe/TVH21JJIaTLC4MPpHQNuL
	mbYfolF9UVe3UX+PvqMPKdc0uIeCXNAZ4GRvf6NkrgRpNmEdgZwivdZ0HglDCjyVZMsge5pqMMu9d
	hLCfiUiGw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAJZO-000101-9k; Thu, 11 Feb 2021 21:32:14 +0000
Received: from [2601:1c0:6280:3f0::cf3b]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAJZJ-0000z0-Sb; Thu, 11 Feb 2021 21:32:10 +0000
Subject: Re: [PATCH v4 net-next 00/21] nvme-tcp receive offloads
To: Boris Pismenny <borisp@mellanox.com>, dsahern@gmail.com, kuba@kernel.org, 
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, sagi@grimberg.me,
 axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk,
 edumazet@google.com, smalin@marvell.com
References: <20210211211044.32701-1-borisp@mellanox.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <76c93e83-be63-f7ed-a096-1408e9525331@infradead.org>
Date: Thu, 11 Feb 2021 13:32:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210211211044.32701-1-borisp@mellanox.com>
Content-Language: en-US
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: yorayz@nvidia.com, boris.pismenny@gmail.com, benishay@nvidia.com,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/11/21 1:10 PM, Boris Pismenny wrote:
> Changes since v3:
> =========================================
> * Use DDP_TCP ifdefs in iov_iter and skb iterators to minimize impact
> when compiled out (Christoph)
> * Simplify netdev references and reduce the use of
> get_netdev_for_sock (Sagi)
> * Avoid "static" in it's own line, move it one line down (Christoph)
> * Pass (queue, skb, *offset) and retrieve the pdu_seq in
> nvme_tcp_resync_response (Sagi)
> * Add missing assignment of offloading_netdev to null in offload_limits
> error case (Sagi)
> * Set req->offloaded = false once -- the lifetime rules are:
> set to false on cmd_setup / set to true when ddp setup succeeds (Sagi)
> * Replace pr_info_ratelimited with dev_info_ratelimited (Sagi)
> * Add nvme_tcp_complete_request and invoke it from two similar call
> sites (Sagi)
> * Introduce nvme_tcp_req_map_sg earlier in the series (Sagi)
> * Add nvme_tcp_consume_skb and put into it a hunk from
> nvme_tcp_recv_data to handle copy with and without offload

Hi,
Did vger.kernel.org eat patch 21/21?

and does that patch contain the Documentation updates?

thanks.
-- 
~Randy


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
