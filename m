Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD9FC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 17:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-transfer-encoding:
	Content-type:In-reply-to:From:References:Cc:To:Subject:MIME-version:Date:
	Message-id:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=diO8MiigQr/mJnJgrMgnwnmeSV/eRZr21rlA7bzda5I=; b=r2/FCOqTFy5NrZMvRJJn74UF2O
	R0sA+bQPyfHuMD6diYF9k0AH4XAiBueuWn7KJClPt2Mf5ZT9ZzOh2x7EheXJePjKl3EgbLEy8ov3l
	bLjKr/mWVdX8hIH24i7JkPDqeFyAYLHozc7P2JK2LXtAuIqatatGnzAAr9LGS/vOwHOvGdx3phd6j
	mwK36/htoTD7T2idXKH+jxoNNVgJAx9p9szU9oFSWNJNK6cw77t5hWDURQQVaYp6wHT761fVqdm7P
	OGfTt2SLBOgDXlGLh3dgMNw9YwMMZdKG/1wj9tv4LZRiuUqQKYLGRFuWwkh79PEE6X5yDOtMEUHfB
	rTx+8KOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovMW1-006cpi-BF; Wed, 16 Nov 2022 17:48:01 +0000
Received: from abi149hd125.arn1.oracleemaildelivery.com ([129.149.84.125])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovMVy-006co6-0S
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 17:47:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=diO8MiigQr/mJnJgrMgnwnmeSV/eRZr21rlA7bzda5I=;
 b=x+d3z3D1WpdYnTVMjqi7lZgcNl5IAoIwv1j2uN+eoHQo81udc9huVL0xM0e8fNvSz8YNQHPQAOqy
   g3sOMoteMxTShdFWWbefSWf59vckKIBdAuTxNwS4s1mgQZEYqnzXepASiwFky8G9p1ZrA8lwF57y
   0iYis5PwTby/Ingbf3FirJqsPBxx4OYlPC9CIgDQshsDdcmpK9rHs7+YnWeBsbbVqWW66FQw4n8k
   QjMWq3bC93ftBZYrBMwucB6/3tmoKa4yfF7as5R18lh1q7mKf+6Qi8KtooAjVa8Y264jJVTK6R0R
   OV7It9ywjCbyuq13CRilYvpP4JVWiF3qX52ehg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=diO8MiigQr/mJnJgrMgnwnmeSV/eRZr21rlA7bzda5I=;
 b=cOV7QhUrmh12sUHXJhueHW5vOReBSoopCJAYw0xdLLG6f7zHm0Nuo9EUGjUT9e0W7iq3jDUDptA9
   dBfeQSCGw5EbfRobDcGuHs12qmk7SKX7lcriFWgzNsaBpZjPoZ2iJC9+ikOUFC+AbqOQgMy8a6Cq
   PY1egSJd6LKfwEAF0hsmX+JFvRVqmyZQToD8mo8BbFO05r3DQWjRh+KiRJtNd0rNtgg6MEghSrA2
   UQ8YhwaVpFJry6QdLj/Wz/UGzKkA6kyaQk2K3PRq8bca9CrO+VBQwtiX9i6AqKa2myKzpnQKTy4c
   FUOSJdIijnzNFdn9jie2QWzaMzyms/FFVvgqmQ==
Received: by omta-ad1-fd1-101-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20221104 64bit (built Nov  4
 2022))
 with ESMTPS id <0RLG00M29BVCB610@omta-ad1-fd1-101-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 17:42:48 +0000 (GMT)
Message-id: <e775398c-97bc-fc1d-a785-6d3c80bce9c6@augustwikerfors.se>
Date: Wed, 16 Nov 2022 18:42:43 +0100
MIME-version: 1.0
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G
 and 512G
Content-language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20221116171727.4083-1-git@augustwikerfors.se>
 <20221116171935.GA24524@lst.de>
From: August Wikerfors <august@augustwikerfors.se>
In-reply-to: <20221116171935.GA24524@lst.de>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta:  AAEu+0BrTkHBsWLOK63HjpEKIIURzBrIK56dK+jBm3s0DHlxjT4P2/MBeqUBNrmp
 VCVIkws4O2zsNXnjRWG/TJ823k/tfg+rw6nLav7RMGWjYpCE5E3JeGTJsjQxqqZ9
 9myAAytQh0FeJHOVlgaKTQdHbJsAIhCOkBV1rjbSnj2wM+OI+24rsIm54L8mErQS
 W1DAjsjn19Db8YGCi6TQXXaeErWaH9xZX7Vvhg24/hMGUnc/cYTX6vsLkk68blbG
 p62OBuSspPqMEBLojfVnayFEPo/WHkPUOkSxUD9G2C1yOoNiFtbnBxw9ckZ1n3Q2
 QvkEjBDk8e+zjZRvRfk9t7bCXQFU0yA7paEsgw+u4dT0W0sxGNId+W/eeh7r0ZDW
 5OqQGuXix4AC5A0bFFBRLbuiEz+k3EIVtvZ5EDK8fOLu1yV59HcbVuXhkoE/CBg3 L4z32xyHFmQ=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_094758_062420_1E3CB9D2 
X-CRM114-Status: UNSURE (   9.65  )
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

On 2022-11-16 18:19, Christoph Hellwig wrote:
> On Wed, Nov 16, 2022 at 06:17:27PM +0100, August Wikerfors wrote:
>> The Samsung PM9B1 512G SSD found in some Lenovo Yoga 7 14ARB7 laptop units
>> reports eui as 0001000200030004 when resuming from s2idle, causing the
>> device to be removed with this error in dmesg:
>>
>> nvme nvme0: identifiers changed for nsid 1
> 
> What EUI did it report before? Is the identifier stable after
> multiple resume cycles?
The original EUI is "002538e621b440e5". Using the patches from [1] and 
[2] for debugging I consistently get this output on every resume:
> eui changed from 002538e621b440e5 to 0001000200030004
[1] https://lore.kernel.org/all/20220408025704.6352-1-me@kingtous.cn/
[2] https://lore.kernel.org/all/20220408062210.GA410@lst.de/

