Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3F7C369B2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 11:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jFFWhzzyGNB/IwmXr5oaIW9KDkvDJ2MxJRLFrdygUgs=; b=zRBjrw/tDVmSkoKMFt2fDjKDQB
	L/Vkgwu6XUcPe0+I/BFEwLWxX1P8vX/25TH2J3hPDDBBkEuarB7hrl+I20E83XYS4q1cjn3Dod0iw
	SVYiwzwOVKu5IXTW8TxCO/T5Uc2GAkJBw4D+0YRfJ9YW9rRgPWHrQY2Z1mp75StAwtuzKas38TUJZ
	0JD9lqiZ9iyfU27NUfiwQt/wqczHsLL8xnY4Z0/EPBS0eaA3JrCgsu7I4TF2XArdxVa/MIO4bS0cP
	B3m3F2VjVdHIy3kqUqC22dydJ9upltKSrYS/hJhQ9I4G2xgZDTTNRLkDoXFOSTPt16CwohErr7Wz9
	vvk6+SOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4ILU-00000001q9k-3l7M;
	Mon, 14 Apr 2025 11:51:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4IBy-00000001o4t-174z
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 11:41:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 916FF68AFE; Mon, 14 Apr 2025 13:41:28 +0200 (CEST)
Date: Mon, 14 Apr 2025 13:41:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, hare@kernel.org,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	wagi@lst.de, linux-nvme@lists.infradead.org,
	"Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>,
	Javier Gonzalez <javier.gonz@samsung.com>
Subject: Re: [PATCH 0/2] nvme: handle partially unique NID value
Message-ID: <20250414114128.GA13822@lst.de>
References: <20250414090959.2015-1-hare@kernel.org> <20250414111916.GB13225@lst.de> <3e6fb1f6-d6f0-4f33-9389-dff37daae7b0@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e6fb1f6-d6f0-4f33-9389-dff37daae7b0@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_044134_446386_A9DE9A40 
X-CRM114-Status: GOOD (  14.33  )
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

On Mon, Apr 14, 2025 at 01:31:29PM +0200, Hannes Reinecke wrote:
> We have discussed this at LSF, and the involved parties (ie
> Samsung as the vendor, HPe as the IHV, and us as the OS provider)
> are happy with this approach.
> And we have paying customers for which the cited patch caused a regression, 
> so ignoring it is not an option for us.

Tell them to fix their broken systems instead of shifting this broken
crap upstream.  Really, we bend over backwards for consumer hardware
that doesn't know better.  We don't add crap for vendors that absolutely
should know better participate in the working group and only provide
expensive enterprise hardware just because they pay you.  If you have
so little spine that you want to accommodate this intentionally broken
behavior do it in your tree but don't force the burden on others.

