Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8EFC47082
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 17:10:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 519B0611CD
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 17:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519B0611CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mljsRJbKmnTYQXEnN+crk3kXrKWQdbbYRpXnnWWrQ70=; b=DRXSBE9M02y0mx
	MGKeKfSgnvzENRjAx+B4UjLpSAanTG05PaS0dBvRTVcZ0FCOi86Hn51m/QrKf9t6P7KONUDozaogR
	MMip6OeN9d/1HNv5eCHB34jphJXkGcqJmwzkLMaJXrw9UjumLPmYYmVgOCsQnXtCWjtKPxrYoz9wp
	GtbxY/WmA8RkIoQE+swRQ04AMRSLlNhmlEtbxZGgOI0Nmu0baqJqjVYTiRyuTFb2VTtHbgzRSHmra
	1sgQ1+eAW8KQrn+9TqhXUJ54JtYi/+3kGMl5I6AnWl1qke2SvSzyslH7j2nbTfm4Y4Xnspk73xQLv
	gAJf9gKMgdb5RAScPLGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llx3D-00G045-KW; Wed, 26 May 2021 17:10:35 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llvxq-00FZhT-V9
 for linux-nvme@bombadil.infradead.org; Wed, 26 May 2021 16:00:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=SKd4GBKcXR4J+TiznbuwSyw7wfecY85AHFnO+15pJ64=; b=wFRzxMsFXB6V3Yg2Zujaw5HZlA
 cl5O1bdWQun/wweAcsOehNSieOd2lZb0/msqrPj8uAZX4FO0t8oyT5ejYQ7AzRHysOuEs1H1URwOv
 HJG5c2ydTMDRPBzIEoBnbIvkk+6Y4EYrjkybCcL862/YAY0t1pSnxwSYSRihQu+Gmecakf8VqIAh3
 WxthkuoPrkoWvo+EBf2YwE+982VcXgGcYIOtsMn6phLhRbtcyZSFh5sSnD5YHcxWQsBzurOF4KNSo
 23vOO4gO9pvRMpX0VRr2jI5jlffDdfZhObgwTV4ckH6UA3/Liyx2D1mxhsUM43QoE0Q+e/B03RlED
 ApZQYaiw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1llvx1-004g7e-HO; Wed, 26 May 2021 16:00:13 +0000
Date: Wed, 26 May 2021 17:00:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
 "Walker, Benjamin" <benjamin.walker@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Israel Rukshin <israelr@nvidia.com>
Subject: Re: [bug report] nvme sends invalid command capsule over rdma
 transport for 5KiB write when target supports MSDBD > 1
Message-ID: <YK5wh91yAcOlu+3J@infradead.org>
References: <BYAPR11MB2824E1B94D81B837E474A7A6EF269@BYAPR11MB2824.namprd11.prod.outlook.com>
 <dc96c3cf-e895-77c0-3d1a-1bc7e96cfd40@grimberg.me>
 <YK5W7F5DD4grBZLB@infradead.org>
 <3c944010-a9e7-cab2-07ad-78d50c8bd82f@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3c944010-a9e7-cab2-07ad-78d50c8bd82f@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 26, 2021 at 05:49:41PM +0300, Max Gurtovoy wrote:
> > We do need for_each_sg here indeed, but you also need to keep
> > incrementing sge for each loop iteration.  I think we can also
> > drop the scat local variable with just a single users and all the
> > renaming while we're at it.
> 
> Is the above fixing the issue ?
> 
> Seems like code refactoring to me, right ?

It fixes support for chained SGLs when using inline segments.  Not sure
if it fixes the original bug report, but the current code is broken.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
