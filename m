Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC09C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 09:39:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC5B64EDC
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 09:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC5B64EDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yXwrc9Ow4d17kMDptTgXezu52DMTy09MKDN10lNk5yE=; b=SkUNFj22Q5xq3KfoPEe76IGqz
	wICIaa2RXMIn+/yoMjEuKaSMimmXrAqzD1n+/M6L60bQ1UlfGbdpGPjiGR2vbRDxv12G6D3aJTmLM
	Gd4bmSBUQSc4EsRWQaZsu4iJprvGBZsKAVQG5MIxq/xbHf8+uuv5wMOQXh/yslM2VuieEmPOzfqcr
	OtD2nEkXacm81uUI6cLGqpt1YPWe1l+LYDo/5StAzbzjoi5fpjWsiBX/9Wp4cFVAECgLsJixDFCFl
	fDthwfPX2vRDLVlhpuDhGPdO4TxSxb1LKnSZ8/LAhyckN7FkbzTPItC7aWNcwbj3smUf/QkWd0zMM
	T4cZ51WvA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6s9S-0002RR-8d; Tue, 02 Feb 2021 09:39:14 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6s9P-0002Qx-Sb
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 09:39:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3720C68C65; Tue,  2 Feb 2021 10:39:10 +0100 (CET)
Date: Tue, 2 Feb 2021 10:39:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 06/10] nvmet: add helper to report invalid opcode
Message-ID: <20210202093908.GH17771@lst.de>
References: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
 <20210201054138.34324-7-chaitanya.kulkarni@wdc.com>
 <20210201172921.GE12054@lst.de>
 <BYAPR04MB49650B7A725B55D0809DB0CE86B59@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49650B7A725B55D0809DB0CE86B59@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210202_043912_058185_09B54954 
X-CRM114-Status: GOOD (  12.06  )
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

On Tue, Feb 02, 2021 at 12:14:47AM +0000, Chaitanya Kulkarni wrote:
> On 2/1/21 09:29, Christoph Hellwig wrote:
> > I think we can just skip reporting the backend, as this doesn't
> > really add much value.  In fact given that this can be triggered
> > remotely it should probably be downgraded to a pr_debug.
> It is easy to grep the backend given that we have 3 and ZBD is
> being worked on. I'll remove it for now with pr_debug.

Well, you'd better know what backend your namespaces uses when looking
at the logs.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
