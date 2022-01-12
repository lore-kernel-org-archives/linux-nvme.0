Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A1BC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jan 2022 14:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ywDbQfCcrcxDrcUPt9nHdMGXf5ZZLyd9/Zw7iqyLYOo=; b=sAq8tQCclZLFnYEu6zkR7ITwNg
	U5ktSlZhbYHI7L2jGGqmKmjDaC4oWdqsvArSyKHzeNApcXHMvuMNezNQhl2uGuCbPf1BsueJ+tpq1
	klYt1d3R683zDsB3AfBxjV2uHuojGeWej4ZaAcFGDd+GwFXW1uuedToou0T064sjCmkN8y9g3QPsi
	gCLdEyrhxaJV1xLFWYlBRlAXbUOuAWgcaqjkbau6Ku+KlLZZIKwnVxLYycTmQLPbHVPvPzykHc6mi
	eWSB/aTWjs7gTrqWkdbZBcFqTdJ62RYlBnB4c0lchW5QvKf0YOFvCv7q2Vxm0Ias9Djk3+B+4KxkQ
	UcbIs/3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n7eDZ-002fXF-Qp; Wed, 12 Jan 2022 14:03:13 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n7eDW-002fV3-Ka
 for linux-nvme@lists.infradead.org; Wed, 12 Jan 2022 14:03:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6626768AFE; Wed, 12 Jan 2022 15:03:04 +0100 (CET)
Date: Wed, 12 Jan 2022 15:03:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, axboe@fb.com,
 sagi@grimberg.me, Rajat Jain <rajatja@google.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Mark external NVMe devices as removable
Message-ID: <20220112140304.GA27446@lst.de>
References: <20220112013154.1210480-1-kai.heng.feng@canonical.com>
 <20220112071659.GA4502@lst.de>
 <CAAd53p4+WjhPM6VKZOZKQ4WcgNWjR7Eh_7Kjs1HZ_wiKov6Ctw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p4+WjhPM6VKZOZKQ4WcgNWjR7Eh_7Kjs1HZ_wiKov6Ctw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220112_060310_847393_EE195AA9 
X-CRM114-Status: GOOD (  10.36  )
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

On Wed, Jan 12, 2022 at 08:50:33PM +0800, Kai-Heng Feng wrote:
> USB thumb drives also use this flag, so I am not sure why it's not
> applicable to NVMe?

They shouldn't report this flag and might need fixing.

