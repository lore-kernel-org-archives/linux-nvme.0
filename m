Return-Path: <SRS0=bCog=6A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EB1C2BB85
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2020 10:37:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3630A21D92
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2020 10:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kuX63SxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3630A21D92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dOJgNUp7hVg5MiYu+9JDM/k26qkdQz2UBzFzkLWXFUs=; b=kuX63SxXzdL96W0V4ubbZFhR4
	SIM6PN9J46xA2OpvRmfD8yK1ms/zCCBsIy3Pn8aJ4OGxsVC7ON1MgqZsuG2bKPyxjcBiWR+cA2/07
	orLamoMRGmxE9abWcJhOCDdgZTlE+mW7dnooeP3U0GHCX6Z/Jhx8cMLjKMFSZNK20zfsD+J6DlHJa
	hH2ZcmvzhszH563x7jv4Xp4bOIw2GH6eNnWkyXKh6kVJyI5cP095GF1NuqHvLD+3VwjH35Hk/2Ns+
	X5mvojYORnLBBuvWyx48fFLHGgpUy4aCMciUVAkdbiikGTUx4liwnEbdhRMg9hOGY1aXn4adc/5YX
	stnJ31R6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jP1tc-0008RS-TG; Thu, 16 Apr 2020 10:37:24 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jP1tY-0008Qj-Se
 for linux-nvme@lists.infradead.org; Thu, 16 Apr 2020 10:37:22 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 00A21AC91;
 Thu, 16 Apr 2020 10:37:15 +0000 (UTC)
Subject: Re: [PATCH 0/3] nvmet/fcloop fixes
To: Christoph Hellwig <hch@lst.de>
References: <20200306130440.16864-1-hare@suse.de>
 <20200331142413.GA18803@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <321166ea-9da2-9475-9d40-8b0bc97e4e96@suse.de>
Date: Thu, 16 Apr 2020 12:37:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331142413.GA18803@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200416_033721_069753_D1527569 
X-CRM114-Status: GOOD (  13.60  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, James Smart <james.smart@broadcom.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy8zMS8yMCA0OjI0IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBIYW5uZXMsCj4g
Cj4gYXJlIHlvdSBnb2luZyB0byByZXNwaW4gdGhpcyBzZXJpZXM/Cj4gClllcywgd2lsbCBiZSBk
b2luZyBzbyBzaG9ydGx5LgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tl
ICAgICAgICAgICAgVGVhbWxlYWQgU3RvcmFnZSAmIE5ldHdvcmtpbmcKaGFyZUBzdXNlLmRlICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdh
cmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4
MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52
bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
