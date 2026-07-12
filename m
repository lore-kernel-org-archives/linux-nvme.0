Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BDCC44501
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 07:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sin8W3ZSdHD4q1m7BeezG3ErJ60L00G8/X/y0SdGqTc=; b=Dd+tj7BGVO9D4u81bjLUGiRXse
	35lynlA9ppMNmRMeIci4WIoMs9G82uYvaI5vWWJ08jFK/+aSuVbcXbKqFoxmL97Iihm841FiiOce7
	Kw6HoNPAayZQ+3Q9CsvqQxycAec5nNzSzmcaqgy6vuz8h1zFm1hVd0oS2iztTFWhLnnn9D1VR/urY
	kAZhZ4eaJWh/AoYMFAM9RCP7Yp34iMxEUUReB2NPaN0cnat2ZjjFx4BEAp87Ht/SKcp3H1pJs44fP
	/H56lnxG7Pb2rGJhdhykEQcfsgGbMO7lRX55mEr0WbNS0cH3qnjHGRhRFxCbgJb2tn0Qcxv6P8i/l
	IL2uRzcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjB2f-00000008Oga-46Ch;
	Mon, 13 Jul 2026 07:25:29 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wisKi-00000007P3W-3lUO
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jul 2026 11:26:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0811440624;
	Sun, 12 Jul 2026 11:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1620A1F000E9;
	Sun, 12 Jul 2026 11:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783855611;
	bh=Sin8W3ZSdHD4q1m7BeezG3ErJ60L00G8/X/y0SdGqTc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=lgFqAe2CIAhPszW7dLMvqr/QHmYXAz3go05mHZWk7bZTEA8XothagfswALI5CEJ+i
	 0/zcwFmx/MAUOlv2WC/s2epj24ecaWmboGbGvQFSdkK58uukgz+cR8GGOYWXCHQ2UQ
	 ZKH8Or6D2OdtehEd1jt2vcB+LrwffQROFEPVGjMCcHoZwOVQl75cb6nVcjzXwAc9CI
	 HaUN6hFMiEY2zLm5f1c1uZA2/oLkMFHGILLE6ifVt49j0qVxUnTpvSBzjAFj83prdl
	 EgQ7u5uBRLisFcNsfJQku5o7hx2GUEttIF240YZwZL+pN2JdzlSIQqfYsT2osBP/xC
	 xwxSzyJO8l3FQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, mkalderon@marvell.com, 
 zyjzyj2000@gmail.com, sagi@grimberg.me, mgurtovoy@nvidia.com, 
 haris.iqbal@ionos.com, jinpu.wang@ionos.com, bvanassche@acm.org, 
 kbusch@kernel.org, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, kch@nvidia.com, smfrench@gmail.com, 
 linkinjeon@kernel.org, metze@samba.org, tom@talpey.com, cel@kernel.org, 
 jlayton@kernel.org, neil@brown.name, okorniev@redhat.com, 
 Dai.Ngo@oracle.com, trondmy@kernel.org, anna@kernel.org, 
 achender@kernel.org, davem@davemloft.net, edumazet@google.com, 
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kees@kernel.org, 
 michaelgur@nvidia.com, edwards@nvidia.com, phaddad@nvidia.com, 
 eadavis@qq.com, yishaih@nvidia.com, kalesh-anakkur.purayil@broadcom.com, 
 andriy.shevchenko@linux.intel.com, clm@meta.com, ebadger@purestorage.com, 
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 target-devel@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org, rds-devel@oss.oracle.com, 
 Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20260709055211.2498307-1-ernis@linux.microsoft.com>
References: <20260709055211.2498307-1-ernis@linux.microsoft.com>
Subject: Re: [PATCH v10 rdma-next] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-Id: <178385560887.1568177.15189396813808538811.b4-ty@kernel.org>
Date: Sun, 12 Jul 2026 07:26:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Mailman-Approved-At: Mon, 13 Jul 2026 00:25:23 -0700
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


On Wed, 08 Jul 2026 22:51:29 -0700, Erni Sri Satya Vennela wrote:
> The capability counter fields in struct ib_device_attr are declared
> as signed int, but these values are inherently non-negative. Drivers
> maintain their cached caps as u32 and assign them directly into these
> int fields; if a cap exceeds INT_MAX the implicit narrowing yields a
> negative value visible to the IB core.
> 
> Change the signed int capability fields to u32 to match the
> underlying nature of the data. Also update consumers across the IB
> core, ULPs, NVMe-oF target, RDS, and NFS/RDMA so the new u32 values
> are not forced back through signed int or u8 via min()/min_t() or
> narrowing local variables.
> 
> [...]

Applied, thanks!

[1/1] RDMA: Change capability fields in ib_device_attr from int to u32
      https://git.kernel.org/rdma/rdma/c/eebd08d91ddbd6

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


