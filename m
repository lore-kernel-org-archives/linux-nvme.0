Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB89BC4332F
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Nov 2023 16:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rqYXSL+MVbXDwRx9+a+EfPXw7ZCZOYp34K8jtUl35VE=; b=BqV0HCmRuWdVgmxBsdrVeRb67u
	+MuDop+BpYKh2nE2Kr518q8n3nCIrDchlaxsZDK7JmggyYI4COb0/7YbNpiwBveMOJXDay9OJGDcp
	kSEFCyGWAxFwjCTSvhpDAXXdo7ItuupbeJWXa23nKw36VBoly74qSDjkPXdTpvk36R89BJQDUZiUN
	ddYWlPND2SBU3biKyZKBhIk7ZQ4sr46MDrqbLFyzkhQCbn6s1iNO9zEIvzkhEqtSOSBf0al74nHlK
	CDv/e5SeR9Bxu+CSwcKbfL2UWPRYNd7XP7ZOf6d09NUBe2FP9R74Oj1Pt6uXpy0xczXhAw/6iwQPq
	CyZ2E7VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r02iY-00H8Cc-2M;
	Mon, 06 Nov 2023 16:44:50 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r02iV-00H8Bh-1n
	for linux-nvme@lists.infradead.org;
	Mon, 06 Nov 2023 16:44:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 0B5A5B80DA0;
	Mon,  6 Nov 2023 16:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5688C433C7;
	Mon,  6 Nov 2023 16:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699289083;
	bh=lwJGtrml9/BgrDRgIC5tla53Nlno4JDjCOXCP23EQDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O4DdHXUJuh/SmClx633LjRNEta2shZD6iz6oYhV19nmfkaeaMz1gIgehwrDxRA0D0
	 EMIH3PR8CTbejhC7n4bL4wDtbBejOqOZy39eMizFgg34EHNUmlPHw35uSHxHknXIsu
	 kydnEJXa7tjrti7GTRRxelxrCq/ONQEBvx0wGpUw8Xd/Q+7g5yP5NnY5rDaIhEwYT6
	 YZ0D8F9vQoys/cntstVZQ449HhV09eRuon2ZuuH2sjCsi/ZaRi42dWG0gcz7BxvpyU
	 rR5PqW2STsA408kvutNZuSl1EWg1Zl10JQZCuHkBEk/oxQpyfpQjXb1Fx4SDSBOXFm
	 zN6dm38at9V4A==
Date: Mon, 6 Nov 2023 09:44:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Niklas Cassel <Niklas.Cassel@wdc.com>,
	Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v3] nvme: update firmware version after commit
Message-ID: <ZUkX9z1M3ZxjIp6Z@kbusch-mbp.dhcp.thefacebook.com>
References: <20231030160044.20355-1-dwagner@suse.de>
 <ZUEmlRnBVr9LGDnF@kbusch-mbp.dhcp.thefacebook.com>
 <y32ounthrv2uuedtriy73oir5m7k5ryupzytd2x5wn436bcrj7@7xalhdepjyk6>
 <20231103135857.GA1871@lst.de>
 <ZUUCE88vOi6Wj69a@kbusch-mbp.dhcp.thefacebook.com>
 <gwyjg43fnkzhrxmeub7zdoikvwfpatdrmaaoaqggdlfgopnpki@uba2ulvqruk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gwyjg43fnkzhrxmeub7zdoikvwfpatdrmaaoaqggdlfgopnpki@uba2ulvqruk3>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231106_084447_735938_58A54165 
X-CRM114-Status: GOOD (  18.85  )
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

On Mon, Nov 06, 2023 at 08:00:44AM +0100, Daniel Wagner wrote:
> On Fri, Nov 03, 2023 at 08:22:11AM -0600, Keith Busch wrote:
> > > All 0's based (what a stupid term..) fields in NVMe are explicitly
> > > marked as such.  And even if that wasn't the case I'd very much
> > > expect the same encoding for the two sub-fields.
> > 
> > Yeah, it's just the firmware slot number, taken literally. AFI = 1 means
> > slot 1, AFI = 2 means slot 2, etc... Slot 0 either has special meaning
> > (firmware commit SF field, or fw log AFI bits 6:4), or is reserved
> > value, like in Identify Controller FRMW.NOFS, and has no place in the FW
> > Slot Info log page.
> > 
> > Our first slot in the log page is defined as slot one, so we have to
> > subtract one from the AFI field to index into the slot array. I messed
> > up for not catching that earlier, but thanks for pointing it out now.
> 
> Thanks for the clarification.
> 
> Do you want me to send a follow up patch, a new version of this one or
> do you fix up yourself?

Fixed up inline when applying the original patch. Let me know if you
have any concerns with the result, currently here:

  https://git.infradead.org/nvme.git/commitdiff/983a338b96c8a25b81e773b643f80634358e81bc

