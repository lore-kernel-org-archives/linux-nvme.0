Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EB4C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jan 2024 16:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8F7PYqflxf4UNtrlHBZzRnzzUMvgP2WoeBM1FymQh5I=; b=A+y8CzUugMvNfH/qhPObdb7LXU
	0EzKde/HEs4brEZcRl4v7w3NW8hht6HYPecgB+4hZUJBILQyh2RIoHnol+wcUg7bvCRNp8E4hFqxY
	DWNh5+VpIw1RLZ7JplnITMlUVH+g+vrksKFxB+c8196QnzXBpxwH7HvrWeezX+J56ZcaLHiHxX8or
	gmkr7tugJj5Gqt0P4E6DGQRXDQWHLEbQsjHBvWf7pZGR5mOJkHUJ+xAiJoZ/qsRTg65klUlZpMFQw
	MJ9t0VIowzR1eD6srVIQswDZwpH8zVCh3yqXiC7jDBvOOKBSCJgYc1I2IyyoPsp5afmaCU8SYOGMQ
	h0jncz6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rL3ou-00BLph-2D;
	Wed, 03 Jan 2024 16:10:16 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rL3or-00BLow-2V
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jan 2024 16:10:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 4446FB80FEA;
	Wed,  3 Jan 2024 16:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0062CC433C8;
	Wed,  3 Jan 2024 16:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704298211;
	bh=Qm5P5u+FGecrVhqqMzdz+iw7vI+vn9BKZtbrWre6wCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=urkX9sn6kUz8bFdy0uh4ZMGqrx343la0Iy5KW453zsqqkDwdfwvKTAbPdZt8ZTbSP
	 ZJ1+L05ehitzySMJy3rCt4jcEiaPvXsbiKIdVZHOIYSjO2tuIIFun9uFbKXyjLjqWZ
	 VFFTmWS91KkaBlWfE5AE7N2OWb0mAUnk/o5yByi5WNcKDYkypnwQasFy0rRqtNILFQ
	 Tr7Haw4ehu6NDRs+9cMXnexKzQP1Brp7jiBsy7LQfn8N1tc6L2rz4DK3O+XNrzx1KQ
	 OBB+IqflzE8V6rfxPat3FvY6P5LK1WdJ78pi7DjgEdezPuVihc6T58hvh1FHuAIeoL
	 zVb8sNJcHKHeg==
Date: Wed, 3 Jan 2024 09:10:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Jim.Lin" <jim.chihjung.lin@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jim.lin@siliconmotion.com, cj.chen@siliconmotion.com,
	david.yeh@siliconmotion.com, hardaway.tseng@sk.com
Subject: Re: [PATCH] nvme-pci: disable write zeroes for SK Hynix BC901
Message-ID: <ZZWG4OraobaeYZkp@kbusch-mbp.dhcp.thefacebook.com>
References: <20231128025737.53026-1-jim.lin@siliconmotion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128025737.53026-1-jim.lin@siliconmotion.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240103_081013_954865_9FB66B9B 
X-CRM114-Status: UNSURE (   7.37  )
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

On Tue, Nov 28, 2023 at 10:57:37AM +0800, Jim.Lin wrote:
> SK Hynix BC901 drive write zero will cause Chromebook takes more than 20 mins to switch to developer mode
> "disable write zeroes" can fix this issue and Sk Hynix has been verified.
> 
> Signed-off-by: Jim.Lin <jim.lin@siliconmotion.com>

Thanks, applied to nvme-6.8.

