Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C5FC10F16
	for <linux-nvme@archiver.kernel.org>; Mon,  6 May 2024 14:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xOm/StQQpkQ9yU/2PnaTEHnN3kr3utr0YdfE5pSwECY=; b=Fxyw2DLFyCgn5SgQu9Bk3fC/G2
	te97oXj/TcguC3m+ovFAV1ljWW2HXF7DJ6hAO7l/tvq2Rp51CSkZDEuMZn0L+W8ZTrXgZ6xrE/Tnw
	jOrEk4ZmibBclAnnU6ntZqWKa91BsV6S2WLVA0Wij7/tAbTSJBKvTvOL1G+zLYSmPKmjU0GN+QTal
	vx7RY9rxGd2WuIDNUJ4+/CYQWsMKHNnL9BieUNeWNdVD3deQrPZZHU13252jFbljF5jbvMJ+TuVhQ
	u6HazEVpbKkUGzL6XzygFQlFUNi3UatOiJp+7UT0vF4OMRn2yERyUPsrTrBw9dFKdHPcqTeRFc3HB
	eyIEEQMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3z8z-00000007cIQ-0FKa;
	Mon, 06 May 2024 14:16:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3z8v-00000007cHO-3xE2
	for linux-nvme@lists.infradead.org;
	Mon, 06 May 2024 14:16:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5D2AA227A87; Mon,  6 May 2024 16:16:29 +0200 (CEST)
Date: Mon, 6 May 2024 16:16:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvmet: make nvmet_wq unbound
Message-ID: <20240506141628.GA8235@lst.de>
References: <20240505103951.52413-1-sagi@grimberg.me> <20240506053308.GA5030@lst.de> <d15da519-2c81-42bb-8f60-89da4650f7a9@grimberg.me> <20240506120808.GA30005@lst.de> <470bf39f-e346-4899-b45f-5a7724a7039a@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <470bf39f-e346-4899-b45f-5a7724a7039a@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240506_071638_144020_A70520CA 
X-CRM114-Status: GOOD (  12.01  )
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

On Mon, May 06, 2024 at 05:05:13PM +0300, Sagi Grimberg wrote:
>>> What makes you think this is not harmless and useful?
>> Because now we have to deal with users setting more or less insane
>> parameters on the workqueue.
>>
>
> Isn't that an argument against WQ_SYSFS entirely?
> I can drop it though, its not really important.

Unless it's a workqueue where these settings explicitly should be user
tweakable: yes.

