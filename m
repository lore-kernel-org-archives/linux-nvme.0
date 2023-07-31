Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE7EC00528
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 19:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o/bEuTZ+CTmZ0ooY2LBoGlqPkcANf2TOfCfH91248XM=; b=hQq1MDIKRxsQXcpA38bc+zk2iu
	wy7POzs5YF8ukW8RjkL5NmeqvnH36D9wufgPF7ZmKk6q57XVzpsUQDghLwioPYhXmgURP8M5ZP/hq
	4z0FBev7smU7E1tLv+D+fUlL2faH/j6rbnYNPJXgBIqSsZ/am9sEb6bLtezmiGeymzkhDn67m1RKb
	uL/j4kkgSX7WxpBUg51XTS8vqQocpQl2/ueiQxz1O7ve3sktvKuSuP9c9pDxV0GYSdobfj/gRDdpA
	tFQXGrjQ7OLdKiw/GoM/To70sqz0GPke2YwyDA87FT1qv3H8J+dUJ1q4DJzUkOmXn2l3zNLYcvIgu
	ARKUgWNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQYik-00H8ZV-2y;
	Mon, 31 Jul 2023 19:38:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQYih-00H8YL-2a
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 19:38:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2EF8368AA6; Mon, 31 Jul 2023 21:38:13 +0200 (CEST)
Date: Mon, 31 Jul 2023 21:38:13 +0200
From: "hch@lst.de" <hch@lst.de>
To: Varun Prakash <varun@chelsio.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Rakshana S <rakshanas@chelsio.com>
Subject: Re: [PATCH] nvmet-tcp: pass iov_len instead of sg->length to
 bvec_set_page()
Message-ID: <20230731193813.GA13587@lst.de>
References: <20230727150550.5851-1-varun@chelsio.com> <d0badb81-782c-52c8-2b05-06ca6c696157@grimberg.me> <BN9PR12MB532469A81B5D3F6C297F91C9BC05A@BN9PR12MB5324.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR12MB532469A81B5D3F6C297F91C9BC05A@BN9PR12MB5324.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_123820_028000_1A648639 
X-CRM114-Status: UNSURE (   9.51  )
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

On Mon, Jul 31, 2023 at 06:30:33PM +0000, Varun Prakash wrote:
> checkpatch.pl was reporting following CHECK warning so I fixed the alignment.

checkpatch.pl is unfortunately not much more useful than Markus Elfring
these days.  Opening brace alignment is a common style and makes sense
in some places, but tab-based alignment often is much easier to maintain.


