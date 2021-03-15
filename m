Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B7DC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 21:41:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1556E64DAF
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 21:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1556E64DAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JZigpB47ZVQlX416WKVdL67uwZmIbyvlOlvnytwAI94=; b=Qu3jGw8BQkO7mLwoBADfCi5UJ
	4sSpaOgFnUwOVCTE9Zkw4MQpn4bfNGj7VlZmPLwQ/qR0ztk9MHP/SL15gKHlZPAaNDzMPLRzQojMd
	Q8JEANbn3V31MmiHNJFc/80+6COY1Sk5B26tpadtud3T1ShQPFecjtX/c/rN/lSAv1nMiCckZRuUW
	M8QdLmiTYqA3VtZpogFdSlXdkwqqeGKTKUhgtFx6TGqZoo/LK9MZvwI4Q/rT/iE/Y7NnFEU0in05J
	8R0zDDRtAgfJf8RlSMjZRXbK9NnFDJINv2JPS+HpABqZMVuNMP7/oy1q/f5Y5Ja1DUbdNtrEfyYGE
	/oGLPQtMQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLuxd-00Gxfd-OR; Mon, 15 Mar 2021 21:41:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLuxW-00Gxez-8K
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 21:41:11 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 496B564DE2;
 Mon, 15 Mar 2021 21:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615844464;
 bh=TiVfs9TnTvt8NCzLeiBYwXiLkKQkqLvNw6cM0aafRmQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=je9Zbl3SP9j9Twgh4k/Qz1f0dte9Y0U0UfeTboyXOxNGke0QLGtCCQI3pkxWVi1GQ
 CJYY834YGjBf0WUUb6UorU/jt7y8Or608V2A11jZiYWD+6FuE/ZA7zqKjnfxd0NGEE
 F1ZFLyzdeX5kKSzkEkYAY4AzqRxJYEZRrBAHpn+E1wJ0y0USmDPyTb73CsnVDgIIA6
 aRTz43hJlZyt2y6OEkrsUxI8bAdy7rAp+cZs1wbFFPyDto4+8L7WwEaGQlTJSnGHSK
 7lCAT/kVDKSZYyz2llLn7WU/37gPiU3NounyJugGs3cu2sqsYgftmHTGVBbolUDf84
 LA/xqVAz+FbKA==
Date: Tue, 16 Mar 2021 06:40:58 +0900
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-topology: have list-subsys print only controllers
 with attached namespace
Message-ID: <20210315214058.GA18599@redsun51.ssa.fujisawa.hgst.com>
References: <20210315205209.352846-1-sagi@grimberg.me>
 <BYAPR04MB496584078ED56F2D5FD0BFF7866C9@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB496584078ED56F2D5FD0BFF7866C9@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_214106_834907_27BBBE7A 
X-CRM114-Status: UNSURE (   4.06  )
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

Thank you, patch applied.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
