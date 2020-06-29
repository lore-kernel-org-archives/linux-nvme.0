Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA79DC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 01:36:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B82A20760
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 01:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O7G4KH78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B82A20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nQLIgKL6YFOrE7HFarAfMVudhY2+b/GOD/Hevx/HrXo=; b=O7G4KH78iiVW7htefTycmNo2K
	pHUtBx8rY8ulYidhqdBivbXpMSOYYqB8MtBctfMJdyjsAzaAiAJuxxZPFt0KZi6KLiKxlNsVmkAcN
	/feHnC6SHiuHAp6WK4yNiTPPofREUuxo4JCltQvy7MGKjUE/Zec8IPGVi1jPzXsEmDcC1b7C8MpCJ
	6dvXU0co+suoP81+PfSlSQF90oWWqvbr6ZJ4z5TAA5ls6pwImOPI/fGeR+2qRwv+/bWW4JoQwfkUi
	0zB5oNEgU72Z1gUTE2mYIDucEbCzvcBwP4PESBKaIzNMHamDTpPval4S+gXN2dqVj+uu9rqhcOgP/
	oK0VQSe1w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpiip-0000hI-GG; Mon, 29 Jun 2020 01:36:35 +0000
Received: from mail-pj1-f66.google.com ([209.85.216.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpiin-0000gM-Jk
 for linux-nvme@lists.infradead.org; Mon, 29 Jun 2020 01:36:34 +0000
Received: by mail-pj1-f66.google.com with SMTP id o22so2249485pjw.2
 for <linux-nvme@lists.infradead.org>; Sun, 28 Jun 2020 18:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=s4x1Od24FXLrarpF97nRPGvbMk3D5kp3VfdEZSEmDhw=;
 b=gwZ4A624ji7DZiqd3fHm0a/PaHnP4Wsfy80bQcLI0t/c5mu1hjoYs0TmVgoUiMSlS0
 s+CFcFN6/xdSvNaydy+qnogDhacNF8qynheQKUVIEt8rHF87pU5sD+O8j+UXbJ4gIWNy
 +Qqy8kcm80A/zUEmznC/hvzriKYmpVp/eU9VXJlqXN3JOBbiQwyO4CmvJc0/TZLuN5GM
 6meO/jr/Zs6M33XTOoZ8QQT6cYhreDipWxyRgH5rqURVRBq6U1ww+ZK3JTK/MzLQ8Ezu
 biBcxrnBRbDormg8YAnRe3zIccVy9QcFNAvVD+13VVgKdUts+sHHDGl0T5u9u0zGw9m3
 PK+g==
X-Gm-Message-State: AOAM532npzzeSsNAzgaO7JcYPxMdj7QNsUXkD0FhlLtnzrdslOEW+9PB
 THPsmomQqBglQVoWEvTcGxKGKq0NkDI=
X-Google-Smtp-Source: ABdhPJz7xUgN970SnEgTAeV9FLe4mfvopgGs1JOIp0QPQ6aC2kw6RkTdzy4i7BI5V2xGik2Bz3QRBA==
X-Received: by 2002:a17:902:6181:: with SMTP id
 u1mr11517203plj.205.1593394588106; 
 Sun, 28 Jun 2020 18:36:28 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id z1sm27702053pgk.89.2020.06.28.18.36.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jun 2020 18:36:27 -0700 (PDT)
Subject: Re: [PATCH 2/2] block: add BLKSETDESCZONE ioctl for Zoned Block
 Devices
To: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
 axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 martin.petersen@oracle.com, damien.lemoal@wdc.com, niklas.cassel@wdc.com,
 hans.holmberg@wdc.com
References: <20200628230102.26990-1-matias.bjorling@wdc.com>
 <20200628230102.26990-3-matias.bjorling@wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <cbb91e7d-5cc8-eeb7-5219-b712545cb5c4@acm.org>
Date: Sun, 28 Jun 2020 18:36:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200628230102.26990-3-matias.bjorling@wdc.com>
Content-Language: en-US
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
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjAyMC0wNi0yOCAxNjowMSwgTWF0aWFzIEJqw7hybGluZyB3cm90ZToKPiArCS8qIFRoaXMg
bWF5IHRha2UgYSB3aGlsZSwgc28gYmUgbmljZSB0byBvdGhlcnMgKi8KPiArCWNvbmRfcmVzY2hl
ZCgpOwo+ICsKPiArCXJldHVybiBzdWJtaXRfYmlvX3dhaXQoJmJpbyk7CgpBIGNvbmRfcmVzY2hl
ZCgpIGNhbGwgYmVmb3JlIGEgc3VibWl0X2Jpb193YWl0KCkgY2FsbD8gSSB0aGluayBpdCdzIHRo
ZQpmaXJzdCB0aW1lIHRoYXQgSSBzZWUgdGhpcy4gSXMgdGhhdCBjYWxsIHJlYWxseSBuZWNlc3Nh
cnk/IElzbid0IHRoZQp3YWl0X2Zvcl9jb21wbGV0aW9uKCkgY2FsbCBpbnNpZGUgc3VibWl0X2Jp
b193YWl0KCkgc3VmZmljaWVudD8KCj4gKwkvKiBubyBmbGFncyBpcyBjdXJyZW50bHkgc3VwcG9y
dGVkICovCiAgICAgICAgICAgICAgICAgICAgXl4KICAgICAgICAgICAgICAgICAgICBhcmU/Cgo+
ICsJLyogYWxsb2NhdGUgdGhlIHNpemUgb2YgdGhlIHpvbmUgZGVzY3JpcHRvciBleHRlbnNpb24g
YW5kIGZpbGwKPiArCSAqIHdpdGggdGhlIGRhdGEgaW4gdGhlIHVzZXIgZGF0YSBidWZmZXIuIElm
IHRoZSBkYXRhIHNpemUgaXMgbGVzcwo+ICsJICogdGhhbiB0aGUgem9uZSBkZXNjcmlwdG9yIGV4
dGVuc2lvbiBzaXplLCB0aGVuIHRoZSByZXN0IG9mIHRoZQo+ICsJICogem9uZSBkZXNjcmlwdGlv
biBleHRlbnNpb24gZGF0YSBidWZmZXIgaXMgemVyby1maWxsZWQuCj4gKwkgKi8KPiArCXpzZF9k
YXRhID0gKHZvaWQgKikgZ2V0X3plcm9lZF9wYWdlKEdGUF9LRVJORUwpOwo+ICsJaWYgKCF6c2Rf
ZGF0YSkKPiArCQlyZXR1cm4gLUVOT01FTTsKPiArCj4gKwlpZiAoY29weV9mcm9tX3VzZXIoenNk
X2RhdGEsIGFyZ3AgKyBzaXplb2Yoc3RydWN0IGJsa196b25lX3NldF9kZXNjKSwKPiArCQkJICAg
enNkLmxlbikpIHsKPiArCQlyZXQgPSAtRUZBVUxUOwo+ICsJCWdvdG8gZnJlZTsKPiArCX0KCkhh
cyBpdCBiZWVuIGNvbnNpZGVyZWQgdG8gdXNlIGttYWxsb2MoKSBpbnN0ZWFkIG9mIGdldF96ZXJv
ZWRfcGFnZSgpPwoKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9ibGtfdHlwZXMuaCBiL2lu
Y2x1ZGUvbGludXgvYmxrX3R5cGVzLmgKPiBpbmRleCBjY2I4OTVmOTExYjEuLjUzYjdiMDViMDAw
NCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2Jsa190eXBlcy5oCj4gKysrIGIvaW5jbHVk
ZS9saW51eC9ibGtfdHlwZXMuaAo+IEBAIC0zMTYsNiArMzE2LDggQEAgZW51bSByZXFfb3BmIHsK
PiAgCVJFUV9PUF9aT05FX0ZJTklTSAk9IDEyLAo+ICAJLyogd3JpdGUgZGF0YSBhdCB0aGUgY3Vy
cmVudCB6b25lIHdyaXRlIHBvaW50ZXIgKi8KPiAgCVJFUV9PUF9aT05FX0FQUEVORAk9IDEzLAo+
ICsJLyogYXNzb2NpYXRlIHpvbmUgZGVzYyBleHRlbnNpb24gZGF0YSB0byBhIHpvbmUgKi8KPiAr
CVJFUV9PUF9aT05FX1NFVF9ERVNDCT0gMTQsCj4gIAo+ICAJLyogU0NTSSBwYXNzdGhyb3VnaCB1
c2luZyBzdHJ1Y3Qgc2NzaV9yZXF1ZXN0ICovCj4gIAlSRVFfT1BfU0NTSV9JTgkJPSAzMiwKCkRv
ZXMgUkVRX09QX1pPTkVfU0VUX0RFU0MgY291bnQgYXMgYSByZWFkIG9yIGFzIGEgd3JpdGUgb3Bl
cmF0aW9uPyBTZWUgYWxzbzoKCnN0YXRpYyBpbmxpbmUgYm9vbCBvcF9pc193cml0ZSh1bnNpZ25l
ZCBpbnQgb3ApCnsKCXJldHVybiAob3AgJiAxKTsKfQoKPiArLyoqCj4gKyAqIHN0cnVjdCBibGtf
em9uZV9zZXRfZGVzYyAtIEJMS1NFVERFU0NaT05FIGlvY3RsIHJlcXVlc3RzCj4gKyAqIEBzZWN0
b3I6IFN0YXJ0aW5nIHNlY3RvciBvZiB0aGUgem9uZSB0byBvcGVyYXRlIG9uLgo+ICsgKiBAZmxh
Z3M6IEZlYXR1cmUgZmxhZ3MuCj4gKyAqIEBsZW46IHNpemUsIGluIGJ5dGVzLCBvZiB0aGUgZGF0
YSB0byBiZSBhc3NvY2lhdGVkIHRvIHRoZSB6b25lLgo+ICsgKiBAZGF0YTogZGF0YSB0byBiZSBh
c3NvY2lhdGVkLgo+ICsgKi8KPiArc3RydWN0IGJsa196b25lX3NldF9kZXNjIHsKPiArCV9fdTY0
CQlzZWN0b3I7Cj4gKwlfX3UzMgkJZmxhZ3M7Cj4gKwlfX3UzMgkJbGVuOwo+ICsJX191OAkJZGF0
YVswXTsKPiArfTsKCklzbid0IHRoZSByZWNvbW1lbmRlZCBzdHlsZSB0byB1c2UgYSBmbGV4aWJs
ZSBhcnJheSAoW10gaW5zdGVhZCBvZiBbMF0pPwpTZWUgYWxzbyBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9sa21sLzIwMjAwNjA4MjEzNzExLkdBMjIyNzFAZW1iZWRkZWRvci8uCgpUaGFua3MsCgpC
YXJ0LgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
