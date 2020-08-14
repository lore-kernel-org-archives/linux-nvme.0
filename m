Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94109C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 16:02:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6029C20791
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 16:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K6Uymybs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8gwfDJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6029C20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jpouZVFbymNCblMTHr9Hs6KkuQ8H8Bwszw/OsAOgaN4=; b=K6UymybsJlciUc2b+F06A5Jjl
	T1fzL/fL7EwrC/CUJGqLnSqrPsmJ0lUv2tMykEdJuDLeXcypJHkopv1WoBFo3hdVC96IE5cqUSbYD
	t32A8rrQdnQ6immsm88KgmqA0ejTqsI1azR/JKMIweK3rrOuYnfPeZAEy6Z8dEPf4NoV1AXY3YJmX
	mWQ4U7ej0FVK/8SLqL4sMupWIuDUWqK/9PCM+4PIyzNjXR5bKR+C7gFEwomqq3GwGYazS75BnX5dk
	Gjf1BJPhAjjiUHWx1JrsiXz2fwloXXdrzOuGr6iewtYOGSpSH23sL9HbLH5KQUe633jvaVaiJpVWP
	AomUTENSw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6c9x-0001Zr-OE; Fri, 14 Aug 2020 16:02:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6c9v-0001Z5-L2
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 16:02:24 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 91A2620791;
 Fri, 14 Aug 2020 16:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597420943;
 bh=n+ZueXi0T3R0sR3C4Tj4zZG7+6gHjs/tKzhXms1Idsg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=u8gwfDJSF+K3EB3GAkDt7lKHX17LAWCyyrJDYiCNlcgswjZGl4pLdyqD0XbS1w+fN
 IhSUAZDST7hMPFf/19D2Ff9c9ez7U7YcWcgv4VjLK5HufWqohWrotD5kCZimrk93nX
 q3Bx1jqQ9ghSHSVAR/TTiJ4P4Mdmsf8R+H3YweyI=
Date: Fri, 14 Aug 2020 09:02:20 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: nvme reservation commands during controller reset
Message-ID: <20200814160220.GC3772144@dhcp-10-100-145-180.wdl.wdc.com>
References: <MN2PR19MB30052441F4F22A4CAC8D396FEE4B0@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200809161016.GA63121@C02WT3WMHTD6>
 <20200810124036.GA25070@infradead.org>
 <MN2PR19MB3005A46208EE2B65E5F9B330EE440@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200810154846.GB4159317@dhcp-10-100-145-180.wdl.wdc.com>
 <462babf2-7cde-af4a-8bf9-a5b230e282b7@grimberg.me>
 <20200814082015.GB18371@infradead.org>
 <20200814100911.GA9975@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200814100911.GA9975@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_120223_767277_E333579A 
X-CRM114-Status: GOOD (  12.75  )
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
Cc: "Anner, Ran" <Ran.Anner@dell.com>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Engel,
 Amit" <Amit.Engel@dell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Aug 14, 2020 at 11:09:11AM +0100, Christoph Hellwig wrote:
> Amit,
> 
> can you try the branch below?  Pretty much hot off the press, but I
> think this should address your problem:
> 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/nvme-pr-fix

Couldn't you just clear the REQ_DRIVER_FAILFAST flag to get the existing
retry mechanisms working in this path?

And while it looks fine for fabrics, PCIe doesn't have the implied HOST
ID connection that makes reservations do the right thing across
different paths. Automatic path failover retries for PCIe may have the
wrong result.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
