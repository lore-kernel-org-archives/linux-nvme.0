Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE3DCCA479
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 05:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OKoPl6pkKwqfVXv0tkCsZkhTLVRcHEZ8byA5r6vMqzE=; b=Zwf5sFghuQgUDsL88F+UmlDKAg
	iiRUyP1y1+TNz8HFcofjtBKO6Xcw6Ncbms8yHPZogD2fQFMDI1SJ2dZO0r2O70zlQdrmBn6h8qOST
	5+THBa7NMJ41rV86DmvklZcgWESVSnM82XOpA8V2GufGANRT/qayk42UGMYiF860czKHVUtbPkPX5
	YfakR7y9I/IsLEAfDzA1Es/P8SwwEtv7qJ03BL6x/bG3E189Yn8+1I+MdNhIRH1b/RIHxwXs3yTr5
	Ym9+7dS54KwymiG5Yub4X7r2qAyoseOWz1BIWAATQWGp8p0FI5O+sBrcwihdOvsZW5bWLudhz7JxT
	Haxa6THQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEOwU-0005DA-SI; Thu, 21 Jul 2022 05:41:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEOwS-00057Z-OJ
	for linux-nvme@lists.infradead.org; Thu, 21 Jul 2022 05:41:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0CE1668AFE; Thu, 21 Jul 2022 07:41:42 +0200 (CEST)
Date: Thu, 21 Jul 2022 07:41:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nick Bowler <nbowler@draconx.ca>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Guixin Liu <kanie@linux.alibaba.com>
Subject: Re: [PATCH v2] nvme: Define compat_ioctl again to unbreak 32-bit
 userspace.
Message-ID: <20220721054141.GC20003@lst.de>
References: <20220721035735.2720-1-nbowler@draconx.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721035735.2720-1-nbowler@draconx.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220720_224144_948226_7E51D8DA 
X-CRM114-Status: UNSURE (   7.72  )
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

Thanks,

applied to nvme-5.20.

