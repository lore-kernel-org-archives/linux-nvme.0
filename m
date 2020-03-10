Return-Path: <SRS0=yUYt=43=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94109C10F27
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 17:08:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AB9B20848
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 17:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uG7EQ46Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB9B20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/eoFvQYdh1ywnKcTmV3+7af+0aTJO+JoGGeEJpEmT/I=; b=uG7EQ46YyCv8BY
	yQzWVmT1RQwT/iDuX+fdcsW9Pw50EMBzQL+v/GnT9dY1q5Y/p2tfopd3ymrQ2zkz+rQ0CxBWbZaZS
	PbmcqTmBBNawBuNkNBtcgVhMK5jB/ccF28xpBEaI7X8EoIohaJerS090407g9ag5U/hSB1MUz/XPB
	kVza6QAsLcX8Z/erih8XvAW8u0TGdusqWufBcLGV/O/0k2hdaxUvhIig5+7qnXGjZP90HL7oOcXhS
	I4Igy9VC9971A+n0F5df3uEaZ7YR2iLjB51PFygpselfjFK7AmYFsFf3VlYKPCD/HS7JdeiKopBOG
	G6zqVGsijlcVZqiOV7iw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBiMd-0007Rq-Sr; Tue, 10 Mar 2020 17:08:19 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jBiMc-0007Rg-F3; Tue, 10 Mar 2020 17:08:18 +0000
Date: Tue, 10 Mar 2020 10:08:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Subject: Re: I/O performance with block sizes > 128k
Message-ID: <20200310170818.GA28008@infradead.org>
References: <321f0a4b-8a75-8cae-2d77-34ad712225d3@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <321f0a4b-8a75-8cae-2d77-34ad712225d3@oracle.com>
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Mar 09, 2020 at 02:49:10PM -0700, Bijan Mottahedeh wrote:
> I'm seeing a sizeable drop in perf with polled fio tests for block sizes >
> 128k:

Try using a controller with SGL support.  NVMe PRP unfortunately are
a completely brain dead scheme once you use non-tiny I/O sizes (
and actually really painful even for those for other reasons).

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
