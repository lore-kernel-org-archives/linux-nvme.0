Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97AEC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Dec 2022 07:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c5cfLkp5anOaD3mKWcYrfV3SlVQjX35rneDw1IRAz08=; b=EVEyx5nob83T1OcO6f87YzEMt4
	0XbF3a2v7MIsgAcO7cf7dcpOfBXZiEq1W4Mj47v5r7cN6mkYqyMrZQNcjfBj7x0k1dX4yoriMJ+pG
	Iy583zuY4QxyRdb8v5AncwhzRl6ovk/W4IodqAqHwPRie3PXKNgwfjOrNEVRCTrNYScHLTLR6Lb2W
	jS5V3Cfiix4YYc/6GkZUiVI4I4CeIUlGaRzCmgLwS265op/2ueD+T7ZDhg0U77sWLKa+JTJtsJDNX
	0JFYVKYYGpSxAL2Fi1SO+ATruOgiAZaASp1mtW1+6sdzRWrEcahf5i0aWLrrUyX8Q94iOP3Zi6pyH
	u8EX4AKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4dgY-009jct-9b; Mon, 12 Dec 2022 07:57:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4dgU-009jYB-KI
	for linux-nvme@lists.infradead.org; Mon, 12 Dec 2022 07:57:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A09EB68AA6; Mon, 12 Dec 2022 08:57:07 +0100 (CET)
Date: Mon, 12 Dec 2022 08:57:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Dong, Eddie" <eddie.dong@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Rao, Lei" <lei.rao@intel.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@fb.com" <axboe@fb.com>, "kch@nvidia.com" <kch@nvidia.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"yishaih@nvidia.com" <yishaih@nvidia.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Li, Yadong" <yadong.li@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"Wilk, Konrad" <konrad.wilk@oracle.com>,
	"stephen@eideticom.com" <stephen@eideticom.com>,
	"Yuan, Hang" <hang.yuan@intel.com>
Subject: Re: [RFC PATCH 5/5] nvme-vfio: Add a document for the NVMe device
Message-ID: <20221212075707.GD11162@lst.de>
References: <20221206130901.GB24358@lst.de> <Y49JNvdmRPNWw26q@ziepe.ca> <20221206140002.GB27689@lst.de> <Y49PqoAhZOeraLVa@ziepe.ca> <20221206143126.GB30297@lst.de> <Y49WNo7XWZ2aFfds@ziepe.ca> <20221206150131.GA32365@lst.de> <Y49fjFD6foGorhmp@ziepe.ca> <20221206153546.GA2266@lst.de> <BL0PR11MB3042F27C99080E4B51318B338A1B9@BL0PR11MB3042.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR11MB3042F27C99080E4B51318B338A1B9@BL0PR11MB3042.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221211_235710_855390_A04DE091 
X-CRM114-Status: GOOD (  12.15  )
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

On Tue, Dec 06, 2022 at 06:00:27PM +0000, Dong, Eddie wrote:
> NVMe spec is general, but the implementation details (such as internal state) may 
> be vendor specific. If the migration happens between 2 identical NVMe devices 
> (from same vendor/device w/ same firmware version), migration of 
> subsystem-wide state can be naturally covered, right?

No.  If you want live migration for nvme supported in Linux, it must
be speced in the NVMe technical working group and interoperate between
different implementations.

