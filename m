Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFEBECAAA1
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Oct 2022 08:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FIEaleoGV7k8rn1B0zuIXbqmOM51uevkKWRhLlI/Vmw=; b=0Z7uN/d6WShZcQxsls9w+QyEnK
	Zn61/+y0NTkw2qKl2aLtPDTeLRJqQTMVBn35lmBVus/PgUKEPu4XGfxAglhGPd3JyY6S8oke8GiEJ
	qM0NpgSDT+TwCemFoeA48owmqRK+JAB+SQVYEEcbi2DkVJ9KsK9KY99GbHaZ7TNV2gONpIttufIxG
	5ENXFYjLSnEL1AueErsAOewrcXRDdMgGP1DJ57TpiwG7qIRD6Y0dkLgheYpD4UT2lE4kGAmgFqStU
	rULdL1B3TfpCWKM+5ngyE2iqf2KkDU8w1mdoL7T+EAj+Hs4LHWQy6n5shv4UFaHLn7wFY/6ta7WT3
	pe+a8YfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooKmF-00G9Jx-C4; Fri, 28 Oct 2022 08:31:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooKm8-00G9J0-BY
	for linux-nvme@lists.infradead.org; Fri, 28 Oct 2022 08:31:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6493068BEB; Fri, 28 Oct 2022 10:31:27 +0200 (CEST)
Date: Fri, 28 Oct 2022 10:31:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	oren@nvidia.com, chaitanyak@nvidia.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme: use macro definitions for setting
 reservation values
Message-ID: <20221028083127.GB1043@lst.de>
References: <20221002082851.13222-1-mgurtovoy@nvidia.com> <cfd01d2e-1f87-2295-13bb-c8705b3335f9@grimberg.me> <3354c32d-34b3-0997-3a59-8fc199e6640a@nvidia.com> <20221025151914.GA23422@lst.de> <Y1hsoZNjDMhDbemd@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1hsoZNjDMhDbemd@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_013136_577782_BC358EE1 
X-CRM114-Status: GOOD (  11.70  )
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

On Tue, Oct 25, 2022 at 05:09:21PM -0600, Keith Busch wrote:
> As far as naming them goes, if the only usage is its definition, then
> what's the point? If there's a use for a named enum somewhere else, then
> yah, that improves readability.

I think it is nice bit of documentation.  E.g. if the enum is for the
bits or value in a nvme filed naming it after that field can be handy.

