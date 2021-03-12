Return-Path: <SRS0=WLLZ=IK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC437C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 16:18:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 979DC64DC4
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 16:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979DC64DC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1ZX8umjBANDAb6hyoVPgXeP/zB7ASoGqvhsoVv9nbk4=; b=LLiIj5/INKieccZ3mhzRmnifl
	/HJX0ElQkk0oyS6xpDwyBJZfL5CVAsl3CNUgTBEVnth4k6bA9Zu1GLtAj34wiOJp1ZOQlWsY21Gea
	98RgS7h9eEbu1PsRvIitwAEe6wgro5DKsXVowHUs9VWXWVLBSB3xfq0Xv9HPkG4IMeIjnR+wpnJJV
	U3NHmpxe9WJhiPb+57ijq8AFJBjps+RaCoRkSso3nbNnUYdVQReuAuPRqaLq8LHJkuLr+8EjEkqSx
	U3fggiAiPr88Twe/MaiZ32QhIi0iMcfpnk1LEafrc6QmF8AD1g3tJUihMnEcb0JpMR+e9zZx7JN13
	NRxbrLolg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKkUp-00BvOy-MV; Fri, 12 Mar 2021 16:18:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKkUh-00BvMy-R2
 for linux-nvme@lists.infradead.org; Fri, 12 Mar 2021 16:18:33 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E9B964EC0;
 Fri, 12 Mar 2021 16:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615565908;
 bh=E5F6qQBAtOFvdg8o0/brgN5f/l7XeEKmX4mfgWdqsnc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fM39pZ0fu8c9HSfdMb7HbwrVshFBNpwntGOKz+oI021yrartv4OXixF0YWYN5BxCF
 jvKyw4K1ZXtvoJUNtDRYcyo+wSejXqIi/fzI2KTFBLwn+LRRIRnBNREcyQVAKxQwiV
 RBYGiuJD4xTLmwFLhrvSvKh3wRodectJfIAD54KEkLNN3cQ7tzU7jCmGfrOK7W2Mkq
 o10qZrhuFVyLnzW2IAK9V8cfKZxztvTz6YrZVfPyiYHUh6H1d3c0w3l0Opu4NdtJbe
 gkAb3n5fzJIiHI5Ppbi07XxLtJLklA8JmaaQrgX21J1ymTyO/FkiTW35l8c9lv2iPF
 cA1MeJWMbAG7A==
Date: Sat, 13 Mar 2021 01:18:24 +0900
From: Keith Busch <kbusch@kernel.org>
To: Tony Asleson <tasleson@redhat.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Tomas Bzatek <tbzatek@redhat.com>
Subject: Re: libnvme questions
Message-ID: <20210312161824.GA3953@redsun51.ssa.fujisawa.hgst.com>
References: <245fc813-9441-56d8-47e2-4417fc1f87e7@redhat.com>
 <20210310204844.GC3377333@dhcp-10-100-145-180.wdc.com>
 <BYAPR04MB49654A2227C054ACC903E2ED86909@BYAPR04MB4965.namprd04.prod.outlook.com>
 <7e866844-4848-3ef6-cba2-c704a8db74b9@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7e866844-4848-3ef6-cba2-c704a8db74b9@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210312_161832_105357_37481E4F 
X-CRM114-Status: GOOD (  14.19  )
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

On Fri, Mar 12, 2021 at 09:35:14AM -0600, Tony Asleson wrote:
> On 3/10/21 10:43 PM, Chaitanya Kulkarni wrote:
> > Keith,
> > 
> > On 3/10/21 12:56, Keith Busch wrote:
> >>> 3. Any plans on adding functionality for NVMe management interfaces to
> >>> the library, e.g. NVMe Enclosures?
> >> Will be happen to incorporate any features that are in-spec.
> >>
> > 
> > Adding MI support is good idea ? I think it will bloat the basic
> > functionality.
> > 
> > Can we consider adding MI plug-in for it ?
> > 
> 
> IMHO having standards based functionality only in the cli as a plugin
> diminishes the value of the library.  If a developer is required to fork
> & exec the cli for some functionality, just do it for all.
> 
> If the size of libnvme is a concern, MI could be built into a separate
> library from the same source tree that leverages the base libnvme
> library, to allow selective install & use.

The MI support through the in-band admin queue is totally fine to
support here. If a feature is in-spec, then it has a place in this
library.

MI support over smbus is probably out-of-scope, though.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
