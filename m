Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA531C25B76
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 05:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=25m3KIGLmguUC8/pQLLfTfUUYokxVK5unna2aPd6ENo=; b=vw5Q3nwoCUv0gIxhJcAyIwl1ec
	r3j2l6i0971GaYXoKNtTgcLhyLgmYKVnOtM5U/N15Q9P4LCimGXqTBX9kGL3nTItzZwtd5xEqPIHm
	ti388YZ/kkwATLaJsd6Ov8Ezzz0UuPuJ/NAvsABJqKOD/3EyVGcwUl4rNQyj84TKiLQcVgKIj3afE
	qVu506tdpuMDPR+cX+9qQ86h1OAy44nCC/9DcIfzLRexmARa2FrezWaOxRrh+op0yh68JDtpOpoqj
	0mM9062AsLLLe2rDC60DE0W918KwEEnRnE05gsohVBKqDLA+cEtCWJDlVFPxteiW5W/WpfoC40o3e
	EAMKe5pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGtya-00000007TYk-47Bc;
	Tue, 11 Jun 2024 05:23:21 +0000
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGilW-00000005y5O-0nYn
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jun 2024 17:25:08 +0000
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7954f8b818fso7750585a.1
        for <linux-nvme@lists.infradead.org>; Mon, 10 Jun 2024 10:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718040304; x=1718645104; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=25m3KIGLmguUC8/pQLLfTfUUYokxVK5unna2aPd6ENo=;
        b=bo5xPvJqDxt5OYGClimMLSNEzJ2tNbVBC9gCuhTfSrg+glyFZWWRmAE+pJ6vClRknr
         VXhsxH70p1PWN0tbCeYBS+QIFvXx8At2M7xnXFRgWqA4r2glYYH6VcSgFMznYxs8p99w
         RMvre0R44NpEx5XRHZx0QF4tdWQ5BEX6G8uaxXJoa8mDZwHebovXKTnFvu2D8mwK6dGD
         b0AvgQ9fiDrQIh2Mw6HiYNl2/ytq+kk9nyFknHhofoVDdhpx0IkGx9INbQDz1fEQ51oO
         y5ir6JCf/yLf0MsQdL6EW07KiuwG2ddWgCrZX/gdPP6e+4mRwZsysD2ITFt7F0aHpL/M
         sKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718040304; x=1718645104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25m3KIGLmguUC8/pQLLfTfUUYokxVK5unna2aPd6ENo=;
        b=JifKjzrbM41fDe2BHiELEvofkKYO7Lr2ONWXJ8ghWiar0HpPa1jwjsNLlTWKxO8Gph
         D17xFSXW7nxIv6rxZsHPgnYmg4M96889XSNwjuyc1WASO2xRIKaZ33nrUbFjb9SZz2ZN
         FWoX7diHpZkrAfp64XcfuYlaEMtuQae/L5Dr+AmaZQ6J0PqgIIVmASKjRI6y1FnUR1hp
         VasfWFMBfEIENQPuwXqVaRQq62NAov9h9xB5o8ZHx2aQ4MtGVMNLj7q6muifKG4Fwgx1
         6aRw3iQtgZnJ5A3lAEyMkJu896xT7qb9akboPmvrvUkdVyCT7LHrR+5qHzQwE6S3dXjg
         /gWA==
X-Forwarded-Encrypted: i=1; AJvYcCW0Ey88cpvIueUcaubbxjkreeZ+5Uuircnv9fxlzhX8tBLUeI7rhn/dw3DadtQUW7QdvoTIx4nEGmQHZ8B/N/JucT5Ak8qspfqL98+fyDg=
X-Gm-Message-State: AOJu0Yz7b2QAJfKSRpghIEgFpfQ57qzUSJfIbAarzuG3l8xeBLDg9P/b
	DvCxWXjrfT32yM3+aN1kNleyeo3lmf4hQmpJ7SikMakP64yQkJVqLSQGU/zbQqg=
X-Google-Smtp-Source: AGHT+IERiQrm9SUSeQMdKlpq1AJrD/6cpiXXPM5R7XiNqEGctS72ZsZ7Qn7LPR52HM49FztB2xw/bQ==
X-Received: by 2002:a05:620a:2949:b0:795:60ba:76a3 with SMTP id af79cd13be357-79560ba7949mr495154685a.12.1718040304159;
        Mon, 10 Jun 2024 10:25:04 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7958e85b6b3sm134283285a.100.2024.06.10.10.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 10:25:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sGilR-00EocS-4l;
	Mon, 10 Jun 2024 14:25:01 -0300
Date: Mon, 10 Jun 2024 14:25:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Zeng, Oak" <oak.zeng@intel.com>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"Brost, Matthew" <matthew.brost@intel.com>,
	"Hellstrom, Thomas" <thomas.hellstrom@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	"Bommu, Krishnaiah" <krishnaiah.bommu@intel.com>,
	"Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two steps
Message-ID: <20240610172501.GJ791043@ziepe.ca>
References: <cover.1709635535.git.leon@kernel.org>
 <SA1PR11MB6991CB2B1398948F4241E51992182@SA1PR11MB6991.namprd11.prod.outlook.com>
 <20240503164239.GB901876@ziepe.ca>
 <PH7PR11MB70047236290DC1CFF9150B8592C62@PH7PR11MB7004.namprd11.prod.outlook.com>
 <20240610161826.GA4966@unreal>
 <PH7PR11MB7004A071F27B4CF45740B87E92C62@PH7PR11MB7004.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB7004A071F27B4CF45740B87E92C62@PH7PR11MB7004.namprd11.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_102506_370418_7F461E7B 
X-CRM114-Status: GOOD (  12.70  )
X-Mailman-Approved-At: Mon, 10 Jun 2024 22:22:01 -0700
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

On Mon, Jun 10, 2024 at 04:40:19PM +0000, Zeng, Oak wrote:
> Thanks Leon and Yanjun for the reply!
> 
> Based on the reply, we will continue use the current version for
> test (as it is tested for vfio and rdma). We will switch to v1 once
> it is fully tested/reviewed.

I'm glad you are finding it useful, one of my interests with this work
is to improve all the HMM users.

Jason

