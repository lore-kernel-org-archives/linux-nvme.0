Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A51C10DC1
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Dec 2023 23:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/d89Bk0s0uKyPAI2o7XLTz37dajPXDDs1v/WfyzlMtY=; b=i7PIunmFhaDmK0F+T8gwjNmgHR
	hiW9QcFDf6V6sw/5byRcQf6XTkWPP9i52MmrL6aE32ymt1zhU/raymUm8IJu5z5ZZIeQDim2vwsGC
	InEppDo/QjsJYL6S5JtsuxAgaUfKdMhl1gSPFg0DC8NfxPFARfH3Ag2aCbP6NmqeA/nM9iX6zfKem
	pqJD5fDCQJF3/AcAtXbO2PloFDWgMazmMKbv4IpjBcNQxLMCSKLIzDfhmMC5nht7Sm4v6LJFzo+lw
	lqZSmCgLDnwREXBMZZnN2Pta7NVCsI5ax9LJg2cufpL7r+h17zdMXQB0nKgMXMRil0v2PX0lKsQDj
	kiUd4VUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rB1HP-00BTm7-1r;
	Wed, 06 Dec 2023 23:26:11 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rB1HL-00BTld-38
	for linux-nvme@lists.infradead.org;
	Wed, 06 Dec 2023 23:26:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3BB3A61547;
	Wed,  6 Dec 2023 23:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2F0C433C7;
	Wed,  6 Dec 2023 23:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701905166;
	bh=/d89Bk0s0uKyPAI2o7XLTz37dajPXDDs1v/WfyzlMtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PWGNUSKf0By2bhIw3bKdpFN2aLvAqrLMmaSuRkaVcUNoCqBR7w+qoIWJyWBfeh4WX
	 Dy4t87KK2gWATJz5yxAK7hTTLf7ZR31AXpz5+zNKMVg+Qe6+rqN427aAfQLMCmNGPn
	 RjXCWBZNO7At5E65+PzkEi8tG4zPwvU0ZGZkD4crQ6HTo1WHmAyrJnfjrTZvcMDh3k
	 4fYRjLo/uDzUjc4E0rCtJ4mE9Rc17o+EmIq3YyQpC3WUGqtw3/X+4No4zTW3MdSInI
	 YLM16roAhTBKVALYhEeSwmOLIW86sV7uUsbvGbl1cmZeuqMeNELduGjGq7x2CfXUAt
	 QCDNWhvpMSCHA==
Date: Wed, 6 Dec 2023 16:26:04 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme: introduce nvme_check_ctrl_fabric_info helper
Message-ID: <ZXEDDC0e4nL_TPLo@kbusch-mbp>
References: <1701761860-17623-1-git-send-email-kanie@linux.alibaba.com>
 <ZXECNqxv6Vd7ttl8@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXECNqxv6Vd7ttl8@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_152609_428532_338C1072 
X-CRM114-Status: UNSURE (   7.19  )
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

On Wed, Dec 06, 2023 at 04:22:30PM -0700, Keith Busch wrote:
> Thanks, series applied for nvme-6.8 with the minor style suggestions for
> patch 2.

Sorry, I meant patch 1; same result.

