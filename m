Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AF4CD128A
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 06:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3CaYQkJIzeUNrGgpSaGOyOZnWNfJoGMDwjXQF8sOFwk=; b=Vdk/pY8A5yPyMKwn03rbFQTI6c
	PpnjT5RoX6oRqW42g03ix7tsSzVFpnZ0aRXMfMfcCknC6jnVa/jKa8T6g85TW8awtXwKL355PXjTi
	HnpJn7uLp0fGU9YHFxYiBuImsuMv/bz794rZ9kZY8djeaouQitQ9dlDEFc7vaScKvgExktxxsDpw2
	9bj1R4FYmsWsvkqsdfYOqtTj6pTk8MnuZF2VVtJImztgA7YfvfkwR80kEQ2/lCJ8YTE3Q3SiIOWEB
	1zGCMPOBFfBHgb9ca6New6Fl5IB+1CXXs0wYPDMlebMyhriZ9BZIxF1OZuLJKzP6qrfEu8Ed+b83c
	79fQ0H6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rti5X-0000000ESgb-1HmZ;
	Mon, 08 Apr 2024 06:02:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rti5U-0000000ESdl-0dw9
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 06:02:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A424168D09; Mon,  8 Apr 2024 08:02:19 +0200 (CEST)
Date: Mon, 8 Apr 2024 08:02:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 00/28] Zone write plugging
Message-ID: <20240408060217.GA15846@lst.de>
References: <20240408014128.205141-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408014128.205141-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_230236_360382_86A1099B 
X-CRM114-Status: UNSURE (   9.81  )
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

FYI, this still looks good to me with the minor changes from the
last two iterations.

