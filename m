Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE98C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 23:16:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42C2423A59
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 23:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C2423A59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=h0utYZO9cRlzFOZdtUIoMQrTFsGfWMXUDzpEb+nsLzc=; b=ZViq9OG6LUrFCwWMp7NsDUWg+
	6lgCoyQgsjMIgfP7CLuZAzD1mZzcL0UVvTY1f9QbmYDsmi+LoL6aMmfQZlYgLMtOlKmu1MNVUXPWY
	561zDdcct2dueOVBE34qIIzak3O6LWNUn30pzHR946PbdIoV0kFOT6opcHIFbPzG4/pywOh2rhYsU
	qFar8UH3WBr9Fhm8m6knUQMUrrd/seQp/ndnu+m4BNp7n8tD+eLk5x82cNWDnN3GjiTwsw4lJ5Kta
	fdUWLTeiSQk9bqFs+7cfGRb8Y3LZlgwHdsCN995rUwf/ZxlDRca/RX/2eoL2hqLJAYeYMitA0awnk
	5yTsCORxw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l0Bqn-00057k-B4; Thu, 14 Jan 2021 23:16:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0Bqj-00057M-Ok
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 23:16:18 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2435B23A5B;
 Thu, 14 Jan 2021 23:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610666176;
 bh=6qn8GqXzqOdKpQWrPejbXnvun5bZ/gmgyF8LUK2pclQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Apet3DJjQNu8sHVjB7IMRD0vHoW72RGPMjW8l5yhlSv82ojmFnnyHt1zG7b2VSbTP
 hV+6cXhbd0FJMq9DHz0zwkgKpncS2ADHMrxTk0mloI7jjrvdchoaIAedgdMLCCMXpz
 myLh1KPGykq1ToHOPJmf2ScDG/Eof69MPkdchNL76GXDbsnTNBaCW/xSstUebi2jwJ
 wO8AjFsayzm+hcEw2Qm2RiMYd31ibQMd56zoMn/enti31MkSf3Z4QyqXlVOq3osy8V
 sD9/FHRebfvSknwm4l3crygDJuD7++/HWRLLp9VvQP4mRQeu3YZbCG2Z9AYsCiji5e
 AHgQWx97Dq+Iw==
Date: Thu, 14 Jan 2021 15:16:14 -0800
From: Keith Busch <kbusch@kernel.org>
To: "Knight, Frederick" <Frederick.Knight@netapp.com>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Message-ID: <20210114231614.GE1511902@dhcp-10-100-145-180.wdc.com>
References: <66bad47c-0cd3-8461-3629-146778f15059@suse.de>
 <20201209173936.GA31971@redsun51.ssa.fujisawa.hgst.com>
 <20201209174718.GA19512@lst.de>
 <DM5PR0601MB3624722C4C00B5A7EDB7E6A0F1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201209213437.GA3682670@dhcp-10-100-145-180.wdc.com>
 <20201210085111.GA15999@lst.de>
 <baa8c2e6-1376-1cad-4c84-1129bd80d4ca@suse.de>
 <20201210133418.GA3645@redsun51.ssa.fujisawa.hgst.com>
 <eb84db43-5e63-19b4-cdb9-53f52d1c45e8@grimberg.me>
 <DM5PR0601MB3624BB4004C273271F30052AF1A80@DM5PR0601MB3624.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM5PR0601MB3624BB4004C273271F30052AF1A80@DM5PR0601MB3624.namprd06.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_181617_906652_DEB4B1CC 
X-CRM114-Status: GOOD (  10.16  )
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
Cc: "George, Martin" <Martin.George@netapp.com>,
 Hannes Reinecke <hare@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Hannes Reinecke <hare@suse.de>, "hch@lst.de" <hch@lst.de>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 14, 2021 at 10:59:09PM +0000, Knight, Frederick wrote:
> Attached is the proposed clarification.  This has had ZERO review time in the NVMe committee.  So just FYI at this point.
> 
> Feel free to share thoughts.

The ECN retains the text that no new ANA event shall be sent if "the
change is due to the creation of a namespace", which seems odd to
continue pointing out given that namespace creation doesn't alter the
ANA log.

Also, if you're going to use this ECN to ensure namespace attachment to
a new ANA group suppresses the ANA event, could you also update section
8.20.3.6 to change: 

  c) upon entry to the following ANA states:

to something like

  c) upon entry to the following ANA states except if the state entry
     occurs as a result of a namespace attachment:

Just so everyone is consistent with the "exceptions".

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
