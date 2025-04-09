Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4741AC369A1
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 10:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mNVdKdqz5PjELp/RsC6Jm+yqoduIQQwv5wdg1Sv/sJs=; b=TQdeDwh/vYfqybrlW/1OekTkK/
	xZ91uxWQcU8QBQqRiW9lGTzErkxDtXMt7sFPmMGR7+Ri2ioEx0xwziOLICzAjqKJH30NGB3ZwBRXh
	tKmVt9DQjgLL2p3M0DLVwnDOMOzvIkWm++dkTyHeZ7p7ZhexOUij3mdgRBvYCYUFff2rYA8M6X+NJ
	Bn2/if4z9pK89nNaFMxQCrymh+m6p0teQ//HFSHBbhbKbfj4n3kIB+1IN25kWtwEqr8o3e9QHAUbB
	9B5tjR7SfDU0DDChsQ5ZyQ93wB9z8CHuZj08zm3NHIoI12mXzZdlv4LGT56hIsU5bxw0IsKI4+LiX
	4LcnIyUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2T1H-00000006tof-0DdO;
	Wed, 09 Apr 2025 10:50:59 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2T1F-00000006toK-3rX9
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 10:50:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id ABC0168432;
	Wed,  9 Apr 2025 10:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AD3C4CEE3;
	Wed,  9 Apr 2025 10:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744195857;
	bh=HlVtWoj3LWyiBcoZxrPmX0QXi/NYax4CcC6lrawTBbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fSJhimxHin3y/ZB3Pleu3u8j+qCxOs5pQ/MD8yAXnWGAwLdK53UFp1b313UBRUubo
	 dL6+a1zQv8pgmZj8HjD2a1G+jcTbYICqmdN1rV9kVlwdEwoAfu+XD8HbiXXKHEYk+B
	 4386xVetZP27Cza1J3J/vATMiaisNlGll5kax3pkPKkd8gCed0PhzE/7ZfhKKZeJUQ
	 CFLn82aDMJg+Mlt9MnoiFh3Dtc79YiLEknPFI7TvLjmg6i9TGfX+UHYAPu/m0G4P90
	 Oma/Fv0wwv8+DxDOQqxtpBVaUGyOykCwkf55QGjoukB+JbQ+iKkPNJ5IxCldgWyW/6
	 PxmDAhNKr3RXg==
Date: Wed, 9 Apr 2025 12:50:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, djwong@kernel.org, john.g.garry@oracle.com, 
	bmarzins@redhat.com, chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com, 
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [RFC PATCH -next v3 07/10] fs: introduce FALLOC_FL_WRITE_ZEROES
 to fallocate
Message-ID: <20250409-ausdauer-weingut-4025b274ee63@brauner>
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
 <20250318073545.3518707-8-yi.zhang@huaweicloud.com>
 <20250409103548.GC4950@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250409103548.GC4950@lst.de>
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

On Wed, Apr 09, 2025 at 12:35:48PM +0200, Christoph Hellwig wrote:
> On Tue, Mar 18, 2025 at 03:35:42PM +0800, Zhang Yi wrote:
> > Users can check the disk support of unmap write zeroes command by
> > querying:
> > 
> >     /sys/block/<disk>/queue/write_zeroes_unmap
> 
> No, that is not in any way a good user interface.  Users need to be
> able to query this on a per-file basis.

Agreed. This should get a statx attribute most likely.

