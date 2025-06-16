Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A61C71136
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 15:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=heypJz8S/hU8da7rGPoy4ryfx/J5cUwqn9IJlGlTcMU=; b=SviFzNP9qLK8m8aL29gTKqrpUR
	ks3eYg7RkoxXFoJ17YKYhTxgk8pM26f7qVq017h1/UeUsaEiJZb/eo6kqhxUZlfei4gsUC6o/ihtJ
	9qOuGQnwhl9eDRzosapQFyqLRfzSl4/eu59yGaDNIxIuGphC6FlHwMCKLh64g63042TxR6AymPlIi
	TWJaTdiyvsoZq/zedLzYqDalBT6qaqKtEJ6rVtPFL2v4ma/5XKTymqzj2fgtdt66lxUzwZ0sunJIx
	U6S5jpZLu/lYO6vTbAGHGxEWUC9IITGXa+rO/Jz46XHAdBbUMEqy9RAxBMaUZcYNSBTLXOAEHTsi3
	a/04S9oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRBka-00000004rh7-2S2D;
	Mon, 16 Jun 2025 15:27:56 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRAnr-00000004heu-2Pqb
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 14:27:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C7FBD5C62D3;
	Mon, 16 Jun 2025 14:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3D8C4CEEA;
	Mon, 16 Jun 2025 14:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750084034;
	bh=27LBzjkFKC0MWbPlUQj6Tt4KZ0Jk3l3sGSDRRlvA7Qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NTVakR5SXYu6c0BR4in/xtNji5OdDLRcOb+1S6kRPnlTkxHPWFuXHEYB2XKVOnV5V
	 XKW8fuD7PUAxa0hc9pOLobc3bi0uPxw+HNln+mqm/IAkPNktMrm+/b1hQwe4msPHOt
	 /RBrG+An7Q7/xCH/oFBha8sLE7asffKwinvo7s0gsMMJkwqWOFFVu1jWoUz0qVEXqh
	 8nYbEvxVezT7bLn6rjAKCURMMss27siUxZLadBGHlsr1LHHNUVo8hPE4huYEBXn5E5
	 fAacJRg0Mlzep6Qt2V5d4o+LEnwopKyEIQ5mGnZXFdLg6Twux+PSTbq1SyQ5q+r4bW
	 c85QZmNSdOsqg==
Date: Mon, 16 Jun 2025 16:27:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, hch@lst.de, tytso@mit.edu, djwong@kernel.org, 
	john.g.garry@oracle.com, bmarzins@redhat.com, chaitanyak@nvidia.com, 
	shinichiro.kawasaki@wdc.com, yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH 00/10] fallocate: introduce FALLOC_FL_WRITE_ZEROES flag
Message-ID: <20250616-wasser-replizieren-c47bcfaa418a@brauner>
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
 <yq17c1k74jd.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <yq17c1k74jd.fsf@ca-mkp.ca.oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_072715_652787_A6AEE5EC 
X-CRM114-Status: GOOD (  12.75  )
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

On Mon, Jun 09, 2025 at 09:47:13PM -0400, Martin K. Petersen wrote:
> 
> Zhang,
> 
> > Changes since RFC v4:
> >  - Rebase codes on 6.16-rc1.
> >  - Add a new queue_limit flag, and change the write_zeroes_unmap sysfs
> >    interface to RW mode. User can disable the unmap write zeroes
> >    operation by writing '0' to it when the operation is slow.
> >  - Modify the documentation of write_zeroes_unmap sysfs interface as
> >    Martin suggested.
> >  - Remove the statx interface.
> >  - Make the bdev and ext4 don't allow to submit FALLOC_FL_WRITE_ZEROES
> >    if the block device does not enable the unmap write zeroes operation,
> >    it should return -EOPNOTSUPP.
> 
> This looks OK to me as long as the fs folks agree on the fallocate()
> semantics.

That looks overall fine. Should I queue this up in the vfs tree?

