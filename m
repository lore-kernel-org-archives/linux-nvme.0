Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2EFE77197
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 08:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TLS4jY/JGx7AKLrY6t16YpBsqZunXPhItZk9CAinwyM=; b=Wx8MBijPfIPhmgdfdMgsS0Jyl0
	Y7hEM7TXTt520x5KwxVRC8FnoeQ2RJmSgpZpP4x2fu5YItyblip/3dOthO1YsXcQWYSDIEEsrRFU3
	DMzZnNaugnOhqyuLpv5h/B2SDYyKTeA+NVbXjlLtH+yFiIwXm5dK5Mog5b9URtyf8w5Wzo+JQgfhS
	HgQIq0l7kiKorTv+xdJNjOsnnjTbAdSqsDuq9YOytpluMs0VQx6XSnaQp1mPQE5Y+j+TpnSAPgjG2
	L9DbTlBF260QyDUV9fKCnQ9sSldonJh9P0twinWkaZidwjkHoZnJtKm78RZHg+ZMVAwjFgqNZJpPN
	lWbM5QxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV4vS-00000003vkw-2tey;
	Tue, 07 Jan 2025 08:26:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV4vQ-00000003vjs-3AUB
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 08:26:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4C69B68AFE; Tue,  7 Jan 2025 09:26:52 +0100 (CET)
Date: Tue, 7 Jan 2025 09:26:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	nbd@other.debian.org, linux-scsi@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 4/8] block: add a store_limit operations for sysfs
 entries
Message-ID: <20250107082651.GA16196@lst.de>
References: <20250107063120.1011593-1-hch@lst.de> <20250107063120.1011593-5-hch@lst.de> <Z3zXANbFk6GBZg_z@fedora> <ae6b7727-64d6-4d9e-9bf5-951e38d8a768@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae6b7727-64d6-4d9e-9bf5-951e38d8a768@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_002656_929565_EB5578B8 
X-CRM114-Status: UNSURE (   9.73  )
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

Hi Nilay,

this is a friendly reminder to reply without quoting the entire mail.
I did not find any content after scrolling half a dozen page of
full quote and gave up.


