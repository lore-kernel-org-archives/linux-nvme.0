Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E37C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Mar 2022 02:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YpzW7SSao3gk1SPgNKZp0ukGGjhRcvp9hd4bPA9WuPQ=; b=tmRrFx8FLggK0dWUWbDqNz6RV/
	EHBMOz0JyIiMGIHKkIYLDlCuGYkReB8y5KVGf+PKMU55et/AwAg095MVRMxSQtc3/X7Sl73+NGdoZ
	hZNA3sPdNwk+pDsndml3J/HDVzB3OXWxaIGSeGuQlobbn+ql4ITtm40+e+seA4264ViIP78aGZH9P
	LOgIfHkiW+6DB5v5HvQhqJpKSgBcrhgQw7dhhqcnCqlIFdq2wTOAYcQf++9EdF3Hvx8gbLee66Fdm
	oQ5bnUTRiaqr1i1IdBtGB91k68wyigPHPB/olz4gqQo1TwcTH5hq6PxuP0LufoJIuCQP6wK8s86rR
	vjJmItKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nPy72-008OLQ-Qp; Fri, 04 Mar 2022 02:56:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPy6z-008OL1-Ua
 for linux-nvme@lists.infradead.org; Fri, 04 Mar 2022 02:56:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B7D9361A01;
 Fri,  4 Mar 2022 02:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559DEC004E1;
 Fri,  4 Mar 2022 02:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646362568;
 bh=zIsF6583ND1nmCG72k5Y+Sn5CLZX1lUZlZX0tJyDatc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Cr5ZaYYFzKVvur8uNdE7MgBal6PbAnnUTyPlnpGIPRqzQxTrvzCP/zGtjQw87+IDf
 UE5A6OWqSsv//soVosJ0tZrr00ttX0sOuaM9awpPeKOuHpMcHDT26ISfsQFrqLbOCx
 /I7xLNmSpN5yFfYkgwiDTraf43xhwyH6BeKiZYavROadP89ffJtfMFJ+Qd6z9Lf4tM
 dbpLKf0IFb9eJb5VMRTIQul7xTIrY7xaE3dKT55sY0pc9BxU1FGySw96m1/58lIa9u
 kTcA8n6MpW6rZEId6D7dYAJF2sAghENNuH4k4IdOZi2xDdsDSNorGpqX7CW9NH4PSh
 lZf//Hsl/BxNw==
Date: Thu, 3 Mar 2022 18:56:05 -0800
From: Keith Busch <kbusch@kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv4 3/8] asm-generic: introduce be48 unaligned accessors
Message-ID: <20220304025605.GB2824821@dhcp-10-100-145-180.wdc.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-4-kbusch@kernel.org>
 <2d8895d24fff46738f98c2dae74fa440@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d8895d24fff46738f98c2dae74fa440@AcuMS.aculab.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220303_185610_049030_DE7CCF81 
X-CRM114-Status: GOOD (  10.68  )
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

On Fri, Mar 04, 2022 at 01:31:26AM +0000, David Laight wrote:
> From: Keith Busch
> > Sent: 03 March 2022 20:13
> > 
> > The NVMe protocol extended the data integrity fields with unaligned
> > 48-bit reference tags.
> 
> If they are reference tags, are they only interpreted by the
> sending system?

No, this field participates in end-to-end data protection formats, so is
verified on both sides.

