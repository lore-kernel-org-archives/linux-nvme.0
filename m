Return-Path: <SRS0=Ayoq=4V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDF6C3F2CD
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 06:57:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F262D2073D
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 06:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lqYrqMXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F262D2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NRSJh05i5CAmUTKrTe5hjOVBKkCODAS1u6v1rPbaioQ=; b=lqYrqMXEQqgJ9E
	gI76mSNhXUlTBRKAnblErg5KuLGMkflZlh9j2ybAN1nIm5XkmIHKV6JjAxJu8XjrLf1Uj9+cYqCZk
	U45BgxGCeFZhxkFpuhPf6DTdoMoPxIG0GZi+oavkx2dJc1fV9N5Yht5X2N79rX+BKOcYt+rm0Ke4b
	3iXhc/KVPHYNFa3kJv2rdZ3GQjqtj2BCf8jFXWnkbTdh/z6UnvcywLR5ipyQH1OHSXd9CvCL3xOSV
	BE1E0/C814KcFl+qHS3YK72Foc201GnHZ8JUVAUN/uyOUaOZavUr6aENZnjsOfa8pIZXABDO0u0Ol
	rW4knIThmWGv4E3shN8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9Nxt-0003eO-83; Wed, 04 Mar 2020 06:57:09 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9Nxq-0003dd-3K
 for linux-nvme@lists.infradead.org; Wed, 04 Mar 2020 06:57:08 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7C7ECB2DA;
 Wed,  4 Mar 2020 06:57:02 +0000 (UTC)
Subject: Re: [RFC PATCH] megaraid_sas : threaded irq hybrid polling
To: Kashyap Desai <kashyap.desai@broadcom.com>, linux-scsi@vger.kernel.org
References: <1581940533-13795-1-git-send-email-kashyap.desai@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 mQINBE6KyREBEACwRN6XKClPtxPiABx5GW+Yr1snfhjzExxkTYaINHsWHlsLg13kiemsS6o7
 qrc+XP8FmhcnCOts9e2jxZxtmpB652lxRB9jZE40mcSLvYLM7S6aH0WXKn8bOqpqOGJiY2bc
 6qz6rJuqkOx3YNuUgiAxjuoYauEl8dg4bzex3KGkGRuxzRlC8APjHlwmsr+ETxOLBfUoRNuE
 b4nUtaseMPkNDwM4L9+n9cxpGbdwX0XwKFhlQMbG3rWA3YqQYWj1erKIPpgpfM64hwsdk9zZ
 QO1krgfULH4poPQFpl2+yVeEMXtsSou915jn/51rBelXeLq+cjuK5+B/JZUXPnNDoxOG3j3V
 VSZxkxLJ8RO1YamqZZbVP6jhDQ/bLcAI3EfjVbxhw9KWrh8MxTcmyJPn3QMMEp3wpVX9nSOQ
 tzG72Up/Py67VQe0x8fqmu7R4MmddSbyqgHrab/Nu+ak6g2RRn3QHXAQ7PQUq55BDtj85hd9
 W2iBiROhkZ/R+Q14cJkWhzaThN1sZ1zsfBNW0Im8OVn/J8bQUaS0a/NhpXJWv6J1ttkX3S0c
 QUratRfX4D1viAwNgoS0Joq7xIQD+CfJTax7pPn9rT////hSqJYUoMXkEz5IcO+hptCH1HF3
 qz77aA5njEBQrDRlslUBkCZ5P+QvZgJDy0C3xRGdg6ZVXEXJOQARAQABtCpIYW5uZXMgUmVp
 bmVja2UgKFN1U0UgTGFicykgPGhhcmVAc3VzZS5kZT6JAkEEEwECACsCGwMFCRLMAwAGCwkI
 BwMCBhUIAgkKCwQWAgMBAh4BAheABQJOisquAhkBAAoJEGz4yi9OyKjPOHoQAJLeLvr6JNHx
 GPcHXaJLHQiinz2QP0/wtsT8+hE26dLzxb7hgxLafj9XlAXOG3FhGd+ySlQ5wSbbjdxNjgsq
 FIjqQ88/Lk1NfnqG5aUTPmhEF+PzkPogEV7Pm5Q17ap22VK623MPaltEba+ly6/pGOODbKBH
 ak3gqa7Gro5YCQzNU0QVtMpWyeGF7xQK76DY/atvAtuVPBJHER+RPIF7iv5J3/GFIfdrM+wS
 BubFVDOibgM7UBnpa7aohZ9RgPkzJpzECsbmbttxYaiv8+EOwark4VjvOne8dRaj50qeyJH6
 HLpBXZDJH5ZcYJPMgunghSqghgfuUsd5fHmjFr3hDb5EoqAfgiRMSDom7wLZ9TGtT6viDldv
 hfWaIOD5UhpNYxfNgH6Y102gtMmN4o2P6g3UbZK1diH13s9DA5vI2mO2krGz2c5BOBmcctE5
 iS+JWiCizOqia5Op+B/tUNye/YIXSC4oMR++Fgt30OEafB8twxydMAE3HmY+foawCpGq06yM
 vAguLzvm7f6wAPesDAO9vxRNC5y7JeN4Kytl561ciTICmBR80Pdgs/Obj2DwM6dvHquQbQrU
 Op4XtD3eGUW4qgD99DrMXqCcSXX/uay9kOG+fQBfK39jkPKZEuEV2QdpE4Pry36SUGfohSNq
 xXW+bMc6P+irTT39VWFUJMcSuQINBE6KyREBEACvEJggkGC42huFAqJcOcLqnjK83t4TVwEn
 JRisbY/VdeZIHTGtcGLqsALDzk+bEAcZapguzfp7cySzvuR6Hyq7hKEjEHAZmI/3IDc9nbdh
 EgdCiFatah0XZ/p4vp7KAelYqbv8YF/ORLylAdLh9rzLR6yHFqVaR4WL4pl4kEWwFhNSHLxe
 55G56/dxBuoj4RrFoX3ynerXfbp4dH2KArPc0NfoamqebuGNfEQmDbtnCGE5zKcR0zvmXsRp
 qU7+caufueZyLwjTU+y5p34U4PlOO2Q7/bdaPEdXfpgvSpWk1o3H36LvkPV/PGGDCLzaNn04
 BdiiiPEHwoIjCXOAcR+4+eqM4TSwVpTn6SNgbHLjAhCwCDyggK+3qEGJph+WNtNU7uFfscSP
 k4jqlxc8P+hn9IqaMWaeX9nBEaiKffR7OKjMdtFFnBRSXiW/kOKuuRdeDjL5gWJjY+IpdafP
 KhjvUFtfSwGdrDUh3SvB5knSixE3qbxbhbNxmqDVzyzMwunFANujyyVizS31DnWC6tKzANkC
 k15CyeFC6sFFu+WpRxvC6fzQTLI5CRGAB6FAxz8Hu5rpNNZHsbYs9Vfr/BJuSUfRI/12eOCL
 IvxRPpmMOlcI4WDW3EDkzqNAXn5Onx/b0rFGFpM4GmSPriEJdBb4M4pSD6fN6Y/Jrng/Bdwk
 SQARAQABiQIlBBgBAgAPBQJOiskRAhsMBQkSzAMAAAoJEGz4yi9OyKjPgEwQAIP/gy/Xqc1q
 OpzfFScswk3CEoZWSqHxn/fZasa4IzkwhTUmukuIvRew+BzwvrTxhHcz9qQ8hX7iDPTZBcUt
 ovWPxz+3XfbGqE+q0JunlIsP4N+K/I10nyoGdoFpMFMfDnAiMUiUatHRf9Wsif/nT6oRiPNJ
 T0EbbeSyIYe+ZOMFfZBVGPqBCbe8YMI+JiZeez8L9JtegxQ6O3EMQ//1eoPJ5mv5lWXLFQfx
 f4rAcKseM8DE6xs1+1AIsSIG6H+EE3tVm+GdCkBaVAZo2VMVapx9k8RMSlW7vlGEQsHtI0FT
 c1XNOCGjaP4ITYUiOpfkh+N0nUZVRTxWnJqVPGZ2Nt7xCk7eoJWTSMWmodFlsKSgfblXVfdM
 9qoNScM3u0b9iYYuw/ijZ7VtYXFuQdh0XMM/V6zFrLnnhNmg0pnK6hO1LUgZlrxHwLZk5X8F
 uD/0MCbPmsYUMHPuJd5dSLUFTlejVXIbKTSAMd0tDSP5Ms8Ds84z5eHreiy1ijatqRFWFJRp
 ZtWlhGRERnDH17PUXDglsOA08HCls0PHx8itYsjYCAyETlxlLApXWdVl9YVwbQpQ+i693t/Y
 PGu8jotn0++P19d3JwXW8t6TVvBIQ1dRZHx1IxGLMn+CkDJMOmHAUMWTAXX2rf5tUjas8/v2
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <4c89034d-d56e-567a-2f84-e3aca41c3f6b@suse.de>
Date: Wed, 4 Mar 2020 07:57:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1581940533-13795-1-git-send-email-kashyap.desai@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200303_225706_434056_AD30D305 
X-CRM114-Status: GOOD (  19.25  )
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
Cc: axboe@kernel.dk, martin.petersen@oracle.com, sumanesh.samanta@broadcom.com,
 linux-nvme@lists.infradead.org, ming.lei@redhat.com, kbusch@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8xNy8yMCAxMjo1NSBQTSwgS2FzaHlhcCBEZXNhaSB3cm90ZToKPiBIaWdoIHBlcmZvcm1h
bmNlIEhCQXMgdW5kZXIgc2NzaSBsYXllciBjYW4gcmVhY2ggbW9yZSB0aGFuIDMuME0gSU9Qcy4K
PiBNZWdhUmFpZCBBZXJvIGNvbnRyb2xsZXIgY2FuIGFjaGlldmUgdG8gMy4zTSBJT1BzLkluIGZ1
dHVyZSB0aGVyZSBtYXkgYmUgcmVxdWlyZW1lbnQgdG8gcmVhY2ggNi4wKyBNIElPUHMuCj4gT25l
IG9mIHRoZSBrZXkgYm90dGxlbmVja3MgaXMgc2VydmluZyBpbnRlcnJ1cHRzIGZvciBlYWNoIElP
IGNvbXBsZXRpb24uCj4gQmxvY2sgbGF5ZXIgaGFzIGludGVyZmFjZSBibGtfcG9sbCB3aGljaCBj
YW4gYmUgdXNlZCBhcyB6ZXJvIGludGVycnVwdCBwb2xsIHF1ZXVlLgo+IEV4dGVuZGluZyBibGtf
cG9sbCB0byBzY3NpIG1pZCBsYXllciBoZWxwcyBhbmQgSSB3YXMgYWJsZSB0byBnZXQgbWF4IElP
UHMgc2FtZSBhcyBudm1lIDxwb2xsX3F1ZXVlcz4gaW50ZXJmYWNlLgo+IAo+IGJsa19wb2xsIGlz
IGN1cnJlbnRseSBtZXJnZWQgd2l0aCBpb191cmluZyBpbnRlcmZhY2UgYW5kIGl0IHJlcXVpcmVz
IGFwcGxpY2F0aW9uIGNoYW5nZSB0byBhZG9wdCBibGtfcG9sbC4KPiAKPiBUaGlzIFJGQyBjb3Zl
cnMgdGhlIGxvZ2ljIG9mIGhhbmRsaW5nIGlycSBwb2xsaW5nIGluIGRyaXZlciB1c2luZyB0aHJl
YWRlZCBJU1IgaW50ZXJmYWNlLgo+IENoYW5nZXMgaW4gdGhpcyBSRkMgaXMgZGVzY3JpYmVkIGFz
IGJlbG93IC0KPiAKPiAtIFVzZSBUaHJlYWRlZCBJU1IgaW50ZXJmYWNlLgo+IC0gUHJpbWFyeSBJ
U1IgaGFuZGxlciBydW5zIGZyb20gaC93IGludGVycnVwdCBjb250ZXh0Lgo+IC0gU2Vjb25kYXJ5
IElTUiBoYW5kbGVyIHJ1bnMgZnJvbSB0aHJlYWQgY29udGV4dC4KPiAtIERyaXZlciB3aWxsIGRy
YWluIHJlcGx5IHF1ZXVlIGZyb20gUHJpbWFyeSBJU1IgaGFuZGxlciBmb3IgZXZlcnkgaW50ZXJy
dXB0IGl0IHJlY2VpdmVzLgo+IC0gUHJpbWFyeSBoYW5kbGVyIHdpbGwgZGVjaWRlIHRvIGNhbGwg
U2Vjb25kYXJ5IGhhbmRsZXIgb3Igbm90Lgo+ICAgVGhpcyBpbnRlcmZhY2UgY2FuIGJlIG9wdGlt
aXplZCBsYXRlciwgaWYgZHJpdmVyIG9yIGJsb2NrIGxheWVyIGtlZXAgc3VibWlzc2lvbiBhbmQg
Y29tcGxldGlvbiBzdGF0cyBwZXIgZWFjaCBoL3cgcXVldWUuCj4gICBDdXJyZW50IG1lZ2FyYWlk
X3NhcyBkcml2ZXIgaXMgc2luZ2xlIGgvdyBxdWV1ZSBiYXNlZCwgc28gSSBoYXZlIHBpY2tlZCBi
ZWxvdyBkZWNpc2lvbiBtYWtlci4KPiAgIElmIHBlciBzY3NpIGRldmljZSBoYXMgb3V0c3RhbmRp
bmcgY29tbWFuZCBtb3JlIHRoYW4gOCwgbWFyayB0aGF0IG1zaXggaW5kZXggYXMg4oCcYXR0ZW1w
dF9pcnFfcG9sbOKAnS4KPiAtIEV2ZXJ5IHRpbWUgc2Vjb25kYXJ5IElTUiBoYW5kbGVyIHJ1bnMs
IHByaW1hcnkgaGFuZGxlciB3aWxsIGRpc2FibGUgSVJRLgo+ICAgT25jZSBzZWNvbmRhcnkgaGFu
ZGxlciBjb21wbGV0ZXMgdGhlIHRhc2ssIGl0IHdpbGwgcmUtZW5hYmxlIElSUS4KPiAgIElmIHRo
ZXJlIGlzIG5vIGNvbXBsZXRpb24sIGxldCdzIHdhaXQgZm9yIHNvbWUgdGltZSBhbmQgcmV0cnkg
cG9sbGluZyBhcyBlbmFibGUvZGlzYWJsZSBpcnEgaXMgZXhwZW5zaXZlIG9wZXJhdGlvbi4KPiAg
IFdpdGhvdXQgdGhpcyB3YWl0IGluIHRocmVhZGVkIElSUSBwb2xsaW5nLCB3ZSB3aWxsIG5vdCBh
bGxvdyBzdWJtaXR0ZXIgdG8gdXNlIENQVSBhbmQgcHVtcCBtb3JlIElPLgo+IAo+IE5WTUUgZHJp
dmVyIGlzIGFsc28gdHJ5aW5nIHNvbWV0aGluZyBzaW1pbGFyIHRvIHJlZHVjZSBJU1Igb3Zlcmhl
YWQuCj4gRGlzY3Vzc2lvbiBzdGFydGVkIGluIERlYy0yMDE5Lgo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LW52bWUvMjAxOTEyMDkxNzU2MjIuMTk2NC0xLWtidXNjaEBrZXJuZWwub3Jn
Lwo+IApJIGFjdHVhbGx5IHdvdWxkIGxpa2UgdG8gaGF2ZSBzb21ldGhpbmcgbW9yZSBnZW5lcmlj
OyB0aHJlYWRlZCBpcnEKcG9sbGluZyBsb29rcyBsaWtlIHNvbWV0aGluZyB3aGVyZSBtb3N0IGhp
Z2gtcGVyZm9ybWFuY2UgZHJpdmVycyB3b3VsZApiZW5lZml0IGZyb20uClNvIEkgdGhpbmsgaXQg
bWlnaHQgYmUgd29ydGh3aGlsZSBwb3N0aW5nIGEgdG9waWMgZm9yIExTRi9NTSB0byBoYXZlIGEK
YnJvYWRlciBkaXNjdXNzaW9uLgoKVGhpbmcgaXMsIEkgd29uZGVyIGlmIGl0IHdvdWxkbid0IGJl
IG1vcmUgZWZmaWNpZW50IGZvciBoaWdoLXBlcmZvcm1hbmNlCmRldmljZXMgdG8gZmlyc3QgdHJ5
IGZvciBjb21wbGV0aW9ucyBpbi1saW5lLCBpZSBzdGFydCB3aXRoIHBvbGxpbmcKX2ZpcnN0Xywg
dGhlbiBlbmFibGUgaW50ZXJydXB0IGhhbmRsZXIsIGFuZCB0aGVuIHNoaWZ0IHRvIHBvbGxpbmcg
Zm9yCm1vcmUgY29tcGxldGlvbnMuCkJ1dCB0aGlzIHdpbGwgaW52b2x2ZSB0aW1lb3V0cyB3aGlj
aCBwcm9iYWJseSB3b3VsZCBiZSBuZWVkIHRvIGJlCnR3ZWFrZWQgcGVyIGhhcmR3YXJlL2RyaXZl
cjsgb25lIGNvdWxkIGV2ZW4gbG9vayBpbnRvIGRpc2FibGUgaW5kaXZpZHVhbApmdW5jdGlvbmFs
aXR5IGNvbXBsZXRlbHkgKGlmIHlvdSBkaXNhYmxlIHRoZSBmaXJzdCBhbmQgdGhlIGxhc3QgcGFy
dAp5b3UncmUgYmFjayB0byB0aGUgb3JpZ2luYWwgaW1wbGVtZW50YXRpb24sIGlmIHlvdSBkaXNh
YmxlIHRoZSBmaXJzdAppdCdzIHRoZSBhbGdvcml0aG0geW91IHByb3Bvc2VkKS4KCkJ1dCBhcyBJ
IHNhaWQsIHRoYXQgcHJvYmFibHkgd2FycmFudHMgYSB3aWRlciBkaXNjdXNzaW9uLgoKQ2hlZXJz
LAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgICAgIEtlcm5lbCBTdG9y
YWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAgICAgICArNDkgOTExIDc0
MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIE1heGZlbGRzdHIu
IDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBGZWxpeCBJ
bWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
