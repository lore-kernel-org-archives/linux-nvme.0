Return-Path: <SRS0=9ZED=LE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4664C48BDF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 15:05:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C68261359
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 15:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C68261359
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:Subject:From:References:To:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=TT2/GmiWHBVqLZH/K4Cwb+y/mDAkNy+f5pXwBphHkUY=; b=ah8kQqwii2akphy5oUmHfMUePF
	Pdi59y8sC+QGH0m8oJ8deQWenA4B7UlIABBSISmW/3/MJuc1+lZEzF3HkHC2vhjK23RvxBPCbPmpy
	FtLkyi66ISp4Btjg1N+FJB5Us+qs+Lju+ATsr+EyL+xTglIvWRvZP1sDNpQf2TYShGcn7lcp8P8TC
	DGa1OnpM7aTOb2WweJstjXO/X7WhTyeGqfCbKMdGUlGcyDb4b+CigLsVaWMKzihZuqXvWwxSPtBAy
	t5LuPAWN3Bi3QRn5FNEMcYA242sDMcF+yt5rmj3mivgNDuHcn0Gd21AlMyARAxi+cUSfLWB+aoXjb
	TCNQ2U/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lrMFB-001I36-6a; Thu, 10 Jun 2021 15:05:17 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lrMF6-001Hyi-3e
 for linux-nvme@lists.infradead.org; Thu, 10 Jun 2021 15:05:14 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4B1BD1FD3F;
 Thu, 10 Jun 2021 15:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623337508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1u6AVXRqlu9Q/BYkByDk+dwsGv2BpsoWcFSiM1eZAU=;
 b=gD3MnDSL952svG7i4msvjAWWr72iYzVvTciBz5lHhAJPAj/IkV253S8NBTUeDnX0bSgZcZ
 /6pSkekO40Un1XOq6M5vBWRUHMIJmn3VZoR9E2OvEGjRzFUZ2gzdz/FhmzzZZy1NGtt7gu
 fwC9agBXevDdxq2fCgf9Ufi+k+211SY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623337508;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1u6AVXRqlu9Q/BYkByDk+dwsGv2BpsoWcFSiM1eZAU=;
 b=yHuuP+5+YnKwICFKNivdTbWdBcxp+klbxFAt22JPjW7UQuTlnqi0HRMeYiAdOpKqJ7LG74
 V3HPidN50qtYVZCw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 26674118DD;
 Thu, 10 Jun 2021 15:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623337508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1u6AVXRqlu9Q/BYkByDk+dwsGv2BpsoWcFSiM1eZAU=;
 b=gD3MnDSL952svG7i4msvjAWWr72iYzVvTciBz5lHhAJPAj/IkV253S8NBTUeDnX0bSgZcZ
 /6pSkekO40Un1XOq6M5vBWRUHMIJmn3VZoR9E2OvEGjRzFUZ2gzdz/FhmzzZZy1NGtt7gu
 fwC9agBXevDdxq2fCgf9Ufi+k+211SY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623337508;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1u6AVXRqlu9Q/BYkByDk+dwsGv2BpsoWcFSiM1eZAU=;
 b=yHuuP+5+YnKwICFKNivdTbWdBcxp+klbxFAt22JPjW7UQuTlnqi0HRMeYiAdOpKqJ7LG74
 V3HPidN50qtYVZCw==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id EZ2bCCQqwmCjfQAALh3uQQ
 (envelope-from <hare@suse.de>); Thu, 10 Jun 2021 15:05:08 +0000
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
References: <a189ec50-4c11-9ee9-0b9e-b492507adc1e@suse.de>
 <485837f392401bf35fb7fc8231d7a051f47b53d7.camel@HansenPartnership.com>
 <539b35c6-34f7-62e0-4d93-6d27145bb78f@suse.de>
 <f31fbb6d2f374a39d22e3fca122d757e905d2711.camel@HansenPartnership.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Subject: Re: [LSF/MM/BPF TOPIC] block namespaces
Message-ID: <33f720ce-484b-0c42-b14a-0a7df3e09e81@suse.de>
Date: Thu, 10 Jun 2021 17:05:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <f31fbb6d2f374a39d22e3fca122d757e905d2711.camel@HansenPartnership.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210610_080512_521752_A4C4998D 
X-CRM114-Status: GOOD (  44.45  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNi8xMC8yMSA0OjI5IFBNLCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6Cj4gT24gVGh1LCAyMDIx
LTA2LTEwIGF0IDA3OjQ5ICswMjAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IE9uIDYvOS8y
MSA4OjM2IFBNLCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6Cj4+PiBPbiBUaHUsIDIwMjEtMDUtMjcg
YXQgMTA6MDEgKzAyMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4+PiBIaSBhbGwsCj4+Pj4K
Pj4+PiBJIGd1ZXNzIGl0J3MgdGltZSB0byB0aWNrIG9mZiB5ZXQgYW5vdGhlciBpdGVtIG9uIG15
IGxvbmctdGVybQo+Pj4+IHRvLWRvIGxpc3Q6Cj4+Pj4KPj4+PiBCbG9jayBuYW1lc3BhY2VzCj4+
Pj4gLS0tLS0tLS0tLS0tLS0tLQo+Pj4+Cj4+Pj4gSWRlYSBpcyBzaW1pbGFyIHRvIHdoYXQgbmV0
d29yayBhbHJlYWR5IGRvZXM6IGFsbG93aW5nIGVhY2ggdXNlcgo+Pj4+IG5hbWVzcGFjZSB0byBo
YXZlIGEgZGlmZmVyZW50ICd2aWV3JyBvbiB0aGUgZXhpc3RpbmcgYmxvY2sKPj4+PiBkZXZpY2Vz
LiAgRUcgaWYgdGhlIGFkbWluIGNyZWF0ZXMgYSByYW1kaXNrIGluIG9uZSBuYW1lc3BhY2UgdGhp
cwo+Pj4+IGRldmljZSBzaG91bGQgbm90IGJlIHZpc2libGUgdG8gb3RoZXIgbmFtZXNwYWNlcy4g
IEJ1dCBmb3IgbWUgdGhlCj4+Pj4gbW9zdCBpbXBvcnRhbnQgdXNlLWNhc2Ugd291bGQgYmUgcWVt
dTsgY3VycmVudGx5IHRoZSBkZXZpY2VzIG5lZWQKPj4+PiB0byBiZSBzZXQgdXAgaW4gdGhlIGhv
c3QsIGV2ZW4gdGhvdWdoIHRoZSBob3N0IGhhcyBubyBidXNpbmVzcwo+Pj4+IHRvdWNoaW5nIGl0
IGFzIHRoZXkgcmVhbGx5IGJlbG9uZyB0byB0aGUgcWVtdSBpbnN0YW5jZS4gIFRoaXMKPj4+PiBp
cyBjYXVzaW5nIHF1aXRlIHNvbWUgaXJyaXRhdGlvbiBlZyB3aGVuIHRoaXMgZGV2aWNlIGhhcyBM
Vk0gb3IKPj4+PiBNRCBtZXRhZGF0YSBhbmQgdWRldiBpcyB0cnlpbmcgdG8gYWN0aXZhdGUgaXQg
b24gdGhlIGhvc3QuCj4+Pgo+Pj4gSSBzdXBwb3NlIHRoZSBmaXJzdCBxdWVzdGlvbiBpcyAid2h5
IGJsb2NrIG9ubHk/IiAgVGhlcmUgYXJlCj4+PiBzZXZlcmFsIGV4aXN0aW5nIGRldmljZSBuYW1l
c3BhY2UgcHJvcG9zYWxzIHdoaWNoIHdvdWxkIGJlIG1vcmUKPj4+IGdlbmVyaWMuCj4+Pgo+Pgo+
PiBXZWxsOyBJJ20gbW9yZSBvZiBhIHN0b3JhZ2UgcGVyc29uLCBhbmQgZG8ga25vdyB0aGUgbmVl
ZHMgYW5kIAo+PiBzaG9ydGNvbWluZ3MgaW4gdGhhdCBhcmVhLiBMZXNzIHdlbGwgc28gaW4gb3Ro
ZXIgYXJlYXMuLi4KPiAKPiBPSywgYnV0IHRoaXMgc2hvdWxkIHdvcmsgZm9yIGFsbCBkZXZpY2Vz
LCBqdXN0IGxpa2UgdGhlIGRldmljZSBjZ3JvdXAKPiBpZiBpdCdzIGdvaW5nIHRvIGJlIGFuIGFk
anVuY3QgdG8gaXQuCj4gCj4+Pj4gT3ZlcmFsbCBwbGFuIGlzIHRvIHJlc3RyaWN0IHZpZXdzIG9m
ICcvZGV2JywgJy9zeXMvZGV2L2Jsb2NrJyBhbmQKPj4+PiAnL3N5cy9ibG9jaycgdG8gb25seSBw
cmVzZW50IHRoZSBkZXZpY2VzICd2aXNpYmxlJyBmb3IgdGhpcwo+Pj4+IG5hbWVzcGFjZS4KPj4+
Cj4+PiBXZSBhY3R1YWxseSBhbHJlYWR5IGhhdmUgYSBkZXZpY2VzIGNncm91cCB0aGF0IGRvZXMg
c29tZSBvZiB0aGlzOgo+Pj4KPj4+IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL0RvY3VtZW50
YXRpb24vY2dyb3VwLXYxL2RldmljZXMudHh0Cj4+Pgo+PiBJIGtub3cuIEJ1dCB0aGlzIGVzc2Vu
dGlhbGx5IGlzIGEgZmlsdGVyIG9uICcvZGV2JyBvbmx5LCBhbmQgbmVlZHMgdG8KPj4gYmUgY29u
ZmlndXJlZC4gV2hpY2ggbWFrZXMgaXQgdmVyeSB1bndpZWxkeSB0byB1c2UuCj4+IEFuZCB0aGUg
Y29udGVudHMgb2Ygc3lzZnMgYXJlIG5vdCBtb2RpZmllZCwgc28gdGhlcmUncyBhIG1pc21hdGNo
IAo+PiBiZXR3ZWVuIGNvbnRlbnRzIGluIC9kZXYgYW5kIC9zeXMuCj4+IFdoaWNoIG1pZ2h0IGNh
dXNlIGlzc3VlcyB3aXRoIG1vbml0b3JpbmcgdG9vbHMuCj4gCj4gRmlyc3RseSwgc2luY2UgaXQg
ZG9lcyBwYXJ0IG9mIHdoYXQgeW91IHdhbnQsIHdlIGF0IGxlYXN0IG5lZWQgdG8KPiB1bmRlcnN0
YW5kIHdoeSB5b3UgdGhpbmsgaXQgY2FuJ3QgYmUgZW5oYW5jZWQgdG8gZG8gZXZlcnl0aGluZy4K
PiAKPiBUaGUgL3N5cyBwcm9ibGVtIGhhcyBiZWVuIGRpc2N1c3NlZCBtYW55IHRpbWVzLiAgR3Jl
Z0tIIHJlYWxseSBkb2Vzbid0Cj4gbGlrZSB0aGUgaWRlYSBvZiBmaWx0ZXJpbmcgL3N5cyAoYW5k
IG1vc3QgY29udGFpbmVyIHBlb3BsZSBhZ3JlZSksIHNvCj4gdGhlIG9wdGlvbnMgYXZhaWxhYmxl
IHNlZW0gdG8gYmUgZG9uJ3QgbW91bnQgL3N5cyBpbiBhIGNvbnRhaW5lciBvcgo+IGVtdWxhdGUg
aXQgdmlhIGZ1c2UuICBJZiB5b3UgcGljayBlaXRoZXIgZG9lcyB0aGUgZGV2aWNlIGNncm91cCBu
b3cKPiB3b3JrIGZvciB5b3U/Cj4gCgouLi4gYmVnZ2luZyB0aGUgcXVlc3Rpb24gd2h5IGhlIHJl
bGVudGVkIGZvciBuZXR3b3JrIG5hbWVzcGFjZXMuClRoZXkgX2RvXyBtb2RpZnkgc3lzZnMsIGFu
ZCB0aGF0IHZpYSBnZW5lcmljIGhvb2tzIChpZSBtYWtpbmcgc3RydWN0CmNsYXNzIG5hbWVzcGFj
ZS1hd2FyZSkuCkFuZCBhcyB0aGlzIGlzIGEgcHVibGljIGludGVyZmFjZSBJIGRvbid0IHNlZSB3
aHkgSSBjYW4ndCBiZSB1c2luZyBpdC4uLgoKPj4+IEhvd2V2ZXIsIHZpc2liaWxpdHkgaXNuJ3Qg
dGhlIG9ubHkgcHJvYmxlbSwgZm9yIGRpcmVjdCBwYXNzdGhyb3VnaAo+Pj4gdGhlcmUncyBhbHNv
IHVldmVudCBoYW5kbGluZyBhbmQgcGVvcGxlIGhhdmUgZXZlbiBhc2tlZCBhYm91dAo+Pj4gbW9k
dWxlIGxvYWRpbmcuCj4+Pgo+PiBJIGFtIGF3YXJlLCBhbmQgdGhhdCdzIGFub3RoZXIgcmVhc29u
IHdoeSBkZXZpY2UgY2dyb3VwIGRvZXNuJ3QgY3V0Cj4+IGl0Lgo+IAo+IENocmlzdGlhbiBCcmF1
bmVyIGlzIGxvb2tpbmcgYXQgdGhpcyAuLi4gYXBwYXJlbnRseSBVYnVudHUgaGFzIHNvbWUKPiB0
aHVtYiBkcml2ZSBpbnNpZGUgbHhjIGNvbnRhaW5lciB1c2UgY2FzZSB0aGF0IG5lZWRzIGl0Lgo+
IAoKR3Vlc3Mgd2l0aCB3aG9tIEknbSBkaXNjdXNzaW5nIG9uIGhvdyB0byBpbXBsZW1lbnQgdGhp
cy4KCj4+Pj4gICBJbml0aWFsbHkgdGhlIGRyaXZlcnMgd291bGQga2VlcCB0aGVpciBnbG9iYWwg
ZW51bWVyYXRpb24sIGJ1dAo+Pj4+IHBsYW4gaXMgdG8gbWFrZSB0aGUgZHJpdmVycyBuYW1lc3Bh
Y2UtYXdhcmUsIHRvbywgc3VjaCB0aGF0IGVhY2gKPj4+PiBuYW1lc3BhY2UgY291bGQgaGF2ZSBp
dHMgb3duIGRyaXZlci1zcGVjaWZpYyBkZXZpY2UgZW51bWVyYXRpb24uCj4+Pgo+Pj4gSSByZWFs
bHkgd291bGRuJ3QgZG8gdGhpcy4gIE5hbWVzcGFjZS9DZ3JvdXAgc2VwYXJhdGlvbiBzaG91bGQg
YmUKPj4+IGtlcHQgYXMgaGlnaCBhcyBwb3NzaWJsZS4gIElmIGl0IGxlYWtzIGludG8gdGhlIGRy
aXZlcnMgaXQgd2lsbAo+Pj4gYmVjb21lIHVubWFpbnRhaW5hYmxlLiAgV2h5IGRvIHlvdSB0aGlu
ayB5b3UgbmVlZCB0aGUgZHJpdmVycyB0byBiZQo+Pj4gYXdhcmU/ICBJZiBpdCdzIGp1c3QgZW51
bWVyYXRpb24sIHRoYXQgc2hvdWxkIGFsbCBiZSBkb2FibGUgd2l0aAo+Pj4gdGhlIHZpc2liaWxp
dHkgZHJpdmVyIHVubGVzcyB5b3Ugd2FudCB0byBkbyB0aGluZ3MgbGlrZSBjb21wYWN0Cj4+PiBu
dW1iZXJpbmc/Cj4+Pgo+PiBXaGljaCBpcyBwcmVjaXNlbHkgd2h5IEkgbWVudGlvbmVkIGRldmlj
ZSBtb2RpZmljYXRpb25zLgo+PiBPbiBhIGdlbmVyaWMgbGV2ZWwgd2UgY2FuIGluZmx1ZW5jZSB0
aGUgdmlzaWJpbGl0eSBvZiBkZXZpY2VzIGluIAo+PiByZWxhdGlvbiB0byBuYW1lc3BhY2VzLCB3
ZSBjYW5ub3QgaW5mbHVlbmNlIHRoZSBkZXZpY2VzIHRoZW1zZWx2ZXMuCj4+IFRoaXMgd2lsbCBs
ZWFkIHRvIG5hbWVzcGFjZXMgc2VlaW5nIGRpc2p1bmN0IGRldmljZSBudW1iZXJzIChpZSA4OjAK
Pj4gYW5kIDg6OCBvbiBucyAxLCA4OjQgb24gbnMgMikuIE5vdCB0aGF0IEkgdGhpbmsgdGhhdCB3
aWxsIGJlIGFuCj4+IGlzc3VlLCBidXQgIGNlcnRhaW5seSBhIGNoYW5nZSBpbiBiZWhhdmlvdXIu
Cj4gCj4gV2VsbCwgbm90IG5lY2Vzc2FyaWx5LCB0aGUgcGlkIG5hbWVzcGFjZSBpcyBhbiBleGFt
cGxlIG9mIGEgcmVtYXBwaW5nCj4gbmFtZXNwYWNlLiAgVGhlIHNhbWUgdGhpbmcgY291bGQgYmUg
ZG9uZSBmb3IgZGV2aWNlIG51bWJlcmluZywgYnV0Cj4gdGhlcmUgcmVhbGx5IG5lZWRzIHRvIGJl
IGEgY29tcGVsbGluZyBjYXNlLiAgR2l2ZW4gb3VyIHVzZSBvZiBob3RwbHVnLAo+IHdoeSB3b3Vs
ZCBhbnkgdG9vbCBhc3N1bWUgY29tcGFjdCBudW1iZXJpbmc/ICBBbmQgaWYgeW91IGRvbid0IG5l
ZWQKPiBjb21wYWN0IG51bWJlcmluZyB0aGVyZSdzIG5vIG5lZWQgdG8gYm90aGVyIHdpdGggcmVt
YXBwaW5nLgo+IAoKV2hpY2ggaXMgbXkgYXNzdW1wdGlvbiwgdG9vLiBJIGhhdmUganVzdCBtZW50
aW9uZWQgaXQgaGVyZSBmb3IKY29tcGxldGVuZXNzIHNha2UuIEl0J3Mgbm90IHRoYXQgSSdsbCBi
ZSBpbXBsZW1lbnRpbmcgaXQgZm9yIG5vdy4KCj4+Pj4gR29hbCBvZiB0aGlzIHRvcGljIGlzIHRv
IGdldCBhIGNvbnNlbnN1cyBvbiB3aGV0aGVyIGJsb2NrCj4+Pj4gbmFtZXNwYWNlcyBhcmUgYSBm
ZWF0dXJlIHdoaWNoIHdvdWxkIGZpbmQgaW50ZXJlc3QsIGFuZCBhbHNvIHRvCj4+Pj4gZGlzY3Vz
cyBzb21lIGRlc2lnbiBkZXRhaWxzIGhlcmU6Cj4+Pj4gLSBPbmx5IGluIGNlcnRhaW4gY2FzZXMg
Y2FuIGEgbmFtZXNwYWNlIGJlIGFzc2lnbmVkIChlZyBieQo+Pj4+IGNhbGxpbmcKPj4+PiAnbW9k
cHJvYmUnLCBzdGFydGluZyBpc2NzaWFkbSwgb3IgY2FsbGluZyBudm1lLWNsaSk7IGhvdyBkbyB3
ZQo+Pj4+IGhhbmRsZQo+Pj4+IGRldmljZXMgZm9yIHdoaWNoIG5vIG5hbWVzcGFjZSBjYW4gYmUg
aWRlbnRpZmllZD8KPj4+PiAtIFNoYWxsIHdlIGFsbG93IGZvciBkaWZmZXJlbnQgZGV2aWNlIGVu
dW1lcmF0aW9uIHBlciBuYW1lc3BhY2U/Cj4+Pj4gLSBJbnRvIHdoaWNoIGxldmVsIHNob3VsZCB3
ZSBnbyB3aXRoIGhpZGluZyBzeXNmcyBzdHJ1Y3R1cmVzPwo+Pj4+ICAgIElzIGJsYW5raW5nIG91
dCB0aGUgaGlnaGVyLWxldmVsIGludGVyZmFjZXMgaW4gL2RldiBhbmQKPj4+PiAvc3lzL2Jsb2Nr
ICAgIGVub3VnaD8KPj4+Cj4+PiBGaXJzdCBxdWVzdGlvbiBpcyBkb2VzIHRoZSBkZXZpY2UgY2dy
b3VwIGRvIGVub3VnaCBmb3IgeW91IGFuZCBpZgo+Pj4gbm90IHdoYXQncyBtaXNzaW5nPwo+Pj4K
Pj4gU2VlIGFib3ZlLiBzeXNmcyBtb2RpZmljYXRpb25zIGFuZCB1ZXZlbnQgZmlsdGVyaW5nIGFy
ZSBtaXNzaW5nLgo+PiBUaGlzIGluZnJhc3RydWN0dXJlIGZvciB0aGF0IGlzIGFscmVhZHkgaW4g
cGxhY2UgdGhhbmtzIHRvIG5ldHdvcmsgCj4+IG5hbWVzcGFjZXMsIHdlICdqdXN0JyBuZWVkIHRv
IG1ha2UgdXNlIG9mIGl0Lgo+PiBBZGRpdGlvbmFsIGRyYXdiYWNrIGlzIHRoZSBtYW51YWwgY29u
ZmlndXJhdGlvbiBvZiBkZXZpY2UtY2dyb3VwLgo+IAo+IE9LLCBzbyBzdGlsbCwgd2h5IG5vdCBm
aXggb3IgZW5oYW5jZSB0aGUgZGV2aWNlIGNncm91cD8gIFRoZSBjdXJyZW50Cj4gcHJvcG9zYWwg
c2VlbXMgdG8gd2FudCB0byBkdXBsaWNhdGUgaXQgYXMgYSBuYW1lc3BhY2UuCj4gClByaW1hcmls
eSBiZWNhdXNlIGRldmljZS1ncm91cCBpcyByZWFsbHkgbGltaXRlZCBpbiBpdHMgZnVuY3Rpb25h
bGl0eSwKYW5kIHRoZSBpbnRlcmZhY2UgaW50byB0aGUgZGV2aWNlIGNvcmUgaXMsIHF1aXRlIGZy
YW5rbHksIGhvcnJpYmxlLgooSW1wbGVtZW50aW5nIGl0IHVuZGVyIHNlY3VyaXR5L2RldmljZV9j
Z3JvdXAuYywgYW5kIGhhdmluZyBkaXJlY3QKZnVuY3Rpb24gY2FsbHMgZnJvbSBmcy9ibG9ja19k
ZXYuYyBhbmQgZnMvbmFtZWkuYz8KaGNoIHdpbGwgeWV0IGF0IG1lIGlmIEkgYXR0ZW1wdGVkIHRo
YXQuKQoKUmUtaW1wbGVtZW50aW5nIHRoYXQgYXMgYSBuYW1lc3BhY2UgaXMgdGhlIGNsZWFuZXIg
c29sdXRpb24uCkFjdHVhbGx5LCBpdCBzaG91bGQgYmUgcG9zc2libGUgdG8gcmUtaW1wbGVtZW50
aW5nIGRldmljZS1jZ3JvdXAgb24gdG8Kb2YgdGhlIGJsb2NrIG5hbWVzcGFjZXM7IGZvciB0aGF0
IHdlJ2xsIGhhdmUgdG8gZXhwYW5kIGl0IHRvIGNvdmVyIGFsbApkZXZpY2VzLCBidXQgeW91J3Jl
IGFyZ3VpbmcgZm9yIHRoYXQgYW55d2F5LgpTbywgbGV0J3Mgc2VlLgoKQ2hlZXJzLAoKSGFubmVz
Ci0tIApEci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVj
dApoYXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNv
ZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIDkwNDA5IE7DvHJuYmVyZwpHRjogRi4gSW1l
bmTDtnJmZmVyLCBIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZykKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
