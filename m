Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5DFC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 13:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IGG7S45w1yatM/3T45dodBkaR1Pg2wD7wXPJD/ySgwM=; b=jAKBtApr3aTB4nJa4Kytdp5/GU
	WkkWHRlg1xcS/K8ajcAzxI5elXJsVSNMNdMHSZPIOLU7NYGsgvL9NLN+ll9tmNQ5WFxrDCMxM9dPN
	Oem8en4TiUIMCz+ukitk4khyFDXqxjLFJ0i4BnePg6NpcQw5GqmwuoWsGJouQbWK8kqe1V1t1YPk/
	Uxc8OCTnj+FfFvq6dnkykd82vTDL79C0HXIfuwy6TsV5z6SwhjdMt4BPRiEcJNW8vj8lyfwKsn1J4
	B+eFM+EqvMrjJpqxJobgkQlg6S2zFbM5g5w0DdjeYCO8QWxqs3XuOWDZ8fDwW0tcjRZnWZDVcquXi
	dPp0EgCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU7Gk-009DOI-Vw; Tue, 15 Mar 2022 13:31:23 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU7GL-009DEC-Gj
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 13:30:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 162D968AA6; Tue, 15 Mar 2022 14:30:53 +0100 (CET)
Date: Tue, 15 Mar 2022 14:30:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc: Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220315133052.GA12593@lst.de>
References: <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
 <20220314073537.GA4204@lst.de>
 <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
 <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220315132611.g5ert4tzuxgi7qd5@unifi>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_063057_783139_64AFD22F 
X-CRM114-Status: GOOD (  15.94  )
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

On Tue, Mar 15, 2022 at 02:26:11PM +0100, Javier González wrote:
> but we do not see a usage for ZNS in F2FS, as it is a mobile
> file-system. As other interfaces arrive, this work will become natural.
>
> ZoneFS and butrfs are good targets for ZNS and these we can do. I would
> still do the work in phases to make sure we have enough early feedback
> from the community.
>
> Since this thread has been very active, I will wait some time for
> Christoph and others to catch up before we start sending code.

Can someone summarize where we stand?  Between the lack of quoting
from hell and overly long lines from corporate mail clients I've
mostly stopped reading this thread because it takes too much effort
actually extract the information.

