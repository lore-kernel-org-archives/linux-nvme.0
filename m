Return-Path: <SRS0=mRFX=GI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F87FC433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 14:23:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 224D42065C
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 14:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224D42065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0q665KSSic0RMKY1bSFP91UF1mYgDaBlsfTFGaYWpSQ=; b=Ru4cQuYnLIqFd/94qc1dAxe54
	6ctDY+4L0zrmWwaCGm9YJA0y5Cex21gt/+os3JxmUOygEvRs0H4aa4sNY99Qk8/QsnPtCGLG2NYwh
	2ESUT4gDCoObyijs0j2ikGJzPMmA83aVzuuzsPPpY6Zcb9YSe1cXtjflaQIhDY/+WWSN8hFe67Ovy
	kK6zk8o4reuZpYywTM7DrTpY5tgD1p13iw0CRnrPQs+4uW+HVAEbHP1uI3asvJKUa7zyxfG4yPfcJ
	wZk12jpeGePTjvR0ZT5nEqHo4giASvLgEYn47qBAtNxWkpUYVQTy5V0J9543CixSWHEic5xP40qVI
	NY/XC2GIg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwnEp-0007oJ-LO; Tue, 05 Jan 2021 14:23:07 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwnEm-0007nk-Hm
 for linux-nvme@lists.infradead.org; Tue, 05 Jan 2021 14:23:05 +0000
Received: by mail-ej1-x632.google.com with SMTP id jx16so41368610ejb.10
 for <linux-nvme@lists.infradead.org>; Tue, 05 Jan 2021 06:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=j1NvKmtJGKiFDjjXKZ0rVwy5v3Z3i/GAMZvpNKKRLfc=;
 b=M65TtKlKHGtX8mX+g+91fAHKCph41gARK7tY21v1oWRfOglc1+76okSjorE6vtFjMx
 JJbVrreafdRsihFtWoQGrxaLull4FcSN/9QzVSNHuujlY44q+OxDDxkKdAM1QqMibP0n
 Pk6wBiWKF9Ss8SUk3mC+r4uoQTFT3T9wuN5mMezTf6gMhehl8AX51wQMFk07WoHUBSuY
 VOzA7W/vIx0lbkqw9RcwNVYhqWZryiE2gDiKn5bICDNMb2EuBEk6Jh7EJxenAlVDegp2
 E5VQLDbhdXKMkXaCv7yoWgmO6MIVVkXzQiWe8eXaV88qIR2L7UUwO6E1t+V9DFExVU9d
 HbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=j1NvKmtJGKiFDjjXKZ0rVwy5v3Z3i/GAMZvpNKKRLfc=;
 b=COhdWMy8OLxIbw+M1kgoRUXo1WKpPpXlaQs+0rR6MUK/P19FJ0PXWx1+WcAabB+sai
 hoCjO4/23ljDleAw3ErzK7Jfk6T5R5YEis4waAL59lAunSXQvlAUZB12z5pTlPB6i1/n
 SfdVC18X5gX4x7jO0jMFqlxUP5qEGc+cLq01cW9vQZpxix5yOzGg+MSEHiGBX65FkZJK
 6evZCin6OuPArplupwzaBG/Ma5jze79T9m75nGM4uY5LJclvNn/KmEkHhR7SbqZX65ir
 /nLAebS/VOoJbhuRssRam/9RalePPLWn6f1WU/UnhmYLhaaiszxsn60YISWWlSuchWTr
 ZrXA==
X-Gm-Message-State: AOAM532XHqpqXflHBLIIesRxj1sUYs01YttiRmK2N1372toqAhY5SQsq
 I59RsPn9mkS4EqHk+k4OgQQvT4zjSiklf4MYn+Y=
X-Google-Smtp-Source: ABdhPJwnxRqHv2aMqHMbFt0kXTvzZaOUW+aFB6JjMi14SNUWLSvVqm2hXOLS8N/UvGELnDV/oZP5zanvNoGhzXZMTZI=
X-Received: by 2002:a17:907:271c:: with SMTP id
 w28mr70922796ejk.140.1609856581820; 
 Tue, 05 Jan 2021 06:23:01 -0800 (PST)
MIME-Version: 1.0
References: <20210104104159.74236-1-selvakuma.s1@samsung.com>
 <CGME20210104104249epcas5p458d1b5c39b5acfad4e7786eca5dd5c49@epcas5p4.samsung.com>
 <20210104104159.74236-3-selvakuma.s1@samsung.com>
 <BL0PR04MB651402CFA75F72826AC8EE1CE7D20@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20210104190254.GB6919@magnolia>
In-Reply-To: <20210104190254.GB6919@magnolia>
From: Selva Jove <selvajove@gmail.com>
Date: Tue, 5 Jan 2021 19:52:48 +0530
Message-ID: <CAHqX9vYCRpX9FSCEaf2+xbYkB-zm7wRTmUka9zGs4D1T6nZb_A@mail.gmail.com>
Subject: Re: [dm-devel] [RFC PATCH v4 2/3] block: add simple copy support
To: "Darrick J. Wong" <darrick.wong@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210105_092304_705936_37D01EB2 
X-CRM114-Status: GOOD (  38.37  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "snitzer@redhat.com" <snitzer@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
 "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
 "bvanassche@acm.org" <bvanassche@acm.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGkgRGFycmljaywKCgpPbiBUdWUsIEphbiA1LCAyMDIxIGF0IDEyOjMzIEFNIERhcnJpY2sgSi4g
V29uZyA8ZGFycmljay53b25nQG9yYWNsZS5jb20+IHdyb3RlOgo+Cj4gU2VsdmFLdW1hciBTOiBU
aGlzIGRpZG4ndCBzaG93IHVwIG9uIGRtLWRldmVsLCBzb3JyeSBmb3IgdGhlIE9UIHJlcGx5Li4u
Cj4KPiBPbiBNb24sIEphbiAwNCwgMjAyMSBhdCAxMjo0NzoxMVBNICswMDAwLCBEYW1pZW4gTGUg
TW9hbCB3cm90ZToKPiA+IE9uIDIwMjEvMDEvMDQgMTk6NDgsIFNlbHZhS3VtYXIgUyB3cm90ZToK
PiA+ID4gQWRkIG5ldyBCTEtDT1BZIGlvY3RsIHRoYXQgb2ZmbG9hZHMgY29weWluZyBvZiBvbmUg
b3IgbW9yZSBzb3VyY2VzCj4gPiA+IHJhbmdlcyB0byBhIGRlc3RpbmF0aW9uIGluIHRoZSBkZXZp
Y2UuIEFjY2VwdHMgY29weV9yYW5nZXMgdGhhdCBjb250YWlucwo+ID4gPiBkZXN0aW5hdGlvbiwg
bm8gb2Ygc291cmNlcyBhbmQgcG9pbnRlciB0byB0aGUgYXJyYXkgb2Ygc291cmNlCj4gPiA+IHJh
bmdlcy4gRWFjaCByYW5nZV9lbnRyeSBjb250YWlucyBzdGFydCBhbmQgbGVuZ3RoIG9mIHNvdXJj
ZQo+ID4gPiByYW5nZXMgKGluIGJ5dGVzKS4KPiA+ID4KPiA+ID4gSW50cm9kdWNlIFJFUV9PUF9D
T1BZLCBhIG5vLW1lcmdlIGNvcHkgb2ZmbG9hZCBvcGVyYXRpb24uIENyZWF0ZQo+ID4gPiBiaW8g
d2l0aCBjb250cm9sIGluZm9ybWF0aW9uIGFzIHBheWxvYWQgYW5kIHN1Ym1pdCB0byB0aGUgZGV2
aWNlLgo+ID4gPiBSRVFfT1BfQ09QWSgxOSkgaXMgYSB3cml0ZSBvcCBhbmQgdGFrZXMgem9uZV93
cml0ZV9sb2NrIHdoZW4gc3VibWl0dGVkCj4gPiA+IHRvIHpvbmVkIGRldmljZS4KPiA+ID4KPiA+
ID4gSWYgdGhlIGRldmljZSBkb2Vzbid0IHN1cHBvcnQgY29weSBvciBjb3B5IG9mZmxvYWQgaXMg
ZGlzYWJsZWQsIHRoZW4KPiA+ID4gY29weSBpcyBlbXVsYXRlZCBieSBhbGxvY2F0aW5nIG1lbW9y
eSBvZiB0b3RhbCBjb3B5IHNpemUuIFRoZSBzb3VyY2UKPiA+ID4gcmFuZ2VzIGFyZSByZWFkIGlu
dG8gbWVtb3J5IGJ5IGNoYWluaW5nIGJpbyBmb3IgZWFjaCBzb3VyY2UgcmFuZ2VzIGFuZAo+ID4g
PiBzdWJtaXR0aW5nIHRoZW0gYXN5bmMgYW5kIHRoZSBsYXN0IGJpbyB3YWl0cyBmb3IgY29tcGxl
dGlvbi4gQWZ0ZXIgZGF0YQo+ID4gPiBpcyByZWFkLCBpdCBpcyB3cml0dGVuIHRvIHRoZSBkZXN0
aW5hdGlvbi4KPiA+ID4KPiA+ID4gYmlvX21hcF9rZXJuKCkgaXMgdXNlZCB0byBhbGxvY2F0ZSBi
aW8gYW5kIGFkZCBwYWdlcyBvZiBjb3B5IGJ1ZmZlciB0bwo+ID4gPiBiaW8uIEFzIGJpby0+Ymlf
cHJpdmF0ZSBhbmQgYmlvLT5iaV9lbmRfaW8gaXMgbmVlZGVkIGZvciBjaGFpbmluZyB0aGUKPiA+
ID4gYmlvIGFuZCBvdmVyIHdyaXR0ZW4sIGludmFsaWRhdGVfa2VybmVsX3ZtYXBfcmFuZ2UoKSBm
b3IgcmVhZCBpcyBjYWxsZWQKPiA+ID4gaW4gdGhlIGNhbGxlci4KPiA+ID4KPiA+ID4gSW50cm9k
dWNlIHF1ZXVlIGxpbWl0cyBmb3Igc2ltcGxlIGNvcHkgYW5kIG90aGVyIGhlbHBlciBmdW5jdGlv
bnMuCj4gPiA+IEFkZCBkZXZpY2UgbGltaXRzIGFzIHN5c2ZzIGVudHJpZXMuCj4gPiA+ICAgICAt
IGNvcHlfb2ZmbG9hZAo+ID4gPiAgICAgLSBtYXhfY29weV9zZWN0b3JzCj4gPiA+ICAgICAtIG1h
eF9jb3B5X3Jhbmdlc19zZWN0b3JzCj4gPiA+ICAgICAtIG1heF9jb3B5X25yX3Jhbmdlcwo+ID4g
Pgo+ID4gPiBjb3B5X29mZmxvYWQoPSAwKSBpcyBkaXNhYmxlZCBieSBkZWZhdWx0Lgo+ID4gPiBt
YXhfY29weV9zZWN0b3JzID0gMCBpbmRpY2F0ZXMgdGhlIGRldmljZSBkb2Vzbid0IHN1cHBvcnQg
bmF0aXZlIGNvcHkuCj4gPiA+Cj4gPiA+IE5hdGl2ZSBjb3B5IG9mZmxvYWQgaXMgbm90IHN1cHBv
cnRlZCBmb3Igc3RhY2tlZCBkZXZpY2VzIGFuZCBpcyBkb25lIHZpYQo+ID4gPiBjb3B5IGVtdWxh
dGlvbi4KPiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogU2VsdmFLdW1hciBTIDxzZWx2YWt1bWEu
czFAc2Ftc3VuZy5jb20+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IEthbmNoYW4gSm9zaGkgPGpvc2hp
LmtAc2Ftc3VuZy5jb20+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IE5pdGVzaCBTaGV0dHkgPG5qLnNo
ZXR0eUBzYW1zdW5nLmNvbT4KPiA+ID4gU2lnbmVkLW9mZi1ieTogSmF2aWVyIEdvbnrDoWxleiA8
amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgYmxvY2svYmxrLWNvcmUu
YyAgICAgICAgICB8ICA5NCArKysrKysrKysrKysrKy0tCj4gPiA+ICBibG9jay9ibGstbGliLmMg
ICAgICAgICAgIHwgMjIzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4g
PiA+ICBibG9jay9ibGstbWVyZ2UuYyAgICAgICAgIHwgICAyICsKPiA+ID4gIGJsb2NrL2Jsay1z
ZXR0aW5ncy5jICAgICAgfCAgMTAgKysKPiA+ID4gIGJsb2NrL2Jsay1zeXNmcy5jICAgICAgICAg
fCAgNTAgKysrKysrKysrCj4gPiA+ICBibG9jay9ibGstem9uZWQuYyAgICAgICAgIHwgICAxICsK
PiA+ID4gIGJsb2NrL2JvdW5jZS5jICAgICAgICAgICAgfCAgIDEgKwo+ID4gPiAgYmxvY2svaW9j
dGwuYyAgICAgICAgICAgICB8ICA0MyArKysrKysrKwo+ID4gPiAgaW5jbHVkZS9saW51eC9iaW8u
aCAgICAgICB8ICAgMSArCj4gPiA+ICBpbmNsdWRlL2xpbnV4L2Jsa190eXBlcy5oIHwgIDE1ICsr
Kwo+ID4gPiAgaW5jbHVkZS9saW51eC9ibGtkZXYuaCAgICB8ICAxMyArKysKPiA+ID4gIGluY2x1
ZGUvdWFwaS9saW51eC9mcy5oICAgfCAgMTMgKysrCj4KPiBUaGlzIHNlcmllcyBzaG91bGQgYWxz
byBiZSBjYydkIHRvIGxpbnV4LWFwaSBzaW5jZSB5b3UncmUgYWRkaW5nIGEgbmV3Cj4gdXNlcnNw
YWNlIGFwaS4KPgoKU3VyZS4gV2lsbCBjYyBsaW51eC1hcGkKCj4KPiBBbHRlcm5hdGVseSwgc2F2
ZSB5b3Vyc2VsZiB0aGUgdHJvdWJsZSBvZiBwYXNzaW5nIHVzZXJzcGFjZSBBUEkgcmV2aWV3Cj4g
YnkgaG9va2luZyB0aGlzIHVwIHRvIHRoZSBleGlzdGluZyBjb3B5X2ZpbGVfcmFuZ2UgY2FsbCBp
biB0aGUgdmZzLiAgL21lCj4gaG9wZXMgeW91IHNlbnQgYmxrdGVzdHMgdG8gY2hlY2sgdGhlIG9w
ZXJhdGlvbiBvZiB0aGlzIHRoaW5nLCBzaW5jZSBub25lCj4gb2YgdGhlIG9yaWdpbmFsIHBhdGNo
ZXMgbWFkZSBpdCB0byB0aGlzIGxpc3QuCj4KCkFzIHRoZSBpbml0aWFsIHZlcnNpb24gaGFkIG9u
bHkgc291cmNlIGJkZXYsIGNvcHlfZmlsZV9yYWdlIGNhbGwgd2FzIG5vdAp2aWFibGUuIFdpdGgg
dGhpcyB2ZXJzaW9uLCB3ZSBoYXZlIHR3byBiZGV2IGZvciBzb3VyY2UgYW5kIGRlc3RpbmF0aW9u
LgpJJ2xsIHJlbG9vayBhdCB0aGF0LiBTdXJlLiBXaWxsIGFkZCBhIG5ldyBibGt0ZXN0cyBmb3Ig
c2ltcGxlIGNvcHkuCgo+Cj4gSWYgeW91IHJlYWxseSAvZG8vIG5lZWQgYSBuZXcga2VybmVsIGNh
bGwgZm9yIHRoaXMsIHRoZW4gcGxlYXNlIHNlbmQgaW4KPiBhIG1hbnBhZ2UgZG9jdW1lbnRpbmcg
dGhlIGZpZWxkcyBvZiBzdHJ1Y3QgcmFuZ2VfZW50cnkgYW5kIGNvcHlfcmFuZ2UsCj4gYW5kIGhv
dyB1c2VycyBhcmUgc3VwcG9zZWQgdG8gdXNlIHRoaXMuCj4KClN1cmUuIFdpbGwgc2VuZCBhIG1h
bnBhZ2UgZG9jdW1lbnRhdGlvbiBvbmNlIHRoZSBwbHVtYmluZyBpcyBjb25jcmV0ZS4KCj4gPG5v
dyBqdW1waW5nIHRvIHRoZSBpb2N0bCBkZWZpbml0aW9uIGJlY2F1c2UgRGFtaWVuIGFscmVhZHkg
cmV2aWV3ZWQgdGhlCj4gcGx1bWJpbmcuLi4+Cj4KPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
dWFwaS9saW51eC9mcy5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2ZzLmgKPiA+ID4gaW5kZXggZjQ0
ZWIwYTA0YWZkLi41Y2FkYjE3NjMxN2EgMTAwNjQ0Cj4gPiA+IC0tLSBhL2luY2x1ZGUvdWFwaS9s
aW51eC9mcy5oCj4gPiA+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9mcy5oCj4gPiA+IEBAIC02
NCw2ICs2NCwxOCBAQCBzdHJ1Y3QgZnN0cmltX3JhbmdlIHsKPiA+ID4gICAgIF9fdTY0IG1pbmxl
bjsKPiA+ID4gIH07Cj4gPiA+Cj4gPiA+ICtzdHJ1Y3QgcmFuZ2VfZW50cnkgewo+ID4gPiArICAg
X191NjQgc3JjOwo+Cj4gSXMgdGhpcyBhbiBvZmZzZXQ/ICBPciB0aGUgZmQgb2YgYW4gb3BlbiBi
ZGV2PwoKVGhpcyBpcyB0aGUgc291cmNlIG9mZnNldC4KCj4KPiA+ID4gKyAgIF9fdTY0IGxlbjsK
PiA+ID4gK307Cj4gPiA+ICsKPiA+ID4gK3N0cnVjdCBjb3B5X3JhbmdlIHsKPiA+ID4gKyAgIF9f
dTY0IGRlc3Q7Cj4gPiA+ICsgICBfX3U2NCBucl9yYW5nZTsKPiA+ID4gKyAgIF9fdTY0IHJhbmdl
X2xpc3Q7Cj4KPiBIbSwgSSB0aGluayB0aGlzIGlzIGEgcG9pbnRlcj8gIFdoeSBub3QganVzdCBw
dXQgdGhlIHJhbmdlX2VudHJ5IGFycmF5Cj4gYXQgdGhlIGVuZCBvZiBzdHJ1Y3QgY29weV9yYW5n
ZT8KPgoKQXMgdGhlIHNpemUgb2YgdGhlIHJhbmdlX2VudHJ5IGFycmF5IGNhbiBjaGFuZ2UgZHlu
YW1pY2FsbHkgZGVwZW5kaW5nIG9uCm5yX3JhbmdlLCBpdCB3YXMgZGlmZmljdWx0IHRvIGRvIGNv
cHlfZnJvbV91c2VyKCkgb24gY29weV9yYW5nZSBzdHJ1Y3R1cmUgaW4gdGhlCmlvY3RsLiBTbyBJ
IGRlY2lkZWQgdG8ga2VlcCB0aGF0IGFzIGEgcG9pbnRlciB0byByYW5nZV9lbnRyeSBhcnJheQpp
bnN0ZWFkIG9mIGtlZXBpbmcKYXJyYXkgYXQgdGhlIGVuZC4KCj4gPiA+ICsgICBfX3U2NCByc3Zk
Owo+Cj4gQWxzbyBuZWVkcyBhIGZsYWdzIGFyZ3VtZW50IHNvIHdlIGRvbid0IGhhdmUgdG8gYWRk
IEJMS0NPUFkyIGluIGxpa2UgMwo+IG1vbnRocy4KPgoKJ3JzdmQnIGZpZWxkIGlzIGtlcHQgdG8g
c3VwcG9ydCBmdXR1cmUgY29waWVzLiBXaWxsIHJlbmFtZSBpdC4KCj4gLS1ECj4KPiA+ID4gK307
Cj4gPiA+ICsKPiA+ID4gIC8qIGV4dGVudC1zYW1lIChkZWR1cGUpIGlvY3RsczsgdGhlc2UgTVVT
VCBtYXRjaCB0aGUgYnRyZnMgaW9jdGwgZGVmaW5pdGlvbnMgKi8KPiA+ID4gICNkZWZpbmUgRklM
RV9ERURVUEVfUkFOR0VfU0FNRSAgICAgICAgICAgICAwCj4gPiA+ICAjZGVmaW5lIEZJTEVfREVE
VVBFX1JBTkdFX0RJRkZFUlMgIDEKPiA+ID4gQEAgLTE4NCw2ICsxOTYsNyBAQCBzdHJ1Y3QgZnN4
YXR0ciB7Cj4gPiA+ICAjZGVmaW5lIEJMS1NFQ0RJU0NBUkQgX0lPKDB4MTIsMTI1KQo+ID4gPiAg
I2RlZmluZSBCTEtST1RBVElPTkFMIF9JTygweDEyLDEyNikKPiA+ID4gICNkZWZpbmUgQkxLWkVS
T09VVCBfSU8oMHgxMiwxMjcpCj4gPiA+ICsjZGVmaW5lIEJMS0NPUFkgX0lPV1IoMHgxMiwgMTI4
LCBzdHJ1Y3QgY29weV9yYW5nZSkKPiA+ID4gIC8qCj4gPiA+ICAgKiBBIGp1bXAgaGVyZTogMTMw
LTEzMSBhcmUgcmVzZXJ2ZWQgZm9yIHpvbmVkIGJsb2NrIGRldmljZXMKPiA+ID4gICAqIChzZWUg
dWFwaS9saW51eC9ibGt6b25lZC5oKQo+ID4gPgo+ID4KPiA+Cj4gPiAtLQo+ID4gRGFtaWVuIExl
IE1vYWwKPiA+IFdlc3Rlcm4gRGlnaXRhbCBSZXNlYXJjaAo+ID4KPiA+Cj4gPgo+ID4gLS0KPiA+
IGRtLWRldmVsIG1haWxpbmcgbGlzdAo+ID4gZG0tZGV2ZWxAcmVkaGF0LmNvbQo+ID4gaHR0cHM6
Ly93d3cucmVkaGF0LmNvbS9tYWlsbWFuL2xpc3RpbmZvL2RtLWRldmVsCj4gPgoKVGhhbmtzLApT
ZWx2YQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
