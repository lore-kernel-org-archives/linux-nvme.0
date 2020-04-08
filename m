Return-Path: <SRS0=zNed=5Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F79DC2D0F4
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 16:37:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A1520769
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 16:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="urgW4OBQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooK2ZAFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A1520769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9WJeBHrJB0NDq/4eJIOeS4Xv+5Kn7dcb73Fym7+xSSc=; b=urgW4OBQSIz5Gz
	v708BsMCjrLPXly9KQNgWx8yU9HWRqLiP1gg48IctAG8VqeBWGegPHoiwr0eyULG6I1E3ZHHI8HMa
	5FMxQRUdRtkP6f/BHssysvvDL1QEoWNZwvuE6qwouVO3jDbXlzw1ZWZ12ObA/zTk1INL0MzhCUAq7
	cDUJr5+idx/Y/nfOJhOD4pVAO/QGgpd5M4kqa8FYlBIC9/hfrIIv1QU9yERunDZr/YMBJMgfYIjTK
	tE35fpzjOVOgfFJ0EHizecjtorOil16QgZZpy0czauzw6UPIvpY4aVDNMlEer6qWnCmi0xPyejWOM
	AwetUm+uxSmOQhgf5W3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jMDhJ-0007vB-R9; Wed, 08 Apr 2020 16:37:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMDhH-0007up-JQ
 for linux-nvme@lists.infradead.org; Wed, 08 Apr 2020 16:37:04 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5CCCC20769;
 Wed,  8 Apr 2020 16:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586363823;
 bh=fltfh7Vd53WuNVDOuo2BMlHDBr0Mja6kvOzez5yjVVU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ooK2ZAFavdvJayiQbXS3TyDp4O3Y3JCaUAkE/UlHPXWyo7Q1W+ZDa91Acw3Q5/7MV
 4e5rzZdCMfyWps+WofJz8T55fpss/j7qRVOAJn1TZeoQIDj70+rrywQ7hyZD0+9zCQ
 zdLg8GO595Hxroupw+Jhj/zNn21XCF+nr+ZXwD3U=
Date: Thu, 9 Apr 2020 01:36:56 +0900
From: Keith Busch <kbusch@kernel.org>
To: Steven Seungcheol Lee <sc108.lee@samsung.com>
Subject: Re: [PATCH] nvme: structures and status update based on spec v1.4
Message-ID: <20200408163656.GA8942@redsun51.ssa.fujisawa.hgst.com>
References: <CGME20200408024822epcms2p1995674f0305dd4676395a34665862384@epcms2p1>
 <20200408024822epcms2p1995674f0305dd4676395a34665862384@epcms2p1>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200408024822epcms2p1995674f0305dd4676395a34665862384@epcms2p1>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200408_093703_660073_BDD2F2D7 
X-CRM114-Status: UNSURE (   5.98  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Beomsoo Kim <beomsooo.kim@samsung.com>,
 Jaegyu Choi <jg123.choi@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Javier Gonzalez <javier.gonz@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Apr 08, 2020 at 11:48:22AM +0900, Steven Seungcheol Lee wrote:
> Updates spec contents only for existing things on kernel.

There's no need to define these new fields and values here when there
are no users for them.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
