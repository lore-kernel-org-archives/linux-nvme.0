Return-Path: <SRS0=H+rW=EL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C2BC00A89
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 07:42:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99BF320936
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 07:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="w+omSUzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99BF320936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9qMwIUbEs07WTPcC0Hi3YmkE20v4sbnj28coynw9fQU=; b=w+omSUzwGH7PspNpsdp7Aor4u
	9diiDjRzbaHRRJLXAQv0Y6bI26JE7gGBRAaIHgL+dvzGals0HOy08SqN/zOPzAn9S8bnLqkVHWzq7
	uvWcmPOc8ogzGuJ2K0I5sQ7Vma1GdL03yn3gouDjn8h5S4pB2FQZxOhlQkE/Q3xdCYCGLB/0yWQ3u
	bOqOhyQMoNfjD8DXlTDtjqTsvo9lw20dwUc8n8b4iekNNFNqo0+tC1EjvCB0qJP66V9zPPI6HgMpA
	X4wHI24BOr8eNqFpEOZLR9ce+f4NznH6BIWhZDo7c+Urc/xUs1A6ZGdwb1K17QphHdbgPpC/K0U5g
	gL0v3v24A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kaZut-0005HC-NG; Thu, 05 Nov 2020 07:42:43 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaZur-0005GV-Bl
 for linux-nvme@lists.infradead.org; Thu, 05 Nov 2020 07:42:42 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3716EAB95;
 Thu,  5 Nov 2020 07:42:40 +0000 (UTC)
Subject: Re: [PATCH V2] nvme: report capacity 0 for non supported ZNS SSDs
To: "hch@lst.de" <hch@lst.de>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com>
 <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local>
 <20201102180836.GC20182@lst.de>
 <20201102183355.GB1970293@dhcp-10-100-145-180.wdc.com>
 <20201102185851.GA21349@lst.de>
 <23e10fd1-d20c-cf77-4dc0-dd8b0774fd7a@suse.de> <20201104142908.GA7941@lst.de>
 <01c72262-1839-05cc-ba9a-94b260511a7c@suse.de> <20201105073737.GA4747@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <6e584b6a-776f-1e3b-5716-152685a6ac5d@suse.de>
Date: Thu, 5 Nov 2020 08:42:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201105073737.GA4747@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201105_024241_553041_C943D063 
X-CRM114-Status: GOOD (  17.76  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "Niklas.Cassel@wdc.com" <Niklas.Cassel@wdc.com>,
 "javier@javigon.com" <javier@javigon.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "Klaus B. Jensen" <k.jensen@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvNS8yMCA4OjM3IEFNLCBoY2hAbHN0LmRlIHdyb3RlOgo+IE9uIFdlZCwgTm92IDA0LCAy
MDIwIGF0IDAzOjQ2OjAyUE0gKzAxMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4gLi4uIGFz
IHdvdWxkIGEgYnNnIGRldmljZSB3aGljaCBjb3VsZCBhY2NlcHQgc2FpZCBpb2N0bCAuLi4KPiAK
PiBTdXJlIHdlIGNvdWxkLiAgU28gd2UnZCBoYXZlIHRvIGFkZCBtb3JlIGNvZGUgdG8gYWxtb3N0
IDEwMDAgbGluZXMgb2YKPiBjb2RlIGluIGJzZyB0aGF0IGFyZSBub3QgdXNlZnVsIHRvIHRoZSBu
dm1lIHVzZSBjYXNlIHRvIG1ha2UgaXQgdXNlZnVsCj4gZm9yIHRoYXQgdXNlIGNhc2UuICBPciB3
ZSBjb3VsZCBqdXN0IGFkZCBhYm91dCA1MCBsaW5lcyBvZiBjb2RlIHRvIE5WTWUKPiB0byBkbyB0
aGUgcmlnaHQgdGhpbmcuCj4gTXkgcG9pbnQgd2Fzbid0IHNvIG11Y2ggdGhhdCBpdCdkIGJlIGVh
c2llciB0byBjb2RlLgpKdXN0IHdhbnRlZCB0byBwb2ludCBvdXQgaG93IHdlJ3ZlIGFyZ3VlZCBp
biB0aGUgcGFzdC4KCkJ1dCBhbnl3YXk6IHlvdSBhcmUgdGhlIG1haW50YWluZXIsIHlvdSBnZXQg
dG8gZGVjaWRlLgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAg
ICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0
aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBO
w7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
