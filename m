Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71345C38142
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jan 2023 16:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6S0AQsWZnAN6xNeEuUvA6GlycA7qJa4b7HtGNu7mjSo=; b=tNMQt49T5YCyyNgBxa6ydFNfPe
	6cSnjjAdmo3gEFnNMRWv1zz/j5J6fpSkJXrd5gUD8ljdKRKR2xhN9qTHricDxtu6GRtc7gLJTbXwS
	2enzKxve3FxQtQuY1QWzIX8RCwpkyb0o6mNIC0iA5Bik2X+TsTYbOLkFg2v0bSQdua6IG/CkLMLUj
	oLFfbEz42xeobQX0L+GEeQ2fw/bdzriAiTkdLYcIfZGVIXnWHsIcjNFN2ASDFYaZh/1LC28qsORD6
	szacCaT+3l9EVD/nszLpLuvZFxyvSA+1WuBnLVSGltYlpwjETMBRp6B08jeCd58V+ANnNDix1pLU7
	dFJ/g2oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJznY-000aVq-Ur; Mon, 23 Jan 2023 16:35:56 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJzhW-000Y13-AV
	for linux-nvme@lists.infradead.org; Mon, 23 Jan 2023 16:29:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id B8B1FB80E19;
	Mon, 23 Jan 2023 16:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1079C433EF;
	Mon, 23 Jan 2023 16:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674491378;
	bh=v2c+eOnt0hzKVuZFfB8MNf1AKeo2YUXNRO8RQgUg+X4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yf23+Dps+xKmAsSNUkNj4zFROjM0N3m0J2Fxikc+mFE39Zk/ykwgq13BoUbnZ7Vp4
	 yEp+3KuL/LfTkgOK88ggF705V5qpez8Y2stDTG5H4E96WbEELvn2igNkHfqMbV6aqX
	 7YFP7PjanVwkDFGRQaKsma8qJDJVUbm8Fb+UopOsAav79/aRADhWPwp5MsLolcoW9r
	 Qc9XO5CkTL8TUpJsKBID7hPZcKfDnki1ToeJYVVLfne3rDvX32Kkl+hc+cn/N6RNgK
	 QKI+uWyoch+sfwDU58Iomta6zSVEOVaX1iti8EEQGXreA3THSd2+FLUP9z2qH9Ktwk
	 Xzv6Keo2ajbLA==
Date: Mon, 23 Jan 2023 09:29:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCHv2] nvme: always initialize known command effects
Message-ID: <Y8617zOJDMka7J0h@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20230119164739epcas5p17673bc9fb1b91d7c85561af220a230eb@epcas5p1.samsung.com>
 <20230119164128.2159217-1-kbusch@meta.com>
 <20230123102431.GA11000@green5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123102431.GA11000@green5>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_082942_540869_6F507AF0 
X-CRM114-Status: GOOD (  12.32  )
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
> > +	if (!ctrl->effects) {
> > +		ctrl->effects = kzalloc(sizeof(*ctrl->effects), GFP_KERNEL);
> 
> ctrl->effects is not getting freed if controller does not support the
> commands-supported-and-effects log page?

Right. If the controller doesn't support it, the driver will make one up
with some sane defaults. The point of this patch is that we don't want
to re-construct the defaults for each passthrough command so we need to
store the defaults somewhere.

