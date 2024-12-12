Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09018E7717F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 06:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZXkL/jwe1KJpb9z6G+ovBDENovucjrZmoP+08ql8GF8=; b=YF1HeIIOK3jwE6IkPA8Fe7D43T
	m6Z+3kXY3LRCXZZr6vxHa3thoRIDQS7cH2IvENnc3mQ+1vV5oh8QBWC5RJpvh8UHzwPCjdot+iQbi
	65K6H846Z2H9uDbZ/NSRJCTi5tPA9iTOIUlWWb5LUPm7uWSdVGqSjxjOOZf056zbRbwAo2PO9Po0M
	LzB6IRKR4Y7efMVzI/Vu2h48q+A2f0Xh6TxfLfEDHy3eg+EKCo2PvzE3QWr5aV40aEzzPDxHPd9+9
	5GjoyCgZeSwMmnAAnWNnvcyvBYqM7hue1jIYCpWTz7OkjCd9U18M05EU+2rb3iYfIxAfzIuwXbRjQ
	5dw92WIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLcLe-0000000H0MC-2GYy;
	Thu, 12 Dec 2024 06:06:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLcLb-0000000H0KC-3Byo
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 06:06:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9219E68D07; Thu, 12 Dec 2024 07:06:48 +0100 (CET)
Date: Thu, 12 Dec 2024 07:06:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v3 00/17] NVMe PCI endpoint target driver
Message-ID: <20241212060648.GB5266@lst.de>
References: <20241210093408.105867-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210093408.105867-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_220651_941783_B27068BF 
X-CRM114-Status: UNSURE (   9.69  )
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

FYI, this looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But I've closely worked with Damaien on this, so a look from someone
who is not too close to the work would be useful as well.


