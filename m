Return-Path: <SRS0=Xmhu=GN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9C4C433E0
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Jan 2021 15:01:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DEC5229EF
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Jan 2021 15:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEC5229EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0RVOcqIMIHLpVKfr2EXNmVR8P+KQTJUyPxRKrymxH/k=; b=QRWEVS1FWsPFV8CKB8CaZQaPt
	zt6GM+H5Ys7lItAMXWsXw3Q6brA2/COt5QZv9dgQzzZSco/IF/uSDJorhqfTujyWwZikXkl3dmBTW
	ZAs0cpTPizqmuCPObwGlL6qZpf72DSJuuOwtACI7tgNChNJjZwCS7OcCa3E1xmrBWAGu9Dqifr2h8
	qTgHp0fcPkrVaZe4eJeyMopcYZXZBeOhshYM10mlhtR0VqFqxOZZOUOsRu7GgMJlKqor5z0fm65vs
	Q64aRuSjCSBCb+BtaIE7Ief5zP0hg+WzjlC/hBpXzuKM2YGH+sL66EtYHgikLNnQPParls6lv0aHt
	9nIk46Y4g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kycD6-0000XY-Ob; Sun, 10 Jan 2021 15:00:52 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kycD4-0000WY-G5
 for linux-nvme@lists.infradead.org; Sun, 10 Jan 2021 15:00:51 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 54306AAF1;
 Sun, 10 Jan 2021 15:00:49 +0000 (UTC)
Subject: Re: [PATCH 4/6] block: propagate BLKROSET on the whole device to all
 partitions
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20210109104254.1077093-1-hch@lst.de>
 <20210109104254.1077093-5-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <81a37585-bf6e-9ab5-993e-e9a0881ce996@suse.de>
Date: Sun, 10 Jan 2021 16:00:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210109104254.1077093-5-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210110_100050_685414_76546226 
X-CRM114-Status: GOOD (  27.30  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@redhat.com>,
 Oleksii Kurochko <olkuroch@cisco.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS85LzIxIDExOjQyIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBDaGFuZ2UgdGhl
IHBvbGljeSBzbyB0aGF0IGEgQkxLUk9TRVQgb24gdGhlIHdob2xlIGRldmljZSBhbHNvIGFmZmVj
dHMKPiBwYXJ0aXRpb25zLiAgVG8gcXVvdGUgTWFydGluIEsuIFBldGVyc2VuOgo+IAo+IEl0J3Mg
dmVyeSBjb21tb24gZm9yIGRhdGFiYXNlIGZvbGtzIHRvIHR3aWRkbGUgdGhlIHJlYWQtb25seSBz
dGF0ZSBvZgo+IGJsb2NrIGRldmljZXMgYW5kIHBhcnRpdGlvbnMuIEkga25vdyB0aGF0IG91ciB1
c2VycyB3aWxsIGZpbmQgaXQgdmVyeQo+IGNvdW50ZXItaW50dWl0aXZlIHRoYXQgc2V0dGluZyAv
ZGV2L3NkYSByZWFkLW9ubHkgd29uJ3QgcHJldmVudCB3cml0ZXMKPiB0byAvZGV2L3NkYTEuCj4g
Cj4gVGhlIGV4aXN0aW5nIGJlaGF2aW9yIGlzIGluY29uc2lzdGVudCBpbiB0aGUgc2Vuc2UgdGhh
dCBkb2luZzoKPiAKPiAgICAjIGJsb2NrZGV2IC0tc2V0cm8gL2Rldi9zZGEKPiAgICAjIGVjaG8g
Zm9vID4gL2Rldi9zZGExCj4gCj4gcGVybWl0cyB3cml0ZXMuIEJ1dDoKPiAKPiAgICAjIGJsb2Nr
ZGV2IC0tc2V0cm8gL2Rldi9zZGEKPiAgICA8c29tZXRoaW5nIHRyaWdnZXJzIHJldmFsaWRhdGU+
Cj4gICAgIyBlY2hvIGZvbyA+IC9kZXYvc2RhMQo+IAo+IGRvZXNuJ3QuCj4gCj4gQW5kIGEgc3Vi
c2VxdWVudDoKPiAKPiAgICAjIGJsb2NrZGV2IC0tc2V0cncgL2Rldi9zZGEKPiAgICAjIGVjaG8g
Zm9vID4gL2Rldi9zZGExCj4gCj4gZG9lc24ndCB3b3JrIGVpdGhlciBzaW5jZSBzZGExJ3MgcmVh
ZC1vbmx5IHBvbGljeSBoYXMgYmVlbiBpbmhlcml0ZWQKPiBmcm9tIHRoZSB3aG9sZS1kaXNrIGRl
dmljZS4KPiAKPiBZb3UgbmVlZCB0byBkbzoKPiAKPiAgICAjIGJsb2NrZGV2IC0tcmVyZWFkcHQK
PiAKPiBhZnRlciBzZXR0aW5nIHRoZSB3aG9sZS1kaXNrIGRldmljZSBydyB0byBlZmZlY3R1YXRl
IHRoZSBzYW1lIGNoYW5nZSBvbgo+IHRoZSBwYXJ0aXRpb25zLCBvdGhlcndpc2UgdGhleSBhcmUg
c3R1Y2sgYmVpbmcgcmVhZC1vbmx5IGluZGVmaW5pdGVseS4KPiAKPiBIb3dldmVyLCBzZXR0aW5n
IHRoZSByZWFkLW9ubHkgcG9saWN5IG9uIGEgcGFydGl0aW9uIGRvZXMgKm5vdCogcmVxdWlyZQo+
IHRoZSByZXZhbGlkYXRlIHN0ZXAuIEFzIGEgbWF0dGVyIG9mIGZhY3QsIGRvaW5nIHRoZSByZXZh
bGlkYXRlIHdpbGwgYmxvdwo+IGF3YXkgdGhlIHBvbGljeSBzZXR0aW5nIHlvdSBqdXN0IG1hZGUu
Cj4gCj4gU28gdGhlIHVzZXIgbmVlZHMgdG8gdGFrZSBkaWZmZXJlbnQgYWN0aW9ucyBkZXBlbmRp
bmcgb24gd2hldGhlciB0aGV5Cj4gYXJlIHRyeWluZyB0byByZWFkLXByb3RlY3QgYSB3aG9sZS1k
aXNrIGRldmljZSBvciBhIHBhcnRpdGlvbi4gRGVzcGl0ZQo+IHVzaW5nIHRoZSBzYW1lIGlvY3Rs
LiBUaGF0IGlzIHJlYWxseSBjb25mdXNpbmcuCj4gCj4gSSBoYXZlIGxvc3QgY291bnQgaG93IG1h
bnkgdGltZXMgb3VyIGN1c3RvbWVycyBoYXZlIGhhZCBkYXRhIGNsb2JiZXJlZAo+IGJlY2F1c2Ug
b2YgYW1iaWd1aXR5IG9mIHRoZSBleGlzdGluZyB3aG9sZS1kaXNrIGRldmljZSBwb2xpY3kuIFRo
ZQo+IGN1cnJlbnQgYmVoYXZpb3IgdmlvbGF0ZXMgdGhlIHByaW5jaXBsZSBvZiBsZWFzdCBzdXJw
cmlzZSBieSBsZXR0aW5nIHRoZQo+IHVzZXIgdGhpbmsgdGhleSB3cml0ZSBwcm90ZWN0ZWQgdGhl
IHdob2xlIGRpc2sgd2hlbiB0aGV5IGFjdHVhbGx5Cj4gZGlkbid0Lgo+IAo+IFN1Z2dlc3RlZC1i
eTogTWFydGluIEsuIFBldGVyc2VuIDxtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbT4KPiBTaWdu
ZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KPiBSZXZpZXdlZC1ieTog
TWFydGluIEsuIFBldGVyc2VuIDxtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbT4KPiAtLS0KPiAg
IGJsb2NrL2dlbmhkLmMgfCAzICstLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAyIGRlbGV0aW9ucygtKQo+IApSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1
c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAg
ICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25z
IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJu
YmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBs
aXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
