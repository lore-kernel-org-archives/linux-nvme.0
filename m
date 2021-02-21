Return-Path: <SRS0=yxkO=HX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096E2C433DB
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Feb 2021 08:52:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494B264D99
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Feb 2021 08:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494B264D99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=y+qcpZ0hCJ8/bn5JMCOAvVT+gOZCQnDwdE22ZFy+Uoc=; b=M2k5U14TreIQppdhBWFh9HQEu
	wV4qOwaW89AyH2da9dudIQvQCrIfUgpy3bK92elDvn0dORYUvydcM1S5ipcS9AvbEOQ/SpdPZfOKQ
	sBeTHCdpMRPJQj561+/uEJSB5pAlzUId0sJnoIzWiHyhKcWUfvmJ4B++3wnZ+L2cHsFKvU3nRHsyR
	nDCjPQzzic+qDoTch2Dq4BOoYjVFMy3iE55dBFYlDWOXQy5d0qL5L8o89mSosph1O4mZoApubZiNg
	4vQ0wDz7qXZgiVSyp9TdiqAgwka+AYIIDF3XwosyuNwcro2B9yBdTrKvYvi2qOMfrHQ9fhad1YI2n
	uvptgqLwg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lDkTZ-0003Lz-JZ; Sun, 21 Feb 2021 08:52:25 +0000
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lDkTW-0003Ld-2B
 for linux-nvme@lists.infradead.org; Sun, 21 Feb 2021 08:52:23 +0000
Received: by mail-yb1-xb31.google.com with SMTP id m188so9909345yba.13
 for <linux-nvme@lists.infradead.org>; Sun, 21 Feb 2021 00:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RJ6XRSj8Hw/drU0HiY0a4+qfk/t22NlQuyruL9Qv2Pg=;
 b=d8cVhGPGGtSbjlDBGWjoq5nPiYmi5R8C+W3xFIlzz9b4F1UBRk8V5IT22a3Wb+wSB/
 Cc4dUCIHvBJpWHWFMYYVBz7uZqDIeStw0kWO1exqxtiHQno9iduSGtyDeW9pIO86Q/hF
 NOY5FHe/mYGEhaAD1FQ3tGxg5K0F9ZWOZixyyYmGub1p/nBnYhJD/4FZEUxramNxmL5n
 WgPzqKPnKno412aejBg2AFG2XVig+FY1xIY+mf2aAAB7BaQRRWWJQrZqTGZYwCG12PbS
 oUou5rEA17GTwCJhx1TX4pla+L5rA8MnRS1QrkKDmxRV4U8VaHc7fKw4VQK1IgqHJgwY
 5wzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RJ6XRSj8Hw/drU0HiY0a4+qfk/t22NlQuyruL9Qv2Pg=;
 b=JXJF75iGryB78rYLTzoNZolzBTRv8c78RlsAvVswnqx5UwsaqrJfXJCsYQsiLZurgE
 pKlP8s4b6oqPyoZoZ4o9yHTTVoDYr9o/DBPU0f200ZyWT+Znv3TkXam4OPYYyoloYIJ9
 9bB6gP6eIctinVYSmxRfsmCaoG7WwmVKzu9N3+2fPG3Fapr4U2bp0jBfAFPZ7LLlPbv4
 +jz4TcpdCvVlzQ96xJCbTSaJ4saUruonRk2tljG9M4pfaYDkB8ObeXOgeEdfP19gzJOx
 nDRtXh/QfLln2wVN6n2SQUQAszC5qHy1KKhTNQi08YJ3Y7T7+jNkdV+iSNsfiBcqq68r
 r1BQ==
X-Gm-Message-State: AOAM532wfAJcmb0Ejj65HUBFrD51l7H1GLNXTg/wdFwix4C85Zr6uVVy
 rBbAg3Io2m/RocbqV6bUnMu6nuLcCELsww3BWPE=
X-Google-Smtp-Source: ABdhPJwkQMy4evXLyTJkB9//pt/zv7UiKRUl5OGXx+PNsbEhzUVPdfxqAhNXR7ik/W0rKswgJrl6q+eFfexlAp6kW3k=
X-Received: by 2002:a25:50d8:: with SMTP id e207mr24663829ybb.56.1613897535704; 
 Sun, 21 Feb 2021 00:52:15 -0800 (PST)
MIME-Version: 1.0
References: <20210211211044.32701-1-borisp@mellanox.com>
In-Reply-To: <20210211211044.32701-1-borisp@mellanox.com>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Sun, 21 Feb 2021 10:52:04 +0200
Message-ID: <CAJ3xEMgazUM053U-nGycNPPT7bennXVcdFoPvMWRU3uZGdpXFg@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 00/21] nvme-tcp receive offloads
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210221_035222_193142_119D626E 
X-CRM114-Status: GOOD (  14.04  )
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
Cc: smalin@marvell.com, Boris Pismenny <borisp@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, linux-nvme@lists.infradead.org, axboe@fb.com,
 Eric Dumazet <edumazet@google.com>, Linux Netdev List <netdev@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, David Ahern <dsahern@gmail.com>,
 Keith Busch <kbusch@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 benishay@nvidia.com, Saeed Mahameed <saeedm@nvidia.com>,
 David Miller <davem@davemloft.net>, Or Gerlitz <ogerlitz@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 11, 2021 at 11:15 PM Boris Pismenny <borisp@mellanox.com> wrote:
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

Sagi, Christoph,

Any further comments?

Or.





> Changes since v2:
> =========================================
> * Use skb->ddp_crc for copy offload to avoid skb_condense
> * Default mellanox driver support to no (experimental feature)
> * In iov_iter use non-ddp functions for kvec and iovec
> * Remove typecasting in nvme-tcp
>
> Changes since v1:
> =========================================
> * Rework iov_iter copy skip if src==dst to be less intrusive (David Ahern)
> * Add tcp-ddp documentation (David Ahern)
> * Refactor mellanox driver patches into more patches (Saeed Mahameed)
> * Avoid pointer casting (David Ahern)
> * Rename nvme-tcp offload flags (Shai Malin)
> * Update cover-letter according to the above
>
> Changes since RFC v1:
> =========================================
> * Split mlx5 driver patches to several commits
> * Fix nvme-tcp handling of recovery flows. In particular, move queue offlaod
>   init/teardown to the start/stop functions.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
