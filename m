Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC464C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Oct 2022 08:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lQrbLXI+C5PxPpRTHu/QuKE1L6V6wD06mSYCJHIvy3U=; b=CH6bxKYQCuwU7PNp4lPLuUPdGN
	ii3Ai4TLlHMKjma5H8cA209F9z6KZinrZufImENvx79GdJyKbZdW5RVHtlxa/4G+CxG6ogMb5IrnX
	lV4Hj5UHVqFmLwPqYHww/zTWcazfZ+WfFWndMRGlXpIcdl77oqagp1G973VqsJX3fDyLgcUMWCIvd
	sP6/vNiCS1Do/7CyrFGC1GteQH2CWBYmNb0ELiNRMfRBpyx9941My8gMdbYFO7S0/MAbXuMRK2/Fj
	FtJ1ItUWDVJZxHnefm8DVpfT2GFKZ9Xl1v0EtS8hsRy9qyJWfDChrIlRzJDDNNseF97C/9j/Z3Zq4
	yxMvPbow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohoFU-0002p4-6B; Mon, 10 Oct 2022 08:34:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohoFP-0002mq-O5
	for linux-nvme@lists.infradead.org; Mon, 10 Oct 2022 08:34:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1C32F68AA6; Mon, 10 Oct 2022 10:34:48 +0200 (CEST)
Date: Mon, 10 Oct 2022 10:34:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Yogev Cohen <yogev@lightbitslabs.com>
Subject: Re: [PATCH v3] nvme-multipath: fix possible hang in live ns resize
 with ANA access
Message-ID: <20221010083447.GA24903@lst.de>
References: <20220929073647.171775-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929073647.171775-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221010_013451_937733_8E22A5A1 
X-CRM114-Status: UNSURE (   9.40  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks, applied to nvme-6.1.

