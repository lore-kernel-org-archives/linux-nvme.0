Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B245C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 07:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lo1iEKepCy/ScAdfJgT7/PYeCdFZ3Xl3/yNcX7cDQrM=; b=jQBbo6FMDfF+DT4zxUhlDWRLyT
	NTTXGkoY2cm+knUVMaHqr8wq4RVo89OcO0hl99s0c1PnjolN/fbYJpArAccfhB8CA72kj3XMpX0NP
	iMi7TX7UKn36AIaNG+P7SdumitOkfI76hIFnyRtWSXAfWGWVXKOHQI0J1Bg7mWDm7WELb9F6U4qVb
	h9qdeZ35PTJ5V+nDjc7KEZF7Mw4/YOGy7s4JSKlx4c9vODaYAXPx7XYD1q4heoz+ErIv0HUSnHf9c
	dPm4XvX5y1La10pOrM440jvqOL2nVuDG21V3Y/Qko0TtLzb76NVhVq/8QOJPrE+Dq2Fg7kdkT632T
	ZgJoZ87g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRqoU-007cIW-Gs; Wed, 09 Mar 2022 07:32:50 +0000
Received: from smtprz14.163.net ([106.3.154.247] helo=smtp.tom.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRqoQ-007cHB-VH
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 07:32:48 +0000
Received: from my-app01.tom.com (my-app01.tom.com [127.0.0.1])
 by freemail01.tom.com (Postfix) with ESMTP id CC9811E8C2AE
 for <linux-nvme@lists.infradead.org>; Wed,  9 Mar 2022 15:32:38 +0800 (CST)
Received: from my-app01.tom.com (HELO smtp.tom.com) ([127.0.0.1])
 by my-app01 (TOM SMTP Server) with SMTP ID -1736553550
 for <linux-nvme@lists.infradead.org>;
 Wed, 09 Mar 2022 15:32:38 +0800 (CST)
Received: from antispam3.tom.com (unknown [172.25.16.54])
 by freemail01.tom.com (Postfix) with ESMTP id BFE631E8C2B1
 for <linux-nvme@lists.infradead.org>; Wed,  9 Mar 2022 15:32:35 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
 t=1646811158; bh=B1TXx7YwcolI6PgRXcjcE/hEwVsy2ADYRgU4ApmkzN8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=qHTdwxtKmA/wHMBXvd8RQ7/hFKZn4gcLA1+Nn+0g/9oS3tZXn2Uvy05+0UgmtSsGH
 6651pTNzBcQJ4UIrUNB0/lF+wd8RRtCUKSwwehr51dyihBlHADaM3bc8JG5mmVmBgm
 orNk4bbKyL1ZA5Ek77cE6mx4oC7Pl1Dx0kgSpzK0=
Received: from antispam3.tom.com (antispam3.tom.com [127.0.0.1])
 by antispam3.tom.com (Postfix) with ESMTP id CAF459C1C2D
 for <linux-nvme@lists.infradead.org>; Wed,  9 Mar 2022 15:32:35 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam3.tom.com
Received: from antispam3.tom.com ([127.0.0.1])
 by antispam3.tom.com (antispam3.tom.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6ImJAnReNHvp for <linux-nvme@lists.infradead.org>;
 Wed,  9 Mar 2022 15:32:35 +0800 (CST)
Received: from localhost (unknown [101.93.196.13])
 by antispam3.tom.com (Postfix) with ESMTPA id 71EEB9C192B;
 Wed,  9 Mar 2022 15:32:34 +0800 (CST)
Date: Wed, 9 Mar 2022 15:32:33 +0800
From: Mingbao Sun <sunmingbao@tom.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
 libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 2/2] nvme-tcp: support specifying the congestion-control
Message-ID: <20220309153136.000048e1@tom.com>
In-Reply-To: <20220309061442.GA31316@lst.de>
References: <20220308151606.2563-1-sunmingbao@tom.com>
 <20220309061442.GA31316@lst.de>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_233247_200978_44580FAE 
X-CRM114-Status: GOOD (  14.80  )
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

> > @@ -1447,6 +1449,21 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
> >  	if (nctrl->opts->tos >= 0)
> >  		ip_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
> >  
> > +	if (nctrl->opts->mask & NVMF_OPT_TCP_CONGESTION) {
> > +		strncpy(ca_name, nctrl->opts->tcp_congestion,
> > +			TCP_CA_NAME_MAX-1);
> > +		optval = KERNEL_SOCKPTR(ca_name);
> > +		ret = sock_common_setsockopt(queue->sock, IPPROTO_TCP,
> > +					     TCP_CONGESTION, optval,
> > +					     strlen(ca_name));  
> 
> This needs to use kernel_setsockopt.  I also can see absolutely no
> need for the optval local variable, and I also don't really see why
> we need ca_name either - if we need to limit the length and terminate
> it (but why?) that can be done during option parsing.

Well, actually at the beginning I did use kernel_setsockopt.
But the compilation failed.

Then I found the API kernel_setsockopt disappeared from kernel v5.8.
So I use sock_common_setsockopt instead.
The birth of variable ca_name and optval is just because of the
the relevant definitions related to the prototype of
sock_common_setsockopt.

But now through thinking your comments and investigating the story of
the disappearance of kernel_setsockopt, I feel I should use
tcp_set_congestion_control instead of sock_common_setsockopt.
Just as target/tcp.c replaced kernel_setsockopt with ip_sock_set_tos.

As for the length limitation of the ca name, I will (if required) move
them into the phase of option parsing in the next version.

