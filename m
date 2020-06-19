Return-Path: <SRS0=ohfr=AA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13F9C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 07:42:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C7CE2073E
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 07:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FsDNWPgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7CE2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jepnfp93yrjkgHvWiCxlVwcz2GN6FHdSTMz8JYNXXVg=; b=FsDNWPgbdK4WIW
	9akZ6VbX5vTEklS+CDzAYk2g2Frl9B5Tn9X5Y6DFX5A1rwypTXuLbXdngf9tSkdXisRRJv44Y6pkJ
	M5lKnZcQQLB5N6/MuvpPepy4omPFJ9i+ghJ5yfFOlv2zLFUUVhR9rMtF5yo+RIcIawu5FuTykFgWZ
	LeiKOgPE6UgCW29ji6le7rsCDkWaTRJote9vHYG1FqlNWZSTPA5G85Sv5oT8K2+K8iNHNBh15x6PE
	eFXnwEB+vjwjmQPH6CY+Kilxefa2vaasAt8I88GO0FMOB9JT3WVSh9cYPp+WjSwVAmGRLpCOd4rnd
	zQLTM2FBkWNq40/SqnMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jmBfF-0005eG-CF; Fri, 19 Jun 2020 07:42:17 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jmBfC-0005dV-B7
 for linux-nvme@lists.infradead.org; Fri, 19 Jun 2020 07:42:15 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 77F68B196;
 Fri, 19 Jun 2020 07:42:08 +0000 (UTC)
Date: Fri, 19 Jun 2020 09:42:07 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 3/5] nvme: implement I/O Command Sets Command Set support
Message-ID: <20200619074207.vamnsauvdhac2n43@beryllium.lan>
References: <20200618145354.1139350-1-kbusch@kernel.org>
 <20200618145354.1139350-4-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200618145354.1139350-4-kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200619_004214_531178_AB611724 
X-CRM114-Status: GOOD (  10.59  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, Niklas Cassel <niklas.cassel@wdc.com>, sagi@grimberg.me,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jun 18, 2020 at 07:53:52AM -0700, Keith Busch wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> =

> Implements support for the I/O Command Sets command set. The command set
> introduces a method to enumerate multiple command sets per namespace. If
> the command set is exposed, this method for enumeration will be used
> instead of the traditional method that uses the CC.CSS register command
> set register for command set identification.
> =

> For namespaces where the Command Set Identifier is not supported or
> recognized, the specific namespace will not be created.
> =

> Reviewed-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
