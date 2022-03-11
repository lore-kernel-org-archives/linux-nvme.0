Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F28DC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 05:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AKcJwdPPGCmC8fnT+SzRmfs6FPJaBvqwnNz4bzPIPRI=; b=4wcCiMkUIFdGgTR48NDHLhFt+N
	aSxc7LridcysyIY4NKVQqbtsPbCevO+hJqS5Q2RbF5p/MgsYXqPgF5mVlHJp7lvxnXbLqC9GoWcbH
	y7BZ756+1mey0wRwRwK2lmqxyEekq5bmSMuLWo4PpUtKeEHZHUEr4vKFjPX+I80HKgwPr1gVGRvaP
	Pj0q6eh2j2eJXQXocf5jDnHoOVNDTmJluVXi0+po0SB1HLSZDVTb/9sQrXT/QGxBU73kdUMONco0E
	dNbdM1SOh0bechnZvFEbb3WY6c2UeByuqfNhNOuvz/D4CYj7EaFWTtXWLG8AtnFa4hppnYXRr3Inp
	0RE6oZww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSXWM-00F7eB-B4; Fri, 11 Mar 2022 05:08:58 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSXTh-00F6c7-0S
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 05:06:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 282AAB82A7E;
 Fri, 11 Mar 2022 05:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384E1C340ED;
 Fri, 11 Mar 2022 05:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646975168;
 bh=AKcJwdPPGCmC8fnT+SzRmfs6FPJaBvqwnNz4bzPIPRI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gwWXoihYFEXXdqVuediOElDChCGopC96LqjN28ounv6QQ4t/nM6nQ7zaEaW74K00I
 VU+JqBS/dFskSGFDaX8oATaI3CDAz/mEXDUUCbQG1m5Q0vxLet99mwu/eGHpBrJgK3
 KGB4n9QfE7o6GOj3CEWYKcKACgXEQBwVLBA336ZWe8Z+kR3OJT1u9gIPtv8kdNJKO0
 OhBBIq0xXlhD0H37V5rvzy2MIn13nbIEosxwBa37jdA7LHwr8B05do7MhB+FZRxK+V
 g7E6xbqhpFY1ZRpxP/zwLkkaqom62qVk8+xNwD/c+ZjczSPOLRa5PXgmTnaGiuVeQt
 chMhruCRIAHuA==
Date: Thu, 10 Mar 2022 21:06:06 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: "Luca Porzio (lporzio)" <lporzio@micron.com>
Cc: "hch@lst.de" <hch@lst.de>, Manjong Lee <mj0123.lee@samsung.com>,
 "david@fromorbit.com" <david@fromorbit.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "song@kernel.org" <song@kernel.org>,
 "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
 "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
 "nanich.lee@samsung.com" <nanich.lee@samsung.com>,
 "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
 "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>,
 "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
 "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>
Subject: Re: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Message-ID: <YirYvvIBW+XNGvxP@sol.localdomain>
References: <20220306231727.GP3927073@dread.disaster.area>
 <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com>
 <20220309133119.6915-1-mj0123.lee@samsung.com>
 <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <20220310142148.GA1069@lst.de>
 <CO3PR08MB7975AB3E282C7DA35A5B1CF0DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO3PR08MB7975AB3E282C7DA35A5B1CF0DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_210613_282323_6B80CE7A 
X-CRM114-Status: UNSURE (   9.37  )
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

On Thu, Mar 10, 2022 at 06:51:39PM +0000, Luca Porzio (lporzio) wrote:
>
> Micron Confidential

This is a public mailing list, so please do not use this header/footer.

> it is used across the (Android) ecosystem.

So why hasn't it been submitted upstream?

- Eric

