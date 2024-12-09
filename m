Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF53E7717D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 07:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=l7y7n0BJ1p/UE8ubwcuJG6n944
	rCsmS+iogPwbs2K0TPL7qzaOVR9duy0KxK5EZsCVNYOx2uszXIghgPDvQGSvY9H1gXLMtib0JO9bj
	jnUwJKzkZ93Qi0d8ZeLyGdys+8w4vCLUKjkkyx9Ij0irwU1Eq3n9VS44v1kScqJ7XRgu67hk+Ln6o
	L4MM5DinczsLnTMtDz/WaaAiibGyO6Wx6PAa8P5zybxhrW2toIiZqs1WTV597re0V02S2AsyV1Zz2
	dqADbDae4Mk7f2ClMVWc2BaB6LyYTfHyaUMEeIjXr6h1XO2yNBUL/W4DcIikRlHvZebkbmhETFMix
	lhqPzbtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKYfb-00000006njB-2krs;
	Mon, 09 Dec 2024 07:59:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKYfZ-00000006ni9-13QH
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 07:59:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E863E68D0E; Mon,  9 Dec 2024 08:59:01 +0100 (CET)
Date: Mon, 9 Dec 2024 08:59:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: fix comment typo
Message-ID: <20241209075901.GA24730@lst.de>
References: <6460798716383804d15e987b0c218bf9969b33d2.1733657672.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6460798716383804d15e987b0c218bf9969b33d2.1733657672.git.baruch@tkos.co.il>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241208_235905_428773_B73D6CF9 
X-CRM114-Status: UNSURE (   9.90  )
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


