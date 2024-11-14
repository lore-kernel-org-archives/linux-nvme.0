Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC34D41D46
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 12:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1CfS1XyLAYhUDvGk1xddY9zhuk+Dgf74Ho6HjP9wZh4=; b=s0aLNcHG1kyu+1PpUYGXV+3QBR
	4pSrohiq0ClwR9o0HluKnelxhg6/N6EBTc4vQO45qPVEB6+qLssckbpZ7OBRnOT7Hn8BA164o3PLk
	6pl2jDaZIrFSgkk0qdL4HBaaeh/KwvytKiJCxw7qWc9rwpi3dcpIdJoia7vyzc6rnZemWEd4la5bP
	F7fSaFSzyQ3vLoCjM9XdNkY1VsAZnsuDVfoUodOwmQVddP/btYEg1kUcRSc0x6HOADV7b/sngSBba
	vIlMdGILdDvgZRcNwcNCx90i5z9wOzlk+8AD7WhQ4e9/Fjmmz57+X+ve0Iat87DKpYFO76SA+10i/
	VOuHUcVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBYmp-00000009sHW-2xr0;
	Thu, 14 Nov 2024 12:17:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBYm4-00000009sB4-1CdT
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 12:17:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0971C68C7B; Thu, 14 Nov 2024 13:16:33 +0100 (CET)
Date: Thu, 14 Nov 2024 13:16:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v9 06/11] io_uring: introduce attributes for read/write
 and PI support
Message-ID: <20241114121632.GA3382@lst.de>
References: <20241114104517.51726-1-anuj20.g@samsung.com> <CGME20241114105405epcas5p24ca2fb9017276ff8a50ef447638fd739@epcas5p2.samsung.com> <20241114104517.51726-7-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114104517.51726-7-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_041636_498868_B107110E 
X-CRM114-Status: GOOD (  11.49  )
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

On Thu, Nov 14, 2024 at 04:15:12PM +0530, Anuj Gupta wrote:
> PI attribute is supported only for direct IO. Also, vectored read/write
> operations are not supported with PI currently.

Eww.  I know it's frustration for your if maintainers give contradicting
guidance, but this is really an awful interface.  Not only the pointless
indirection which make the interface hard to use, but limiting it to
not support vectored I/O makes it pretty useless.

I guess I need to do a little read-up on why Pavel wants this, but
from the block/fs perspective the previous interface made so much
more sense.

