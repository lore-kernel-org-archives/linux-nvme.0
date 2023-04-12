Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B83C7619A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Apr 2023 11:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p13YqXFGOIdtBHJwC2qwzAyWz6Qgh6+2djuWpFQo3gg=; b=vqcWrXjPll0dLN+m69uIqnZ0RU
	EazQ8yX3gxKSnpHSYIko8fjRYDosahq2U68JL934gJbQlTm8o1TMcJU67qrn/D833kVaV2FRnkPF7
	Iwhp5FD5JbTSPPFqH1h4PZykZ5u+3hvoTS+pZAQFwkUEQTVd5ci3NzSCHsv3FU6Lg/RIlQyZ9bEbU
	yYJyXSChw++3Mk9AzP4hf3SH0j/HAAhSQI8hBAPkDL/pHSUH/nOX9RQu6wN0uAFykBYgDk5b9se7B
	SG5wN2LLXDhdHBoHshmI+/r37d05wmHU8pFQWx3or3Eb3fz+nFTDOEcAy45U9liN/ZmDFBplbhTj1
	9AbZARNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmYzF-002wKS-04;
	Wed, 12 Apr 2023 11:50:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmYzC-002wJ5-06
	for linux-nvme@lists.infradead.org;
	Wed, 12 Apr 2023 11:50:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A191668AA6; Wed, 12 Apr 2023 13:49:55 +0200 (CEST)
Date: Wed, 12 Apr 2023 13:49:55 +0200
From: "hch@lst.de" <hch@lst.de>
To: Jinyoung CHOI <j-young.choi@samsung.com>
Cc: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@fb.com" <axboe@fb.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: (2) [PATCH 2/2] nvme-pci: fix metadata mapping length
Message-ID: <20230412114955.GA9786@lst.de>
References: <20230412065736.GB20550@lst.de> <20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p8> <CGME20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p1> <20230412071230epcms2p145d53bfc8e40eede25f282b80247218c@epcms2p1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412071230epcms2p145d53bfc8e40eede25f282b80247218c@epcms2p1>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230412_045002_219689_971E9304 
X-CRM114-Status: GOOD (  12.61  )
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

On Wed, Apr 12, 2023 at 04:12:30PM +0900, Jinyoung CHOI wrote:
> I agree with you.
> I think the problem is bio_integrity_add_page().
> If it is modified, sg functions for blk-integrity should also 
> be modified.
> 
> If you think the blk-integrity modification is better, 
> I will send an mail to block mailing after modifying it.

Please wait for feedback from Martin.

