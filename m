Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DF1D6553E
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2024 18:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lC29wVITPHMOuhHH9Nx7D96CtWmpeHRsQUFq67BE4vo=; b=L55sDeBPcHcNVr5ehNM0Qq7w0o
	Q/N5tpeanU9U6yYON1OEiAKNWu39yi9YhEwU+bNYdXfYLzwfEbWgMRYTgEMA6YMPDSVqMt6If44Y5
	uug6U2wfxV/X3sGSJQvm7kwv9zP4bFEbE2Z5lk78fTJ0umXmlCVoiA2jeiM/uLrbvqPq6FwmzRdhN
	3brv6TmRjwY3Lji22ZIQSkBVQaFZMiJHN01+MQ45HV6QinCdXgD9XudVAiVRj4IScBDzazctkscaz
	a9MyL86J/qf/T0yl2F7kdT7z1zGEqa5x3JA6WgFtDCQC9Fg55Ol4BkcpdZnkMX1Gc4TC6v6WHzZaw
	HilVdc7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tG00E-0000000BOLL-140v;
	Tue, 26 Nov 2024 18:09:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tG00A-0000000BOKf-2YUt
	for linux-nvme@lists.infradead.org;
	Tue, 26 Nov 2024 18:09:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 73DFF68BFE; Tue, 26 Nov 2024 19:09:22 +0100 (CET)
Date: Tue, 26 Nov 2024 19:09:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Paul Webb <paul.x.webb@oracle.com>, Jens Axboe <axboe@kernel.dk>,
	Phil Auld <pauld@redhat.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nicky Veitch <nicky.veitch@oracle.com>
Subject: Re: [External] : Re: [bug-report] 5-9% FIO randomwrite ext4 perf
 regression on 6.12.y kernel
Message-ID: <20241126180922.GA18892@lst.de>
References: <20241121113058.GA394828@pauld.westford.csb> <a01ead6b-bd1d-4cd3-ade6-59ad905273e7@kernel.dk> <181bcb70-e0bf-4024-80b7-e79276d6eaf7@oracle.com> <20241122121304.GA25877@lst.de> <188e08f4-2eb3-41ad-a331-63fd5bb0e7f6@oracle.com> <14F95ECE-2AB7-4A50-AE45-C98EC426312C@oracle.com> <Z0Dy8H0A3Wj45ZQn@kbusch-mbp.dhcp.thefacebook.com> <CD26086B-67EE-4A62-AABF-3068252B158A@oracle.com> <20241126045557.GA31032@lst.de> <D00AC7C8-8371-4629-BA39-E0BFB9975195@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D00AC7C8-8371-4629-BA39-E0BFB9975195@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241126_100930_785298_42E17E2F 
X-CRM114-Status: GOOD (  13.27  )
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

On Tue, Nov 26, 2024 at 06:06:19PM +0000, Saeed Mirzamohammadi wrote:
> I was waiting for the results but yes that recovered the regression as well (snippet below), thanks! I think that’s the best way to go here. Should I make it into a patch and send it for review?

I'll send out the formal patch tomorrow morning, need to do a little
more digging for a good detailed commit log describing what went
wrong here.


