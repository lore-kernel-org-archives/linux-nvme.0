Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B262C54EDA
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 16:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q83a3aOAlFEsUBxycxiFP+NkK9i6pWmdjvMN3DiYJEA=; b=iBaT8eskkw/myzy6P2DmiWGTUJ
	CCV0YL04A/9/DYyVnaCD8o/YGP2T+jilkI7f/j/dMARlSmfcsEr4NQWgkmAzfmX2jVPRv9Gwyl8YX
	0lau8IaJFyEcojS6AwGXrxWGOWNjWNp3idD42FHklci2nUknMOlSYz2BJGsgGkJyBc+pqOgdLP38p
	0uypN/oNUa02TphRaAV7vRPn0GjSn4B+v+2BFH7V+Th3wIWqykqMkAvTj6pTCRVoGgL34gNgzPG42
	aOQN0gJZoekC3y8z9M6MSCss2qGAojTolyh8ipKsz5ENEieRnK1EQZT040J095Le9gvDY7t3yimz8
	J9xID5JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI8m3-00000001ZCn-3YBL;
	Thu, 22 May 2025 16:28:03 +0000
Received: from smtp-fw-80008.amazon.com ([99.78.197.219])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI8XL-00000001Xjw-1Rih
	for linux-nvme@lists.infradead.org;
	Thu, 22 May 2025 16:12:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747930371; x=1779466371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q83a3aOAlFEsUBxycxiFP+NkK9i6pWmdjvMN3DiYJEA=;
  b=gSHtKwksHSKiApdlZWEBvEJvpM/2gT9z1Bwy1Rln+8sEJat774CUQk/f
   Tie4d0owVdEwmqPUQgS41gApwXgbGqOqTp94GUI1+0/Ya4wMb1SVurXph
   FobK+vYk6a3NlF2bgTovlIrYXAafrhMDle7Bc3Iiw7DkQkNsnYPcTQ6Be
   z+K4HjPVi7OfsT0StGaJv3tUE2pkw6aGaxpupPVdThyvsNPsqFXcNlkQw
   8dr6NTPOYH3EmONJ8iis0cedlSn7vuh511wbuBUI8E3wZ7RSHjxiD6xY8
   FXK0FPGy9kbcB/ENk1lT44ebczWK0NYZIpDK7aESUnbTFgZGEmUhsL0qX
   A==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; 
   d="scan'208";a="199907297"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 16:12:48 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:57322]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.185:2525] with esmtp (Farcaster)
 id 5dac8cde-4bb0-4f29-b099-51b167a264c8; Thu, 22 May 2025 16:12:48 +0000 (UTC)
X-Farcaster-Flow-ID: 5dac8cde-4bb0-4f29-b099-51b167a264c8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 16:12:47 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 16:12:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <axboe@kernel.dk>, <chuck.lever@oracle.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <hch@lst.de>, <horms@kernel.org>,
	<jaka@linux.ibm.com>, <jlayton@kernel.org>, <kbusch@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<linux-nfs@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	<linux-rdma@vger.kernel.org>, <matttbe@kernel.org>, <mptcp@lists.linux.dev>,
	<netdev@vger.kernel.org>, <sfrench@samba.org>, <wenjia@linux.ibm.com>,
	<willemb@google.com>
Subject: Re: [PATCH v1 net-next 4/6] socket: Remove kernel socket conversion except for net/rds/.
Date: Thu, 22 May 2025 09:12:22 -0700
Message-ID: <20250522161235.32989-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <7a965a97-a6d0-462f-b7dd-8833605ea7c9@redhat.com>
References: <7a965a97-a6d0-462f-b7dd-8833605ea7c9@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.32]
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250522_091251_433693_4B59E8D4 
X-CRM114-Status: GOOD (  24.40  )
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

From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 22 May 2025 10:55:47 +0200
> On 5/17/25 5:50 AM, Kuniyuki Iwashima wrote:
> > Since commit 26abe14379f8 ("net: Modify sk_alloc to not reference
> > count the netns of kernel sockets."), TCP kernel socket has caused
> > many UAF.
> > 
> > We have converted such sockets to hold netns refcnt, and we have
> > the same pattern in cifs, mptcp, nvme, rds, smc, and sunrpc.
> > 
> >   __sock_create_kern(..., &sock);
> >   sk_net_refcnt_upgrade(sock->sk);
> > 
> > Let's drop the conversion and use sock_create_kern() instead.
> > 
> > The changes for cifs, mptcp, nvme, and smc are straightforward.
> > 
> > For sunrpc, we call sock_create_net() for IPPROTO_TCP only and still
> > call __sock_create_kern() for others.
> > 
> > For rds, we cannot drop sk_net_refcnt_upgrade() for accept()ed
> > sockets.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> This LGTM, but is touching a few other subsystems, it would be great to
> collect acks from the relevant maintainers: I'm adding a few CCs.
> 
> Direct link to the series:
> 
> https://lore.kernel.org/all/20250517035120.55560-1-kuniyu@amazon.com/#t
> 
> > diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
> > index 37a2ba38f10e..c7b4f5a7cca1 100644
> > --- a/fs/smb/client/connect.c
> > +++ b/fs/smb/client/connect.c
> > @@ -3348,21 +3348,14 @@ generic_ip_connect(struct TCP_Server_Info *server)
> >  		socket = server->ssocket;
> >  	} else {
> >  		struct net *net = cifs_net_ns(server);
> > -		struct sock *sk;
> >  
> > -		rc = __sock_create_kern(net, sfamily, SOCK_STREAM,
> > -					IPPROTO_TCP, &server->ssocket);
> > +		rc = sock_create_kern(net, sfamily, SOCK_STREAM,
> > +				      IPPROTO_TCP, &server->ssocket);
> >  		if (rc < 0) {
> >  			cifs_server_dbg(VFS, "Error %d creating socket\n", rc);
> >  			return rc;
> >  		}
> >  
> > -		sk = server->ssocket->sk;
> > -		__netns_tracker_free(net, &sk->ns_tracker, false);
> > -		sk->sk_net_refcnt = 1;
> > -		get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
> > -		sock_inuse_add(net, 1);
> 
> AFAICS the above implicitly adds a missing net_passive_dec(net), which
> in turns looks like a separate bugfix. What about adding a separate
> patch introducing that line? Could be in the same series to simplify the
> processing.

Thanks for catching!

Will add this patch before this change.

---8<---
commit c7ff005fe4d930169f319aca0bd9577541cd7459 (HEAD)
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Thu May 22 16:03:29 2025 +0000

    smb: client: Add missing net_passive_dec().
    
    While reverting commit e9f2517a3e18 ("smb: client: fix TCP timers deadlock
    after rmmod"), I should have added net_passive_dec(), which was added between
    the original commit and the revert by commit 5c70eb5c593d ("net: better track
    kernel sockets lifetime").
    
    Let's call net_passive_dec() in generic_ip_connect().
    
    Note that this commit is only needed for 6.14+.
    
    Fixes: 95d2b9f693ff ("Revert "smb: client: fix TCP timers deadlock after rmmod"")
    Cc: <stable@vger.kernel.org> # 6.14.x
    Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 37a2ba38f10e..afac23a5a3ec 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3359,6 +3359,7 @@ generic_ip_connect(struct TCP_Server_Info *server)
 
                sk = server->ssocket->sk;
                __netns_tracker_free(net, &sk->ns_tracker, false);
+               net_passive_dec(net);
                sk->sk_net_refcnt = 1;
                get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
                sock_inuse_add(net, 1);
---8<---

