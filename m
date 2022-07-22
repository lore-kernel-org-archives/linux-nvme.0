Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E1FC43334
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 04:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1YcWaE2JIjDLT+8acbfDR5uOJiuBkZNhLfg8d3eGjys=; b=SCq4aGT9O1T+FIlQSuZ2UUItep
	NhByRpojkjNBbddKL492YeuaoMG/wwoRUP8j78EW/5kjWs2mopUgCp3WMDiNH4I9AHVp9gtwi5IQB
	D1qfCjGQDlHs+q3Aj7Te+kguW17VxkbvUtYtxsqgHVhbvaQFIo3jZtZUzT6UYXwpev1PlqkIIbr1N
	LV0yco01jKIqjHDEF41r97Vg+NkDscthhwqhXwJ3Uij8B0zoB4DsPnB73upuGlOW4QkTDTSYEoQX5
	2nxzBoyt5I4Ga5I1b8eUsysx1mHCRvEuI1I4V1m3Kcl4cEomG3XFIMNYlOdeJSLT10CPS6I2XDSCC
	JeDE7qPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEkPb-00HWBi-UJ; Fri, 22 Jul 2022 04:37:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEkPY-00HWAO-FS
	for linux-nvme@lists.infradead.org; Fri, 22 Jul 2022 04:37:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3704A68AFE; Fri, 22 Jul 2022 06:37:07 +0200 (CEST)
Date: Fri, 22 Jul 2022 06:37:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	kbusch@kernel.org
Subject: Re: [PATCH] nvme-pci: print the command name of aborted commands
Message-ID: <20220722043707.GA30303@lst.de>
References: <20220718051357.232697-1-hch@lst.de> <e448b5d1-d1d1-49a4-3972-cbe89353fbf7@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e448b5d1-d1d1-49a4-3972-cbe89353fbf7@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_213712_693341_7D871DEE 
X-CRM114-Status: UNSURE (   9.94  )
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

On Fri, Jul 22, 2022 at 01:20:48AM +0300, Sagi Grimberg wrote:
> I want that for rdma/tcp/loop as well.

We don't ever send an abort from those currently.

