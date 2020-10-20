Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68502C4363A
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 17:50:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB4B521D6C
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 17:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R0qkAZO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4B521D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fWnf2w6KmmuIa5zwotGgXpScxG0o4RSmPepaPvOpkAU=; b=R0qkAZO/v179jxHzxSwZZWA0m
	hM/BNrDTsBjKbHyzcC/xcvGwb74Otonv0d70icjz4hj2hBQAWTXE2zC01prNGEV7BPrXeW44uCVBN
	kfzuMcgScdhFzzY6/7STRXnRFNlF5ksq53BTNeDktVkjyllJui5RgvQgpwOF2V1u2jIDyG+gldh1z
	LN1ZA1PlmzLjflaJ7Bv/bEwrM4xo4iZIprDJYnDIe9fslFFrsH+nvIJUMmLCiPKoQzbQ3vTBnuj2h
	HdoPpI5zAIk6JZNuN09SuCE1h/Olsz+Geylfmj6+OxFkWoBCtkpidDdPXBn46oDxpldSQSTXGaKc0
	UzGk367pg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUvmB-0000rO-Qv; Tue, 20 Oct 2020 17:50:23 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUvm8-0000pg-Ds
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 17:50:21 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D5C55AC23;
 Tue, 20 Oct 2020 17:50:17 +0000 (UTC)
Date: Tue, 20 Oct 2020 19:50:17 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Jeffrey Lien <Jeff.Lien@wdc.com>
Subject: Re: NVMe CLI Version Tag
Message-ID: <20201020175017.2avzkm2bwyeg2t3a@beryllium.lan>
References: <BYAPR04MB5656B49BFE47211B3A2F1748EA1F0@BYAPR04MB5656.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5656B49BFE47211B3A2F1748EA1F0@BYAPR04MB5656.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_135020_601839_90F98C6A 
X-CRM114-Status: GOOD (  11.61  )
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
Cc: Keith Busch <kbusch@kernel.org>, Sean Brownlow <sean.brownlow@wdc.com>,
 Randall Bates <randall.bates@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

On Tue, Oct 20, 2020 at 03:52:25PM +0000, Jeffrey Lien wrote:
> Keith,
> I'd like to request that the nvme cli version be updated to 1.13 and
> then tagged.   It's been 4 months since it was last changed and
> tagged.

FWIW, I would also appreciate to have a fresh release of nvme-cli.

Thanks,
Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
