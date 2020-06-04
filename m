Return-Path: <SRS0=P2Tb=7R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A73C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2020 14:03:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D6C1207D0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2020 14:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s88M/0px"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6C1207D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=baKLpNZFlw1fgxUivRKljVlcHKjBocitAHKh80QLghg=; b=s88M/0pxND+D3NPwh4uvpri9L
	Yo9B5NLVMC9lu0RFKSD6B6jy9vZ8IlOum/m5JnFhqSX6rJIGhOkQbezI4SjMPfwrwYJskQLVFbP3M
	CFqXNLU0H8b/d0E+HOpy6YjkCS1D5XoPw/2ye3m6Qg8RxhxE8FdZgIaE3DR13lokT9sFpZ6XF6gOp
	DRxs+E+aGCMESo9Ua1s16OLw8Jv/BpU4sX4D1rSlXZRoggY3Tu6D6SzVtdHzISmXl/zmjhrw0JwqX
	WAhTrpjVSfz3sq+tH8R0Y+UvL5hJsM3Qrxmw0j0bMNISM2uq2bLhL6Xkyb/54y7w8ae5UFPy/ZFeW
	Ofqn7MQ7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jgqT9-0000x5-BQ; Thu, 04 Jun 2020 14:03:43 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jgqT7-0000wP-Ks
 for linux-nvme@lists.infradead.org; Thu, 04 Jun 2020 14:03:43 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CE82BAC6C;
 Thu,  4 Jun 2020 14:03:42 +0000 (UTC)
Subject: Re: [PATCH 1/1] nvme-fcloop: verify wwnn and wwpn format
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Dongli Zhang <dongli.zhang@oracle.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>
References: <20200526042118.17836-1-dongli.zhang@oracle.com>
 <38a2cfb9-df2a-c5cb-6797-2b96ef049c7c@oracle.com>
 <BYAPR04MB49650D649A53B89DBFE1461286890@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <6c646a1e-ab40-63a1-01cb-6cc2548a3853@suse.de>
Date: Thu, 4 Jun 2020 16:03:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49650D649A53B89DBFE1461286890@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200604_070341_829512_1F9DF039 
X-CRM114-Status: GOOD (  16.20  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hch@lst.de" <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNi80LzIwIDg6NTQgQU0sIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToKPiBPbiA2LzMvMjAg
MTE6NDYgUE0sIERvbmdsaSBaaGFuZyB3cm90ZToKPj4gTWF5IEkgZ2V0IGZlZWRiYWNrIGZvciB0
aGlzPwo+Pgo+PiBGb3IgdGhlIGZpcnN0IHRpbWUgSSB1c2UgZmNsb29wLCBJIHNldDoKPj4KPj4g
IyBlY2hvICJ3d25uPTB4Myx3d3BuPTB4MSIgPiAvc3lzL2NsYXNzL2ZjbG9vcC9jdGwvYWRkX3Rh
cmdldF9wb3J0Cj4+Cj4+IEhvd2V2ZXIsIEkgd291bGQgbm90IGJlIGFibGUgdG8gbW92ZSBmb3J3
YXJkIGlmIEkgdXNlICIweDMiIG9yICIweDEiIGZvciBudm1lLWZjCj4+IHRhcmdldCBvciBob3N0
IGZ1cnRoZXIuIEluc3RlYWQsIHRoZSBhZGRyZXNzIGFuZCBwb3J0IHNob3VsZCBiZQo+PiAweDAw
MDAwMDAwMDAwMDAwMDMgYW5kIDB4MDAwMDAwMDAwMDAwMDAwMS4KPj4KPj4gVGhpcyBwYXRjaCB3
b3VsZCBzeW5jIHRoZSByZXF1aXJlbWVudHMgb2YgaW5wdXQgZm9ybWF0IGZvciBudm1lLWZjIGFu
ZAo+PiBudm1lLWZjbG9vcCwgdW5sZXNzIHRoaXMgd291bGQgYnJlYWsgZXhpc3RpbmcgdGVzdCBz
dWl0ZSAoZS5nLiwgYmxrdGVzdCkuCj4gSWYgSSByZW1lbWJlciBjb3JyZWN0bHkgSSBkb24ndCB0
aGluayB3ZSBoYXZlIGZjLWxvb3AgdGVzdGNhc2VzIChjb3JyZWN0Cj4gbWUgaWYgSSdtIHdyb25n
KS4KPiAKV2VsbCwgSSBzZW50IHNvbWUgdGVzdGNhc2VzIGEgd2hpbGUgYmFjayAoY2YgJ2ZjbG9v
cCBhbmQgQU5BIGZpeGVzJykuClNob3VsZCBJIHJlc2VuZCB0aGVtPwoKPiBOb3QgYW4gZmMgZXhw
ZXJ0LCBidXQgaGF2aW5nIHVuaWZvcm0gZm9ybWF0IGZvciB0aGUgaW5wdXQgbWFrZSBzZW5zZSB0
bwo+IG1lICh1bmxlc3MgdGhlcmUgaXMgYW4gZXhwbGljaXQgcmVhc29uKS4gSSdsbCBsZXQgSmFt
ZXMgaGF2ZSBhIGZpbmFsIHNheS4KPiAKCkkgd291bGQgc3RpY2sgdG8gdXNlIHRoZSBmdWxsIDY0
Yml0IG51bWJlciBmb3IgYm90aCB3d3BuIGFuZCB3d25uOyBvbmUgCmdldHMgaW50byB0b28gbWFu
eSBhcmd1bWVudHMgb3RoZXJ3aXNlIChiaWctZW5kaWFuPyBsaXR0bGUtZW5kaWFuPykuCkFuZCBv
bmUgY291bGQgYXJndWUgdGhhdCAnMHgwMDAwMDAwMDAwMDAwMDAxJyBpcyBpbnZhbGlkIGFueXdh
eSBhcyBwZXIgCkZDLUZTMyBhICcwJyBpbiB3b3JkIDAgYnl0ZSAwIG1lYW5zICdOYW1lIG5vdCBw
cmVzZW50JyA6LSkKCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAg
ICAgICAgIFRlYW1sZWFkIFN0b3JhZ2UgJiBOZXR3b3JraW5nCmhhcmVAc3VzZS5kZSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNv
bHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChB
RyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1h
aWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
