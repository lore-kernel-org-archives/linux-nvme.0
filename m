Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2075C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 09:25:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 644E620855
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 09:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="z4sEQD/X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PN8z7gRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644E620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ts7l5MaFiNkFIvBAE0Z8tFHwiT4OU+xpzac/psmYsts=; b=z4sEQD/XjTOiQngCR3GGn+3ve
	WEhvDTaBd1Gn+MW/AVvTij0ZuSEkQjkSBBV8eh0paRpEd14uKLel6NDr5uRca+fAQVs3naJ+xhohk
	Weo37W6rXop4/9EIKCEai1c+wyomEZf4EeEeB+pdv/AwOzlh7z0hp5poRTCZdMkGXBmBGKNqTalw5
	29typYVXo7sNkrCZ4N69/2iwBaiv2OvVtpFORJMDUxdVlxvjp9Pp40Skw9F/azQJyLAPWjY/Sin+c
	gDNIq/nPhYzdhKyRzxuo5IWgK+F8T85tyeEtgbt3gh50U4AF8Cy/yD6TVmRhfbUhzpeRPwbbJFNcT
	rzwWlMP6g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3ycr-0002QY-BU; Fri, 07 Aug 2020 09:25:21 +0000
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3yco-0002QA-3W
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 09:25:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596792317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5zNghwZyDwNMJFv9scQbFvX4Q5eB7i0ZQE3vtTwERyw=;
 b=PN8z7gRDuqdOiIjzSoe+nG8IgWJUo5PFsylc0B+hYVFhJSo7/B/q90w/GE/TTXTekx/Z4I
 xmpzLUTSlk3RMQGdmKYsHEtswrYhLLLwvcJf60VND+y/hkc9DeVyvkulP4m0FuBUbzA/Ox
 7YBK55iM2IqMtwq96Ypb7Yd71oLS1CQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-6DgKfVeOMj2xYj1wbWQ_LA-1; Fri, 07 Aug 2020 05:25:13 -0400
X-MC-Unique: 6DgKfVeOMj2xYj1wbWQ_LA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 858C379EC0;
 Fri,  7 Aug 2020 09:25:11 +0000 (UTC)
Received: from T590 (ovpn-13-53.pek2.redhat.com [10.72.13.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 193A887A6D;
 Fri,  7 Aug 2020 09:25:01 +0000 (UTC)
Date: Fri, 7 Aug 2020 17:24:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20200807092457.GA2112310@T590>
References: <20200728071859.GA21629@lst.de> <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
 <20200728135436.GP9247@paulmck-ThinkPad-P72>
 <d1ba2009-130a-d423-1389-c7af72e25a6a@grimberg.me>
 <20200729003124.GT9247@paulmck-ThinkPad-P72>
 <07c90cf1-bb6f-a343-b0bf-4c91b9acb431@grimberg.me>
 <20200729005942.GA2729664@dhcp-10-100-145-180.wdl.wdc.com>
 <2f17c8ed-99f6-c71c-edd1-fd96481f432c@grimberg.me>
 <31a9ba72-1322-4b7c-fb73-db0cb52989da@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <31a9ba72-1322-4b7c-fb73-db0cb52989da@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_052518_215645_56CB3926 
X-CRM114-Status: GOOD (  28.37  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 paulmck@kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Ming Lin <mlin@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBBdWcgMDcsIDIwMjAgYXQgMDU6MDQ6MzhQTSArMDgwMCwgQ2hhbyBMZW5nIHdyb3Rl
Ogo+IAo+IAo+IE9uIDIwMjAvNy8yOSAxMjozOSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiA+IAo+
ID4gPiA+ID4gPiBEeW5hbWljYWxseSBhbGxvY2F0aW5nIGVhY2ggb25lIGlzIHBvc3NpYmxlIGJ1
dCBub3QgdmVyeSBzY2FsYWJsZS4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IFRoZSBxdWVzdGlv
biBpcyBpZiB0aGVyZSBpcyBzb21lIHdheSwgd2UgY2FuIGRvIHRoaXMgd2l0aCBvbi1zdGFjawo+
ID4gPiA+ID4gPiBvciBhIHNpbmdsZSBvbi1oZWFwIHJjdV9oZWFkIG9yIGVxdWl2YWxlbnQgdGhh
dCBjYW4gYWNoaWV2ZSB0aGUgc2FtZQo+ID4gPiA+ID4gPiBlZmZlY3QuCj4gPiA+ID4gPiAKPiA+
ID4gPiA+IElmIHRoZSBoY3R4IHN0cnVjdHVyZXMgYXJlIGd1YXJhbnRlZWQgdG8gc3RheSBwdXQs
IHlvdSBjb3VsZCBjb3VudAo+ID4gPiA+ID4gdGhlbSBhbmQgdGhlbiBkbyBhIHNpbmdsZSBhbGxv
Y2F0aW9uIG9mIGFuIGFycmF5IG9mIHJjdV9oZWFkIHN0cnVjdHVyZXMKPiA+ID4gPiA+IChvciBz
b21lIGxhcmdlciBzdHJ1Y3R1cmUgY29udGFpbmluZyBhbiByY3VfaGVhZCBzdHJ1Y3R1cmUsIGlm
IG5lZWRlZCkuCj4gPiA+ID4gPiBZb3UgY291bGQgdGhlbiBzZXF1ZW5jZSB0aHJvdWdoIHRoaXMg
YXJyYXksIGNvbnN1bWluZyBvbmUgcmN1X2hlYWQgcGVyCj4gPiA+ID4gPiBoY3R4IGFzIHlvdSBw
cm9jZXNzZWQgaXQuwqAgT25jZSBhbGwgdGhlIGNhbGxiYWNrcyBoYWQgYmVlbiBpbnZva2VkLAo+
ID4gPiA+ID4gaXQgd291bGQgYmUgc2FmZSB0byBmcmVlIHRoZSBhcnJheS4KPiA+ID4gPiA+IAo+
ID4gPiA+ID4gU291bmRzIHRvbyBzaW1wbGUsIHRob3VnaC7CoCBTbyB3aGF0IGFtIEkgbWlzc2lu
Zz8KPiA+ID4gPiAKPiA+ID4gPiBXZSBkb24ndCB3YW50IGhpZ2hlci1vcmRlciBhbGxvY2F0aW9u
cy4uLgo+ID4gPiAKPiA+ID4gU286Cj4gPiA+IAo+ID4gPiDCoMKgICgxKSBXZSBkb24ndCB3YW50
IHRvIGVtYmVkIHRoZSBzdHJ1Y3QgaW4gdGhlIGhjdHggYmVjYXVzZSB3ZSBhbGxvY2F0ZQo+ID4g
PiDCoMKgIHNvIG1hbnkgb2YgdGhlbSB0aGF0IHRoaXMgaXMgbm9uLW5lZ2xpZ2FibGUgdG8gYWRk
IGZvciBzb21ldGhpbmcgd2UKPiA+ID4gwqDCoCB0eXBpY2FsbHkgbmV2ZXIgdXNlLgo+ID4gPiAK
PiA+ID4gwqDCoCAoMikgV2UgZG9uJ3Qgd2FudCB0byBhbGxvY2F0ZSBkeW5hbWljYWxseSBiZWNh
dXNlIGl0J3MgcG90ZW50aWFsbHkKPiA+ID4gwqDCoCBodWdlLgo+ID4gPiAKPiA+ID4gQXMgbG9u
ZyBhcyB3ZSdyZSB1c2luZyBzcmN1IGZvciBibG9ja2luZyBoY3R4J3MsIEkgdGhpbmsgaXQncyAi
cGljayB5b3VyCj4gPiA+IHBvaXNvbiIuCj4gPiA+IAo+ID4gPiBBbHRlcm5hdGl2ZWx5LCBNaW5n
J3MgcGVyY3B1X3JlZiBwYXRjaCgqKSBtYXkgYmUgd29ydGggYSBsb29rLgo+ID4gPiAKPiA+ID4g
wqAgKiBodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC1ibG9jay9tc2c1Njk3Ni5o
dG1sMQo+ID4gSSdtIG5vdCBvcHBvc2VkIHRvIGhhdmluZyB0aGlzLiBXaWxsIHJlcXVpcmUgc29t
ZSBtb3JlIHRlc3RpbmcKPiA+IGFzIHRoaXMgYWZmZWN0cyBwcmV0dHkgbXVjaCBldmVyeSBkcml2
ZXIgb3V0IHRoZXJlLi4KPiA+IAo+ID4gSWYgd2UgYXJlIGdvaW5nIHdpdGggYSBsaWdodHdlaWdo
dCBwZXJjcHVfcmVmLCBjYW4gd2UganVzdCBkbwo+ID4gaXQgYWxzbyBmb3Igbm9uLWJsb2NraW5n
IGhjdHggYW5kIGhhdmUgYSBzaW5nbGUgY29kZS1wYXRoPwo+ID4gLgo+IEkgdHJpZWQgdG8gb3B0
aW1pemUgdGhlIHBhdGNo77yMc3VwcG9ydCBmb3Igbm9uIGJsb2NraW5nIHF1ZXVlIGFuZAo+IGJs
b2NraW5nIHF1ZXVlLgo+IFNlZSBuZXh0IGVtYWlsLgoKUGxlYXNlIHNlZSB0aGUgZm9sbG93aW5n
IHRocmVhZDoKCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJsb2NrLzA1Zjc1ZTg5LWI2
ZjctZGU0OS1lYjlmLWEwOGFhNGUwYmE0ZkBrZXJuZWwuZGsvCgpCb3RoIEtlaXRoIGFuZCBKZW5z
IGRpZG4ndCB0aGluayBpdCBpcyBhIGdvb2QgaWRlYS4KCgoKVGhhbmtzLApNaW5nCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWls
aW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
