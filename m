Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC004C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 07:10:41 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC0BC6101D
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 07:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0BC6101D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OZi9+CKfdeb6HIXR/is50kp4XhuAT+U5nXLyoKJuu7s=; b=iQbFOI/lFxAMFl+BpP4IFs6Ff
	qCOq9QSh08SUnJe91+oWtf5jgST2AIXCDdGCl9PawyvQ0qYGx579NGyE5M9SwYJPaolBlhLUKM5FG
	q+hAx9Zw8bmaZR5Zb0h4tre+FMzOPTGCZ/WaTBmrPs35whApyW3LdxTDlX0uNHU8kreWeJ7711SBz
	xXdRPcj5+Cga+NX2JNZ2lJkxUv2aVX23TtTvWA6DIElVYo3gmOTjdlsuhDkW6vKtVAJK/JPYhZZZv
	RRwM6mSEuMcoOJWaaPWrEJFxOoMZFK/T36WHz/sNkL1K4GD/tkyptWtfH8ElNJRkiWaBy1SNJSrKt
	pd9epDq+w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYO2v-009IOv-0h; Mon, 19 Apr 2021 07:10:13 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYO2r-009IOT-8S
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 07:10:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=nsEFNC2JpNTf6B6tal4EFdKGsIcNBKYUQ8+u4VT8lYg=; b=cvsQDYV500Zz/J021t5Lwd+DAd
 IsU7tWbItN722ng3t2e0FeOBHo6mQQBuZlMbsfqTgugr8Au/0m3HwupSWfFago9ukZ1aYhVu3HVpS
 3y7b7W7+Gcq5eznLwbiB8PIoQdgLTFXPv2F3UlCSW2SGf4lI4OH1MpLr6rsKh0LIU1ctqQjPx3gW3
 AnV2fTscWgDoHPWJThgbGp99qZDDWy0H5pKj4t2OG7LTSXGVJ6jvLxwr/BYMfrY2zHp71OKJZQt3D
 JSwOp+tJnPJyh6Ru3C1LxTZ8J3su29CHU+zS2QJEUtQ9u7bJPJaK57YPBETwi7tOhRzUWM1OeF+ZP
 MZrQnEOQ==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYO2o-00B6lW-SP
 for linux-nvme@lists.infradead.org; Mon, 19 Apr 2021 07:10:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id EFB8067373; Mon, 19 Apr 2021 09:10:04 +0200 (CEST)
Date: Mon, 19 Apr 2021 09:10:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 Mike Snitzer <snitzer@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2 3/3] zonefs: fix synchronous write to sequential
 zone files
Message-ID: <20210419071004.GA19600@lst.de>
References: <20210417023323.852530-1-damien.lemoal@wdc.com>
 <20210417023323.852530-4-damien.lemoal@wdc.com>
 <20210419064529.GA19041@lst.de>
 <BL0PR04MB651477B7ECC57FA61E1C99EFE7499@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BL0PR04MB651477B7ECC57FA61E1C99EFE7499@BL0PR04MB6514.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210419_001007_080999_B2D1E6D8 
X-CRM114-Status: UNSURE (   9.70  )
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

On Mon, Apr 19, 2021 at 07:08:46AM +0000, Damien Le Moal wrote:
> 1) refuse to mount if ZA is disabled, same as btrfs

Yes, please do that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
