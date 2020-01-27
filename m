Return-Path: <SRS0=UxdA=3Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE4FC2D0DB
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jan 2020 16:37:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34E4214D8
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jan 2020 16:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PRHOUt/2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovm0vapz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34E4214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TJXzEDuNfrljZ7oMUBI5AsplLOsRNIu2mAcLudfbd7s=; b=PRHOUt/2lsOgXE
	8x3nk2cKZ0qPGwhTXwxGOzR4d4kKmJFdjBl3otsHwOh2QWK+rOOmaplPv1sUPmaTFc5Wa+1X9utpU
	R2uvbdG0dmJFEhP/Bfk1cZ+99EjDmxHO9WYDqRmqtIm08p6lAbXO7T31rPF3ZYJ4lL+Z4ExeE4eee
	57u0QmFqRsTx5A2O3JYATDEPYweXmOLpQGE3pvabEyssTpJ5upiXbwRWbitpjrlxqvwRzsFJLvT13
	ZJbuasPb+URByuY6cf/GBPITw3AjjKgsiROP/mn12UL9JyFVNpW9p6lLir96leur4Xw97mPjiBUjB
	yYRYaIK8rzDecYGuCTuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iw7Nk-0002pZ-PA; Mon, 27 Jan 2020 16:37:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iw7Ni-0002os-U7
 for linux-nvme@lists.infradead.org; Mon, 27 Jan 2020 16:37:00 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9C77F206D4;
 Mon, 27 Jan 2020 16:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1580143016;
 bh=ntyWU1KIi38AW81EQsFzIxBr6ahMVg4xHn85/tev4OQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ovm0vapzessZYM7dZ51vQ3ZQve4zqc8CiCIW/50pZP27bt3vjuHaXEFBLswquBN2p
 l6dcS07Ip5xEJr2isIylxpcAoQB7XPpw0fi9hrk0YVPz/iOIKbgtzqtLbwSZyB/27g
 wa2lhm7T9yOQ6GBemUrmivatFdSdA5E/JYj963yo=
Date: Tue, 28 Jan 2020 01:36:51 +0900
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH] nvmet: configfs code cleanup
Message-ID: <20200127163651.GA17848@redsun51.ssa.fujisawa.hgst.com>
References: <20200126203544.4819-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200126203544.4819-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200127_083658_994053_45281530 
X-CRM114-Status: UNSURE (   8.49  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Jan 26, 2020 at 12:35:44PM -0800, Chaitanya Kulkarni wrote:
> This is a pure code cleanup patch which does not change any
> functionality. This patch removes the extra lines, get rid of
> else which is duplicate for return.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Applied for-5.6, thanks.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
