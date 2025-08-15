Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7C3CA0ED1
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Aug 2025 16:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oSvoNOK/pZF/R+iqZIRykbA4dhfR0pPJSufe2H8Am44=; b=swsIbZ/QsG4Kd2cOFS2420sYn8
	AMo5EOyw337m2WdTyj5OCkxb3Mmt9GRYvMLqrmV8YQEX9hQAskxq8/DZBWQ6yVLQ5dLFrw2dqC0qk
	S95Jb3GJ/Xwox6LMza+ezrj8O+twYwVqGJrl0jAINCK84OlJk4qUEl7k5YW7fid0bYi9WO2/jxiKS
	62KLhFDBxJDUIGgUrp5yQ8dJ28hLadQ7y65zSgpKapfK+FuOj+bYZvIjDN5VI6raVHAEPGNH6aND2
	viV+q+y6H4msvmQip/86ieDL1N17buVgJ8SOqo9hY4m9Sz3vTXJgYQpIw8wdY3hDM5FiTB6afDEJR
	xftjZr/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umx47-00000002wVU-29kx;
	Fri, 15 Aug 2025 16:14:03 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umvQc-00000002iWD-2pQw
	for linux-nvme@lists.infradead.org;
	Fri, 15 Aug 2025 14:29:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 160925C66FF;
	Fri, 15 Aug 2025 14:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF939C4CEEB;
	Fri, 15 Aug 2025 14:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755268148;
	bh=H81prq1QS9ngg/A1qE6OG7MnMnv7zcnpHYeSRdGdZx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s69DztBfXres7T+IGhWSm85kpDCZD1LuzBjTqvlPeazZ2xDoT7onrcIjC0CaPq8bs
	 iD6N/+Zk/GT+qO4Ph8IN5wbiy8vunaKBWLp5btluDma1LO0TQFm/UeTe7cUSECYDhd
	 DzGkZQIC1cHW6+P9IxTaGO+r8/nCY+AvJObL29xsrIxfGfEOyqHTP+DnWzN90UVIUd
	 0ARf0GxAJW30/LZPs4pIVYqqTtSAX2Mh5ft7njos/J8iAMdMypui9QR0elLt3ThP5j
	 AZ66f2EC/SlK7IDOn1Q1JLgG6Iare8/Wc96BkubrlFWA+SyzHZClNs1G44Ht9zQ41y
	 +aC7ReJZAkj3A==
Date: Fri, 15 Aug 2025 07:29:08 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, hch@lst.de, tytso@mit.edu,
	bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, brauner@kernel.org,
	martin.petersen@oracle.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH util-linux v2] fallocate: add FALLOC_FL_WRITE_ZEROES
 support
Message-ID: <20250815142908.GG7981@frogsfrogsfrogs>
References: <20250813024015.2502234-1-yi.zhang@huaweicloud.com>
 <20250814165218.GQ7942@frogsfrogsfrogs>
 <a0eda581-ae6c-4b49-8b4f-7bb039b17487@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0eda581-ae6c-4b49-8b4f-7bb039b17487@huaweicloud.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250815_072910_793885_619061F1 
X-CRM114-Status: GOOD (  31.78  )
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

On Fri, Aug 15, 2025 at 05:29:19PM +0800, Zhang Yi wrote:
> Thank you for your review comments!
> 
> On 2025/8/15 0:52, Darrick J. Wong wrote:
> > On Wed, Aug 13, 2025 at 10:40:15AM +0800, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> The Linux kernel (since version 6.17) supports FALLOC_FL_WRITE_ZEROES in
> >> fallocate(2). Add support for FALLOC_FL_WRITE_ZEROES to the fallocate
> >> utility by introducing a new option -w|--write-zeroes.
> >>
> >> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=278c7d9b5e0c
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> >> ---
> >> v1->v2:
> >>  - Minor description modification to align with the kernel.
> >>
> >>  sys-utils/fallocate.1.adoc | 11 +++++++++--
> >>  sys-utils/fallocate.c      | 20 ++++++++++++++++----
> >>  2 files changed, 25 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/sys-utils/fallocate.1.adoc b/sys-utils/fallocate.1.adoc
> >> index 44ee0ef4c..0ec9ff9a9 100644
> >> --- a/sys-utils/fallocate.1.adoc
> >> +++ b/sys-utils/fallocate.1.adoc
> >> @@ -12,7 +12,7 @@ fallocate - preallocate or deallocate space to a file
> > 
> > <snip all the long lines>
> > 
> >> +*-w*, *--write-zeroes*::
> >> +Zeroes space in the byte range starting at _offset_ and continuing
> >> for _length_ bytes. Within the specified range, blocks are
> >> preallocated for the regions that span the holes in the file. After a
> >> successful call, subsequent reads from this range will return zeroes,
> >> subsequent writes to that range do not require further changes to the
> >> file mapping metadata.
> > 
> > "...will return zeroes and subsequent writes to that range..." ?
> > 
> 
> Yeah.
> 
> >> ++
> >> +Zeroing is done within the filesystem by preferably submitting write
> > 
> > I think we should say less about what the filesystem actually does to
> > preserve some flexibility:
> > 
> > "Zeroing is done within the filesystem. The filesystem may use a
> > hardware accelerated zeroing command, or it may submit regular writes.
> > The behavior depends on the filesystem design and available hardware."
> > 
> 
> Sure.
> 
> >> zeores commands, the alternative way is submitting actual zeroed data,
> >> the specified range will be converted into written extents. The write
> >> zeroes command is typically faster than write actual data if the
> >> device supports unmap write zeroes, the specified range will not be
> >> physically zeroed out on the device.
> >> ++
> >> +Options *--keep-size* can not be specified for the write-zeroes
> >> operation.
> >> +
> >>  include::man-common/help-version.adoc[]
> >>  
> >>  == AUTHORS
> [..]
> >> @@ -429,6 +438,9 @@ int main(int argc, char **argv)
> >>  			else if (mode & FALLOC_FL_ZERO_RANGE)
> >>  				fprintf(stdout, _("%s: %s (%ju bytes) zeroed.\n"),
> >>  								filename, str, length);
> >> +			else if (mode & FALLOC_FL_WRITE_ZEROES)
> >> +				fprintf(stdout, _("%s: %s (%ju bytes) write zeroed.\n"),
> > 
> > "write zeroed" is a little strange, but I don't have a better
> > suggestion. :)
> > 
> 
> Hmm... What about simply using "zeroed", the same to FALLOC_FL_ZERO_RANGE?
> Users should be aware of the parameters they have passed to fallocate(),
> so they should not use this print for further differentiation.

No thanks, different inputs should produce different outputs. :)

--D

> Thanks,
> Yi.
> 

