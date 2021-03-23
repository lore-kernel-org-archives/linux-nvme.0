Return-Path: <SRS0=jrCY=IV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64292C433C1
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 12:31:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B103860C3D
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 12:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B103860C3D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ot0XMmrtoXe7FHLjrcVZzn3s0jhNMeRVaxH/Q/dxX0c=; b=iidoJKX/Tuw3f403pMZDdl72e
	n52hD6WXnqkD67iUoVeI5Ga2lYfs10MHk1FGRfuTnxcUo2kYR+I1KOE1uKr+J4lBhBz2xYVesvzFs
	hC/IG5HN3fFl5M7BCn0z19XTlH+vjOaLvfKhJtQIrkomLej6JRFlSy7kuE3IXgzC54URJaB2peFc/
	cyHlL3l5/yVthbyGFE58bgFE+Fq+thcCw6hBf0YkuZ3Gg5VA2IFJpf7m233pe3HI4+uuunYAu2zFh
	BzzteZkSnLsbv3IxuxUgg8gDO3dRC/VHvUN8TrATfBABi2fVSpDSk0iId8s5O1lVUt6IMYZe2U1zp
	L9CPqHHVg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOgC2-00Exxa-KW; Tue, 23 Mar 2021 12:31:30 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOgBy-00Exwp-Rr
 for linux-nvme@lists.infradead.org; Tue, 23 Mar 2021 12:31:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2A7F268B02; Tue, 23 Mar 2021 13:31:22 +0100 (CET)
Date: Tue, 23 Mar 2021 13:31:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya.Kulkarni@wdc.com
Subject: Re: [PATCH 1/1] nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a
 Samsung PM1725a
Message-ID: <20210323123121.GA31105@lst.de>
References: <1615377076-3251-1-git-send-email-dmtrmonakhov@yandex-team.ru>
 <20210310132156.GA12145@lst.de> <20210310134110.GA13063@lst.de>
 <20210310200030.GA3377333@dhcp-10-100-145-180.wdc.com>
 <20210311104712.GA16218@lst.de>
 <CGME20210323083750eucas1p14d21230ac758194d854ca336caf7f3f2@eucas1p1.samsung.com>
 <20210323083749.r272grolxozf3w2f@mpHalley.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210323083749.r272grolxozf3w2f@mpHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210323_123126_972179_FDDCA822 
X-CRM114-Status: GOOD (  12.31  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 23, 2021 at 09:37:49AM +0100, Javier Gonz=E1lez wrote:
> Quick question. It seems like the current quirk simply disables
> write-zeroes. Would you be open for a quirk that aligns with MDTS for
> models that implemented it this way before TP4040?

Aligning to MDTS is our current behavior, although all kernels up to
5.11 had a bug in the calculation.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
