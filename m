Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0ECC4167D
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 13:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SXfH8Llt0jxmPv2myg0rD8VmQvDP6rhPvEfTH/AwkCE=; b=q7i6wO6vO6ceblpFr3tJyE+DFL
	YSbbj1WKkrFr5bjtGTDULQlY9XV1f8BOK4drPCK4T698lTOF+v4AOKmw8R8fIpqLYR8VAW9VpL2ds
	jI4AIkO22PZ/2KsB1YEhhEk5XMfq8dZERbj58WtKQPwPjCJ6UIEVPAshDmJH477vGcaR8hIZ2N+p8
	DgKeYT/oLZlH5uPU3hkQlHBjYt4naGSQnBWP52Qeu6893V+kiqsKtnZ4bsSyVjsEhmHOBzp3azdNr
	jXUnVqLl63BMsO0PfeyH7jydp7XNVTP2zPIZUrdompM4y2Hf66v/ja7ZOs3b9Bz0ULIFDlaYlLt3l
	Bvk8GOwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPL3-00Eopd-2B;
	Wed, 13 Dec 2023 13:31:49 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPL0-00EonA-0r
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 13:31:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SXfH8Llt0jxmPv2myg0rD8VmQvDP6rhPvEfTH/AwkCE=; b=YTgQ262hq3ggMN7vyDDIz8Eqtu
	ikkWyXyLiN2Uhbg+PRQ+hN11PbOPCm+x3g4mCaGBn7A9NVYOXrAzzL8jZ4agYKKkqMzp9dae1YolE
	TBFLyY7o2DtammUpBSJY+o9yAx6QKcNZ3SaImPXjDOEEAu6dDTiiP10Y5J129WNNV39iJq7eb8zmT
	6Kx7l1fE5YiVAwxiL+Yp09DvTvuXIlMwdrwgMhc9dNtGyi+54Hj6n4n+PSHn6JEnW1XRMofwxMeRO
	BKywIExN6rudbNMrUmDUucuOF/XIXS4LKB08O4YFByoC/fIzP3LSrGPtQ/VaJkS5CWV5VD0CrVboW
	2Cgyl4Xg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPKQ-00BmIC-0J;
	Wed, 13 Dec 2023 13:31:10 +0000
Date: Wed, 13 Dec 2023 13:31:10 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ming.lei@redhat.com,
	jaswin@linux.ibm.com, bvanassche@acm.org,
	Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH v2 05/16] fs: Add RWF_ATOMIC and IOCB_ATOMIC flags for
 atomic write support
Message-ID: <20231213133110.GL1674809@ZenIV>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212110844.19698-6-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212110844.19698-6-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_053146_302395_84A2232B 
X-CRM114-Status: GOOD (  15.27  )
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

On Tue, Dec 12, 2023 at 11:08:33AM +0000, John Garry wrote:

> Add file mode flag FMODE_CAN_ATOMIC_WRITE, so files which do not have the
> flag set will have RWF_ATOMIC rejected and not just ignored.
> 
> Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  include/linux/fs.h      | 8 ++++++++
>  include/uapi/linux/fs.h | 5 ++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 70329c81be31..d725c194243c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -185,6 +185,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>  /* File supports async nowait buffered writes */
>  #define FMODE_BUF_WASYNC	((__force fmode_t)0x80000000)
>  
> +/* File supports atomic writes */
> +#define FMODE_CAN_ATOMIC_WRITE	((__force fmode_t)0x100000000)

Have you even tried to compile that on e.g. arm?

