Return-Path: <SRS0=h+kd=CH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456AEC433E6
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Aug 2020 00:00:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E39E20CC7
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Aug 2020 00:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qn0it9zl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E39E20CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jAIfOj7e4c10aWQ7c6evY7yESotmT0WB/oJHQvVMi2o=; b=Qn0it9zlkVScTR13RwjbFsYYA
	6CWI1ZdxirMM0FAXsJqPwuSuj17E/H7nC/fIeCgQV3Mx++bf+jkQ8P7MUf68Fz5QX2ejd7vs5sxe7
	V3U5hLOyS0hRc0dzmuwbnkdS29pLc/9QMRqUo1lOjELbkOMcYCvkfQ0i2n3FM8eIgSjKqval61g5b
	CVSVoFE/RRFjFJ8dh1Kx4lWUwN+kHvhsmVMi2xXatdk+H6zoj5Acw34ZfsJ0vKQH7eXPCl0vyCa6E
	6BD6ff/Ivd95oNWwIQ7YbfCKcUWDBsBbI66pxwifFkRiD/i7oKHezSnxOm4nEDUn6v6RkXPVbEuFo
	r66XyLZiw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBoHl-0006XA-QF; Fri, 28 Aug 2020 23:59:57 +0000
Received: from mail-pj1-f65.google.com ([209.85.216.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBoHi-0006UF-Mj
 for linux-nvme@lists.infradead.org; Fri, 28 Aug 2020 23:59:55 +0000
Received: by mail-pj1-f65.google.com with SMTP id mw10so285991pjb.2
 for <linux-nvme@lists.infradead.org>; Fri, 28 Aug 2020 16:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WziFzy0mfIhNVjHu+MhHHDukksW7Q5B3x38ptCX1DtQ=;
 b=TOgZhhnMds2DVPa2RL7lgYwFBI58yY267IaY1G3gUQLs3llcJ5v61znAaEso5PH1GQ
 9fjTKBjxyJxg6ejrqLQjugZ/XHmTh06a/QImLD6waEFbjl6Cz2SdlbUeYa4A0B6jURhA
 nh13elF1rQKTltuB1msOlabJuBXhBL5zCVBA/NpCoEnjrnFuIji35drx3NHddl5CDBGL
 VWk7ZIAuMhM8nMasqNGPGIa7db3K281PpYgN7848++Gl7YdwXUVQk1WTPvuLVNTbU0Vz
 QUHyNJS2VgNJKwLYi69aFzop6ptOVm1wmAE/C5bKBmPrEJIh7AOyb3tFYDPhv2dY0CN2
 VKsg==
X-Gm-Message-State: AOAM533JEA1gK7nW92a/NOgW+r872Y/p3iQVVBeQLJbdBWdqQeWDUEUC
 fWLjbsDQmOp2ZNCrCQonKhc=
X-Google-Smtp-Source: ABdhPJzklbH/I1vgnWTb4LZef7zTWIRLyWmJeXAizMb/jYOaS7dNZaQF06HLFbXG2vVZDWBSuxXwJg==
X-Received: by 2002:a17:902:24c:: with SMTP id 70mr980052plc.284.1598659188040; 
 Fri, 28 Aug 2020 16:59:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:b43d:4be3:4cfb:fd9e?
 ([2601:647:4802:9070:b43d:4be3:4cfb:fd9e])
 by smtp.gmail.com with ESMTPSA id d131sm546927pgc.88.2020.08.28.16.59.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 16:59:47 -0700 (PDT)
Subject: Re: [PATCH] nvme: Revert: Fix controller creation races with teardown
 flow
To: James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org
References: <20200828190150.34455-1-james.smart@broadcom.com>
 <0867c437-1521-c0c9-d7fa-6a615d88105a@grimberg.me>
 <a73cd06b-b319-d55f-1465-4263e08900ae@broadcom.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <741ec2a7-7a38-9432-33fb-58227bf1f1f1@grimberg.me>
Date: Fri, 28 Aug 2020 16:59:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a73cd06b-b319-d55f-1465-4263e08900ae@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200828_195954_798663_05ACEE1C 
X-CRM114-Status: GOOD (  20.32  )
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
Cc: Keith Busch <kbusch@kernel.org>, Israel Rukshin <israelr@mellanox.com>,
 Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org,
 Max Gurtovoy <maxg@mellanox.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+IFRoaXMgaXMgaW5kZWVkIGEgcmVncmVzc2lvbi4KPj4KPj4gUGVyaGFwcyB3ZSBzaG91bGQg
YWxzbyByZXZlcnQ6Cj4+IDEyYTBiNjYyMjEwNyAoIm52bWU6IGRvbid0IGhvbGQgbnZtZl90cmFu
c3BvcnRzX3J3c2VtIGZvciBtb3JlIHRoYW4gCj4+IHRyYW5zcG9ydCBsb29rdXBzIikKPj4KPj4g
V2hpY2ggaW5oZXJlbnRseSBjYXVzZWQgdGhpcyBieSByZW1vdmluZyB0aGUgc2VyaWFsaXphdGlv
biBvZgo+PiAuY3JlYXRlX2N0cmwoKS4uLgo+IAo+IG5vLCBJIGJlbGlldmUgdGhlIHBhdGNoIG9u
IHRoZSBzZW1hcGhvcmUgaXMgY29ycmVjdC4gT3RoZXJ3aXNlIC0gdGhpbmdzIAo+IGNhbiBiZSBi
bG9ja2VkIGEgbG9uZyB0aW1lLi4gYSBtaW51dGUgKDEgY21kIHRpbWVvdXQpIG9yIGV2ZW4gbXVs
dGlwbGUgCj4gbWludXRlcyBpbiB0aGUgY2FzZSB3aGVyZSBhIGNvbW1hbmQgZmFpbHVyZSBpbiBj
b3JlIGxheWVycyBlZmZlY3RpdmVseSAKPiBnZXRzIGlnbm9yZWQgYW5kIHRodXMgZG9lc24ndCBj
YXVzZSB0aGUgZXJyb3IgcGF0aCBpbiB0aGUgdHJhbnNwb3J0LiAKPiBUaGVyZSBjYW4gYmUgbXVs
dGlwbGUgL2Rldi9udm1lLWZhYnJpY3MgY29tbWFuZHMgc3RhY2tlZCB1cCB0aGF0IGNhbiAKPiBt
YWtlIHRoZSBkZWxheXMgbG9vayBtdWNoIGxvbmdlciB0byB0aGUgbGFzdCBndXkuCj4gCj4gYXMg
ZmFyIGFzIGNyZWF0aW9uIHZzIHRlYXJkb3duLi4uIHllYWgsIG5vdCBmdW4sIGJ1dCB0aGVyZSBh
cmUgb3RoZXIgCj4gd2F5cyB0byBkZWFsIHdpdGggaXQuIEZDOiBJIGdvdCByaWQgb2YgdGhlIHNl
cGFyYXRlIGNyZWF0ZS9yZWNvbm5lY3QgCj4gdGhyZWFkcyBhIHdoaWxlIGFnbyB0aHVzIHRoZSBy
ZXR1cm4tY29udHJvbC13aGlsZS1yZWNvbm5lY3RpbmcgYmVoYXZpb3IsIAo+IHNvIEkndmUgaGFk
IHRvIGRlYWwgd2l0aCBpdC7CoCBJdCdzIG9uZSBhcmVhIGl0J2QgYmUgbmljZSB0byBzZWUgc29t
ZSAKPiBjb252ZXJnZW5jZSBpbiBpbXBsZW1lbnRhdGlvbiBhZ2FpbiBiZXR3ZWVuIHRyYW5zcG9y
dHMuCgpEb2Vzbid0IGZjIGhhdmUgYSBidWcgdGhlcmU/IGluIGNyZWF0ZV9jdHJsIGFmdGVyIGZs
dXNoaW5nIHRoZQpjb25uZWN0X3dvcmssIHdoYXQgaXMgdGVsbGluZyBpdCBpZiBkZWxldGUgaXMg
cnVubmluZyBpbiB3aXRoIGl0CihvciB0aGF0IGl0IGFscmVhZHkgcmFuLi4uKQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5n
IGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
