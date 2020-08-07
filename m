Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EEFC433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 00:03:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 152B82075A
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 00:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dds7RHJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152B82075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LkQwCLzZte+1chL6zdub5EVP47XBCtb5nYTPhOh4MOU=; b=Dds7RHJeAtv8l4p5HRQ/qJj3u
	FRJxqV2FccOxS11ckyz6o511l+uVRjfCSNPsOc76shMj8yqxJKJsomFhDCbrdGtDcu+BRxXf9FCaK
	kXkrq6PCp3pH2gVFiy/mnBM5M9iefxoSAIPzABFDEaZk7Z5y/RiK+or3En2b0kS/0N0fPit7hEALT
	uAIFOnh+gD1VhAHWYhM6LYb1FcVlm5HqO0Ac8Z2xpwgoK3EBM0asTZm4yD54b2vzgBssYWLXhMMod
	fPnJVUpopvjvMu7NNnnMeqC606TbVzD8Tt+9MX9qooRmvN54ZbfVlH2LyXsXzrHsFH9QYilsT3Wk8
	RCmWPqkTA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3prJ-00073Q-CA; Fri, 07 Aug 2020 00:03:41 +0000
Received: from mail-wm1-f65.google.com ([209.85.128.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3prG-00072n-1N
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 00:03:39 +0000
Received: by mail-wm1-f65.google.com with SMTP id k20so218894wmi.5
 for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2020 17:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xhd8+U8ngWIZHNWQPMg7axj0NJjPdQAvScWt1odARyA=;
 b=ltUH0SuInSpY6a6/DXGPc8ZOb/ynbNBDFoguaBhERSzv+tlGcJTeGzescFnfw1/w3l
 DbG15HRcrLljfjuhFZGz1hiQ0i6Mr5t93kYDY4t9+QFFLYaJk+MispGfNdj6r+ryYzek
 gVXfGY7k86hhbCmmOr7O8SZcF3hTMh3wK3ykGaecFZvNJtLkIEYrHTCkarMvW9NYdDrE
 wMkNCf6uRRRXihNx9AYYEUJkWuNSYI/BK+GlQc6gWSIWw9jwfTzuXyPMd3q0kSVToFOY
 H0iKgRJKPgGNBQCuVeuE4wQqzC7W0sKcj6K7qmXM/WPQqnBDmqjKwTNLstJ/ZLI8nUj2
 k/eA==
X-Gm-Message-State: AOAM5324HjvRAb//nWJ++1wgCdTETA/kdW+UzDkQvhzPpvTTUV8VyrWZ
 zAk5vS3jpyd7i+UheBAKKHI8TD/r/6o=
X-Google-Smtp-Source: ABdhPJwNKIVIlq3hvz5ea302H/a/KLUYiCR2buSY6rtNOqSdO1uR2qXTzfSrKQh9hKbq2W8idQV2Zw==
X-Received: by 2002:a05:600c:258e:: with SMTP id
 14mr9700588wmh.141.1596758615761; 
 Thu, 06 Aug 2020 17:03:35 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d88d:857c:b14c:519a?
 ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id r22sm8487394wmh.45.2020.08.06.17.03.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 17:03:35 -0700 (PDT)
Subject: Re: [PATCH] nvme-core: fix io interrupt when work with dm-multipah
To: "Meneghini, John" <John.Meneghini@netapp.com>,
 Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
References: <20200727055818.21430-1-lengchao@huawei.com>
 <20200728111956.GA31546@lst.de>
 <6df01884-5498-0809-b358-0c9f7d775a73@huawei.com>
 <20200729055903.GC31113@lst.de>
 <43e5dee8-1a91-4d8b-fdb5-91f9679ddeb3@huawei.com>
 <8d01b123-478f-f057-1598-8283dd099b03@huawei.com>
 <20200805152905.GB1982647@dhcp-10-100-145-180.wdl.wdc.com>
 <255d55e3-f824-a968-e478-3efeda095696@huawei.com>
 <20200806142625.GA3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <729820BC-5F38-4E22-A83A-862E57BAE201@netapp.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9d641d7d-8b3f-759b-afa5-1e5d4be0ff82@grimberg.me>
Date: Thu, 6 Aug 2020 17:03:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <729820BC-5F38-4E22-A83A-862E57BAE201@netapp.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_200338_133353_A1693A02 
X-CRM114-Status: GOOD (  28.14  )
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
Cc: Christoph Hellwig <hch@infradead.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Hannes de <hare@suse.de>, Ewan Milne <emilne@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+PiBKb2huLCBXYXQgZG8geW91IHRoaW5rIGFib3V0IGlmIGRlbGV0ZSB0cmFuc2xhdGUgTlZN
RV9TQ19DTURfSU5URVJSVVBURUQKPj4+IHRvIEJMS19TVFNfVEFSR0VUPyBUaGFuayB5b3UuCj4g
Cj4gSSB0aGluayByZXR1cm5pbmcgdG8gQkxLX1NUU19UQVJHRVQgZm9yIE5WTUVfU0NfQ01EX0lO
VEVSUlVQVEVEIGFuZCBOVk1FX1NDX05TX05PVF9SRUFEWQo+IHdhcyBhIHBvdGVudGlhbGx5IG5v
bi1iYWNrd2FyZHMgY29tcGF0aWJsZSBjaGFuZ2UgdGhhdCBLZWl0aCBtYWRlIGluIHJlc3BvbnNl
IHRvIGEgcHJvYmxlbSB0aGF0Cj4gSSByZXBvcnRlZCBpbiBwYXRjaCAzNTAzOGJmZmE4N2RhLgo+
IAo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJs
ZS9saW51eC5naXQvY29tbWl0Lz9pZD0zNTAzOGJmZmE4N2RhCj4gCj4gSSBkb27igJl0IHRoaW5r
IGl0IHdvdWxkIGJlIGEgbWlzdGFrZSB0byBiYWNrIG91dCB0aGlzIGNoYW5nZS4gIFdlJ3ZlIGhh
ZCBhIG51bWJlciBvZiBwcm9ibGVtcwo+IGluIHRoZSBkaXN0cmlidXRpb25zIHdpdGggZG0tbXAg
YW5kIG90aGVyIGxlZ2FjeSBjb2RlIGdldHRpbmcgY29uZnVzZWQgYnkgdGhpcyBjaGFuZ2UuCgog
RnJvbSB3aGF0IEkgc2VlIHRoZSBwb2ludCBvZiB0aGlzIGNoYW5nZSB3YXMgdG8gaGF2ZSB0aGVz
ZSBzdGF0dXMgY29kZXMKdG8gZG8gZXhhY3RseSB3aGF0IHRoZXkgbmVlZCB0byBkbywgdXNlIHRo
ZSBsb2NhbCByZXRyeSBmbG93LgoKPj4+IEJMS19TVFNfVEFSR0VUIG1lYW5zIHRhcmdldCBoYXMg
Y3JpdGljYWwgZXJyb3IuIE5WTUVfU0NfQ01EX0lOVEVSUlVQVEVECj4+PiBqdXN0IG1lYW5zIHRh
cmdldCBuZWVkIHJldHJ5IGlvLiBJdCBpcyBub3Qgc3VpdGFibGUgdG8gdHJhbnNsYXRlCj4+PiBO
Vk1FX1NDX0NNRF9JTlRFUlJVUFRFRCB0byBCTEtfU1RTX1RBUkdFVC4gTWF5YmUgdHJhbnNsYXRl
IHRvCj4+PiBCTEtfU1RTX0lPRVJSIGlzIGFsc28gbm90IHN1aXRhYmxlLCB3ZSBzaG91bGQgdHJh
bnNsYXRlCj4+PiBOVk1FX1NDX0NNRF9JTlRFUlJVUFRFRCB0byBCTEtfU1RTX0FHQUlOLgo+Pj4g
V2UgY2FuIGRvIGxpa2UgdGhpczoKPj4KPj4gQkxLX1NUU19BR0FJTiBpcyBhIGJhZCBjaG9pY2Ug
YXMgd2UgdXNlIGl0IGZvciBjYWxscyB0aGF0IGJsb2NrIHdoZW4KPj4gdGhlIGNhbGxlcnMgYXNr
ZWQgZm9yIG5vbi1ibG9ja2luZyBzdWJtaXNzaW9uLiAgSSdtIHJlYWxseSBub3Qgc3VyZQo+PiB3
ZSB3YW50IHRvIGNoYW5nZSBhbnl0aGluZyBoZXJlIC0gdGhlIGVycm9yIGRlZmluaXRpb24gY2xl
YXJseSBzdGF0ZXMKPj4gaXQgaXMgbm90IGEgZmFpbHVyZSBidXQgYSByZXF1ZXN0IHRvIHJldHJ5
IGxhdGVyLgo+IAo+IEFncmVlZC4gVGhlIGhpc3RvcmljYWwgYmVoYXZpb3IgaW4gbnZtZS1jb3Jl
IGhhcyBiZWVuIHRvIHJldHVybiBCTEtfU1RTX0lPRVJSIHN0YXR1cyBmb3IgYWxsIG5ldwo+IG9y
IHVua25vd24gTlZNZSBlcnJvcnMuCgpXaGljaCBpcyB0aGUgY29ycmVjdCB0aGluZyB0byBkby4K
Cj4g77u/LiAgIE9uIDgvNi8yMCwgMTA6MjYgQU0sICJLZWl0aCBCdXNjaCIgPGtidXNjaEBrZXJu
ZWwub3JnPiB3cm90ZToKPiAKPiAgICAgID4gT24gVGh1LCBBdWcgMDYsIDIwMjAgYXQgMDE6NTI6
NDJQTSArMDgwMCwgQ2hhbyBMZW5nIHdyb3RlOgo+ICAgICAgPiBOVk1FX1NDX0xCQV9SQU5HRSBz
aG91bGQgZmFpbGZhc3QsIGJlY2F1c2UgcmV0cnkgY2FuIG5vdCBzdWNjZXNzLgo+IAo+ICAgICAg
VGhlIEROUiBiaXQgaXMgaG93IE5WTWUgY29udmV5cyBzdWNoIHRoaW5ncy4KPiAKPiBJIHRoaW5r
IHRoYXQgTlZNRV9TQ19MQkFfUkFOR0UgaGFzIGhpc3RvcmljYWxseSByZXR1cm5lZCBCTEtfU1RT
X1RBUkdFVCBzbyB0aGF0Cj4gc2hvdWxkbid0IGJlIGNoYW5nZWQuICBJIGFncmVlIHRoYXQgRE5S
IC0gYW5kIG5vdyB0aGUgbmV3IEFDUkUgbWVjaGFuaXNtIC0gaXMgd2hhdAo+IHNob3VsZCBjb250
cm9sIHRoZSBjb21tYW5kIHJldHJ5IGJlaGF2aW9yIGluIE5WTWUuCgpDb21wbGV0ZWx5IGFncmVl
IGhlcmUgdG9vLgoKPiAgICAgID4gTlZNRV9TQ19OU19OT1RfUkVBRFkgbWF5IHJldHJ5IHN1Y2Nl
c3MsIGJ1dCB0aGUgcHJvYmFsaXR5IGlzIHZlcnkgbG93Lgo+ICAgICAgPiBOVk1FX1NDX0NNRF9J
TlRFUlJVUFRFRCBuZWVkIHJldHJ5LCBhY2NvcmRpbmcgdG8gcHJvdG9jb2wgZGVmaW5lLCByZXRy
eSB3aWxsIHN1Y2Nlc3MuCj4gCj4gICAgICBJZiB0aGUgdXBwZXIgbGF5ZXJzIHNldCBhIHJlcXVl
c3Qgc3VjaCB0aGF0ICJub3JldHJ5IiBpcyB0cnVlLCB0aGF0J3MKPiAgICAgIHRoZSBiZWhhdmlv
ciB5b3UncmUgZ29pbmcgdG8gZ2V0LiBTcHJpbmtsaW5nIHNwZWNpYWwgZXhjZXB0aW9ucyBhcm91
bmQKPiAgICAgIGlzIG5vdCBhIGdvb2QgaWRlYS4KPiAKPiBJIGFncmVlLgoKSSBhbHNvIDEwMCUg
YWdyZWUgaGVyZS4KCj4gSSB0aGluayB0aGUgcHJvYmxlbSBoZXJlIGlzIHRoYXQgdGhlIGN1cnJl
bnQgQkxLX1NUUyBhbmQgRkFTVF9GQUlMIG1lY2hhbmlzbXMKPiB3ZXJlIGRlc2lnbmVkIHN1cHBv
cnQgbGVnYWN5IHByb3RvY29scyBsaWtlIFNDU0kuICBUaGV5IGFzc3VtZSB0aGF0IGFsbCByZXRy
eSBiZWhhdmlvciBpcwo+IGNvbnRyb2xsZWQgYnkgb3RoZXIgY29tcG9uZW50cyBpbiB0aGUgc3Rh
Y2suICBOVk1lIGlzIHByZXNlbnRpbmcgbmV3IHByb3RvY29sIGZlYXR1cmVzCj4gYW5kIHNlbWFu
dGljcyB3aGljaCBwcm9iYWJseSBjYW4ndCBiZSBlZmZlY3RpdmVseSBzdXBwb3J0ZWQgYnkgdGhv
c2UgbGVnYWN5IEJMS19TVFMKPiBhbmQgRkFTVF9GQUlMIG1lY2hhbmlzbXMgd2l0aG91dCBwYXNz
aW5nIG1vcmUgaW5mb3JtYXRpb24gdXAgdGhlIHN0YWNrLgoKTm90IHN1cmUgaG93IGdlbmVyaWMg
dGhpcyBuZXcgYmxrIHN0YXR1cyB3b3VsZCBiZS4uIEl0IHdvdWxkIHByb2JhYmx5Cm1ha2UgYSBs
b3QgbW9yZSBzZW5zZSBvZiB0aGVyZSBhcmUgb3RoZXIgY29uc3VtZXJzIGZvciBzdWNoIGEgc3Rh
dHVzCmNvZGUuCgpNYXliZSB3ZSBjb3VsZCBzZXQgaXQgdG8gQkxLX1NUU19USU1FT1VUIHdpdGgg
YSBiaWcgZmF0IGNvbW1lbnQgZm9yIHdoeQp3ZSBhcmUgZG9pbmcgdGhpcy4uLgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5n
IGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
