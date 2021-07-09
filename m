Return-Path: <SRS0=jeJI=MB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBFFC07E99
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 04:58:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70A3461441
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 04:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A3461441
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L73vG0Se+P1cHeYth386+f98mE+Ax3BQ/InT8M507EY=; b=B473I8mVyOaTbmF6mCviGZq+JZ
	zD0KBP+LuFyeauPXdQZ0LDsljEOnq1yPoDc5BbqZfr2ZOUuGxgmnOSOsRkhp/23suyvNenI17B0pt
	z60iyruAqPsAEzYYJR92jHqmbJhgnmj+PE6h/dDfEfxYQUKsc17FfVBFJiMwEtmI/MIs+22qg16rh
	YDwA8cJC7tGXBjhDjSi7le/4OGdeb8VcykAq2jKywh20gI9y5O+OaXXfVxbQIEXG/5VpaqZbwdf4O
	LkLZA7M2Nfu3BR3eDjCq0WOVBjGCX2m55v9nHtwTg1+baAumjjzkyGWUkV4Gd8f6yPZLPv1cfHZMW
	F35gqJHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1iaO-000mZI-31; Fri, 09 Jul 2021 04:58:00 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1iaL-000mYf-1d
 for linux-nvme@lists.infradead.org; Fri, 09 Jul 2021 04:57:58 +0000
Received: by mail-pj1-x102b.google.com with SMTP id n11so5108496pjo.1
 for <linux-nvme@lists.infradead.org>; Thu, 08 Jul 2021 21:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Byilgdf+/pjp2opZ5gRLRRZXZBb8ZICnfIxWuK3WRqA=;
 b=CpKoPvmigFrVFph+AOIhDJxXRCnPRldRr3FpRXrqD7DKl6O7VV42E8lt2ubQhzvIpU
 16NeEcN76mR40AaR7GsPjxkVRF9jLzezFrpjAq6w7tXYHh/leSARlCELOXKkC6ua6t/X
 BNjXowtNXIAl2/os8UhNinNtmqWrYLSeSybwyXQkjvK4JUdyuoGykU0k/GlMylBl7ooM
 xt0oKhh9RlRFSfYIaV+ndw5xac4DvEhzzYaDLQYfQfZ+yWYj74BTAYuIqQPx1iMtDb43
 tF0fjLWd+zUU6+b1+QKILdrujfPGmI1DYeM1DN27r90GXr9DepwcSuw3Pghtz/BwDfoU
 csEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Byilgdf+/pjp2opZ5gRLRRZXZBb8ZICnfIxWuK3WRqA=;
 b=aKt+5ezT1nf6hiWj5Ua//dQErU1Ky01P7iJujx5+7TqvslZi6xKQnWwWAc/i+ZTjvt
 HTaXcERuwbLsxjtG/J7zyZl97LTyF+6DiX8j1wwnz4BhvTmd5CTCHadQTlVe6wbOpNBz
 xW3Mj+zLiNvZmJbvqzvH5FsYjfJGQGNuTWAPgeJP3lVprUJgw/lcIjOnBnoZFbpYZ2HC
 xv70mz2ikHg6cnict6+S+HVzBGy/+WNTJh1eB0MmOsGzgkfz0ny2bEC85pM6TyJs7GI5
 AZqtu24LAbftWxfo9G97mx2ApLblCLpjAmS3OT/j0upsT5OZXY4Hg5ZbbEWPkdyDtMbS
 ZLNg==
X-Gm-Message-State: AOAM5337dQAGVRsD7oD0RcAAW/IduKbBo/5lTybf3sN+Ng3z+Xvfjoyr
 rS9r4J/rU6ipYMCKp/qoS9P/ZdJQiJA=
X-Google-Smtp-Source: ABdhPJy6ZqD6DWhcm/Gd+liYyyDM6CKQ9vKd2HP/49VXyX+YWtPWyF0goCz7YEOdzwyxi2JW83U62g==
X-Received: by 2002:a17:902:6bc6:b029:122:68ea:32f3 with SMTP id
 m6-20020a1709026bc6b029012268ea32f3mr29414542plt.43.1625806675365; 
 Thu, 08 Jul 2021 21:57:55 -0700 (PDT)
Received: from [192.168.1.30] (ip174-67-196-173.oc.oc.cox.net.
 [174.67.196.173])
 by smtp.gmail.com with ESMTPSA id me4sm4116690pjb.4.2021.07.08.21.57.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jul 2021 21:57:54 -0700 (PDT)
Subject: Re: [PATCH 0/2] nvme-fabrics: short-circuit connect retries
To: Chao Leng <lengchao@huawei.com>, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210623143250.82445-1-hare@suse.de>
 <8d7c79d9-0928-8c71-74fd-7185d67e7895@grimberg.me>
 <204a6656-ef83-b688-4979-26fe17f57974@suse.de>
 <cdf40226-12ed-5f87-8549-10b4defceae5@huawei.com>
 <91ff9961-6537-05d1-c552-18a02d13bf0c@suse.de>
 <984b2d1a-f319-1a09-7347-6c4edd1dbab6@huawei.com>
 <d20b23fc-dd08-cb51-eb29-aa033810b0a4@suse.de>
 <caa3759f-9a72-5e3b-9097-700132e4ab63@gmail.com>
 <28ec79af-beb0-8ef9-ab6a-d608a632ee2c@huawei.com>
 <0af5901a-4dab-70de-abda-00ed7f8cf45f@suse.de>
 <c5ddf523-af8c-eae0-03fc-6c64d0df9e7c@huawei.com>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <f4d95ae8-7c7b-275b-0436-863c5add25cb@gmail.com>
Date: Thu, 8 Jul 2021 21:57:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c5ddf523-af8c-eae0-03fc-6c64d0df9e7c@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210708_215757_156794_B14EE617 
X-CRM114-Status: GOOD (  31.52  )
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

T24gNy83LzIwMjEgMTE6MjkgUE0sIENoYW8gTGVuZyB3cm90ZToKPiAKPiAKPiBPbiAyMDIxLzYv
MjkgMTk6MDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4gT24gNi8yOC8yMSAzOjEwIEFNLCBD
aGFvIExlbmcgd3JvdGU6Cj4+Pgo+Pj4KPj4+IE9uIDIwMjEvNi8yNyAyMTozOSwgSmFtZXMgU21h
cnQgd3JvdGU6Cj4+Pj4gT24gNi8yNi8yMDIxIDU6MDkgQU0sIEhhbm5lcyBSZWluZWNrZSB3cm90
ZToKPj4+Pj4gT24gNi8yNi8yMSAzOjAzIEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4+Pj4+Pgo+Pj4+
Pj4KPj4+Pj4+IE9uIDIwMjEvNi8yNCAxNjoxMCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+Pj4+
Pj4+IE9uIDYvMjQvMjEgOToyOSBBTSwgQ2hhbyBMZW5nIHdyb3RlOgo+Pj4+Pj4+Pgo+Pj4+Pj4+
Pgo+Pj4+Pj4+PiBPbiAyMDIxLzYvMjQgMTM6NTEsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4+
Pj4+Pj4+IE9uIDYvMjMvMjEgMTE6MzggUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4+Pj4+Pj4+
Pj4KPj4+Pj4+Pj4+Pj4gSGkgYWxsLAo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiBjb21taXQgZjI1
ZjhlZjcwY2UyICgibnZtZS1mYzogc2hvcnQtY2lyY3VpdCByZWNvbm5lY3QgcmV0cmllcyIpCj4+
Pj4+Pj4+Pj4+IGFsbG93ZWQgdGhlIGZjIHRyYW5zcG9ydCB0byBob25vdXIgdGhlIEROUiBiaXQg
ZHVyaW5nIHJlY29ubmVjdAo+Pj4+Pj4+Pj4+PiByZXRyaWVzLCBhbGxvd2luZyB0byBzcGVlZCB1
cCBlcnJvciByZWNvdmVyeS4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IEhvdyBkb2VzIHRoaXMgc3Bl
ZWQgdXAgZXJyb3IgcmVjb3Zlcnk/Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gV2VsbCwgbm90IGV4YWN0
bHkgZXJyb3IgcmVjb3ZlcnkgKGFzIHRoZXJlIGlzIG5vdGhpbmcgdG8gcmVjb3ZlcikuCj4+Pj4+
Pj4+PiBCdXQgd2Ugd29uJ3QgYXR0ZW1wdCBwb2ludGxlc3MgcmV0cmllcywgdGhlcmVieSByZWR1
Y2luZyB0aGUgCj4+Pj4+Pj4+PiBub2lzZSBpbgo+Pj4+Pj4+Pj4gdGhlIG1lc3NhZ2UgbG9nLgo+
Pj4+Pj4+PiBUaGlzIGNvbmZsaWN0IHdpdGggdGhlIHRjcCBhbmQgcmRtYSB0YXJnZXQuCj4+Pj4+
Pj4+IFlvdSBtYXkgbmVlZCB0byBkZWxldGUgdGhlIGltcHJvcGVyIE5WTUVfU0NfRE5SIGF0IHRo
ZSB0YXJnZXQuCj4+Pj4+Pj4+IEhvd2V2ZXIsIHRoaXMgd2lsbCBjYXVzZSBjb21wYXRpYmlsaXR5
IGlzc3VlcyBiZXR3ZWVuIGRpZmZlcmVudCAKPj4+Pj4+Pj4gdmVyc2lvbnMuCj4+Pj4+Pj4KPj4+
Pj4+PiBXaGljaCBvbmVzPwo+Pj4+Pj4gSW4gbWFueSBzY2VuYXJpb3MsIHRoZSBkZXN0aW5hdGlv
biBzZXRzIEROUiBmb3IgYWJub3JtYWwgcGFja2V0cywKPj4+Pj4+IGJ1dCBlYWNoIG5ldyBjb25u
ZWN0aW9uIG1heSBub3QgaGF2ZSB0aGUgc2FtZSBlcnJvci4KPj4+Pj4KPj4+Pj4gVGhpcyBwYXRj
aCBzZXJpZXMgaXMgb25seSBmb3IgdGhlIEROUiBiaXQgc2V0IGluIHJlc3BvbnNlIHRvIHRoZSAK
Pj4+Pj4gJ2Nvbm5lY3QnIGNvbW1hbmQuCj4+Pj4+IElmIHRoZSB0YXJnZXQgaXMgbm90IGFibGUg
dG8gcHJvY2VzcyB0aGUgJ2Nvbm5lY3QnIGNvbW1hbmQsIGJ1dCBtYXkgCj4+Pj4+IGJlIHNvIGlu
IHRoZSBmdXR1cmUgaXQgcmVhbGx5IHNob3VsZCBub3Qgc2V0IHRoZSBETlIgYml0Lgo+Pj4+Pgo+
Pj4+Pj4+IEkgY2hlY2tlZCB0aGUgRE5SIHVzYWdlIGluIHRoZSB0YXJnZXQgY29kZSwgYW5kIHRo
ZXkgc2VlbSB0byBzZXQgaXQKPj4+Pj4+PiBjb3JyZWN0bHkgKGllIHRoZSByZXN1bHQgd291bGQg
bm90IGNoYW5nZSB3aGVuIHRoZSBjb21tYW5kIGlzIAo+Pj4+Pj4+IHJldHJpZWQpLgo+Pj4+Pj4+
IFdpdGggdGhlIHBvc3NpYmxlIGV4Y2VwdGlvbiBvZiBFTk9TUEMgaGFuZGxpbmcsIGFzIHRoaXMg
aXMgYXJndWFibHkKPj4+Pj4+PiBkeW5hbWljIGFuZCBtaWdodCBjaGFuZ2Ugd2l0aCBhIHJldHJ5
Lgo+Pj4+Pj4gVGhlIEROUiBzdGF0dXMgb2YgdGhlIG9sZCBjb25uZWN0aW9uIG1heSBub3QgYmUg
cmVsZXZhbnQgdG8gdGhlIAo+Pj4+Pj4gcmUtZXN0YWJsaXNoZWQgY29ubmVjdGlvbi4KPj4+Pj4K
Pj4+Pj4gU2VlIGFib3ZlLgo+Pj4+PiBXZSBhcmUganVzdCBjaGVja2luZyB0aGUgRE5SIHNldHRp
bmdzIGZvciB0aGUgJ2Nvbm5lY3QnIGNvbW1hbmQgKG9yIAo+Pj4+PiBhbnkgb3RoZXIgY29tbWFu
ZHMgYmVpbmcgc2VudCBkdXJpbmcgaW5pdGlhbCBjb250cm9sbGVyIAo+Pj4+PiBjb25maWd1cmF0
aW9uKS4KPj4+Pj4gSWYgdGhhdCBmYWlscyB0aGUgY29ubmVjdCBuZXZlciB3YXMgcHJvcGVybHkg
aW5pdGlhbGl6ZWQ7IGlmIHRoZSAKPj4+Pj4gY29udHJvbGxlciB3b3VsZCByZXR1cm4gYSBkaWZm
ZXJlbnQgc3RhdHVzIGFmdGVyIHJlY29ubmVjdCBpdCAKPj4+Pj4gc2ltcGx5IHNob3VsZCBub3Qg
c2V0IHRoZSBETlIgYml0IC4uLgo+Pj4+Pgo+Pj4+PiBDaGVlcnMsCj4+Pj4+Cj4+Pj4+IEhhbm5l
cwo+Pj4+Cj4+Pj4gQWdyZWVkLiBTaW5jZSAxLjMgc3BlYyBzYXlzOiAiSWYgc2V0IHRvIOKAmDHi
gJksIGluZGljYXRlcyB0aGF0IGlmIHRoZSAKPj4+PiBzYW1lIGNvbW1hbmQgaXMgcmUtc3VibWl0
dGVkIHRvIGFueSBjb250cm9sbGVyIGluIHRoZSBOVk0gc3Vic3lzdGVtLCAKPj4+PiB0aGVuIHRo
YXQgcmUtc3VibWl0dGVkIGNvbW1hbmQgaXMgZXhwZWN0ZWQgdG8gZmFpbC4iCj4+PiBBY2NvcmRp
bmcgdG8gdGhlIGRlZmluaXRpb24gb2YgdGhlIHByb3RvY29sLCB0aGlzIGlzIG5vdCBzdHJpY3Rs
eSAKPj4+IGltcGxlbWVudGVkIG9uIHRoZSB0YXJnZXQgc2lkZS4KPj4+IEluIG52bWUvdGFyZ2V0
LCB0aGVyZSBhcmUgbWFueSBleHRlcm5hbCBlcnJvcnMsIHRoZSBETlIgaXMgc2V0IHRvIDEuCj4+
PiBGb3IgZXhhbXBsZSwgYWJvcm1hbCBmYWJyaWNzIGNtZC4KPj4KPj4gWWVzOyBidXQgYW4gYWJu
b3JtYWwgZmFicmljcyBjbWQgd2lsbCBiZSBhYm5vcm1hbCBldmVuIGFmdGVyIGEgcmVjb25uZWN0
Lgo+IFNvcnJ5LCBkZWxheWVkIHJlcGx5IGR1ZSB0byBsZWF2ZS4KPiBUaGVyZSBhcmUgbWFueSBw
b3NzaWJpbGl0aWVzIGZvciBhYm5vcm1hbCBmYWJyaWNzIGNtZC4KPiBJbiBzb21lIHNjZW5hcmlv
cywgaWYgdGhlIGxpbmsgaXMgcmUtZXN0YWJsaXNoZWQsIHRoZSBlcnJvciBtYXkgbm90IAo+IG9j
Y3VyIGFnYWluLAo+IHN1Y2ggYXMgSEJBIGlubmVyIGVycm9yLCBuZXR3b3JrIGlzIGFibm9ybWFs
IG9yIGF0dGFja2VkIGV0Yy4KPj4KPj4+Pgo+Pj4+IFRodXMgaWYgdGhlIGluaXRpYWwgY29ubmVj
dCBmYWlscyBpbiB0aGlzIG1hbm5lciwgYW55IG5ldyAKPj4+PiBhc3NvY2lhdGlvbiB3aWxsIGJl
IG9uIGEgZGlmZmVyZW50IGNvbnRyb2xsZXIsIHdoZXJlIGl0IGlzIG5vdyAKPj4+PiBleHBlY3Rl
ZCBjb25uZWN0IG9uIHRoYXQgY29udHJvbGxlciB3aWxsIGZhaWwgdG9vLsKgIFRodXMgLSB3aHkg
Cj4+Pj4gY29udGludWUgdG8gY29ubmVjdCB3aGVuIGl0J3MgZXhwZWN0ZWQgZWFjaCB3aWxsIGZh
aWwuCj4+PiBBZ3JlZS4KPj4+IFdlIHNob3VsZCBub3QgYXR0ZW1wdCB0byByZS1lc3RhYmxpc2gg
dGhlIGNvbm5lY3Rpb24gaWYgdGFyZ2V0IGNhbiAKPj4+IG5vdCB3b3JrIGR1ZSB0byB0YXJnZXQg
aW5uZXIgZXJyb3IgLgo+Pj4gSG93ZXZlciwgbm93wqAgdGFyZ2V0IGRvZXMgbm90IGJlaGF2ZSBl
eGFjdGx5IGxpa2UgdGhpcywgc28gdGhlcmUgYXJlIAo+Pj4gY29uZmxpY3RzIGFuZCBjb21wYXRp
YmlsaXR5IGlzc3Vlcy4KPj4KPj4gTm90ZTogd2UgbmV2ZXIgc2FpZCB0aGUgdGFyZ2V0IHNob3Vs
ZCBfbm90XyBzZW5kIGEgRE5SIHN0YXRlLiBXZSBvbmx5IAo+PiBzYWlkIHRoZSB0YXJnZXQgc2hv
dWxkIG9ubHkgc2V0IHRoZSBETlIgYml0IGlmIGEgcmV0cnkgKGV2ZW4gYWZ0ZXIgCj4+IHJlY29u
bmVjdCBvciBvbiBhIGRpZmZlcmVudCBjb250cm9sbGVyKSB3aWxsIG5vdCBjaGFuZ2UgdGhlIHJl
c3VsdC4KPj4gV2hpY2ggZnJvbSB3aGF0IEkgY2FuIHNlZSBfaXNfIHRoZSBjYXNlLCBzbyBJIGRv
IG5vdCBzZWUgYW55IGlzc3VlcyBoZXJlLgo+Pgo+PiBQbGVhc2UgZ2l2ZSBkZXRhaWxzIGZvciB0
aGUgaXNzdWVzIHlvdSBhcmUgY29uY2VybmVkIHdpdGguCj4gRm9yIGV4YW1wbGUsIGlmIGhvc3Qg
c2VuZCBhIGZhYnJpYyBjbWQsIGJ1dCB0aGUgZmFicmljIGNtZCBpcyBwb2lzb25lZAo+IGR1ZSB0
byBIQkEgaW5uZXIgZXJyb3IsIGFibm9ybWFsIG9yIGF0dGFja2VkIG5ldHdvcmssIGFuZCB0aGVu
IHRoZSB0YXJnZXQKPiBzZXQgdGhlIEROUiB0byByZXBseSByZXNwb25zZS4gSWYgZG8gbm90IHJl
Y29ubmVjdCBmb3IgRE5SIHJlc3BvbnNlIG9mCj4gb2xkIGNvbm5lY3Rpb24sIHRodXMgdGhlIGNv
bm5lY3RpbmcgY2FuIG5vdCBhb3RvIHJlY292ZXJ5LiBUaGUgZmFicmljCj4gY21kIHBvaXNvbmlu
ZyBtYXkgYmUgdHJhbnNpZW50LCBtYXkgc3VjY2VzcyBpZiB0cnkgZm9yIHJlY29ubmVjdGluZy4K
PiBzbyB0cnkgdG8gcmVjb25uZWN0aW5nIGlzIGEgYmV0dGVyIGNob2ljZS4KPiBJZiBkbyBub3Qg
cmVjb25uZWN0IGZvciBETlIgcmVzcG9uc2UsIHRhcmdldCBzaG91bGQgc2V0IEROUiBzdGF0ZSBq
dXN0Cj4gZm9yIHRhcmdldCBpbm5lciBlcnJvci4KPj4KPj4gQ2hlZXJzLAo+Pgo+PiBIYW5uZXMK
Ckl0IHJlYWxseSBkb2Vzbid0IG1hdHRlciB3aGF0IHlvdSBkZXNjcmliZSBpcyBoYXBwZW5pbmcg
b24gdGhlIGJhY2sgZW5kIApvZiB0aGUgY29udHJvbGxlcnMvc3Vic3lzdGVtLiAgVGhlIHJldiAx
LjQgc3BlYyBzYXlzICJpZiB0aGUgc2FtZSAKY29tbWFuZCBpcyByZS1zdWJtaXR0ZWQgdG8gYW55
IGNvbnRyb2xsZXIgaW4gdGhlIE5WTSBzdWJzeXN0ZW0sIHRoZW4gCnRoYXQgcmUtc3VibWl0dGVk
IGNvbW1hbmQgaXMgZXhwZWN0ZWQgdG8gZmFpbC4iIC0gU28sIGlmIHRoZXJlJ3MgYSAKY2hhbmNl
IHRoYXQgYSByZWNvbm5lY3Qgd291bGQgc3VjY2VlZCwgd2hpY2ggd291bGQgYmUgb24gYSBkaWZm
ZXJlbnQgCmNvbnRyb2xsZXIgLSB0aGVuIHN1YnN5c3RlbSBpcyBub3QgZm9sbG93aW5nIHRoYXQg
c3RhdGVtZW50LiBTbyB5b3UgCnNob3VsZG4ndCBiZSBzZXR0aW5nIEROUi4gICBJZiB5b3UgZGlz
YWdyZWUgd2l0aCB0aGlzIGJlaGF2aW9yLCBpdCB3aWxsIApuZWVkIHRvIGJlIHRha2VuIHVwIHdp
dGggdGhlIE5WTSBFeHByZXNzIGdyb3VwLgoKLS0gamFtZXMKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
