Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6D8C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 16:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rypyp6BX7m/djk2QK0Lbb84gp/mVJJ2mAjN2oWNFUXI=; b=YlgjRM69CGNRkoDs/2H5SUl0dz
	f3AW/6zcP4XD0mxk2AuKnI0+8iY4AqPB6kWKOGW6eyIG5Yslh10Z+7u+b+8Xhx04j2nrcyzewhuN6
	RUWgAiz7fv7DBcdQG5rCxXyi9LvsQ50GY8wSvhTxs80dsFP4+R8MKNXUWAjS6X5BO3C5LqXzzXeU9
	u+Sc2mdfyvYZguX1/WFw1q+LN4VOGKGLZYjLxotefPf5Jp87RV1ZLkXSjfOsBzG4jnqSBBmSE12Kb
	Jps1fb5aFdx5ifZgt7NJ+QRiBZDxOg/zhIjBmZi7MwoljVcA3by2cSzb9SQETFf2rGMv4ttEBfkYh
	cOslnexg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osRpB-006kVW-KR; Tue, 08 Nov 2022 16:51:45 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osRp4-006kUV-2b
	for linux-nvme@lists.infradead.org; Tue, 08 Nov 2022 16:51:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id DEF37B81B4E;
	Tue,  8 Nov 2022 16:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4CCC433C1;
	Tue,  8 Nov 2022 16:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667926294;
	bh=APtEjyH5Uack2UlY2blKatc3e2SEGTBkQlXBZhgLgdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fFNRGEXktsRgRKW7p+I5y/E+TxHHTTEaKtritc0XZpTq/Rcs4PdFb1zX//7H84Ey+
	 Tf6cKTBr5oC3eL2uhuTwCYdzJ1XfwupQGDo7iC9BlKVesekdBK+XhkfAuA39x3Ozzu
	 Rj4qHwkuEFqZ0ifDHb/T9wjKqJxV2BM3zayHDnurCqP4O9dKxnyOKf5hPy3kTWUnC1
	 JUDNE9ywMENTyiz6FkI220QNWrU317LO0lggox4F0eTK2IeplRGcb55tkQn3/zY8FG
	 ZhSaNB6kFkEUFgR6OiL/BO48vvp5tLekmSlGivNFx9Hov2/MRovRloVCnP1Ty5V+7j
	 GQ2B5yhTMkEVQ==
Date: Tue, 8 Nov 2022 09:51:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Francesco Ruggeri <fruggeri@arista.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, hch@lst.de, axboe@fb.com
Subject: Re: nvme: hung task in blk_mq_freeze_queue_wait
Message-ID: <Y2qJE2Bpbvnf5Ejb@kbusch-mbp>
References: <20221108025602.E48005EC04F9@us226.sjc.aristanetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108025602.E48005EC04F9@us226.sjc.aristanetworks.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_085138_290265_61EB64DE 
X-CRM114-Status: UNSURE (   8.52  )
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

On Mon, Nov 07, 2022 at 06:56:02PM -0800, Francesco Ruggeri wrote:
> [ 4390.119745] INFO: task kworker/u80:2:8279 blocked for more than 300 seconds.
> [ 4390.471456]       Tainted: P           O      4.19.142.Ar-29007847.buytenhb7335070 #1

That is an old kernel, I think it'd be worth trying something newer to
confirm if this observation isn't already fixed. Specifically, it looks
like you have multiple namespaces timing out IO near simultaneously, and
causing a mismatched handling. That kind of thing was fixed after the
follow (plus some prior dependencies): 

  commit d6135c3a1ec0cddda7b8b8e1b5b4abeeafd98289
  Author: Keith Busch <kbusch@kernel.org>
  Date:   Tue May 14 14:46:09 2019 -0600
  
      nvme-pci: Sync queues on reset

