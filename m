Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF68CDB465
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Oct 2023 20:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6iO8ZezL8FazPnqf0asG4mXbjAoTpx1AXLK2AZ7nc7U=; b=aw9otitU62fx8o0EDyNxk2x5Da
	njDdqK8Xrr2Wg4SZkC3L65EjP42Lr5eDpGonC3I2PEC22bXaSZwwqpZceA93SCzreKPbjaSyPtSmj
	Wv2XeUmfnqVfH8OlhVRnCoaxYC5SlhzzSKzDqkXSknPOG8VlX5yEhTQj7G6Cak5BiLWdWy/RKYjqT
	Ws0qyy0R2g891aizJbHf51cOTFsjKtnedyBwYXN+XVnmVN5e2ksz1X4bsdC30OP2Pk2sdqQPllNot
	4U0N9E68PSh5nNe5zlRJjlbzSqwh41s6x3XweBnCynI+Sm+CM5pgSce1zM6HpCyXW6n5lQWVWrnFP
	oIwjU+uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsUYv-00AX7q-2z;
	Mon, 16 Oct 2023 20:51:41 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsUYt-00AX7Q-37
	for linux-nvme@lists.infradead.org;
	Mon, 16 Oct 2023 20:51:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E1F76CE1478;
	Mon, 16 Oct 2023 20:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DBAC433C7;
	Mon, 16 Oct 2023 20:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697489494;
	bh=hQVThwfGta628Xf1mTyQEpyhuKTeMN6klO0wO5mT9R0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rEsAWZls2b+hAjVWYx9e6MjcUbY6bd8b70+i57nk3ZEZMHXqtomWD6zqFgkesAB0n
	 kj64wLKxGh3dMcuVc/EwJY/looScrzROdtIpC9w4DqRVHvtAm4YMflBEActI06D1Y2
	 wxYDK5GDp+dV01hP4kpffEBbBHwsPCM62dcZ4vkvqMQzekorhA/fENVnD4++7ogW+0
	 GvX58+KPP7JMmfuvD3GdrG2oANc5rF2c3sjyj47soA+gRNuXER3Xo6PYwFklioi33I
	 wb/JX3FvCs/I6mPd/SrpTdFfV+IHJfJ6cCFcd/x8B1YFjCXglM+JkE8loYma7ibmxs
	 RESf8XAOUzYgA==
Date: Mon, 16 Oct 2023 14:51:31 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@meta.com>, hch@lst.de,
	linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH] nvme: sanitize metadata bounce buffer for reads
Message-ID: <ZS2iU5T0O0ve29EV@kbusch-mbp.dhcp.thefacebook.com>
References: <20231016202124.2957213-1-kbusch@meta.com>
 <90fd6d9e-5bcf-40d8-b85b-9d33c91406b6@kernel.dk>
 <ZS2dmakCEln97UNi@kbusch-mbp.dhcp.thefacebook.com>
 <e04eec37-ec31-4c35-bf26-acbf90fda43d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e04eec37-ec31-4c35-bf26-acbf90fda43d@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_135140_207417_8C8CC25B 
X-CRM114-Status: GOOD (  11.04  )
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

On Mon, Oct 16, 2023 at 02:41:47PM -0600, Jens Axboe wrote:
> It still looks wrong to me. If it's writing to the drive AND we fail
> copying in data, -EFAULT. But the opposite of that isn't that it's a
> read from device.
> 
> 	if (req_op(req) == REQ_OP_DRV_OUT) {
> 		ret = -EFAULT;
> 		if (copy_from_user(buf, ubuf, len))
> 			goto out_free_meta;
> 	} else {
> 		memset(buf, 0, len);
> 	}
> 
> would look more readable, as it splits it on direction, rather than on
> direction and the status of the copy. And follows the normal idioms for
> erroring on the copy condition.

Thanks! When you put it that way, the mistake was clear! Fixing for v2.

