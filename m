Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF0AC433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Apr 2022 04:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VxCCA1if4MjVywiRC7EnrE+nphBnU8HHnT6e+P2TXkQ=; b=xHw7Z1cII964bzEGVRYCYfVWUn
	Hpb9kog5kuVrVA31IAUz48mcc2R33NwzFI/8jfT9EAUKxR55GmpgQWtnYpKkyNdX0bXfMWfrTdQSz
	MSfJceA++nGnsbyNwwT2lYjbOG08shx9iXM5jXL8LtJ0MazibZLY1CvcXBP9YJqB6g5fJTWzE3yIB
	jVXtI42K+2ViQ2ShU1XHh1LhtQzagHAuWKgmKMMadRUrgj05WkynysnXbNnE0lMRpeZL5gTGQ/pnl
	8DLBbsLAu61mvZH/F0hoQyHmgoeCBLYzzs0XicLaOlXLuNy9oVh0M2hBR5tK3bVSWsBCnnPb7u8VR
	n0ar+aLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nfaPR-00CFE9-QN; Sat, 16 Apr 2022 04:51:45 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nfYBN-00C5Ec-Bt; Sat, 16 Apr 2022 02:29:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2FF20B82E4A;
 Sat, 16 Apr 2022 02:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BEAC385A9;
 Sat, 16 Apr 2022 02:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650076142;
 bh=64fC476XAzTfqTSPn+hnDLb+pMKn+pGg/cu9T2ZYoeo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YR2swQd5bHjAFWTiUHuzi2CBAoBviVOC618ZH6KrZjKGz54+nb14CQuuZA/rg7rT4
 HOUGUM1/um4+uLyDQbz+2PZe7eFGngBlsNfmtF55BEnpI8SeGgAW1TB9RPEF0hZ/gu
 wadS+mRuD6cvw4fVgc6pYN09yVoj6blhm7pLMwx6SJQPqerB95uO3eDsfGVZkI1tAT
 ypjbfbxn7+bT/FWjnusepnTR0gEoGRsC/NgAvlwAmFKhGsjLJGRbec9W3gsrNwS1xO
 /N5W0GD6Xr6BMAFslHSxbnYfv+w/HrqJWAmw3dvOKrGV8WDuaNAVrqQjvW1ASku3np
 CHDdJgFxl65YQ==
Message-ID: <ffa14a07-b8f9-828e-97bc-cf7a2099bab5@kernel.org>
Date: Sat, 16 Apr 2022 10:28:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [f2fs-dev] [PATCH 26/27] block: decouple REQ_OP_SECURE_ERASE from
 REQ_OP_DISCARD
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: jfs-discussion@lists.sourceforge.net, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 dm-devel@redhat.com, target-devel@vger.kernel.org,
 linux-mtd@lists.infradead.org, drbd-dev@lists.linbit.com,
 linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
 linux-scsi@vger.kernel.org, cluster-devel@redhat.com,
 xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org,
 linux-um@lists.infradead.org, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 ceph-devel@vger.kernel.org, Coly Li <colyli@suse.de>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, linux-raid@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-mmc@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org,
 =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>,
 ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 ntfs3@lists.linux.dev, linux-btrfs@vger.kernel.org
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-27-hch@lst.de>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220415045258.199825-27-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220415_192905_642171_2AAF379D 
X-CRM114-Status: UNSURE (   7.31  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Fri, 15 Apr 2022 21:51:41 -0700
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

On 2022/4/15 12:52, Christoph Hellwig wrote:
> Secure erase is a very different operation from discard in that it is
> a data integrity operation vs hint.  Fully split the limits and helper
> infrastructure to make the separation more clear.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com> [drbd]
> Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com> [nifs2]
> Acked-by: Jaegeuk Kim <jaegeuk@kernel.org> [f2fs]
> Acked-by: Coly Li <colyli@suse.de> [bcache]
> Acked-by: David Sterba <dsterba@suse.com> [btrfs]

For f2fs part,

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

