Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74940C0218F
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2025 05:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PmeBjIffRL0zJ/a26qdx0jVpYYzHUWrXmf4N6s0YxoI=; b=Vm/notW04nU839YLqXFRVRjnsd
	278zwqpyyJ4fTyA34mYfTcSacog35KKDFka5vAIYhiApcQoA+uBE+q0zJ+7i+h9tRU6RWj5WeHLi1
	1tsE22N080fht7p6x3bwlSaZ4Zi3HkrE6c/PrSOhsntWtGGWfjwOTv5jesB0WVl2xzBwIiIEl/xW+
	fCjPFhj0PKjbI48LUunlf5jQkxuSaEHTEf1tkvrvBphVwTmAdWTNMIGSv6Tqp2S8g3sCPqF1BKryU
	oXIRj1J3yaSlpzIi16l1DC1gnKOUo+7amtPdYNlfaM9/RHGl8PX4LaCW1EiXqDeS3Ha12jGGSgn5c
	b3sEdgvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfBIn-0000000HGZ9-40Lk;
	Tue, 04 Feb 2025 05:16:49 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tfBIl-0000000HGYs-3eYO;
	Tue, 04 Feb 2025 05:16:47 +0000
Date: Mon, 3 Feb 2025 21:16:47 -0800
From: "hch@infradead.org" <hch@infradead.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"hch@infradead.org" <hch@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <Z6GivxxFWFZhN7jD@infradead.org>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
 <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
 <cfe11af2-44c5-43a7-9114-72471a615de7@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfe11af2-44c5-43a7-9114-72471a615de7@samsung.com>
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

On Mon, Feb 03, 2025 at 06:57:13PM +0530, Kanchan Joshi wrote:
> But, patches do exactly that i.e., hardware cusm support. And posted 
> numbers [*] are also when hardware is checksumming the data blocks.

I'm still not sure why you think the series implements hardware
csum support.

The buf mode is just a duplicate implementation of the block layer
automatic PI.  The no buf means PRACT which let's the device auto
generate and strip PI.  Especially the latter one (which is the
one that was benchmarked) literally provides no additional protection
over what the device would already do.  It's the "trust me, bro" of
data integrity :)  Which to be fair will work pretty well as devices
that support PI are the creme de la creme of storage devices and
will have very good internal data protection internally.  But the
point of data checksums is to not trust the storage device and
not trust layers between the checksum generation and the storage
device.

IFF using PRACT is an acceptable level of protection just running
NODATASUM and disabling PI generation/verification in the block
layer using the current sysfs attributes (or an in-kernel interface
for that) to force the driver to set PRACT will do exactly the same
thing.


