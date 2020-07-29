Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0DFC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 19:34:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB4CE206D4
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 19:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qEenTatu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="V4YWPDmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4CE206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z5syIF3QNs8RMXpIpFZIDkZmnG9qrhkjIwvyaXGpiV4=; b=qEenTatuKSos97NN3uMWwkdYJ
	lqAhCV9s9Igy3hw75NUGBGSi67HYRl5LuR2s3zUOSNKi/xwY0zxt59QR+lGb8wnOYqDn14Fc9Zn20
	X3TmIts39EHUndJI4fzp7S4AZcNZkdyvgKEI/1FCpjmnlwIQ+jPu2pMVUU8hNDocjmk2ttrfQcCw6
	eJbXytNybbUhCeK+S5nPEmNotbPzceey/q4SFxowEJSoW2cNPat/Ir5v85nX3PS2he1FjE0D810VW
	UV23sHR7UppxhcrgEQkk0m50zn6fxpnVBELWlsId6lep16OJTHlKMcU8cmAUGzoTd9ymgxPRUQe57
	Sb6OTg8Ag==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0rqV-0007FO-MS; Wed, 29 Jul 2020 19:34:35 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0rqR-0007Es-Sf
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 19:34:34 +0000
Received: by mail-wr1-x444.google.com with SMTP id 88so22690191wrh.3
 for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2020 12:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=R5/41mPOQjCbbYXA5cnj/dNA42WMumYC1D6M98hT8+I=;
 b=V4YWPDmYL9jm4PmjU0SS0jdG0jPJIP/7x3kT7lQkEJOFPqOVtHOQeYMVdVraXrr32/
 uDBJQ6RDjL/A0Vzn+lmgXnWvEqBFBbLr7E7QzM4Af5xO294uPf3h+UaQeRUqP8jVNhCu
 Cg9uNukrmkm466UHhBNtIw9bW8WT5/Bnyexec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=R5/41mPOQjCbbYXA5cnj/dNA42WMumYC1D6M98hT8+I=;
 b=V3tmONVLCFc+r8mcJ+lx3C2WY6ZF7mcnlZlLCTkz2uVjXXnA3/8cJ75Lqmx2dqGM/F
 DTprpSJ6LYjnVUZ9w34XqsiqT20H52jiH4dZ1lDg4Lev5xf5h7PjXxkxXDF0y/lIkPzq
 2HN2cdwiWAlB8iK/+rQ9fLUDI2LKYLooOJk70i7J9f9ABR3Jf6ggp9r305KhpgsXCZaG
 gouweAAMBrhaXK6cc/Iy8Jse+4VTeY7Wh4n1Ee8AG1NjhgmlhCg8tq2qhxzVlT/B41az
 xAArAqmhhErS/A4MzFAZXNXF+GmmiCCZVHX0wiw/WCJ3Y/FO6SKLaE25bxahVAyKTWjo
 y1kg==
X-Gm-Message-State: AOAM532J/lO+UT/xw9N3vZ/hO3hH4btpLcYf/fd3xZXJc3NbptFIAHoz
 HCZYrzigUkmNIsUlMA1G/xFSz1GB/aVcJA==
X-Google-Smtp-Source: ABdhPJwJd4hiQ34SHkwC1AIufm7HoqgSijXYPQil5NYQ1LJhkrvtKYv5J9jLG9G3CUJ89SikdztH4A==
X-Received: by 2002:adf:ef08:: with SMTP id e8mr57113wro.164.1596051269586;
 Wed, 29 Jul 2020 12:34:29 -0700 (PDT)
Received: from [10.69.69.102] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id h10sm5923855wro.57.2020.07.29.12.34.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2020 12:34:28 -0700 (PDT)
Subject: Re: [PATCH v2] nvme-fabrics: allow to queue requests for live queues
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200729075846.22762-1-sagi@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <dcfb5abb-b740-2043-a6c2-97dca47f75e4@broadcom.com>
Date: Wed, 29 Jul 2020 12:34:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729075846.22762-1-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200729_153432_338269_C2EA83BE 
X-CRM114-Status: GOOD (  26.28  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA3LzI5LzIwMjAgMTI6NTggQU0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gUmlnaHQgbm93
IHdlIGFyZSBmYWlsaW5nIHJlcXVlc3RzIGJhc2VkIG9uIHRoZSBjb250cm9sbGVyCj4gc3RhdGUg
KHdoaWNoIGlzIGNoZWNrZWQgaW5saW5lIGluIG52bWZfY2hlY2tfcmVhZHkpIGhvd2V2ZXIKPiB3
ZSBzaG91bGQgZGVmaW5pdGVseSBhY2NlcHQgcmVxdWVzdHMgaWYgdGhlIHF1ZXVlIGlzIGxpdmUu
Cj4KPiBXaGVuIGVudGVyaW5nIGNvbnRyb2xsZXIgcmVzZXQsIHdlIHRyYW5zaXRpb24gdGhlIGNv
bnRyb2xsZXIKPiBpbnRvIE5WTUVfQ1RSTF9SRVNFVFRJTkcsIGFuZCB0aGVuIHJldHVybiBCTEtf
U1RTX1JFU09VUkNFIGZvcgo+IG5vbi1tcGF0aCByZXF1ZXN0cyAoaGF2ZSBibGtfbm9yZXRyeV9y
ZXF1ZXN0IHNldCkuCj4KPiBUaGlzIGlzIGFsc28gdGhlIGNhc2UgZm9yIE5WTUVfUkVRX1VTRVIg
Zm9yIHRoZSB3cm9uZyByZWFzb24uCj4gVGhlcmUgc2hvdWxkbid0IGJlIGFueSByZWFzb24gZm9y
IHVzIHRvIHJlamVjdCB0aGlzIEkvTyBpbiBhCj4gY29udHJvbGxlciByZXNldC4gV2UgZG8gd2Fu
dCB0byBwcmV2ZW50IHBhc3N0aHJ1IGNvbW1hbmRzIG9uCj4gdGhlIGFkbWluIHF1ZXVlIGJlY2F1
c2Ugd2UgbmVlZCB0aGUgY29udHJvbGxlciB0byBmdWxseSBpbml0aWFsaXplCj4gZmlyc3QgYmVm
b3JlIHdlIGxldCB1c2VyIHBhc3N0aHJ1IGFkbWluIGNvbW1hbmRzIHRvIGJlIGlzc3VlZC4KPgo+
IEluIGEgbm9uLW1wYXRoIHNldHVwLCB0aGlzIG1lYW5zIHRoYXQgdGhlIHJlcXVlc3RzIHdpbGwg
c2ltcGx5Cj4gYmUgcmVxdWV1ZWQgb3ZlciBhbmQgb3ZlciBmb3JldmVyIG5vdCBhbGxvd2luZyB0
aGUgcV91c2FnZV9jb3VudGVyCj4gdG8gZHJvcCBpdHMgZmluYWwgcmVmZXJlbmNlLCBjYXVzaW5n
IGNvbnRyb2xsZXIgcmVzZXQgdG8gaGFuZwo+IGlmIHJ1bm5pbmcgY29uY3VycmVudGx5IHdpdGgg
aGVhdnkgSS9PLgoKSSd2ZSBiZWVuIGxvb2tpbmcgYXQgdGhpcyB0cnlpbmcgdG8gdW5kZXJzdGFu
ZCB0aGUgcmVhbCBpc3N1ZXMuCgpGaXJzdCBpc3N1ZTogZXZlbiBpZiB0aGUgY2hlY2tfcmVhZHkg
Y2hlY2tzIHBhc3MsIHRoZXJlJ3Mgbm90aGluZyB0aGF0IApzYXlzIHRoZSB0cmFuc3BvcnQgd29u
J3QgcmV0dXJuIEJMS19TVFNfUkVTT1VSQ0UgZm9yIGl0J3Mgb3duIHJlYXNvbnMuwqAgCk1heWJl
IFRjcC9yZG1hIGRvbid0LCBidXQgRkMgZG9lcyB0b2RheSBmb3IgY2FzZXMgb2YgbG9zdCBjb25u
ZWN0aXZpdHkgLSAKYW5kIGEgbG9zcyBvZiBjb25uZWN0aXZpdHkgd2lsbCBjYXVzZSBhIFJlc2V0
dGluZyBzdGF0ZSB0cmFuc2l0aW9uLgoKSSBhZ3JlZSB3aXRoCivCoMKgwqAgaWYgKHJxLT5xID09
IGN0cmwtPmFkbWluX3EgJiYgKHJlcS0+ZmxhZ3MgJiBOVk1FX1JFUV9VU0VSQ01EKSkKY2hhbmdl
IGFzIHVudGlsIHdlIGRvIGhhdmUgYWNjZXB0YW5jZSBvZiBhIHdheSB0byBzZXJpYWxpemUvcHJp
b3JpdGl6ZSAKQ29ubmVjdCBhbmQgaW5pdGlhbGl6YXRpb24gY29tbWFuZHMuIFdlIG5lZWQgdG8g
ZG8gdGhpcy4KCldoaWNoIHRoZW4gbGVhdmVzOgpUaGUgcGF0Y2ggaXNuJ3QgY2hhbmdpbmcgYW55
IGJlaGF2aW9yIHdoZW4gISBxLT5saXZlIC0gd2hpY2ggb2NjdXJzIGluIAp0aGUgbGF0dGVyIHN0
ZXBzIG9mIFJlc2V0dGluZyBhcyB3ZWxsIGFzIG1vc3Qgb2YgdGhlIENvbm5lY3Rpbmcgc3RhdGUu
wqAgClNvIGFueSBJL08gcmVjZWl2ZWQgd2hpbGUgIXEtPmxpdmUgaXMgc3RpbGwgZ2V0dGluZyBx
dWV1ZWQvcmV0cmllZC4gU28gCndoYXQgd2FzIHRoZSBwcm9ibGVtID/CoCBJdCBoYXMgdG8gYmUg
bGltaXRlZCBpbiBzY29wZSB0byBlaXRoZXIgdGhlIApzdGFydCBvZiB0aGUgUmVzZXR0aW5nIHN0
YXRlIHdoaWxlIHEtPmxpdmUgaGFkIHlldCB0byB0cmFuc2l0aW9uIHRvIAohbGl2ZS4gQnV0IEkg
ZG9uJ3Qgc2VlIGFueSBmcmVlemluZyBpbiB0aGlzIHBhdGguCgpMb29raW5nIGF0IHRoZSBvcmln
aW5hbCBwcm9ibGVtIHRoYXQgbG9jayB1cHMgYXJlOgoxKSB0aGUgc3lzZnMgd3JpdGUgdG8gZG8g
YSByZXNldCAtIHdoaWNoIGlzIHN0YWxsZWQgd2FpdGluZyBvbiBhIGZsdXNoIApvZiByZXNldF93
b3JrCjIpIHJlc2V0X3dvcmsgaXMgc3RhbGxlZCBvbiBhIGNhbGwgdG8gYmxrX21xX3VwZGF0ZV9u
cl9od19xdWV1ZXMoKSB3aGljaCAKdGhlbiBkb2VzIGEgYmxrX21xX2ZyZWV6ZV9xdWV1ZV93YWl0
LgoKVGhlIDJuZCBvbmUgaXMgb2RkIGluIG15IG1pbmQgYXMgdGhlIHRoZSB1cGRhdGVfbnJfaHdf
cXVldWVzIGlzIApzb21ldGhpbmcgZG9uZSB3aGlsZSBjb25uZWN0aW5nIGFuZCBJIHdvdWxkbid0
IHRoaW5rIHRoZSByZXNldCBmbHVzaCAKbXVzdCB3YWl0IGZvciBhIHJlY29ubmVjdCBhcyB3ZWxs
LsKgIEFsdGhvdWdoIG5vdCB0aGUgZml4LCBJJ2QgcmVjb21tZW5kIAp0byBub3QgY2FsbCBudm1l
X3RjcF9zZXR1cF9jdHJsKCkgZnJvbSByZXNldF93b3JrIGFuZCBpbnN0ZWFkIGhhdmUgaXQgCnNj
aGVkdWxlIG52bWVfdGNwX3JlY29ubmVjdF9jdHJsX3dvcmsoKS4KCkFzIHRjcCBkaWQgY2hhbmdl
IHN0YXRlIHRvIENvbm5lY3RpbmcgYmVmb3JlIG1ha2luZyB0aGUgCnVwZGF0ZV9ucl9od19xdWV1
ZXMgY2FsbCwgeWV0IHdlIGRpZG4ndCBjaGFuZ2UgdGhlIGJlaGF2aW9yIG9mIApyZXNjaGVkdWxp
bmcgaWYgQ29ubmVjdGluZyBhbmQgIXEtPmxpdmUsIHdoYXQgZGlkIHRoZSBwYXRjaCBhY3R1YWxs
eSBkbyAKdG8gaGVscCA/wqAgVGhlIHBhdGNoIG9ubHkgY2hhbmdlZCB0aGUgcXVldWluZyBiZWhh
dmlvciBmb3IgQ29ubmVjdGluZyAKYW5kIHEtPmxpdmUuwqAgU28gd2hldGhlciBvciBub3Qgd2Ug
aGl0IGl0IGlzIGRlcGVuZGVudCBvbiB0aGUgdGltaW5nIG9mIAp3aGVuIGEgbmV3IGlvIGlzIHJl
Y2VpdmVkIHZzIHRoZSBjYWxsIHRvIGhyX2h3X3F1ZXVlcy7CoMKgIFRoZSBwYXRjaCAKZGlkbid0
IGhlbHAgdGhpcy4KCi0tIGphbWVzCgoKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtbnZtZQo=
