Return-Path: <SRS0=k+Rq=MI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDDEC07E95
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 10:42:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E4F2613C0
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 10:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4F2613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6bwIVmr1OBVKHoa0Oc2sc4VWK4C8Ggluv/uDLFaZebY=; b=BupEFHVj7gsy0J
	4w9TnHTpSyXJtLRpwhs20i0AXYoYzTz/r/aPGdpIUAgVNYGEdbcf78AOAiv1wEHdwYCqa9Ngj4y17
	FG14rqVXenUE9ifTtj+RT4OObGvTAcKzem75BvuI5KcjS3Trk/KrEUTHGyBlf3BFs71BuexVOvaja
	fJwCcnJmxakOPjhVO5FrFtapfRXtNwzwwM2PfXPdgdtbfyWA8IADVOqZ92VkCS4ApixyIPuomRhcr
	sbfv4UX4VgjgpK5/hmP3DZIo7BobSyC41hcAe+n+0x3g9s2Tle/wSjDNETUFWXgJzoAw7mhvToHpe
	dcNCeRXPlk9178ML2+gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4LIR-004Af0-L5; Fri, 16 Jul 2021 10:42:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4LIO-004AcO-0s
 for linux-nvme@lists.infradead.org; Fri, 16 Jul 2021 10:42:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626432134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eYv2Aol5Hptlza4XzCigRKb4M7GsMoM5cZVrcTu70PQ=;
 b=KONg+0p7EcGvEiIo25z6zIUXusijP0poCUQqudf+C2NO2jJJX/RarejFXny03oqXVSGo6P
 B7brB2NzVnnoZ0obyC+bNwIesE0suTTmdHydxPi9Osp9ZfH6ru+LFue8tZcC1Lb1yRT8N1
 5h5XZMdKLSqU/klshKSn7T9W+HFMOps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-cY1zEBD4NcGFDboNVED5bw-1; Fri, 16 Jul 2021 06:42:13 -0400
X-MC-Unique: cY1zEBD4NcGFDboNVED5bw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44CFC8030B5;
 Fri, 16 Jul 2021 10:42:11 +0000 (UTC)
Received: from T590 (ovpn-12-46.pek2.redhat.com [10.72.12.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 622B6752A0;
 Fri, 16 Jul 2021 10:41:57 +0000 (UTC)
Date: Fri, 16 Jul 2021 18:41:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, David Jeffery <djeffery@redhat.com>,
 Laurence Oberman <loberman@redhat.com>,
 Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
 Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: New warning in nvme_setup_discard
Message-ID: <YPFicCW90Jse4oms@T590>
References: <4729812.CpyZKHjjVO@natalenko.name>
 <81322754.HEIg0oD171@natalenko.name> <YPFSUfG+fMITAH01@T590>
 <2455133.St5lIfLNcX@natalenko.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2455133.St5lIfLNcX@natalenko.name>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210716_034216_201882_0919F473 
X-CRM114-Status: GOOD (  28.46  )
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

T24gRnJpLCBKdWwgMTYsIDIwMjEgYXQgMTI6MDM6NDNQTSArMDIwMCwgT2xla3NhbmRyIE5hdGFs
ZW5rbyB3cm90ZToKPiBIZWxsby4KPiAKPiBPbiBww6F0ZWsgMTYuIMSNZXJ2ZW5jZSAyMDIxIDEx
OjMzOjA1IENFU1QgTWluZyBMZWkgd3JvdGU6Cj4gPiBDYW4geW91IHRlc3QgdGhlIGZvbGxvd2lu
ZyBwYXRjaD8KPiAKPiBTdXJlLCBidWlsZGluZyBpdCBhdCB0aGUgbW9tZW50LCBhbmQgd2lsbCBn
aXZlIGl0IGEgdHJ5LiBBbHNvIHBsZWFzZSBzZWUgbXkgCj4gY29tbWVudHMgYW5kIHF1ZXN0aW9u
cyBiZWxvdy4KPiAKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2Jsb2NrL2JmcS1pb3NjaGVkLmMgYi9i
bG9jay9iZnEtaW9zY2hlZC5jCj4gPiBpbmRleCA3Mjc5NTU5MTg1NjMuLjY3M2E2MzRlYWRkOSAx
MDA2NDQKPiA+IC0tLSBhL2Jsb2NrL2JmcS1pb3NjaGVkLmMKPiA+ICsrKyBiL2Jsb2NrL2JmcS1p
b3NjaGVkLmMKPiA+IEBAIC0yMzYxLDYgKzIzNjEsOSBAQCBzdGF0aWMgaW50IGJmcV9yZXF1ZXN0
X21lcmdlKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxLAo+ID4gc3RydWN0IHJlcXVlc3QgKipyZXEs
IF9fcnEgPSBiZnFfZmluZF9ycV9mbWVyZ2UoYmZxZCwgYmlvLCBxKTsKPiA+ICAJaWYgKF9fcnEg
JiYgZWx2X2Jpb19tZXJnZV9vayhfX3JxLCBiaW8pKSB7Cj4gPiAgCQkqcmVxID0gX19ycTsKPiA+
ICsKPiA+ICsJCWlmIChibGtfZGlzY2FyZF9tZXJnYWJsZShfX3JxKSkKPiA+ICsJCQlyZXR1cm4g
RUxFVkFUT1JfRElTQ0FSRF9NRVJHRTsKPiA+ICAJCXJldHVybiBFTEVWQVRPUl9GUk9OVF9NRVJH
RTsKPiA+ICAJfQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvYmxvY2svYmxrLW1lcmdlLmMgYi9ibG9j
ay9ibGstbWVyZ2UuYwo+ID4gaW5kZXggYTExYjNiNTM3MTdlLi5mODcwN2ZmN2UyZmMgMTAwNjQ0
Cj4gPiAtLS0gYS9ibG9jay9ibGstbWVyZ2UuYwo+ID4gKysrIGIvYmxvY2svYmxrLW1lcmdlLmMK
PiA+IEBAIC03MDUsMjIgKzcwNSw2IEBAIHN0YXRpYyB2b2lkIGJsa19hY2NvdW50X2lvX21lcmdl
X3JlcXVlc3Qoc3RydWN0IHJlcXVlc3QKPiA+ICpyZXEpIH0KPiA+ICB9Cj4gPiAKPiA+IC0vKgo+
ID4gLSAqIFR3byBjYXNlcyBvZiBoYW5kbGluZyBESVNDQVJEIG1lcmdlOgo+ID4gLSAqIElmIG1h
eF9kaXNjYXJkX3NlZ21lbnRzID4gMSwgdGhlIGRyaXZlciB0YWtlcyBldmVyeSBiaW8KPiA+IC0g
KiBhcyBhIHJhbmdlIGFuZCBzZW5kIHRoZW0gdG8gY29udHJvbGxlciB0b2dldGhlci4gVGhlIHJh
bmdlcwo+ID4gLSAqIG5lZWRuJ3QgdG8gYmUgY29udGlndW91cy4KPiA+IC0gKiBPdGhlcndpc2Us
IHRoZSBiaW9zL3JlcXVlc3RzIHdpbGwgYmUgaGFuZGxlZCBhcyBzYW1lIGFzCj4gPiAtICogb3Ro
ZXJzIHdoaWNoIHNob3VsZCBiZSBjb250aWd1b3VzLgo+ID4gLSAqLwo+ID4gLXN0YXRpYyBpbmxp
bmUgYm9vbCBibGtfZGlzY2FyZF9tZXJnYWJsZShzdHJ1Y3QgcmVxdWVzdCAqcmVxKQo+ID4gLXsK
PiA+IC0JaWYgKHJlcV9vcChyZXEpID09IFJFUV9PUF9ESVNDQVJEICYmCj4gPiAtCSAgICBxdWV1
ZV9tYXhfZGlzY2FyZF9zZWdtZW50cyhyZXEtPnEpID4gMSkKPiA+IC0JCXJldHVybiB0cnVlOwo+
ID4gLQlyZXR1cm4gZmFsc2U7Cj4gPiAtfQo+ID4gLQo+ID4gIHN0YXRpYyBlbnVtIGVsdl9tZXJn
ZSBibGtfdHJ5X3JlcV9tZXJnZShzdHJ1Y3QgcmVxdWVzdCAqcmVxLAo+ID4gIAkJCQkJc3RydWN0
IHJlcXVlc3QgKm5leHQpCj4gPiAgewo+ID4gZGlmZiAtLWdpdCBhL2Jsb2NrL2VsZXZhdG9yLmMg
Yi9ibG9jay9lbGV2YXRvci5jCj4gPiBpbmRleCA1MmFkYTE0Y2ZlNDUuLmE1ZmUyNjE1ZWMwZiAx
MDA2NDQKPiA+IC0tLSBhL2Jsb2NrL2VsZXZhdG9yLmMKPiA+ICsrKyBiL2Jsb2NrL2VsZXZhdG9y
LmMKPiA+IEBAIC0zMzYsNiArMzM2LDkgQEAgZW51bSBlbHZfbWVyZ2UgZWx2X21lcmdlKHN0cnVj
dCByZXF1ZXN0X3F1ZXVlICpxLCBzdHJ1Y3QKPiA+IHJlcXVlc3QgKipyZXEsIF9fcnEgPSBlbHZf
cnFoYXNoX2ZpbmQocSwgYmlvLT5iaV9pdGVyLmJpX3NlY3Rvcik7Cj4gPiAgCWlmIChfX3JxICYm
IGVsdl9iaW9fbWVyZ2Vfb2soX19ycSwgYmlvKSkgewo+ID4gIAkJKnJlcSA9IF9fcnE7Cj4gPiAr
Cj4gPiArCQlpZiAoYmxrX2Rpc2NhcmRfbWVyZ2FibGUoX19ycSkpCj4gPiArCQkJcmV0dXJuIEVM
RVZBVE9SX0RJU0NBUkRfTUVSR0U7Cj4gPiAgCQlyZXR1cm4gRUxFVkFUT1JfQkFDS19NRVJHRTsK
PiA+ICAJfQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvYmxvY2svbXEtZGVhZGxpbmUtbWFpbi5jIGIv
YmxvY2svbXEtZGVhZGxpbmUtbWFpbi5jCj4gPiBpbmRleCA2ZjYxMmU2ZGM4MmIuLjI5NGJlMGMw
ZGI2NSAxMDA2NDQKPiA+IC0tLSBhL2Jsb2NrL21xLWRlYWRsaW5lLW1haW4uYwo+ID4gKysrIGIv
YmxvY2svbXEtZGVhZGxpbmUtbWFpbi5jCj4gCj4gSSBoYWQgdG8gYWRqdXN0IHRoaXMgYWdhaW5z
dCB2NS4xMyBiZWNhdXNlIHRoZXJlJ3Mgbm8gbXEtZGVhZGxpbmUtbWFpbi5jLCBvbmx5IAo+IG1x
LWRlYWRsaW5lLmMgKGR1ZSB0byBCYXJ0IHNlcmllcywgSSBhc3N1bWUpLiBJIGhvcGUgdGhpcyBp
cyBmaW5lIGFzIHRoZSBwYXRjaCAKPiBhcHBsaWVzIGNsZWFubHkuCj4gCj4gPiBAQCAtNjc3LDYg
KzY3Nyw4IEBAIHN0YXRpYyBpbnQgZGRfcmVxdWVzdF9tZXJnZShzdHJ1Y3QgcmVxdWVzdF9xdWV1
ZSAqcSwKPiA+IHN0cnVjdCByZXF1ZXN0ICoqcnEsCj4gPiAKPiA+ICAJCWlmIChlbHZfYmlvX21l
cmdlX29rKF9fcnEsIGJpbykpIHsKPiA+ICAJCQkqcnEgPSBfX3JxOwo+ID4gKwkJCWlmIChibGtf
ZGlzY2FyZF9tZXJnYWJsZShfX3JxKSkKPiA+ICsJCQkJcmV0dXJuIEVMRVZBVE9SX0RJU0NBUkRf
TUVSR0U7Cj4gPiAgCQkJcmV0dXJuIEVMRVZBVE9SX0ZST05UX01FUkdFOwo+ID4gIAkJfQo+ID4g
IAl9Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9ibGtkZXYuaCBiL2luY2x1ZGUvbGlu
dXgvYmxrZGV2LmgKPiA+IGluZGV4IDMxNzcxODFjNDMyNi4uODdmMDAyOTJmZDdhIDEwMDY0NAo+
ID4gLS0tIGEvaW5jbHVkZS9saW51eC9ibGtkZXYuaAo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9i
bGtkZXYuaAo+ID4gQEAgLTE1MjEsNiArMTUyMSwyMiBAQCBzdGF0aWMgaW5saW5lIGludAo+ID4g
cXVldWVfbGltaXRfZGlzY2FyZF9hbGlnbm1lbnQoc3RydWN0IHF1ZXVlX2xpbWl0cyAqbGltLCBz
ZWN0b3IgcmV0dXJuCj4gPiBvZmZzZXQgPDwgU0VDVE9SX1NISUZUOwo+ID4gIH0KPiA+IAo+ID4g
Ky8qCj4gPiArICogVHdvIGNhc2VzIG9mIGhhbmRsaW5nIERJU0NBUkQgbWVyZ2U6Cj4gPiArICog
SWYgbWF4X2Rpc2NhcmRfc2VnbWVudHMgPiAxLCB0aGUgZHJpdmVyIHRha2VzIGV2ZXJ5IGJpbwo+
ID4gKyAqIGFzIGEgcmFuZ2UgYW5kIHNlbmQgdGhlbSB0byBjb250cm9sbGVyIHRvZ2V0aGVyLiBU
aGUgcmFuZ2VzCj4gPiArICogbmVlZG4ndCB0byBiZSBjb250aWd1b3VzLgo+ID4gKyAqIE90aGVy
d2lzZSwgdGhlIGJpb3MvcmVxdWVzdHMgd2lsbCBiZSBoYW5kbGVkIGFzIHNhbWUgYXMKPiA+ICsg
KiBvdGhlcnMgd2hpY2ggc2hvdWxkIGJlIGNvbnRpZ3VvdXMuCj4gPiArICovCj4gPiArc3RhdGlj
IGlubGluZSBib29sIGJsa19kaXNjYXJkX21lcmdhYmxlKHN0cnVjdCByZXF1ZXN0ICpyZXEpCj4g
PiArewo+ID4gKwlpZiAocmVxX29wKHJlcSkgPT0gUkVRX09QX0RJU0NBUkQgJiYKPiA+ICsJICAg
IHF1ZXVlX21heF9kaXNjYXJkX3NlZ21lbnRzKHJlcS0+cSkgPiAxKQo+ID4gKwkJcmV0dXJuIHRy
dWU7Cj4gPiArCXJldHVybiBmYWxzZTsKPiA+ICt9Cj4gPiArCj4gPiAgc3RhdGljIGlubGluZSBp
bnQgYmRldl9kaXNjYXJkX2FsaWdubWVudChzdHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2KQo+ID4g
IHsKPiA+ICAJc3RydWN0IHJlcXVlc3RfcXVldWUgKnEgPSBiZGV2X2dldF9xdWV1ZShiZGV2KTsK
PiAKPiBEbyBJIHVuZGVyc3RhbmQgY29ycmVjdGx5IHRoYXQgdGhpcyB3aWxsIGJlIHNvbWV0aGlu
ZyBsaWtlOgo+IAo+IEZpeGVzOiAyNzA1ZGZiMjA5ICgiYmxvY2s6IGZpeCBkaXNjYXJkIHJlcXVl
c3QgbWVyZ2UiKQo+IAo+ID8KPiAKPiBCZWNhdXNlIGFzIHRoZSBiaXNlY3Rpb24gcHJvZ3Jlc3Nl
cywgSSd2ZSBidW1wZWQgaW50byB0aGlzIGNvbW1pdCBvbmx5LiAKPiBXaXRob3V0IGl0IHRoZSBp
c3N1ZSBpcyBub3QgcmVwcm9kdWNpYmxlLCBhdCBsZWFzdCBzbyBmYXIuCgpJdCBjb3VsZCBiZS4K
ClNvIGNhbiB5b3UganVzdCB0ZXN0IHY1LjE0LXJjMT8KCgpUaGFua3MsCk1pbmcKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
