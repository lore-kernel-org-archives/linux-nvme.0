Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12755C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 08:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NFmCIWEXhzE5OtGgFzJKunwe8TfGwn+kd4PxAFgyPb4=; b=UhQJrBwSzrCvb5Ln91s6hR6gri
	Sre9d2P0zMd3os5EK9CA+b7aHjMTgK8IHIRFZ4dej3HaJm4mpdW5aY+EaUn+KFMbdUb0S39Kxjiv0
	a/WhmVqOK1bHCvzcsiHnl3FSmvB3aCHBDl18CuKRzn8RnOpRqPw+XFJryF03379+a5XbXFs/ZNk6C
	M8GID7kgDhyselbYzw8TeGzgj8NCCbssw4Esks4K3lPOhNLIsbwNFqTf7eMMxiYU8o2aYj/Z3xnl3
	VpgJDaqgW3Jj2dT3jXyHCTiUaE97dQtgsz0bph03fo2jqF3atuZ+aW+Q25DOoG32hMj5jZGuBeP2t
	o5EQH1mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSazT-00Fhxr-Dd; Fri, 11 Mar 2022 08:51:15 +0000
Received: from smtprz01.163.net ([106.3.154.234] helo=smtp.tom.com)
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSawF-00FgLr-Bw
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 08:48:00 +0000
Received: from localhost (localhost [127.0.0.1])
 by vip-app02.163.net (Postfix) with ESMTP id 5454044019C
 for <linux-nvme@lists.infradead.org>; Fri, 11 Mar 2022 16:47:53 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1646988473; bh=AEFZVAJwucJ2wHyqaL/XbxD7jUYcLxvLBDGo8y7nOI4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=5nn0Ihcgi0xdvTkX90xPeSHrWZLwKsKkpZkScq81Fy2jHRlxDJHN/kCVI1oGIT3Xz
 Lop/I3nqxGDJ7TsvQmfspUGKOyge3htkNVTbhlWRLmhoB4lcVOVP+v5BMl/bASOlau
 Bl1jObpBkM3hsCqmWR44b3Q/ZYCfoZ9zS5BXFm3c=
Received: from localhost (HELO smtp.tom.com) ([127.0.0.1])
 by localhost (TOM SMTP Server) with SMTP ID -1277494478
 for <linux-nvme@lists.infradead.org>;
 Fri, 11 Mar 2022 16:47:53 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at mxtest.tom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1646988473; bh=AEFZVAJwucJ2wHyqaL/XbxD7jUYcLxvLBDGo8y7nOI4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=5nn0Ihcgi0xdvTkX90xPeSHrWZLwKsKkpZkScq81Fy2jHRlxDJHN/kCVI1oGIT3Xz
 Lop/I3nqxGDJ7TsvQmfspUGKOyge3htkNVTbhlWRLmhoB4lcVOVP+v5BMl/bASOlau
 Bl1jObpBkM3hsCqmWR44b3Q/ZYCfoZ9zS5BXFm3c=
Received: from localhost (unknown [101.93.196.13])
 by antispamvip.163.net (Postfix) with ESMTPA id 1C8C815414F8;
 Fri, 11 Mar 2022 16:47:49 +0800 (CST)
Date: Fri, 11 Mar 2022 16:47:48 +0800
From: Mingbao Sun <sunmingbao@tom.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, Hideaki
 YOSHIFUJI <yoshfuji@linux-ipv6.org>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
 libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH 2/3] nvme-tcp: support specifying the congestion-control
Message-ID: <20220311164748.00000217@tom.com>
In-Reply-To: <20220311071518.GB18222@lst.de>
References: <20220311030113.73384-1-sunmingbao@tom.com>
 <20220311030113.73384-3-sunmingbao@tom.com>
 <20220311071518.GB18222@lst.de>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220311_004755_826828_8D2FDAFA 
X-CRM114-Status: GOOD (  14.40  )
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

On Fri, 11 Mar 2022 08:15:18 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, Mar 11, 2022 at 11:01:12AM +0800, Mingbao Sun wrote:
> > +		case NVMF_OPT_TCP_CONGESTION:
> > +			p = match_strdup(args);
> > +			if (!p) {
> > +				ret = -ENOMEM;
> > +				goto out;
> > +			}
> > +
> > +			kfree(opts->tcp_congestion);
> > +			opts->tcp_congestion = p;  
> 
> We'll need to check that the string is no loner than TCP_CA_NAME_MAX
> somewhere.
> 

accept.
will do that in the next version.
this would also be applied for the target side.

> >  
> > +	if (nctrl->opts->mask & NVMF_OPT_TCP_CONGESTION) {
> > +		ret = tcp_set_congestion_control(queue->sock->sk,
> > +						 nctrl->opts->tcp_congestion,
> > +						 true, true);  
> 
> This needs to be called under lock_sock() protection.  Maybe also
> add an assert to tcp_set_congestion_control to enforce that.

accept.
will handle it in the next version.
this would also be applied for the target side.
Many thanks for reminding.

as for the assertion, I failed to find a conventional way to do that.
would you like to give me a suggestion?


