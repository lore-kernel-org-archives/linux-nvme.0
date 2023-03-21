Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED086C74A5B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 15:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FRsGJETOfZfEOMJyL92ZXZc5vveIJKtccEVQZm5V/ns=; b=faXo5jEsuXK3nWUUwnpN5fLRNM
	ToQmMUhsVJl88n0sND5GRKL3KY27FzvMG0zmIXtp88PtIEFny3/3YdL9dzt+mzEaGfkmDegyFLnN2
	e219NBM4C5Avcppr8/7Zjr7N5ajm+vYTULrhSCL9RVCoKRCur/j5tcaa7Fc8U54Y6ZaogW0JmVBGF
	P0syqxlhMtwWOw5iskketbQF4jzoUXYpfI6RRo/UqYK9gWT55Mz1fjqge6mvTJYMHNwReZMMfOcF2
	6NUkWymaknNJ1TTnOq9RwZthiPDt8PP9fX6mzvWuXf9JGDGeQCk5U7VlwpaNDyVgsqpKnv+UL74MH
	2kQ81Myg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pedTp-00CpYF-2h;
	Tue, 21 Mar 2023 15:00:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pedTm-00CpW9-0G
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 15:00:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5AA1368B05; Tue, 21 Mar 2023 16:00:42 +0100 (CET)
Date: Tue, 21 Mar 2023 16:00:41 +0100
From: "hch@lst.de" <hch@lst.de>
To: Lei Lei2 Yin <yinlei2@lenovo.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cybeyond@foxmail.com" <cybeyond@foxmail.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbRXh0ZXJuYWxdIFJl?=
 =?utf-8?B?OiBbUEFUQ0hdIG52bWU6IGZp?=
 =?utf-8?Q?x?= heap-use-after-free and oops in bio_endio for nvme
 multipath
Message-ID: <20230321150041.GA21056@lst.de>
References: <PS1PR03MB493948DD1ECFAF150EE7B2F688819@PS1PR03MB4939.apcprd03.prod.outlook.com> <042385ef-285e-5179-941b-ab37f490c1d8@grimberg.me> <PS1PR03MB49395AC5BC73DDDA6A79E87488819@PS1PR03MB4939.apcprd03.prod.outlook.com> <56620baf-6195-b987-6067-ae81d23e39c5@grimberg.me> <PS1PR03MB4939A124F814F35E69C7D59B88819@PS1PR03MB4939.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS1PR03MB4939A124F814F35E69C7D59B88819@PS1PR03MB4939.apcprd03.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_080050_260523_EFD8E254 
X-CRM114-Status: UNSURE (   9.24  )
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

On Tue, Mar 21, 2023 at 01:30:18PM +0000, Lei Lei2 Yin wrote:
> 
> 	No, I have not verified this issue with a system larger than 5.10.y(such as 5.15.y and 6.0 or furthor), because some function we need like cgroup in upper version kernel has changed too much, we can't use these upper version kernel.

If you can't reproduce on in a non-tained upstream kernel it's entirely
your own problem to deal with.  Please don't waste the upstream
maintainers resources.

