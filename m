Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000C4C0218B
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 15:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jCNq3FdaooIHa/dhF2Eu4TWh4pt77tYRxwQVFjCdKhk=; b=o7u7zza10fKNhaVErbrMq5zR/n
	ey+zlniGtRwGTwvJ2e2n65vh6jhhEC5ggn6KZgp8S+K2aWW5nOFr2YklJsKjYoCTiD5RHpfAGLSt9
	bBQjEe+NgJQ+tmEyRwgreNAuuQ/FZgZxfETgWtetKhPTV1gLwfcFvIUHRZBXyITqpMwl0U69mJFVF
	4/aHQmygwvFdYujGVIK5+gFVQCWTkMfdzBXDV0Ljrgnx02PoNTwuq66uys0Z/1qijvzEHGu2xvXcT
	X92cJwCVonFZnHuEyE7eEUlh/KGzRam3lQ2DqdhUp+ew7+3IA/mTnsjkkdspb6Z7L8uZ9VmOIagJL
	8JymjYxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbLiw-0000000F0gQ-3tg5;
	Fri, 24 Jan 2025 15:35:58 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbLiu-0000000F0g3-15EY
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 15:35:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C91F9A4191E;
	Fri, 24 Jan 2025 15:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF68C4CEDD;
	Fri, 24 Jan 2025 15:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737732954;
	bh=jCNq3FdaooIHa/dhF2Eu4TWh4pt77tYRxwQVFjCdKhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I84h1segP/9qxfOAhDMrgyLb1isM/tW7nbCzFnBJH4sNhPVnoOzrek2chL54C9Uoj
	 Wf2Bc70u2bQtvMhPXveu+nlhMzHbd2Enr0zOdoVa/njeN6l6toIPyEW0wQnE96SdmG
	 cnG8HYxifcO3Nhi4u+B7mmIDp6Z5nC/a3nc3PvAflOIs23S6n4BdTcUltxNxyI2o0J
	 lxOrYgOIjoEmqJ3v7GA2yjT0+hq1BaDo439Zzf+G+gknaZ9bW0VDzIHBE3RyDXPFtK
	 klMZWcpx0l+/kcMQBeXdK5b+2z45F6/+D+nAtmUpmij7VtjdzB4ZyNNlGulzlq2BAo
	 8J34eDzh1LMbg==
Date: Fri, 24 Jan 2025 08:35:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvmet: fix a memory leak in controller identify
Message-ID: <Z5OzV2_xFIeWeuIC@kbusch-mbp>
References: <20250124110033.391731-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124110033.391731-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_073556_361476_726BCFF1 
X-CRM114-Status: UNSURE (   8.58  )
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

On Fri, Jan 24, 2025 at 01:00:33PM +0200, Sagi Grimberg wrote:
> Simply free an allocated buffer once we copied its content
> to the request sgl.

Thanks, applied to nvme-6.14.

