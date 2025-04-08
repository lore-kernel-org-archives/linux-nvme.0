Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B67FC369A4
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 05:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W94j31G+r8Y0Cd8KcgC93GsP943xgufSZZHy829yDhA=; b=fAVzVNwKwlU6/HHkCCuY+KVXog
	dFF0Q/EfjEJyO4yTLIrWzDCEYKQZdTL78cIVpF73m758X5KY1YEx25PxkUDdr/L9TviJQexYhFBFs
	xHoMRxe5Rci9Tin/SMuFhpSwOa2q2+eNIRdBn5sy+CowGpyWvnTOzamTExj+8dLbKLfqrsj+cCkvC
	cKeG+NaYDdxGr8X93PsFvurpZqzijL6QWl9NruvS1d2Dr2TUgLA8w/ebpBI64XwCBLTN1TPiow7Dd
	ad49Le9gMCAhjtgHanrv+xm5P06UrtGfcil28Hkul76qhJuptatshdrcHK0fuYIGxPt8Me8Pv2IT0
	b/ilILEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u21zN-00000002pTG-0JO7;
	Tue, 08 Apr 2025 05:59:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u21yn-00000002pO7-2Kcu
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 05:58:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 96D1F67373; Tue,  8 Apr 2025 07:58:30 +0200 (CEST)
Date: Tue, 8 Apr 2025 07:58:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: hch@lst.de, axboe@kernel.dk, gechangzhong@cestc.cn, kbusch@kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org, sagi@grimberg.me, shaopeijie@cestc.cn,
	zhang.guanghui@cestc.cn
Subject: Re: [PATCH v2] nvme-tcp: Fix netns UAF introduced by commit
 1be52169c348
Message-ID: <20250408055830.GA708@lst.de>
References: <20250408050408.GA32223@lst.de> <20250408055549.16568-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408055549.16568-1-kuniyu@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_225837_732876_D010F99D 
X-CRM114-Status: GOOD (  10.11  )
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

On Mon, Apr 07, 2025 at 10:55:27PM -0700, Kuniyuki Iwashima wrote:
> Which branch/tag should be based on, for-next or nvme-6.15 ?
> http://git.infradead.org/nvme.git

nvme-6.15 is the canonical tree, but for bug fixes I'm fine with
almost anything :)

