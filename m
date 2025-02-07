Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F08C02194
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Feb 2025 16:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GNTOUe4iMIXqAscJ4hdE+V+EtKQG9ZJEwsoJ4nZISb8=; b=X78no89Gt9n6+7nrrqSpG2Zy+4
	5xS09EVxLfdLPcbb5cfyVayooHDX4yPrITunDwSkCuZLglHhy8yMzMeD6zgBUqXxmF95jUnYm4bJw
	e2Oan67Zt315GVT5slErnSK2Ver4zbmrxbd7sbl+E+rPAv3YcgOSw4/M0BwxtVZ4W0wZYxdsmef2O
	fXVnmGZ+tJpxfG7WxnnipZf44bCL9MfNSRfbflHcc9qHBX3jJHvUdQWIVQVOq6o+kobh6m0LpDWfP
	jN+csEwkB6as02JDAgazUuca5keWHYk5oIYWMm2MCy3jsdJOvsjYu8g58Wf6KdWHoM4R0OfSk8Mim
	MqBIKWwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgRdT-0000000ANJK-0bVq;
	Fri, 07 Feb 2025 16:55:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgRKT-0000000AJPo-2kHu
	for linux-nvme@lists.infradead.org;
	Fri, 07 Feb 2025 16:35:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 11E565C6E3E;
	Fri,  7 Feb 2025 16:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41592C4CED1;
	Fri,  7 Feb 2025 16:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738946144;
	bh=mr2MXra6pZSqeZdW5AVwEl8pEWOqy2NHL62R0DRg87A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rLZT0PkxeCr872F6Xh4RBjFbbidnF+xCIlz88X/9/tuMOqifpZwcLoeVDkhJYlfSo
	 jFZiuP9+sJOUUIFFkb9qu4J1an8rwgI3A7RpzZ3sk4FtyfftdmIoRdOLQpEDRHYlzJ
	 BkIu+/6Xn6VTS7YFL5ZRoZUwxZZTAX0PosYRbPEPP9GgJcnYCApcJ8a3vqd6ygyvST
	 qmeHuHndAsCID33wWSlt+DKeTwMEjHc6V0XPaCuvaGiaxdQCJjvSL0ltP4O9+gQk6/
	 8juTUTKx8xmdQBPi2X/1Og2jTYJTRoLuwP4KlrGyun1J0NdFgW7cSJt75K5QVJBivH
	 Th5ZSYi6La6/g==
Date: Fri, 7 Feb 2025 09:35:41 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jamaleddine AMGHAR <je.amghar@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: NVMe Write Speed Slow on Linux (Samsung 970 EVO Plus)
Message-ID: <Z6Y2Xc6dqwrt2csg@kbusch-mbp>
References: <CAA8V+ZQ6JUiF0FeLFQqy4rGUHSsJom1u0j=FEnpjumG8CSw_NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8V+ZQ6JUiF0FeLFQqy4rGUHSsJom1u0j=FEnpjumG8CSw_NQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_083545_738247_55191243 
X-CRM114-Status: GOOD (  11.62  )
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

On Fri, Feb 07, 2025 at 05:25:30PM +0100, Jamaleddine AMGHAR wrote:
> I am experiencing a significant slowdown in write speeds on my NVMe SSD
> (Samsung SSD 970 EVO Plus 1TB, firmware 2B2QEXM7) when using Linux, while
> the performance on Windows is normal.
> System Details:
> 
>    - *SSD Model*: Samsung SSD 970 EVO Plus 1TB (2B2QEXM7)
>    - *Operating System*: Ubuntu 24.04.1 LTS
>    - *Kernel Version*: 6.8.0-52-generic
>    - *Processor*: 12th Gen Intel Core i7-12700 (20 cores)
> 
> Issue Description:
> 
>    - Write speeds on Linux are significantly slower than expected, whereas
>    they perform normally on Windows.
> 
> Could you please advise on possible solutions or additional diagnostic
> steps to identify the cause of this slowdown?

There's a lot of missing information here. What workload are you
throwing at the SSD and what results are you seeing? What results are
you expecting? Are you using a filesystem? If so, which one? Are you
using parititons? If so, are they aligned? What program are you using to
evaluate your SSD performance? If you're not using 'fio', use that.

