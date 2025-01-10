Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF18FE7719D
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2025 10:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lBmlYAbRZpBSO1SA8djWioiDu4AX+1qy47FudLLk6j0=; b=wRhiuSU5NWxCUPcM9yQ9Eynt7e
	uNlUpnZcLd7TthgDKj4aNadPT0ta25ElEMppg4GZ2+TCfvHuNHNMJSLJKFzqo4+6Xgva9ge7PuRfS
	CdPS7MlzUqK4yKl088EFfKdjASRs0FHcMh/cb6xk4ClfK4FxdoAi9kKclA0NeKZpQFLYVVydCU7t+
	40jmzf4Y5b+9IhAQwXWDEC+DPlQREaIuh9xng/OAY6CMMISNM/O5B0nN0CMVKimVXI46LbuPiizHk
	c//RW4wmtoa3hJQjx0fC0BzChY3WItAvxTORGg1cbKfVK6TuBynknnBRCF0MeyAj5oIKx/SEJPqc4
	3fh2EuHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWBoS-0000000Eqta-2Ksq;
	Fri, 10 Jan 2025 10:00:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWBkO-0000000Eq9O-2BPM
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jan 2025 09:56:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 32AEA68BFE; Fri, 10 Jan 2025 10:56:01 +0100 (CET)
Date: Fri, 10 Jan 2025 10:56:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 05/11] block: add a store_limit operations for sysfs
 entries
Message-ID: <20250110095601.GA11121@lst.de>
References: <20250110054726.1499538-1-hch@lst.de> <20250110054726.1499538-6-hch@lst.de> <e7177a33-aebd-4828-87b0-f790b4fb1306@oracle.com> <20250110091859.GA8373@lst.de> <68cd5371-f4ca-44c0-8ac7-c734da04f877@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68cd5371-f4ca-44c0-8ac7-c734da04f877@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_015608_699562_EACE6AFA 
X-CRM114-Status: GOOD (  17.38  )
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

On Fri, Jan 10, 2025 at 09:51:18AM +0000, John Garry wrote:
> ok, and that just comes down to the behavior of queue_var_store(), which 
> mimics sysfs_ops.store
>
> I will note that queue_var_store and queue_var_store64 differ in behaviour 
> here :(
>
>> ->store_limits uses
>> the simpler and harder to get wrong convention of returning 0 on
>> success.
>>
>
> understood, so any reason why not to change the rest (apart from being 
> busy)?

Not real urge.  The idea here was to get it right for the new one.
Changing the existing would be a lot of churn for a relatively small
improvement.  For me that's only worth it when touching the area anyway.
Which might or might not happen when trying to remove the sysfs_lock
around ->store.


