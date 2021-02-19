Return-Path: <SRS0=4MGw=HV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79E4C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Feb 2021 16:41:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 889B664DED
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Feb 2021 16:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889B664DED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UsFy6Lubkjzms4HEQrTnYNg5/OBM4q6h8JCjBFSee+A=; b=Qb3+0gtlfZZj+c4HsIymknfaU
	i4uhZ2hammbjWfoxSum4nPmHxNpazgOlgFUZBDerqaozg3NYWgsxcYhXSDzkqe9vwn6u1ddCZCEXc
	XxBlnf4nKyyIYSDH4KGYq9ZAjl5bqYC56pTPnbRkxRmbBH1C40EZ8gJnWzQWL8AigWvS9uGVXzSZB
	oOMDoClGJcgDElQMHHDsAOAuZTH/4OtdTCx854sTCUpJsvDgtt9DRhioxtuyB5B9jGY1xFkLaucrg
	o1SyogsShuJIDVTFzd0mBYzmW7UdyuNuPsuWxu0e5BWW/4UpKmGohgnh5ygiEzwvckW8qnxgKkCZr
	yWcfes16w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lD8q4-0006Bk-CW; Fri, 19 Feb 2021 16:41:08 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lD8q1-0006BH-8S
 for linux-nvme@lists.infradead.org; Fri, 19 Feb 2021 16:41:05 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B1CAFAF3D
 for <linux-nvme@lists.infradead.org>; Fri, 19 Feb 2021 16:41:00 +0000 (UTC)
Subject: Re: vhost/virtio fabric
To: linux-nvme@lists.infradead.org
References: <CA+ULb+v-2jigmQA=Z2WmWP0n3wCbEs_s94oCoNbjJMw14ATCjw@mail.gmail.com>
 <BYAPR04MB4965EC7FB74B38612065CDF5868E9@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a010afb0-c81e-5e05-029a-0c9e49160553@suse.de>
Date: Fri, 19 Feb 2021 17:41:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965EC7FB74B38612065CDF5868E9@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210219_114105_412411_40DCEE01 
X-CRM114-Status: GOOD (  23.67  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi85LzIxIDU6NDEgQU0sIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToKPiBSb21hbiwKPiAK
PiBPbiAyLzgvMjEgMjA6MjksIFJvbWFuIFNoYXBvc2huaWsgd3JvdGU6Cj4+IFRoaXMgc2VhcmNo
IG1hZGUgbWUgY29tZSBhY3Jvc3MgYW4gb2xkIHNldCBvZiBzbGlkZXMgZnJvbQo+PiBDaHJpc3Rv
cGggSGVsbHdpZyB0aGF0IGRpZCwgaW5kZWVkLCBtZW50aW9uIHRoYXQgYXQgc29tZSBwb2ludAo+
PiB2aG9zdC92aXJ0aW8gZmFicmljIHdhcyBjb25zaWRlcmVkLgo+Pgo+PiBQbGVhc2UgbGV0IG1l
IGtub3cgaWYgdGhlcmUncyBhbnkgd29yayB0aGF0IGhhcyBldmVyIGJlZW4gZG9uZQo+PiBpbiB0
aGUgZGlyZWN0aW9uIChldmVuIGlmIGluIGEgZm9ybSBvZiB1bm1lcmdlZCBwYXRjaGVzKSBvciB3
aGV0aGVyCj4+IGlmIEkgbmVlZCB0aGlzIGZ1bmN0aW9uYWxpdHkgSSdkIGhhdmUgdG8gaW1wbGVt
ZW50IGl0IGZyb20gc2NyYXRjaCAocHJvYmFibHkKPj4gYXBpbmcgYSBncmVhdCBkZWFsIG9mIGRy
aXZlcnMvdmhvc3Qvc2NzaS5jKS4KPiAKPiBBdCBzb21lIHBvaW50IG9mIHRpbWUgSSd2ZSBsb29r
ZWQgaW50byB0aGlzIGJlY2F1c2UgdGhhdCB0aGUgbmV4dCBsb2dpY2FsCj4gc3RlcCBpbiB0aGUg
ZWNvc3lzdGVtIGRldmVsb3BtZW50LCBidXQgSSdtIG5vdCBzdXJlIGlmIHRoaXMgd2lsbCBiZQo+
IGFjY2VwdGFibGUgb3Igbm90IG9yIGRvIHdlIG5lZWQgdG8gaGF2ZSBjaGFuZ2UgdGhlIHNwZWMu
IElmIHRoZXJlIGlzIGEgc3Ryb25nCj4gdXNlIGNhc2UgSSdkIGxpa2UgdG8gZGVmaW5pdGVseSB3
b3JrIG9uIG9yIGNvbnRyaWJ1dGUgdG93YXJkcyB0aGUgZGV2ZWxvcG1lbnQKPiBvZiB0aGlzIGZl
YXR1cmUuCj4gCj4gSSdtIGludGVyZXN0ZWQgaW4ga25vd2luZyB3aGF0IGV2ZXJ5b25lIHRoaW5r
IGFib3V0IHRoaXMgb25lIC4uLgo+IApXZWxsLCBJIGhhZCBiZWVuIGxvb2tpbmcgaW50byBpdCBm
b3Igc29tZSB0aW1lLCB0b28uCkJ1dCB0dXJucyBvdXQgdG8gYmUgcXVpdGUgY2hhbGxlbmdpbmcg
Y29uY2VwdHVhbC4KCk1vZGlmeWluZyAvIGxldmVyYWdpbmcgdmlydGlvIGZvciBOVk1lIHRyYW5z
cG9ydCBzaG91bGQgYmUgdHJpdmlhbGx5LCAKYnV0IHRoZW4geW91J2QgbmVlZCB0byBwdXQgdGhl
IHZpcnRpbyBkZXZpY2Ugb24gc29tZSBlbXVsYXRlZCBoYXJkd2FyZSwgCndoaWNoIHR5cGljYWxs
eSAob24gaXg4NikgaXMgYSBQQ0kgZGV2aWNlLgpTbyBpdCB3b3VsZCBiZSBhIFBDSSBkZXZpY2Ug
d2l0aCB2aXJ0aW8gcXVldWVzIHdoaWNoIHRyYW5zcG9ydCBOVk1lIApDUUVzL1NRRXMsIGJlZ2dp
bmcgdGhlIHF1ZXN0aW9uIHdoeSB3ZSBuZWVkIHRvIGhhdmUgaXQgYXMgd2UgX2NvdWxkXyB1c2Ug
CmFuIGVtdWxhdGVkIE5WTWUgUENJIGRldmljZSB0byBzdGFydCB3aXRoLgoKQnV0IHRoZW4gX3Ro
YXRfIHdvdWxkIG5lZWQgdG8gc3VwcG9ydCBQUlBzLCBhbmQgeW91IGNhbid0IHNlbmQgZGlzY292
ZXJ5IAphbmQvb3IgY29ubmVjdCBjb21tYW5kcyBhY3Jvc3MgdGhhdC4KClNvIHRoZXJlIG1pZ2h0
IGJlIGEgdmFsdWUgaW4gaGF2aW5nIGEgdmlydGlvIHRyYW5zcG9ydCwganVzdCBzbyB0aGF0IHlv
dSAKY2FuIHVzZSB0aGUgZmFicmljcyBjb21tYW5kcy4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIu
IEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QK
aGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2
ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8
cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4
IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZt
ZQo=
