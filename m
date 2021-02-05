Return-Path: <SRS0=OXBW=HH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AA5C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 16:35:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03AC264E93
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 16:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03AC264E93
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=U4+cpn3XSs1knEOSRvGY2YdeVNdAzuhFOJkboaoMWOY=; b=JwF6CzFrfEDdMf6/Lt7AbX2Fu
	a7eUrMAhPBgYOTEJfrXiydHE16SOqUSo99yTrEcb8mVBQoXDhHiBqI8XKUGrEaLGv/NvlGBBrfWHB
	iVdqUlY2XaGjSm5+FpBb3FkpE6OI/7tBDMxBrH88NyCjn4XIMBnLVBYqgsMV9aVs/ZrQTp26uMFjk
	oKa2CmFpulXcX3hogsiKl0H5j/bE6MkScGLAG8pwXC3tekNlA/S75ct25ZUzMCuMkkiWkQeNQwUcY
	/L9QXVx8J2WtSTQzHy37tzEHEemranuIlYup0ztDO3SG8W8E6SrnaEA6eZPcyCMPIaoIvWae/SBtm
	rzNQvkugQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l844e-0006D1-Mn; Fri, 05 Feb 2021 16:35:12 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l844c-0006Ch-5O
 for linux-nvme@lists.infradead.org; Fri, 05 Feb 2021 16:35:11 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E40B7AD57;
 Fri,  5 Feb 2021 16:35:08 +0000 (UTC)
Subject: Re: [PATCH] nvme: move NVMF_OPT_CTRL_LOSS_TMO to generic list of
 allowed options
To: Christoph Hellwig <hch@lst.de>
References: <20210205154714.127995-1-hare@suse.de>
 <20210205162506.GA27415@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <14420650-7548-3897-3baf-a8c303165842@suse.de>
Date: Fri, 5 Feb 2021 17:35:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210205162506.GA27415@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210205_113510_318296_0777CE59 
X-CRM114-Status: GOOD (  19.92  )
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
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi81LzIxIDU6MjUgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IE9uIEZyaSwgRmVi
IDA1LCAyMDIxIGF0IDA0OjQ3OjE0UE0gKzAxMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4g
RXZlcnkgc2luZ2xlIGZhYnJpY3MgZHJpdmVyIHdpdGggdGhlIGV4Y2VwdGlvbiBvZiBsb29wIGlz
IHNldHRpbmcKPj4gTlZNRl9PUFRfQ1RSTF9MT1NTX1RNTywgYW5kIHJlY2VudCBudm1lLWNsaSBo
YXMgYmVndW4gdG8gc2V0IHRoaXMKPj4gaW4gdGhlIGRlZmF1bHQgb3B0aW9ucyB3aGVuIGNyZWF0
ZSBhIGRpc2NvdmVyeSBjb250cm9sbGVyLgo+PiBBcyBpdCdzIG5vdCBsaXN0ZWQgZm9yIGxvb3Ag
Y29ubmVjdGlvbnMgdG8gdGhlIGxvb3AgY29udHJvbGxlciB3aWxsCj4+IGZhaWwuCj4+IFNvIG1v
dmUgaXQgdG8gdGhlIGdlbmVyaWMgb3B0aW9ucyB0byBhdm9pZCB0aGlzIGZhaWx1cmUuCj4gCj4g
V2VsbCwgdGhlIG9wdGlvbiBkb2Vzbid0IHJlYWxseSBtYWtlIHNlbnNlIGZvciBsb29wLiAgSSB0
aGluayBudm1lLWNsaQo+IG5lZWRzIHRvIGJlIGZpeGVkIHRvIG5vdCBzZXQgaW4gdGhpcyBjYXNl
Lgo+IApOZWl0aGVyIGRvZXMgTlZNRl9PUFRfRkFJTF9GQVNUX1RNTywgeWV0IHRoZXJlIGl0IGlz
IC4uLgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAg
ICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBH
bWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJl
cmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlz
dApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
