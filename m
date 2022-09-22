Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3D8C6FA82
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 05:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NgdmLNRvrO9MsNRfGWQf+ICWwA3A5ez7cVnaWEc3V70=; b=3Olb8elVt2t1D1kxAZhB6jeZjN
	pby7CgxOGx8qYbnDZ+iIJ1PQWvnekb2sYn1sUMrYVsMg2e1lQzioja91AjcwQtEH55B0DEiDwwACs
	gv/bsTbXQ4DoRiIAJylZupVqRXvcXGV9GcxOEv7f0F895U2bKdKOHmiXW5J9/kW8amXJcNxeh4D4N
	gaRRfRfyuRHp4y76SejiuISb8I5rb2bFn4clEzgR27uDnF5vvazhgvgpgjrFfNdEoq9U1kQl2JRsN
	GJcnEa5rIMmVKw4vQ1ha1rOtc3zh1+vpiUYRfRLQYT4BZ5ncn/G7U0jh8cG7GDpnHPWEiHNDp0mz5
	HqErBzsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obF8X-00DTBR-Ke; Thu, 22 Sep 2022 05:52:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obF8V-00DTAF-9X
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 05:52:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7A4D268AFE; Thu, 22 Sep 2022 07:52:31 +0200 (CEST)
Date: Thu, 22 Sep 2022 07:52:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Rita Lin <ritach_lin@phison.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?77+9U+aZn++/vXw=?= <redd_huang@phison.com>,
	Tina Hsu <tina_hsu@phison.com>,
	Vita Hsueh =?utf-8?B?KOiWm+S8iuWAqSk=?= <Vita.Hsueh@quantatw.com>,
	"Wang, Audrey" <audrey.wang@hp.com>
Subject: Re: nvme-pci: disable write zeros support on SSDs
Message-ID: <20220922055231.GA27560@lst.de>
References: <36fd82e8780742c2881f078f98110e5e@ExMBX2.phison.com> <20220922053137.GA27191@lst.de> <53e4a6192bf746af839d8da90917a248@ExMBX2.phison.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53e4a6192bf746af839d8da90917a248@ExMBX2.phison.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_225235_490240_DBE83C83 
X-CRM114-Status: GOOD (  15.67  )
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

On Thu, Sep 22, 2022 at 05:50:52AM +0000, Rita Lin wrote:
> Dear Christoph,
> 
> Thank you for your reply.
> These SSDs do support write 0 command and the function was tested without issue.
> But since these SSDs are DRAMless products, the write 0 command will take a lot longer to complete which had impacted the product performance.
> Due to the FW had been frozen, we would like to check if we could apply CL for these 2 products.

please add a comment explaining this to the IDs entry.

