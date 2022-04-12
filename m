Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04848C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 05:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GZ/ocTaut2ObL0eW8nSoeVPz8pfCA0UR3sS9vdppdls=; b=DrBflbWE7Uv+T9GB2ehXj6RYJv
	iNts52XtESRossF2SMEKTj41hB4OHy3MWhJ5DrpeRlLZkMq4BlcQMx4W/YGeLd6cBVtJDIUtdOrEJ
	vW62zV7uFp1TGrYL9O1FrETpWe5VpvKdHQQqteCTr9D9W9P0xAu458jmwFYTGRsff7OAX4QDNLNKp
	Pjwvo0IUWXVkfY08sKu/t7V/ywglxNQFLS/8Q7gioTLNEPc02H/sNOAJA/lsq5U6KOgV5y7CmEHHS
	BZlRWixfFIQQb+IGUUDi4wcu8SfIIqfOme6mvorh0C7ZfEQwnp0tKjsvMJPD3fGggRLzDmtLo7A3U
	ebBN2wFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ne8i1-00BkGa-0i; Tue, 12 Apr 2022 05:04:57 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ne8hu-00BkEA-Ga
 for linux-nvme@lists.infradead.org; Tue, 12 Apr 2022 05:04:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E7F2568AA6; Tue, 12 Apr 2022 07:04:41 +0200 (CEST)
Date: Tue, 12 Apr 2022 07:04:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: =?utf-8?B?6YeR6Z+s?= <me@kingtous.cn>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, axboe@fb.com, sagi@grimberg.me,
 kingtous <kingtous@qq.com>
Subject: Re: [PATCH] fix: nvme_update_ns_info method should be called even
 if nvme_ms_ids_equal return false
Message-ID: <20220412050441.GA5311@lst.de>
References: <20220408080721.GA2888@lst.de>
 <YlBSO/vH7DjE6kC9@kbusch-mbp.dhcp.thefacebook.com>
 <20220408160424.GB27746@lst.de>
 <21ac620f-d234-13a1-0de7-e3ec1b3272db@kingtous.cn>
 <20220409044351.GA17212@lst.de>
 <33f34253-4418-e16a-89fb-92257749cf3f@kingtous.cn>
 <20220411054945.GA14311@lst.de>
 <dc6e8c8c-7eaf-f502-207c-4907ce58a474@kingtous.cn>
 <20220411060746.GA14519@lst.de>
 <2c504d2e-5c64-72fb-c26b-e086588ecd8d@kingtous.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c504d2e-5c64-72fb-c26b-e086588ecd8d@kingtous.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_220450_741023_A6B8C552 
X-CRM114-Status: GOOD (  13.33  )
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

On Mon, Apr 11, 2022 at 10:20:13PM +0800, 金韬 wrote:
> btw, I checked the patch code, I noticed "MAXIO MAP1202" is hard coded in 
> pci.c. I think not only MAP1202 has the problem mentioned in this thread, 
> but also "MAXIO MAP1002"(Gloway Basic 1T NVMe SSD, which has the same 
> suspend issue).

If you can verify it has the issue we can add a quirk for it as well.

