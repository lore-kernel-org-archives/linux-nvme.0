Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D937FC46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 09:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=diuzq7XDJo9rA9QZeucr2hpnMpEwvjn+lraKRormS4s=; b=c+dlXqs2fW9K9mvq7HekeoTpyd
	pLNnuNNUw2YfNVsJ9k4WugbWcn5wA3nnQVp7J4uaeiabNVPYabzsWsBwoe2IuS946lLQ/6mAHxu5r
	LZtXa3oQdKPlr92y3IbHdGgXvNHHbggcZIF2Y5eTgS1a3q5UEdm0hfszUbaa0D71lp8M6db5YE8/X
	LBkNVvieberQbIfUIjMPnlabjusz70xhXs7PI/bZFYX4jxkzNjM7QmAbPLJnmVAdz7F5JiW9sYG8z
	dxIaBWO66Yxr+S7Iot0AfMX97eVW6LRfjIpmlPG9FaRP4OJ4/bzD5LvRILb7Q+56U3FWZSDB6J+Ma
	IVU8dj3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZwB-002M0f-2P;
	Wed, 24 Jan 2024 09:52:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZw9-002Lz8-2C
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 09:52:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DC2BF68AFE; Wed, 24 Jan 2024 10:52:45 +0100 (CET)
Date: Wed, 24 Jan 2024 10:52:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: nvme-pci timeout issue
Message-ID: <20240124095245.GA31389@lst.de>
References: <287b9ed9-6eb3-46d0-a6f0-a9d283245b90@nvidia.com> <094bf7ce-b5da-4325-93ab-fef6b76671a6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <094bf7ce-b5da-4325-93ab-fef6b76671a6@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_015249_858920_94288227 
X-CRM114-Status: GOOD (  11.04  )
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

On Tue, Jan 23, 2024 at 10:19:28PM +0000, Chaitanya Kulkarni wrote:
> Can someone please provide an insight on this behavior so we can merge 
> testcase into blktests? Please note that Shinichiro also observed the 
> same behavior.

Can you provide the test case?


