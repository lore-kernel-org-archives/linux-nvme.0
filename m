Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A974FC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 17:23:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B0E62075F
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 17:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="THhYjd3C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IaTvj7WL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0E62075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VaJ3e5Wva6u3XeVlRB7Zq05Zci8Vlr11HmHul072xh0=; b=THhYjd3C1ELCMisQ103Tvh66H
	lSViUZ5BVjiSf75XqHx/+dppkdwJDQ0Ph7xDkZorTnyoojxQ1Jwfew/qc8gwrNN0WECEvFMPRLelC
	6CQyvE06vfOgoUUCk7NCTx4+q4JoL36P5BPYEUPKhUJAN8c48asGB34L2fQ8hS7+nCUHUFzJ9hctS
	KPuQZf+E1GNHGJBQ8AG8yUHHKY9paQlXVyTQ9IR27C8MayVPygVojFers54xuWRodRrMZa9mX8egY
	WCy/cyYkMufXg6clnrfuWdK73fNMYiIo/JfTitqL4G5gy2uRDUSNcs8qrvzJruncxTjmBlRzGa+nK
	gbFOyyvUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbSR0-0000bU-T2; Wed, 20 May 2020 17:23:14 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbSQy-0000aq-LK
 for linux-nvme@lists.infradead.org; Wed, 20 May 2020 17:23:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589995390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DCjdOMTssUEwrdR+kksZof+T09119kJHdMwXjoHB0aQ=;
 b=IaTvj7WLMer6up9ZjqAVwoLkXwTNf/7RMOwG49KkENsc8IyIhjYZZaMXez+11Y3P4jBRZp
 6lFIVul8JzilBF42mZWgUv1AHnlTmXM5EaWtFm5//JNF1wyEBO6ufwc8Qzcb5cIP8ESbVC
 90yOZhIJs4c2CGqDE35ugit7f6BNztI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-J01nKWBfPcGwwM4Jxwqtlg-1; Wed, 20 May 2020 13:23:04 -0400
X-MC-Unique: J01nKWBfPcGwwM4Jxwqtlg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D0CB8014D7;
 Wed, 20 May 2020 17:23:03 +0000 (UTC)
Received: from [10.3.112.120] (ovpn-112-120.phx2.redhat.com [10.3.112.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F57C82A33;
 Wed, 20 May 2020 17:23:02 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] nvmet: avoid memleak by freeing any remaining aens
 in nvmet_async_events_free
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@infradead.org>
References: <1589828396-144513-1-git-send-email-dmilburn@redhat.com>
 <1589828396-144513-3-git-send-email-dmilburn@redhat.com>
 <388242d3-5ccc-d694-c7a0-ac489f63f26a@grimberg.me>
 <20200520061613.GA18308@infradead.org>
 <0018af56-e3f9-8730-3c57-c4f19e478014@grimberg.me>
 <20200520070330.GA26871@infradead.org>
 <d353aa1a-cef3-d2f6-66de-92cc18cd97aa@grimberg.me>
 <20200520071526.GA7008@infradead.org>
 <c0379f95-246a-3fd6-9ec9-4ee814562c8d@grimberg.me>
 <41bae172-289e-1407-93a6-4147491a346c@redhat.com>
 <c3bef33b-f786-e4db-afbc-89e49c159c23@grimberg.me>
From: David Milburn <dmilburn@redhat.com>
Message-ID: <5f3d5126-ceb5-370d-37e2-667640bfff95@redhat.com>
Date: Wed, 20 May 2020 12:23:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c3bef33b-f786-e4db-afbc-89e49c159c23@grimberg.me>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200520_102312_776705_D757F534 
X-CRM114-Status: GOOD (  16.23  )
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
Cc: chaitanya.kulkarni@wdc.com, dwagner@suse.de, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMDUvMjAvMjAyMCAxMjoxOSBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4gSGkgQ2hy
aXN0b3BoLCBTYWdpLAo+Pgo+PiBPbiAwNS8yMC8yMDIwIDAzOjA2IEFNLCBTYWdpIEdyaW1iZXJn
IHdyb3RlOgo+Pj4KPj4+Pj4gOikgSSBndWVzcyB0aGUgcGFuZGVtaWMgZ290IHRvIG1lLi4uCj4+
Pj4+Cj4+Pj4+IFRoaW5ncyBtYWtlIGEgbG90IG1vcmUgc2Vuc2Ugbm93LiBCdXQgZG9uJ3Qgd2Ug
bmVlZCB0byBtb3ZlIHRoZSBhZW5zCj4+Pj4+IGZyZWUgdG8gYWZ0ZXIgd2UgcmVtb3ZlIHRoZSBj
b250cm9sbGVyIGZyb20gdGhlIHN1YnN5cy0+Y3RybHM/Cj4+Pj4KPj4+PiBZZXMuwqAgSSBhbHNv
IHRoaW5rIHdlIGNhbiBjbGVhbiB1cCBhIGZldyB0aGluZ3MgaGVyZS7CoCBIb3cgYWJvdXQgSSAK
Pj4+PiBhcHBseQo+Pj4+IHRoZSBzZXJpZXMgZnJvbSBEYXZpZCBub3cgYW5kIHNlbmQgYSBmZXcg
YWRkaXRpb25hbCBmaXh1cHMgb24gdG9wPwo+Pj4KPj4+IFNvdW5kcyBnb29kCj4+Pgo+Pgo+PiBZ
aSB3YXMgYWJsZSB0byByZXByb2R1Y2UgdGhlIG1lbWxlYWsgdXNpbmcgdGhlIHYyIG9mIHRoZSBw
YXRjaCBzZXJpZXMKPj4gc2luY2UgbnZtZXRfYXN5bmNfZXZlbnRzX2ZyZWUoKSByYW4gYmVmb3Jl
IG52bWV0X2FkZF9hc3luY19ldmVudCgpLgo+Pgo+PiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9waXBlcm1haWwvbGludXgtbnZtZS8yMDIwLU1heS8wMzA1MTIuaHRtbAo+Pgo+PiBXaXRoIFNh
Z2kncyBwYXRjaCBiZWxvdywgSSBkbyBzZWUgYWZ0ZXIgbnZtZXRfYWRkX2FzeW5jX2V2ZW50KCks
Cj4+IG52bWV0X2FzeW5jX2V2ZW50c19wcm9jZXNzIHB1bGxzIHRoZSByZXF1ZXN0LCBkZWNyZW1l
bnRzCj4+IGN0cmwtPm5yX2FzeW5jX2V2ZW50X2NtZHMgdG8gMCwgYW5kIGZyZWVzIHRoZSBhZW4s
Cj4+IGFuZCBubyBtZW1vcnkgbGVhay4KPj4KPj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
cGlwZXJtYWlsL2xpbnV4LW52bWUvMjAyMC1NYXkvMDMwNTQ4Lmh0bWwKPiAKPiBJIGRvbid0IHRo
aW5rIHRoYXQgcGF0Y2ggIzEgaXMgcmVxdWlyZWQgdG8gZml4IHRoZSBpc3N1ZSwgY2FuIHlvdQo+
IGNvbmZpcm0gdGhhdD8gQ2hyaXN0b3BoIHNhaWQgaGUgaGFzIHNvbWUgbW9yZSBjbGVhbmluZyB1
cCBpbiB0aGlzCj4gYXJlYS4KClllcywgdGhhdCBpcyBjb3JyZWN0LCB3aGVuIEkgdGVzdGVkIHlv
dXIgY2hhbmdlIEkgZGlkIG5vdCBhcHBseQpwYXRjaCAxLgoKVGhhbmtzLApEYXZpZAoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFp
bGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
