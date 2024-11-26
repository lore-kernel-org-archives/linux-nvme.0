Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8E9D5A6E2
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2024 04:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ahTfncGgNaSjejkWk0kmdB2AH0E9a3fmxL9noberQUs=; b=hn6oKeXaz2ZqvDMSnu87GAYNXR
	vLdxMm5EtZmioBIhRy4S7nttTf9gSEhSPydluxRgIGo0g2JDRMpY22JxfXQTBOOhgcap8RNjYeBbJ
	pygr83VH9FrfF1+Jm0jx0X8aM7/afdAtoyGn5LkkgGolL3j8c9vHreGHV+jEoSTUtyGdmkknUnsfO
	nUupPtbzTUlh1TQdrANZqT1759cddN4i6tbSRE7vlv9/THPvvf3TPgb9/Tir3ZAi/UF9OTnqrkVpp
	X1U2DqBWIHljsIlzK/SeZ9Xp5CRv4qvLxrBmzmxMyOppIYdIgU80R93dcPL0ZmToDrizmXsgUSnPD
	/8OTlGUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFncN-00000009dT4-2GqA;
	Tue, 26 Nov 2024 04:56:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFncK-00000009dSb-2oz9
	for linux-nvme@lists.infradead.org;
	Tue, 26 Nov 2024 04:56:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6B3DB68D09; Tue, 26 Nov 2024 05:55:57 +0100 (CET)
Date: Tue, 26 Nov 2024 05:55:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc: Keith Busch <kbusch@kernel.org>, Paul Webb <paul.x.webb@oracle.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Phil Auld <pauld@redhat.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nicky Veitch <nicky.veitch@oracle.com>
Subject: Re: [External] : Re: [bug-report] 5-9% FIO randomwrite ext4 perf
 regression on 6.12.y kernel
Message-ID: <20241126045557.GA31032@lst.de>
References: <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com> <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk> <20241121113058.GA394828@pauld.westford.csb> <a01ead6b-bd1d-4cd3-ade6-59ad905273e7@kernel.dk> <181bcb70-e0bf-4024-80b7-e79276d6eaf7@oracle.com> <20241122121304.GA25877@lst.de> <188e08f4-2eb3-41ad-a331-63fd5bb0e7f6@oracle.com> <14F95ECE-2AB7-4A50-AE45-C98EC426312C@oracle.com> <Z0Dy8H0A3Wj45ZQn@kbusch-mbp.dhcp.thefacebook.com> <CD26086B-67EE-4A62-AABF-3068252B158A@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CD26086B-67EE-4A62-AABF-3068252B158A@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_205604_853209_C170C5B1 
X-CRM114-Status: UNSURE (   8.63  )
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

Hi Saeed,

can you please also test I sent yesterday?


