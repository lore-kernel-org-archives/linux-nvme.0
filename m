Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC17C07545
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Oct 2023 06:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=BWESrhi1m4X6cPQzRLAbbMSmZw
	lfW1IE2VTfgU3RR+nft0NQZi54osOTQkSKuT5znsGe1uuLZMMzlGW3Br+MTaJm4t6SO9Mr6JP+kD5
	c9sjUwodg/wlE8lZIPZI2GrcjzMK2BjZPy2bor/6542qQLk7ituBefEZ3ctkOndscvegfDuL9Aum5
	wfN/pgzRHOfTOlMQ4jkXpavOCufrwUi/jZyOzubyoweg610PTCAqcRrvPSIZzhOJu7liIvJpXUcpF
	kbVT+89p1DafqbrUp27aXhwPRm8qaAqjiNHxYgLvw6A+S9q6PTQuGU51zic6jM8WtQd/2Q//OBo6V
	9H2wICmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvBEo-0090rT-2z;
	Tue, 24 Oct 2023 06:50:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvBEm-0090qj-1T
	for linux-nvme@lists.infradead.org;
	Tue, 24 Oct 2023 06:50:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C67806732D; Tue, 24 Oct 2023 08:49:57 +0200 (CEST)
Date: Tue, 24 Oct 2023 08:49:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mark O'Donovan <shiftee@posteo.net>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, kbusch@kernel.org,
	hare@suse.de
Subject: Re: [PATCH v2 3/3] nvme-auth: always set valid seq_num in dhchap
 reply
Message-ID: <20231024064957.GC9847@lst.de>
References: <20231023140003.58019-1-shiftee@posteo.net> <20231023140003.58019-4-shiftee@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023140003.58019-4-shiftee@posteo.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231023_235000_639634_CE50B33B 
X-CRM114-Status: UNSURE (   8.50  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

