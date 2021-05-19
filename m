Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A71C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 06:35:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849356023E
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 06:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849356023E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7xin8YcM8UXA1N0nCbD4BbyDBrLeWo+T/XKKPOETZ9c=; b=MrlRZweUl8KaHHipt+ZDgHp5W
	P84SdAvKGEmKxILNQoWrNxGdoB4BW32rDekvXSWSsO/eOI4dGRzid1LQyWTr3aCHG2gGyy28fapHl
	MXfwvD505ohrub6EHD9YKX8KdXEsvAvE9W0oUGth9dsRm2r3RfhVpyAaTOofPIqU84azDNNBQkYVv
	Lz/g1sAz8wGmdMmjMZ9b8hwm8L3OWtVVLB1IvF8E+DRmK9qFdzHGmYkhva6ZH2HjuaTT+k265whP0
	DUZmYx8R8MWGu2VqbpUx9bFA1Vp3Xke1/YtvdU37fcvfnX687kEQEPyR/ZguUOei02QbSLiDVnpPh
	/MEHR6GvQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljFnM-0030Im-A3; Wed, 19 May 2021 06:35:04 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljFnK-0030HI-Os
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 06:35:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JfcaAWiL9MX/KzgqZFMd5GxaGaNC7KsyrSBFfXwwLXo=; b=S/NmmAUOt/lOV6Yz9CSpv3Ii5y
 1e8z/0/v47dEisIgDUeuQ1lnxFeMoKIjdfeAI5B846QB+H+JXS3EETPmQIzVXjZZ9/0uEpZCX7Gq+
 LLJJ6/O9GWRt1fcs63KiRoU0Sm3+K5R7uaE1U5mdV80CFCyK5eqFdJW7cAX0tFDZ56UX5X3r0lIFR
 EwP974GHC21Mdorx7RIQZmJ48n8VyBSO7aGOg7drPSZF0Ty1oOUbFYT/0z3ZCAReKEzvHVHiPNNlp
 3iBK4WGGpVKDJTOUtk+JMYgnDWcsMhYMoRFOGFn1XTIdBYGJOMLSrVsy8Kbb6QwKnvLvY6ywvIXNO
 iuYZXKfQ==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljFnH-00FBNU-OA
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 06:35:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 67E7367373; Wed, 19 May 2021 08:34:55 +0200 (CEST)
Date: Wed, 19 May 2021 08:34:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Narayan Ayalasomayajula <narayan.ayalasomayajula@wdc.com>
Subject: Re: [PATCH] nvme-tcp: Fix possible use-after-completion
Message-ID: <20210519063454.GA30513@lst.de>
References: <20210517210745.634778-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210517210745.634778-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_233459_951181_47FE3618 
X-CRM114-Status: UNSURE (   9.39  )
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

Thanks,

applied to nvme-5.13.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
