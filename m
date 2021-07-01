Return-Path: <SRS0=jgW7=LZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F2FC11F64
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 14:20:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1530861405
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 14:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1530861405
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KbGSw0wyWKWPO17U929/jy1zoQXKWXrGRGh5RPWesmQ=; b=pEcGd4QIIxLQm/
	WD6h5+ylu0IQ0bblq1N86cODmSs72UMIgyR5G4ritTfJ1/cgsafrvExyoTJg/yAfwjEE1+xFz09p8
	37BR/IVmVs/r49p7Szr+2VZ/fxBns+JVVxT1FThrz0NFn2Oy/l1Ip0rP5n61ETZqf9ZuLO82SgpzV
	kkzSvYIRfU2FFCHqne9xDjmbsMTyBqvTvpj9wbAAZ+ZGEjofGhKaYQEh+io0ciYO4E4TlCRu3rrd5
	oMibQXY9ZKgdSubZJyVSHyd4o9D5uiGWKJJ03lOq521y72EDBgQXPMVHZJ95WeYBKhOX+rCf6oZJf
	Nx1e8ZZqK3QhF3c7bq8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyxYX-0002OA-Al; Thu, 01 Jul 2021 14:20:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyxYU-0002NJ-NO
 for linux-nvme@lists.infradead.org; Thu, 01 Jul 2021 14:20:39 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BC2C61405;
 Thu,  1 Jul 2021 14:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625149238;
 bh=SQSq9ogWmtmPuajCoHS0DChPgVVgS9fw7xgf2VjK3D0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gAhdiWbK1ZiMKr2FqSbt0icJkvnU02QPQ+Cc2kzZ1o0JoSsBn5JbGiBh0oOCQlvoH
 GQmnDLeCG78Bmgak2CYaDn2Btgbfhv5Eb4H5mP208C9uxPsa6C7NwRTvrPQD/h9Qco
 LeYRope8VBm3ibGlSxtxYafpRPIePK52exKYJItlOIatgPjIsr6qsHIEl99VL6KmLk
 o+J3Bzi8U0Oa2i84+8EnKjgQQsf2YHR9ZClAtyW6QfpnxKhFIvWYdfv+fhZGsU2M9z
 L6JsVA2i66XPjjkZ9mHY8xUrM8wbUalHqWHga0tyfWCUtOkna3VGU++X2Yzwe945gR
 agVkT71rVbwsw==
Date: Thu, 1 Jul 2021 07:20:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 1/2] blk-mq: not deactivate hctx if the device doesn't
 use managed irq
Message-ID: <20210701142035.GA3370360@dhcp-10-100-145-180.wdc.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <20210629074951.1981284-2-ming.lei@redhat.com>
 <DM6PR04MB70814885C27FF97CFC02A456E7029@DM6PR04MB7081.namprd04.prod.outlook.com>
 <0f8be11b-c6de-1c2b-323b-1e059c2ac4f8@grimberg.me>
 <CH2PR04MB70781FC64AC0621F7E55B408E7019@CH2PR04MB7078.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CH2PR04MB70781FC64AC0621F7E55B408E7019@CH2PR04MB7078.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210701_072038_819361_935FDC6D 
X-CRM114-Status: GOOD (  10.28  )
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

On Wed, Jun 30, 2021 at 09:57:05PM +0000, Damien Le Moal wrote:
> On 2021/07/01 3:58, Sagi Grimberg wrote:
> > 
> >>> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> >>> index 21140132a30d..600c5dd1a069 100644
> >>> --- a/include/linux/blk-mq.h
> >>> +++ b/include/linux/blk-mq.h
> >>> @@ -403,6 +403,7 @@ enum {
> >>>   	 */
> >>>   	BLK_MQ_F_STACKING	= 1 << 2,
> >>>   	BLK_MQ_F_TAG_HCTX_SHARED = 1 << 3,
> >>> +	BLK_MQ_F_NOT_USE_MANAGED_IRQ = 1 << 4,
> >>
> >> My 2 cents: BLK_MQ_F_NO_MANAGED_IRQ may be a better/shorter name.
> > 
> > Maybe BLK_MQ_F_UNMANAGED_IRQ?
> 
> Even better :)

Since most drivers are unmanaged, shouldn't that be the default? The
managed irq drivers should get to set a flag instead.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
