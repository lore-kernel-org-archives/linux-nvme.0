Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABC6C46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 17:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sxYXElQsciLOsv3yaNTjkNJXUmdkdAD0Npl8p5dMtaA=; b=Ui+yNRQZiLv8cwA7Kdoga/Y+Cs
	nRDChpuVL7S35uOZj8oaBJlhVT8Kckke5ZqaUZ/4vXg4r+iUmW7C/Oczkw0EoBm4PhPO592ADZhLa
	FNaSSn6VIfCSp+HLAgJ15lnZptC7CTnoDOOjxZK7xwUwVUim1Yblg35J9ba9qFH9vNEDDDvGLsDSx
	MdcIxlH5fJuk3+fnxFsvTHYb/+b0K7HrqfwAio+DMXUteZYL+ApiQ9h50L7Pr/ceJqPlPtYoAsAQQ
	nhBvL+5oDGPVf9u/wEc/e39VQlFFwViX3oV5RZPxqFIgpnNIHHQu3W83Z+X8HLbdS5q3QonIKrpvr
	tf2Xd9Aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSgbc-004KCo-0Y;
	Wed, 24 Jan 2024 17:00:04 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSgbZ-004KAr-0d
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 17:00:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id ABA4161D7B;
	Wed, 24 Jan 2024 17:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1749AC43390;
	Wed, 24 Jan 2024 17:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706115600;
	bh=hXGzPTiwioKcSc96+KXT2D0Ks/c8ANCX1++Y+vUEniU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dpRWL51yr2yLTp71TPIP1Fop/jhdHpgPdcdrk6nJxIGc3touJb70eIylpeofIKiKn
	 30FtWhEG28HVB1QCvOzcma9X/ZGjPUfQ4xFb0jSn+R0xd/ke9BY/5xczlmlQljrmw+
	 92vWkOL2Z9vD6oulG4wt/tJNQV5/eqOhkqrMmmt0+xD6jVYl3sXoSVYYkYqGqKkFcj
	 1OBRy104EQZlH975QRWOC+CS6h73jtFq3pQUEQKf2UjF79JWZ4UHqu/yv8s/wYWHUW
	 OotF+7FKg9mppxwlnZQr0sspyvioRbL5f7LB1vz8ajloF5O0lUA9eYuRPWs5Kl1KY3
	 A13gSOA5kdJEw==
Date: Wed, 24 Jan 2024 09:59:57 -0700
From: Keith Busch <kbusch@kernel.org>
To: alan.adamson@oracle.com
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, linux-block@vger.kernel.org
Subject: Re: [RFC 0/1] nvme: Add NVMe LBA Fault Injection
Message-ID: <ZbFCDQlFXIvpDHeX@kbusch-mbp.dhcp.thefacebook.com>
References: <20240116232728.3392996-1-alan.adamson@oracle.com>
 <20240118072419.GA21315@lst.de>
 <6874a81c-3f4f-428a-8a95-19898ca004a2@oracle.com>
 <20240123090506.GA31535@lst.de>
 <7d7d7855-8a37-4de1-a32b-2edf0b53a05c@oracle.com>
 <20240124090453.GB27760@lst.de>
 <d63f74b2-b455-4fd4-9b32-2657c6d81588@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d63f74b2-b455-4fd4-9b32-2657c6d81588@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_090001_279522_64F7E8DE 
X-CRM114-Status: UNSURE (   9.57  )
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

On Wed, Jan 24, 2024 at 08:52:54AM -0800, alan.adamson@oracle.com wrote:
> 
> Thanks, I'll look at the block layer for this.  Do you think adding error
> injection to qemu-nvme makes sense?

I frequently added custom error injection to qemu, though it was always
pretty hacky so I never upstreamed anything. Klaus may be interested in
getting a feature like that integrated upstream if you're able to put
something together.

