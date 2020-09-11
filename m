Return-Path: <SRS0=9POq=CU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1ADC43461
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 18:08:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF78206F4
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 18:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M65lwC/L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGNoLYsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF78206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=o77ATXiWq+tZ2Ob2C2l/wDS+2UWe5EaLKgYF+ZF3h/E=; b=M65lwC/LjG8Km8ZzzvpFZeVJ7
	uNWuOcyaIdYSdWdyzxKF69Km6d2W0giZmAz9vMuSQrU8OZOqQcH1X7BYxHv/JCvQrWvQh85/pLykK
	EQnHCl1WIEUDak3nnREVM876ri2fwdBEdQHfIWFzfhSv26l+9rg07n9LRkiRuBZ9uNXejeoxqo/39
	5U837dwYSxT+Ap6UrngaToBWmVXF7vXB+4uutKu7Ia8013GaO8m4WjxYgd28Py55njl2PdmI4XCmO
	/1vt6+Hn8bMuLrV/+GkBRZr5lD+BE7MZtUzTBjVFX9H0Whd15Z80de0BwV8SoslUJgNd+z9cra4Lc
	BpnZf5hIg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGnT2-0001nm-3J; Fri, 11 Sep 2020 18:08:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGnSz-0001nI-M1
 for linux-nvme@lists.infradead.org; Fri, 11 Sep 2020 18:08:10 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E6E22206F4;
 Fri, 11 Sep 2020 18:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599847688;
 bh=G+m4oE7aVIPklLjBFfAVaF7RVnA1c7AGgY0ngfApleY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vGNoLYsILcM0Gy9QjDda6Zo+ylUqgpLGF9ZsKiXWrx8fa7iXgnniWGSmeZRTKQ8uR
 PCTsOicF2Zi6tZTsvChGEzQzN89HH46Rh6HfBidwsGkv2KimrH51t7SQJIzaLOBzf4
 gP9/oV3bEHToeapwu1ryPbU3i/nJ6oC8PdEx7ISk=
Date: Fri, 11 Sep 2020 11:08:05 -0700
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] nvme: translate zns errors to blk_status_t
Message-ID: <20200911180805.GA3655346@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200909203324.3356679-1-kbusch@kernel.org>
 <20200910052643.GA18283@lst.de>
 <CY4PR04MB375101AA0F80FB54BAFBC427E7270@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200911061022.GA21597@lst.de>
 <CY4PR04MB3751B5CEE2967C1B3B29554CE7240@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751B5CEE2967C1B3B29554CE7240@CY4PR04MB3751.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200911_140809_896654_60096E52 
X-CRM114-Status: GOOD (  19.43  )
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
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 11, 2020 at 09:35:31AM +0000, Damien Le Moal wrote:
> On 2020/09/11 15:10, Christoph Hellwig wrote:
> > On Thu, Sep 10, 2020 at 10:25:24PM +0000, Damien Le Moal wrote:
> >>> I'm not sure this is the best idea, we probably need specific error codes
> >>> if we want file systems to be aware of the limit.
> >>
> >> Do you mean something else than -EBUSY being returned to the user by the block
> >> layer ? Or a different/specific BLK_STS_XXX code which translates into -EBUSY in
> >> blk_status_to_errno() ?
> > 
> > My primary aim is a different BLK_STS_ code.  But given that I think
> > that we should not map different BLK_STS_ codes to the same errno if
> > we can avoid it, we should probably also use a different errno.
> > 
> 
> Hmm. Beside EBUSY, I do not see a nice existing errno that we can reuse. May be
> ENOSR (out of stream resources) ? Or do we define a new one ? EZBUSY ?
> 
> And indeed if we define a new BLK_STS_ZONE_RESOURCE and map that to EBUSY,
> errno_to_blkstatus() will get confused.

It's not often I get to help define a new errno, so I'm a bit cautious
of that route. But if that's the recommendation, then sure, sounds fun.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
