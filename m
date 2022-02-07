Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F88C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Feb 2022 12:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Doyl7c+YKASq4AJluYrR+O87aR16tDdEKZAcpy46YD4=; b=DvPuko9YhMCtsftOHTpcRomjbq
	GncjZDiZMtadx8KFs9jOiSrRPpk1J5MwAL608oogEJQbusQlPpJNM1z7yEwLhx6v9e6yzIV1H4d7q
	ntoIX8AUip9ZWT9eHOug4anU1d3vh5UrcKHQWZwP4acHHuFK49ZNgPvF8JY9eJTSu7J3jV5/cye0F
	yPo2svTssdmjPGQ1oMGNSKQ+mVdDM0PRyfI2iE2kmoUGtYyPxcMHszKQWvNJkafOjSNExG0FykRVY
	9ASq1hZsaoP3zD3eJ+KPgJLGndFEZBLGHBx53eC673FFPhJuN4vZid2Ly8S+VC88RVp9VaJhdUWEi
	pLM29iFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nH2oU-00A6DC-SW; Mon, 07 Feb 2022 12:08:10 +0000
Received: from hiro.icebalm.com ([172.245.134.119])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nH2oS-00A6Bs-AZ
 for linux-nvme@lists.infradead.org; Mon, 07 Feb 2022 12:08:09 +0000
Received: from citadel.icebalm.com (unknown [10.0.10.6])
 by hiro.icebalm.com (Postfix) with ESMTPS id CF9025F405;
 Mon,  7 Feb 2022 06:08:01 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
 by citadel.icebalm.com (Postfix) with ESMTP id 856E41203D51;
 Mon,  7 Feb 2022 07:08:01 -0500 (EST)
Received: from citadel.icebalm.com ([127.0.0.1])
 by localhost (citadel.icebalm.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Hg5K68Bxnbc6; Mon,  7 Feb 2022 07:08:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by citadel.icebalm.com (Postfix) with ESMTP id 27856120AD7B;
 Mon,  7 Feb 2022 07:08:01 -0500 (EST)
X-Virus-Scanned: amavisd-new at icebalm.com
Received: from citadel.icebalm.com ([127.0.0.1])
 by localhost (citadel.icebalm.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 71Ajdv4xUNba; Mon,  7 Feb 2022 07:08:01 -0500 (EST)
Received: from citadel.icebalm.com (citadel.icebalm.com [10.0.10.6])
 by citadel.icebalm.com (Postfix) with ESMTP id 0EE501203D51;
 Mon,  7 Feb 2022 07:08:01 -0500 (EST)
Date: Mon, 7 Feb 2022 07:08:00 -0500 (EST)
From: Warren Chartier <icebalm@icebalm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, 
 Sagi Grimberg <sagi@grimberg.me>, 
 linux-nvme <linux-nvme@lists.infradead.org>
Message-ID: <1316046246.0.1644235680860.JavaMail.zimbra@icebalm.com>
In-Reply-To: <20220207064653.GA23286@lst.de>
References: <1897892278.92.1644177774073.JavaMail.zimbra@icebalm.com>
 <20220207064653.GA23286@lst.de>
Subject: Re: PROBLEM: XPG Gammix S70 Blade PCIe Gen 4 NVMe drive unusable in
 Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.0.10.6]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Topic: PROBLEM: XPG Gammix S70 Blade PCIe Gen 4 NVMe drive unusable in
 Linux
Thread-Index: PTY4qUOmvE3VHNJLAOC9Xz2sn1pVBg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220207_040808_446124_98B11F2A 
X-CRM114-Status: UNSURE (   4.14  )
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

Hi Christoph,

Yes, I did go looking for newer firmware. The ADATA Windows utility tells me there are no firmware updates available for the drive and that I have the latest.

----- Original Message -----
From: "Christoph Hellwig" <hch@lst.de>
To: "Warren Chartier" <icebalm@icebalm.com>
Cc: "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@fb.com>, "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, "linux-nvme" <linux-nvme@lists.infradead.org>
Sent: Monday, February 7, 2022 1:46:53 AM
Subject: Re: PROBLEM: XPG Gammix S70 Blade PCIe Gen 4 NVMe drive unusable in Linux

Based on the warnings the drive seems to have rather broken VPD
support.  Did you check with the vendor if there might be a newer
firmware available?

