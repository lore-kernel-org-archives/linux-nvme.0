Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA699C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 14:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iQxIB7QH0VxqWxMly9wWD8lldbF8WlQitLmdYg/Ud74=; b=MdvmFH/0AXFXvOaa8CKG2vnvfZ
	ZHzPF2Q0YSTgPKbB2krhG5LuUtWuAx4EduZAqtj/XR0eb5D9JrWSDvop7B/Qxp7i52TTpSPRYwtUW
	HWB7qnOi9Sys6kppWLdStpeMA0qCEZKYJbVvHkSjfeVPfxFIQCREHd2e/M5QVuC3GpfjBlzXNWrfu
	RfGPfBfdeIT85UDrMj/O5I7T8gkpQVFDhH8yViUYsgM+bSTqSWkr0I+872Bk6IgIJYxrxxsYiRNRQ
	Gqo1cK2AGwo3Vjb93Qx5oF5fvxBKrMEz+j2X4AtMvc3AIDqX1gc1ITJJG/4tA7uiB0fbrifCNcbBD
	SwvWOgWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSJft-00D3zX-Kk; Thu, 10 Mar 2022 14:21:53 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSJfq-00D3yN-Vr
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 14:21:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2E2F968AFE; Thu, 10 Mar 2022 15:21:48 +0100 (CET)
Date: Thu, 10 Mar 2022 15:21:48 +0100
From: "hch@lst.de" <hch@lst.de>
To: "Luca Porzio (lporzio)" <lporzio@micron.com>
Cc: Manjong Lee <mj0123.lee@samsung.com>,
 "david@fromorbit.com" <david@fromorbit.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
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
Message-ID: <20220310142148.GA1069@lst.de>
References: <20220306231727.GP3927073@dread.disaster.area>
 <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com>
 <20220309133119.6915-1-mj0123.lee@samsung.com>
 <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_062151_209950_DA645BDF 
X-CRM114-Status: GOOD (  11.23  )
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

On Thu, Mar 10, 2022 at 11:34:40AM +0000, Luca Porzio (lporzio) wrote:
> I work for Micron UFS team. I confirm and support Manjong message above.
> There are UFS customers using custom write_hint in Android and due to the 
> "upstream first" policy from Google, if you remove write_hints in block device,
> The Android ecosystem will suffer this lack.
> 
> Can we revert back this decision? Or think of an alternative solution which 
> may work?

Hell no.  Given that these custmomers never gave a singe fuck to actually
support whatever crap they came up with upstream we're not going to leave
dead code to encurage them to keep doing this.

