Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0AEC433ED
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 15:46:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF23611AB
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 15:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF23611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3hmUUqMrBTyyfb3Hjz/kbdnG1Q7ET19eeedwqde1dHM=; b=NKYV5P+/+YhP19LAz8h/CN4Od
	uYVBCtCYFG7n91QtZdbkPcXZjTeac1iAyfgAoGSdboRIL/gEzMl71lyBqb1yjao2BR1tKqqwYLZYJ
	X64eMIXUzJOFsN3MF9Nm5eddXW+VhkJnUVaxOMSK7khKQKWm8wIEONUAhBUpHx29jG05z2D6lWqkq
	BpfDFkB5I1YRFpWoeARtkfMSHWxR3EeMSCko2I7BHlSjCruL2UgK6fUlK8cKrX0+FEE6f/yhDQQYX
	/rsuWLBrtKP2OycjI5dtNB12TpCZVO767mPBi1ekIF8mUEY9RmRSCCRYRxI4jwHVDKQOAToEUTHkW
	8trHAPjnQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldam9-00EHvq-SC; Mon, 03 May 2021 15:46:26 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldam5-00EHuH-2z
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 15:46:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-ID:Content-Description;
 bh=e5urHp2pKhem2MEsTQYPlFemG31abPiVuCzUED6xLlM=; b=aq1iXQ5ex4k/6DtcW2VMevnelD
 KIv16srO1UPQNpwoJdBeT+znRTbP//gEbvKjGbIvDoOFqk+Iu67Ux+2w2i1vN+EFfExZglJHDkZYY
 8izMHwbHS0SZKo4M48GQbX3tEs4FzZqJgPm4SkaQmHYzfrgNg4Im3mY3qaZRCEC4Z2k4Zula6PH4l
 NrETyirmywNNpKycuZh+tzg4m3UWvg7Rh66GQ/0l7odl2AqjUqgFyyFwo2wI/tcUzqPamFVr9UH3a
 tukNCAfVtmtJZ2Km5WdZ/DjHV+In/GvF7ZdGRm0EL7bksR9tZ1/LpHJAnc20BQ6L+GbZaRVn7TIXx
 92bApDHQ==;
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldam2-003C3a-Cf
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 15:46:19 +0000
Received: by mail-ej1-x629.google.com with SMTP id gx5so8544996ejb.11
 for <linux-nvme@lists.infradead.org>; Mon, 03 May 2021 08:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=e5urHp2pKhem2MEsTQYPlFemG31abPiVuCzUED6xLlM=;
 b=qcJ49LyQi32B8nQgKz0pVycJUDXgKlF3UC34odKI5DOVbh6eqD0b0XyaVo/kseNstn
 bSv2FLdzXXu/98WlqBPYRIlmDr3x+Z7vFBI6/T8rY2Cn46wFn3TooopWxDFR7nLIkm1Z
 rO/X47ThDNPJQZJfrdZkvE56bYWcA1gnm+3KdXq/UkNYgMeydsA5rF292au64mu2koAF
 YhzljUj0m1ke3P8WMN1jz5IqAPpuUSNghE3jXwKpV/z8Yb2A0j5v4KAcvfHf9W4X+1LK
 xJksR/17NM7g9QbVE7hMf3yRmWQ7FEIB5Ms6jLWmf6fyzcyXFcZ7FI1rWNpSgqNb7vky
 Qzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=e5urHp2pKhem2MEsTQYPlFemG31abPiVuCzUED6xLlM=;
 b=cdk1B5VwsyBspU+BIJn0b5P+IgY7G0RJJovem/1P5HHEZyDFFkS9rabLH6LKa7QEbv
 rA9EBtpiex81QoipYE0imm2PNT1+MMipC+4dQFuxjXhPirPeTpSsjIYMheIynpPj8SE1
 cs5abdkXICXESVQp82eGZhIKC2aD5znp9xKEvtN5xXIKmZNqw/4tL8tJ8mrpQu7COEdc
 fyavxOakqmT0WCmGHnVmsC2ZM5jn4IjcKtwawGu0zTs0JAFEujxW2GEDxgNUQDPqlcwk
 XHvOzH9hWGpZAe2eFgVkBAlHYr3GcrdyLfsVytLGsat89w2Sv8ITL2guRU/MUH7g+rFk
 bcxg==
X-Gm-Message-State: AOAM530s9asIgl6jYbN82y3YM73u6AnihQTrlQnpGGW5hZB9gdejsLxt
 pg91M1sRVC3c0/1Ne/7Xkjubbiy71jHCayu15yU=
X-Google-Smtp-Source: ABdhPJyoTkJmtTXEDMO202XSpVgDCWthvq3f0YU6ntgiWaRBqz4OKJvDEZxtTpcEjKNrkZgE8evzI4fB1076HfS3Mho=
X-Received: by 2002:a17:906:3a45:: with SMTP id
 a5mr17881005ejf.288.1620056776960; 
 Mon, 03 May 2021 08:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210429190926.5086-1-smalin@marvell.com>
 <20210429190926.5086-9-smalin@marvell.com>
 <7831d4ff-9e47-3c43-8725-95eb0bdd7107@suse.de>
In-Reply-To: <7831d4ff-9e47-3c43-8725-95eb0bdd7107@suse.de>
From: Shai Malin <malin1024@gmail.com>
Date: Mon, 3 May 2021 18:46:05 +0300
Message-ID: <CAKKgK4z28-gGB05y3nOPpok22H9tYzPQyYZXF4UpTcsR31e9AQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 08/27] nvme-tcp-offload: Add nvme-tcp-offload -
 NVMeTCP HW offload ULP
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 davem@davemloft.net, 
 kuba@kernel.org, sagi@grimberg.me, hch@lst.de, axboe@fb.com, 
 kbusch@kernel.org, Ariel Elior <aelior@marvell.com>, 
 Michal Kalderon <mkalderon@marvell.com>, okulkarni@marvell.com,
 pkushwaha@marvell.com, Dean Balandin <dbalandin@marvell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_084618_468913_C973FCE2 
X-CRM114-Status: GOOD (  24.30  )
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

T24gNS8xLzIxIDM6MTggUE0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiBPbiA0LzI5LzIxIDk6
MDkgUE0sIFNoYWkgTWFsaW4gd3JvdGU6Cj4gPiBUaGlzIHBhdGNoIHdpbGwgcHJlc2VudCB0aGUg
c3RydWN0dXJlIGZvciB0aGUgTlZNZVRDUCBvZmZsb2FkIGNvbW1vbgo+ID4gbGF5ZXIgZHJpdmVy
LiBUaGlzIG1vZHVsZSBpcyBhZGRlZCB1bmRlciAiZHJpdmVycy9udm1lL2hvc3QvIiBhbmQgZnV0
dXJlCj4gPiBvZmZsb2FkIGRyaXZlcnMgd2hpY2ggd2lsbCByZWdpc3RlciB0byBpdCB3aWxsIGJl
IHBsYWNlZCB1bmRlcgo+ID4gImRyaXZlcnMvbnZtZS9odyIuCj4gPiBUaGlzIG5ldyBkcml2ZXIg
d2lsbCBiZSBlbmFibGVkIGJ5IHRoZSBLY29uZmlnICJOVk0gRXhwcmVzcyBvdmVyIEZhYnJpY3MK
PiA+IFRDUCBvZmZsb2FkIGNvbW1tb24gbGF5ZXIiLgo+ID4gSW4gb3JkZXIgdG8gc3VwcG9ydCB0
aGUgbmV3IHRyYW5zcG9ydCB0eXBlLCBmb3IgaG9zdCBtb2RlLCBubyBjaGFuZ2UgaXMKPiA+IG5l
ZWRlZC4KPiA+Cj4gPiBFYWNoIG5ldyB2ZW5kb3Itc3BlY2lmaWMgb2ZmbG9hZCBkcml2ZXIgd2ls
bCByZWdpc3RlciB0byB0aGlzIFVMUCBkdXJpbmcKPiA+IGl0cyBwcm9iZSBmdW5jdGlvbiwgYnkg
ZmlsbGluZyBvdXQgdGhlIG52bWVfdGNwX29mbGRfZGV2LT5vcHMgYW5kCj4gPiBudm1lX3RjcF9v
ZmxkX2Rldi0+cHJpdmF0ZV9kYXRhIGFuZCBjYWxsaW5nIG52bWVfdGNwX29mbGRfcmVnaXN0ZXJf
ZGV2Cj4gPiB3aXRoIHRoZSBpbml0aWFsaXplZCBzdHJ1Y3QuCj4gPgo+ID4gVGhlIGludGVybmFs
IGltcGxlbWVudGF0aW9uOgo+ID4gLSB0Y3Atb2ZmbG9hZC5oOgo+ID4gICAgSW5jbHVkZXMgYWxs
IGNvbW1vbiBzdHJ1Y3RzIGFuZCBvcHMgdG8gYmUgdXNlZCBhbmQgc2hhcmVkIGJ5IG9mZmxvYWQK
PiA+ICAgIGRyaXZlcnMuCj4gPgo+ID4gLSB0Y3Atb2ZmbG9hZC5jOgo+ID4gICAgSW5jbHVkZXMg
dGhlIGluaXQgZnVuY3Rpb24gd2hpY2ggcmVnaXN0ZXJzIGFzIGEgTlZNZiB0cmFuc3BvcnQganVz
dAo+ID4gICAgbGlrZSBhbnkgb3RoZXIgdHJhbnNwb3J0Lgo+ID4KPiA+IEFja2VkLWJ5OiBJZ29y
IFJ1c3NraWtoIDxpcnVzc2tpa2hAbWFydmVsbC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBEZWFu
IEJhbGFuZGluIDxkYmFsYW5kaW5AbWFydmVsbC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmFi
aGFrYXIgS3VzaHdhaGEgPHBrdXNod2FoYUBtYXJ2ZWxsLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6
IE9ta2FyIEt1bGthcm5pIDxva3Vsa2FybmlAbWFydmVsbC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5
OiBNaWNoYWwgS2FsZGVyb24gPG1rYWxkZXJvbkBtYXJ2ZWxsLmNvbT4KPiA+IFNpZ25lZC1vZmYt
Ynk6IEFyaWVsIEVsaW9yIDxhZWxpb3JAbWFydmVsbC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBT
aGFpIE1hbGluIDxzbWFsaW5AbWFydmVsbC5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9udm1l
L2hvc3QvS2NvbmZpZyAgICAgICB8ICAxNiArKysKPiA+ICAgZHJpdmVycy9udm1lL2hvc3QvTWFr
ZWZpbGUgICAgICB8ICAgMyArCj4gPiAgIGRyaXZlcnMvbnZtZS9ob3N0L3RjcC1vZmZsb2FkLmMg
fCAxMjYgKysrKysrKysrKysrKysrKysrKwo+ID4gICBkcml2ZXJzL252bWUvaG9zdC90Y3Atb2Zm
bG9hZC5oIHwgMjA2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiAgIDQgZmls
ZXMgY2hhbmdlZCwgMzUxIGluc2VydGlvbnMoKykKPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvbnZtZS9ob3N0L3RjcC1vZmZsb2FkLmMKPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvbnZtZS9ob3N0L3RjcC1vZmZsb2FkLmgKPiA+Cj4gSXQgd2lsbCBiZSB0cmlja3kgdG8g
c2VsZWN0IHRoZSBjb3JyZWN0IHRyYW5zcG9ydCBlZyB3aGVuIHRyYXZlcnNpbmcgdGhlCj4gZGlz
Y292ZXJ5IGxvZyBwYWdlOyB0aGUgZGlzY292ZXJ5IGxvZyBwYWdlIG9ubHkga25vd3MgYWJvdXQg
J3RjcCcgKG5vdAo+ICd0Y3Bfb2ZmbG9hZCcpLCBzbyB0aGUgb2ZmbG9hZCB3b24ndCBiZSBwaWNr
ZWQgdXAuCj4gQnV0IHRoYXQgY2FuIHdlIHdvcmtlZCBvbiAvIGZpeGVkIGxhdGVyIG9uLCBhcyBp
dCdzIGFyZ3VhYmx5IGEgcG9saWN5Cj4gZGVjaXNpb24uCgpJIGFncmVlIHRoYXQgd2Ugc2hvdWxk
IGltcHJvdmUgdGhlIHBvbGljeSBkZWNpc2lvbiBhbmQgYWxsb3cgYWRkaXRpb25hbApjYXBhYmls
aXRpZXMgYW5kIGl0IG1heSBiZSBkaXNjdXNzZWQgYXMgYSBuZXcgTlZNZSBUUEFSLgoKPgo+IFJl
dmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KClRoYW5rcy4KCj4KPiBD
aGVlcnMsCj4KPiBIYW5uZXMKPiAtLQo+IERyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAg
ICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0Cj4gaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKPiBTVVNFIFNvZnR3YXJlIFNvbHV0aW9u
cyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKPiBIUkIgMzY4MDkgKEFHIE7D
vHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGlu
ZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
