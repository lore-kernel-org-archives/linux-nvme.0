Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D85BD41C3A
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 05:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SJ6ELJJfhmbUTs9apopKpMWSEYOjW5u1LEYrwN9dIjI=; b=OwCqqaYTLHpKb3IJIDjCHTOXFD
	ltmz/FX+5Zvn9LQqYx7eTySD3jhrG6YXYvhsFEQ3c1D96JIlsPcFBSRngvZcsJ37u83F6DmuUK82I
	+KWQNdpeUTmDhLOPF/0nRdUus+MtoiG9Qwqls9DhBOpadcxjxn9uCK4K4WLIIpgcz6slUWz42373x
	colDpxBFRP5k7B7SZe40E0XvfR+dZKX4EojNF4rGBY2HUmNSZhO9acYYQqU8mMoO5OoXh6jphFpKe
	88bnAGzc3eda/gcwD5oXMt8vO5Qtaib80N7vfzqN/AqAqGC/N4Iwi/VA1pc08jhwNz11pM6oWm/BS
	1rvjlYpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBSBq-00000008pVu-40GC;
	Thu, 14 Nov 2024 05:14:46 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBSBp-00000008pVd-07gU;
	Thu, 14 Nov 2024 05:14:45 +0000
Date: Wed, 13 Nov 2024 21:14:45 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: use BIT_MASK and GENMASK for NVME definitions
Message-ID: <ZzWHRSFI2dS8O0sa@infradead.org>
References: <20241111170935.4540-1-ikegami.t@gmail.com>
 <ZzLZCzXfrLAP_RO8@infradead.org>
 <52a74c14-e95a-4065-9b38-8aae830ae239@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52a74c14-e95a-4065-9b38-8aae830ae239@gmail.com>
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

On Thu, Nov 14, 2024 at 12:14:33AM +0900, Tokunori Ikegami wrote:
> On 2024/11/12 13:26, Christoph Hellwig wrote:
> > > -	NVME_CMBSZ_CQS		= 1 << 1,
> > > -	NVME_CMBSZ_LISTS	= 1 << 2,
> > > -	NVME_CMBSZ_RDS		= 1 << 3,
> > > -	NVME_CMBSZ_WDS		= 1 << 4,
> > > +	NVME_CMBSZ_SQS		= BIT_MASK(0),
> > > +	NVME_CMBSZ_CQS		= BIT_MASK(1),
> > > +	NVME_CMBSZ_LISTS	= BIT_MASK(2),
> > > +	NVME_CMBSZ_RDS		= BIT_MASK(3),
> > > +	NVME_CMBSZ_WDS		= BIT_MASK(4),
> > Nothjing genmask here, and a lot less readable for no good reason at
> > all.
> Is it still no good to change BIT_MASK() to BIT()?

No, why would it be?


