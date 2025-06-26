Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027DBC77B7F
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Jun 2025 05:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UBEwDnMJN22bLP+dxVTjMxFY0sw7JGYkn/6mgVsH9Ro=; b=Z1eJq8bd/9ZpJIi+IepX29FueH
	CQ10DiC+AMjnmEAamPCYUm7zOtYAXLhrwce6DjyKvOlFLrlgjQt5qxPPpYA8Q7e8uvUinfRliXNVl
	8O/EHVtNSDtp6CLEE5z2ita/5+B7QePpLeO2vbmBg9sGawvPmAITpqpYTR2jOx5EBKUMxjC/+A6GT
	ZmllZahlQ5CtvsTXPc0aKUueJHW5241i68tiS4qtirCZe5HA8BfUvoqZT35and4VOzfx+j6FRvs14
	SXni5L5JqDOwChC5qU1boLmDn4BWQUdV2zUzhSGfk/FAwQacue57wJch5dIayPe6fU7pp4Pu0NILp
	fiur8VrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUf48-0000000AdaJ-2G1e;
	Thu, 26 Jun 2025 05:22:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUf46-0000000AdZz-0aB7
	for linux-nvme@lists.infradead.org;
	Thu, 26 Jun 2025 05:22:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8DC8168B05; Thu, 26 Jun 2025 07:22:19 +0200 (CEST)
Date: Thu, 26 Jun 2025 07:22:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: alan.adamson@oracle.com
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: fix atomic limits check v2
Message-ID: <20250626052219.GA23726@lst.de>
References: <20250625064003.436582-1-hch@lst.de> <69e9b54f-c3c7-45c3-b4aa-4dbb9df64976@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69e9b54f-c3c7-45c3-b4aa-4dbb9df64976@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_222226_323043_B93DE807 
X-CRM114-Status: GOOD (  10.86  )
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

On Wed, Jun 25, 2025 at 10:04:55AM -0700, alan.adamson@oracle.com wrote:
> [root@localhost ~]# nvme id-ns /dev/nvme0n2 | grep nawupf
> nawupf  : 15
> [root@localhost ~]# cat /sys/block/nvme0n2/queue/atomic_write_max_bytes
> 8192
> [root@localhost ~]# nvme id-ns /dev/nvme0n3 | grep nawupf
> nawupf  : 63
> [root@localhost ~]# cat /sys/block/nvme0n3/queue/atomic_write_max_bytes
> 32768
> [root@localhost ~]# dmesg | grep nvme | grep AWUPF
> [    2.761599] nvme nvme2: inconsistent AWUPF, controller not added (7/15).
> [    2.765669] nvme nvme1: inconsistent AWUPF, controller not added (31/15).
> [root@localhost ~]#
>
> Why was CTRL1 (nvme1) not added? AWUPF of 31 works with a 
> atomic_write_max_bytes of 8192.

Because it reports different AWUPF for controllers in the same subsystem.


