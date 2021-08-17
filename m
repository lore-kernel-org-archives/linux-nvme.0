Return-Path: <SRS0=LLxJ=NI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E45AC4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 13:09:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC90860F22
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 13:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DC90860F22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d7ftv5Lj4f/oIWleNS+vxUHDPPEpzE4vb4Gyh1clZss=; b=K4JIv2aF5Pi4tR
	84CJf6iEOyp0G4IdkZozmZe2UebOMMmcEUV2u4EFYLC5/eEhWlPN8NzcuIgSkLeSd2bQavHtr30Gh
	tyaH6YI5Oi7nqbHE08FHPl5W4PLg8zld5tvFejGr0d8CgWfsLM+50gUMbMhSxbCZhPbQ2mH9cECRP
	S1k9BkRuThb9roHeWijn3NXngD3nXeMc/xIzr1wxf2F5jD7LsVvhJtyx6OXR63g4OZsHKDeG+zEwj
	TlsHwatr2/5BhznCRiAiEonexlE+o37JVb3FiuuUPIc7w6AtwvJqcN7J27v4vrut33PgqzMBaFJr/
	DXsYa/3kx3QvnVnYjrpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mFyq5-002XL3-12; Tue, 17 Aug 2021 13:09:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFypj-002XIR-JX
 for linux-nvme@lists.infradead.org; Tue, 17 Aug 2021 13:08:51 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C925E6054F;
 Tue, 17 Aug 2021 13:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1629205726;
 bh=J1u5EkWGe1vhFroD1IkbImRAmY2cS/NhgJTldLkgdQ0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G4sEWuIHg7dPIAdb+CNrXrzTwB17LGwdPnAKkHBjeFaDSeu0zgdgJ3WtuSvwm7Ke5
 qxE2jqR/gnytpY4Px0tGv4k+kTSRxfZiGjlylGou8T6pgSEfNOHaYfOBoA5tol2NwA
 1w+n/Xyy20t5QAhTAy0o9AYp+44fdacT9SJtE6lI=
Date: Tue, 17 Aug 2021 15:08:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: SelvaKumar S <selvakuma.s1@samsung.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
 kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
 asml.silence@gmail.com, johannes.thumshirn@wdc.com, hch@lst.de,
 willy@infradead.org, kch@kernel.org, martin.petersen@oracle.com,
 mpatocka@redhat.com, bvanassche@acm.org, djwong@kernel.org,
 snitzer@redhat.com, agk@redhat.com, selvajove@gmail.com,
 joshiiitr@gmail.com, nj.shetty@samsung.com, nitheshshetty@gmail.com,
 joshi.k@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH 2/7] block: Introduce queue limits for copy-offload support
Message-ID: <YRu02+RgnZekKSqi@kroah.com>
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
 <CGME20210817101753epcas5p4f4257f8edda27e184ecbb273b700ccbc@epcas5p4.samsung.com>
 <20210817101423.12367-3-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210817101423.12367-3-selvakuma.s1@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210817_060847_728872_B1D7302A 
X-CRM114-Status: UNSURE (   6.76  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 17, 2021 at 03:44:18PM +0530, SelvaKumar S wrote:
> From: Nitesh Shetty <nj.shetty@samsung.com>
> 
> Add device limits as sysfs entries,
>         - copy_offload (READ_WRITE)
>         - max_copy_sectors (READ_ONLY)
>         - max_copy_ranges_sectors (READ_ONLY)
>         - max_copy_nr_ranges (READ_ONLY)

You forgot to add Documentation/ABI/ entries for your new sysfs files,
so we can't properly review them :(

thanks,

greg k-h

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
