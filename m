Return-Path: <SRS0=zNYX=IX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FEEC433C1
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 15:30:57 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AAF261A16
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 15:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AAF261A16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7/oqca2GQUuXaYKEUnmBn6cXGeKw6GgNVNski+KgmWc=; b=SkbyYHe3GW/XPKuWlGuMs1JWu
	1D8o5zl7Qm7pT3QP+Wxi491KrsqdZD4sh23407LeMm2+WbhGjL0kShNj3j5Kcsn3treszhNSk31Yp
	P9VXGSutgkMEzhCiyVoXydV6CEu6IU9MM7ZLn/dSJtHaGy++5GoTEYYJkv9NdB5awnJkXA7i+CLOT
	GsfZj28ADViVttkHa3MYiPWpdXAV3BVtmfR26JEucbfin7fptamZDU0fgI+GpH0IDabJhzelN1KUn
	+3O9DT7mlA9b1sXAy5ecdjAQ5tKbI7bHaGQVHDdskkXcFhR3nyG4UAMjpj6rtrJdbOAmnOAOaTuVN
	+n/1Aymuw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPRwc-001jYU-J8; Thu, 25 Mar 2021 15:30:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPRwY-001jXl-QV
 for linux-nvme@lists.infradead.org; Thu, 25 Mar 2021 15:30:44 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1E51619E8;
 Thu, 25 Mar 2021 15:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616686241;
 bh=H7hzNet4an8I2o0heRS5gJ5wghNtpqninQ2gm8Y7QRw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GYbVTdNa4XR0B+zWls9zLs5YoBWtSTazKkOEIBRVsPAVVX/TUHvEf53ESerdWWUIj
 Zql4zyriirKHhnOjUlNVbugPzi0SSQ9vgFFz+a+bat12eosBz2qi1JjI/sDtyRniL4
 At+z9cvF9tcTtGL7VrTySZl9+IUIQMNwkeQFUJTea0g15JOw+3cB/C1Zs6mBx5V+p9
 B2v7+BDrabzsZHTih9GNfUxT3mf65yzUT8lYv20LWYtLhcKn7AdGmG5340IKTjpxd8
 4GKm9v8pYa1Xi2dxarZIMBeHnUSfhlhWZfOkvx0QBW9PeFR2oOKZnJ0f4376/XLKuO
 iLAHC2WeY7psQ==
Date: Fri, 26 Mar 2021 00:30:35 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCHv3] nvme: implement non-mdts command limits
Message-ID: <20210325153035.GC31394@redsun51.ssa.fujisawa.hgst.com>
References: <20210324231805.1232062-1-kbusch@kernel.org>
 <20210325065028.GA25678@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210325065028.GA25678@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210325_153043_130975_6B6D0A55 
X-CRM114-Status: GOOD (  18.82  )
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

On Thu, Mar 25, 2021 at 07:50:28AM +0100, Christoph Hellwig wrote:
> On Wed, Mar 24, 2021 at 04:18:05PM -0700, Keith Busch wrote:
> >  
> > +static inline u32 nvme_mps_size_to_sectors(struct nvme_ctrl *ctrl, u8 size)
> > +{
> > +	int page_shift = NVME_CAP_MPSMIN(ctrl->cap) + 12;
> > +
> > +	return 1 << (size + page_shift - 9);
> 
> A little nitpick we can fix when applying if needed:  MPS already
> is the memory page size, so the size here seems redundant.

Sure, nvme_mps_to_sectors() is fine. And perhaps renaming the 'size'
parameter to something like 'units' might be more clear and aligns to
the spec terms.
 
> > +	/*
> > +	 * Even though NVMe spec explicitly states that MDTS is not applicable
> > +	 * to the write-zeroes, we are cautious and limit the size to the
> > +	 * controllers max_hw_sectors value, which is based on the MDTS field
> > +	 * and possibly other limiting factors.
> > +	 */
> > +	if (!(ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES) &&
> > +	    (ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES))
> 
> I would place the oncs check befoe the quirks check as it flows a lot
> more logical.
> 
> But all the actual logic looks fine to me.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
