Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D052C369BD
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Apr 2025 01:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WP1oD8ojhW04PX9migqK5siQPp/YiNU70XlfdH963OI=; b=D0SQOG+2QzTIjibkTifrAKVAHa
	AA0UndqdcV/jMlmTGN8q+b0R85YPpemlGBmRVK7ul4HlkSojQZ6a9EQ54oH2hX3Kt/bl/qeE9B+7k
	GsiYBZ0F4q11svUTOkVnPWv1KEA9EzYrut/d1ISBY2vmWB4BBNV4bRtZrUyWu55XVMskmAjeHobqc
	Nf4xqovA2xm8XtTsQMu2YMpllciSgE8V9z2I9tnrBQ3cUkxoaCcakvz84JYetyIKAYluYKy9squqs
	71Cvngrwq+nQX/jWrabkF85Ol6SePesAL11ne8RXcvha/FH/3HZdHkO65WQNCyMyqw8HmRMvMdvQ5
	0qP13WSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5Dww-0000000BQCC-2iHg;
	Thu, 17 Apr 2025 01:21:54 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5D8S-0000000BI6a-0Id2
	for linux-nvme@lists.infradead.org;
	Thu, 17 Apr 2025 00:29:45 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-af5085f7861so132873a12.3
        for <linux-nvme@lists.infradead.org>; Wed, 16 Apr 2025 17:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744849783; x=1745454583; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WP1oD8ojhW04PX9migqK5siQPp/YiNU70XlfdH963OI=;
        b=EwynnQP42+6C+1fX5j56EBqksfvHxwryWvNu7KrtPXpvlf9KhGmx/uWKSsrNilPNss
         Nir17u4ySj3tbt5Q7Omk0lran1/0X0KMJVYnCuGbC4rAllXsR4aEVK6Vmh/tNAothxg/
         MsTm6QuJILikD3ESPGtbFJ69AFb3DR+rCCADzOrsRoyp8rkaaWjBYu3DcADTdGwCif2u
         4JMep6L5cZYnfPwb8/eUD51m4VCkZeJK7SsKLhAJrAONgFMVsX8+GA2/VdMQmtDLJyt8
         OuKm9WvMaPyzkWuYnZzMCQe2R5x7ajKPLHNQ4e8x5f2ZlobD+SfgnRtY/T6olwGrQXxT
         xrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744849783; x=1745454583;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WP1oD8ojhW04PX9migqK5siQPp/YiNU70XlfdH963OI=;
        b=lRG+g3efu5RvRTXZDMAirvYZLtqCVAuO5aBtwT9m+OpZgFYarEyi6dJ4NZXx86RbaE
         1U+ZMWjKOKYysr83YWLBnbI4I6Rbg2PWcd1geiz1FURm0/lCE1jhy5sFc0hRnk18DUOT
         /9OX7Wv+aXc0ydOf5+VwymIv82byVf/H6/8adGyKsaHqQ+gu0i8qqybTaG0OFHWn0jcw
         tLYUh+/Sk9EcrhjCs6Esk/c2jESb1iao5xzSK19elSe+XVYFwbr3JD99ninHeJ5mN37Q
         JcMaOvg1dPDFfLavAuhAF1xm/6maB1W6JuqCrovX+qsT5NTmCbR2QQGL09Ew/bXhOVBM
         TvQg==
X-Forwarded-Encrypted: i=1; AJvYcCV49HNFTC9t/KpczXDEMllxTFg8u7O1k5H9kTT5se54w767k9fimb5LQ/n6WIFitLahFasaV9TPTtla@lists.infradead.org
X-Gm-Message-State: AOJu0YzDTPYZ0iQscgN/SeZ6gVbp+ynVzNCKDkEhpV80cT9X7bURdeOl
	iGdlfSjzQ75BcuZmvtz2L4xlTaqI4rZO5dvONuljcVeQK8TxGuzPAFZn7SqjXrp2EqMAp3WJW06
	QOEI=
X-Gm-Gg: ASbGncvqPQ5Pip83vJslpROzu4cHKYGq+tWiuqoc9YfiG0VJlOBx3AHHgUUiYX/kwIO
	fMtUC3ID+uInABgwEcqcgx5LgfqUzJNXWQmttTi+qQ+g1zac5c9vKtH1X7+8ItVsteduQuqwZFV
	M7qcQo5ElCwTyHaTi84j0ZWLZcAtE4ejI0rwXkMAenA//CC7PiF0tO2LpTGSzNNoRkw1xOS9Ipf
	CZL1U2N8ieuGw5qkpU9w5muxMZ3GOP7ZAIJFaFRrPUWtI2Ee3MmHUV5mtVFPdlP9kJ5v2UgAcAn
	v5SOR5It5dS8jBX55h4z/MDu3hw1UEFuKZXaBlJtU6Bs9GTnT9iL3MR09EMwK/RCp58Xtsyc4g=
	=
X-Google-Smtp-Source: AGHT+IGODSmKtgQTaCQWBZvcjwnv3GsNfODWGdLR/SxS58ZY9sJsKkJKcYbaDcy5Z28dWArcAMi1lg==
X-Received: by 2002:a17:90b:518b:b0:301:1bce:c252 with SMTP id 98e67ed59e1d1-30864168021mr6126979a91.27.1744849782637;
        Wed, 16 Apr 2025 17:29:42 -0700 (PDT)
Received: from xldev1604-tmpl.dev.purestorage.com ([208.88.159.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308611d6107sm2311116a91.1.2025.04.16.17.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 17:29:42 -0700 (PDT)
Date: Wed, 16 Apr 2025 18:29:36 -0600
From: Michael Liang <mliang@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: wait socket wmem to drain in queue stop
Message-ID: <20250417002936.7ezg2dwm44l7xblm@xldev1604-tmpl.dev.purestorage.com>
References: <20250405054848.3773471-1-mliang@purestorage.com>
 <2d9257c7-de3e-42ea-a947-25e394146f57@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d9257c7-de3e-42ea-a947-25e394146f57@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250416_172944_153598_29A32F6A 
X-CRM114-Status: GOOD (  26.49  )
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

On Mon, Apr 14, 2025 at 01:25:05AM +0300, Sagi Grimberg wrote:
> 
> 
> On 05/04/2025 8:48, Michael Liang wrote:
> > This patch addresses a data corruption issue observed in nvme-tcp during
> > testing.
> > 
> > Issue description:
> > In an NVMe native multipath setup, when an I/O timeout occurs, all inflight
> > I/Os are canceled almost immediately after the kernel socket is shut down.
> > These canceled I/Os are reported as host path errors, triggering a failover
> > that succeeds on a different path.
> > 
> > However, at this point, the original I/O may still be outstanding in the
> > host's network transmission path (e.g., the NIC’s TX queue). From the
> > user-space app's perspective, the buffer associated with the I/O is considered
> > completed since they're acked on the different path and may be reused for new
> > I/O requests.
> > 
> > Because nvme-tcp enables zero-copy by default in the transmission path,
> > this can lead to corrupted data being sent to the original target, ultimately
> > causing data corruption.
> 
> This is unexpected.
> 
> 1. before retrying the command, the host shuts down the socket.
> 2. the host sets sk_lingerime to 0, which means that
> as soon as the socket is shutdown - the packet should not be able to
> transmit again
> on the socket, zero-copy or not. Perhaps there is something not handled
> correctly
> with linger=0? perhaps you should try with linger=<some-timeout> ?
I did notice that the linger time is explicitly set to 0 in nvme-tcp, but it
doesn't behave as expected in this case for two main reasons:
1. We're invoking socket shutdown, not socket close. During shutdown, tcp_shutdown()
in net/ipv4/tcp.c is called. This changes the socket state and may send a FIN
if needed, however it doesn't consider the linger setting at all;
2. Further more while tcp_close() does check the linger time, we experimented with
using socket close instead of shutdown, yet the same data corruption issue persisted.

The root cause is that once data is handed off to the lower-level device driver for
transmission, neither socket shutdown nor close can cancel it. With further tracing,
I realized that the socket could be freed a while after close when the outstanding
TX skb is released by the NIC. And sk_wmem_alloc is the one used to track the outstanding
data sent to low-level driver, so it's necessary to wait until it turns to 0 in queue
stop.

