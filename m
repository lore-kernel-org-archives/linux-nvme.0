Return-Path: <SRS0=ljDk=B2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DD8C433E1
	for <linux-nvme@archiver.kernel.org>; Sun, 16 Aug 2020 17:55:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD3820578
	for <linux-nvme@archiver.kernel.org>; Sun, 16 Aug 2020 17:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HKCP7POA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I61qtUMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD3820578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jEVDpJ5omjBneJOsR/wIdaUHvTP5k2T5P9q9QwkWNGU=; b=HKCP7POA+9LNeG92QH9DOPX++
	PlIW1aRjEleUi9TqP5nReAJWPv6BbGpTmMyGGYWABSLbBbfdH9fxtqfwLYTrNZcqPDwnMZKCU0Vf/
	vBRbgFzj2UCy1pOJy3c8sQzmowXpy3cxgBsBj+WgcjTX1Qq1CpAXwamnSgK5ZAdOJqjYBTMRSIXCu
	7dreb2diLalK65vVr/FzRrf/NWDLtRzx39DeRT9xEo61F+FTgdtDRizK1amMYcFpD4qZ2+IwIsrab
	Jr0g59Gvj5ykB9AI74vRxfDuUrTidvyxe+cMW+5FokhiYNkfOALDQ4ztDrc6NYanoMFRtDKwoTqDO
	eny9hvNTw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7MsU-0004OB-Ts; Sun, 16 Aug 2020 17:55:30 +0000
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7MsR-0004N6-SB
 for linux-nvme@lists.infradead.org; Sun, 16 Aug 2020 17:55:28 +0000
Received: by mail-il1-x142.google.com with SMTP id 77so12587405ilc.5
 for <linux-nvme@lists.infradead.org>; Sun, 16 Aug 2020 10:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AiCG/uAK0dtENCt/PueZkz6eV6g5vA/PPqkue6QuGWc=;
 b=I61qtUMSC2HknCJQ8BnSlGPAk0WckimWiJAmc4vXKKQzxH9BEIsAhWEsTKYCph4lr5
 zKLQwUFtah4H8ruIP6TbMazrqzSXXglI+NvJiH9AoTcjE1d70tjVN0mGNRIr2XuelmIe
 jjOwjREGzAcDQ2h9u3mKWRdeN72cO2EtrYUxYrYsHhJ5RDm1NYT6NfYDu4KV7rNcWduL
 zHKS0XfdXfyLfzrOjHDULxRLhsz8I0MhwBhUgzby41g+6trfGaRKXI+MYpn5NkF7XgvC
 ilpb+Ivei2c6W4F0grs6mW2aGUlHzxXJ4keQdL2hIxk7xT+DsihZL0e0IIDS1nBz0X6+
 Q2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AiCG/uAK0dtENCt/PueZkz6eV6g5vA/PPqkue6QuGWc=;
 b=RIyNFcaKSBtjL6b2qO6vrcucQOizSCmxFmGMgGBFPXm/7CEGTgLpAZPwH4sK3EZKoo
 ego425NIzE6I8eKpREDEQ1QCXova9xcp8Cnaa8iF+DzOZkXO1n1yrq+1Vw+GZENZQtIi
 CNTJTJf/U4b8jlGdrPns3fCgSidINkixrUjS/gu3LMShLNEmfHuRI3CerB0Z2bHFUKsl
 qjxP+/rjpOLZkZepRPXeSMYmsWiJ871hhYnyqM9ocubbbazYpbt4GFyTgRTO7BU6PmC6
 ASxfyVwk51Artz2/J2C7cwPibYrve81njHrKe7OFDTHGYt86/pQ4AATrS2SwEEOqmWCx
 A9xA==
X-Gm-Message-State: AOAM531qubNIY1kKAbPmU+5DZBqu9azuduW0+kn5vxuaIKe+FQRdguxT
 8IQlA8bmlHmEJ8jZq4WNhmCZBWjHXaQ1sytHkH4=
X-Google-Smtp-Source: ABdhPJxSfbQX1hDpkJkRit7p7VGjkXenq2dg0JNjY9g09NZghabgSAKJkr9JDtBOuaL+IgFlYgX60tqH7vqMFJoSaYI=
X-Received: by 2002:a92:d786:: with SMTP id d6mr10604101iln.144.1597600520704; 
 Sun, 16 Aug 2020 10:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200816071518.6964-1-colyli@suse.de>
In-Reply-To: <20200816071518.6964-1-colyli@suse.de>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sun, 16 Aug 2020 10:55:09 -0700
Message-ID: <CAM_iQpUFtZdrhfUbuYYODNeSVqPOqx8mio6Znp6v3Q5iDZeyqg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] net: introduce helper sendpage_ok() in
 include/linux/net.h
To: Coly Li <colyli@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200816_135528_010005_FAC986A2 
X-CRM114-Status: GOOD (  17.11  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>,
 Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jan Kara <jack@suse.com>, Philipp Reisner <philipp.reisner@linbit.com>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Aug 16, 2020 at 1:36 AM Coly Li <colyli@suse.de> wrote:
>
> The original problem was from nvme-over-tcp code, who mistakenly uses
> kernel_sendpage() to send pages allocated by __get_free_pages() without
> __GFP_COMP flag. Such pages don't have refcount (page_count is 0) on
> tail pages, sending them by kernel_sendpage() may trigger a kernel panic
> from a corrupted kernel heap, because these pages are incorrectly freed
> in network stack as page_count 0 pages.
>
> This patch introduces a helper sendpage_ok(), it returns true if the
> checking page,
> - is not slab page: PageSlab(page) is false.
> - has page refcount: page_count(page) is not zero
>
> All drivers who want to send page to remote end by kernel_sendpage()
> may use this helper to check whether the page is OK. If the helper does
> not return true, the driver should try other non sendpage method (e.g.
> sock_no_sendpage()) to handle the page.

Can we leave this helper to mm subsystem?

I know it is for sendpage, but its implementation is all about some
mm details and its two callers do not belong to net subsystem either.

Think this in another way: who would fix it if it is buggy? I bet mm people
should. ;)

Thanks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
