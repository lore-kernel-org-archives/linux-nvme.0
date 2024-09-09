Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2926ECE589
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2024 20:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JnALK4wDwOn7Kw/GQ3ARghSlKCAXXCVBvg7CYYmMt/c=; b=oEmfwv/jDRmlxpLZqxrOjkHpiz
	qpfwxg11MzlQe1h/IJzakr99qkFS84B8MRKwvBSrOHl+qArnhdRYxEi6yCB5jnY+h/4ZBcq/LQLRj
	zlhfFJLIh/XzYgsw4pgJoIvNqpOcva+M3kzyrbkxqF90r+Q+9Ky8gs3Ky+Owk6+j2kyan9dSZQb5h
	lvVbl8GuZNqC7nxbVFcl0JCOTHV7NOwoNe84AyazGfIj3FgH9Kgmrrf98D4/t3rf7mVRKHpq5COOQ
	2UrXeJlVC2WZh3WTOALK4XaTUm1AD0unzSBpJr2afPGCi/4AZv5bxZJvaUS5m1KldNzm3Beuy4kjr
	3p3c+wBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snl3g-00000003F1T-1zs4;
	Mon, 09 Sep 2024 20:32:24 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snl32-00000003Ev1-2htD
	for linux-nvme@lists.infradead.org;
	Mon, 09 Sep 2024 20:31:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 69D55A43713;
	Mon,  9 Sep 2024 20:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115FBC4CEC5;
	Mon,  9 Sep 2024 20:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725913903;
	bh=JnALK4wDwOn7Kw/GQ3ARghSlKCAXXCVBvg7CYYmMt/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nkh/5p44/1ExmxE83WBrrqKZQp2/RJA+cXdgKURcPWrtUwQhlSD8lA5YSa9l/yxtt
	 SovpQ71A7FgRXz4lbw121vJxQlHuP4EEn13x0snODKIEo1sMAkDsU4MKQKnN5SexgS
	 oSjiL3HI1cndzyG9qWiVH26Q1G8gmlC8IwViECJ6JoblM50T048x6KL/LyPoZaPRle
	 zI8blSaQyQKzL9fXreQN5QOAsRO3sMEkIslXo2+fgxrvPN1NYF7+9op6xObLIoTIpN
	 rJsZFMAktXu9am+qOZpaIyAbMUv1HVx82D0JEXl3aZ+0mmKCVH5p05uMRDzR2Od6DX
	 wpnLovbFuTcDQ==
Date: Mon, 9 Sep 2024 14:31:41 -0600
From: Keith Busch <kbusch@kernel.org>
To: Robert Beckett <bob.beckett@collabora.com>
Cc: linux-nvme <linux-nvme@lists.infradead.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm <linux-mm@kvack.org>
Subject: Re: possible regression fs corruption on 64GB nvme
Message-ID: <Zt9bLa4TJT6L75aG@kbusch-mbp>
References: <191d810a4e3.fcc6066c765804.973611676137075390@collabora.com>
 <Zt9amhUGs9FT5i-O@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt9amhUGs9FT5i-O@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240909_133144_772650_72D63337 
X-CRM114-Status: UNSURE (   7.51  )
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

On Mon, Sep 09, 2024 at 02:29:14PM -0600, Keith Busch wrote:
> As a test, could you try kernel parameter "nvme.io_queue_depth_set=2"?

Err, I mean "nvme.io_queue_depth=2".

