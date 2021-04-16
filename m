Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B01C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 16:20:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB5360C3E
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 16:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB5360C3E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6vTliMXhnx2wUJ8ivuRs07hTN417V0pHcX3JbayF+Qw=; b=IkL0sYj+nrUm6f2XI/h8bRK5Y
	VQP4cMzFYyHLgZmnkLWo+zwW5GJsAX2FEfYUfpfxBLqOSKXP5iiNXwsnGsFdDSt44QfDeM96GWUjp
	IWj9BYKc1/6BN31cWf/eSOo2fESuN4CJPMw6F8Rqncp9YbCTaqExvcH988SdDqno+d3nIhOwytm+V
	5MeOKIWOHO7EgIv5XasmD9LqG5tfYJ/g/jcU0CTqVoAVJ6d/XzteL7KAy1ffXxjLRQUgPJvrjoJsa
	w0W8bn9JB1+GhQGYJtI4TQrKYeq6cAYbI7snAWNfJk5YczcyQFWFK9pcXvEI2nkpwq56MTrnTWAqW
	zqJ7meXaA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXRC7-002kuM-6v; Fri, 16 Apr 2021 16:19:47 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXRC4-002kuA-F1
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 16:19:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ILM5/Rm0Tov0goZU9+itl/kOwwU+WVZAtt7K+xNo0Ls=; b=yO2/XHgYzSOWNbCslsAoLmXs9D
 h+bsa7DQDeX7B5Chn9tl39l24HtP5qZIGMFgEfWl7/gUsDqmagiCxv8Zafd54IPhozrkOhEF6Qi1u
 JFkuMhRex3R5tFsnK/7pDIYWZbPLgOr+defbJNWB0b2D327S0sb2lFb19+dU1NA3TaVVXKxr+GVGi
 Gn9/PVUoPJEcHdTUoDrGj513ZMTzZ4+vnd4NROIy7RIiylaM6Km/rcXs54MC+TzvwYIwQ0mLp/rz5
 m8Gi0UE+7OCzc9mOz2N5xZ5q5cnDBr054ImxJ7lumvfVq6kpblAaP8EOrEbxz7cpXqPBO+3hcK5Ls
 ebvbXrAQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXRC1-009Y4z-Qz
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 16:19:43 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1C135B1E8;
 Fri, 16 Apr 2021 16:19:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
 id 22C74DA790; Fri, 16 Apr 2021 18:17:21 +0200 (CEST)
Date: Fri, 16 Apr 2021 18:17:21 +0200
From: David Sterba <dsterba@suse.cz>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
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
Message-ID: <20210416161720.GA7604@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz, Damien Le Moal <damien.lemoal@wdc.com>,
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
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
 <20210416030528.757513-4-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210416030528.757513-4-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_091942_042195_F825C215 
X-CRM114-Status: GOOD (  10.65  )
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
Reply-To: dsterba@suse.cz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Apr 16, 2021 at 12:05:27PM +0900, Damien Le Moal wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> For zoned btrfs, zone append is mandatory to write to a sequential write
> only zone, otherwise parallel writes to the same zone could result in
> unaligned write errors.
> 
> If a zoned block device does not support zone append (e.g. a dm-crypt
> zoned device using a non-NULL IV cypher), fail to mount.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Added to misc-next, thanks. I'll queue it for 5.13, it's not an urgent
fix for 5.12 release but i'll tag it as stable so it'll apear in 5.12.x
later.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
