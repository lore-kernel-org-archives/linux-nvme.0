Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4DBC63793
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 14:24:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 563DA6128C
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 14:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563DA6128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SmN389p9Ucq1mmFobCNtpPu5k4XwdY+40HWwATcrstU=; b=kMNjBcmQf8lpJh
	Q105uJCZGkhRJolxB7gMlMHauFTEsfTUpRUWf5UEB3tsoENG6WiZBXdDl+Qd7q/WDfd6IahUv0fij
	22OXlybi3r+pE+6SpzKRxMmqVykpRVFevk0hw1QZG09NJTWBmCF62btdqAr7fjmY4dckhdCMNyVXA
	F934HipHZ1dX6WDDF3t+k1/HpjqdQvmhpa2oxSkqmBKum7DORbgf+5kyrngUb6ycmW3Jo1S+9h709
	fpoapEXuLdaJ7nW22mcMQeqwp+Ai0NI6OwQMK527l3KtnDyvtqNVPewS3WCKq16NpLR6gcTbm9UnF
	sd9BiXlKPSahuyZaFJZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6ZcO-001sRX-1G; Thu, 22 Jul 2021 14:24:08 +0000
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6ZcL-001sQt-Aa
 for linux-nvme@lists.infradead.org; Thu, 22 Jul 2021 14:24:06 +0000
Received: by mail-yb1-xb33.google.com with SMTP id r135so5571663ybc.0
 for <linux-nvme@lists.infradead.org>; Thu, 22 Jul 2021 07:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sZrDdzs8PEEUYBhRoHxBInlAmMts2fSYYQKODBWYcMQ=;
 b=ZU5nnf20kYGsWviyI76tYstfqIqub/it6RsYY8lnp/E/cCz2ZzgjgEs/I/gzyBsm4E
 WBiwsdRWrMoL+7OzBQ8whsq9LxyfCJz5t2k0pj/YCmQ2D4+wY/3hFJ9+1PUQQeMzPjFS
 WlFulK9YpokK62kea1Iz6nmj5MXHdxKJbHgzKvWtmyHHeZRhykziPyPuKf1BuUpYDqAA
 WfZgmoe3KnTfLdPAoNE7bdcoCirjMg2sb2S10b4eVOWRCILMKIdYSDgnVCU+rjlbMa83
 HggAEe6D+pf0KtYmStvha7JqN7sTu8TGvavfOiv5NX5aqwa+Un7l/DCOkWDzu51z07/1
 ZP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sZrDdzs8PEEUYBhRoHxBInlAmMts2fSYYQKODBWYcMQ=;
 b=mhBn5Co4zI/ptiKXi5QdCVJMLRdNIoHLv4G1WodFUC6o41MRsF0NBXaBatvjyNgEJj
 Kt6hrQyzkQ2yozCPu14Pu5Yto7FviO0X/gAu+sHWzFdiIrnOBKivAylKuV+VH3Z/P/MA
 3L34RHVZcqCj7Hyf3vForxt5xhnHclQfGbiMNoqCR3GbFSFJk74aUhPfEsjoQn8h7dIG
 K0jL2M6ixo3E3vMiuQFt4Ba0Is72pzthxyLMBegP44t/UrlOyjoPmXOMHeGUpKQLf8tj
 uhnNCkJz/+zKneIplY5FS3WSFuRKWdyoTMqmapZgBbQ/92c9fZLqgYEr9l2+ItYPLzy6
 fP0Q==
X-Gm-Message-State: AOAM532V7otG1/PaZPsGFuXSH1b1gQipTvvjrO/FhkSdhc5b+1Xsr9/v
 9Xh65Lue5h0Sj7+/xnsZRLo1TER7p260XQEAxDpq8g==
X-Google-Smtp-Source: ABdhPJw3/tZuxDkr6ZjXPwr7PbS/ybmHtdyHUfRL0NL/tqHjWRehBhWRwwCsQl0Qp8VCbvjW7Yy1V2aITCwLZ4DD5o8=
X-Received: by 2002:a25:bec2:: with SMTP id k2mr54243090ybm.234.1626963843442; 
 Thu, 22 Jul 2021 07:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210722110325.371-1-borisp@nvidia.com>
 <20210722110325.371-25-borisp@nvidia.com>
In-Reply-To: <20210722110325.371-25-borisp@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Jul 2021 16:23:52 +0200
Message-ID: <CANn89i+xCzwGEbWCu6A2neqFt_SaDK9Y3GVPCTz0Nv0+OrnQiw@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 24/36] net: Add MSG_DDP_CRC flag
To: Boris Pismenny <borisp@nvidia.com>
Cc: David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 David Miller <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, 
 axboe@fb.com, kbusch@kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
 smalin@marvell.com, boris.pismenny@gmail.com, linux-nvme@lists.infradead.org, 
 netdev <netdev@vger.kernel.org>, benishay@nvidia.com, ogerlitz@nvidia.com, 
 yorayz@nvidia.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_072405_435987_D5518E70 
X-CRM114-Status: GOOD (  11.57  )
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

On Thu, Jul 22, 2021 at 1:06 PM Boris Pismenny <borisp@nvidia.com> wrote:
>
> From: Yoray Zack <yorayz@nvidia.com>
>
> if the msg sent with this flag, turn up skb->ddp_crc bit.
>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>

Ok, but why ?

How would you document in linux manpages the purpose of this flag ?

How can applications be sure the kernel they run on is actually
supporting this flag ?
Maybe it is a hint only ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
