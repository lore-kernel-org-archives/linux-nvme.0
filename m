Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A531E7717D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2024 21:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Xth0sFL6XMzp3/V1ztZznDsvIdAdic2yOuGaJJzYg4=; b=swfTivjY5ZMW321YRdKL9Q32wl
	8uUnSsqxo1vVQwpW9T/Xsso6pxuehFeOdswW148dq56ApfdYICOElR1AyVnH5AA9DomgKWzgGENFa
	BeMNCc4CXoqm+ZRGaH1D2bkyHvMFHpjFfPqfE9qPj5W+HYIev8cHg0BWf6xQkkkgZpNExSolrrCSR
	HGMazNXChVNjznvS0Vebus0FNWzZuD77tzRnb+Y3CMNGPG7BKN+Mrx8Q15UaLq71foTqMzRDHNHtT
	81VWlO/xc0xoPz/j3NgPmZutRJ9nuNyJHJidsIJVLasiPbEPJdhEs6wxvOWfMaqQQce7MAFKB+H+5
	mJRKAbtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLU9X-0000000GAM1-2xMT;
	Wed, 11 Dec 2024 21:21:51 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLU9V-0000000GAKM-02nQ
	for linux-nvme@lists.infradead.org;
	Wed, 11 Dec 2024 21:21:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 906C45C6393;
	Wed, 11 Dec 2024 21:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C98C4CEDD;
	Wed, 11 Dec 2024 21:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733952107;
	bh=IaVdboK9++5RQ3hFpt89sE9pHIWJBLcZbpQWyCDkaME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M36mERpSl2KG6yGOKVFPVUFiFJoJmnzxAr9I9L0WRvuAX9uAMuEwLz0+1j5JVZivX
	 980NduCXsymeKnFsx+atJRTapwFUrOe9lfsH9y+ryYZYSPAUAwBlbFpTsw70lRABVN
	 CrlfulJbyhNZ+n0BHHUZiftbqrf+PqCwsbRHR00oOynDbcF76Xy+PW9tvdG9iWUWO7
	 dsAcCE2tmN3aKOWA4w2MaDqy7C/O3UyRXScbhCnxNAhncze022rUqPFlfFmp6wTfUI
	 ATi05tkiy0cSiSAw7rPPjseZuS1empUiTdZdTuNNZ/GyLEhodhPC7IdjVwWH9sIgRF
	 pzOluCzKOlsoA==
Date: Wed, 11 Dec 2024 21:21:44 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, hch <hch@lst.de>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Javier Gonzalez <javier.gonz@samsung.com>,
	Matthew Wilcox <willy@infradead.org>,
	Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"joshi.k@samsung.com" <joshi.k@samsung.com>
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Message-ID: <Z1oCaLF8-xclgFB_@google.com>
References: <yq1jzcov5am.fsf@ca-mkp.ca.oracle.com>
 <CGME20241205081138epcas5p2a47090e70c3cf19e562f63cd9fc495d1@epcas5p2.samsung.com>
 <20241205080342.7gccjmyqydt2hb7z@ubuntu>
 <yq1a5d9op6p.fsf@ca-mkp.ca.oracle.com>
 <20241210071253.GA19956@lst.de>
 <2a272dbe-a90a-4531-b6a2-ee7c4c536233@wdc.com>
 <20241210105822.GA3123@lst.de>
 <a10da3f8-9a71-4794-9473-95385ac4e59f@acm.org>
 <6ff84297-d133-48d4-b847-807a75cab0f6@kernel.org>
 <97ed9def-7dfd-4170-9e60-6c081da409bc@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97ed9def-7dfd-4170-9e60-6c081da409bc@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_132149_088660_D1AF7787 
X-CRM114-Status: GOOD (  12.57  )
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

On 12/11, Bart Van Assche wrote:
> On 12/10/24 8:07 PM, Damien Le Moal wrote:
> > But for F2FS, the conventional unit is used for metadata and the other zoned LU
> > for data. How come copying from one to the other can be useful ?
> 
> Hi Damien,
> 
> What you wrote is correct in general. If a conventional and zoned LU are
> combined, data is only written to the conventional LU once the zoned LU
> is full. The data on the conventional LU may be migrated to the zoned LU
> during garbage collection. This is why copying from the conventional LU
> to the zoned LU is useful.
> 
> Jaegeuk, please correct me if I got this wrong.

Bart is correct. It doesn't make sense forcing to use conventional LU for
metadata only, but shows the remaining conventional LU space to user as well.
In order to do that, we exploited the multi-partition support in F2FS by
aligning the section to zoned partition offset simply.

> 
> Bart.

