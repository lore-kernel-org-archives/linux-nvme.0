Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5D8C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 19:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qnNHnMvHG02Ly4rM0aPHESYzZMu2fr4eGAWdFol6VdQ=; b=pPREQLIkxebwB+dzjdcUSe2CFQ
	xL/ZM/ZX2PmTPa34vaaBQzgbPeQeQw6/lfw4FUr+peNjVj5lC/CBYZjtuIZbk5m0eb+5uEE533F0D
	gJ/Mn8yipooCDKfWgyK+KoZ+bqgd+ywx6HkWCijVk/4QZdyRLfQqjVZmZPwFFJg/T4hHpntIwH3Gv
	OR7/ouBhC7OPnRu+kbuHZh6LbnHgbcS2vpgQYNiW63xUJMo2myC8Ua7PxZS8NiltjCThw4jkQHCRi
	MgMuu5kLlKIpUhOQzIgx6J1/jtqyc6bGnujkmFKeKl3mbhza9E3xue5GYXyDNVY3RmnwbdpaPAqve
	I3fHg5JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSOFW-00Dn9L-UZ; Thu, 10 Mar 2022 19:14:58 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSOFS-00Dn74-RO
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 19:14:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B24FF68AFE; Thu, 10 Mar 2022 20:14:45 +0100 (CET)
Date: Thu, 10 Mar 2022 20:14:45 +0100
From: "hch@lst.de" <hch@lst.de>
To: "Luca Porzio (lporzio)" <lporzio@micron.com>
Cc: "hch@lst.de" <hch@lst.de>, Manjong Lee <mj0123.lee@samsung.com>,
 "david@fromorbit.com" <david@fromorbit.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "song@kernel.org" <song@kernel.org>,
 "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
 "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
 "nanich.lee@samsung.com" <nanich.lee@samsung.com>,
 "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
 "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>,
 "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
 "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>
Subject: Re: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Message-ID: <20220310191445.GA7338@lst.de>
References: <20220306231727.GP3927073@dread.disaster.area>
 <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com>
 <20220309133119.6915-1-mj0123.lee@samsung.com>
 <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <20220310142148.GA1069@lst.de>
 <CO3PR08MB7975AB3E282C7DA35A5B1CF0DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CO3PR08MB7975AB3E282C7DA35A5B1CF0DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_111455_066189_0C36EBB1 
X-CRM114-Status: GOOD (  11.42  )
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

On Thu, Mar 10, 2022 at 06:51:39PM +0000, Luca Porzio (lporzio) wrote:
> You are starting from the wrong assumption: I'm just saying this is not dead code
> but it is used across the (Android) ecosystem.

No one gives cares about random forks, so no I'm not starting from the
wrong assumptіon.  You on the other hand seem to have a lot of learning
to do if you thing some random kernel fork matters the slightest about
what is considered dead code.

