Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F082C54EED
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jan 2023 16:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8yb5acfsm0t8FtlXyeAEb2+6Isyjlh/8JbGX1Mf5rOY=; b=mQENvggMTCFkCPubptfwZKRMCh
	pUEkD+uTgE88eALnK8ZcVPfhWzj7LXkMkSKcHTzDiawVKtW57/KUGUBH+zvLQ+FhsRU6q5bmaExLP
	hSB3msrwrX1FQWu9dNOL8JYmi8nUUrqk8BFlHxU2JUuTCvCaHTGiHZWMi4otAPCBG4xLuhow8v+Md
	OdpUzB+waV16UPvbQXles5KBrnC8a2hAxXcFzNpjaV7+x7L48kl77LbjHGQgMOgC4jV2vJb/C+x0x
	mfrC+FGNiaLb/8OX4uK5nTIc9LZbryU8yflbGXP0vvFWMN3htapPAz295qoKwSFYQCHRI1/hKpGnI
	OOS1OAUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJznu-000afl-Dm; Mon, 23 Jan 2023 16:36:18 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJzkq-000ZQC-6K
	for linux-nvme@lists.infradead.org; Mon, 23 Jan 2023 16:33:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id B29CFB80DD6;
	Mon, 23 Jan 2023 16:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04276C433D2;
	Mon, 23 Jan 2023 16:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674491585;
	bh=5s076Gn5DaBOZUkNAMXnP+jtz0GoOCT5ZFZLWbSw96A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PwRvHzwt0vNCKIpM4hdlfhdeM9l6xNR1359WS+H372WOdPWmBMn7uJIrDNVoMSb1G
	 8JUk/5Q6tZEj9IYPOcRrObmDyxzsspZkJxMjBRWbDHRzik3P8j4jlhsE6rOkRLyLRJ
	 e08v7LQAdG01nS44WDfDIi29onYP3L78zdGiveS1a0KsW48lOuzc59jHzHZkwOab5u
	 KVwGc66yC42Z2WKjAjl12+3EI7OBsKyLbsJ4aW4/w4ei/QbzqitY+3qcOnSKO0WvSp
	 +Km0y7S7nCLe8wRMKAhS5+QaNHz2xJuheyPCm2LDr9oqU9YQwjbLv24EuyvLvVrPiE
	 eK+ayg4BKEs7Q==
Date: Mon, 23 Jan 2023 09:33:02 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCHv2] nvme: always initialize known command effects
Message-ID: <Y862vnYpoi12OfaL@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20230119164739epcas5p17673bc9fb1b91d7c85561af220a230eb@epcas5p1.samsung.com>
 <20230119164128.2159217-1-kbusch@meta.com>
 <20230123102431.GA11000@green5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123102431.GA11000@green5>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_083308_438851_2FF26FFF 
X-CRM114-Status: GOOD (  13.36  )
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

On Mon, Jan 23, 2023 at 03:54:31PM +0530, Kanchan Joshi wrote:
> On Thu, Jan 19, 2023 at 08:41:28AM -0800, Keith Busch wrote:
> > +	if (ctrl->effects)
> > +		return 0;
> > +
> > +	if (id->lpa & NVME_CTRL_LPA_CMD_EFFECTS_LOG) {
> > +		ret = nvme_get_effects_log(ctrl, NVME_CSI_NVM, &ctrl->effects);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> > +	if (!ctrl->effects) {
> > +		ctrl->effects = kzalloc(sizeof(*ctrl->effects), GFP_KERNEL);
> 
> ctrl->effects is not getting freed if controller does not support the
> commands-supported-and-effects log page?

Or maybe you meant that it's never freed *ever* since it's not in the
"cels" structure? Oops, that is indeed a leak... 

