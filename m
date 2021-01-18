Return-Path: <SRS0=Iqha=GV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F3EC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jan 2021 18:21:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37F0822CA1
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jan 2021 18:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F0822CA1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qoDEfHyDKrK870J488WFeDBZr/3LJ/ZCXD+3fGT8MvQ=; b=tb+o0qxvSturR5JNT79WnA+BG
	MDmAygfHi4KcuatnaE2Ty2lSTzPlz12YM+QDt2GHVbxaI75aMY8FalRoQjigAUaZL9q5KwmuKwbLT
	TT+7rkbyWgpxmrg2rD0KWdt2ac9zLhQGWPdpUwHvON0cOgBr2hIZwp5lNgpJMMfkW+nBL4jCEwVdk
	Ble700uSFeWwHpQI9lS2GZ0Q3Wufq/hkkyccU14S2xSFfZpVeOOJysbZKZf3sEY0SB0JtxYswwafz
	4o2g5CoY4qIyeichwjcJst85udPw2zKE9zwwyUVX3eUNsONg2cv7jZDkvw2z+urD65NhpKRAsjc48
	zNo3hmrAg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1Z9J-0007uZ-Bf; Mon, 18 Jan 2021 18:21:09 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1Z9H-0007u8-R9
 for linux-nvme@lists.infradead.org; Mon, 18 Jan 2021 18:21:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 30E6B6736F; Mon, 18 Jan 2021 19:21:06 +0100 (CET)
Date: Mon, 18 Jan 2021 19:21:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH V9 3/9] nvmet: add NVM command set identifier support
Message-ID: <20210118182105.GB11082@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-4-chaitanya.kulkarni@wdc.com>
 <20210112072715.GB24155@lst.de>
 <BYAPR04MB4965017878A807316A0A1BBA86A90@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965017878A807316A0A1BBA86A90@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210118_132108_039641_22C734F8 
X-CRM114-Status: GOOD (  15.59  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 13, 2021 at 04:16:51AM +0000, Chaitanya Kulkarni wrote:
> We advertise the support for command sets supported in
> nvmet_init_cap() -> ctrl->cap = (1ULL << 37). This results in
> nvme_enable_ctrl() setting the ctrl->ctrl_config -> NVME_CC_CSS_NVM.
> In current code in nvmet_start_ctrl() ->  nvmet_cc_css(ctrl->cc) != 0
> checks if value is not = 0 but doesn't use the macro used by the host.
> Above function does that also makes it helper that we use in the next
> patch where cc_css value is != 0 but NVME_CC_CSS_CSI with
> ctrl->cap set to 1ULL << 43.
> 
> With code flow in [1] above function is needed to make sure css value
> matches the value set by the host using the same macro in
> nvme_enable_ctrl() NVME_CC_CSS_NVM. Otherwise patch looks incomplete
> and adding check for the CSS NVM with CSS_CSI looks mixing up things
> to me.
> 
> Are you okay with that ?

Yeah, we can probably include it in an overall multiple command sets
support patch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
