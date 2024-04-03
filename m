Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CC7CD128A
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 12:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OWfrzzyqj+1lKysFE1UJDX4WEwGmXDzkjY20Waip+k8=; b=IkU/y2n1XLGHyCtXkJOvamXnGa
	UNhjtmg5eayUPGPJ30rH3dRGO8m691nRRFLvEcwCdqFNzXgNmgxWkA0Jl3+6cXFE/HPm7erJp3kp5
	6NsgqSI03PRnjnB+NrnRKZ/zfhU+YYRLywi1uMC0qS0JJiqPZtfB3D4NQevGjORk+iPxGWAksPbiK
	7U3kXhjBjy2VYV2KPrkyo/By35iB68HV8pPhMo02Ckwddez/d7lJcj4MNKsJDc+DBrKmysra9Qj/r
	CDka6dpm+M24FhNZuXxcqVqq+OR+NOMIMS7zcI+1lkbVV7hKffIK4M2oH1KNAFBlGkMjscl/yGgwa
	PRu6wgSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrzxP-0000000FzCl-18Z2;
	Wed, 03 Apr 2024 12:43:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrzxC-0000000FzBU-0nTx
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 12:42:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8DB5D68BFE; Wed,  3 Apr 2024 14:42:55 +0200 (CEST)
Date: Wed, 3 Apr 2024 14:42:55 +0200
From: "hch@lst.de" <hch@lst.de>
To: Dongyang Li <dongyangli@ddn.com>
Cc: "joshi.k@samsung.com" <joshi.k@samsung.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"hch@lst.de" <hch@lst.de>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC]
 Meta/Integrity/PI improvements
Message-ID: <20240403124255.GA19272@lst.de>
References: <CGME20240222193304epcas5p318426c5267ee520e6b5710164c533b7d@epcas5p3.samsung.com> <aca1e970-9785-5ff4-807b-9f892af71741@samsung.com> <yq14jdu7t2u.fsf@ca-mkp.ca.oracle.com> <ab32d8be16bf9fd5862e50b9a01018aa634c946a.camel@ddn.com> <0c54aed5-c1f1-ef83-9da9-626fdf399731@samsung.com> <d442fe43e7b43d9e00c168f91dcfddd5a240b366.camel@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d442fe43e7b43d9e00c168f91dcfddd5a240b366.camel@ddn.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_054258_501377_049EAE44 
X-CRM114-Status: UNSURE (   6.74  )
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

In kernel use is easy, we can do that as soon as the first in-kernel
user comes along.  Which one do you have in mind?


