Return-Path: <SRS0=S+bv=NP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B428C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Aug 2021 05:57:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEAC361248
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Aug 2021 05:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CEAC361248
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Sr+InPt+spp3tILFfurunbIhFhbK3ToyIdUpFZS5EY8=; b=NUSdzBkDIFjxlW
	YZIkuEDY4XBVbFagaZNub0HB0jVHMCREM1n5OYWHX0BZHEwAjIRWHEuNOa7iGMWOusTsuhm69uuzO
	e/sDPHQrtG3UzooEzUH59fXuummSPqSNu+IK8EFYaqVMiEVXXamPsA3olBUtW9bjBaJCCuzLlVb7b
	+5Pi0kJzoeI2jDP7AU/Xh9HFc8cV3R61erXDuZxGpw1S/Uo68mP5k/Aiu/U4AvawSVJeYIxbXqwRO
	9GKbcy/q1tijjmrpPsEOISzu/UwV8KiHYLcILioo1EGNNVbNAbnCW/ZadlsNiES5nH0rifV3sWo2t
	jkf3vvIEReCr3YZGJRwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIPQm-001k6N-Q7; Tue, 24 Aug 2021 05:57:04 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIPQk-001k5O-EE
 for linux-nvme@bombadil.infradead.org; Tue, 24 Aug 2021 05:57:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=nxCjIIPElSqhCdgo8hNsrZTfzyz3uEXAdzaL8siyKA4=; b=SXYaBLqKWP/frBwB8zI2Zucfr5
 0/+veg5jWJ6Kfk/QszuC5jPagukx8ODt6uyKxEUJwSPMT421Vdmt0/C6tWxwD6wF5fKRHHnKsBrXT
 lHh4JKs6Mae3P6aKLDd2Rc1w1Ct3e3hiGtrEBVxib59XxlDS8UX1Bb8ei4ULVCQ3oTVTZPrJf2x8K
 vPv3ihshzkIR1BJYOKoiVb/TuIaIvVHlKDizUFn/dTILcwJoSXpRy2TbYsSyjdjUwum+CbWiWDRlr
 k8nVlg+ZfypZ5fof5hEQvH3rS5pR7+XguMeBeHds3S0Mk2J0UGWPAzrReERc+4WTJU6IMoQbPwRvY
 K76Tn2Iw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mIPMj-00AcGi-Ei; Tue, 24 Aug 2021 05:54:07 +0000
Date: Tue, 24 Aug 2021 06:52:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
 kbusch@kernel.org, sagi@grimberg.me, adrian.hunter@intel.com,
 beanhuo@micron.com, ulf.hansson@linaro.org, avri.altman@wdc.com,
 swboyd@chromium.org, agk@redhat.com, snitzer@redhat.com,
 josef@toxicpanda.com, hch@infradead.org, hare@suse.de,
 bvanassche@acm.org, ming.lei@redhat.com, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-mmc@vger.kernel.org,
 dm-devel@redhat.com, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] scsi/sd: use blk_cleanup_queue() insted of
 put_disk()
Message-ID: <YSSJNTxyLHu/LsNJ@infradead.org>
References: <20210823202930.137278-1-mcgrof@kernel.org>
 <20210823202930.137278-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210823202930.137278-2-mcgrof@kernel.org>
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

On Mon, Aug 23, 2021 at 01:29:21PM -0700, Luis Chamberlain wrote:
> The single put_disk() is useful if you know you're not doing
> a cleanup after add_disk(), but since we want to add support
> for that, just use the normal form of blk_cleanup_disk() to
> cleanup the queue and put the disk.

Hmm, I don't think this is correct.  The request_queue is owned by the
core SCSI code.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
