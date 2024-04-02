Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26767C6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 14:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D5EYP1f5nXmUO6i+uCQyFlPoc+PCFjxdHcU4q8U8Q74=; b=4pulBMZuryt++7xGQO1mvn698g
	60o1qLfo2Sp0LsNgr9BEa8e6MpwN061uw32rCEC5gBu7CU9B5wtZRKQtn02AMiN77Ku+KLHBYh4pI
	S0CHBrnAycgr0yFVhdiNiKrhV9gYu2Tf9C+T9wr8HNYTA4fQLshcKQBjdsdLdhQyWxmLyqmF+pDUp
	bMb+YjKZEYsCy90fFABfY7S8+/2EbxsHy7/c64+p1mS9HdY0O412KmZUSyV7xSlOETqZ7uIrElXvp
	zCaPiQjr59LCFCrIB094ChTLSif7E+mVA8+womoVWq/rQy8jICqhacgc26thy84Ctbzf8LwI/mx6T
	Oj3ytidQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrev3-0000000BXaw-2Wfv;
	Tue, 02 Apr 2024 14:15:21 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrev0-0000000BXaQ-0NdF
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 14:15:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 776A3CE1B4F;
	Tue,  2 Apr 2024 14:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D40C433F1;
	Tue,  2 Apr 2024 14:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712067314;
	bh=D5EYP1f5nXmUO6i+uCQyFlPoc+PCFjxdHcU4q8U8Q74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jS9b2pbezCpG1p/57V/ijLpgsXYSgYGB7L4ZI8+DNeN+hGsIsoxC/DMvENevgvKGA
	 PE4gQKl3dvAmm26Pd/lOHNKZJ8Yrp19l+5xgPvnjsMNw0uR0plEjKCwleVUlLCq+3E
	 mfV/jaYClAN7ret5xPSoDzvzVN2A8C7DOc0TBSRVgvOFPa89ryepWN5RonY0zzD61l
	 +RUR3oCQAeUr1+l5Sgz5tVpOqU/4IgWnip3oNjEvDS1Wv7gt3WGsbL5qORkYrlZAV3
	 nZCa0vUkchoiYR4Vv80ufE23h11Zn4sc7GYv0tpba52m4So3YdEEmtrk9axzwzWigt
	 Q+MhMBD9zkRzg==
Date: Tue, 2 Apr 2024 08:15:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: don't inherit LBA-related fields for the
 multipath node
Message-ID: <ZgwS741jcyzbv1wH@kbusch-mbp.dhcp.thefacebook.com>
References: <20240321210819.1246749-1-hch@lst.de>
 <Zf2wRtNqNU2qTpHE@kbusch-mbp>
 <128c950a-57e1-428a-baa1-67765860661b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <128c950a-57e1-428a-baa1-67765860661b@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_071518_331488_9FDCC27D 
X-CRM114-Status: UNSURE (   9.00  )
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

On Tue, Apr 02, 2024 at 06:51:02PM +0530, Nilay Shroff wrote:
> I found this one couldn't made into 6.9-rc2. So are we planning to queue this fix
> for the next rc?

Yes, it'll get in. I send pull requests on Thursday's but some unplanned
travel events got in the way last week.

