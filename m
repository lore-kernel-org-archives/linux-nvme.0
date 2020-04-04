Return-Path: <SRS0=CVBY=5U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BFCC4332B
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2020 17:07:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EACA206E6
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2020 17:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hrof93Tp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fw5alWvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EACA206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4kQfsHycdPn/LsSbDgRrKxeTMcbsfo5ngjfRRGbZQVA=; b=hrof93TpbcyJeb
	pUarDBnkwFjQyVycBFWqukgoDp8/ur7zxIHBPbQslKhAYd+mGDx4axtytiGImZKl4LYgGsDt2bBGr
	fXvBNn5OUUKlgcsiOZbvGTezl+z7iHZvJpUTVkEnGL0PbbcJ/nyvgKUPULUIpd9BrKWiKynLA/wiY
	cIJcxPSq282d5B+8CZP7wd75vcYbelKk4dT3MVy4hetvPae0Vi2yMvSZfBE/wnxbQu8iE4fjUCLsR
	rISR9UKPnVP5PIDSi65uwVaimHyMlGtti/Vw0S2PYI4K0S0ezJJ5FivGY46gNF9IJiF7GbzVGbCPy
	9kfACe7fdfqiQyVV82eA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jKmGq-0008Ii-Rq; Sat, 04 Apr 2020 17:07:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jKmGm-0008IL-Un
 for linux-nvme@lists.infradead.org; Sat, 04 Apr 2020 17:07:46 +0000
Received: from C02WT3WMHTD6 (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F02B0206C3;
 Sat,  4 Apr 2020 17:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586020064;
 bh=MBc8C9YCVF7M6Y+M04mBqnmt/0bgyFzN1UXDdBvMmXk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Fw5alWvtgmQWT9oQDQGL/bdjaB2W/sHJvdorG6sUkMbl+0lwEOmktdDXKMP0Mp5v5
 piCRsUPmM9nMipwTBJ/w92sGszVoWExQbiWlbX1VN6nn36d1wHRv6Jm3L0nn35egnp
 DJx+2WmA+irDuJ06zqKlU0hWj1Xw5YYYJuqLudVc=
Date: Sat, 4 Apr 2020 11:07:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2] nvme: define constants for identification values
Message-ID: <20200404170742.GA53042@C02WT3WMHTD6>
References: <20200403175346.1571822-1-kbusch@kernel.org>
 <20200404070437.GA14423@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200404070437.GA14423@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200404_100745_017128_8FB036D9 
X-CRM114-Status: GOOD (  11.88  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Apr 04, 2020 at 09:04:37AM +0200, Christoph Hellwig wrote:
> On Fri, Apr 03, 2020 at 10:53:46AM -0700, Keith Busch wrote:
> > Improve code readability by defining the specification's constants that
> > the driver is using when decoding identification payloads.
> > 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> 
> I can't say I find this an improvement - the bit values allow you
> to jump straight to the spec, while the names need a translation
> (either to the actual bit or the spec name without underscores and co
> first).

Named constants tell us what they are inline with the code that's
using it. You can make sense of the code just by reading the code,
no additional docs or code comments required.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
