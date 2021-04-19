Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56533C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 06:46:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DFD361104
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 06:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFD361104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=t0qjDT27eFjCfvYGQiAPdeKkVvbf8iYtQF4lWmNy0vE=; b=HzurU74q2hOvT8niEhOcrg6iZ
	2AtQhOwjcuwiRMi8E+zOY0y12jS0qOQHnyN1ri1E80e8NCLc1F2+kEF8Ll39L1TUJHGf4A7STfZ7w
	AwFEaBFQgKR07cpC7PvhKJgeiWQiI7XsTh1OGNuehX1ePzRywOwmnCQ/w8qUApfeZzQiK6PuAU8rY
	gX04HsQRvd0g/75vzDIs6YwJBh+nesBomBQzLtclsVESuPHBL5YQM9McJA4RT4et/k3XTw4CB2caZ
	3wnbdOso3mcuYfF1cESWVQpsp70EEN7NwLW08E4uZQcZKAofEPRTCavNv88cyH8nJtqSgf7SsMoiR
	t6HEpa8dg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYNf9-009Fxt-FC; Mon, 19 Apr 2021 06:45:39 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYNf7-009Fxd-88
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 06:45:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=017vf1NZ2p/pcaTQ0C07hqpG9djQcqMno+rozpMO9wg=; b=ldIufCbez1GNabSqpTOsw1uoF3
 0awUm1q6KH9PD9CiIQfy/yRN5OZ60drKgsA7RDLvt9cS5uFHT/9VyWMp3VOl2y+1SRf/aHlvAv56X
 uNKJ1FLdrdfSE/zf0Oub/5N8q/oEEinj0ygZC+dc5lCAHftD/T7OXB3SJI8GCBtYBmzCDZcnBzHdK
 BwSk0l35XGT5NF1vaUdE2uW1PR+1gau9b8I2HsHZmZ/O2Xx7Z8e1dc1tDtFr5bpZD3lj8zUPEkN/Z
 3MarmOMn5TfocWWsGshjkWF9KvVyU/tcUjleCdGzRbCPDCiaGrvN9eWvCYMWtec82lNGom+xIrVoU
 FWeBLqWA==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYNf2-00B58b-5u
 for linux-nvme@lists.infradead.org; Mon, 19 Apr 2021 06:45:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8535E6736F; Mon, 19 Apr 2021 08:45:29 +0200 (CEST)
Date: Mon, 19 Apr 2021 08:45:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-fsdevel@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2 3/3] zonefs: fix synchronous write to sequential
 zone files
Message-ID: <20210419064529.GA19041@lst.de>
References: <20210417023323.852530-1-damien.lemoal@wdc.com>
 <20210417023323.852530-4-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210417023323.852530-4-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210418_234532_387609_F1C5CE0E 
X-CRM114-Status: GOOD (  11.69  )
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

On Sat, Apr 17, 2021 at 11:33:23AM +0900, Damien Le Moal wrote:
> Synchronous writes to sequential zone files cannot use zone append
> operations if the underlying zoned device queue limit
> max_zone_append_sectors is 0, indicating that the device does not
> support this operation. In this case, fall back to using regular write
> operations.

Zone append is a mandatory feature of the zoned device API.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
