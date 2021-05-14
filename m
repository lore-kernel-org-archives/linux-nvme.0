Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE83C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 08:41:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 757EA600D1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 08:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757EA600D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7tfGhbzycCIkTXAweyBvrNHaUHEQwdCwBiOT29bX1f4=; b=eF6mb4F4g2VIbr//MXDIgQRHq
	HaNk/SMhLJ40aNYIlqnbmnVhFZhxjlAuimT8oE018x6aK7w1gLiewMKtx3ol/rd80Ag1dJtiDToAK
	QvbLDcHJ+ZMp9GojaCbMiNLEbh4kMVwRCiATnNCSDYzRQScklrYvX+bP5kdujcZ26Lq21lZkn/mBs
	Go3ZTDmFnUBS2RvHiBx02rR134OPR89ppl2dIGCWSla7kzJh4YkkoSyre2iMXWNudVys4DdR8UzT5
	Ofnf/9z/cLyiA3gfPpf6V0m8xBQ0wL34yrMmzYXnFDHi8Q+qED+QLVqJJiI/j2jrxURofL+oQNWW3
	giLlJDNKQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhTNr-007XQM-Ol; Fri, 14 May 2021 08:41:23 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhTNn-007XPN-Od
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 08:41:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=TJn/nLoU9Syw+KdnV6O/lwjrev39jSRJ3buOrGlP4Mw=; b=IX2jIFDIK4gxj50XtiOxQDoEnv
 kgWFiTTQ3/pN7Toas4L6Z+T9Kq2IHWh9mt+oLHLn4h+gxGnHRprdnOW517nthPvWWTqhNrzsQvzdF
 VR5ifJaCJPYpwm18GZrgHg0dSIKmZWFSSdY3x/jhyhTH0ViLHUls3Am/oP70kHDT4qbBSMI4vxMpX
 E4XzclhQyyFlITbkYk+or+huQbiG8MXB1Ksa2hNAGD2rc88oxkcq0dn2CNFNfbbIox7AjDBZXztZ1
 ryVijy1o0kTOcxEKwKmboRlHRt0xxRxvdD4CgQmz4uiyxQJhKgbicsjckZzvmawVB8wSMtqyi+2a8
 PpbVDYew==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhTNk-00BpMP-Bd
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 08:41:17 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 6BADBB151;
 Fri, 14 May 2021 08:41:13 +0000 (UTC)
Date: Fri, 14 May 2021 10:41:12 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Enzo Matsumiya <ematsumiya@suse.com>
Subject: Re: [PATCH v3] nvmet: Reset ns->file when open fails
Message-ID: <20210514084112.pxeoyx2lpvwpvvgi@beryllium.lan>
References: <20210512145005.103653-1-dwagner@suse.de>
 <20210512174942.GA26130@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210512174942.GA26130@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210514_014116_580328_6C52A4C5 
X-CRM114-Status: GOOD (  10.37  )
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

Hi Christoph,

On Wed, May 12, 2021 at 07:49:42PM +0200, Christoph Hellwig wrote:
> Thanks,
> 
> applied to nvme-5.13.

I did write the first word with a upercase letter again. I
swear, next time I use a lowercase one.

I noticed you fixed this from 'Reset' to 'seset'. In case you are going
to rebase the branch, you might want to fix the typo. It's not terrible
important though.

Thanks,
Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
