Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA912C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 06:37:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B07F611BD
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 06:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B07F611BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XiQe/+wvwTG5NcDDED76rT/z9d4eGL0q9AwgFGT9VNE=; b=XDSRDCtlezAnV2xP6Pz13/smM
	d1ITK+sGJYtctD8IixC7/lGA+Bpz4Zv5Rtwq565SO50d5PSkbXaOFHONAHQAFr8yYLBHbfJ0vDnRr
	8+7AJNnaBid1VBgmmmgXqm4fc/zvoI++t8pcW3TP0s3Vi5agej1sSjYMCGnKjcyP2yoS9Jg/MnVUJ
	xagtDwe+TT612pCfy884vb7aKdDpZ8940D8qI8XLOx8NDh8ObCMynqw1Ofwvam0bQMq63R3UpoNFy
	IeOlLSIaOKkhjeukREhFxypOH/27HFV9FK1037R+QTOybdymfVl43zQA+fDt3r42YksJVNLy5SsYe
	ZU31Pp4CQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1litMG-00HAmw-Et; Tue, 18 May 2021 06:37:36 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1litMD-00HAmk-Dc
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 06:37:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=26cNlIt/q8fbt7a53rvo51klQKpBcVlrL3ih08ai6NQ=; b=Hn4Wwn5PpgoyjehbyCLiAcdqxS
 ThdyM14WZLNJc7gYVFsZpDGJuo9hyvhoxXJfEKZbY2T8P/Ya03n3zdqr2kGFByyUt8NtX4fN+YvVX
 NtAQOfUsQQPw8Ao5XHY+EFW2rRLLZcS9v6JpUw66l2c2/o5YPWnStNbhZVnsV33oqKWWE/w2Mre9Y
 ebRgzurUM7Yr7Z6oRLFjytAtmFqHtDgRfIFmgRteWkwRjYreINMda8Eju5Hy8COYwveYX0V2wFJeC
 J1Xgg+QyV4AAdCnNimE0OxFDdmi4lVhjyY0Rj8thes5qWu2/Dwxv7yMmIDwCJaM8jHCw7EZ3sG8W7
 7gHkRo3w==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1litMA-00EMCs-TL
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 06:37:32 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 8C035B062;
 Tue, 18 May 2021 06:37:29 +0000 (UTC)
Date: Tue, 18 May 2021 08:37:29 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: Sasha Levin <sashal@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Enzo Matsumiya <ematsumiya@suse.com>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH AUTOSEL 5.4 2/2] nvmet: seset ns->file when open fails
Message-ID: <20210518063729.ppvsr4ni4yvirblw@beryllium.lan>
References: <20210518011002.1485938-1-sashal@kernel.org>
 <20210518011002.1485938-2-sashal@kernel.org>
 <BYAPR04MB4965B34C6F9C5E833782C7C1862C9@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965B34C6F9C5E833782C7C1862C9@BYAPR04MB4965.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_233731_110358_B7D7E655 
X-CRM114-Status: GOOD (  11.69  )
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

Hi Chaitanya,

On Tue, May 18, 2021 at 04:27:32AM +0000, Chaitanya Kulkarni wrote:
> I think the patch subject line is being worked on since it needs to be
> reset and not seset.
> 
> Not sure how we can go about fixing that.

This ship has sailed, as the commit already hit mainline. Fixing the
typo in the back ports is surely possible but I assume it's better not
do change the subject line. seset forever!

Thanks,
Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
