Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABA3C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 09:29:46 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1CB76113C
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 09:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CB76113C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BYMKJwW0+baLf6xI5O5bBPasFQ9Bppw6LwkKT624TvY=; b=OJLK4p/bHOcUwqXak6UKg5HDv
	Zso9N7H12M/fCf60bXy/eZua7C9bjpmKH38ixZq17IJX05asYLowrM+cUyTO5foOkuXkKrR6kRjcK
	Hh8QC7SGyPjUDlQ2gbIAJIpvi7X9tBcik3rzrX1RKTwWSlj3gkLJywVeXmV0MefPOyQsSfYuWjwVs
	Zme/x1q0JRuxY3eNvjCE8+Pgu8SPTVI/MgMWLPrL0e6UAXIpMium0Xzp2m/xP63uaRZgSUfdeiq9+
	0cjzVQ7B+iXov25/dP0tF6OGpEgyV93iE8xHFl1OhfTm4lCD0YTQCglioWclIywJWqWzQUTmDIVNg
	2dvi0jMYQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYQDd-009YP9-Io; Mon, 19 Apr 2021 09:29:25 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYQDa-009YOb-Se
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 09:29:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=2aOsr0PrOwnfD3TDOKZ6BC+krPtm53sXeyFnBIAmB5o=; b=dlxuJSx74ojN6u2Cspw4sbyZBO
 9m5osR+tXN1F9D2uMZozBeEkZ4MMcNCOPxCKoUyDXwaLoqiAm7VCtGRfluX5kw/ZtBzbxvpjFJBIV
 /Zof+qyjZPyk3+YUS+VqCwOMpgQNSaWNiBGx69mR7gC73d7qn1DGovpFArIHQp4g+ySK6sHCe/kO2
 c0kem+FjGoDxzpGghmMe6FzIOZqhSZ/5ws/Gr5solihRG7qkAZF3RMNY/NrOey0EljxSkQUMLfdrT
 65Nj+vMd0kqZDmygxvpE5HMY3SAXDAKkvrAq30rnObRAEEaMWzepVl2mvkN7IM1/snzMdSTlt1kI3
 odEbSJGw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lYQD9-00DWee-NI; Mon, 19 Apr 2021 09:29:02 +0000
Date: Mon, 19 Apr 2021 10:28:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: dsterba@suse.cz, Damien Le Moal <damien.lemoal@wdc.com>,
 dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH 3/4] btrfs: zoned: fail mount if the device does not
 support zone append
Message-ID: <20210419092855.GA3223318@infradead.org>
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
 <20210416030528.757513-4-damien.lemoal@wdc.com>
 <20210416161720.GA7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210416161720.GA7604@twin.jikos.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

On Fri, Apr 16, 2021 at 06:17:21PM +0200, David Sterba wrote:
> On Fri, Apr 16, 2021 at 12:05:27PM +0900, Damien Le Moal wrote:
> > From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > 
> > For zoned btrfs, zone append is mandatory to write to a sequential write
> > only zone, otherwise parallel writes to the same zone could result in
> > unaligned write errors.
> > 
> > If a zoned block device does not support zone append (e.g. a dm-crypt
> > zoned device using a non-NULL IV cypher), fail to mount.
> > 
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> 
> Added to misc-next, thanks. I'll queue it for 5.13, it's not an urgent
> fix for 5.12 release but i'll tag it as stable so it'll apear in 5.12.x
> later.

Please don't.  Zone append is a strict requirement for zoned devices,
no need to add cargo cult code like this everywhere.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
