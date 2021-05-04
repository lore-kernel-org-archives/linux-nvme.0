Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307D3C433B4
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 07:42:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E73CB6103E
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 07:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73CB6103E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7xin8YcM8UXA1N0nCbD4BbyDBrLeWo+T/XKKPOETZ9c=; b=qMTLKUdZu8PdWiY0wq6fK2xzu
	enFgWn0fW1WcbifZ7+zxRjisaPPIKbj+PdfxtIpM07CJbxd5kQFtf+OLpZvQyiNZB0CctL4SuUvzm
	jpFu/env9wH//6Fx1SbEY7qSa9fvvExaGORFW9+m1szfdqV1qJqXkSTbXHjRomiZ/05QA1aOYddxZ
	7P/CySslU0Kbennp7KzJJ06nQtnfUfvr7R5PEJBJUNyR7pe5c/+Ub3/MbWcah8bbJX4WgDoDmFEzI
	WYHzAsACM35O0w7MgHmzO/4hZMCFPYdA8KiSe8GRlF0wxibv4P7B4ZY/dJxH7ZB2NBdi++v5s7vUZ
	o6OAywjGQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldph3-00FdFh-FA; Tue, 04 May 2021 07:42:09 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldph1-00FdFL-8D
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 07:42:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JfcaAWiL9MX/KzgqZFMd5GxaGaNC7KsyrSBFfXwwLXo=; b=rEpmhzDqqMnYCYM07ao3+qoSdg
 YMnGVffoCs5/dvnJXnOjsmvJDAxbTmNyhawdKgj9Zc+QbRmwBWY5tNnKZl1IyHaW5TYxce2iu6pAH
 zxoj8No9qBHaspRVCEP6q6x9mldvnwswN9ElrbNv3f+VFfro7YBFz5rPma/KsEZniZ1tzMaF3csuQ
 7DEelmRMhr/w/GPEmAZkni6APRhGGBGSupJTmPTjyFeyH4jX7pVC93sin5++8Dm9r2UTGjGRqryyh
 2k3xQbpN8L7VnPZ/dZZoJNMWqJTEhqvM+aSran6/lYvgRIwsig19f75G1iw4/SpIggLuluq3uNSFc
 sY1sNphw==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldpgy-003m2d-Ar
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 07:42:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id EEBE368AFE; Tue,  4 May 2021 09:41:53 +0200 (CEST)
Date: Tue, 4 May 2021 09:41:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 chaitanya.kulkarni@wdc.com, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] nvmet: remove unsupported command noise
Message-ID: <20210504074153.GA16523@lst.de>
References: <20210429042558.905404-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210429042558.905404-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_004204_538222_50084366 
X-CRM114-Status: UNSURE (   7.78  )
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

Thanks,

applied to nvme-5.13.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
