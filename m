Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9E1C54F47
	for <linux-nvme@archiver.kernel.org>; Fri, 23 May 2025 18:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ae8iei/MxNZ1GAywSlI3IUvxi3FmxgZOmA0ImXXwfDo=; b=hc5dvbIg8IAYgot4eIZ5fA9tPg
	bXdSpFhhbM+5p8G0fAjngo0W2302RJNyz7Z93+EbrgAXp0hE/g8QBB9GJObcns7u/4OdCpw17wFLm
	jCQ84hlBcUbPp0UwxwcuvcTLFz/3j3ap1QVHYA6W3RvT3hNh7xSDqgN1QVrNijAUqlSxqgsCjcfdv
	sFcsa2Ssf4GKKTDifm58KUJTonb9hfasyVY/wOcdxjPlypmw8sjlxr4uJEqeHFdQnSgsv2bFGoHCC
	2Ih+1XNk2zaK90eoir3JklRGwT8jhk7/KOUJpKalDHfABYY1+jYoBUt/QXeFGMrNDB+kg4Ao/7Ulf
	pyzr2M8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIX3r-00000004fW4-1ldg;
	Fri, 23 May 2025 18:24:03 +0000
Received: from smtp-fw-52003.amazon.com ([52.119.213.152])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIX3P-00000004fOl-0wnm
	for linux-nvme@lists.infradead.org;
	Fri, 23 May 2025 18:23:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1748024615; x=1779560615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ae8iei/MxNZ1GAywSlI3IUvxi3FmxgZOmA0ImXXwfDo=;
  b=Cnyrt2qKD4cjzF5CcI9m0FcrqCNdnTBakgyPqqs2aYfj8wzJUjksSu9V
   MdmXZ+KUDO2kZ5KpuULlYZMO6yeQRsIA3H+aiYoBwObXRmRiSbghbdYcl
   1/R652SdsOwtTRuvWVUx9rSfbZcaFt8Vr57/FfuHj8WvFxF1Di/D3BTGe
   6biHOvvqCtl5rvUhg90Q6lpsv1g8qQbxZ3OHNamvuRmk0Z6dgSvQWaKdH
   aVRx0+xNzp3n1cyZ9Gff0lVUAHjw5/jz+eqywwZehxfxqfxoZ/r65gwwP
   +1HG9r5Xzihe3Uxg0IEPn+N4yOsjjQX4XHZVQVutcESZCN8w4NpPXsq+F
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,309,1739836800"; 
   d="scan'208";a="96732876"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 18:23:28 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:47636]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.22:2525] with esmtp (Farcaster)
 id f65fbf90-224c-415e-a7b2-3925684c748d; Fri, 23 May 2025 18:23:27 +0000 (UTC)
X-Farcaster-Flow-ID: f65fbf90-224c-415e-a7b2-3925684c748d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 23 May 2025 18:23:27 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.204.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 23 May 2025 18:23:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
	"Keith Busch" <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher
	<jaka@linux.ibm.com>, Steve French <sfrench@samba.org>,
	<netdev@vger.kernel.org>, <mptcp@lists.linux.dev>,
	<linux-nfs@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <stable@vger.kernel.org>
Subject: [PATCH v2 net-next 4/7] smb: client: Add missing net_passive_dec().
Date: Fri, 23 May 2025 11:21:10 -0700
Message-ID: <20250523182128.59346-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523182128.59346-1-kuniyu@amazon.com>
References: <20250523182128.59346-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.142.204.12]
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250523_112335_417536_F5D86E2D 
X-CRM114-Status: GOOD (  10.06  )
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

While reverting commit e9f2517a3e18 ("smb: client: fix TCP timers deadlock
after rmmod"), I should have added net_passive_dec(), which was added
between the original commit and the revert by commit 5c70eb5c593d ("net:
better track kernel sockets lifetime").

Let's call net_passive_dec() in generic_ip_connect().

Note that this commit is only needed for 6.14+.

Fixes: 95d2b9f693ff ("Revert "smb: client: fix TCP timers deadlock after rmmod"")
Cc: <stable@vger.kernel.org> # 6.14.x
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 fs/smb/client/connect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 37a2ba38f10e..afac23a5a3ec 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3359,6 +3359,7 @@ generic_ip_connect(struct TCP_Server_Info *server)
 
 		sk = server->ssocket->sk;
 		__netns_tracker_free(net, &sk->ns_tracker, false);
+		net_passive_dec(net);
 		sk->sk_net_refcnt = 1;
 		get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
 		sock_inuse_add(net, 1);
-- 
2.49.0


