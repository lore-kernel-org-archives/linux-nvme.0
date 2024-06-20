Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF107C2BA1A
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jun 2024 06:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D7fgINTFh0G5Ijqrinqt2AsVVcjhW7C8yTCIx+X7yBw=; b=foVxZbxlszwGuRL1HGstZxA/Tw
	Und+seyqs/Vj8Hnn8c3UbQhKRtImOb0/2ijRx+de9J6G+1xDurZh6x1IlSKsGIY2IkAyAE72unJYO
	e2434J34t7f8T8wijyySJlCtUeHPze0aOVnKTux1Z3+bBFmhp6joxgSJN4Zv1wF9M8XFcdeosjYS5
	UbIGiERAUZKJ2YkteTe+aDH7gaR8G8PsZ/afntlH0jeSUeUNqo6chNfeEvsTxDedIRsyiiic6clS5
	bgLnZqP4G5DbE+OMGCSiYZXwJQuhpv8a0YWvLdBC+boBHnDN6iyhPRNBm2URTqGSXa+6a4eVrL20m
	4WXl3paw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKXrh-00000007zAa-2rz4;
	Fri, 21 Jun 2024 06:35:17 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKNjV-00000006VRj-3SvZ
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jun 2024 19:46:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B5FFE62234;
	Thu, 20 Jun 2024 19:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C76FC2BD10;
	Thu, 20 Jun 2024 19:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718912768;
	bh=kMxWNABFITruZw+TUT+s054RLNenCGCKbp9bHivL/B8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EMsWWz6mmR4aR426mOwSJxZM5BkplVD6O6Y1Ze4cOA5gwtHhAXvPMTol9dAiFKn9D
	 5gOTo4hDvm2DXlnDGMvSjzz05Aj3kLdFYbRm5iPAUYVXYqMoqwUfNg1jUusILc+FHA
	 dIWaQtKsiTPy/AU5LZx/rsQzK7g7IavkLhftxgjIx3cZCRrO2/lM/9kqU8of2BmuwU
	 vwZyjS5mgn+7hl1L2Ixu5x1vFSPXbJsHGzgD+uAH7/ycqMqZpXWU20JkG4FVB/Izt6
	 zWwYiFlZ9qHGHk5yuRgSeoEX/ljehr2wNVy6Sib65ImiOem5a74PoDoHGBAew5MCRY
	 IguOii3yzi4Sw==
Date: Thu, 20 Jun 2024 13:46:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
	djwong@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com, willy@infradead.org, agk@redhat.com,
	snitzer@kernel.org, mpatocka@redhat.com, dm-devel@lists.linux.dev,
	hare@suse.de, Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [Patch v9 06/10] block: Add atomic write support for statx
Message-ID: <ZnSG_G9PGSUeQ78-@kbusch-mbp.dhcp.thefacebook.com>
References: <20240620125359.2684798-1-john.g.garry@oracle.com>
 <20240620125359.2684798-7-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620125359.2684798-7-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_124609_946452_5DD052AB 
X-CRM114-Status: UNSURE (   7.18  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Thu, 20 Jun 2024 23:35:15 -0700
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

On Thu, Jun 20, 2024 at 12:53:55PM +0000, John Garry wrote:
> From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
> 
> Extend statx system call to return additional info for atomic write support
> support if the specified file is a block device.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

