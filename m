Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C831D12686
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 11:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DKGXXXeTLdD5Cu3Six/o+8wlmirWruNIgykv9Mr2d1o=; b=vGq45MH0DABm5ldU0n6DkBkiE2
	BkmY2LTA9RBPDiKu077vzoJfLSDjxtHtfs3GCijsmdyi9u+INEFbHoVsVygFLLbpWWbkrLmq5slRu
	w/SEfgHk2o7zhLtaC0+ufoppfTe/UU9HIK8W/W6aD8j7/v8nvvWSwNRj2FlkSagBhqJphgsTLvPj4
	w5dfTDvkRx8BfwHNAFUa40u0DwNe4n4nCqgmcsN+Y1IfrGP1xQ/mWxzCk2Ux3RtInvV+vewR5INO0
	ICdrED+GwSED2gVhx8ujkTMJn15hcdqV+xNYDrPrSyeJgAFynkIjvjxWVr8ghmEc+G9DTxSATl2i8
	Re+6g8jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8HU6-0000000Gnp0-46E8;
	Tue, 05 Nov 2024 11:12:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8HSs-0000000GneG-0LLN
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 11:11:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0628268CFE; Tue,  5 Nov 2024 12:11:07 +0100 (CET)
Date: Tue, 5 Nov 2024 12:11:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH RFC 2/3] nvme: query independent identify ns by default
Message-ID: <20241105111106.GA1993@lst.de>
References: <20241104085524.118221-1-kanie@linux.alibaba.com> <20241104085524.118221-3-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104085524.118221-3-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_031114_287711_14F623F5 
X-CRM114-Status: GOOD (  11.48  )
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

On Mon, Nov 04, 2024 at 04:55:01PM +0800, Guixin Liu wrote:
> Query independent identify ns by default, if returning fail,
> go back to sending the "identify namespace data structure for the
> specified NSID or the namespace capabilities for the NVM Command
> Set(cns = 0)".

How is this related to the rest of the series?


