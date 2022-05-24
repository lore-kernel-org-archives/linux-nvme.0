Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A30FC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 05:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xspr9q8wrCQ7j9SHJRfFWrr/gJIyMTnBbmdu+lbI3DE=; b=yj3aVyQJsbLu6mHbFP2MGXDWRE
	Oz0nYX8H0L0NHujv0jJ7CPWr7X5ClwliEji6p7Tc5eNRJnQ7TQ8vz98ZiKvnH/Ifc2Uv1NfB8DBEx
	Bd7pEMHXZj+hzV7dSZOOjUldTTDzIgNiUHUJtnWvs+wEnK7YCXWbbRq/XyUiJu3n6ClUjajWpYf8B
	8mMUTd446Bj4tsK0kPqDFzSV6Z1z2JDswcX+9hZubkX9HsA7QWmcpmjiW5KFPuv2ooF7RyshaRTHW
	J95OHZ4Evvkmbr9JBE0apVOkaeInEVz9apbiN5uyZnPoKSapwL5VPJRfnp76224C5976IDiK3+i6d
	M6lOE0+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntMtj-006q3g-Q0; Tue, 24 May 2022 05:15:59 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1ntMti-006q39-Aj; Tue, 24 May 2022 05:15:58 +0000
Date: Mon, 23 May 2022 22:15:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 io-uring <io-uring@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [GIT PULL] io_uring passthrough support
Message-ID: <YoxqDtk71JuyydDv@infradead.org>
References: <6f712c75-c849-ae89-d763-b2a18da52844@kernel.dk>
 <CAHk-=whfi3FE3O7KrziqPbyGvAmNFas3xxLz2O+ttzBkCOQmfw@mail.gmail.com>
 <caa5e85c-2bfe-b9e3-1e32-c11f78e6ad29@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa5e85c-2bfe-b9e3-1e32-c11f78e6ad29@kernel.dk>
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

On Mon, May 23, 2022 at 02:19:38PM -0600, Jens Axboe wrote:
> We can obviously dump this as it isn't integral to anything, and
> honestly now that the NVMe is wired up, there's no great need to have a
> separate test for it. But it doesn't really hurt and there are already
> regression tests for it.

Yes, please dump it.  It is not actually useful and is just more
code around for no good reason.

