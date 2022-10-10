Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE33DC433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Oct 2022 08:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vo4yDv3ovpdO/ZJVXLeiWCAzgX7idsFmIs0m1o/yZgk=; b=tB+efIKSQdBusw1t778rmaH2xj
	SqpJHhn2VqMrMFBf180TcJZwJSDmc5zuF4P9wNBqyqnYVtHG3T077ehAbF48ePnqAvE2TJtNqHafQ
	WfOYPHB31FA0nB8vM0d4bjwJC++ym67wSawHx7YcRwgFYcwTb47oy/iTcgnBAP0wHc5mATumAD60I
	1c/4Vf33DbfnPcfXA9/FJml2l8Bvfnvnw8raQv6sBYyAhXcsMXPQKw2QDdWQhMcGE+b1eeP5mOnJ8
	QU9/l+LRnvHOK0V4f3M17JW5JbIluNbokJKth30oyRxLgXwz/tD+d27AdG+emZyx3gVwszlxYCfAb
	+06w6xmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oho3n-00HZhR-8g; Mon, 10 Oct 2022 08:22:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohnd5-00HRAd-EQ; Mon, 10 Oct 2022 07:55:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 21BA768AA6; Mon, 10 Oct 2022 09:55:05 +0200 (CEST)
Date: Mon, 10 Oct 2022 09:55:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, axboe@kernel.dk, efremov@linux.com,
	josef@toxicpanda.com, idryomov@gmail.com,
	dongsheng.yang@easystack.cn, haris.iqbal@ionos.com,
	jinpu.wang@ionos.com, mst@redhat.com, jasowang@redhat.com,
	pbonzini@redhat.com, stefanha@redhat.com, ohad@wizery.com,
	andersson@kernel.org, baolin.wang@linux.alibaba.com,
	ulf.hansson@linaro.org, richard@nod.at, miquel.raynal@bootlin.com,
	vigneshr@ti.com, marcan@marcan.st, sven@svenpeter.dev,
	alyssa@rosenzweig.io, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, sth@linux.ibm.com, hoeppner@linux.ibm.com,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, hare@suse.de, bhelgaas@google.com,
	john.garry@huawei.com, christophe.jaillet@wanadoo.fr,
	vaibhavgupta40@gmail.com, wsa+renesas@sang-engineering.com,
	damien.lemoal@opensource.wdc.com, johannes.thumshirn@wdc.com,
	bvanassche@acm.org, ming.lei@redhat.com,
	shinichiro.kawasaki@wdc.com, vincent.fu@samsung.com,
	christoph.boehmwalder@linbit.com, joel@jms.id.au,
	vincent.whitchurch@axis.com, nbd@other.debian.org,
	ceph-devel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, asahi@lists.linux.dev
Subject: Re: [RFC PATCH 00/21] block: add and use init tagset helper
Message-ID: <20221010075504.GA21272@lst.de>
References: <20221005032257.80681-1-kch@nvidia.com> <Y0BvRaVO0iUVmHgB@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0BvRaVO0iUVmHgB@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221010_005515_635165_42FC49EC 
X-CRM114-Status: GOOD (  12.24  )
X-Mailman-Approved-At: Mon, 10 Oct 2022 01:22:45 -0700
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

On Fri, Oct 07, 2022 at 11:26:13AM -0700, Luis Chamberlain wrote:
> *If* there were commonalities at init and these could be broken up into
> common groups, each having their own set of calls, then we simplify and
> can abstract these. I say this without doing a complete review of the
> removals, but if there really isn't much of commonalities I tend to
> agree with Bart that open coding this is better.

The commonality is that there are various required or optional
fields to fill out.  I actually have a WIP series to make the tag_set
dynamically allocated and refcounted to fix some long standing life time
issues.  That creates a new alloc helper that will take a few mandatory
arguments and would heavily clash with this series.

