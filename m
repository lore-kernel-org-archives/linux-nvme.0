Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF7EC61DA4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 05:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iqR0sTCKXAJYEZpaEeN7K2yXpFMi/k6UTD/kCt1XVfU=; b=Nkb+y38A5rRstqpK37KxcoAvtp
	n8I6/SJamvu9Or9Arlws0z9gCe/m2WsPYijkXS312qm4hI2cWjZmm3Wodt8tmmnyT7bM9PND/DX7B
	qX1gQIidh3zlz2R/afYtMCvwFvhzYqPBfVY0OBUMUvPqSyLMkE3Blo54cM0ROHSb9YX3JJR9d/dvj
	SRTmhF/EsLugmvFnzkvJ6e8ZKHtl/n8Ncqxw3LZsKcnj9LK4B0EnvYju8a4ehCJ7tiry4+teH5lHw
	e5Xu1DrepVzujFFACQAqyoUw1w5XUSk1QRCX5SXczaX3h46HWYinRoWc6Jirg8jGPSpmTmjiVpvlg
	GZzdLQVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcJsa-00CRGE-2k;
	Wed, 15 Mar 2023 05:40:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcJsY-00CREH-0c
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 05:40:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B552268AA6; Wed, 15 Mar 2023 06:40:42 +0100 (CET)
Date: Wed, 15 Mar 2023 06:40:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, bvanassche@acm.org,
	martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
	dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
	kbusch@kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH v4 07/18] nvme: Fix reservation status related structs
Message-ID: <20230315054042.GA29433@lst.de>
References: <20230224174502.321490-1-michael.christie@oracle.com> <20230224174502.321490-8-michael.christie@oracle.com> <20230314171538.GG6780@lst.de> <c9082d55-7009-279a-fde1-7f774fb7e6e8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9082d55-7009-279a-fde1-7f774fb7e6e8@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230314_224050_442660_1DF20099 
X-CRM114-Status: GOOD (  10.11  )
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

On Tue, Mar 14, 2023 at 05:23:16PM -0500, Mike Christie wrote:
> We could do separate structs though:

I suspect that's probably better in the long run, as the [0] notation
is on its way out.

