Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB7AC54E65
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 17:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mwf+P23CSKd+lg3vtdZYz0g0GEFKW8pE4MrhtK1epSU=; b=s9Fj5zLCNBoRNewGVsFxcD80+L
	qieyeJwU/Y9H3OzbH+4YOlpan0Evg0oy043EHMAISFh4q0Xj7fflnKrxiZkQyIChPurOFbDgGWJEB
	SL6oSdTaSDsyKQkdAh6zvz5xsOKVMgR59VxJHG7I+kZGMqeO7WWuSEwYMu5Lp9upvB3iQDfxhLhoG
	62VH9KM4t7KNSPAp+nhDnuYGVW3pU1eveCQduFak1FJ/MpGjFXRFwUUwTY79TaJNS984nEGNBLZv/
	eYdZsYUHr5zs6vsdOR6+VuQUtHGZuUOg5ckNbA+IdJeD/R0RY/3ly90UZQuLCIy9IVGUluf5VNik2
	DCTuek4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI9MS-00000001hS3-0MOy;
	Thu, 22 May 2025 17:05:40 +0000
Received: from smtp-fw-52003.amazon.com ([52.119.213.152])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI9MP-00000001hRb-1aZA
	for linux-nvme@lists.infradead.org;
	Thu, 22 May 2025 17:05:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747933538; x=1779469538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mwf+P23CSKd+lg3vtdZYz0g0GEFKW8pE4MrhtK1epSU=;
  b=Cx0WBx2r1EkmtVPBa5yBuxeB5DQNL1HUbuRjanu3WXYMfN7KLaekzyXA
   MQ6lp1vXYBVXIeHA0fu8fjsYef6gCWUIg5YXnPP5gsMImX6bbO7G5NQxl
   w5zOjnsiEBs38Zyc2IruJQf3aq7IYB/BM0Yb1BtzlZeHL3+ULRk5AdTHJ
   aCQD2HztiGAKSIx7iPKGKQ2rpC0/39GulkClUNB5mSb9A3aQYCn7W4YWy
   6teo1StVJ9YPhS1RmzGC4MgLAWoU24RFjq5Rcvh2CokBW5yPAZiUVWegb
   iKhuC+j6HLEGWY0mSZ7bh28H/OgOvt5uB70sGLnHH2y7OEF8DfTMGqS4Y
   A==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; 
   d="scan'208";a="96335492"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 17:05:26 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:2008]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.213:2525] with esmtp (Farcaster)
 id 4433f7e4-b50c-4174-ab14-8accf7c1ba1b; Thu, 22 May 2025 17:05:25 +0000 (UTC)
X-Farcaster-Flow-ID: 4433f7e4-b50c-4174-ab14-8accf7c1ba1b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 17:05:25 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 17:05:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <chuck.lever@oracle.com>
CC: <axboe@kernel.dk>, <davem@davemloft.net>, <edumazet@google.com>,
	<hch@lst.de>, <horms@kernel.org>, <jaka@linux.ibm.com>, <jlayton@kernel.org>,
	<kbusch@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <linux-nfs@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-rdma@vger.kernel.org>,
	<matttbe@kernel.org>, <mptcp@lists.linux.dev>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <sfrench@samba.org>, <wenjia@linux.ibm.com>,
	<willemb@google.com>
Subject: Re: [PATCH v1 net-next 4/6] socket: Remove kernel socket conversion except for net/rds/.
Date: Thu, 22 May 2025 10:04:48 -0700
Message-ID: <20250522170512.41751-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <44b6a9b5-6bd7-48f3-927d-3188cfd726f1@oracle.com>
References: <44b6a9b5-6bd7-48f3-927d-3188cfd726f1@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.42]
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250522_100537_608230_FB263EE2 
X-CRM114-Status: GOOD (  27.09  )
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

From: Chuck Lever <chuck.lever@oracle.com>
Date: Thu, 22 May 2025 12:38:03 -0400
> On 5/22/25 4:55 AM, Paolo Abeni wrote:
> > On 5/17/25 5:50 AM, Kuniyuki Iwashima wrote:
> >> Since commit 26abe14379f8 ("net: Modify sk_alloc to not reference
> >> count the netns of kernel sockets."), TCP kernel socket has caused
> >> many UAF.
> >>
> >> We have converted such sockets to hold netns refcnt, and we have
> >> the same pattern in cifs, mptcp, nvme, rds, smc, and sunrpc.
> >>
> >>   __sock_create_kern(..., &sock);
> >>   sk_net_refcnt_upgrade(sock->sk);
> >>
> >> Let's drop the conversion and use sock_create_kern() instead.
> >>
> >> The changes for cifs, mptcp, nvme, and smc are straightforward.
> >>
> >> For sunrpc, we call sock_create_net() for IPPROTO_TCP only and still
> >> call __sock_create_kern() for others.
> >>
> >> For rds, we cannot drop sk_net_refcnt_upgrade() for accept()ed
> >> sockets.
> >>
> >> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > 
> > This LGTM, but is touching a few other subsystems, it would be great to
> > collect acks from the relevant maintainers: I'm adding a few CCs.
> > 
> > Direct link to the series:
> > 
> > https://lore.kernel.org/all/20250517035120.55560-1-kuniyu@amazon.com/#t
> 
> Thank you, Paolo, for forwarding this series.
> 
> For all hunks modifying net/sunrpc/svcsock.c and
> net/handshake/handshake-test.c:
> 
>   Acked-by: Chuck Lever <chuck.lever@oracle.com>
> 
> Regarding patch 4/6:
> 
> This paragraph in the patch description needs to explain /why/ sunrpc
> is an exception:
> 
> > For sunrpc, we call sock_create_net() for IPPROTO_TCP only and still
> > call __sock_create_kern() for others.

Sorry I noticed this sentence was not updated from the previous series.

I'll change it as follows

    For sunrpc, we call sk_net_refcnt_upgrade() for IPPROTO_TCP only
    so we use sock_create_kern() for TCP and keep __sock_create_kern()
    for others.


> 
> The below hunk doesn't seem related to the marquee purpose of this
> series. Should it be a separate patch with its own rationale?
> 
> @@ -1541,8 +1544,8 @@ static struct svc_xprt *svc_create_socket(struct
> svc_serv *serv,
>  	newlen = error;
> 
>  	if (protocol == IPPROTO_TCP) {
> -		sk_net_refcnt_upgrade(sock->sk);

The part above is related, and the below is not, using the old
style warned by checkpatch, so I cleaned it up while at it but
didn't think it's worth a patch.  I'm fine to drop it.


> -		if ((error = kernel_listen(sock, 64)) < 0)
> +		error = kernel_listen(sock, 64);
> +		if (error < 0)
>  			goto bummer;
>  	}
> 

