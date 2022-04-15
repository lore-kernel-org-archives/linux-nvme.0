Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57971C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Apr 2022 05:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kyZluFDispHzU6EtFYly7NcsJxqecPrODfCIycc76so=; b=B/J7z474CAhUjqPBlQYmo66X0l
	OYdFr8QjV0GF0dov44UFPMmvzg2KW/Y2KJ3KRja766x3m1fHzGFuE7OMuowRm1bsCmBLuk1lNVMZk
	m9StcD8B8CnM+WeEYya2f/bsTkna8lKNUbWKlddQXUTZJw+ri9x6uus7TGoppV9ROXCeFH89SL1Qq
	cVXM+/fTizsUxpomLapcszvzLAfIK/6UwTPKHKjusGsLHc50//XKJpzwcotu7+587Ebc3uEAiOAwb
	zW1EZ1vbzeMrbeY/e9Jf9Fruu7tt5Udg3keOee1vCqe1ipXFMQLk1UQrcKn9tROGC3/bQVFfa7f/v
	RpANhfmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nfENZ-008ePv-HW; Fri, 15 Apr 2022 05:20:21 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nfENY-008ePJ-H3; Fri, 15 Apr 2022 05:20:20 +0000
Date: Thu, 14 Apr 2022 22:20:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@infradead.org>,
 Luis Chamberlain <mcgrof@kernel.org>, yi.zhang@redhat.com,
 sagi@grimberg.me, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: can't run nvme-mp blktests
Message-ID: <YlkAlHe6LloUAzzN@infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <YlZXOC4VgmDrUGIP@infradead.org>
 <YlcKqu3roZQSxZe8@bombadil.infradead.org>
 <YlcLOM49JsdlBqTW@infradead.org>
 <af030072-d932-5e38-64d6-bfd28152862b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af030072-d932-5e38-64d6-bfd28152862b@acm.org>
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

On Wed, Apr 13, 2022 at 03:46:16PM -0700, Bart Van Assche wrote:
> I'm not sure whether the nvme-mp tests test any code that is not yet tested by
> any nvme or srp test. How about removing these tests since these tests make
> it harder than necessary to run blktests?

I haven't looked at the details recently, but if these tests still are
basically a copy and paste of the srp mpath tests I'm all for removing
them!

