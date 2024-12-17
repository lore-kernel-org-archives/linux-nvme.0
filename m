Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5EAE7716A
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 04:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GXKY4ibAqf+fScHyj3FgJPIYI3um2k9fkI7luLsdvHI=; b=mYpMw3Y+dmQBptHIiLlMWB6K3G
	IhZI/XQdka501b0pY/8HfDgrTq47C+Vxzz9aFi0RoqNZCj4UB5GTo1WZNTFJjpx5hn4P3AKYRl849
	UPDdcqYRAy+fnTBmrT0MBD5Kj/VPJnlwNz0QBikb0Nm9Jw82fVTXlMDSnzZ+AFl3FvuVAG6Xlxcp/
	BaVJ6LDIbVAqg8Hpx5uVDeCTF7Tr+4G0sOXBSUolMyjbPsdyjr4qjcsH6T1RQb8nSkWXxmYG+Gk12
	5ALknOZJpCUan3PWj9y+rjxcqgiEYyfOxy9rw7KSWn+Xy6MKxdLe/EFhhkrg237QsjsRyMsDq1Ky/
	kYs7Ivtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNOrs-0000000C79k-1KmN;
	Tue, 17 Dec 2024 04:07:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNOkS-0000000C6Cc-1Blz
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 03:59:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8E68768C4E; Tue, 17 Dec 2024 04:59:43 +0100 (CET)
Date: Tue, 17 Dec 2024 04:59:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kees Cook <kees@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Cheng Xu <chengyou@linux.alibaba.com>, Kai Shen <kaishen@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Christian Benvenuti <benve@cisco.com>, Nelson Escobar <neescoba@cisco.com>, Bernard Metzler <bmt@zurich.ibm.com>, Karsten Keil <isdn@linux-pingi.de>, Michal Ostrowski <mostrows@earthlink.net>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>, Mike Christie <michael.christie@oracle.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, Namjae Jeon <linkinjeon@kernel.org>, Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, Simon Horman <horms@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, David Ahern <dsahern@kernel.org>, Joerg Reuter <jreuter@yaina.de>, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>, Alexandra Winter <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, James Chapman <jchapman@katalix.com>, Krzysztof Kozlowski <krzk@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Remi Denis-Courmont <courmisch@gmail.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Allison Henderson <allison.henderson@oracle.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, Stefano Garzarella <sgarzare@redhat.com>, Martin Schiller <ms@dev.tdt.de>, Kentaro Takeda <takedakn@nttdata.co.jp>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Guillaume Nault <gnault@redhat.com>, Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>, Andrew Morton <akpm@linux-foundation.org>, Wu Yunchuan <yunchuan@nfschina.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Maurizio Lombardi <mlombard@redhat.com>, David Howells <dhowells@redhat.com>, Atte =?iso-8859-1?Q?Heikkil=E4?= <atteh.mailbox@gmail.com>, Vincent Duvert <vincent.ldev@duvert.net>, Denis Kirjanov <kirjanov@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Huth <thuth@redhat.com>, Andrew Waterman <waterman@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>, Andrej Shadura <andrew.shadura@collabora.co.uk>, Ying Hsu <yinghsu@chromium.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Tom Parkin <tparkin@katalix.com>, Jason Xing <kernelxing@tencent.com>, Dan Carpenter <error27@gmail.com>, Hyunwoo Kim <v4bel@theori.io>, Bernard Pidoux <f6bvp@free.fr>, Sangsoo Lee <constant.lee@samsung.com>, Doug Brown <doug@schmorgal.com>, Ignat Korchagin <ignat@cloudflare.com>, Gou Hao <gouhao@uniontech.com>, Mina Almasry <almasrymina@google.com>, Abhishek Chauhan <quic_abchauha@quicinc.com>,
 Yajun Deng <yajun.deng@linux.dev>, Michal Luczaj <mhal@rbox.co>, Jiri Pirko <jiri@resnulli.us>, syzbot <syzkaller@googlegroups.com>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, linux-nvme@lists.infradead.org, open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org, target-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org, linux-hams@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, linux-s390@vger.kernel.org, rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net, virtualization@lists.linux.dev, linux-x25@vger.kernel.org, linux-security-module@vger.kernel.org, syzbot+d7ce59b06b3eb14fd218@syzkaller.appspotmail.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: Convert proto_ops::getname to sockaddr_storage
Message-ID: <20241217035943.GB14719@lst.de>
References: <20241217023417.work.145-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217023417.work.145-kees@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_195952_611054_537268C3 
X-CRM114-Status: GOOD (  12.56  )
X-Mailman-Approved-At: Mon, 16 Dec 2024 20:07:30 -0800
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

Would be nice to avoid a bunch of the overly long lines, but the
fundamental changes looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

