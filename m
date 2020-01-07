Return-Path: <SRS0=77Bv=24=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEA3C33C8C
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2020 17:04:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EA51208C4
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2020 17:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jOdRllFy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVoraKJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA51208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GuXfKpjzc9x6Dnoq+mcau+iYCdoXqz8MWWwS/QZDXF4=; b=jOdRllFyuX3++K
	+Nta9/Vie3k1cVP+63n8XnFDgpt5Kl2sGa90COoTWNDFzIt9Hdldfn247iIrs6hQNkAVwCCLCtb4z
	F8oNORjlTsKP1YopPXgfJ2ID/Yf6a+ynswmek9ComRL5PjaqRDJeTYWOShdcZvku80GVwH+ew4PpH
	nsr9F75haFAkLH4XKr+jlU9FWOg8Y4umWpEpANpupDPaccpIwlrRWiAJzUQwVZDbNJlvc0EsicKcZ
	RoYPAaK+YpgJOT9VUDLU3CiHwEVjvM5R7LCEA89WPxEhruOzV/CTnIAcc8pgBm+H7soHm0Y2OBTcU
	MNLoFH26GJ4LeGp8vTSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iosHF-0005Xb-AM; Tue, 07 Jan 2020 17:04:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iosHB-0005XG-SP
 for linux-nvme@lists.infradead.org; Tue, 07 Jan 2020 17:04:19 +0000
Received: from chuupie.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C1C80208C4;
 Tue,  7 Jan 2020 17:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578416657;
 bh=GcW2dITOM3hpKnag21R+iXYkSDPuXta8coGyBUI0b3A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cVoraKJM+yflGB5N4r11LLggbmfdwwgn/kygt0uL7WdPnarFepPtegE1ODbnNTh9a
 TvbbbEdX4hXr9itUNTJ/rMdsEwL+fJ0l/WdheH1Aozatp9CZyZ8h1mLRG9CZ86c4fh
 JCGmDteKdZnJ8FwWW/xIAt9p77f4htnm8U3ozAME=
Date: Tue, 7 Jan 2020 10:04:14 -0700
From: Keith Busch <kbusch@kernel.org>
To: James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH] nvme-cli: Fix systemd service script use of CONNECT_ARGS
 env var
Message-ID: <20200107170414.GA600101@chuupie.wdl.wdc.com>
References: <20191219190534.11673-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191219190534.11673-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200107_090417_939008_8ED6FBDD 
X-CRM114-Status: UNSURE (   7.43  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Dec 19, 2019 at 11:05:34AM -0800, James Smart wrote:
> In testing, some environments are not properly expanding CONNECT_ARGS.
> 
> Change systemd service file use of CONNECT_ARGS to be encapsulated by
> apostrophes and parens.
> 
> Signed-off-by: James Smart <jsmart2021@gmail.com>

Patch applied, sorry for the delay.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
