Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E873C4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Nov 2023 15:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LZgXuVKNcQ+GuFKZzEEfTOvd82OtwUqJOxP7xWbm0rs=; b=eoFfjK8IbXV+KKPRp6JjzW/IVp
	ozFapuQWN9HrxWzj4e60vs+aoxQuGM/XCbxzNxOIUXZZFttZDb5sgTzJzh/Xjc5secJsQYeq39P9Y
	O8WfJXOwoVX/GPFbIyfDHizC4K7Agq5aEv05/yxqCfKe4/7T8j9EIC8Vo3mTDAGCI2rFhbTIlqe9E
	/lDE6byMxiV+/iN/m69++OI+W5q8OZNI9jH6Q4zD490mS7GDg6g0VVnSEtCkJyf9iqYJJL0Fb7Ao3
	YzTs3jnYAlBj+tItkX1qTxCOm2g+3sJ1iEhQkW5osYfijI2ZImSftsnY92DeflP+cU7l9QFLu0PYv
	SUeMLIyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r16fv-006YCc-07;
	Thu, 09 Nov 2023 15:10:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r16fs-006Y9n-0m
	for linux-nvme@lists.infradead.org;
	Thu, 09 Nov 2023 15:10:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3068167373; Thu,  9 Nov 2023 16:10:14 +0100 (CET)
Date: Thu, 9 Nov 2023 16:10:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org,
	Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH 01/21] block: Add atomic write operations to
 request_queue limits
Message-ID: <20231109151013.GA32432@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-2-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230929102726.2985188-2-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231109_071028_442202_ADAEFEDC 
X-CRM114-Status: GOOD (  22.18  )
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

On Fri, Sep 29, 2023 at 10:27:06AM +0000, John Garry wrote:
> From: Himanshu Madhani <himanshu.madhani@oracle.com>
> 
> Add the following limits:
> - atomic_write_boundary_bytes
> - atomic_write_max_bytes
> - atomic_write_unit_max_bytes
> - atomic_write_unit_min_bytes
> 
> All atomic writes limits are initialised to 0 to indicate no atomic write
> support. Stacked devices are just not supported either for now.
> 
> Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> #jpg: Heavy rewrite
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  Documentation/ABI/stable/sysfs-block | 42 +++++++++++++++++++
>  block/blk-settings.c                 | 60 ++++++++++++++++++++++++++++
>  block/blk-sysfs.c                    | 33 +++++++++++++++
>  include/linux/blkdev.h               | 33 +++++++++++++++
>  4 files changed, 168 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index 1fe9a553c37b..05df7f74cbc1 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -21,6 +21,48 @@ Description:
>  		device is offset from the internal allocation unit's
>  		natural alignment.
>  
> +What:		/sys/block/<disk>/atomic_write_max_bytes
> +Date:		May 2023
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] This parameter specifies the maximum atomic write
> +		size reported by the device. An atomic write operation
> +		must not exceed this number of bytes.

> +What:		/sys/block/<disk>/atomic_write_unit_max_bytes
> +Date:		January 2023
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] This parameter defines the largest block which can be
> +		written atomically with an atomic write operation. This
> +		value must be a multiple of atomic_write_unit_min and must
> +		be a power-of-two.

What is the difference between these two values?


> +Date:		May 2023
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] This parameter specifies the smallest block which can
> +		be written atomically with an atomic write operation. All
> +		atomic write operations must begin at a
> +		atomic_write_unit_min boundary and must be multiples of
> +		atomic_write_unit_min. This value must be a power-of-two.

How can the minimum unit be anythіng but one logical block?

> +extern void blk_queue_atomic_write_max_bytes(struct request_queue *q,
> +					     unsigned int bytes);

Please don't add pointless externs to prototypes in headers.

> +static inline unsigned int queue_atomic_write_unit_max_bytes(const struct request_queue *q)

.. and please avoid the overly long lines.


