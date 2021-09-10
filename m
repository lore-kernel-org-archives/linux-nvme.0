Return-Path: <SRS0=S/y/=OA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE83C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Sep 2021 10:13:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35A686103D
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Sep 2021 10:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 35A686103D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZLVcWOCVex2ZDlkFpnz2q60GYbhFMzSWeKNxjMlau2E=; b=LFBXPE0eo5RJC7
	IrgHasvovLiv3iBUYl4MJxeK3WBjT1b/fmABEDMwpqYXo9oU9AZhwVYzJLse3l9kRdaRbM7RynJbn
	o24JrywszRkutoHNrmcjr5ViUG94BbzfOZN0ljC8fOtcgF1kYT1tLXtUGJhjYiDOOpuyW/pMGeDnA
	39mhVbugjrQbx2WWjnXmidre6yI4anhuN4Wv4b4BdcQuMLUy3EDBGPhTVWWSm/Bfuoew0/XWa2Ux3
	iJXJA6iyFIpdqJ6NYqhbKwLiTSVY4+IYWzvHelq8/cW3TdSAFHlkxV3YYyq9jQgFjjTRG4jN+LQUc
	EN8CU0KsbbSvdTNnDzZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mOdWM-00CQRk-T7; Fri, 10 Sep 2021 10:12:34 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOdWJ-00CQQb-IA
 for linux-nvme@lists.infradead.org; Fri, 10 Sep 2021 10:12:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8DE3767357; Fri, 10 Sep 2021 12:12:24 +0200 (CEST)
Date: Fri, 10 Sep 2021 12:12:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lihong Kou <koulihong@huawei.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] block: nvme: fix the NULL ptr bug in
 bio_integrity_verify_fn
Message-ID: <20210910101224.GA12941@lst.de>
References: <20210910085412.747800-1-koulihong@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210910085412.747800-1-koulihong@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210910_031231_790389_EFE98E5A 
X-CRM114-Status: UNSURE (   8.78  )
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

Please just add the call to blk_flush_integrity to
blk_integrity_unregister itself.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
