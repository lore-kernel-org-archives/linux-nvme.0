Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F65C6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 17:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2DVDjn14jcmXI06omFunOWKNfCuEsxTlBPssx+oZvkM=; b=pt7hV/xqoUsm5t2nnvzWrzJaaT
	IkcoSkDgo4vPWd2QWla4LFFed4B7dd53Bfh3zR6FKSUZ7SMy4sRzHwCFQMhjVwsjoGZXOJ3iFI7yT
	cr6D9nfh58d4QpIhkuWElhgFyez4IgPFwwuzUDnqlapxAAE+psJwBZmjol9WPnC1bKV39/YzLI431
	TwEPgDj9smkBF7JVdVyriwj0T6yffdaR+qk+SDuf315MGFPFNEhxS5hGBmiaojglgVxSEd/0oU2GU
	i3PLQGyCWB9RTN4Q6CZYQ3NJbSqLuR0lZpgUu0iwdyZeIoQm2uXXc/DL1NOEmeeteMwCsbDrM9tWJ
	iOKnaMkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpAL6-00000005fNq-1Lnj;
	Tue, 26 Mar 2024 17:11:56 +0000
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpAL2-00000005fKX-32AV;
	Tue, 26 Mar 2024 17:11:52 +0000
Message-ID: <0a9fb564-7129-4153-97d6-76e9b3a1b6c1@infradead.org>
Date: Tue, 26 Mar 2024 10:11:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/10] block: Add core atomic write support
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
 martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, dchinner@redhat.com, jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
 ojaswin@linux.ibm.com, linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
 io-uring@vger.kernel.org, nilay@linux.ibm.com, ritesh.list@gmail.com,
 willy@infradead.org, Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20240326133813.3224593-1-john.g.garry@oracle.com>
 <20240326133813.3224593-6-john.g.garry@oracle.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240326133813.3224593-6-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi,

On 3/26/24 06:38, John Garry wrote:
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index 1fe9a553c37b..4c775f4bdefe 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -21,6 +21,58 @@ Description:
>  		device is offset from the internal allocation unit's
>  		natural alignment.
>  
> +What:		/sys/block/<disk>/atomic_write_max_bytes
> +Date:		February 2024
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] This parameter specifies the maximum atomic write
> +		size reported by the device. This parameter is relevant
> +		for merging of writes, where a merged atomic write
> +		operation must not exceed this number of bytes.
> +		This parameter may be greater to the value in

		                              than

> +		atomic_write_unit_max_bytes as
> +		atomic_write_unit_max_bytes will be rounded down to a
> +		power-of-two and atomic_write_unit_max_bytes may also be
> +		limited by some other queue limits, such as max_segments.
> +		This parameter - along with atomic_write_unit_min_bytes
> +		and atomic_write_unit_max_bytes - will not be larger than
> +		max_hw_sectors_kb, but may be larger than max_sectors_kb.
> +
> +
> +What:		/sys/block/<disk>/atomic_write_unit_min_bytes
> +Date:		February 2024
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] This parameter specifies the smallest block which can
> +		be written atomically with an atomic write operation. All
> +		atomic write operations must begin at a
> +		atomic_write_unit_min boundary and must be multiples of
> +		atomic_write_unit_min. This value must be a power-of-two.
> +
> +
> +What:		/sys/block/<disk>/atomic_write_unit_max_bytes
> +Date:		February 2024
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] This parameter defines the largest block which can be
> +		written atomically with an atomic write operation. This
> +		value must be a multiple of atomic_write_unit_min and must
> +		be a power-of-two. This value will not be larger than
> +		atomic_write_max_bytes.
> +
> +
> +What:		/sys/block/<disk>/atomic_write_boundary_bytes
> +Date:		February 2024
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] A device may need to internally split I/Os which
> +		straddle a given logical block address boundary. In that
> +		case a single atomic write operation will be processed as
> +		one of more sub-operations which each complete atomically.

		    or

> +		This parameter specifies the size in bytes of the atomic
> +		boundary if one is reported by the device. This value must
> +		be a power-of-two.

-- 
#Randy

