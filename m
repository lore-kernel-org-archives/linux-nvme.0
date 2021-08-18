Return-Path: <SRS0=/QSy=NJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F6AC4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 05:44:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8B4B61038
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 05:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C8B4B61038
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0HPWN/9yaSNVmaj99Stu4oAt+j+2PuL2/ol+bl+FwIE=; b=DDhfWH5ehwFGtqg6RulEETuVnI
	hVcsTgXVvI+0HHFlQEj2E808/CFsZPZ78aRTF2TGZHoQnK70qL9eobnRY7DjMc9UOGJMyQjVgFPvQ
	xNuzr3RsmEIpL+sn92kIURBCLNekkdW4nvEZoJEKGyURxSa6hl5UqSCppetf/WVIQMgeKZ2cvmzEV
	IC9R2aX67iI/wE5eqT1/3kAq1CXb8T7sFRW7/p0FIdltKZPVyEEbXoKTEVgQBJuSi/rsU6P/UUtpw
	o/98J5vgccaChE6RazEb4O+3xcWJKFawHvxj6AW8sAe1+tyoVgqZ4twshEUZR8KI3sQM1mQqq86RX
	bYfTcRaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGENS-004GaL-T7; Wed, 18 Aug 2021 05:44:38 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGENN-004GZw-Oa
 for linux-nvme@lists.infradead.org; Wed, 18 Aug 2021 05:44:37 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F1B921FF80;
 Wed, 18 Aug 2021 05:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1629265471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7gt9xQcpg8cLompgwAs2sgaTiNyRhomg3wa5s6AJxE=;
 b=GwJqqya4wErklpUfsHhkvceUHxU7++zXRRxL1ZA2tPLDfzCMF+E2KXG3ftzPT01KZL3t0o
 j/PQx+pkhVSHClamIyhh0/dVCtBOivIv/qn9gB/TU9xckEgKlF0RxeL7tl28HETYm1oSOA
 x615NaF4YbY/6cWJhs1fmGMznR/8D3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1629265471;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7gt9xQcpg8cLompgwAs2sgaTiNyRhomg3wa5s6AJxE=;
 b=zKV4yycOMmovdQAhULrtF00NIo0gAUBBWL+J9SR27LszChgC1urhm3C1hlkMTV+ATONW8k
 E0xGU0Re4SI724AQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id CC28C13357;
 Wed, 18 Aug 2021 05:44:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id 1m86MD+eHGEqagAAGKfGzw
 (envelope-from <hare@suse.de>); Wed, 18 Aug 2021 05:44:31 +0000
Subject: Re: [PATCHv2 00/13] nvme: In-band authentication support
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210810124230.12161-1-hare@suse.de>
 <5a69187b-cfb1-d09a-87e2-8435e27612a7@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <dbf2ca1f-32f6-2aff-da08-d3fd2f977fa5@suse.de>
Date: Wed, 18 Aug 2021 07:44:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <5a69187b-cfb1-d09a-87e2-8435e27612a7@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210817_224433_999707_32F84616 
X-CRM114-Status: GOOD (  25.61  )
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

T24gOC8xNy8yMSAxMToyMSBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4gSGkgYWxsLAo+
Pgo+PiByZWNlbnQgdXBkYXRlcyB0byB0aGUgTlZNZSBzcGVjIGhhdmUgYWRkZWQgZGVmaW5pdGlv
bnMgZm9yIGluLWJhbmQKPj4gYXV0aGVudGljYXRpb24sIGFuZCBzZWVpbmcgdGhhdCBpdCBwcm92
aWRlcyBzb21lIHJlYWwgYmVuZWZpdAo+PiBlc3BlY2lhbGx5IGZvciBOVk1lLVRDUCBoZXJlJ3Mg
YW4gYXR0ZW1wdCB0byBpbXBsZW1lbnQgaXQuCj4+Cj4+IFRyaWNreSBiaXQgaGVyZSBpcyB0aGF0
IHRoZSBzcGVjaWZpY2F0aW9uIG9yaWVudHMgaXRzZWxmIG9uIFRMUyAxLjMsCj4+IGJ1dCBzdXBw
b3J0cyBvbmx5IHRoZSBGRkRIRSBncm91cHMuIFdoaWNoIG9mIGNvdXJzZSB0aGUga2VybmVsIGRv
ZXNuJ3QKPj4gc3VwcG9ydC4gSSd2ZSBiZWVuIGFibGUgdG8gY29tZSB1cCB3aXRoIGEgcGF0Y2gg
Zm9yIHRoaXMsIGJ1dCBhcyB0aGlzCj4+IGlzIG15IGZpcnN0IGF0dGVtcHQgdG8gZml4IGFueXRo
aW5nIGluIHRoZSBjcnlwdG8gYXJlYSBJIHdvdWxkIGludml0ZQo+PiBwZW9wbGUgbW9yZSBmYW1p
bGlhciB3aXRoIHRoZXNlIG1hdHRlcnMgdG8gaGF2ZSBhIGxvb2suCj4+Cj4+IEFsc28gbm90ZSB0
aGF0IHRoaXMgaXMganVzdCBmb3IgaW4tYmFuZCBhdXRoZW50aWNhdGlvbi4gU2VjdXJlCj4+IGNv
bmNhdGVuYXRpb24gKGllIHN0YXJ0aW5nIFRMUyB3aXRoIHRoZSBuZWdvdGlhdGVkIHBhcmFtZXRl
cnMpIGlzIG5vdAo+PiBpbXBsZW1lbnRlZDsgb25lIHdvdWxkIG5lZWQgdG8gdXBkYXRlIHRoZSBr
ZXJuZWwgVExTIGltcGxlbWVudGF0aW9uCj4+IGZvciB0aGlzLCB3aGljaCBhdCB0aGlzIHRpbWUg
aXMgYmV5b25kIHNjb3BlLgo+Pgo+PiBBcyB1c3VhbCwgY29tbWVudHMgYW5kIHJldmlld3MgYXJl
IHdlbGNvbWUuCj4gCj4gSGV5IEhhbm5lcywKPiAKPiBGaXJzdCwgY2FuIHlvdSBhbHNvIHNlbmQg
dGhlIG52bWUtY2xpL252bWV0Y2xpIGJpdHMgYXMgd2VsbD8KPiAKWWVzLCB3aWxsIGJlIGRvbmUg
d2l0aCB0aGUgbmV4dCByb3VuZC4KSXQgZmlyc3QgcmVxdWlyZWQgYSBsYXJnZXIgdXBkYXRlIHRv
IGxpYm52bWUvbnZtZS1jbGkgdG8gZ2V0IGV2ZXJ5dGhpbmcgCmluIG9yZGVyIDotKQoKPiBTZWNv
bmQsIG9uZSB0aGluZyB0aGF0IGlzIG5vdCBjbGVhciB0byBtZSBoZXJlIGlzIGhvdyB0aGlzCj4g
d29ya3Mgd2l0aCB0aGUgZGlzY292ZXJ5IGxvZyBwYWdlLgo+IAo+IElmIHRoZSB1c2VyIGlzc3Vl
cyBhIGRpc2NvdmVyeSBsb2cgcGFnZSB0byBlc3RhYmxpc2ggY29ubmVjdGlvbnMKPiB0byB0aGUg
Y29udHJvbGxlcnMgZW50cmllcywgd2hlcmUgaXQgcGlja3MgdGhlIGFwcHJvcHJpYXRlCj4gc2Vj
cmV0Pwo+IAo+IEluIG90aGVyIHdvcmRzLCB3aGVuIHRoZSB1c2VyIHJ1bnMgY29ubmVjdC1hbGws
IGhvdyBkb2VzIGl0IGhhbmRsZQo+IHRoZSBzZWNyZXRzIGJhc2VkIG9uIHRoZSBjb250ZW50IG9m
IHRoZSBkaXNjb3ZlcnkgbG9nLXBhZ2U/CgpXaXRoIHRoZSBsYXRlc3QgbnZtZS1jbGkgdXBkYXRl
IEkndmUgaW1wbGVtZW50ZWQgYSBqc29uIGNvbmZpZ3VyYXRpb24sIAp3aGljaCBhbGxvd3MgdG8g
c3RvcmUgY29uZmlndXJhdGlvbiBvbiBhIHBlci1jb250cm9sbGVyIGJhc2lzLgpUaGlzIHdpbGwg
YmUgdXBkYXRlZCB0byBob2xkIHRoZSBkaGNoYXAgc2VjcmV0cywgYW5kIHdlIHNob3VsZCBiZSBh
YmxlIAp0byBzcGVjaWZ5IGluZGl2aWR1YWwgc2VjcmV0cyBmb3IgZWFjaCBjb250cm9sbGVyLgoK
Q2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtl
cm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBN
YXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBH
ZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
