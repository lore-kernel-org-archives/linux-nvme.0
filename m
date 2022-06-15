Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED350C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 05:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LSwiNooFNoXZjATP5NyRXWKVu1QY4d13eDLqpW1+iLo=; b=4hPdMAJSmNM/8Wh3jPVdkU6h8t
	Z6eb8dq2yPrZ0c/qK6TrXLt/zQJ/4EnqpgcHf7wtvQzzuRxc/R1+pRmHRWoq2Q0AhaXiBowBILTNo
	CgKrt36hpmDBZKXzYe4FtgmgLyg8wA9C6ytpj7gVLarhdQS3RR2NTeeR0EZYEiaqBVf25k6FOnhkY
	KNu/NfJJYIAE2vrOUOZoK2gFefT8YZ98UmKirctmtIflGzERX6IFckzFdExMUDvtrAjw1vrZj40KY
	5t0a4qPXRZuiNmTUzujI0LCxihFVVfOJHwhm/2fy1pg4uMsqSBjcuPh3mBjSIVNRe+Pr22L/X1odq
	T2UcvvjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Lit-00Cg0K-5X; Wed, 15 Jun 2022 05:37:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Lil-00Cfyq-P1
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 05:37:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 888A767373; Wed, 15 Jun 2022 07:37:29 +0200 (CEST)
Date: Wed, 15 Jun 2022 07:37:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Erwan Velu <erwanaliasr1@gmail.com>, Erwan Velu <e.velu@criteo.com>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] nvme: Report model,sn,fw,pci device information
 during init
Message-ID: <20220615053729.GA21858@lst.de>
References: <20220614210902.744318-1-e.velu@criteo.com> <20220614210902.744318-2-e.velu@criteo.com> <Yqj94JXMwjrdSbqG@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqj94JXMwjrdSbqG@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220614_223739_996249_BD89292F 
X-CRM114-Status: GOOD (  11.87  )
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

On Tue, Jun 14, 2022 at 02:30:08PM -0700, Keith Busch wrote:
> I'm unsure if the serial number should be logged. Firmware and model are
> probably fine.

I would much prefer to not print it all.  The Linux boot is way to spammy
to start with and this doesn't add any real value.

