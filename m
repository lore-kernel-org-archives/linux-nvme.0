Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2933DC04FDE
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Dec 2022 08:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c4d7/iJve2JRdCjgVOhYmb7Bw9eBUNAGReYZ99FlBEY=; b=eTjqbP497nxwkOtvwo/beM6V1w
	dJaX1jb4bNPJrgPuAOjaoJpTnMOAg7nO58GqgvJ0byDxzrUVf3rpyRRPVN/EE2l2uY7kCdwCcvszj
	K61BQAvWJbyMLH4zl/nR2bBXa3u0gQ6npjieAOtzTZWOI6evIPG1DU6TJPOr8s7mtdm1IYmqfP3iQ
	jvdBEMt6tEAiTOEPgIgceh6oOvEm/hRRU/SyjSqzkJ54oX2tiMva25SsN0HQgeECLG2hNJyiPyE66
	kEpfT8cuNAMsXCx+JP0BdMOehrkM9dTgyh/LBLz5eer0DsKet8n9bJq+htvMZjOmnTRZtpyK6Vg7C
	Vp9CQr7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4du5-009sVW-EK; Mon, 12 Dec 2022 08:11:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4du2-009sSd-0q
	for linux-nvme@lists.infradead.org; Mon, 12 Dec 2022 08:11:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2A70467373; Mon, 12 Dec 2022 09:11:07 +0100 (CET)
Date: Mon, 12 Dec 2022 09:11:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Li, Yadong" <yadong.li@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, "Rao, Lei" <lei.rao@intel.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@fb.com" <axboe@fb.com>, "kch@nvidia.com" <kch@nvidia.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"yishaih@nvidia.com" <yishaih@nvidia.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Dong, Eddie" <eddie.dong@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"Wilk, Konrad" <konrad.wilk@oracle.com>,
	"stephen@eideticom.com" <stephen@eideticom.com>,
	"Yuan, Hang" <hang.yuan@intel.com>
Subject: Re: [RFC PATCH 5/5] nvme-vfio: Add a document for the NVMe device
Message-ID: <20221212081106.GB11892@lst.de>
References: <20221206055816.292304-1-lei.rao@intel.com> <20221206055816.292304-6-lei.rao@intel.com> <20221206062604.GB6595@lst.de> <Y48+AaG5rSCviIhl@ziepe.ca> <20221206130901.GB24358@lst.de> <BN9PR11MB5276EBF06791EF7B39648FA48C1C9@BN9PR11MB5276.namprd11.prod.outlook.com> <BL1PR11MB602591A00CE052373BB47EBCFE1C9@BL1PR11MB6025.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB602591A00CE052373BB47EBCFE1C9@BL1PR11MB6025.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221212_001110_223063_E7A44D27 
X-CRM114-Status: GOOD (  11.58  )
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

On Fri, Dec 09, 2022 at 04:53:47PM +0000, Li, Yadong wrote:
> The key leadership in NVMe WG, Peter and Nick (from Intel), are on top of this TPAR,
> and help influence the scope of the TPAR to better support IPU/DPUs.

You guys should talk more to each other.  I think Peter especially has
been vocal to reduce the scope and not include this.

