Return-Path: <SRS0=uBfD=K4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F06C47083
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 08:00:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA5E613BF
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 08:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA5E613BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TSSnskhRbAAoRJI5Q0aNKJXlpZocpokp5tHORRiEirU=; b=CHi4VVr0oGSAN3
	f416YMNNO/KfeKTBWmYdZ7/Hn4GyRJPt5DekHne2AlJ7I8BPSWMbfLfRdOzxvG/0DacOFIJSNtASG
	tTwjcqa3tAJJnHfxlo4WOT8/5QqSloySCTTu8/mFhOMC/g4p7XSa+suCnKtEBNwNlElU5c/xvCv8V
	38CKvL5BQuuzGjqNKhzqk/g2D9YwgINnKv3Dxvs0hj6Qv+plm5UqBeiBEgpP6IK+Vbs1AN+6/Sq1N
	QjGTFuv2tzPvgulfymRwNNA/uZQEJygdKlRNdYAQV3RaCUUzFmzPo3N+tYb/WpsjmIF4CMbcozNT2
	jaWb/Vhoc203mkHnuZkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loLnu-002Siq-9J; Wed, 02 Jun 2021 08:00:42 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loL21-002Cmy-9t
 for linux-nvme@lists.infradead.org; Wed, 02 Jun 2021 07:11:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 87CC668B05; Wed,  2 Jun 2021 09:11:09 +0200 (CEST)
Date: Wed, 2 Jun 2021 09:11:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org,
 hch@lst.de, chaitanya.kulkarni@wdc.com, oren@nvidia.com,
 israelr@nvidia.com, logang@deltatee.com
Subject: Re: [PATCH 1/1] nvmet: fix freeing unallocated p2pmem
Message-ID: <20210602071109.GA10133@lst.de>
References: <20210601162205.38326-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210601162205.38326-1-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210602_001113_538230_15AE732F 
X-CRM114-Status: UNSURE (   8.37  )
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

Applied including the edit to streamline nvmet_req_find_p2p_dev.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
