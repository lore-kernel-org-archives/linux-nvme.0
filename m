Return-Path: <SRS0=/NUg=KW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4527CC47089
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 11:33:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2F33613D1
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 11:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F33613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RTuyiFXb2yeEgGs8pYLNAdtl0LaqyVXWlwiuxnBDejk=; b=lpLHypqX44O9yD
	ao30rncHYOGJCqNzR4/NI8sC9Z2lc3REBJ7V7uTnlUCaVrvExwH0WQpg7af8+PwTh4QMNd85u37Ya
	sz4QEXEB1sft5g6L6D24pNbQ1oh8J9z02GxQtlgOz/mh8iahr8oUsgGj9JXMywhTHcHTAB/ka/MwL
	hvA8plgSAjv4gHm5E6IPzNqcuaCsjLCkruIekenRWH6xGJGqTA3s2R8mSJa10dHHEciUmjo+jA5EU
	jzay8QtGLvzspxCz4jW0gxIAWa11W1Aa+3sebSiFbBu0gw3ANojdVx2387K8aUcwFT6Bbnt7BlAL9
	N3YNbXKqkhUw8wDyWeyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmEGc-005Jk9-56; Thu, 27 May 2021 11:33:34 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmEGZ-005JhB-4V
 for linux-nvme@lists.infradead.org; Thu, 27 May 2021 11:33:32 +0000
Received: by mail-io1-xd32.google.com with SMTP id n10so74992ion.8
 for <linux-nvme@lists.infradead.org>; Thu, 27 May 2021 04:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mqEDlk2sNzidNQvpGj45BkhBFjLGabgCz3RBJGy/iew=;
 b=ScprxQCoQ77glNlvOugxvVVrn69foGnY4OYqos0Y8SpYs5GVmKize2IiZE5LuTt6Nn
 5TRn6czbMwhPjUPRgXx+XHiG3shPxZiVtm0qpOPkuZT4+9IFpL64FAV8cavZnIJWPOfA
 sIDk+HY6m2PbxXiyecVkjP9ADuD/Uq2Uk9aa/kW0tlEZ1tV5oUwN+gMuTHWtbw/kYQBO
 eRgDHU8ATEA/EkgrODDXjvChMWnVnTgCmWZ34VvNObnHH1bsWs+qGW44Io0gTp3U9ugj
 HT+owS6Wvgsqqs96bl1Ho3sKZ2bb0eHVuFM35z5oVdtRwae0IQqv6oq2mEskP5UHHHW8
 PVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mqEDlk2sNzidNQvpGj45BkhBFjLGabgCz3RBJGy/iew=;
 b=XiVTFox1m0ievmUOfUD8Fl4OEY0eym/qDmeDLCI597wTrBwEmy06I3LwiQc1934R20
 IRaYLvJiHFaKtqmSTY6PgnfVF72JqUhI4QJssPBkG5PM1T/pNC7JZPUICNwy8OW6wRnZ
 kB+osqdXYGfb6BgNv2Tt5fMeQslZwijL5iyTvOCL5yHDLsSYmMMCbeKUtevWnzsjZbqU
 w268R6ZtTyil5lVwByOUT2orTJNZ2iBgZ6nRumlou2ZEB5I0r8M3Um6DNRRoVVMjp3UF
 aNQd6raJYVJWv8cIV+fg0Indi0jso4HhVgyq7EFd/a9gb31a/qqPLWycHFkRUS5TYvOK
 XjNg==
X-Gm-Message-State: AOAM531Zw0+dsvWsQubTWCiOpwHa7ZcMY5ZmWAb5+tBmHOyKP+D5Cszd
 stf8BkEFZepNy5WSDbaisCpwciDSBmSjmbDJLgw=
X-Google-Smtp-Source: ABdhPJzDl1R9x0T3SQJFORSI2Yh6UeZHLzFcpUuyu7djM0Nn8FsFhP89Sb7bZM+cRt3bywuRGh2vhe27TzvpJpW0ZsM=
X-Received: by 2002:a05:6638:3445:: with SMTP id
 q5mr3101199jav.120.1622115208036; 
 Thu, 27 May 2021 04:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210513130410.1186-1-houpu.main@gmail.com>
 <ab5cb841-abd6-16a9-af4f-a4824838d684@suse.de>
In-Reply-To: <ab5cb841-abd6-16a9-af4f-a4824838d684@suse.de>
From: Hou Pu <houpu.main@gmail.com>
Date: Thu, 27 May 2021 19:33:16 +0800
Message-ID: <CAKHcvQitkVOdjGNxpsfV+45JZ6eiB+J3j9Ujiky-HBcembxsjQ@mail.gmail.com>
Subject: Re: [PATCH] nvmet: use new ana_log_size instead the old one
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, hch@lst.de, 
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_043331_208352_A1DBE19C 
X-CRM114-Status: GOOD (  21.74  )
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

T24gVGh1LCBNYXkgMjcsIDIwMjEgYXQgNzoyNCBQTSBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3Vz
ZS5kZT4gd3JvdGU6Cj4KPiBPbiA1LzEzLzIxIDM6MDQgUE0sIEhvdSBQdSB3cm90ZToKPiA+IFRo
ZSBuZXcgYW5hX2xvZ19zaXplIHNob3VsZCBiZSB1c2VkIGluc3RlYWQgb2YgdGhlIG9sZCBvbmUu
Cj4gPiBPciBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIHdpbGwgaGFwcGVuIGxpa2Ug
YmVsb3c6Cj4gPgo+ID4gWyAgIDM4Ljk1Nzg0OV1bICAgVDY5XSBCVUc6IGtlcm5lbCBOVUxMIHBv
aW50ZXIgZGVyZWZlcmVuY2UsIGFkZHJlc3M6IDAwMDAwMDAwMDAwMDAwM2MKPiA+IFsgICAzOC45
NzU1NTBdWyAgIFQ2OV0gI1BGOiBzdXBlcnZpc29yIHdyaXRlIGFjY2VzcyBpbiBrZXJuZWwgbW9k
ZQo+ID4gWyAgIDM4Ljk3NTk1NV1bICAgVDY5XSAjUEY6IGVycm9yX2NvZGUoMHgwMDAyKSAtIG5v
dC1wcmVzZW50IHBhZ2UKPiA+IFsgICAzOC45NzY5MDVdWyAgIFQ2OV0gUEdEIDAgUDREIDAKPiA+
IFsgICAzOC45NzkzODhdWyAgIFQ2OV0gT29wczogMDAwMiBbIzFdIFNNUCBOT1BUSQo+ID4gWyAg
IDM4Ljk4MDQ4OF1bICAgVDY5XSBDUFU6IDAgUElEOiA2OSBDb21tOiBrd29ya2VyLzA6MiBOb3Qg
dGFpbnRlZCA1LjEyLjArICM1NAo+ID4gWyAgIDM4Ljk4MTI1NF1bICAgVDY5XSBIYXJkd2FyZSBu
YW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUyByZWwtMS4x
NC4wLTAtZzE1NTgyMWExOTkwYi1wcmVidWlsdC5xZW11Lm9yZyAwNC8wMS8yMDE0Cj4gPiBbICAg
MzguOTgyNTAyXVsgICBUNjldIFdvcmtxdWV1ZTogZXZlbnRzIG52bWVfbG9vcF9leGVjdXRlX3dv
cmsKPiA+IFsgICAzOC45ODUyMTldWyAgIFQ2OV0gUklQOiAwMDEwOm1lbWNweV9vcmlnKzB4Njgv
MHgxMGYKPiA+IFsgICAzOC45ODYyMDNdWyAgIFQ2OV0gQ29kZTogODMgYzIgMjAgZWIgNDQgNDgg
MDEgZDYgNDggMDEgZDcgNDggODMgZWEgMjAgMGYgMWYgMDAgNDggODMgZWEgMjAgNGMgOGIgNDYg
ZjggNGMgOGIgNGUgZjAgNGMgOGIgNTYgZTggNGMgOGIgNWUgZTAgNDggOGQgNzYgZTAgPDRjPiA4
OSA0NyBmOCA0YyA4OSA0ZiBmMCA0YyA4OSA1NyBlOCA0YyA4OSA1ZiBlMCA0OCA4ZCA3ZiBlMCA3
MyBkMgo+ID4gWyAgIDM4Ljk4NzY3N11bICAgVDY5XSBSU1A6IDAwMTg6ZmZmZmM5MDAwMDFiN2Q0
OCBFRkxBR1M6IDAwMDAwMjg3Cj4gPiBbICAgMzguOTg3OTk2XVsgICBUNjldIFJBWDogMDAwMDAw
MDAwMDAwMDAyMCBSQlg6IDAwMDAwMDAwMDAwMDAwMjQgUkNYOiAwMDAwMDAwMDAwMDAwMDEwCj4g
PiBbICAgMzguOTg4MzI3XVsgICBUNjldIFJEWDogZmZmZmZmZmZmZmZmZmZlNCBSU0k6IGZmZmY4
ODgxMDg0YmMwMDQgUkRJOiAwMDAwMDAwMDAwMDAwMDQ0Cj4gPiBbICAgMzguOTg4NjIwXVsgICBU
NjldIFJCUDogMDAwMDAwMDAwMDAwMDAyNCBSMDg6IDAwMDAwMDAxMDAwMDAwMDAgUjA5OiAwMDAw
MDAwMDAwMDAwMDAwCj4gPiBbICAgMzguOTg4OTkxXVsgICBUNjldIFIxMDogMDAwMDAwMDEwMDAw
MDAwMCBSMTE6IDAwMDAwMDAwMDAwMDAwMDEgUjEyOiAwMDAwMDAwMDAwMDAwMDI0Cj4gPiBbICAg
MzguOTg5Mjg5XVsgICBUNjldIFIxMzogZmZmZjg4ODEwODRiYzAwMCBSMTQ6IDAwMDAwMDAwMDAw
MDAwMDAgUjE1OiAwMDAwMDAwMDAwMDAwMDI0Cj4gPiBbICAgMzguOTg5ODQ1XVsgICBUNjldIEZT
OiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmODg4MjM3YzAwMDAwKDAwMDApIGtubEdT
OjAwMDAwMDAwMDAwMDAwMDAKPiA+IFsgICAzOC45OTAyMzRdWyAgIFQ2OV0gQ1M6ICAwMDEwIERT
OiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwo+ID4gWyAgIDM4Ljk5MDQ5MF1b
ICAgVDY5XSBDUjI6IDAwMDAwMDAwMDAwMDAwM2MgQ1IzOiAwMDAwMDAwMTA4NWIyMDAwIENSNDog
MDAwMDAwMDAwMDAwMDZmMAo+ID4gWyAgIDM4Ljk5MTEwNV1bICAgVDY5XSBDYWxsIFRyYWNlOgo+
ID4gWyAgIDM4Ljk5NDE1N11bICAgVDY5XSAgc2dfY29weV9idWZmZXIrMHhiOC8weGYwCj4gPiBb
ICAgMzguOTk1MzU3XVsgICBUNjldICBudm1ldF9jb3B5X3RvX3NnbCsweDQ4LzB4NmQKPiA+IFsg
ICAzOC45OTU1NjVdWyAgIFQ2OV0gIG52bWV0X2V4ZWN1dGVfZ2V0X2xvZ19wYWdlX2FuYSsweGQ0
LzB4MWNiCj4gPiBbICAgMzguOTk1NzkyXVsgICBUNjldICBudm1ldF9leGVjdXRlX2dldF9sb2df
cGFnZSsweGM5LzB4MTQ2Cj4gPiBbICAgMzguOTk1OTkyXVsgICBUNjldICBudm1lX2xvb3BfZXhl
Y3V0ZV93b3JrKzB4M2UvMHg0NAo+ID4gWyAgIDM4Ljk5NjE4MV1bICAgVDY5XSAgcHJvY2Vzc19v
bmVfd29yaysweDFjMy8weDNjMAo+ID4gWyAgIDM4Ljk5NjM5M11bICAgVDY5XSAgd29ya2VyX3Ro
cmVhZCsweDQ0LzB4M2QwCj4gPiBbICAgMzguOTk2NjAwXVsgICBUNjldICA/IGNhbmNlbF9kZWxh
eWVkX3dvcmsrMHg5MC8weDkwCj4gPiBbICAgMzguOTk2ODA0XVsgICBUNjldICBrdGhyZWFkKzB4
ZjcvMHgxMzAKPiA+IFsgICAzOC45OTY5NjFdWyAgIFQ2OV0gID8ga3RocmVhZF9jcmVhdGVfd29y
a2VyX29uX2NwdSsweDcwLzB4NzAKPiA+IFsgICAzOC45OTcxNzFdWyAgIFQ2OV0gIHJldF9mcm9t
X2ZvcmsrMHgyMi8weDMwCj4gPiBbICAgMzguOTk3NzA1XVsgICBUNjldIE1vZHVsZXMgbGlua2Vk
IGluOgo+ID4gWyAgIDM4Ljk5ODc0MV1bICAgVDY5XSBDUjI6IDAwMDAwMDAwMDAwMDAwM2MKPiA+
IFsgICAzOS4wMDAxMDRdWyAgIFQ2OV0gLS0tWyBlbmQgdHJhY2UgZTcxOTkyN2I2MDlkMGZhMCBd
LS0tCj4gPgo+ID4gRml4ZXM6IDVlMWY2ODk5MTNhNCAoIm52bWUtbXVsdGlwYXRoOiBmaXggZG91
YmxlIGluaXRpYWxpemF0aW9uIG9mIEFOQSBzdGF0ZSIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBIb3Ug
UHUgPGhvdXB1Lm1haW5AZ21haWwuY29tPgo+ID4gLS0tCj4gPiAgZHJpdmVycy9udm1lL2hvc3Qv
bXVsdGlwYXRoLmMgfCAyICstCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L211bHRp
cGF0aC5jIGIvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMKPiA+IGluZGV4IGRlYjE0NTYy
Yzk2YS4uZjgxODcxYzcxMjhhIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvbXVs
dGlwYXRoLmMKPiA+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4gPiBAQCAt
ODE3LDcgKzgxNyw3IEBAIGludCBudm1lX21wYXRoX2luaXRfaWRlbnRpZnkoc3RydWN0IG52bWVf
Y3RybCAqY3RybCwgc3RydWN0IG52bWVfaWRfY3RybCAqaWQpCj4gPiAgICAgICBpZiAoYW5hX2xv
Z19zaXplID4gY3RybC0+YW5hX2xvZ19zaXplKSB7Cj4gPiAgICAgICAgICAgICAgIG52bWVfbXBh
dGhfc3RvcChjdHJsKTsKPiA+ICAgICAgICAgICAgICAga2ZyZWUoY3RybC0+YW5hX2xvZ19idWYp
Owo+ID4gLSAgICAgICAgICAgICBjdHJsLT5hbmFfbG9nX2J1ZiA9IGttYWxsb2MoY3RybC0+YW5h
X2xvZ19zaXplLCBHRlBfS0VSTkVMKTsKPiA+ICsgICAgICAgICAgICAgY3RybC0+YW5hX2xvZ19i
dWYgPSBrbWFsbG9jKGFuYV9sb2dfc2l6ZSwgR0ZQX0tFUk5FTCk7Cj4gPiAgICAgICAgICAgICAg
IGlmICghY3RybC0+YW5hX2xvZ19idWYpCj4gPiAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IC1FTk9NRU07Cj4gPiAgICAgICB9Cj4gPgo+IFBsZWFzZSBmaXh1cCB0aGUgc3ViamVjdCBsaW5l
OyB0aGlzIGlzIF9ub3RfIGZvciBudm1ldCwgYnV0IHJhdGhlciB0aGUKPiBpbml0aWF0b3Igc2lk
ZSAnbnZtZScuCj4KPiBPdGhlcndpc2U6Cj4KPiBSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tl
IDxoYXJlQHN1c2UuZGU+Cj4KPiBDaHJpc3RvcGgsIHBsZWFzZSBwdWxsIHRoaXMgaW47IGl0IHJl
bGlhYmx5IGtpbGxzIG15IHRlc3RiZWQgLi4uCkkgZm91bmQgdGhhdCB0aGlzIHBhdGNoIGhhcyBi
ZWVuIGFwcGxpZWQgdG8gbnZtZS01LjEzIGFscmVhZHkuCkkgYW0gc29ycnkgZm9yIHRoZSBpbXBy
b3BlciBzdWJqZWN0IGxpbmUuCgpUaGFua3MsCkhvdQoKPgo+IENoZWVycywKPgo+IEhhbm5lcwo+
IC0tCj4gRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9y
YWdlIEFyY2hpdGVjdAo+IGhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKPiBTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55
IEdtYkgsIDkwNDA5IE7DvHJuYmVyZwo+IEdGOiBGLiBJbWVuZMO2cmZmZXIsIEhSQiAzNjgwOSAo
QUcgTsO8cm5iZXJnKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZt
ZQo=
