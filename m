Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11CFC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 16:19:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E23E611B0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 16:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7E23E611B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fuckner.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qYiqAvjyPlh6eK23Qokye+yGFH6MpdQg8y3OOrLuEbI=; b=b/nZCGpoVilPC4PHTNWuOfMNN/
	Z20Qe/4Lhx52ZCdWOzrgAtCPdaFcMOma+7cAijIr0dpLbFYeeR2jT5v3YL6sXXPMgiZb+k1YLGN2y
	r5mCiYX+6LlxlB1I979x09RdAoSfG6up9O68eo9N6/VfZm+7Okw4cLL2ebSM0d0huGErOm/Y2PntT
	HC2PRB2SbvmwmBULpxKKCFPQcmNPKVYWmFA5J3qsnpqEFN4Bbl7Vq8d0lqXk6eCsT46yapCqRURT2
	RsLtniE5X09Mi/mILgq8GuupFKnLbPRCZUOcnPmvhCrjoKd/nf2WkODkTCQaR0apuvsoTJ+fraAAi
	IZGTn9Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mdEJV-005Dnk-5D; Wed, 20 Oct 2021 16:19:37 +0000
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdEJR-005DmO-Tv
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 16:19:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1634746768;
 s=strato-dkim-0002; d=fuckner.net;
 h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=qYiqAvjyPlh6eK23Qokye+yGFH6MpdQg8y3OOrLuEbI=;
 b=HRvduh+kn0o0Mj49CmG0Ix20vWnEYX8UHkOy5HXoM3kfz3XlL2AU8rkgRY0sSB12Yi
 a5FSWjH/LT+Fgq+CAz4xZud+HImqDDgX09ByeuHW2/OFvq95Wa9WA8WEIaKktWgWW4f4
 tSkPsiFvK6eD0eZcnr+DsCJQtCQnayQlaODAk21hebDq1OjZhl+LDeQqKQMDh7dZsCvA
 Ps7zCRGpE8+7sHs45DaO5pBNeWS2IbtNvWL6Lb0ef7PrYb9UOT2O9oicOHvs4UksMnpP
 YRKGWx2IgD8ZJrlSthZsVhBL0MRalXitQZACr9d3jwGskkp1s4aqpYvdF07h0CVxcS2p
 JOIg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":IWUHfUGtd9+6EujMWHx57N4dWae4bmTbIPWLqR/scRfpbcFYDmdyCXC8+RaIVQFZ9oBy"
X-RZG-CLASS-ID: mo00
Received: from oxapp03-03.back.ox.d0m.de by smtp-ox.front (RZmta 47.33.8 AUTH)
 with ESMTPSA id 6017e9x9KGJSkL1
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Wed, 20 Oct 2021 18:19:28 +0200 (CEST)
Date: Wed, 20 Oct 2021 18:19:28 +0200 (CEST)
From: Michael Fuckner <michael@fuckner.net>
To: Keith Busch <kbusch@kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Message-ID: <1692762439.5341100.1634746768656@com4.strato.de>
In-Reply-To: <50968b55-e25a-cf60-36a2-b330d5362024@fuckner.net>
References: <34244386.3221623.1633769595569@com4.strato.de>
 <20211011191249.GB635062@dhcp-10-100-145-180.wdc.com>
 <50968b55-e25a-cf60-36a2-b330d5362024@fuckner.net>
Subject: Re: Namespaces on MZQL2960HCJR-00A07
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.5-Rev24
X-Originating-Client: open-xchange-appsuite
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211020_091934_211587_FF3E37ED 
X-CRM114-Status: GOOD (  10.88  )
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


> On 12/10/2021 10:28 Michael Fuckner <michael@fuckner.net> wrote:

> test220:~ # nvme create-ns /dev/nvme7 -s 26214387 -c 26214387 -b 4096
> create-ns: Success, created nsid:1
> test220:~ # nvme attach-ns /dev/nvme7 -n 1 -c 0x6
> NVMe status: Controller List Invalid: The controller list provided 
> contains invalid controller ids(0x211c)
> test220:~ # nvme delete-ns /dev/nvme7 -n 1
> delete-ns: Success, deleted nsid:1
Hi,

got another drive to play with (Micron 7400) and I can use the nvme tool as expected- so I just consider Samsung Firmware broken?

 ram1:~ # nvme create-ns /dev/nvme0 -s 26214387 -c 26214387 -b 4096  -dps 0 -nmic 0
create-ns: Success, created nsid:2
ram1:~ # nvme attach-ns /dev/nvme0 -n 2 -c 0
attach-ns: Success, nsid:2
ram1:~ # nvme list
Node                  SN                   Model                                    Namespace Usage                      Format           FW Rev  
--------------------- -------------------- ---------------------------------------- --------- -------------------------- ---------------- --------
nvme0n2               213331B0EE15         Micron_7400_MTFDKBG3T8TDZ                2           0.00   B / 107.37  GB      4 KiB +  0 B   E1MU231W
nvme0n1               213331B0EE15         Micron_7400_MTFDKBG3T8TDZ                1           0.00   B / 107.37  GB      4 KiB +  0 B   E1MU231W
ram1:~ # 

Regards,
 Michael!

