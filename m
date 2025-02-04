Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B736CC0218F
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2025 05:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1qcJuEWlYhdOVNQk8D1T49twEcTNrzd2Jl5XU96g98A=; b=DAEnHwbkUey35DTt5xjkPbSGUG
	pHWb3/ey6PDhdPxJaK7twuiGENq2NteUEXbyYQ2k2VB4c7PB9QmAfEcv0ZZZ9hQlTpQQj96GDNp3p
	fLOYbSxN93cT/ZrkYwSuNrT13Ex7a9yfV5pbByyKQbKUePrpUEacqLi7bH6STSDgJwH5S11qRKdoS
	Tuo/ldMrRmOhGOcTHfTShDTSHDD1dO1Ci38lAs6VGs7MHbbBejQsYevybtRZMGID426/hYSFeq/Ji
	R5tN2ksBvnUdvlkZvHDlB3dn1lRpNNsVf9w/lSVb21p+yTx4Mk3JxUpEeUakt1rg6sVfGyJxARl/w
	Cx8Ou71w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfBn2-0000000HIqw-22Gd;
	Tue, 04 Feb 2025 05:48:04 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tfBn0-0000000HIqd-3H2A;
	Tue, 04 Feb 2025 05:48:02 +0000
Date: Mon, 3 Feb 2025 21:48:02 -0800
From: "hch@infradead.org" <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"hch@infradead.org" <hch@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <Z6GqEt9IrFHxGz_Y@infradead.org>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
 <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
 <cfe11af2-44c5-43a7-9114-72471a615de7@samsung.com>
 <df9c2b85-612d-4ca3-ad3f-5c2e2467b83f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df9c2b85-612d-4ca3-ad3f-5c2e2467b83f@suse.com>
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

On Tue, Feb 04, 2025 at 09:47:20AM +1030, Qu Wenruo wrote:
> Btrfs already has the way to disable its data checksum. It's the end users'
> choice to determine if they want to trust the hardware.

Yes.

> The only thing that btrfs may want to interact with this hardware csum is
> metadata.
> Doing the double checksum may waste extra writes, thus disabling either the
> metadata csum or the hardware one looks more reasonable.

Note that the most common (and often only supported) PI checksum
algorithm is significantly less strong than the default btrfs checksum
algorithm.


