Return-Path: <SRS0=x9Yf=BX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ADDC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 15:00:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2823F20656
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 15:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MBKTr/YM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dMixVRYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2823F20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zs6TfY4dqhYwTBIKvhJuuR8r6R+D2Cwcf+rKzMtEtJo=; b=MBKTr/YMWWzPzIBGgjsnX2p6p
	ZH6kdCBYs9f5oPiH3Yim9bcsJK8AmYX/pERD7sD1GS9GnfiBcrZHE6lNwIp3zqpSz+7kPI4IcKelq
	NlzS3450KtJNZgkyDe7vhqYyNV9VaqKOWEPoeN85dhdvu9VBUCAtunTr/Ko2zg5SBiIgKsxzjq8Iq
	mmDHPrrYxsvpzhcrpYMrGHTUa7MrFhNfnn/tVNSY2lQhH7Cnxu8FxUX2ObsM2AtBZhpzjj8tqVEMK
	k0FdOdCU7SNRiBCjgrRusz4Zqg/CdJqyl3pm/YGrlroruR0J+acaVUnLEqLDHtFshegdiReH94PVb
	iE/g61wMQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6Eid-00066V-1z; Thu, 13 Aug 2020 15:00:39 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6EiZ-000668-Gq
 for linux-nvme@lists.infradead.org; Thu, 13 Aug 2020 15:00:36 +0000
Received: by mail-pf1-x443.google.com with SMTP id u128so2948311pfb.6
 for <linux-nvme@lists.infradead.org>; Thu, 13 Aug 2020 08:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Gmd4M80IEWsDHxiG/Ywnf/HBZn5+CO0GhB5I2n4yzJM=;
 b=dMixVRYi9/AVtZ1hh8HUWIqPAu9hcNoS4Yyh2u3ONkAh6JgjsyelbT1HMNRHILKRt1
 I6AZGT1qTYbgkQT5/r7iEuuuMDpftRzIsKZuF/EHp45+CCds2ObKIr7CJlkWHQ49x2qR
 P4ZD5j/bQbdJxkYGYLGA9jlBN4FsYWR5A2nw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Gmd4M80IEWsDHxiG/Ywnf/HBZn5+CO0GhB5I2n4yzJM=;
 b=DBzk1dqT5OsKIzco5Ia7dK4I5KEzuJDq4qrIesZhn5QFeJMvNDRN6B2wt4Z7EczYVi
 poN0HMyF4uvF7rk7gyaQ3qZsxoHsZxYorAyKrOlcgXFwjV/kOVKPt2cYjgLdqlbUJVVR
 g0HtRgawx2xuXBnbPsXYtkH7yPM+ANtT9Qb9prdWSAOddReWDy8c1tVQ0k4vQft09aDW
 fdut+9V2r5EOuQGVD31QG8lh5feK6hBhoO2ETGK0Q8Aa0FrkFTZarjk+9E4oNTMxmyIj
 8rnlA7YbYEe4opwElAlIC2/mOL22nuPIUnBj9ETrfOhkLkBU81RBJhtONaFPvWFUIXD7
 G8kQ==
X-Gm-Message-State: AOAM53100oJunSSO9gsHWeyQ9Skkrthyzerfq55/lwcDBFiqutnIjbCp
 mlsbVu+hSys3RfivlEgXUmZ/Vw==
X-Google-Smtp-Source: ABdhPJzlfCAE7TY3tQUawa+wxAJH6PmsPe+xrxJidUb5GKJ/3weRzY2NeL9fUWaHxMKAZLiV/uVPpw==
X-Received: by 2002:a63:8249:: with SMTP id w70mr3995751pgd.293.1597330831422; 
 Thu, 13 Aug 2020 08:00:31 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id y7sm6009105pjm.3.2020.08.13.08.00.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 08:00:30 -0700 (PDT)
Subject: Re: [PATCH v7] nvme-fabrics: reject I/O to offline device
To: Victor Gladkov <Victor.Gladkov@kioxia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <168ed5d66eae49ac8b445478b1bb362d@kioxia.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <d79e8917-6c45-5120-5e5c-602750fc5013@broadcom.com>
Date: Thu, 13 Aug 2020 08:00:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <168ed5d66eae49ac8b445478b1bb362d@kioxia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200813_110035_855187_C68D42AD 
X-CRM114-Status: GOOD (  21.07  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, "Ewan D. Milne" <emilne@redhat.com>,
 Hannes Reinecke <hare@suse.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNy84LzIwMjAgODowNyBBTSwgVmljdG9yIEdsYWRrb3Ygd3JvdGU6Cj4gQ29tbWFuZHMgZ2V0
IHN0dWNrIHdoaWxlIEhvc3QgTlZNZSBjb250cm9sbGVyIChUQ1Agb3IgUkRNQSkgaXMgaW4KPiBy
ZWNvbm5lY3Qgc3RhdGUuIE5WTWUgY29udHJvbGxlciBlbnRlcnMgaW50byByZWNvbm5lY3Qgc3Rh
dGUgd2hlbiBpdAo+IGxvc2VzIGNvbm5lY3Rpb24gd2l0aCB0aGUgdGFyZ2V0LiBJdCB0cmllcyB0
byByZWNvbm5lY3QgZXZlcnkgMTAKPiBzZWNvbmRzIChkZWZhdWx0KSB1bnRpbCBzdWNjZXNzZnVs
IHJlY29ubmVjdGlvbiBvciB1bnRpbCByZWNvbm5lY3QKPiB0aW1lLW91dCBpcyByZWFjaGVkLiBU
aGUgZGVmYXVsdCByZWNvbm5lY3QgdGltZSBvdXQgaXMgMTAgbWludXRlcy4KPgo+IFRvIGZpeCB0
aGlzIGxvbmcgZGVsYXkgZHVlIHRvIHRoZSBkZWZhdWx0IHRpbWVvdXQgd2UgaW50cm9kdWNlIG5l
dwo+IHNlc3Npb24gcGFyYW1ldGVyICJmYXN0X2lvX2ZhaWxfdG1vIi4gVGhlIHRpbWVvdXQgaXMg
bWVhc3VyZWQgaW4KPiBzZWNvbmRzIGZyb20gdGhlIGNvbnRyb2xsZXIgcmVjb25uZWN0LCBhbnkg
Y29tbWFuZCBiZXlvbmQgdGhhdAo+IHRpbWVvdXQgaXMgcmVqZWN0ZWQuIFRoZSBuZXcgcGFyYW1l
dGVyIHZhbHVlIG1heSBiZSBwYXNzZWQgZHVyaW5nCj4gJ2Nvbm5lY3QnLgo+IFRoZSBkZWZhdWx0
IHZhbHVlIG9mIDAgbWVhbnMgbm8gdGltZW91dCAoc2ltaWxhciB0byBjdXJyZW50IGJlaGF2aW9y
KS4KPgo+IFdlIGFkZCBhIG5ldyBjb250cm9sbGVyIE5WTUVfQ1RSTF9GQUlMRkFTVF9FWFBJUkVE
IGFuZCByZXNwZWN0aXZlCj4gZGVsYXllZCB3b3JrIHRoYXQgdXBkYXRlcyB0aGUgTlZNRV9DVFJM
X0ZBSUxGQVNUX0VYUElSRUQgZmxhZy4KPgo+IFdoZW4gdGhlIGNvbnRyb2xsZXIgaXMgZW50ZXJp
bmcgdGhlIENPTk5FQ1RJTkcgc3RhdGUsIHdlIHNjaGVkdWxlCj4gdGhlIGRlbGF5ZWRfd29yayBi
YXNlZCBvbiBmYWlsZmFzdCB0aW1lb3V0IHZhbHVlLiBJZiB0aGUgdHJhbnNpdGlvbgo+IGlzIG91
dCBvZiBDT05ORUNUSU5HLCB0ZXJtaW5hdGUgZGVsYXllZCB3b3JrIGl0ZW0gYW5kIGVuc3VyZQo+
IGZhaWxmYXN0X2V4cGlyZWQgaXMgZmFsc2UuIElmIGRlbGF5ZWQgd29yayBpdGVtIGV4cGlyZXMg
dGhlbiBzZXQKPiAiTlZNRV9DVFJMX0ZBSUxGQVNUX0VYUElSRUQiIGZsYWcgdG8gdHJ1ZS4KPgo+
IFdlIGFsc28gdXBkYXRlIG52bWZfZmFpbF9ub25yZWFkeV9jb21tYW5kKCkgYW5kCj4gbnZtZV9h
dmFpbGFibGVfcGF0aCgpIGZ1bmN0aW9ucyB3aXRoIGNoZWNrIHRoZQo+ICJOVk1FX0NUUkxfRkFJ
TEZBU1RfRVhQSVJFRCIgY29udHJvbGxlciBmbGFnLgo+Cj4gU2lnbmVkLW9mZi1ieTogVmljdG9y
IEdsYWRrb3YgPHZpY3Rvci5nbGFka292IGF0IGtpb3hpYS5jb20+Cj4gU2lnbmVkLW9mZi1ieTog
Q2hhaXRhbnlhIEt1bGthcm5pIDxjaGFpdGFueWEua3Vsa2FybmkgYXQgd2RjLmNvbT4KPiBSZXZp
ZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpWaWN0b3IsCgp3aGVuIHdl
IHRhbGtlZCBhYm91dCB3aGF0IGZhc3QgZmFpbCBkb2VzLCB3ZSBkaXNjdXNzZWQgaG93IGl0IHdh
cyAKZGlmZmVyZW50IGZyb20gU0NTSSdzIG5vdGlvbiBvZiBmYXN0IGZhaWwsIHdoaWNoIHdhcyBp
biBzdXBwb3J0IG9mIAptcGlvLsKgIG52bWUgZGlkbid0IG5lZWQgc2NzaSdzIGZhc3RfZmFpbCBi
ZWhhdmlvciBhcyB0aGUgZmFicmljIGNoZWNrIApyZWFkeSdzIGFyZSBzcG90dGluZyB0aGUgbXBh
dGggYXR0cmlidXRlcyBpbW1lZGlhdGVseS4gU28gdGhpcyBwYXRjaCBzZXQgCmlzIGZvciAibm9y
bWFsIiBpbyB0aGF0IG5vcm1hbGx5IGVudGVycyByZXRyaWVzLsKgIFlvdSByZXBsaWVkIHdpdGgg
YSAKdmVyeSBpbXBvcnRhbnQgZGlzdGluY3Rpb24gYWJvdXQgdGhpcyBwYXRjaCB0aGF0IGlzbid0
IGRlc2NyaWJlZCBieSB0aGUgCmFib3ZlLgoKUGxlYXNlIGFkZCB0aGlzIHBhcmFncmFwaCB0byB0
aGUgcGF0Y2ggZGVzY3JpcHRpb246CgogRnJvbSBlbWFpbCBmcm9tIFZpY3RvciBvbiAxMi8zLzIw
MTkgYXQgMjowNCBhbSBVUyBQU1Q6CkFwcGxpY2F0aW9ucyBhcmUgZXhwZWN0aW5nIGNvbW1hbmRz
IHRvIGNvbXBsZXRlIHdpdGggc3VjY2VzcyBvciBlcnJvciAKd2l0aGluIGEgY2VydGFpbiB0aW1l
b3V0ICgzMCBzZWNvbmRzIGJ5IGRlZmF1bHQpLsKgIFRoZSBOVk1lIGhvc3QgaXMgCmVuZm9yY2lu
ZyB0aGF0IHRpbWVvdXQgd2hpbGUgaXQgaXMgY29ubmVjdGVkLCBuZXZlciB0aGUgbGVzcywgZHVy
aW5nIApyZWNvbm5lY3Rpb24sIHRoZSB0aW1lb3V0IGlzIG5vdCBlbmZvcmNlZCBhbmQgY29tbWFu
ZHMgbWF5IGdldCBzdHVjayBmb3IgCmEgbG9uZyBwZXJpb2Qgb3IgZXZlbiBmb3JldmVyLgoKLS0g
amFtZXMKCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
