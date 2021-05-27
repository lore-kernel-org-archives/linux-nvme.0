Return-Path: <SRS0=/NUg=KW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B18C47089
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 18:13:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D483613C0
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 18:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D483613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d05tw5dnXATbQBEvUSvJMKCzvBgWLTTNcWggv+XIGxA=; b=S3HZ49W+kFzx07
	X4uerZnW4tm2PAKcutRdyxFkSR4dukftZeRZXNEovI0rGR3i140KBsp1INEewX+SYxyVNJaBuD4mM
	yU496RMSqgExolMT4FYzF9lBqTsIriqHpotSNd8BLd7OypKASer1Yk+7ZKb6NXxvpuFR7oOxNui/6
	lM2eML9cOsV29b2yluEwRndzH2hhoxfO4y2tcy07KDaF+cqz47VlgeR0ADELBUbiG6Z30nWhNPDB3
	kZbotd7cbqhb7CwsLcyN90q+Y0na/HvHsE0AmV7YlIEXQPknE+MGpBZ8ihtcNcD0rH48qMdKDoplG
	1YVauWsVKSnUOauYkUVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmKVd-008OBd-54; Thu, 27 May 2021 18:13:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmJDz-007nhO-DV
 for linux-nvme@lists.infradead.org; Thu, 27 May 2021 16:51:12 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC2A960D07;
 Thu, 27 May 2021 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622134271;
 bh=lXeDk+lfIvTvB287GGxNo4IJd0Q5uC0t+WZ1l2qLlQ4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RI1DKeJ+mw0hA2qeQdsOIJ9MFjiierDnxwfKbSHtHM2b/hqJeoQOF4wGdn4oxQePh
 cqpEaXfiZed+AwpJ6xJqdXtlsl2dYON91v8JtDdqLNbsbAKUAbbBr2kNTWQPZz7xF1
 H1gLteY8h6IVOkWhuSfbqxrbc7tBDyrFebbWzTM9aYxKprC5K2cqmABME74qiSbt5C
 DGre7DUzRIfbxngFyEwK8l1KM+iaeYiEnkr0x4eNGIMcjNg0o0Wzciyp41ko2MsYTr
 68Vo/qiluMWdFcuIREQvbL27EyfTr22myiEH70XD8DQs2XPZj25rndmbD70wkd7zNj
 gdQcDi7NNhc1g==
Date: Thu, 27 May 2021 09:51:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: Jonathan Wright <jonathan@knownhost.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvmeof Issues with Zen 3/Ryzen 5000 Initiator
Message-ID: <20210527165108.GB3706388@dhcp-10-100-145-180.wdc.com>
References: <ffae89d5-05d8-e0a4-ca71-b3db18f70286@knownhost.com>
 <BYAPR04MB49650971173C72A97AC8B0D186249@BYAPR04MB4965.namprd04.prod.outlook.com>
 <98b9e916-1c62-d6fe-ade8-bf0a8788e622@knownhost.com>
 <BYAPR04MB4965276BE6BD29AD9594F4DB86239@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965276BE6BD29AD9594F4DB86239@BYAPR04MB4965.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_095111_517091_2AB84CC6 
X-CRM114-Status: GOOD (  10.45  )
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

On Thu, May 27, 2021 at 02:36:59AM +0000, Chaitanya Kulkarni wrote:
> On 5/26/21 16:14, Jonathan Wright wrote:
> > I grabbed/built the kernel from the nvme-5.14 branch 
> > (http://git.infradead.org/nvme.git/shortlog/refs/heads/nvme-5.14) and 
> > managed to get the NIC drivers compiled.
> >
> > Unfortunately the issue still persists.
> 
> It will allow everyone to help you to fix this if you can bisect
> the problem.

You need a "good" commit point in order to bisect, and we don't have one
here. The description sounds like no kernel release ever worked.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
