Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA91C48BF8
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Feb 2024 18:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E5253epWr/zaC4e7F0X77wkVCHTrLNx/UNbcR3b4RXY=; b=tXh1kDgpZBHv27Vb0SjGviMwIm
	/KqJhjA4oDldYJ+VTi8ELVzQef1xSyUB516WWJpkxsNeB7LdvGHM7kGV635LeGuac6ypL9Vp9De4x
	IE9LwyJ+8DorZZIbfcLa//dBkrovluPjcRbpegpK0XzLce/BhZjPt4Dz55+gPX93vKaoN69TzavJW
	CUImYzgK5bPzN5mdjgJBgfdzt0fMw6xCeM9Ikch/CIasp9qxaXjiXbPy2Nf7z9+csmDeScu6URjJP
	IgIi8S6ISV9eJr5vJoaJLJQ+xMJKgktyKEa7u2De648WM2pCj6egyDY0J/WY233E794VBX1G9xO95
	urbu5+wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc8q2-0000000Bnxm-1nlf;
	Mon, 19 Feb 2024 18:58:02 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc8q0-0000000BnwU-0frc
	for linux-nvme@lists.infradead.org;
	Mon, 19 Feb 2024 18:58:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A41EC60F21;
	Mon, 19 Feb 2024 18:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D104AC43399;
	Mon, 19 Feb 2024 18:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708369079;
	bh=WX+/BwKaMoi4eZrIDNE+tT6bRVlFBx1G/86vGVtXqD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ByWPm0weIZLIZDkeu9F7U3wLzNAxvJ0wCc0RX9kGhgdhcJfvd6woVFl/GnXE1TSmM
	 COFe07bO2b5emaS1mCXplG7Nyp/lAlqeDf6IoQ9f8bPe+rUntxpHDqCnExMiY7kJ47
	 KiwTKH06LtDIHzNkYCwqAsiuJvnjz4kdzONe4y5nqyZ40xBUm010Vz30bGq053wPcE
	 +ONYB1Np8G22L8MxHL7VziiI7QiaCYtoXbZ21PR0m6EN4hIiN9NUFXFLyO6dqrPXPJ
	 gBrd6UUtBmYPhuyFFd3uerXJdoDrUxB06wlm4ih5guvURtYgzliLa/DRz5pLQJVpJx
	 RB9hrKDCMCVDg==
Date: Mon, 19 Feb 2024 11:57:55 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com
Subject: Re: [PATCH v4 01/11] block: Pass blk_queue_get_max_sectors() a
 request pointer
Message-ID: <ZdOks-bU2kDY6S6Z@kbusch-mbp>
References: <20240219130109.341523-1-john.g.garry@oracle.com>
 <20240219130109.341523-2-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219130109.341523-2-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_105800_264645_038B38A9 
X-CRM114-Status: UNSURE (   8.14  )
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

On Mon, Feb 19, 2024 at 01:00:59PM +0000, John Garry wrote:
> Currently blk_queue_get_max_sectors() is passed a enum req_op. In future
> the value returned from blk_queue_get_max_sectors() may depend on certain
> request flags, so pass a request pointer.
> 
> Also use rq->cmd_flags instead of rq->bio->bi_opf when possible.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

