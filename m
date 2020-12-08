Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AA3C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 10:59:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B736B23AA7
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 10:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B736B23AA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2IDTcIRLqy5D9vSqiGy6txOaFMrbsl2t50GumnbIztw=; b=vAPMTjrrZeHS0sC4kmoquWbA+
	qPW8sLkvNNLf8lCYL0cjad2z1o6Ja7YgPEH5DxyDVcHyiPQLxMLW/fx9XIqFKPFB4YzPZjCHjCcqJ
	DDGGb176kthUWEACkjB656OK02SZU6aPlY4W8eXRQ4JlkUr6q8YaI0PoRzDbaqWVtr2S6SBsoqq9a
	25oGCb4V8UoTsM6MwkB5niVhsFhjkalhv0OvI+9kZPsahparSCHClqGN1UrTQ0cWOmb65qTjQwSdx
	MCoNKjUgL6+BDEt9KfqAOaZ+AafozOuIIMC1EcxuyRb6yuqfSDiFMMW4eHuUWYhXHrcnigbtBPH0K
	rzYPUtZfA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmaiU-0004oN-JV; Tue, 08 Dec 2020 10:59:34 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmaiS-0004np-KF
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 10:59:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1A43D6736F; Tue,  8 Dec 2020 11:59:29 +0100 (CET)
Date: Tue, 8 Dec 2020 11:59:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 4/6] block: propagate BLKROSET on the whole device to
 all partitions
Message-ID: <20201208105927.GB21762@lst.de>
References: <20201207131918.2252553-1-hch@lst.de>
 <20201207131918.2252553-5-hch@lst.de> <20201208102923.GD1202995@T590>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201208102923.GD1202995@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_055932_817027_4B122745 
X-CRM114-Status: GOOD (  11.81  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Mike Snitzer <snitzer@redhat.com>, Oleksii Kurochko <olkuroch@cisco.com>,
 ceph-devel@vger.kernel.org, Dongsheng Yang <dongsheng.yang@easystack.cn>,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 08, 2020 at 06:29:23PM +0800, Ming Lei wrote:
> > -		test_bit(GD_READ_ONLY, &bdev->bd_disk->state);
> > +	return bdev->bd_read_only || get_disk_ro(bdev->bd_disk);
> >  }
> >  EXPORT_SYMBOL(bdev_read_only);
> 
> I think this patch should be folded into previous one, otherwise
> bdev_read_only(part) may return false even though ioctl(BLKROSET)
> has been done on the whole disk.

The above is the existing behavior going back back very far, and I feel
much more comfortable having a small self-contained patch that changes
this behavior.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
