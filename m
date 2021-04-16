Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9783BC433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 17:18:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56076611AE
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 17:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56076611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hDNhzKg0WmdXi+79JVcgtSSVbk9S7PrkYWyyUy7e3L4=; b=Gq6+TDjreWnkSksL7CAUCpBnv
	MbKlsxp1NX8lEuQsCNN5WK7Tge61whDrFgP7QQOaSF2ZgW9CEOD/CfgTHKlShXmHFZmOz61eyvUG/
	C7DD9fMp8+Grdxq+81X47c+kAUybEIgUwBAP2L9AzcpovnC4bX3mwQvNmRLEdy2mTQtvPEVSigFL/
	kb072Cf0CCdkkc9QH6qY5Hd/2GX/aeSl6nn4JLUQV8FWOdjuU+yp3oL0/gSVlAHFCpMMBG5fYJq9X
	07vT3jzHVi6ONiuhKxpcJbANmGFgsgbO04wkuU2238JwKmgvNM2vcWahGYnuApEXXmuDVaono4Qw+
	edkyfYKPg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXS6G-002vO5-2o; Fri, 16 Apr 2021 17:17:48 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXS6D-002vNt-VD
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 17:17:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=hrPKgqdXPvw7384ilFvHt69dXZtxgUsWmoB/m6vBM1Q=; b=Dk+5lGmijUTiDbyXOw8bSutPZu
 gJ4l6V+oyI1QqG4hVyWGE6RoS2uSSVkQ4TBA7MLJyN0mwjaXLcA4FQX/IHiLexm/idyin/tpUhw39
 br12WMWWWVmkWup75vto2Ghyw6tIQwqw3P5GrPb3t9zsPtz40Uo5NU1BEzNLJiVj0MWzyNqBf3tp2
 Rk3pyJMUkyTP3uLq+JG3j/w8iMn5ZLaWG3dr+7fnUQN5oJxO6n2iULOWnMBUoJTq1O1eZ+u0/sJAG
 EtykdUBo3ALF6/1RCu/mnClduN056R/m0WhA95xN/u2cl5+k7yzeVXfnDFQx04GpimYORQmzFO84C
 CqhlHwcw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXS6B-009aau-Jp
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 17:17:44 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6950C6117A;
 Fri, 16 Apr 2021 17:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618593463;
 bh=9hxK/R+s2EU4kR7kshGTeZycGVsVIiRTG9wD/ajjcm8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NygsV5CnESJgpSeDCfg/n4rmxI5KDQXNTe63ckgX4DcH+pes3gH3CAxm6Hz77FYbW
 XATkeBuvClbbPQknSy4qHNHB6wc5PO0qeTxt/XcGtf9t/Qjks95POJmljNtKsaAOK8
 hCt1ZkP1HkYeC8cRmQHjZjRSsi4r844XdvCVJMYHhKcaiYxycv51OT99CpcUUSRsjg
 3zbNyoJzlY5nfXSFOBpYPaoYlaV4gs0MhiaVmNF4dQh+l9b97FjIl8fIkKeliPaP0k
 hfolU+G7XRxeCkHrFRfB0g9oz+irn50Xyu6gDyN+mrcfF9067CChi+p6GaTn1RKqjH
 Plb5eJhsREsdg==
Date: Sat, 17 Apr 2021 02:17:35 +0900
From: Keith Busch <kbusch@kernel.org>
To: Yuanyuan Zhong <yzhong@purestorage.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: use return value from blk_execute_rq()
Message-ID: <20210416171735.GA32082@redsun51.ssa.fujisawa.hgst.com>
References: <20210416165353.3088547-1-kbusch@kernel.org>
 <20210416165353.3088547-2-kbusch@kernel.org>
 <CA+AMecG=8TTdsdYtaV=H+hKm2poKYhyh_Tvf0Tc0PZvbVXf_iA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+AMecG=8TTdsdYtaV=H+hKm2poKYhyh_Tvf0Tc0PZvbVXf_iA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_101743_703338_02AD50ED 
X-CRM114-Status: UNSURE (   7.91  )
X-CRM114-Notice: Please train this message.
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

On Fri, Apr 16, 2021 at 10:12:11AM -0700, Yuanyuan Zhong wrote:
> >         if (poll)
> >                 nvme_execute_rq_polled(req->q, NULL, req, at_head);
> You may need to audit other completion handlers for blk_execute_rq_nowait().

Why? Those callers already provide their own callback that directly get
the error.

> How to get error ret from polled rq?

Please see nvme_end_sync_rq() for that driver's polled handler callback.
It already has the error.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
