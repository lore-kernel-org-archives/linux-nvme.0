Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE85C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Feb 2022 18:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5/1uaKlnce6rzebm+WnuAhm1JVVstW5GRTgY7CiW8sY=; b=tBg5O+cGisAs5Vt4uL8DR0TI9e
	0uSwOqfmgQeHV+xLodbr0Ku+r4aIlc33GE8vRq0JkwnOP38JSRvENV+lhKj7+JVWi4QMNovtCrk9N
	oaoYcIBMtDOf9j1HjFTmH8OBQRID1PHVhl366vQOaBIQLZDlVQKP17mWjgka66RLH7BaM+ARv8StS
	dGaNtg7W4HmLoWkm564Gde5TusPNEtIcufe2E89BAy2669VP/bZalQMFW7eEQvvCuDPd91T6XLyHS
	OAvvTWvrk+embEtvDDGefC1LmLPhEohL06mGyuQ1QdDjMF3F5gFSDgRqVrZTHi1U9I8a0/st9UtgP
	uaTOnn2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nK2j5-0047R7-OD; Tue, 15 Feb 2022 18:38:59 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nK2j2-0047Q6-LL
 for linux-nvme@lists.infradead.org; Tue, 15 Feb 2022 18:38:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 31E6768AA6; Tue, 15 Feb 2022 19:38:53 +0100 (CET)
Date: Tue, 15 Feb 2022 19:38:53 +0100
From: "hch@lst.de" <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: remove nssa from struct nvme_ctrl
Message-ID: <20220215183853.GA24529@lst.de>
References: <20220215153719.1934484-1-kbusch@kernel.org>
 <8e48a72e-8d52-2395-4889-6ec6a493c3d6@nvidia.com>
 <0c105b7f-c24b-ed24-1dcd-e9d22be13b1e@nvidia.com>
 <20220215183736.GA1934598@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215183736.GA1934598@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220215_103856_878643_3426DF8E 
X-CRM114-Status: GOOD (  11.83  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Feb 15, 2022 at 10:37:36AM -0800, Keith Busch wrote:
> > > Looks good, can we make this feature configurable from KConfig ?
> > > 
> > 
> > right question is should we make optional features configurable ?
> 
> I don't see why. What benefit does the driver stand to gain from
> conditionally compiling such capabilities?

I could see the benefit for a really big feature that is not required
on typical embedded setups.  But multipathing is the only feature
anywhere that threshold.

