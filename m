Return-Path: <SRS0=G/Rm=MN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C702C12002
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 06:12:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2E8600EF
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 06:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2E8600EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Fb1a1rzbRmMQUCsyF76mGOuEIx7mgEHiTRKNvsfCE1w=; b=Swe+ZwhIXLuAXqukc3f8ssQDUR
	VUhLnqJ8p4XfIt2XHyEgRkH/DFkzDHCzUBrzJujNCXTFUbvZwvcenkNaDk5rqolkdhsER6yjxp2Qf
	2rWlyc43myAUQiyRQ+x1XoDnyEOY7yWswivSQKQQ876vk3umoA1WIgSPFh1rBpV/HhzA2+NF54zCN
	XLvFUYSsGMEsHhi9lwsQXmH0poEVj6kPnJ0NBMezBIMhc4BD8P4sBiN1Iyg10p1z93+yv3iDJbIQH
	D+BB5WkxwZtMfyCIQiPoivgaRka+4B/PUSG+hawwJ9ztPbiepjwrTLRq0WczPk1qEFyUkoFXeB+tK
	GacVIEAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m65Sj-00EZFh-2C; Wed, 21 Jul 2021 06:12:09 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m65Sf-00EZF7-U1
 for linux-nvme@lists.infradead.org; Wed, 21 Jul 2021 06:12:07 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9BDAD20309;
 Wed, 21 Jul 2021 06:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626847924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=23Da93x2OamZkrjR7W059ebzA9RY2IGBwKnHeBHK5SU=;
 b=PeNne0pGyUGWa2BTrvclh6ps1qlNHNCZWdF7dTCA+6fc0Fj+2PG8gu4F7zTS0OOnxfSu94
 UGTOD/iId2nOAaxGhP5u2Lb2/PiDvA1cORstTc9wMs9OVjZh9p+e6L8zcqMS6E0L+USI7Q
 ybdotj77oCC1tr/kjWPXDH2PwdtUTK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626847924;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=23Da93x2OamZkrjR7W059ebzA9RY2IGBwKnHeBHK5SU=;
 b=VdKJuwzVvR7D8rog49FyRYVIDGCjcCSqDPWl/NsCfgHsvFStxZ+B13I/uHw/P7FHOGUQsb
 WAmEC0n/mHHDZYDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86BF9133D1;
 Wed, 21 Jul 2021 06:12:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kh8sILS692CPbQAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 21 Jul 2021 06:12:04 +0000
Subject: Re: [PATCH 06/11] nvme: Implement In-Band authentication
To: Vladislav Bolkhovitin <vst@vlnb.net>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <20210716110428.9727-7-hare@suse.de>
 <bd588839-8acc-91cf-5946-f702007b0c7d@grimberg.me>
 <d74c29b8-1c64-e439-9015-6c424baad3d3@suse.de>
 <a3098fb2-2127-6f81-97e9-ab5de503508e@vlnb.net>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <14949004-6ef5-b8e5-f133-c50fe311a693@suse.de>
Date: Wed, 21 Jul 2021 08:12:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a3098fb2-2127-6f81-97e9-ab5de503508e@vlnb.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210720_231206_172575_D5BCDBDB 
X-CRM114-Status: GOOD (  28.64  )
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

T24gNy8yMC8yMSAxMDoyOCBQTSwgVmxhZGlzbGF2IEJvbGtob3ZpdGluIHdyb3RlOgo+IAo+IE9u
IDcvMTgvMjEgMzoyMSBQTSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+PiBPbiA3LzE3LzIxIDk6
MjIgQU0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4+Pj4gSW1wbGVtZW50IE5WTWUtb0YgSW4tQmFu
ZCBhdXRoZW50aWNhdGlvbi4gVGhpcyBwYXRjaCBhZGRzIHR3byBuZXcKPj4+PiBmYWJyaWMgb3B0
aW9ucyAnZGhjaGFwX2tleScgdG8gc3BlY2lmeSB0aGUgUFNLCj4+Pgo+Pj4gcHJlLXNoYXJlZC1r
ZXkuCj4+Pgo+Pj4gQWxzbywgd2UgbmVlZCBhIHN5c2ZzIGtub2IgdG8gcm90YXRlIHRoZSBrZXkg
dGhhdCB3aWxsIHRyaWdnZXIKPj4+IHJlLWF1dGhlbnRpY2F0aW9uIG9yIGV2ZW4gYSBzaW1wbGUg
Y29udHJvbGxlcihzLXBsdXJhbCkgcmVzZXQsIHNvIHRoaXMKPj4+IHNob3VsZCBnbyBiZXlvbmQg
anVzdCB0aGUgY29ubmVjdGlvbiBzdHJpbmcuCj4+Pgo+Pgo+PiBZZWFoLCByZS1hdXRoZW50aWNh
dGlvbiBjdXJyZW50bHkgaXMgbm90IGltcGxlbWVudGVkLiBJIGZpcnN0IHdhbnRlZCB0bwo+PiBn
ZXQgdGhpcyBwYXRjaHNldCBvdXQgc3VjaCB0aGF0IHdlIGNhbiBzZXR0bGUgb24gdGhlIHVzZXJz
cGFjZSBpbnRlcmZhY2UKPj4gKGJvdGggZnJvbSBob3N0IGFuZCB0YXJnZXQpLgo+PiBJJ2xsIGhh
dmUgdG8gdGhpbmsgb24gaG93IHdlIHNob3VsZCBoYW5kbGUgYXV0aGVudGljYXRpb247IG9uZSBv
ZiB0aGUKPj4gcmVhbGx5IGludGVyZXN0aW5nIGNhc2VzIHdvdWxkIGJlIHdoZW4gb25lIG1hbGlj
aW91cyBhZG1pbiB3aWxsIF9qdXN0Xwo+PiBzZW5kIGEgJ25lZ290aWF0ZScgY29tbWFuZCB0byB0
aGUgY29udHJvbGxlci4gQXMgcGVyIHNwZWMgdGhlIGNvbnRyb2xsZXIKPj4gd2lsbCBiZSB3YWl0
aW5nIGZvciBhbiAnYXV0aGVudGljYXRpb24gcmVjZWl2ZScgY29tbWFuZCB0byBzZW5kIGEKPj4g
J2NoYWxsZW5nZScgcGF5bG9hZCBiYWNrIHRvIHRoZSBob3N0LiBCdXQgdGhhdCB3aWxsIG5ldmVy
IGNvbWUsIHNvIGFzIGl0Cj4+IHN0YW5kcyBjdXJyZW50bHkgdGhlIGNvbnRyb2xsZXIgaXMgcmVx
dWlyZWQgdG8gYWJvcnQgdGhlIGNvbm5lY3Rpb24uCj4+IE5vdCB2ZXJ5IG5pY2UuCj4gCj4gWWVz
LCBpbiB0aGlzIGNhc2UgYWZ0ZXIgc29tZSByZWFzb25hYmxlIHRpbWVvdXQgKEkgd291bGQgc3Vn
Z2VzdCAxMC0xNQo+IHNlY29uZHMpIHRoZSBjb250cm9sbGVyIGV4cGVjdGVkIHRvIGFib3J0IGNv
bm5lY3Rpb24gYW5kIGNsZWFuIHVwIGFsbAo+IGFsbG9jYXRlZCByZXNvdXJjZXMuCj4gCj4gVG8g
aGFuZGxlIERvUyBwb3NzaWJpbGl0eSB0byBtYWtlIHRvbyBtYW55IHN1Y2ggIm9ycGhhbiIgbmVn
b3RpYXRpb25zLAo+IGhlbmNlIGNvbnN1bWUgYWxsIGNvbnRyb2xsZXIgbWVtb3J5LCBzb21lIGFk
ZGl0aW9uYWwgaGFuZGxpbmcgaXMgbmVlZGVkLgo+IEZvciBzaW1wbGljaXR5IGFzIGEgZmlyc3Qg
c3RlcCBJIHdvdWxkIHN1Z2dlc3QgdG8gaGF2ZSBhIGdsb2JhbCBsaW1pdCBvbgo+IG51bWJlciBv
ZiBjdXJyZW50bHkgYmVpbmcgYXV0aGVudGljYXRlZCBjb25uZWN0aW9ucy4KPiAKPiBbLi4uXQo+
IAo+Pj4+ICvCoMKgwqAgY2hhcC0+a2V5ID0gbnZtZV9hdXRoX2V4dHJhY3Rfc2VjcmV0KGN0cmwt
Pm9wdHMtPmRoY2hhcF9zZWNyZXQsCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAmY2hhcC0+a2V5X2xlbik7Cj4+Pj4gK8KgwqDCoCBpZiAoSVNf
RVJSKGNoYXAtPmtleSkpIHsKPj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0ID0gUFRSX0VSUihjaGFw
LT5rZXkpOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBjaGFwLT5rZXkgPSBOVUxMOwo+Pj4+ICvCoMKg
wqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+Pj4+ICvCoMKgwqAgfQo+Pj4+ICsKPj4+PiArwqDCoMKg
IGlmIChrZXlfaGFzaCA9PSAwKQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+PiAr
Cj4+Pj4gK8KgwqDCoCBobWFjX25hbWUgPSBudm1lX2F1dGhfaG1hY19uYW1lKGtleV9oYXNoKTsK
Pj4+PiArwqDCoMKgIGlmICghaG1hY19uYW1lKSB7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHByX2Rl
YnVnKCJJbnZhbGlkIGtleSBoYXNoIGlkICVkXG4iLCBrZXlfaGFzaCk7Cj4+Pj4gK8KgwqDCoMKg
wqDCoMKgIHJldHVybiAtRUtFWVJFSkVDVEVEOwo+Pj4+ICvCoMKgwqAgfQo+Pj4KPj4+IFdoeSBk
b2VzIHRoZSB1c2VyIGluZmx1ZW5jZSB0aGUgaG1hYyB1c2VkPyBpc24ndCB0aGF0IGlzIGRyaXZl
bgo+Pj4gYnkgdGhlIHN1c2JzeXN0ZW0/Cj4+Pgo+Pj4gSSBkb24ndCB0aGluayB0aGF0IHRoZSB1
c2VyIHNob3VsZCBjaG9vc2UgaW4gdGhpcyBsZXZlbC4KPj4+Cj4+Cj4+IFRoYXQgaXMgYW5vdGhl
ciB3ZWlyZG5lc3Mgb2YgdGhlIHNwZWMuCj4+IFRoZSBfc2VjcmV0XyB3aWxsIGJlIGhhc2hlZCB3
aXRoIGEgc3BlY2lmaWMgZnVuY3Rpb24sIGFuZCB0aGF0IGZ1bmN0aW9uCj4+IGlzIHN0YXRlZCBp
biB0aGUgdHJhbnNwb3J0IHJlcHJlc2VudGF0aW9uLgo+PiAoQ2Ygc2VjdGlvbiAiREgtSE1BQy1D
SEFQIFNlY3VyaXR5IFJlcXVpcmVtZW50cyIpLgo+PiBUaGlzIGlzIF9ub3RfIHRoZSBoYXNoIGZ1
bmN0aW9uIHVzZWQgYnkgdGhlIGF1dGhlbnRpY2F0aW9uIGl0c2VsZiwgd2hpY2gKPj4gd2lsbCBi
ZSBzZWxlY3RlZCBieSB0aGUgcHJvdG9jb2wuCj4+IFNvIGl0J3Mgbm90IHRoZSB1c2VyIGhlcmUs
IGJ1dCByYXRoZXIgdGhlIHRyYW5zcG9ydCBzcGVjaWZpY2F0aW9uIG9mIHRoZQo+PiBrZXkgd2hp
Y2ggc2VsZWN0cyB0aGUgaGFzaCBhbGdvcml0aG0uCj4gCj4gWWVzLCBnb29kIGNhdGNoLiBJdCBs
b29rcyBhcyBhIG1pbm9yIGVycmF0YSBtYXRlcmlhbCB0byBzcGVjaWZ5IHRoYXQKPiBoYXNoIGZ1
bmN0aW9uIGhlcmUgaXMgaW1wbGVtZW50YXRpb24gc3BlY2lmaWMuCj4gCj4gSSB3b3VsZCBzdWdn
ZXN0IHRvIGp1c3QgaGFyZGNvZGUgU0hBNTEyIGhlcmUuIFVzZXJzIGRvbid0IGhhdmUgdG8gYmUK
PiBjb25mdXNlZCBieSB0aGlzLgo+IApTdXJlLCBjYW4gZG8uIE15IHJlYXNvbmluZyB3YXMgdGhh
dCB0aGUgdGFyZ2V0IGFic29sdXRlbHkgaGFzIHRvIHN1cHBvcnQKdGhlIGhhc2ggZnVuY3Rpb25z
IHNwZWNpZmllZCBpbiB0aGUgUFNLLCBzbyB0aGF0IHdpbGwgYmUgYSBzYWZlIGJldCB0bwpjaG9v
c2UgZm9yIHRoZSBoYXNoIGZ1bmN0aW9uIGluIHRoZSBwcm90b2NvbCBpdHNlbGYuCihBbnkgb3Ro
ZXIgaGFzaCBmdW5jdGlvbiBfbWlnaHRfIG5vdCBiZSBwcmVzZXQgb24gdGhlIHRhcmdldC4pCkJ1
dCBpZiB0aGUgUFNLIGRvZXMgbm90IHNwZWNpZnkgYSBoYXNoIHRoZSB0YXJnZXQgbmVlZCB0byBw
aWNrIG9uZTsgYW5kCmZvciB0aGF0IG9mIGNvdXJzZSB3ZSBjYW4gdXNlIFNIQTUxMi4KCkNoZWVy
cywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZQkJICAgICAgICAgICBLZXJuZWwgU3Rv
cmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlCQkJICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3
NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJILCBNYXhmZWxkc3Ry
LiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHRjogRmVsaXgg
SW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1l
Cg==
