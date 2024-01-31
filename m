Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45865C47DDF
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 13:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RyPW6XVd2RR5+mbTG8L0WuDlJGFM9PyJgN94TlaKNoU=; b=gk9dwKYHDA5UELfb1uM2w4Vgj/
	CCmHo9wbjEoXSTVWl6VUyNLgZX81uHIrtD4L4VqMn30YYyagGgUIZ32AQgReX/dhwzDv/GTl1x2xA
	5o/Uz2fqfMvze5yYyhQmTc2TF1JQFuyeV87RxI925E31IQSJcf+I6lKVCsdw8osA91dV2FrhjT+Ov
	poMFpuS1f/qKN3Zux0GGMBpihS5NaM/m0EeUayJe+gp/3M6vosuWbfFMVoFnqMNRfQ0cR4KuaShM7
	37cIhLb6frfW+0rww4yfIpMp9oGLzVvNDqIyVLQ3imOw7E9uRhGo8+EHMSTbH6+57sImL3/a59yS7
	iuVSd6Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVAU6-00000003ZuU-300O;
	Wed, 31 Jan 2024 13:18:34 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVAU4-00000003Ztm-2TbS;
	Wed, 31 Jan 2024 13:18:32 +0000
Date: Wed, 31 Jan 2024 05:18:32 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Arthur Muller <arthur_mueller@gmx.net>
Cc: Martin Oliveira <Martin.Oliveira@eideticom.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Kelly Ursenbach <Kelly.Ursenbach@eideticom.com>,
	"Lee, Jason" <jasonlee@lanl.gov>,
	Logan Gunthorpe <Logan.Gunthorpe@eideticom.com>
Subject: Re: Error when running fio against nvme-of rdma target (mlx5 driver)
Message-ID: <ZbpIqA9eZ5YYJOPO@infradead.org>
References: <MW3PR19MB42505C41C2BA3F425A5CB606E42D9@MW3PR19MB4250.namprd19.prod.outlook.com>
 <9a40e66eb8ffc48a2e3765cf77f49914d57c55e7.camel@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a40e66eb8ffc48a2e3765cf77f49914d57c55e7.camel@gmx.net>
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

On Wed, Jan 31, 2024 at 06:34:00AM +0100, Arthur Muller wrote:
> Dear all,
> 
> We've encountered a similar issue. In our case, we are using the Lustre
> file system instead of NVMe-oF to connect our storage over the network.
> Our setup involves an AMD EPYC 7282 machine paired with Mellanox
> MT28908 cards. Following the guidelines in the Nvidia documentation:
> 
> https://docs.nvidia.com/networking/display/mlnxenv584150lts/installing+mlnx_en#src-2477565014_InstallingMLNX_EN-InstallationModes
> 
> we compiled the MLNX_EN 5.8 LTS driver using VMA. Additionally, we
> experimented with the latest MLNX_EN 23.10 driver, encountering the
> same issue. 

If you use the nvidia out of tree junk you are completely on your own
and have no one to blame but yourself.  Any problems with that do not
belong on a Linux mailing list.


