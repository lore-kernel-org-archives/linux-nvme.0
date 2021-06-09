Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A79C48BCD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 13:25:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B66613AE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 13:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B66613AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=loU/Q8TAjJGC3xbOL9ng1c2sxW6mJz0yFe6KKhATHvA=; b=A5uT6LvUk+YwCN
	8h5m+5OebRzOhJF0tZP1sGlgiUdT35HVVpL5ijWBKfP4B99RfXpQtSGwYN132Pf1lT4HJWW93/Ql8
	mjYQxtNlfkrj4gbxJJ9iyaRK1++aL4mAHOEXEtt57sSI8KJjDMsLDLQrEQgurDrIy5gywp26YRwLg
	MY++PbLyQ4+rVZGx0kiw79geZy2NZL/rQp3QV3rc5TI8FUNTZNET2p8mwtdWuSm7KXyNiensI4sZZ
	4/Xp4gTj9aET5WHKQb217QGzVXHa3bMlzxq1A3JW6HDhJRcx1pevoJf/1IhwU/89niAKpBH8WgkLs
	uXGNOgz9xaGhRNegB1vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqyCN-00DzGK-PO; Wed, 09 Jun 2021 13:24:47 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqxnU-00Drp2-LY
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 12:59:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 85D4C68AFE; Wed,  9 Jun 2021 14:58:56 +0200 (CEST)
Date: Wed, 9 Jun 2021 14:58:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: kernel test robot <lkp@intel.com>,
 "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
Subject: Re: [linux-nvme:nvme-5.14 27/28] drivers/nvme/host/pci.c:539:7:
 error: implicit declaration of function 'nvme_ctrl_sgl_supported'
Message-ID: <20210609125856.GA1837@lst.de>
References: <202106090556.FQr8aEIa-lkp@intel.com>
 <E9067936-7A06-4EFF-A4A9-9405612333B6@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E9067936-7A06-4EFF-A4A9-9405612333B6@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_055904_906492_4C764982 
X-CRM114-Status: UNSURE (   7.81  )
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

I'll drop the patch for now.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
