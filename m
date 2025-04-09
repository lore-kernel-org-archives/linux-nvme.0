Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA54C36002
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 10:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=2o3zKeNsXlTz1vZS7/ZTdyoEHS
	osUDt0sKzegr+0z16TDdrF862VJlXdcrs27zvKwPJWGT2/4nyf7G69J+wVkwImz5U5RHk8qVjjZ8z
	27g/L7m1jehTSd/lF/rCa0TXSVG8znWC6/xs5sEJz8moc1fptDFSOZGi0Tm0JWxaD5xiMevyx5fyD
	RrLyQtGTfl6aTD0+u1u4MTYzUlWOoL/X9YMfe6KBXjuqqWZhGQIoHr+kNy8XQBX/C2qyYfnhJ1C1c
	WPEqs/dfINyh4b8+gby4AIUi5t6+J+2z7IZqIU1N341t127WfcIsY45WO9THa1FXjIY+t2Rg9wifg
	ukS6M8Yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2SnP-00000006rJS-2mfE;
	Wed, 09 Apr 2025 10:36:39 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2SnO-00000006rIu-1luG
	for linux-nvme@bombadil.infradead.org;
	Wed, 09 Apr 2025 10:36:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=DYQe0mgn0FL6nc5251mQdxBL3E
	2Ud0V+XJfKyIjz3QblGarW17XisUo+XB5lRHqvFmpMIaB3VlUgG9EWQO9/jCjE4xpMnw9KSv6oNo5
	ry+YyeHTIPj5IMRdhaVN3GnoGr4FeagCfzg6Xu7pVH2oYN1wHl0CztB5L6B02+PhO/VU3aCSq6dKD
	X7y8bpNFhLpw+f1X4WndbKZG15yz57z+vqUJiLlyGqndBsbet/l4tRi/k1bc41kqa7DlBwBbjshWM
	GZh7RvBp6MQWSsiSuwykAiFzeEj0Ngjv07HY8xOixudAwcmOVMINCmn9ojJNi/vhKmP1Tyiz45pBc
	dlTTrcVQ==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u2SnL-00000008aiR-1Joi
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 10:36:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6283A68BFE; Wed,  9 Apr 2025 12:36:29 +0200 (CEST)
Date: Wed, 9 Apr 2025 12:36:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
	tytso@mit.edu, djwong@kernel.org, john.g.garry@oracle.com,
	bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH -next v3 09/10] block: factor out common part in
 blkdev_fallocate()
Message-ID: <20250409103629.GD4950@lst.de>
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com> <20250318073545.3518707-10-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318073545.3518707-10-yi.zhang@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_113635_512925_9967A5D5 
X-CRM114-Status: UNSURE (   8.53  )
X-CRM114-Notice: Please train this message.
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


