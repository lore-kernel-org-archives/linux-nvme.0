Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C99C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 05:01:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692E9611B0
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 05:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 692E9611B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LCw9anJfWk9uOuzr3ueUlW5PfC3tHh8gwhxpOe1xdA0=; b=WkCuVJTTHouxyS
	uEcUxwkTbemGJjD5fvpMlQH1TqX2ck+/HG65q0SXyxO9Ph0AdoGon+re/PPGPqGx6rTUcfrrhmq7A
	NaWMs6CTCCfU5qeKHQHhhvL24jO+02jfyRl6/i7meC8q2Ccc8fuhYS6438m2IKn3odX8eZtARHLfd
	knhDk7ih1/Qzt+eSpG4ahe5dQP1liGONsaRJxiBrIsaO3l1SIHagjSo/8upFUOP9lr4FhA7gcXu52
	5g+SNdjnH8qxfm3tuLJG9TREVIyTR4CIVIqRONHYNSOnErsjI9IxaHRleYIEeUhiOxgv+mu/d0eHw
	YwLfDNxM3rFu8g6i1TeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSuN4-006wBa-Ta; Wed, 22 Sep 2021 05:00:38 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSuN1-006wAy-10
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 05:00:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1899D67373; Wed, 22 Sep 2021 07:00:29 +0200 (CEST)
Date: Wed, 22 Sep 2021 07:00:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/6] nvmet: set 'CNTRLTYPE' in the identify controller data
Message-ID: <20210922050028.GA12802@lst.de>
References: <20210921151529.29419-1-hare@suse.de>
 <20210921151529.29419-4-hare@suse.de>
 <0afe1307-44d8-50d5-13b1-1939745dc2a5@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0afe1307-44d8-50d5-13b1-1939745dc2a5@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_220035_262401_2CA92A94 
X-CRM114-Status: GOOD (  12.28  )
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

On Wed, Sep 22, 2021 at 01:23:03AM +0000, Chaitanya Kulkarni wrote:
> since this check is used on more than one place in this patch,
> why not have a helper instead of opencoding that makes code easy so
> search e.g.
> 
> bool nvmet_is_subsys_disc(struct nvmet_subsys *s)
> {
> 	return subsys->type == NVME_NQN_DISC ? true : false;

That can be just:

	return subsys->type == NVME_NQN_DISC;

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
