Return-Path: <SRS0=b72z=GS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF16C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 07:15:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E2622597
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 07:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E2622597
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zf/4EI2rmUvOyrndgHOV0OceB5GzdCfD4ikjVd9diFc=; b=QN6dOr70hQi7ylK4CfHQ8UbFh
	V2mkO+BN5wgvhi4j7X2/wq4xfgqrVe5V0LGbkVERn5WDBgEzAx+/NBw/LGXUhcQEawWYb04Ijl+/F
	/68KwWvobg5YSpNgBlVblPOAptDwAq9gzTSQaJHvZnuoJFBiFoZ/ftMuyPyTne3MSrxb39l32kazL
	RFx4cQFb/Np7KP+jiqE81VSgNON5F75APUkFqIJE+p9PMySRyNolI8d9P/ONUAGrTPSqOy6AZjYHM
	XSwTDY5v718ACS+92+EbMeswnsMvPTmFXI6Lz/NK0JL3dGRpdeDxgCCvPZ/F4AElr+FHdsGP32I9+
	uBrXPs8yQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l0JKF-0000XB-SM; Fri, 15 Jan 2021 07:15:15 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0JKB-0000Wi-Nn
 for linux-nvme@lists.infradead.org; Fri, 15 Jan 2021 07:15:12 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 94F6DAB7A;
 Fri, 15 Jan 2021 07:15:07 +0000 (UTC)
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
To: "Knight, Frederick" <Frederick.Knight@netapp.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
References: <20201209155321.GA31729@redsun51.ssa.fujisawa.hgst.com>
 <b9c9e5f9-a447-2a2e-b687-304dd8f3d2b2@suse.de>
 <20201209161911.GA31836@redsun51.ssa.fujisawa.hgst.com>
 <66bad47c-0cd3-8461-3629-146778f15059@suse.de>
 <20201209173936.GA31971@redsun51.ssa.fujisawa.hgst.com>
 <20201209174718.GA19512@lst.de>
 <DM5PR0601MB3624722C4C00B5A7EDB7E6A0F1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201209213437.GA3682670@dhcp-10-100-145-180.wdc.com>
 <20201210085111.GA15999@lst.de>
 <baa8c2e6-1376-1cad-4c84-1129bd80d4ca@suse.de>
 <20201210133418.GA3645@redsun51.ssa.fujisawa.hgst.com>
 <eb84db43-5e63-19b4-cdb9-53f52d1c45e8@grimberg.me>
 <DM5PR0601MB3624BB4004C273271F30052AF1A80@DM5PR0601MB3624.namprd06.prod.outlook.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <3f96f147-cc19-f799-7832-0391459828ea@suse.de>
Date: Fri, 15 Jan 2021 08:15:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <DM5PR0601MB3624BB4004C273271F30052AF1A80@DM5PR0601MB3624.namprd06.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210115_021511_912070_1AD142E4 
X-CRM114-Status: GOOD (  14.83  )
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
Cc: "George, Martin" <Martin.George@netapp.com>,
 Hannes Reinecke <hare@suse.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS8xNC8yMSAxMTo1OSBQTSwgS25pZ2h0LCBGcmVkZXJpY2sgd3JvdGU6Cj4gQXR0YWNoZWQg
aXMgdGhlIHByb3Bvc2VkIGNsYXJpZmljYXRpb24uICBUaGlzIGhhcyBoYWQgWkVSTyByZXZpZXcg
dGltZSBpbiB0aGUgTlZNZSBjb21taXR0ZWUuICBTbyBqdXN0IEZZSSBhdCB0aGlzIHBvaW50Lgo+
IAo+IEZlZWwgZnJlZSB0byBzaGFyZSB0aG91Z2h0cy4KPiAKVGh1bWJzIHVwIGZyb20gbXkgc2lk
ZS4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAg
ICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21i
SCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJn
KSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QK
TGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
