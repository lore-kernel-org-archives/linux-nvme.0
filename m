Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728F9CCA476
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Oct 2025 05:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=dqR3zEzGyAaX0Y7ANC9xRXcoaf
	fbtAkkPeuy4URPyp/5/dOXrpaYSfL7hOd3i5QhcpkbJ5IFwsZ41SiKti1mUgtGq0iTcx1z0MuAube
	0bpyf0ceAUQrwY4CTVWjXCbwakvUuze8a5eHKgu5oYIxSPAQGk+nE6tFS/YlKxmtkgHW0lCpwGgmK
	L9/Uju6XYgYB4wMP0pSUCulZDDrdMK381Npi5KMjHWSu1RZ7c/0X7dyj0gVtBsUTYgNm4CSEW4dSV
	aj32xcpE5wh3qvWIWtqrlXvDCQw4qesk2SQxEUT50tT3KPKPHAIUXJtGeFpVBpVQn5AtRPzO1ij2N
	a8TtuzNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v75mD-00000007iZo-0A6K;
	Fri, 10 Oct 2025 05:34:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v75m9-00000007iZC-3YSI
	for linux-nvme@lists.infradead.org;
	Fri, 10 Oct 2025 05:34:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6B130227AAA; Fri, 10 Oct 2025 07:34:41 +0200 (CEST)
Date: Fri, 10 Oct 2025 07:34:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 2/2] nvme: remove virtual boundary for sgl capable
 devices
Message-ID: <20251010053441.GB16037@lst.de>
References: <20251007175245.3898972-1-kbusch@meta.com> <20251007175245.3898972-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007175245.3898972-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251009_223446_025229_357AF49E 
X-CRM114-Status: UNSURE (   8.36  )
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

