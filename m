Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58063CFD368
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 06:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ja/dybNRZjiFc4BwhelBUXC1g5mym/a7FtVQoXLnDWM=; b=ZlluRrOa8JGWPOhpPZxvKZefkr
	PcdZB+E5mcBa92wolgjqL8T28oPAxBx7Fk4wvcbCwZEU96fw2i8lXVQTvrWEZ4yv3xoPosE2pt8Mu
	VMgoo1xiq/YE6DNDd6zQ/aX5pFAhqKjL3Yj7Mzs1bR4wzrwDXMso4/DD0HjbIyVRoerKQ1+Na37gT
	ne1v75JmbmMOnDNpMmFOg2TNHAz8OPEGnYXZFudsoQNL52hze6VVILg5mC4L5/B4sTJD8R+mXTJqL
	2XnPjUh3VU5BQ59E9ZhIksnrew/Vhub6YJ7dGKJ+w+pMGOXLjXFgJhmLIWtq1sebWS554iXe88Gku
	i++JYgdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNmcm-0000000CpYT-3dzX;
	Tue, 25 Nov 2025 06:34:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNmcl-0000000CpXv-0DmY
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 06:34:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BA0A868B05; Tue, 25 Nov 2025 07:33:58 +0100 (CET)
Date: Tue, 25 Nov 2025 07:33:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chao Yu <chao@kernel.org>
Cc: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk,
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	song@kernel.org, yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, jaegeuk@kernel.org, cem@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
	bpf@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH V3 5/6] f2fs: ignore discard return value
Message-ID: <20251125063358.GA14801@lst.de>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com> <20251124234806.75216-6-ckulkarnilinux@gmail.com> <9c8a6b5f-74c8-4e9f-ae46-24e1df5fe4e0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c8a6b5f-74c8-4e9f-ae46-24e1df5fe4e0@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_223403_233288_63021DCA 
X-CRM114-Status: GOOD (  11.35  )
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

On Tue, Nov 25, 2025 at 09:10:00AM +0800, Chao Yu wrote:
> Reviewed-by: Chao Yu <chao@kernel.org>

Sending these all as a series might be confusing - it would be good
if the individual patches get picked through the subsystem trees
so that the function signature can be cleaned up after -rc1.

Can we get this queued up in the f2fs tree?


