Return-Path: <SRS0=n325=NQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CF0C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Aug 2021 08:54:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095C561139
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Aug 2021 08:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 095C561139
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=540pqsXYLrd0Txwh48HQyLjyeVW3317cBGZOcEyFB9A=; b=d5UeTyHx2uAWL+
	ctlOQqy2DILF3FB4FSTDxBRGCSBc5XFqUVbYuQaFWrVovCakibCL2+101C268QHb3ozCqY0YSnxAT
	EaDh1+QW08vK84HQPfb2Yc56WxceGxfqN9yYIzWbvziAvy0sVAmOwmmYxlsPoU/4GaJUZLb6zVKMx
	ii1POKdz8/a1cDfOgetruKxOh3z/O8HUR1P4Eaa5anDjz2P6xXnZPXKHstvnSKjZFMKEgqTRvhz6K
	avSSfgUAFAh2W0jiHSgNBWymAskVAsZMEIKPngaoYM2sApfqY6xy1Jvp2fQoozxVv66JSra0tmOvY
	hq5iZCne6RhLjJTX5baA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIofV-0060Mb-Dh; Wed, 25 Aug 2021 08:53:57 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIofT-0060L7-Bs
 for linux-nvme@lists.infradead.org; Wed, 25 Aug 2021 08:53:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0C18267357; Wed, 25 Aug 2021 10:53:46 +0200 (CEST)
Date: Wed, 25 Aug 2021 10:53:45 +0200
From: "hch@lst.de" <hch@lst.de>
To: sasaki tatsuya <tatsuya6.sasaki@kioxia.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: update keep alive interval when kato is modified
Message-ID: <20210825085345.GA31419@lst.de>
References: <526a1a756d6c4643b15b1b305cc32817@kioxia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <526a1a756d6c4643b15b1b305cc32817@kioxia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210825_015355_624049_8A89E816 
X-CRM114-Status: GOOD (  10.15  )
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

Any reason we can't just call this from nvme_passthru_end instead
of inventing a new API?  Right now the nvmet passthrough code never
uses the underlying keep alive code, so it doesn't make a difference,
but I expect we'll need more handling for passthrough commands like
this, and we might also grow more users (e.g. the io_uring based
passthrough).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
