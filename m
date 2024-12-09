Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1315E77180
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 17:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UunNpXZLaCyhhmqBaF7F2iv/OIXmf6YTRKMXx11BKOo=; b=taGn65xsFB3/YFhu9FUKaklcUg
	LgjjsKxF8+lAC994FTrWk4KpV452wJXXSdS82UAYF+eW4HUbhxzRxSxkp6LmqAbJ64HURR3aVzr94
	uwchH1tZUYxNc1XyjtxblOeyPG8l+P1Xyc9opQIU0o2Y/qR1Pyq0ZXiiagKJa1HCeGX9v+lozWjO0
	4gxS9oILf5HhBzZPUvZk85pgJ4UR7pWyTf0SaQh6MYmqxIGpD5e+v+FBd2W7wSFWpwc2VoKgyrV66
	Y5vTJrbvD9Wr6bmSWal3JO68mj1XLmpL/pDf13ValsX4NYXUz+d42Tj5JFOI9/fhPNzZARBRU4her
	xKv9EtLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKhVW-00000008iwj-0G75;
	Mon, 09 Dec 2024 17:25:18 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKhVU-00000008iwM-0sAw
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 17:25:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id ECD74A4182C;
	Mon,  9 Dec 2024 17:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5A0C4CED1;
	Mon,  9 Dec 2024 17:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733765115;
	bh=UunNpXZLaCyhhmqBaF7F2iv/OIXmf6YTRKMXx11BKOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LiG6rHA/QSaokIFPmLccdq1P1TnM+ReNY+PAMBZitZU6bcUNzaGsywjVdrb5DLUp3
	 NUirGGGmEW9J9rkt5NvcWYZb6UlY2Cb4LA3sLkAofakmiCoZszJwurL5KODlil0hLy
	 YVpdrmN7MRw7vL03vl7CLJicke/zrv2X6ESnuK5mjj+wQ7e4Q743Pt7QsAv8yDXybt
	 NggcvLEvltT/Us2ctg+vYerMfJYVAXXIZuyaG9NBmuH0vMrll2v+rqbMP3dX0VNcpn
	 cFcWZjlONIAeObu7st/EpKPVb2O3NxJghBoOZs6dH41nciyzO12bfa56gV2eiQLDks
	 TFP+EfUhvm01A==
Date: Mon, 9 Dec 2024 10:25:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Pierre Labat <plabat@micron.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"asml.silence@gmail.com" <asml.silence@gmail.com>
Subject: Re: [EXT] Re: [PATCHv11 00/10] block write streams with nvme fdp
Message-ID: <Z1cn-LLW3pGqJFqC@kbusch-mbp.dhcp.thefacebook.com>
References: <20241206015308.3342386-1-kbusch@meta.com>
 <20241209125132.GA14316@lst.de>
 <DS0PR08MB85414C2FDCFE1F98424C0366AB3C2@DS0PR08MB8541.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR08MB85414C2FDCFE1F98424C0366AB3C2@DS0PR08MB8541.namprd08.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_092516_312762_1BDD67F7 
X-CRM114-Status: GOOD (  10.51  )
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

On Mon, Dec 09, 2024 at 05:14:16PM +0000, Pierre Labat wrote:
> I was under the impression that passing write hints via fcntl() on any
> legacy filesystem stays. The hint is attached to the inode, and the fs
> simply picks it up from there when sending it down with write related
> to that inode.
> Aka per file write hint.
>
> I am right?

Nothing is changing with respect to those write hints as a result of
this series, if that's what you mean. The driver hadn't been checking
the write hint before, and this patch set continues that pre-existing
behavior. For this series, the driver utilizes a new field:
"write_stream".

Mapping the inode write hint to an FDP stream for other filesystems
remains an open topic to follow on later.

