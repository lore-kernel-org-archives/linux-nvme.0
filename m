Return-Path: <SRS0=TgIa=3N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AC5C35242
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2020 14:30:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD50C2077C
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2020 14:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UJirfn71";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arrikto-com.20150623.gappssmtp.com header.i=@arrikto-com.20150623.gappssmtp.com header.b="TbF89NBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD50C2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arrikto.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Mla5HqR1PirYXCW3QBsFC/Tlt5FJt/g3jBqzR1P8BP0=; b=UJirfn71iNH4W957mdi0jR4KM
	p2Y+B8dL54vsK2CC0dQ4McNR+8Cn9PNI+Bk/pg99WG9vt8et3fZw5x7L00d16kxFv4G0NFOrua2Ue
	YNwFT5yqAnkXV18l/EDryk2MT6wTMXsmxvSLqzD4/abpNn4TDcJZe+NTPg1u6NTgDbwIN3DsIvlVb
	+ovNbGBrTWtMoFUPJEqeGg2sR4AWSctI2RJk8mFdTuuh2CwgIZiHjqF24PHrzaPttAfYeW1oCWcVn
	1yt0LMNktGDtKVfU/RjbQV3ACNIW0k5msC5FkB2PE0JuGyGJSdZSALVvTbe3+HFamA1x1rrb13g2Z
	KNVCn7vxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iuzyw-0007RJ-Hp; Fri, 24 Jan 2020 14:30:46 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iuzrs-0005zM-8x
 for linux-nvme@lists.infradead.org; Fri, 24 Jan 2020 14:23:31 +0000
Received: by mail-lf1-x143.google.com with SMTP id m30so1227249lfp.8
 for <linux-nvme@lists.infradead.org>; Fri, 24 Jan 2020 06:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrikto-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=M7Z8KguGyGrtLfBMqY4wl99vU+N7ApmZw1y+IbjQEx0=;
 b=TbF89NBrPPtjbS1P/FwyWSe2nucdwaM3kEujRt5kLsRMVFROqH9NQRxQmABrsIhhPp
 SpB7JmLw4eAdnKL6c7VYyEeRZwIoNchwIliPsTOznaUpWABB6caAUy5145uw/iclv6UM
 h0Spd29IN39wMT+jIr6fp8x5MZa4fNiZTMk/X5pgfPoGL/sxmENh4rZn0ilVb/G1V4iT
 6+UEglC+0uEu9gFgBXevCz89sUnlWTu9BOUDS3jIq7sBahbQgkCFQV3vN7u+avzs/3dq
 PvGIGn5GcGEKrYWzcJl6s3CDEC2MR6aZkwhyWfz+h/wvmyFiNETQ6v53gyBnIdPFEND/
 2ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M7Z8KguGyGrtLfBMqY4wl99vU+N7ApmZw1y+IbjQEx0=;
 b=LaR2SAGj3E7YHaVexhxbZwyyBkhCqCr6NU2m78NbYnX2XJbQapQEWqkomdQq4aSHq7
 qeVMbtVmzPBHXcLeeHS4M03DQdCCS1+fiZ0X1knk4290AoUkGY1zeHrRMuilKHASrOkN
 DHGCXbu0Ws6YqUWydrYDnKKgWH0Awvhlo+0nxlqoEliOfBts0bI09dRLdaOYFsSgJb7E
 5LVrsHwlRcLirZ3biqId6LBwIKTt3xR0BA3WhUcqnT4db37M0XJ8SD8aXZWvLU8eSVJC
 SjJWrWKvUfjQPuk/jJECK+GEPy169EPyzkdWl1cf1fMkX1ac0flR80TW5xY2vZbMKAoj
 IX3w==
X-Gm-Message-State: APjAAAURYYUNdt02TQJzEt1Ex9WdqkyBtHbq9cTpeixoxFUISrlm7/mg
 nCbUHlTsJFbL77M1vi+bUWtKyw==
X-Google-Smtp-Source: APXvYqxYFxC8cAjCsNefWipfW5e+yY7MTZfna3SxpxHUdRcvEVbmwtNUP/9O6SCBCuYG19sj+hF7LQ==
X-Received: by 2002:ac2:5388:: with SMTP id g8mr1495011lfh.43.1579875801941;
 Fri, 24 Jan 2020 06:23:21 -0800 (PST)
Received: from [10.94.250.133] ([31.177.62.212])
 by smtp.gmail.com with ESMTPSA id r21sm3158951ljn.64.2020.01.24.06.23.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 06:23:21 -0800 (PST)
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
References: <BYAPR04MB5749820C322B40C7DBBBCA02863F0@BYAPR04MB5749.namprd04.prod.outlook.com>
From: Nikos Tsironis <ntsironis@arrikto.com>
Message-ID: <e67bf36e-18cb-a170-39ad-a1081fae5e50@arrikto.com>
Date: Fri, 24 Jan 2020 16:23:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5749820C322B40C7DBBBCA02863F0@BYAPR04MB5749.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200124_062328_355532_9E8CB350 
X-CRM114-Status: GOOD (  25.62  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "msnitzer@redhat.com" <msnitzer@redhat.com>,
 "bvanassche@acm.org" <bvanassche@acm.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>, Stephen Bates <sbates@raithlin.com>,
 "roland@purestorage.com" <roland@purestorage.com>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>, "hare@suse.de" <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, "rwheeler@redhat.com" <rwheeler@redhat.com>,
 Christoph Hellwig <hch@lst.de>,
 "frederick.knight@netapp.com" <frederick.knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS83LzIwIDg6MTQgUE0sIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToKPiBIaSBhbGwsCj4g
Cj4gKiBCYWNrZ3JvdW5kIDotCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAKPiBDb3B5IG9mZmxvYWQgaXMg
YSBmZWF0dXJlIHRoYXQgYWxsb3dzIGZpbGUtc3lzdGVtcyBvciBzdG9yYWdlIGRldmljZXMKPiB0
byBiZSBpbnN0cnVjdGVkIHRvIGNvcHkgZmlsZXMvbG9naWNhbCBibG9ja3Mgd2l0aG91dCByZXF1
aXJpbmcKPiBpbnZvbHZlbWVudCBvZiB0aGUgbG9jYWwgQ1BVLgo+IAo+IFdpdGggcmVmZXJlbmNl
IHRvIHRoZSBSSVNDLVYgc3VtbWl0IGtleW5vdGUgWzFdIHNpbmdsZSB0aHJlYWRlZAo+IHBlcmZv
cm1hbmNlIGlzIGxpbWl0aW5nIGR1ZSB0byBEZW5hcmQgc2NhbGluZyBhbmQgbXVsdGktdGhyZWFk
ZWQKPiBwZXJmb3JtYW5jZSBpcyBzbG93aW5nIGRvd24gZHVlIE1vb3JlJ3MgbGF3IGxpbWl0YXRp
b25zLiBXaXRoIHRoZSByaXNlCj4gb2YgU05JQSBDb21wdXRhdGlvbiBUZWNobmljYWwgU3RvcmFn
ZSBXb3JraW5nIEdyb3VwIChUV0cpIFsyXSwKPiBvZmZsb2FkaW5nIGNvbXB1dGF0aW9ucyB0byB0
aGUgZGV2aWNlIG9yIG92ZXIgdGhlIGZhYnJpY3MgaXMgYmVjb21pbmcKPiBwb3B1bGFyIGFzIHRo
ZXJlIGFyZSBzZXZlcmFsIHNvbHV0aW9ucyBhdmFpbGFibGUgWzJdLiBPbmUgb2YgdGhlIGNvbW1v
bgo+IG9wZXJhdGlvbiB3aGljaCBpcyBwb3B1bGFyIGluIHRoZSBrZXJuZWwgYW5kIGlzIG5vdCBt
ZXJnZWQgeWV0IGlzIENvcHkKPiBvZmZsb2FkIG92ZXIgdGhlIGZhYnJpY3Mgb3Igb24gdG8gdGhl
IGRldmljZS4KPiAKPiAqIFByb2JsZW0gOi0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+IAo+IFRoZSBvcmln
aW5hbCB3b3JrIHdoaWNoIGlzIGRvbmUgYnkgTWFydGluIGlzIHByZXNlbnQgaGVyZSBbM10uIFRo
ZQo+IGxhdGVzdCB3b3JrIHdoaWNoIGlzIHBvc3RlZCBieSBNaWt1bGFzIFs0XSBpcyBub3QgbWVy
Z2VkIHlldC4gVGhlc2UgdHdvCj4gYXBwcm9hY2hlcyBhcmUgdG90YWxseSBkaWZmZXJlbnQgZnJv
bSBlYWNoIG90aGVyLiBTZXZlcmFsIHN0b3JhZ2UKPiB2ZW5kb3JzIGRpc2NvdXJhZ2UgbWl4aW5n
IGNvcHkgb2ZmbG9hZCByZXF1ZXN0cyB3aXRoIHJlZ3VsYXIgUkVBRC9XUklURQo+IEkvTy4gQWxz
bywgdGhlIGZhY3QgdGhhdCB0aGUgb3BlcmF0aW9uIGZhaWxzIGlmIGEgY29weSByZXF1ZXN0IGV2
ZXIKPiBuZWVkcyB0byBiZSBzcGxpdCBhcyBpdCB0cmF2ZXJzZXMgdGhlIHN0YWNrIGl0IGhhcyB0
aGUgdW5mb3J0dW5hdGUKPiBzaWRlLWVmZmVjdCBvZiBwcmV2ZW50aW5nIGNvcHkgb2ZmbG9hZCBm
cm9tIHdvcmtpbmcgaW4gcHJldHR5IG11Y2gKPiBldmVyeSBjb21tb24gZGVwbG95bWVudCBjb25m
aWd1cmF0aW9uIG91dCB0aGVyZS4KPiAKPiAqIEN1cnJlbnQgc3RhdGUgb2YgdGhlIHdvcmsgOi0K
PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQo+IAo+IFdpdGggWzNdIGJlaW5nIGhhcmQgdG8gaGFuZGxlIGFyYml0
cmFyeSBETS9NRCBzdGFja2luZyB3aXRob3V0Cj4gc3BsaXR0aW5nIHRoZSBjb21tYW5kIGluIHR3
bywgb25lIGZvciBjb3B5aW5nIElOIGFuZCBvbmUgZm9yIGNvcHlpbmcKPiBPVVQuIFdoaWNoIGlz
IHRoZW4gZGVtb25zdHJhdGVkIGJ5IHRoZSBbNF0gd2h5IFszXSBpdCBpcyBub3QgYSBzdWl0YWJs
ZQo+IGNhbmRpZGF0ZS4gQWxzbywgd2l0aCBbNF0gdGhlcmUgaXMgYW4gdW5yZXNvbHZlZCBwcm9i
bGVtIHdpdGggdGhlCj4gdHdvLWNvbW1hbmQgYXBwcm9hY2ggYWJvdXQgaG93IHRvIGhhbmRsZSBj
aGFuZ2VzIHRvIHRoZSBETSBsYXlvdXQKPiBiZXR3ZWVuIGFuIElOIGFuZCBPVVQgb3BlcmF0aW9u
cy4KPiAKPiAqIFdoeSBMaW51eCBLZXJuZWwgU3RvcmFnZSBTeXN0ZW0gbmVlZHMgQ29weSBPZmZs
b2FkIHN1cHBvcnQgbm93ID8KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+IAo+IFdpdGggdGhlIHJpc2Ugb2Yg
dGhlIFNOSUEgQ29tcHV0YXRpb25hbCBTdG9yYWdlIFRXRyBhbmQgc29sdXRpb25zIFsyXSwKPiBl
eGlzdGluZyBTQ1NJIFhDb3B5IHN1cHBvcnQgaW4gdGhlIHByb3RvY29sLCByZWNlbnQgYWR2YW5j
ZW1lbnQgaW4gdGhlCj4gTGludXggS2VybmVsIEZpbGUgU3lzdGVtIGZvciBab25lZCBkZXZpY2Vz
IChab25lZnMgWzVdKSwgUGVlciB0byBQZWVyCj4gRE1BIHN1cHBvcnQgaW4gdGhlIExpbnV4IEtl
cm5lbCBtYWlubHkgZm9yIE5WTWUgZGV2aWNlcyBbN10gYW5kCj4gZXZlbnR1YWxseSBOVk1lIERl
dmljZXMgYW5kIHN1YnN5c3RlbSAoTlZNZSBQQ0llL05WTWVPRikgd2lsbCBiZW5lZml0Cj4gZnJv
bSBDb3B5IG9mZmxvYWQgb3BlcmF0aW9uLgo+IAo+IFdpdGggdGhpcyBiYWNrZ3JvdW5kIHdlIGhh
dmUgc2lnbmlmaWNhbnQgbnVtYmVyIG9mIHVzZS1jYXNlcyB3aGljaCBhcmUKPiBzdHJvbmcgY2Fu
ZGlkYXRlcyB3YWl0aW5nIGZvciBvdXRzdGFuZGluZyBMaW51eCBLZXJuZWwgQmxvY2sgTGF5ZXIg
Q29weQo+IE9mZmxvYWQgc3VwcG9ydCwgc28gdGhhdCBMaW51eCBLZXJuZWwgU3RvcmFnZSBzdWJz
eXN0ZW0gY2FuIHRvIGFkZHJlc3MKPiBwcmV2aW91c2x5IG1lbnRpb25lZCBwcm9ibGVtcyBbMV0g
YW5kIGFsbG93IGVmZmljaWVudCBvZmZsb2FkaW5nIG9mIHRoZQo+IGRhdGEgcmVsYXRlZCBvcGVy
YXRpb25zLiAoU3VjaCBhcyBtb3ZlL2NvcHkgZXRjLikKPiAKPiBGb3IgcmVmZXJlbmNlIGZvbGxv
d2luZyBpcyB0aGUgbGlzdCBvZiB0aGUgdXNlLWNhc2VzL2NhbmRpZGF0ZXMgd2FpdGluZwo+IGZv
ciBDb3B5IE9mZmxvYWQgc3VwcG9ydCA6LQo+IAo+IDEuIFNDU0ktYXR0YWNoZWQgc3RvcmFnZSBh
cnJheXMuCj4gMi4gU3RhY2tpbmcgZHJpdmVycyBzdXBwb3J0aW5nIFhDb3B5IERNL01ELgo+IDMu
IENvbXB1dGF0aW9uYWwgU3RvcmFnZSBzb2x1dGlvbnMuCj4gNy4gRmlsZSBzeXN0ZW1zIDotIExv
Y2FsLCBORlMgYW5kIFpvbmVmcy4KPiA0LiBCbG9jayBkZXZpY2VzIDotIERpc3RyaWJ1dGVkLCBs
b2NhbCwgYW5kIFpvbmVkIGRldmljZXMuCj4gNS4gUGVlciB0byBQZWVyIERNQSBzdXBwb3J0IHNv
bHV0aW9ucy4KPiA2LiBQb3RlbnRpYWxseSBOVk1lIHN1YnN5c3RlbSBib3RoIE5WTWUgUENJZSBh
bmQgTlZNZU9GLgo+IAo+ICogV2hhdCB3ZSB3aWxsIGRpc2N1c3MgaW4gdGhlIHByb3Bvc2VkIHNl
c3Npb24gPwo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gCj4gSSdkIGxpa2UgdG8gcHJvcG9zZSBhIHNlc3Np
b24gdG8gZ28gb3ZlciB0aGlzIHRvcGljIHRvIHVuZGVyc3RhbmQgOi0KPiAKPiAxLiBXaGF0IGFy
ZSB0aGUgYmxvY2tlcnMgZm9yIENvcHkgT2ZmbG9hZCBpbXBsZW1lbnRhdGlvbiA/Cj4gMi4gRGlz
Y3Vzc2lvbiBhYm91dCBoYXZpbmcgYSBmaWxlIHN5c3RlbSBpbnRlcmZhY2UuCj4gMy4gRGlzY3Vz
c2lvbiBhYm91dCBoYXZpbmcgcmlnaHQgc3lzdGVtIGNhbGwgZm9yIHVzZXItc3BhY2UuCj4gNC4g
V2hhdCBpcyB0aGUgcmlnaHQgd2F5IHRvIG1vdmUgdGhpcyB3b3JrIGZvcndhcmQgPwo+IDUuIEhv
dyBjYW4gd2UgaGVscCB0byBjb250cmlidXRlIGFuZCBtb3ZlIHRoaXMgd29yayBmb3J3YXJkID8K
PiAKPiAqIFJlcXVpcmVkIFBhcnRpY2lwYW50cyA6LQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gCj4gSSdk
IGxpa2UgdG8gaW52aXRlIGJsb2NrIGxheWVyLCBkZXZpY2UgZHJpdmVycyBhbmQgZmlsZSBzeXN0
ZW0KPiBkZXZlbG9wZXJzIHRvOi0KPiAKPiAxLiBTaGFyZSB0aGVpciBvcGluaW9uIG9uIHRoZSB0
b3BpYy4KPiAyLiBTaGFyZSB0aGVpciBleHBlcmllbmNlIGFuZCBhbnkgb3RoZXIgaXNzdWVzIHdp
dGggWzRdLgo+IDMuIFVuY292ZXIgYWRkaXRpb25hbCBkZXRhaWxzIHRoYXQgYXJlIG1pc3Npbmcg
ZnJvbSB0aGlzIHByb3Bvc2FsLgo+IAo+IFJlcXVpcmVkIGF0dGVuZGVlcyA6LQo+IAo+IE1hcnRp
biBLLiBQZXRlcnNlbgo+IEplbnMgQXhib2UKPiBDaHJpc3RvcGggSGVsbHdpZwo+IEJhcnQgVmFu
IEFzc2NoZQo+IFN0ZXBoZW4gQmF0ZXMKPiBaYWNoIEJyb3duCj4gUm9sYW5kIERyZWllcgo+IFJp
YyBXaGVlbGVyCj4gVHJvbmQgTXlrbGVidXN0Cj4gTWlrZSBTbml0emVyCj4gS2VpdGggQnVzY2gK
PiBTYWdpIEdyaW1iZXJnCj4gSGFubmVzIFJlaW5lY2tlCj4gRnJlZGVyaWNrIEtuaWdodAo+IE1p
a3VsYXMgUGF0b2NrYQo+IE1hdGlhcyBCasO4cmxpbmcKPiAKPiBbMV1odHRwczovL2NvbnRlbnQu
cmlzY3Yub3JnL3dwLWNvbnRlbnQvdXBsb2Fkcy8yMDE4LzEyL0EtTmV3LUdvbGRlbi1BZ2UtZm9y
LUNvbXB1dGVyLUFyY2hpdGVjdHVyZS1IaXN0b3J5LUNoYWxsZW5nZXMtYW5kLU9wcG9ydHVuaXRp
ZXMtRGF2aWQtUGF0dGVyc29uLS5wZGYKPiBbMl0gaHR0cHM6Ly93d3cuc25pYS5vcmcvY29tcHV0
YXRpb25hbAo+IGh0dHBzOi8vd3d3Lm5hcGF0ZWNoLmNvbS9zdXBwb3J0L3Jlc291cmNlcy9zb2x1
dGlvbi1kZXNjcmlwdGlvbnMvbmFwYXRlY2gtc21hcnRuaWMtc29sdXRpb24tZm9yLWhhcmR3YXJl
LW9mZmxvYWQvCj4gICAgICAgIGh0dHBzOi8vd3d3LmVpZGV0aWNvbS5jb20vcHJvZHVjdHMuaHRt
bAo+IGh0dHBzOi8vd3d3LnhpbGlueC5jb20vYXBwbGljYXRpb25zL2RhdGEtY2VudGVyL2NvbXB1
dGF0aW9uYWwtc3RvcmFnZS5odG1sCj4gWzNdIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC9ta3AvbGludXguZ2l0IHhjb3B5Cj4gWzRdIGh0dHBzOi8vd3d3LnNw
aW5pY3MubmV0L2xpc3RzL2xpbnV4LWJsb2NrL21zZzAwNTk5Lmh0bWwKPiBbNV0gaHR0cHM6Ly9s
d24ubmV0L0FydGljbGVzLzc5MzU4NS8KPiBbNl0gaHR0cHM6Ly9udm1leHByZXNzLm9yZy9uZXct
bnZtZXRtLXNwZWNpZmljYXRpb24tZGVmaW5lcy16b25lZC0KPiBuYW1lc3BhY2VzLXpucy1hcy1n
by10by1pbmR1c3RyeS10ZWNobm9sb2d5Lwo+IFs3XSBodHRwczovL2dpdGh1Yi5jb20vc2JhdGVz
MTMwMjcyL2xpbnV4LXAycG1lbQo+IFs4XSBodHRwczovL2tlcm5lbC5kay9pb191cmluZy5wZGYK
PiAKPiBSZWdhcmRzLAo+IENoYWl0YW55YQo+IAoKVGhpcyBpcyBhIHZlcnkgaW50ZXJlc3Rpbmcg
dG9waWMgYW5kIEkgd291bGQgbGlrZSB0byBwYXJ0aWNpcGF0ZSBpbiB0aGUKZGlzY3Vzc2lvbiB0
b28uCgpUaGUgZG0tY2xvbmUgdGFyZ2V0IHdvdWxkIGFsc28gYmVuZWZpdCBmcm9tIGNvcHkgb2Zm
bG9hZCwgYXMgaXQgaGVhdmlseQplbXBsb3lzIGRtLWtjb3B5ZC4gSSBoYXZlIGJlZW4gZXhwbG9y
aW5nIHJlZGVzaWduaW5nIGtjb3B5ZCBpbiBvcmRlciB0bwphY2hpZXZlIGluY3JlYXNlZCBJT1BT
IGluIGRtLWNsb25lIGFuZCBkbS1zbmFwc2hvdCBmb3Igc21hbGwgY29waWVzIG92ZXIKTlZNZSBk
ZXZpY2VzLCBidXQgY29weSBvZmZsb2FkIHNvdW5kcyBldmVuIG1vcmUgcHJvbWlzaW5nLCBlc3Bl
Y2lhbGx5CmZvciBsYXJnZXIgY29waWVzIGhhcHBlbmluZyBpbiB0aGUgYmFja2dyb3VuZCAoYXMg
aXMgdGhlIGNhc2Ugd2l0aApkbS1jbG9uZSdzIGJhY2tncm91bmQgaHlkcmF0aW9uKS4KClRoYW5r
cywKTmlrb3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
