Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950F1D374A2
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 14:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9zaYnG8LBfw3AFTBnKZAJnThYnyZyHG9WIVT4s9S7mA=; b=YfcVcNIWTHNKXSb5vHOU8ofkZs
	fM2BoE9OjWA5s8h/V7bI4SSvghBO3oKtxRfsFLumVDi/RDfecHWdphCdTqRbTLOT3KD3DQ8Sifjq5
	wQZJGiqygHRpezgjgd32vd+TvtpQknUWAn4p1Ehdvkb0TfaF07Rjs0t4tkqxBc8GBZfdG08cT3N3A
	tk57GR9vcAhF98uoQuCK4sQdd3t3NwNz7K3AlwjryPVloG508vGWKHPJX86a3qqaTmPk795WfJExs
	6fhEiaFn67Ezzo6tbN0bvhFr4OSjvy7SIxaLbFPu4O8QM5fF+e+/t+hmU4jQwbN7BjMAPBK43IECr
	JJFFUNRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Rbl-0000000F8Vh-1IWk;
	Thu, 17 Oct 2024 14:36:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Rah-0000000F8Fg-2IEZ
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 14:35:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 041FC227A8E; Thu, 17 Oct 2024 16:34:58 +0200 (CEST)
Date: Thu, 17 Oct 2024 16:34:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj gupta <anuj1072538@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Anuj Gupta <anuj20.g@samsung.com>,
	axboe@kernel.dk, kbusch@kernel.org, martin.petersen@oracle.com,
	asml.silence@gmail.com, krisman@suse.de, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com
Subject: Re: [PATCH v4 06/11] block: add flags for integrity meta
Message-ID: <20241017143457.GA21905@lst.de>
References: <20241016112912.63542-1-anuj20.g@samsung.com> <CGME20241016113745epcas5p1723d91b979fd0e597495fef377ad0f62@epcas5p1.samsung.com> <20241016112912.63542-7-anuj20.g@samsung.com> <20241017080015.GD25343@lst.de> <20241017104502.GA1885@green245> <20241017120102.GA10883@lst.de> <CACzX3AtdmWgEggmQsfqHU-GjdbQHTq9DwCzW07VG9zaoXaWfgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACzX3AtdmWgEggmQsfqHU-GjdbQHTq9DwCzW07VG9zaoXaWfgA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_073503_753734_40D086BA 
X-CRM114-Status: GOOD (  13.46  )
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

On Thu, Oct 17, 2024 at 06:29:32PM +0530, Anuj gupta wrote:
> The last iteration of this series added these flags as io-uring flags [1].
> Based on feedback received [2], I moved it here in this version.
> Should I move them back to io-uring?

Maybe I misread the patch back then, but IIRC at that point the flag
was also used on the bio and not just in the uapi?

As of this series it is used in the uapi, and in the block layer.

Based on that uapi/linux/fs.h might be the best place.

