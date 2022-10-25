Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B0EFA3740
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 15:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4SMeSm4DlwzKbpIIBL4LUw93Y17IjwGNlfOdMx58+5M=; b=L573fhrt8g0CuHpo4d2i0wQwBF
	fsFttZZOlR586db9wUS4j+ZR/gqWzgf7i7XvqS/pTe1LVTV67KwVuF6bHNFcYGaTkZy1WZrTNwMso
	8ck3Pg47ovHmE89pFBxS82sON/816ofFLT+xuRpAUjLbfbRAl9k+Dom+yBGjEVpTa6JK+26Ff+vSM
	UJVAGOZ1zrQt46s35/5CAEoPsjK9CpDwOZDiG/Eau/jjyseu5POF9WwhqaWSRLbw01Lk0tgA9RLNp
	A38gNfBn27FIK61VlFtMgdU/Fax2SZPi25Gd6nVKuOeFKcTIoLCkErrDX6QdDKyzQAZ3uWWpffukr
	+JA2Q+zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onLi5-0063E4-2m; Tue, 25 Oct 2022 15:19:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onLi2-0063C8-4H
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 15:19:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 64F1F68B05; Tue, 25 Oct 2022 17:19:14 +0200 (CEST)
Date: Tue, 25 Oct 2022 17:19:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	hch@lst.de, kbusch@kernel.org, oren@nvidia.com,
	chaitanyak@nvidia.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme: use macro definitions for setting
 reservation values
Message-ID: <20221025151914.GA23422@lst.de>
References: <20221002082851.13222-1-mgurtovoy@nvidia.com> <cfd01d2e-1f87-2295-13bb-c8705b3335f9@grimberg.me> <3354c32d-34b3-0997-3a59-8fc199e6640a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3354c32d-34b3-0997-3a59-8fc199e6640a@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_081918_328584_EE512329 
X-CRM114-Status: GOOD (  15.48  )
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

On Mon, Oct 03, 2022 at 01:16:36PM +0300, Max Gurtovoy wrote:
>> I'd make this named nvme_pr_type
>
> Most of the enums of this header are not named.
>
> I don't understand what is the convention here.
>
> Usually, if it's not a new header file I'm trying to keep the file 
> convention and this is what I did.
>
> If all agree on named, I'll send another version.

I think named is better, nvme has some weird unnamed enums that
even combine totally unrelated fields which I always found confusing.

