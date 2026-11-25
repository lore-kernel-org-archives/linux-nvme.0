Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAF0606A321
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 05:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LngHa2dt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jPZjlBfUCICcuHzPRjtVK09Fl7HrWMyo7U5qbFkjo4k=; b=LngHa2dti9jfm6ewm2P5sQ4mCO
	U7RFslD9L+bpK5lPocOv8HuniLxpdaP+0k76iSOGbsC0DojEZWU+0texvI6A7YuiJNWoG3qXliDLo
	ZWqz5/yFyx7rqveNCJLxSZrS2R7Al7BjpCrOWXoE7yW4lCotKKndYPb/hTwog8ajVBSsIDGQHEn0+
	q1gZvSLm/vRuf18VxAdFkCrwpv8rIdnltLxNGjAhY+/danDuDkKdcyH0qRmcoydpqo5oDz9HBt6AU
	AW8DwzRyysyOYQnOg/aKwaMrOiS2sFXbib8A9Xm2c1aE33pN+vGUUI7hEnKzJGChMWHn+x7tsKXJ9
	ygf0bOXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW5Oz-00000008Rsp-0Q5l;
	Wed, 25 Nov 2026 05:18:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW5Of-00000008Rr9-1QSe
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 05:18:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DD3BD68AFE; Wed, 25 Nov 2026 06:18:17 +0100 (CET)
Date: Wed, 25 Nov 2026 06:18:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 2/3] nvme: define the SMART / Health Status async
 event subtypes
Message-ID: <20261125051817.GD20096@lst.de>
References: <20261124120032.1824788-1-kanie@linux.alibaba.com> <20261124120032.1824788-3-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124120032.1824788-3-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_211827_065248_86FA4D1D 
X-CRM114-Status: GOOD (  12.45  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 08:00:31PM +0800, Guixin Liu wrote:
> Add the asynchronous event information values of the SMART / Health
> Status event type (NVMe 2.x, Figure 154) alongside the notice
> subtypes, and the events bit for the temperature warning.

Pleaee split the command set addition in nvme.h from the changes to the
host implementation.  The latter can go directly into the next patch.

