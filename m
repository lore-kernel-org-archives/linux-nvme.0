Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCC8C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 07:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aSYS5gGDQjxcymHRmr07eGqtvZY7RC+pIxnwG173VDY=; b=UGEMJnv0Hew/+QrVfWz1lA4agL
	we2h7oC2wnCDREBJIvy4CXptVWC7L3ZneDRiKbdlZ/VCOVedasw5sytxmtoinMzUhKWb52cjyv84i
	3vO38gRyYfxArrDSA12Ri3YdYx8UbN4LUwRsFNl23kEX/AZ6Jn2YO77Cmk/v62tJ8Osq8/AeZbPY7
	odh6+mSFUK/uPhotg3cX/4chBhEgxgRl+etrW5uKto0dufshSQ/FJFREsY6H14dU94ZvH8Ww6s/m/
	viWYb6WBxdoE7ADVmbnniJKFPz92PFOOPTWwup1LF51GDhlp8EyLu9edfF6FoswIRoRNfu4zgJyfl
	ODgUk1rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRUjP-0038Be-QK; Tue, 08 Mar 2022 07:58:07 +0000
Received: from smtprz14.163.net ([106.3.154.247] helo=smtp.tom.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRUjM-00388y-VC
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 07:58:07 +0000
Received: from my-app01.tom.com (my-app01.tom.com [127.0.0.1])
 by freemail01.tom.com (Postfix) with ESMTP id D5CEC1E8C1EC
 for <linux-nvme@lists.infradead.org>; Tue,  8 Mar 2022 15:57:58 +0800 (CST)
Received: from my-app01.tom.com (HELO smtp.tom.com) ([127.0.0.1])
 by my-app01 (TOM SMTP Server) with SMTP ID -382177656
 for <linux-nvme@lists.infradead.org>;
 Tue, 08 Mar 2022 15:57:58 +0800 (CST)
Received: from antispam3.tom.com (unknown [172.25.16.54])
 by freemail01.tom.com (Postfix) with ESMTP id CA01B1E8C1E9
 for <linux-nvme@lists.infradead.org>; Tue,  8 Mar 2022 15:57:57 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
 t=1646726278; bh=VE2APZ2EUOPto3xCBpDlYUdKULx5+IcuTAJTyrhmCSY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=gj5i1CIn33pvAtjiI7PGRju3F/FT7LKjibE7E8hhJ6gGhMozDM7LMnh+dISkXG05A
 r+46TRZ4nX9WHje5PvfW3wS0nXRQ+uCAJVaoVLv8QMj03MFLxVeoV5IfUa8svgi0lM
 y/Vhw9A9nEf1KGzbU6q/KzPeAUHqyA242IiwcRM4=
Received: from antispam3.tom.com (antispam3.tom.com [127.0.0.1])
 by antispam3.tom.com (Postfix) with ESMTP id 3C3B39C1C1C
 for <linux-nvme@lists.infradead.org>; Tue,  8 Mar 2022 15:57:57 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam3.tom.com
Received: from antispam3.tom.com ([127.0.0.1])
 by antispam3.tom.com (antispam3.tom.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 89eiVeu1VSZz for <linux-nvme@lists.infradead.org>;
 Tue,  8 Mar 2022 15:57:56 +0800 (CST)
Received: from localhost (unknown [223.104.210.22])
 by antispam3.tom.com (Postfix) with ESMTPA id 4B4899C0839;
 Tue,  8 Mar 2022 15:57:55 +0800 (CST)
Date: Tue, 8 Mar 2022 15:57:54 +0800
From: Mingbao Sun <sunmingbao@tom.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
 libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH 2/2] nvme-tcp: support specifying the congestion-control
Message-ID: <20220308155754.000029bb@tom.com>
In-Reply-To: <20220308071227.GB24575@lst.de>
References: <20220304092754.2721-1-sunmingbao@tom.com>
 <20220304092754.2721-3-sunmingbao@tom.com>
 <20220304162032.GA12250@lst.de> <20220305150915.00006b44@tom.com>
 <20220308071227.GB24575@lst.de>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220307_235805_412419_D2F41F87 
X-CRM114-Status: GOOD (  21.45  )
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

On Tue, 8 Mar 2022 08:12:27 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Sat, Mar 05, 2022 at 03:09:15PM +0800, Mingbao Sun wrote:
> > Well, actually I did have thought whether the calling of network API
> > here is proper. Since I did find that there is no call to APIs of
> > PCI/RDMA/TCP in fabrics.c.  
> 
> Yes - for a good reason.  Without networking support your patch won't
> even compile (both the host and target side).

accept.

Will remove the calls to networking APIs in the next version.
With investigation, I found the tcp_congestion could also get checked
later within sock_common_setsockopt in nvme_tcp_alloc_queue.
And this brings no difference to the command 'nvme connect'.

> 
> > But I hope the following could make a defense for it:
> > 
> > Anyway, we need to validate the tcp_congestion passed in from
> > user-space, right?  
> 
> Do we?  It seems like no one else really calls this routine to verify
> things.  In fact it has no modular users at all in the current tree.

OK. Got it.

> 
> > The role of nvmf_parse_options is similar to that of
> > drivers/nvme/target/configfs.c from the target side.
> > And both of them can not avoid handling specific options of the
> > sub-classes (e.g., NVMF_OPT_HDR_DIGEST, NVMF_OPT_TOS, NVMF_OPT_KATO).  
> 
> NVMF_OPT_KATO is completely generic, but yes, there other two are
> transport specific.  None of them calls out into other modules
> that would need dependecies, though.

Yeah, NVMF_OPT_KATO is generic. Sorry for the mistake.

> 
> I'm also a little concerned that no other in kernel user like iSCSI,
> NBD or NFS has any code like this.

Well, at least I could first remove the calls to networking APIs on the
host side. And it brings no downside.


