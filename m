Return-Path: <SRS0=ND0+=JJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E585FC433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 07:48:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C0D16135A
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 07:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0D16135A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tCij+o3FJypyr8nMHwk9y9YjVHo19/RjBZc5uY9wlko=; b=jCYHgmIyadAFplDhhwzy5GJGC
	jkxtxnCA7ReR6mFBG5B+VsyZ++McVSIQGbUDrQqzaBdGnj0P6nYtZgQ2Gmz2WznFPP5U3rCdEANEP
	8C9yMfuz27rnA40/mELfGvOb7adaOgjWBt0eyY7NKt6WCAD/M1ZrLfDVt7EYYp+/6bV1dVnynjxY9
	4DEmw14GGznufJPOEyggYMCwnEZTILR/pVR4v5XwI/48B0XiF431/hWsKaUHD1pqJMNvSIBs7+cpS
	5JvOCP+EYUMSHBQrvoBJooHlpnwBSDvt1nDsKxIxrqx3HOVkM21gPKKw4rjxab1NDAlh5GhgLu8EN
	m20fXR7nQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVrJF-006199-PX; Mon, 12 Apr 2021 07:48:37 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVrJC-00618q-SG
 for linux-nvme@desiato.infradead.org; Mon, 12 Apr 2021 07:48:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=VGF+LtR5/PkeUw1C9bVYV3aARf5HcSTJ6rRvXNsQ64s=; b=JY1VpDCK514VKUH9jDTjVB74h7
 pbEJp04gGDQIQtkI1NQcdYeisxUUmVTpzRJ3eIxI8LZTvLHojuBOkN1jVI76i5muSfTtWgtHXefHk
 6qnm35cgEI4fubNHYGW4XOVjSxRPU492oM557yQ1v5CuVUUZlf0x03wtTgfilgbLJ7GA/ybk7f6O1
 8m67M9zHZmCVNKpid9Ilifu4P7F4YDlWe6DxLwnKdby5xRQ1BzdOz5frqOFWwfZIDTvyEAZBnim9n
 aX4f6A0wpW5m/EHXgBiCFXL+2IgCRLT5GFbKeBGKTSPFikWnsbtW57RvyvLg5DEpMtkG44lDwcdh9
 iCX7u8hA==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVrJA-005wJ8-FB
 for linux-nvme@lists.infradead.org; Mon, 12 Apr 2021 07:48:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7109268C4E; Mon, 12 Apr 2021 09:48:27 +0200 (CEST)
Date: Mon, 12 Apr 2021 09:48:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Colin King <colin.king@canonical.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] nvmet: Fix spelling mistake "nubmer" -> "number"
Message-ID: <20210412074826.GA3898@lst.de>
References: <20210407111020.486625-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210407111020.486625-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210412_004832_672636_E9B778D2 
X-CRM114-Status: UNSURE (   7.99  )
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

Applied to nvme-5.13.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
