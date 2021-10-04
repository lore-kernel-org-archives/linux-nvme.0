Return-Path: <SRS0=itK/=OY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E29C433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Oct 2021 13:11:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B2061BFD
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Oct 2021 13:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 65B2061BFD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=62ds+384bfcHwoiqo7GF3mIVUVe+Dsn/oLX8rVvby8M=; b=m7PWZ/4KPrGr+O
	snssTs65AEJ4a+2fZ6Ha2gEykKLs4YYQFKPlPTj0FnnpKMzPUSWr9IOSoLpp4XId557Yzzub2KUeF
	jQdNbNYCPEVMSY9YSQnUFr/jDH2K10LiWaVhfL2QG2FOwcsy2XaQ/u5S22U+Pjsor7W3G+EB+Gzhf
	hbyghxTpWXbczD+WIi9Hoe3Ps4+mS4clroUk/tiz3BhZwRbt4Hx2W98W7Qy0XmaeaAOmeIik+kHfA
	OK6njh/o9fGF8r5ZpS4LkU1BKv8DaWi0EMN9xEeRZFs3DJskctJ79KvNZy24C/uB2uqXK6TuNs4o6
	qvt6lS40Uf8gRheKc/eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mXNkL-006a5i-AX; Mon, 04 Oct 2021 13:11:09 +0000
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mXNkH-006a2v-AT
 for linux-nvme@lists.infradead.org; Mon, 04 Oct 2021 13:11:08 +0000
Received: by mail-qt1-x82f.google.com with SMTP id r16so15717266qtw.11
 for <linux-nvme@lists.infradead.org>; Mon, 04 Oct 2021 06:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=paHHKoo/ZYW/alWLfZ/j7TCYl/PNWAJKpM5YE1NlK5U=;
 b=CiiZvoWKp3sR9ox9MwLe/aAoWn+zgVzIzoK5stQ+lLZ8DkbvPmGdAvlduR2gk+UfNV
 1P2afMJH7vV6IAPbHYW+Rc1sS/roPklW+dTBpRVIRTDMTOlufRxRg1g/8y1JoQ+dMbuv
 LGIfCJ9SBJ35Rx0zUSTT/N81gMCEGHaUh1bP29Efovspabd/frzknJ1uGremi9e7FwxS
 GxHlxz3fbXPf+Zsfi7b0EtSOmVd90ItpDxGwUFntNisS3pwBHUIyI3Rc56o8RcowEZMy
 Mw89sHmlOIvN3XWdOUkQFS1bSP5hsGSdPYoFBcbynXIPZSK0aKIKspXPBzoXODDrSrLW
 RE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=paHHKoo/ZYW/alWLfZ/j7TCYl/PNWAJKpM5YE1NlK5U=;
 b=G5BaJo4/9LFt99uAZC0oOxan/PzWMFDN+dElrWlryGTrP9JPEVsddQUaBNSR4EVKSJ
 sBs61reQfGauPljueRPu5OdQxNjfjdLlmdHdeCmV1nLI+LyXMZm8vEpDHoSRlWwVKaxu
 jNSkrtKaP/qTVJMXnuUUBUPTNjXyi4PUmKF+ouUuL/aXSHuNMjN0sW3glcWVs+HQuRvl
 /uqBid/Cl8Zq9zhhQLfR6YPL0J8ltrTzaD/OslLilLpHz5gqgtPmAk/Fkj5OV1+etEqO
 o9SN+TAmOSQ9fDcizzTAZEZYDxEOCKu8F0N11Qmm3Y0rmUKfiUNTD2SYXvOtAcK82tvx
 DCDA==
X-Gm-Message-State: AOAM531ZH5Wc76ep9nWhBO9Z+uPaOZBAQ1OUABRbqTw8RHn2wUAyaf5Y
 OXB4nPoGFkgNF4Y+YBejGs0BDA==
X-Google-Smtp-Source: ABdhPJxQOmTNv7SjQ0A/T+hfHtxMzsOyyvatzsxt2GOAUZRpJkhppd32O3vVCO/+XaAwlscFA5pPQw==
X-Received: by 2002:ac8:7594:: with SMTP id s20mr12950198qtq.158.1633353063650; 
 Mon, 04 Oct 2021 06:11:03 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id t8sm7785072qkt.117.2021.10.04.06.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Oct 2021 06:11:02 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mXNkE-00ATWh-9x; Mon, 04 Oct 2021 10:11:02 -0300
Date: Mon, 4 Oct 2021 10:11:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Logan Gunthorpe <logang@deltatee.com>,
 Alistair Popple <apopple@nvidia.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Message-ID: <20211004131102.GU3544071@ziepe.ca>
References: <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca>
 <20211001134856.GN3544071@ziepe.ca>
 <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
 <20211001174511.GQ3544071@ziepe.ca>
 <809be72b-efb2-752c-31a6-702c8a307ce7@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <809be72b-efb2-752c-31a6-702c8a307ce7@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211004_061105_574860_980ECF6B 
X-CRM114-Status: GOOD (  37.54  )
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

T24gTW9uLCBPY3QgMDQsIDIwMjEgYXQgMDg6NTg6MzVBTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBJJ20gbm90IGZvbGxvd2luZyB0aGlzIGRpc2N1c3Npb24gdG8gY2xvc2VseSwg
YnV0IHRyeSB0byBsb29rIGludG8gaXQgZnJvbQo+IHRpbWUgdG8gdGltZS4KPiAKPiBBbSAwMS4x
MC4yMSB1bSAxOTo0NSBzY2hyaWViIEphc29uIEd1bnRob3JwZToKPiA+IE9uIEZyaSwgT2N0IDAx
LCAyMDIxIGF0IDExOjAxOjQ5QU0gLTA2MDAsIExvZ2FuIEd1bnRob3JwZSB3cm90ZToKPiA+IAo+
ID4gPiBJbiBkZXZpY2UtZGF4LCB0aGUgcmVmY291bnQgaXMgb25seSB1c2VkIHRvIHByZXZlbnQg
dGhlIGRldmljZSwgYW5kCj4gPiA+IHRoZXJlZm9yZSB0aGUgcGFnZXMsIGZyb20gZ29pbmcgYXdh
eSBvbiBkZXZpY2UgdW5iaW5kLiBQYWdlcyBjYW5ub3QgYmUKPiA+ID4gcmVjeWNsZWQsIGFzIHlv
dSBzYXksIGFzIHRoZXkgYXJlIG1hcHBlZCBsaW5lYXJseSB3aXRoaW4gdGhlIGRldmljZS4gVGhl
Cj4gPiA+IGFkZHJlc3Mgc3BhY2UgaW52YWxpZGF0aW9uIGlzIGRvbmUgb25seSB3aGVuIHRoZSBk
ZXZpY2UgaXMgdW5ib3VuZC4KPiA+IEJ5IGFkZHJlc3Mgc3BhY2UgaW52YWxpZGF0aW9uIEkgbWVh
biBpbnZhbGlkYXRpb24gb2YgdGhlIFZNQSB0aGF0IGlzCj4gPiBwb2ludGluZyB0byB0aG9zZSBw
YWdlcy4KPiA+IAo+ID4gZGV2aWNlLWRheCBtYXkgbm90IGhhdmUgYSBpc3N1ZSB3aXRoIHVzZS1h
ZnRlci1WTUEtaW52YWxpZGF0aW9uIGJ5Cj4gPiBpdCdzIHZlcnkgbmF0dXJlIHNpbmNlIGV2ZXJ5
IFBGTiBhbHdheXMgcG9pbnRzIHRvIHRoZSBzYW1lCj4gPiB0aGluZy4gZnNkYXggYW5kIHRoaXMg
cDJwIHN0dWZmIGFyZSBkaWZmZXJlbnQgdGhvdWdoLgo+ID4gCj4gPiA+IEJlZm9yZSB0aGUgaW52
YWxpZGF0aW9uLCBhbiBhY3RpdmUgZmxhZyBpcyBjbGVhcmVkIHRvIGVuc3VyZSBubyBuZXcKPiA+
ID4gbWFwcGluZ3MgY2FuIGJlIGNyZWF0ZWQgd2hpbGUgdGhlIHVubWFwIGlzIHByb2NlZWRpbmcu
Cj4gPiA+IHVubWFwX21hcHBpbmdfcmFuZ2UoKSBzaG91bGQgc2VxdWVuY2UgaXRzZWxmIHdpdGgg
dGhlIFRMQiBmbHVzaCBhbmQKPiA+IEFGSUFLIHVubWFwX21hcHBpbmdfcmFuZ2UoKSBraWNrcyBv
ZmYgdGhlIFRMQiBmbHVzaCBhbmQgdGhlbgo+ID4gcmV0dXJucy4gSXQgZG9lc24ndCBhbHdheXMg
d2FpdCBmb3IgdGhlIGZsdXNoIHRvIGZ1bGx5IGZpbmlzaC4gSWUgc29tZQo+ID4gY2FzZXMgdXNl
IFJDVSB0byBsb2NrIHRoZSBwYWdlIHRhYmxlIGFnYWluc3QgR1VQIGZhc3QgYW5kIHNvIHRoZQo+
ID4gcHV0X3BhZ2UoKSBkb2Vzbid0IGhhcHBlbiB1bnRpbCB0aGUgY2FsbF9yY3UgY29tcGxldGVz
IC0gYWZ0ZXIgYSBncmFjZQo+ID4gcGVyaW9kLiBUaGUgdW5tYXBfbWFwcGluZ19yYW5nZSgpIGRv
ZXMgbm90IHdhaXQgZm9yIGdyYWNlIHBlcmlvZHMuCj4gCj4gV293LCB3YWl0IGEgc2Vjb25kLiBU
aGF0IGlzIHF1aXRlIGEgYm9vbWVyLiBBdCBsZWFzdCBpbiBhbGwgR0VNL1RUTSBiYXNlZAo+IGdy
YXBoaWNzIGRyaXZlcnMgdGhhdCBjb3VsZCBwb3RlbnRpYWxseSBjYXVzZSBhIGxvdCBvZiB0cm91
YmxlLgo+IAo+IEkndmUganVzdCBkb3VibGUgY2hlY2tlZCBhbmQgd2UgY2VydGFpbmx5IGhhdmUg
dGhlIGFzc3VtcHRpb24gdGhhdCB3aGVuCj4gdW5tYXBfbWFwcGluZ19yYW5nZSgpIHJldHVybnMg
dGhlIHB0ZSBpcyBnb25lIGFuZCB0aGUgVExCIGZsdXNoIGNvbXBsZXRlZCBpbgo+IHF1aXRlIGEg
bnVtYmVyIG9mIHBsYWNlcy4KPiAKPiBEbyB5b3UgaGF2ZSBtb3JlIGluZm9ybWF0aW9uIHdoZW4g
YW5kIHdoeSB0aGF0IGNhbiBoYXBwZW4/CgpUaGVyZSBhcmUgdHdvIHRoaW5ncyB0byBrZWVwIGlu
IG1pbmQsIGZsdXNoaW5nIHRoZSBQVEVzIGZyb20gdGhlIEhXCmFuZCBzZXJpYWxpemluZyBhZ2Fp
bnN0IGd1cF9mYXN0LgoKSWYgeW91IHN0YXJ0IGF0IHVubWFwX21hcHBpbmdfcmFuZ2UoKSB0aGUg
cGFnZSBpcyBldmVudHVhbGx5CmRpc2NvdmVyZWQgaW4gemFwX3B0ZV9yYW5nZSgpIGFuZCB0aGUg
UFRFIGNsZWFyZWQuIEl0IGlzIHRoZW4gcGFzc2VkCmludG8gX190bGJfcmVtb3ZlX3BhZ2UoKSB3
aGljaCBwdXRzIGl0IG9uIHRoZSBiYXRjaC0+cGFnZXMgbGlzdAoKVGhlIHBhZ2UgZnJlZSBoYXBw
ZW5zIGluIHRsYl9iYXRjaF9wYWdlc19mbHVzaCgpIHZpYQpmcmVlX3BhZ2VzX2FuZF9zd2FwX2Nh
Y2hlKCkKClRoZSB0bGJfYmF0Y2hfcGFnZXNfZmx1c2goKSBoYXBwZW5zIHZpYSB6YXBfcGFnZV9y
YW5nZSgpIC0+CnRsYl9maW5pc2hfbW11KCksIHByZXN1bWFibHkgYWZ0ZXIgdGhlIEhXIGhhcyB3
aXBlZCB0aGUgVExCJ3Mgb24gYWxsCkNQVXMuIE9uIHg4NiB0aGlzIGlzIGRvbmUgd2l0aCBhbiBJ
UEkgYW5kIGFsc28gc2VyaWFsaXplcyBndXAgZmFzdCwgc28KT0sKClRoZSBpbnRlcmVzdGluZyBj
YXNlIGlzIENPTkZJR19NTVVfR0FUSEVSX1JDVV9UQUJMRV9GUkVFIHdoaWNoIGRvZXNuJ3QKcmVs
eSBvbiBJUElzIGFueW1vcmUgdG8gc3luY2hyb25pemUgd2l0aCBndXAtZmFzdC4KCkluIHRoaXMg
Y29uZmlndXJhdGlvbiBpdCBtZWFucyB3aGVuIHVubWFwX21hcHBpbmdfcmFuZ2UoKSByZXR1cm5z
IHRoZQpUTEIgd2lsbCBoYXZlIGJlZW4gZmx1c2hlZCwgYnV0IG5vIHNlcmlhbGl6YXRpb24gd2l0
aCBHVVAgZmFzdCB3YXMKZG9uZS4KClRoaXMgaXMgT0sgaWYgdGhlIEdVUCBmYXN0IGNhbm5vdCBy
ZXR1cm4gdGhlIHBhZ2UgYXQgYWxsLiBJIGFzc3VtZQp0aGlzIGdlbmVyYWxseSBkZXNjcmliZXMg
dGhlIERSTSBjYWVzPwoKSG93ZXZlciwgaWYgdGhlIEdVUCBmYXN0IGNhbiByZXR1cm4gdGhlIHBh
Z2UgdGhlbiBzb21ldGhpbmcsCnNvbWV3aGVyZSwgbmVlZHMgdG8gc2VyaWFsaXplIHRoZSBwYWdl
IGZyZWUgd2l0aCB0aGUgUkNVIGFzIHRoZSBHVVAKZmFzdCBjYW4gYmUgb2JzZXJ2aW5nIHRoZSBv
bGQgUFRFIGJlZm9yZSBpdCB3YXMgemFwJ2QgdW50aWwgdGhlIFJDVQpncmFjZSBleHBpcmVzLgoK
UmVseWluZyBvbiB0aGUgcGFnZSByZWYgYmVpbmcgITAgdG8gcHJvdGVjdCBHVVAgZmFzdCBpcyBu
b3Qgc2FmZQpiZWNhdXNlIHRoZSBwYWdlIHJlZiBjYW4gYmUgaW5jcidkIGltbWVkaWF0ZWx5IHVw
b24gcGFnZSByZS11c2UuCgpJbnRlcmVzdGluZ2x5IEkgbG9va2VkIGFyb3VuZCBmb3IgdGhpcyBv
biBQUEMgYW5kIEkgb25seSBmb3VuZCBSQ1UKZGVsYXllZCBmcmVlaW5nIG9mIHRoZSBwYWdlIHRh
YmxlIGxldmVsLCBub3QgUkNVIGRlbGF5ZWQgZnJlZWluZyBvZgpwYWdlcyB0aGVtc2VsdmVzLi4g
SSB3b25kZXIgaWYgaXQgd2FzIG1pc3NlZD8gCgpUaGVyZSBpcyBhIHBhdGggb24gUFBDICh0bGJf
cmVtb3ZlX3RhYmxlX3N5bmNfb25lKSB0aGF0IHRyaWdnZXJzIGFuCklQSSBidXQgaXQgbG9va3Mg
bGlrZSBhbiBleGNlcHRpb24sIGFuZCB3ZSB3b3VsZG4ndCBuZWVkIHRoZSBSQ1UgYXQKYWxsIGlm
IHdlIHVzZWQgSVBJIHRvIHNlcmlhbGl6ZSBHVVAgZmFzdC4uLgoKSXQgbWFrZXMgbG9naWNhbCBz
ZW5zZSBpZiB0aGUgUkNVIGFsc28gZnJlZXMgdGhlIHBhZ2VzIG9uCkNPTkZJR19NTVVfR0FUSEVS
X1JDVV9UQUJMRV9GUkVFIHNvIGFueXRoaW5nIHJldHVybmFibGUgYnkgR1VQIGZhc3QKbXVzdCBi
ZSByZWZjb3VudGVkIGFuZCBmcmVlZCBieSB0bGJfYmF0Y2hfcGFnZXNfZmx1c2goKSwgbm90IGJ5
IHRoZQpjYWxsZXIgb2YgdW5tYXBfbWFwcGluZ19yYW5nZSgpLgoKSWYgd2UgZXhwZWN0IHRvIGFs
bG93IHRoZSBjYWxsZXIgb2YgdW5tYXBfbWFwcGluZ19yYW5nZSgpIHRvIGZyZWUgdGhlbgpDT05G
SUdfTU1VX0dBVEhFUl9SQ1VfVEFCTEVfRlJFRSBjYW4ndCByZWFsbHkgZXhpc3QsIHdlIGFsd2F5
cyBuZWVkIHRvCnRyaWdnZXIgYSBzZXJpYWxpemluZyBJUEkgZHVyaW5nIHRsYl9iYXRjaF9wYWdl
c19mbHVzaCgpCgpBRkFJQ1QsIGF0IGxlYXN0CgpKYXNvbgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=
