Return-Path: <SRS0=D26X=KB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0929BC433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 12:09:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494F8613D6
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 12:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494F8613D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QVJwz9W/h6bUzurEZy9LaszlFusfYp0WnmstNR1+skE=; b=B09QYBWDjJCtEXISluNU/l6kP
	+ZpTknsf0ft+Nc5noWb9q9upfEXRSURFkGOKCnwrbNGogyuNBkiAHcOPL45EWSCwGX3xEqD8qRgl7
	GoTM5cABAxFnacvDNwXW4q6+d3vBDEN70Dgn5R+3zvEmcCrTrFxd/SR9PbAG5W4UZWLoxoGqa6q2K
	V5uav1KBrQ0ifQ3FCJsMc1R+hyg0tUz3UT8JRENcDLvtVGb5V6QjLK9J7zB6jC1fu7PO4j7Jcjwjz
	TWvKY2fgv/oRkZDFnfFC3hR0FtmY4egUd6SToMyZBdILl6pfSRG9+//MR7zJLuhVPiS+lC6K6JZMb
	WiFeYz/ow==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lecoR-004Cri-Di; Thu, 06 May 2021 12:09:03 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lecoO-004CrO-7L
 for linux-nvme@desiato.infradead.org; Thu, 06 May 2021 12:09:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=O5UtaaO2wH1go45Jtof9m2m/Rf2wXiEEXh/hT4l+g8U=; b=leI4lUSHqR3J/VlwA2A7gCoCuY
 IeEQQnUzMB+0P0m6HojnCy6SHrhqCX1L3m86bp1cojOlmIX551lvCS5tqcBdazURHTwpo7Os0c6vL
 7qsocyMvUwMk/cA0UdnPYMydReedUam2UeZtGfNOfw/FrJxi8mp4pYU28b8872lZxUp8t6vUODEFp
 9+bW4uG6AqYMomf/MBuXmGpt+k4Qer+ECDOYxWf+ldYQvkfO40iM13vDW+RsrVzj6VULqDlVt2aQ3
 9VXNe4BM9hPEr+3OgVW8Hm5d4h2PPaZwGrRp0ObnHr7kidjhgMhbyCqr7ukCCYgZpiOXuyfDVOBOA
 mLCoEMyg==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lecoL-0060Yj-Ni
 for linux-nvme@lists.infradead.org; Thu, 06 May 2021 12:08:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 40D2368BFE; Thu,  6 May 2021 14:08:55 +0200 (CEST)
Date: Thu, 6 May 2021 14:08:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Daniel Wagner <daniel.wagner@suse.de>
Subject: Re: [PATCHv3] nvme-mpath: delete disk after last connection
Message-ID: <20210506120855.GA1546@lst.de>
References: <20210501120447.45478-1-hare@suse.de>
 <20210504085457.GA21826@lst.de>
 <5e4df9ec-c66c-17cf-542f-bac71b490e62@suse.de>
 <d1ca6eab-1ec9-d6c7-ed8a-00d9110bf023@grimberg.me>
 <20210506074341.GC14615@lst.de>
 <96fbc678-a7e8-aaf3-5f15-8c866e683afe@suse.de>
 <d50ca6e6-5340-6f38-bc56-6f10b49d7801@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d50ca6e6-5340-6f38-bc56-6f10b49d7801@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210506_050857_945922_5C671249 
X-CRM114-Status: GOOD (  14.99  )
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

On Thu, May 06, 2021 at 02:47:00AM -0700, Sagi Grimberg wrote:
> That is my assumption as well, and its a problem that by default
> a pci device unplugs or a fabrics controller is lost and removed
> the stacked mdraid on top stops functioning.
>
> I still think we can fix that by changing the semantics of implicit
> queue_if_no_path and restore it as an explicit opt-in.

So at very least we need to make sure we have the opt-in available before
changing the defaults.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
