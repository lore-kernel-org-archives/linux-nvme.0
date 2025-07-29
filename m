Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C133DC83F26
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jul 2025 10:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lg3wPxjd/SerzBNwxTH7tFhGgsh8mMPrkCq9OZTxf+I=; b=ozwBOcUaienfdbw/9EAPFtVH2V
	rBz2SbYAl0zOpoEe5EjVDNgp2yQ1CbQJJo8kTCqcQuNVuCVch7K4p/eJ3e/RpY7ChuS1v4ggEtmQU
	4+bUEQN4eQ+l+S89JnqfXRpYHb1ZXuzPOla5hznnJr7hZaW1fLZdhyp6MeHs4LMeOoDgvSlkOuh+n
	3Ae2B1enp8vZ7nz1mQPLeR7YekVYdS8o+WMw4186lC6HR3iQYNSA2e84ZdC6vOFi0/kyJ4KHauM2J
	iiU0Q99YM6QgyfpjDBAOZvlQCcE2GM2Nw69dG17BTvyYIkHayRk9XvniNFc2s9DfsFnv7Ok1mzqwg
	ociKjE5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ughWr-0000000GWJB-0GeL;
	Tue, 29 Jul 2025 10:25:53 +0000
Received: from [203.254.224.25] (helo=mailout2.samsung.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ughWm-0000000GWI0-3Bc4
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 10:25:51 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250729102537epoutp02a52eb4725df6b0763846d0aa45834392~Wse1K10pP2772727727epoutp02W
	for <linux-nvme@lists.infradead.org>; Tue, 29 Jul 2025 10:25:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250729102537epoutp02a52eb4725df6b0763846d0aa45834392~Wse1K10pP2772727727epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753784737;
	bh=Lg3wPxjd/SerzBNwxTH7tFhGgsh8mMPrkCq9OZTxf+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ltAZJh8X1M34rB0zS7EvOEypRhWkDniqM/3yD5eZtAxOobXDYNy9jIQt8biPGHs/7
	 MQooLIE0lo50VnJrfy8wYLSmyJoxbxIKRpjen3DJqDo6iwblnAOS3/T0hEUNHvppwQ
	 EJn1nMnOpVwe1pJP+VBr0aHjw9XIITbic8nty1EE=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250729102537epcas5p214ca14d5197c5d23f2992d1876177184~Wse0240X11631216312epcas5p2J;
	Tue, 29 Jul 2025 10:25:37 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.94]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4brs1X439sz3hhT4; Tue, 29 Jul
	2025 10:25:36 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250729102527epcas5p165b73185cadb10d38b3213fcbf931159~WsereKcfS2666926669epcas5p19;
	Tue, 29 Jul 2025 10:25:27 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250729102525epsmtip2acf59cc937e893fd98db5c3180d7ccb4~WseqNEUth0444404444epsmtip2q;
	Tue, 29 Jul 2025 10:25:25 +0000 (GMT)
Date: Tue, 29 Jul 2025 15:55:05 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, Hannes
	Reinecke <hare@kernel.org>, Daniel Wagner <dwagner@suse.de>, Randy Jennings
	<randyj@purestorage.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: Initialize discovery subsys after debugfs is
 initialized
Message-ID: <20250729102505.lxot5ka473gh4uyh@green245.gost>
MIME-Version: 1.0
In-Reply-To: <20250725205005.1983426-1-mkhalfella@purestorage.com>
X-CMS-MailID: 20250729102527epcas5p165b73185cadb10d38b3213fcbf931159
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----OUxkrUiS_5tNAtfPKy2OQMQtEkPPDXVoOsIej.5k6A4J0mxM=_4fed2_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250729102527epcas5p165b73185cadb10d38b3213fcbf931159
References: <20250725205005.1983426-1-mkhalfella@purestorage.com>
	<CGME20250729102527epcas5p165b73185cadb10d38b3213fcbf931159@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_032549_423864_52D276FD 
X-CRM114-Status: UNSURE (   8.79  )
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

------OUxkrUiS_5tNAtfPKy2OQMQtEkPPDXVoOsIej.5k6A4J0mxM=_4fed2_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 25/07/25 01:50PM, Mohamed Khalfella wrote:
>During nvme target initialization discovery subsystem is initialized
>before "nvmet" debugfs directory is created. This results in discovery
>subsystem debugfs directory to be created in debugfs root directory.
>
>nvmet_init() ->
>  nvmet_init_discovery() ->
>    nvmet_subsys_alloc() ->
>      nvmet_debugfs_subsys_setup()
>
>In other words, the codepath above is exeucted before nvmet_debugfs is
>created. We get /sys/kernel/debug/nqn.2014-08.org.nvmexpress.discovery
>instead of /sys/kernel/debug/nvmet/nqn.2014-08.org.nvmexpress.discovery.
>Move nvmet_init_discovery() call after nvmet_init_debugfs() to fix it.
>
>Fixes: 649fd41420a8 ("nvmet: add debugfs support")
>Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
>---

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------OUxkrUiS_5tNAtfPKy2OQMQtEkPPDXVoOsIej.5k6A4J0mxM=_4fed2_
Content-Type: text/plain; charset="utf-8"


------OUxkrUiS_5tNAtfPKy2OQMQtEkPPDXVoOsIej.5k6A4J0mxM=_4fed2_--

