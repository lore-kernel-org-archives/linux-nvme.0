Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EA9E7719A
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 17:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5+NqPSTZ/mFxw8HqAVbuu8JGQ5Rp+stuqCJR4BpJjCw=; b=lpzhUIntRJAdUMrssXZ+hJgExL
	9HscxhXkGqZ1wxdMNzAkoT/Jzx7gXR+PllY2mNPG6I2vfrxy4se7nlq6GD90Urn6cZWbr2Eozp9+Y
	9J7M9rGsPIaqt5QBcU+vYJnauCmlZbkreskUcX8bjxWETk2Uz4qqyP+FP/hknEsCTmJL9hb0zK/jj
	ZsNQDOjctQxGai84M9sMXYFqBJTnKSbWCif0FLVEApYNIZynVQsIn0w2Yt4Bz3mZPalGMRlUN8JmY
	6gtBQiWrrmZc9Ym1cdhUCnwJ4a6ZRcxgV65qB2obdsfjAN/bchwtRc7EXTGqo72ZmvuEpLL+OwnWe
	bvQ2lrVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVD97-00000005nag-1VlD;
	Tue, 07 Jan 2025 17:13:37 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVCkz-00000005hmX-1AJb
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 16:48:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AB5665C45AA;
	Tue,  7 Jan 2025 16:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB1DC4CEDD;
	Tue,  7 Jan 2025 16:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736268520;
	bh=5+NqPSTZ/mFxw8HqAVbuu8JGQ5Rp+stuqCJR4BpJjCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bjKZlSihUay1LOlJkbiDKgOenB/Hkbtve6UsrtMokoLdSeXC7qlX4MeNhI13e4EqC
	 0GgfeLOrzS4bRy0PDhNyXfohg2CVxiIVMuipbwUe1RGvRfZllBDMDN/y6gmGIF6wba
	 DVXmLElie8XGzBLpneoZMJGBBsuE81rEk20TuqjSQyvjPZ5IZGyg6nAp0/koIh6850
	 D0HoGN1vt9GZ4aa0ufR7COvPK12/dfMjl7qGXoXa2tbQKzUiY0LkBopaSiHVM5hMls
	 Cfcp6eaufPtBgRzthlFpKygfvlip/vZmXXZrDku7jopnNWiXnGm9XhKlSpRt9OdNKA
	 YOK1ltbMWSR6A==
Date: Tue, 7 Jan 2025 09:48:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Add error check for xa_store in
 nvme_get_effects_log
Message-ID: <Z31a5uPbc-AErsiZ@kbusch-mbp>
References: <20241216155229.GC23786@lst.de>
 <20241220120046.13559-1-keisuke.nishimura@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220120046.13559-1-keisuke.nishimura@inria.fr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_084841_362337_C462CEE0 
X-CRM114-Status: GOOD (  10.39  )
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

On Fri, Dec 20, 2024 at 01:00:47PM +0100, Keisuke Nishimura wrote:
> The xa_store() may fail due to memory allocation failure because there
> is no guarantee that the index csi is already used. This fix adds an
> error check of the return value of xa_store() in nvme_get_effects_log().

Thanks, applied to nvme-6.14.

