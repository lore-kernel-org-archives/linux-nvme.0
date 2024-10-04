Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904D7CFA774
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Oct 2024 12:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q+5RUw4uNcQZxC2dy3F7b1o9dSlwukmucy/P+gjiWWM=; b=r2aeaSuz22JM4RmBXOwr613qzW
	/d65zBQPWEIocaX3Lk1veZm1X+Yzmlj4+0ZkRHwZ0LoYOEyEp4m97hEHIUtSWjJTCzqX+RZWErann
	vMBbvBbs7Bqcndy4mwaD/yxoGul47j9upVb8mhT8I5FzV7XkD8flduEqgC6IsA/guSDc0n1fmtA2O
	eeSVCHP3cI+5AghWLFhsBpXEkrC8fmnE3wLXXezwywFQnA6ahoUtHuArahnKjZMieaGyjrasav/DR
	xCltxKLTokKi31TO8Zow4fMcNFsxgro5ZW0Q0VhJbmcB6AOrPD3qM18vIiNydtsgN2oPX09nhR19R
	Pg35C3lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swhTf-0000000CJdP-3dBl;
	Fri, 04 Oct 2024 12:32:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swhTd-0000000CJcg-0kk1
	for linux-nvme@lists.infradead.org;
	Fri, 04 Oct 2024 12:32:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 87712227A87; Fri,  4 Oct 2024 14:32:06 +0200 (CEST)
Date: Fri, 4 Oct 2024 14:32:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Kanchan Joshi <joshi.k@samsung.com>, hare@suse.de, sagi@grimberg.me,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
	asml.silence@gmail.com, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-aio@kvack.org,
	gost.dev@samsung.com, vishak.g@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241004123206.GA19275@lst.de>
References: <20241002151344.GA20364@lst.de> <Zv1kD8iLeu0xd7eP@kbusch-mbp.dhcp.thefacebook.com> <20241002151949.GA20877@lst.de> <yq17caq5xvg.fsf@ca-mkp.ca.oracle.com> <a8b6c57f-88fa-4af0-8a1a-d6a2f2ca8493@acm.org> <CGME20241003125523eucas1p272ad9afc8decfd941104a5c137662307@eucas1p2.samsung.com> <20241003125516.GC17031@lst.de> <20241004062129.z4n6xi4i2ck4nuqh@ArmHalley.local> <20241004062415.GA14876@lst.de> <20241004065923.zddb4fsyevfw2n24@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241004065923.zddb4fsyevfw2n24@ArmHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241004_053209_385524_8B8E738F 
X-CRM114-Status: GOOD (  13.54  )
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

On Fri, Oct 04, 2024 at 08:59:23AM +0200, Javier González wrote:
> FDP has authors from Meta, Google, Kioxia, Micron, Hynix, Solidigm,
> Microship, Marvell, FADU, WDC, and Samsung.
>
> The fact that 2 of these companies are the ones starting to build the
> Linux ecosystem should not surprise you, as it is the way things work
> normally.

That's not the point.  There is one company that drivers entirely pointless
marketing BS, and that one is pretty central here.  The same company
that said FDP has absolutely no іntent to work on Linux and fought my
initial attempt to make the protocol not totally unusable ony layer system.
And no, that's not Samsung.

