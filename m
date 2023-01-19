Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74C1C38142
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Jan 2023 08:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IHGndIRja3xl0UdvqP7h7tDtLbkxDSiNXyiBZwZqyY0=; b=TDDj4fWRvFwe3EmD1AfP73edM/
	eh0UBU+dJwWoM93q2TEjA3I8bRGZDwQC8N9nitTYjJ7vCO3xHIKvGRjTgp1FCTofRL5Y6L6MUSgBW
	tWc4H3Z7LkiDTXokwDcPmuI6YTI49boiC5sb6RPk7+T/zmD/8A+jBpOAZMe2ptS//DheIUb/98R0U
	QoegBjkvqpCTNtypzgLasqSLOSj/jkJ1lvh7sj1uIgQ+oFmIOuB3SX6/jcfgDJjsEsQw661aW6oRJ
	34k7PaaSibFVyg62rlGY9nXTTIg5qggv5Nn8uGrw9KoMTVmN9MxOViqWgVX9XR2fwq7iSldgipvp3
	swwaEDng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIQ1z-0043xv-Ud; Thu, 19 Jan 2023 08:12:20 +0000
Received: from soltyk.jannau.net ([144.76.91.90])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIQ1o-0043vo-7h; Thu, 19 Jan 2023 08:12:09 +0000
Received: by soltyk.jannau.net (Postfix, from userid 1000)
	id A29BD26F67C; Thu, 19 Jan 2023 09:12:06 +0100 (CET)
Date: Thu, 19 Jan 2023 09:12:06 +0100
From: Janne Grunau <j@jannau.net>
To: Christoph Hellwig <hch@lst.de>
Cc: Hector Martin marcan <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Eric Curtin <ecurtin@redhat.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nvme-apple: Reset controller during shutdown
Message-ID: <20230119081206.GD3576@jannau.net>
References: <20230114-apple-nvme-suspend-fixes-v6.2-v2-0-9157bf633dba@jannau.net>
 <20230114-apple-nvme-suspend-fixes-v6.2-v2-1-9157bf633dba@jannau.net>
 <20230118052450.GA24742@lst.de>
 <20230119061452.GA17695@lst.de>
 <60A924B7-9F29-4AF1-9DF8-EA90DBA48B3E@marcan.st>
 <20230119080839.GA24679@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119080839.GA24679@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230119_001208_443111_9F2EE6B2 
X-CRM114-Status: UNSURE (   7.45  )
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

On 2023-01-19 09:08:39 +0100, Christoph Hellwig wrote:
> Thanks, this looks good.  Updated commit here:
> 
> http://git.infradead.org/nvme.git/commitdiff/c06ba7b892a50b48522ad441a40053f483dfee9e

looks good to me as well.

thanks

Janne

