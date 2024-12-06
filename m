Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E68E7716E
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 02:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XGTfwcrbpqwINMa/C7mzh2ds2WSzlBHHgehx8xpmfe0=; b=J+zW3IZhw2zioeunOC5vF1X1JD
	5P/apM5ONnZBSgMrHv0qmQuLnb4wujRZJH3YaKl6Nai+zJOecnkZO15lCDmfAKVviKjr8VJ7ETAsW
	0N/PD+PCT6gI5fbxcoq9XUPe4Yz61k+J1IhWS4ufHhBvI0tdM/DH3JdV/m3UbDJnL6+ZfOMeuwc41
	s9r+YlV7lQDaahYoe+AcR/r1KQw9QI+gdgkMZpU8/4KlXnmnQjMJe4cMvJKGGghTkNOdmdiasOED3
	5hyRmrME5W+5+bcSqnnuZJkLYcLWKKCB2pQ505pZOwa3bcN3Od16nwQl/w6pGf/kYBNHKpfuBujZd
	1Dsc32QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJNuw-00000000IzW-0teN;
	Fri, 06 Dec 2024 02:18:06 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJNuu-00000000Iz8-14mH
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 02:18:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 37B75A41AC2;
	Fri,  6 Dec 2024 02:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82697C4CED1;
	Fri,  6 Dec 2024 02:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733451482;
	bh=r87v6RI14MYvQVvrhHKKo5H2rpySP4RbfqYlrBpFKZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j23gqL9NEopbGtSbdZPKivdMJRqAbKO9sZrmDC9Ftd7yGWUZjm7lqHDO+LEwRqY8d
	 ravnVsXVQyLyjxep89kWNPXh6GBbszdLpwXr949hXgA6myo8XkrUh38CEWu3Y0E3yP
	 7VefFhA/L9eD9sJ66hry0eg642xiu0axIFqdVHWLzKa/ja1ZGPaVMuAkHxWMIo3CB/
	 fAo/MnU4QUa0oycKNt2Mayt0BIqPwAOI8FthnQDHJLTdt/uhxBJOTc9zB3E9wQRs2O
	 PcJnm9gXJ2c9Ka0TZKACIgHBjNatA9vsIO4mutBw3MyVnf6t1GyMe3eiD+NdyQFfLC
	 2IYRR7LQK3HRA==
Date: Thu, 5 Dec 2024 18:18:00 -0800
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, sagi@grimberg.me, asml.silence@gmail.com
Subject: Re: [PATCHv11 00/10] block write streams with nvme fdp
Message-ID: <Z1Je2Do8Tj_NYePW@kbusch-mbp.dhcp.thefacebook.com>
References: <20241206015308.3342386-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206015308.3342386-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_181804_434186_D7F4787C 
X-CRM114-Status: GOOD (  19.14  )
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

On Thu, Dec 05, 2024 at 05:52:58PM -0800, Keith Busch wrote:
> Changes from v10:
> 
>  Merged up to block for-6.14/io_uring, which required some
>  new attribute handling.
> 
>  Not mixing write hints usage with write streams. This effectively
>  abandons any attempts to use the existing fcntl API for use with
>  filesystems in this series.
> 
>  Exporting the stream's reclaim unit nominal size.
> 
> Christoph Hellwig (5):
>   fs: add a write stream field to the kiocb
>   block: add a bi_write_stream field
>   block: introduce a write_stream_granularity queue limit
>   block: expose write streams for block device nodes
>   nvme: add a nvme_get_log_lsi helper
> 
> Keith Busch (5):
>   io_uring: protection information enhancements
>   io_uring: add write stream attribute
>   block: introduce max_write_streams queue limit
>   nvme: register fdp queue limits
>   nvme: use fdp streams if write stream is provided

I fucked up the format-patch command by ommitting a single patch. The
following should have been "PATCH 1/11", but I don't want to resend for
just this:

commit 9e40f4a4da6d0cef871d1c5daf55cc0497fd9c39
Author: Keith Busch <kbusch@kernel.org>
Date:   Tue Nov 19 13:16:15 2024 +0100

    fs: add write stream information to statx
    
    Add new statx field to report the maximum number of write streams
    supported and the granularity for them.
    
    Signed-off-by: Keith Busch <kbusch@kernel.org>
    [hch: renamed hints to streams, add granularity]
    Signed-off-by: Christoph Hellwig <hch@lst.de>

diff --git a/fs/stat.c b/fs/stat.c
index 0870e969a8a0b..00e4598b1ff25 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -729,6 +729,8 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_atomic_write_unit_min = stat->atomic_write_unit_min;
 	tmp.stx_atomic_write_unit_max = stat->atomic_write_unit_max;
 	tmp.stx_atomic_write_segments_max = stat->atomic_write_segments_max;
+	tmp.stx_write_stream_granularity = stat->write_stream_granularity;
+	tmp.stx_write_stream_max = stat->write_stream_max;
 
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 3d900c86981c5..36d4dfb291abd 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -57,6 +57,8 @@ struct kstat {
 	u32		atomic_write_unit_min;
 	u32		atomic_write_unit_max;
 	u32		atomic_write_segments_max;
+	u32		write_stream_granularity;
+	u16		write_stream_max;
 };
 
 /* These definitions are internal to the kernel for now. Mainly used by nfsd. */
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 887a252864416..547c62a1a3a7c 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -132,9 +132,11 @@ struct statx {
 	__u32	stx_atomic_write_unit_max;	/* Max atomic write unit in bytes */
 	/* 0xb0 */
 	__u32   stx_atomic_write_segments_max;	/* Max atomic write segment count */
-	__u32   __spare1[1];
+	__u32   stx_write_stream_granularity;
 	/* 0xb8 */
-	__u64	__spare3[9];	/* Spare space for future expansion */
+	__u16   stx_write_stream_max;
+	__u16	__sparse2[3];
+	__u64	__spare3[8];	/* Spare space for future expansion */
 	/* 0x100 */
 };
 
@@ -164,6 +166,7 @@ struct statx {
 #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
 #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
 #define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
+#define STATX_WRITE_STREAM	0x00020000U	/* Want/got write_stream_* */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 

