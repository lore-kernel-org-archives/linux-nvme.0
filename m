Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAF3C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 11:03:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A03306138C
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 11:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03306138C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=W7q8k3B9Wqblp+K2mTHKIcurrIkbe+4HmYvfD3UiNmw=; b=DsfNFv8qACSpk5CTu6AK+lsSn
	N4PYHtLGIJpKHNOVM0+CHOvBjubTWIMGGbqo1XPAMt3LiB33AT+e3W5JTCWueA2he1iloyldlMmDq
	3YgAnLTTOHejAQtjaL8+Cp96kc10MtI6ABdVukbJfEsq20dd3uflEcLzFBHF2InMEy1R5BJ/WPTVv
	NHFtt+3eN4SOVzEzLs6w8dPN5nA+l5frkxjBXzGC3Z+YPnecdaLdvhKbWgMrz8VSRwMv8GSyXaXqk
	pbK0CzMAuSnjSToFmgiASR/PmJlp1+3neu2qz1RIo+XXUeGZHocIRTsgfa5e+5ydVCNs9CAGqswAn
	YFdLDhYiw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgQAs-00H3vq-IV; Tue, 11 May 2021 11:03:38 +0000
Received: from [2607:7c80:54:e::133] (helo=bombadil.infradead.org)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgGFx-00FyIe-El
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 00:28:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=HF6Ee0O4tVtFeuPGKAGZ+6NgFoc8DmbhSPGcfK7sK3Y=; b=y1Hi8WXQz+08SndSj+ERlTVcRW
 5ZtNTu8PCGYrtefiL3xhz88VWVVrG7vjUVRKzJ+9MnlRw6mj51BUMxpZPnYin9AgntYHKByDn2HmC
 MDxBJTAyDy6XAkdIfqxNPq3fITcNFyW6PTQ2xLIv+Uqhad+E1KT3QxAPVfVtdPAGwnotQ9Gvy9Lxn
 0RyK5/geJu/VQfeQtG1mzrWA+4grgSL0Fy4CPZ+nbADbn/hy0ApqxHTU+RSi0tRDtsrMEDiWUvzXT
 hq8nBtZaG4Yjm39aNha/oP3o2FW+gKbS9oIOiRRk91OsRDlqT+u6hFXoLkPSQsPzJJeXWBanVWOEZ
 9/MD5d0g==;
Received: from mail-pf1-f175.google.com ([209.85.210.175])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgGFu-009DNv-6x
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 00:28:11 +0000
Received: by mail-pf1-f175.google.com with SMTP id 10so14944509pfl.1
 for <linux-nvme@lists.infradead.org>; Mon, 10 May 2021 17:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HF6Ee0O4tVtFeuPGKAGZ+6NgFoc8DmbhSPGcfK7sK3Y=;
 b=ZbK5areNygVy0iuV78WUKXdWx3eW1JxehaIovxoO9BQU3WLNNFuf2cXXTkSp8Rfx+4
 WoiY7ieIw5bF9L6bekgevbf+fZocNAg0KD77ZU7SYIFHwz36Z/b9lvFQehNrPbsvPVFJ
 qqLmM/c1WFqOUs9b3qvSG78q2bNuO4TOsQdhqrKfLiIt7b7lRmx8bVoJVtbC9FrnMyR8
 9EtK/Wuy+gQDx/0l/wBxjwti+YCdk3ZsjEzSvx4TmF+QkZsmwYPgQ3lIcAbtQ3Ma5f51
 1yXn1uBzZx9li6l2pCyluIjEbVLjY+fzib9Tq8FeFIifCPwAV/1ye3fwrPGT2G2xMipS
 3t0Q==
X-Gm-Message-State: AOAM5302b+bGHelstiqPD1xm3cD2OGkg5alKqYOohh7AIG7XapnXQY4g
 OM0boApiZSa+tL9REQ5pY5U=
X-Google-Smtp-Source: ABdhPJyAkQSw+TeWrbR5PA8B7rFMSRaYd5zHrjGuKQRnHTapDxPx4AMQ2tjRWv1soHKC3qZxd9CJcg==
X-Received: by 2002:a63:4b43:: with SMTP id k3mr27367524pgl.450.1620692887520; 
 Mon, 10 May 2021 17:28:07 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:1522:1d2e:7c9d:185c?
 ([2601:647:4802:9070:1522:1d2e:7c9d:185c])
 by smtp.gmail.com with ESMTPSA id h36sm12687603pgh.63.2021.05.10.17.28.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 May 2021 17:28:06 -0700 (PDT)
Subject: Re: [PATCH 1/1] Add 'Transport Interface' (triface) option. This can
 be used to specify the IP interface to use for the connection. The
 driver
 uses that to set SO_BINDTODEVICE on the socket before connecting.
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 Hannes Reinecke <hare@suse.de>, Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
References: <20210415192848.962891-1-nitram_67@hotmail.com>
 <BL0PR13MB42917AC33BFFC7DB2440D1149C4D9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <b47456a5-69ae-1f33-30f0-aa25906668f2@grimberg.me>
 <27a0071d-7c7b-ee5b-41a2-d5eb8de12928@suse.de>
 <SJ0PR19MB45446577ACEA270069ADB738F2599@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <dbb70739-e636-7f4c-7332-1fbc07332444@suse.de>
 <07fa3404-ed37-052a-c2d7-0e21c119f5c5@suse.de>
 <SJ0PR19MB4544F01520BE86D205B41B23F2589@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <b511b6a0-392f-9845-8097-1f2173085ce0@grimberg.me>
 <SJ0PR19MB4544420019D202816F4392DFF2549@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <7b0d0915-961a-0af2-7ea3-77f59cd98ef1@grimberg.me>
 <SJ0PR19MB45449EA9215D3EB116E1325CF2549@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <60aa6be0-ca88-bab8-c893-4c2b1d3f8baf@grimberg.me>
Date: Mon, 10 May 2021 17:28:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <SJ0PR19MB45449EA9215D3EB116E1325CF2549@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_172810_280758_92E91FB9 
X-CRM114-Status: GOOD (  27.07  )
/bin/ln: failed to access
 'reaver_cache/texts/20210510_172810_280758_92E91FB9': No such file or
 directory
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_172810_280758_92E91FB9 
X-CRM114-Status: GOOD (  22.58  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+Pj4gV2UgYWxyZWFkeSBzdXBwb3J0IHRoaXMgZm9yIElQdjYsIHdlIGNhbiBkbyB0aGF0IGFs
c28gZm9yIElQdjQsIGJ1dAo+Pj4+IHRoaXMgc3ludGF4IG1heSBub3QgYmUgdHJpdmlhbGx5IGV4
cGVjdGVkIGZvciBpcHY0Pwo+Pj4KPj4+IEkgdHJpZWQgdGhpcyBmb3IgSVB2NiBhbmQgaXQgZG9l
c24ndCB3b3JrLiBIZXJlJ3Mgd2hhdCBJIGdldDoKPj4+ICQgc3VkbyBudm1lIGRpc2NvdmVyIC1n
IC1HIC10IHRjcCAtcyA4MDA5IC1hIGZlODA6OjgwMDoyN2ZmOmZlMDA6MAo+Pj4gRmFpbGVkIHRv
IHdyaXRlIHRvIC9kZXYvbnZtZS1mYWJyaWNzOiBJbnZhbGlkIGFyZ3VtZW50ICQgc3VkbyBudm1l
Cj4+PiBkaXNjb3ZlciAtZyAtRyAtdCB0Y3AgLXMgODAwOSAtYSBmZTgwOjo4MDA6MjdmZjpmZTAw
OjAlZW5wMHM4IEZhaWxlZAo+Pj4gdG8gd3JpdGUgdG8gL2Rldi9udm1lLWZhYnJpY3M6IEludmFs
aWQgYXJndW1lbnQgJCBzdWRvIG52bWUgZGlzY292ZXIKPj4+IC1nIC1HIC10IHRjcCAtcyA4MDA5
IC1hIFtmZTgwOjo4MDA6MjdmZjpmZTAwOjBdIGZhaWxlZCB0byByZXNvbHZlIGhvc3QKPj4+IFtm
ZTgwOjo4MDA6MjdmZjpmZTAwOjBdIGluZm8gJCBzdWRvIG52bWUgZGlzY292ZXIgLWcgLUcgLXQg
dGNwIC1zIDgwMDkKPj4+IC1hIFtmZTgwOjo4MDA6MjdmZjpmZTAwOjAlZW5wMHM4XSBmYWlsZWQg
dG8gcmVzb2x2ZSBob3N0Cj4+PiBbZmU4MDo6ODAwOjI3ZmY6ZmUwMDowJWVucDBzOF0gaW5mbwo+
Pgo+PiAjIG52bWUgZGlzY292ZXIgLXQgdGNwIC1hIGZlODA6OjUwNTQ6ZmY6ZmVmMTo5ZjNiIC13
Cj4+IGZlODA6OjUwNTQ6ZmY6ZmUyODo1ZWRiJWVucDZzMAo+IAo+IFRoYW5rcyBmb3IgY2xhcmlm
eWluZyB0aGUgc3ludGF4LiBIb3dldmVyLCB0aGF0IGRvZXNuJ3Qgd29yayBmb3IgbWUuCj4gCj4g
IyBudm1lIGRpc2NvdmVyIC10IHRjcCAtYSBmZTgwOjo4MDA6MjdmZjpmZTAwOjAgLXcgZmU4MDo6
OTI2Njo0ODU1OjZjZjI6ZjdlOSVlbnAwczgKPiBGYWlsZWQgdG8gd3JpdGUgdG8gL2Rldi9udm1l
LWZhYnJpY3M6IENvbm5lY3Rpb24gcmVmdXNlZAoKQXJlIHlvdSB1c2luZyB0aGUgbGludXggdGFy
Z2V0PyBjb25uZWN0aW9uIHJlZnVzZWQgbWVhbnMgdGhhdAp5b3UgZG9uJ3QgaGF2ZSBhIGxpc3Rl
bmVyIG9uIGl0LCBpdCdzIG5vdCBhIHJlc29sdXRpb24gZXJyb3IuCgpkaWQgeW91IGhhdmUgdGhl
IHRhcmdldCBsaXN0ZW4gb24gZmU4MDo6ODAwOjI3ZmY6ZmUwMDowJTxpbnRmPiA/Cgo+IAo+IE5v
dGUgdGhhdCB0aGUgYWJvdmUgc3ludGF4IGRvZXMgbm90IGNvbXBseSB3aXRoIFJGQzQwMDcuIFRo
ZSAnJScgZGVsaW1pdGVyIGlzIHN1cHBvc2VkIHRvIGJlIGFwcGVuZGVkIHRvIHRoZSBEZXN0aW5h
dGlvbiBJUCBhZGRyZXNzIGFuZCBub3QgdGhlIFNvdXJjZSBBZGRyZXNzLiBJbiBvdGhlciB3b3Jk
cywgdG8gYmUgUkZDNDAwNy1jb21wbGlhbnQsIHRoZSBzeW50YXggc2hvdWxkIGJlICh1c2luZyB5
b3VyIGV4YW1wbGUpOgo+IAo+ICMgbnZtZSBkaXNjb3ZlciAtdCB0Y3AgLWEgZmU4MDo6NTA1NDpm
ZjpmZWYxOjlmM2IlZW5wNnMwIC13IGZlODA6OjUwNTQ6ZmY6ZmUyODo1ZWRiCj4gCj4gVGhpcyB0
ZWxscyBudm1lLWNsaSB0byBjb25uZWN0IHRvIGEgY29udHJvbGxlciBhdCBhZGRyZXNzIGZlODA6
OjUwNTQ6ZmY6ZmVmMTo5ZjNiIHVzaW5nIGludGVyZmFjZSBlbnA2czAgZm9yIHRoZSBjb25uZWN0
aW9uLiBBbmQgc2V0IHRoZSBTb3VyY2UgYWRkcmVzcyB0byBmZTgwOjo1MDU0OmZmOmZlMjg6NWVk
Yi4KClRoaXMgYWxzbyBzZWVtcyB0byB3b3JrLCBub3Qgc3VyZSB0aGF0IGl0IGRvZXMgd2hhdCB3
ZSB3YW50IHRob3VnaC4uLgpudm1lIGRpc2NvdmVyIC10IHRjcCAtYSBmZTgwOjo1MDU0OmZmOmZl
ZjE6OWYzYiVlbnA2czAgLXcgCmZlODA6OjUwNTQ6ZmY6ZmUyODo1ZWRiJWVucDZzMAoKRGlzY292
ZXJ5IExvZyBOdW1iZXIgb2YgUmVjb3JkcyAxLCBHZW5lcmF0aW9uIGNvdW50ZXIgNQo9PT09PURp
c2NvdmVyeSBMb2cgRW50cnkgMD09PT09PQp0cnR5cGU6ICB0Y3AKYWRyZmFtOiAgaXB2NgpzdWJ0
eXBlOiBudm1lIHN1YnN5c3RlbQp0cmVxOiAgICBub3Qgc3BlY2lmaWVkLCBzcSBmbG93IGNvbnRy
b2wgZGlzYWJsZSBzdXBwb3J0ZWQKcG9ydGlkOiAgMwp0cnN2Y2lkOiA4MDA5CnN1Ym5xbjogIHRl
c3RucW4xCnRyYWRkcjogIGZlODA6OjUwNTQ6ZmY6ZmVmMTo5ZjNiJWVucDZzMApzZWN0eXBlOiBu
b25lCgoKPj4gVGhlICclJyBtYXkgYmUgY29uZnVzaW5nIHdoZW4gaXQgY29tZXMgdG8gb3RoZXIg
dHJhbnNwb3J0cyBhcyB3ZWxsIChlLmcuCj4+IHJkbWEvZmMgd291bGQgaGF2ZSB0byBlaXRoZXIg
cmVqZWN0IG9yIGlnbm9yZSBpdCwgYnV0IHJlZ2FyZGxlc3Mgb2YgaG93IHdlCj4+IGFkZCBpdCB0
aGF0IHdvdWxkIGJlIHRoZSBjYXNlKS4gSGF2aW5nIGhvc3QtdHJhZGRyIGFjY2VwdCBlaXRoZXIg
aXAgb3IKPj4gaW50ZXJmYWNlIHNlZW1zIHRoZSBtb3N0IGRlc2lyYWJsZSwgaG93ZXZlciB0aGF0
IHdvbid0IHdvcmsgaWYgdGhlcmUgYXJlIDIKPj4gaW50ZXJmYWNlcyB0aGF0IHNoYXJlIG11bHRp
cGxlIGlwIGFkZHJlc3Nlcy4gU28gaWYgdGhpcyBpcyBhIHJlcXVpcmVtZW50IHdlJ2xsCj4+IHBy
b2JhYmx5IG5lZWQgdG8gYWRkIC0taG9zdC1pZmFjZSBhcyBhbm90aGVyIG9wdGlvbi4uLgo+IAo+
IEkgZG9u4oCZdCBncm9rIHdoYXQgeW91IG1lYW4gYnkgInRoYXQgd29uJ3Qgd29yayBpZiB0aGVy
ZSBhcmUgMiBpbnRlcmZhY2VzIHRoYXQgc2hhcmUgbXVsdGlwbGUgaXAgYWRkcmVzc2VzIi4gV2h5
IG5vdD8gSWYgb25lIHNwZWNpZmllcyB0aGUgaW50ZXJmYWNlIGJ5IGl0cyBuYW1lIChlLmcuIGVu
cDBzOCksIHRoZXJlIGlzIG5vIHBvc3NpYmxlIGNvbmZ1c2lvbiBldmVuIGlmIG11bHRpcGxlIGlu
dGVyZmFjZXMgc2hhcmUgdGhlIHNhbWUgSVAgYWRkcmVzc2VzLgo+IAo+IFRoZSBmb2xsb3dpbmcg
YXJlIHNvbWUgZXhhbXBsZXMgb2YgaG93IG52bWUtY2xpIHNob3VsZCB3b3JrIHRvIGNvbXBseSB3
aXRoIFJGQzQwMDcgYW5kIGJlIGNvbnNpc3RlbnQgdG8gdGhlIHdheSBwaW5nIG9wZXJhdGVzLgo+
IEV4YW1wbGUgMSAtIElQdjQsIFNwZWNpZnkgSW50ZXJmYWNlIHdpdGggLXcgYW5kIGxldCBMaW51
eCBzZWxlY3QgU291cmNlIGFkZHJlc3M6Cj4gbnZtZSBkaXNjb3ZlciAtdCB0Y3AgLWEgMTkyLjE2
OC4xLjkgLXcgZW5wMHM4Cj4gCj4gRXhhbXBsZSAyIC0gSVB2NCwgU3BlY2lmeSBJbnRlcmZhY2Ug
YW5kIFNvdXJjZSBhZGRyZXNzIHdpdGggcmVwZWF0ZWQgLXc6Cj4gbnZtZSBkaXNjb3ZlciAtdCB0
Y3AgLWEgMTkyLjE2OC4xLjkgLXcgZW5wMHM4IC13IDE5Mi4xNjguNTYuMTAzCgpJIG1lYW50IHdp
dGhvdXQgdGhlIHJlcGV0aXRpb25zLCB3aGljaCB5b3Ugb25seSBuZWVkIGlmIHlvdSBoYXZlIDIK
ZGV2aWNlcyB0aGF0IHNoYXJlIG1vcmUgdGhhbiBvbmUgYWRkcmVzcywgd2hpY2ggYWdhaW4sIGlz
IG5vdCBhIGNsZWFyCnVzZS1jYXNlIHRvIG1lLCBidXQgd2l0aG91dCByZXBldGl0aW9ucyB3ZSB3
b24ndCBzdXBwb3J0IHRoYXQuCgo+IEV4YW1wbGUgMyAtIElQdjYsIFNwZWNpZnkgSW50ZXJmYWNl
IHdpdGgnJScgZGVsaW1pdGVyIGFuZCBsZXQgTGludXggc2VsZWN0IFNvdXJjZSBhZGRyZXNzOgo+
IG52bWUgZGlzY292ZXIgLXQgdGNwIC1hIGZlODA6OjgwMDoyN2ZmOmZlMDA6MCVlbnAwczgKPiAK
PiBFeGFtcGxlIDQgLSBJUHY2LCBTcGVjaWZ5IEludGVyZmFjZSB3aXRoIC13IGFuZCBsZXQgTGlu
dXggc2VsZWN0IFNvdXJjZSBhZGRyZXNzOgo+IG52bWUgZGlzY292ZXIgLXQgdGNwIC1hIGZlODA6
OjgwMDoyN2ZmOmZlMDA6MCAtdyBlbnAwczgKPiAKPiBFeGFtcGxlIDUgLSBJUHY2LCBTcGVjaWZ5
IEludGVyZmFjZSB3aXRoJyUnIGRlbGltaXRlciBhbmQgU291cmNlIGFkZHJlc3Mgd2l0aCAtdzoK
PiBudm1lIGRpc2NvdmVyIC10IHRjcCAtYSBmZTgwOjo4MDA6MjdmZjpmZTAwOjAlZW5wMHM4IC13
IGZlODA6OjkyNjY6NDg1NTo2Y2YyOmY3ZTkKPiAKPiBFeGFtcGxlIDYgLSBJUHY2LCBTcGVjaWZ5
IEludGVyZmFjZSBhbmQgU291cmNlIGFkZHJlc3Mgd2l0aCByZXBlYXRlZCAtdzoKPiBudm1lIGRp
c2NvdmVyIC10IHRjcCAtYSBmZTgwOjo4MDA6MjdmZjpmZTAwOjAgLXcgZW5wMHM4IC13IGZlODA6
OjkyNjY6NDg1NTo2Y2YyOmY3ZTkKPiAKPiBNYXJ0aW4KPiAKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
