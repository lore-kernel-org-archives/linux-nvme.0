Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4190C35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 12:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sv+mHNyRfEyGTB6TT8cZbkUG6r1En2QM+Hm0QRQPupM=; b=HqFbb8yIphzlVQMvCwj517SO8C
	m+0RJ83Bpso6Izv6dxV9XuAegLR2TYjr4dmvhPZZA+RZIbQ74JzAEGTZdo57m7u/8wvFQ86SHShqU
	vObUxntGnZS831W8dQUO+y1coByfNgJzDsQHYi8U+2Z4y044U1c5V1YLh5kCJiGnREnhfvcXVJDSu
	fhMQRNTQC45YEeXC+yEZY/Amze6jL42dccludqUK0aF7k2Z2y35ZFQ8l54HYDHFvp5wMYKLpFyt6e
	F4SeJ8c6NvI1mRDCigSosa7KsiAAin5dxZhhz8X3j4GLb2fPMPvkp/LOoJcp4O+uC+R8C6TbheRmh
	Pd4yq2cQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGIc5-002rWG-1z;
	Thu, 21 Dec 2023 12:57:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGIc2-002rUx-0J
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 12:57:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AEB9768B05; Thu, 21 Dec 2023 13:57:13 +0100 (CET)
Date: Thu, 21 Dec 2023 13:57:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, jaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20231221125713.GA24013@lst.de>
References: <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com> <20231219051456.GB3964019@frogsfrogsfrogs> <20231219052121.GA338@lst.de> <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com> <20231219151759.GA4468@lst.de> <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com> <20231221065031.GA25778@lst.de> <b60e39ce-04bf-4ff9-8879-d9e0cf5d84bd@oracle.com> <20231221121925.GB17956@lst.de> <df2b6c6e-6415-489d-be19-7e2217f79098@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df2b6c6e-6415-489d-be19-7e2217f79098@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_045718_274382_450AB98A 
X-CRM114-Status: GOOD (  14.86  )
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

On Thu, Dec 21, 2023 at 12:48:24PM +0000, John Garry wrote:
>>> - ubuf / iovecs need to be PAGE-aligned
>>> - each iovec needs to be length of multiple of atomic_write_unit_min. If
>>> total length > PAGE_SIZE, each iovec also needs to be a multiple of
>>> PAGE_SIZE.
>>>
>>> I'd rather something simpler. Maybe it's ok.
>> If we decided to not support atomic writes on anything setting a virt
>> boundary we don't have to care about the alignment of each vector,
>
> ok, I think that alignment is not so important, but we still need to 
> consider a minimum length per iovec, such that we will always be able to 
> fit a write of length atomic_write_unit_max in a bio.

I don't think you man a minim length per iovec for that, but a maximum
number of iovecs instead.  For SGL-capable devices that would be
BIO_MAX_VECS, otherwise 1.

