Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0CEC63797
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jan 2023 06:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dYSuRYQfAMN1swxew38SWgEfF0K8MNGSEpsBYc78DnM=; b=f5jD9k5Jls8igvi1q7VVtMH/RL
	5j+0cuFIKTAUbwDjLfLRgmVqlDVHdszBehaT5NaN0z8tN8MioGLXiBKtACeoLCMAXAmFOtizy/wK0
	IoLPy6J8Z5+py92p4sASB+/WsL3gcyY0EwjkBV97TaOpz33akjESXbPhBIwsokYAfhQRsCYMTFPhn
	6y2UXCe/hjoplP5mlZnXqno3hRYkZ0bTQcT1msu00rHgA+fa0VrqdO1L+0sUhUtoDNIWsm3rZQwuc
	UEgvS+L6R6zZE/FxMP3QG+vErooDjyM2qTyNrRPv0m9eUuj3ZJBtk9thqZNPYdBsG+eNOG3g/GSCf
	JiAG/dmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHfbK-00D4nU-D2; Tue, 17 Jan 2023 06:37:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHfbH-00D4me-PK
	for linux-nvme@lists.infradead.org; Tue, 17 Jan 2023 06:37:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 662BE67373; Tue, 17 Jan 2023 07:37:35 +0100 (CET)
Date: Tue, 17 Jan 2023 07:37:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: regression on aarch64? panic on boot
Message-ID: <20230117063735.GA14468@lst.de>
References: <Y8XINx8fpGPKudW6@cormorant.local> <20230117055819.GB13795@lst.de> <Y8ZA30EoAFaFPwVC@cormorant.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8ZA30EoAFaFPwVC@cormorant.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230116_223739_993180_E2D48297 
X-CRM114-Status: GOOD (  12.83  )
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

On Tue, Jan 17, 2023 at 07:31:59AM +0100, Klaus Jensen wrote:
> Good morning Christoph,
> 
> Yep, the above works.

Context for the newly added: This is dropping the newly added
PROBE_PREFER_ASYNCHRONOUS in nvme, which causes Klaus' arm64 (but not
other boot tests) to fail.  Any idea what could be going wrong there
probably in userspace?


