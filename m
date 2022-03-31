Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71DFC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Mar 2022 05:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R/GKA8fg0A1xmIXWtrQM8WHV2FCdOqYEpK5w1vjnWx4=; b=qLej7GPvD0oHMgzryz3ZYZc3wt
	9cdWevEwSwEWir0eQ4t8g5KK1InKgz1Ld6Y9NW1Atc6aR8UaKj+qZTntPc960UNfALJjNMvHCYs9U
	G93DS5fDqifCbDOKUGWYnSaX6/kOp6ImBLVgr6mmtyIT252qu531jULvr78+1GNL7lxKYeFWCZaiY
	azemyRve3f/RNu2ul2XW1RNx/C4gtKrdPHhEkBKKSvAtdnkjb4Jd7SulNQiOHiydi7U9EVGgbXXbf
	GtfkPoFwCZ9FThREd6shntB6SOCepGFOIY8quanMIYHlLWU8r9PrezNwALOs4PsfsqYDo0PPReSMe
	XIgMOD5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nZnRQ-000i3g-3s; Thu, 31 Mar 2022 05:33:52 +0000
Received: from smtprz01.163.net ([106.3.154.234])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nZnRL-000i2e-Pj
 for linux-nvme@lists.infradead.org; Thu, 31 Mar 2022 05:33:50 +0000
Received: from localhost (localhost [127.0.0.1])
 by vip-app02.163.net (Postfix) with ESMTP id 5D1314400CD
 for <linux-nvme@lists.infradead.org>; Thu, 31 Mar 2022 13:33:45 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1648704825; bh=R/GKA8fg0A1xmIXWtrQM8WHV2FCdOqYEpK5w1vjnWx4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Z1i2Flc+yAz6KboBjV1ub4vDF/bDmMNTM4Vq9UWMQNdc9vgUV6wSZ2V9++fVYcawI
 KnZ98AxZKpb3glKi3jgD3zZlfAQvV8WnY4K0XN+TPV1XTPIgncRwZhSY3YWhhRDyRK
 6pHO+SOymmb8jJChobA7NQegYM2LC2Gx2u4Do644=
Received: from localhost (HELO smtprz01.163.net) ([127.0.0.1])
 by localhost (TOM SMTP Server) with SMTP ID 415619944
 for <linux-nvme@lists.infradead.org>;
 Thu, 31 Mar 2022 13:33:45 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at mxtest.tom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1648704825; bh=R/GKA8fg0A1xmIXWtrQM8WHV2FCdOqYEpK5w1vjnWx4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Z1i2Flc+yAz6KboBjV1ub4vDF/bDmMNTM4Vq9UWMQNdc9vgUV6wSZ2V9++fVYcawI
 KnZ98AxZKpb3glKi3jgD3zZlfAQvV8WnY4K0XN+TPV1XTPIgncRwZhSY3YWhhRDyRK
 6pHO+SOymmb8jJChobA7NQegYM2LC2Gx2u4Do644=
Received: from localhost (unknown [101.93.196.13])
 by antispamvip.163.net (Postfix) with ESMTPA id AAC541540B7C;
 Thu, 31 Mar 2022 13:33:42 +0800 (CST)
Date: Thu, 31 Mar 2022 13:33:41 +0800
From: Mingbao Sun <sunmingbao@tom.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, Hideaki
 YOSHIFUJI <yoshfuji@linux-ipv6.org>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
 libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 2/3] nvme-tcp: support specifying the congestion-control
Message-ID: <20220331133341.00002f70@tom.com>
In-Reply-To: <15f24dcd-9a62-8bab-271c-baa9cc693d8d@grimberg.me>
References: <20220311103414.8255-1-sunmingbao@tom.com>
 <20220311103414.8255-2-sunmingbao@tom.com>
 <7121e4be-0e25-dd5f-9d29-0fb02cdbe8de@grimberg.me>
 <20220325201123.00002f28@tom.com>
 <b7b5106a-9c0d-db49-00ab-234756955de8@grimberg.me>
 <20220329104806.00000126@tom.com>
 <15f24dcd-9a62-8bab-271c-baa9cc693d8d@grimberg.me>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220330_223348_248844_BAC6E873 
X-CRM114-Status: UNSURE (   6.47  )
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

OOOPS, my mail service has got some issues.
Sorry for the duplicated emails.

