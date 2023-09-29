Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8A4E77347
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Sep 2023 22:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KAwIiP82CTT8ssqwInBeFz+VGFATtc1QtMI4c1kdYto=; b=y4+MbtVhOjpLc15SwP7QK/Yjq0
	Zd1hpX6UkVQTlgg7+1J/e1Hl+EGuj1c06Upg5vhCBY47HHMibojvNbEJevmtV780fPiXoTQES6zrC
	/wBmixxvYnAEjXfQHEVodKKML5zWqKQRX8LE/WWXW5SYCPVvmBCXIRYO86c6Dn++doJPSdR7FYwLp
	KfqPCovR0XRVnnThvs0+jNyQuO8jAlPbHsjhwAwwWK2rReVOQpIjkSQDwCWe7/mo+KvwdmBWZvAsr
	JpaU4M6KM9h5meJgFt7bAqSk+Shq4pq5BTkTUOYqnakZMPeVWa7RIdD+X50WTmV7VQSqpX5xHP04t
	4QGM1oWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qmMIe-008fQt-1J;
	Fri, 29 Sep 2023 22:49:32 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qmMIa-008fPb-2A
	for linux-nvme@lists.infradead.org;
	Fri, 29 Sep 2023 22:49:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E771ACE24ED;
	Fri, 29 Sep 2023 22:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57E9C433C8;
	Fri, 29 Sep 2023 22:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696027764;
	bh=Ufhqxo3yas1XlwZ8/C+WysTlrYXwdeYXTChlz66gL/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqmEBvELKiKJrPdmj27E6wWm3wbgoGhbztCnJy3K8fbCsufv51Lo9qUuXj8sTFb4C
	 zU3wRai4oALXDco5xkF66XgYStzG6E7Va5LNHKv2nVFCtNMduKicVQ7BzAu6Gg3pLo
	 DyVc3WaIDXXS3CqCCT0fschckPSyFzmlt/dbLDBIpO+CvPw8eAtrVBCEpTUG6UJ+bE
	 sM6pS/HdnnAFfJXBhYTF3VU7HubdFFtuXEKr8TIhEZZpMR0qJOHhOjaM14WcTCkW8u
	 3/kp7PQcfopDGxKohL2jgFUOHFzUYt/CpLGVJQYxOo+j5L/uayzxWPWpO76hsI2ut3
	 Ym9Y7/TXMwICw==
Date: Fri, 29 Sep 2023 22:49:22 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org,
	Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH 03/21] fs/bdev: Add atomic write support info to statx
Message-ID: <20230929224922.GB11839@google.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-4-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929102726.2985188-4-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230929_154928_904134_2A758B3A 
X-CRM114-Status: GOOD (  12.53  )
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

On Fri, Sep 29, 2023 at 10:27:08AM +0000, John Garry wrote:
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 7cab2c65d3d7..c99d7cac2aa6 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -127,7 +127,10 @@ struct statx {
>  	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
>  	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
>  	/* 0xa0 */
> -	__u64	__spare3[12];	/* Spare space for future expansion */
> +	__u32	stx_atomic_write_unit_max;
> +	__u32	stx_atomic_write_unit_min;

Maybe min first and then max?  That seems a bit more natural, and a lot of the
code you've written handle them in that order.

> +#define STATX_ATTR_WRITE_ATOMIC		0x00400000 /* File supports atomic write operations */

How would this differ from stx_atomic_write_unit_min != 0?

- Eric

