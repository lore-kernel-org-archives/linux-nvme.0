Return-Path: <SRS0=a62X=FU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B41C4361B
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Dec 2020 17:43:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14F323C8D
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Dec 2020 17:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14F323C8D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JH4KiLy7dYvmSDBHcdF6D1W/4LVUf0XAJt0084Fb1mM=; b=rxrGka1choSta0FGlYPrS1RZe
	EYCC8GIs+uy3sz31/7xiSMJgSxyZueXkjSl8H/UYkvG0hStQgBATf+xSOSUD7bOz+Ty0iFbHFMX6K
	5jKnUVek1FmUpCDCakWJDk92k18x5ISEmQwWNdXhrWdw100Dh+dDf3l4VKb7unErm/jpLF6zHUycJ
	ULlW17TBxCkWdwueXFXgq7H3H7H3H75HGWGoTkea9QbZPwnZjAmMEMDBlPmZ4KkyAQtdb9apWfBmL
	MN/m2Pe1akgTzTih7Olzoi8/PLgmU+5NJLBJh4mvmCy/mwwaBAxMHGONd1tQrgYYF8nOBuY6HJkMx
	xJAwXePbQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kpapk-0002XG-Rn; Wed, 16 Dec 2020 17:43:29 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpapi-0002VX-9R
 for linux-nvme@lists.infradead.org; Wed, 16 Dec 2020 17:43:27 +0000
Received: by mail-ed1-x533.google.com with SMTP id r5so25715267eda.12
 for <linux-nvme@lists.infradead.org>; Wed, 16 Dec 2020 09:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=H+3RNEaIlplEsNKj4tKhHJ8/EvDoMT5Q6fp5481U93w=;
 b=Bm++DYiaI5h4OrUVd8RoF9m/oV0tQMk4OvNQ/JIOQMWUT4kfD4WzsOBVVwhDuU60tE
 P8bceoB7xdQPXr4RCmTJ67Uoxq222qdIyTwueQItFvy2zK71GNeiPhmyANdJx6iv6o2M
 QhKJgYb1Ds0O9wvjOkFeCBjk2RqYqR7ID2P1/7paX7Z/vowZEQeo8aqIPlTdT3bt+dlt
 dM9MJa8IJNpW9w4ezwWg8HnNv9JtbRTs7gX+gqpDXiVL2ZplXLBf03afOYGIJpszSBM/
 FwwxJ5tmKQmwKSxF5IDfBO4YZDxVfVqwY1ujnl696ThPIzvjrKdL0KGUn65oA9KcBV23
 9Yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=H+3RNEaIlplEsNKj4tKhHJ8/EvDoMT5Q6fp5481U93w=;
 b=kph+QaAddoRF39NrX12EKi7O163OHBpeEMEJKZvLX9KqytEuo99WQauvo91ICkUK25
 bZUA6S0eRXYqAMSCaFWMIvpvyCG04YdAYcytBmfcmJLgIlbLPZMwpSWegWB8aFJ3Ab5S
 OOdNoMAk/lfiPdKeo6c8QZUBgrLOOQ7j+eZZYp/lFVaA33lJ4hzOPCVyplaX3glnYGXa
 e5KUoriUXiLkqdiO+klyQH03RM8H9JlwHsJPwI0+um3LKNlZ8oVpY5DZBmd/nJCxcqOa
 jfs4+lBGH+kLQ7N6eZdm+eA/XHClpcRHbhDsSvQPj8n5Vf09Go+pU/HMQvB2HQ3RQsB2
 aZ2w==
X-Gm-Message-State: AOAM530QNCoZDkllVLAi8NcIJRRJNopA81ScW1IG5PPOXvZGZyq/OeQ1
 MqjlqLGeivq7PY2f5t87pPjnyw==
X-Google-Smtp-Source: ABdhPJxyMzG3y1cEoqg95J+1Pq0ibGAMp9Jca894WL69eMAvmnAZ49QAV61L0YxZzcqmcSSkmRUh6g==
X-Received: by 2002:a50:d8c8:: with SMTP id y8mr7744834edj.82.1608140603951;
 Wed, 16 Dec 2020 09:43:23 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id d14sm23243577edn.31.2020.12.16.09.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Dec 2020 09:43:23 -0800 (PST)
Date: Wed, 16 Dec 2020 18:43:22 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: nvme: enable char device per namespace
Message-ID: <20201216174322.v2ahfdhvgix536gd@unifi>
References: <20201215224607.GB3915989@dhcp-10-100-145-180.wdc.com>
 <10318EDE-F4D0-4C89-B69D-3D5ACA4308C2@javigon.com>
 <20201216162631.GA77639@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201216162631.GA77639@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201216_124326_461717_A8E73B86 
X-CRM114-Status: GOOD (  26.65  )
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
Cc: linux-block@vger.kernel.org, minwoo.im.dev@gmail.com, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTYuMTIuMjAyMCAwODoyNiwgS2VpdGggQnVzY2ggd3JvdGU6Cj5PbiBXZWQsIERlYyAxNiwg
MjAyMCBhdCAwOTowMTo1MUFNICswMTAwLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PiA+IE9u
IDE1IERlYyAyMDIwLCBhdCAyMy40NiwgS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPiB3
cm90ZToKPj4gPiDvu79PbiBUdWUsIERlYyAxNSwgMjAyMCBhdCAwODo1NTo1N1BNICswMTAwLCBq
YXZpZXJAamF2aWdvbi5jb20gd3JvdGU6Cj4+ID4+ICtzdGF0aWMgaW50IG52bWVfYWxsb2NfY2hh
cmRldl9ucyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCBzdHJ1Y3QgbnZtZV9ucyAqbnMpCj4+ID4+
ICt7Cj4+ID4+ICsgICAgY2hhciBjZGlza19uYW1lW0RJU0tfTkFNRV9MRU5dOwo+PiA+PiArICAg
IGludCByZXQ7Cj4+ID4+ICsKPj4gPj4gKyAgICBkZXZpY2VfaW5pdGlhbGl6ZSgmbnMtPmNkZXZf
ZGV2aWNlKTsKPj4gPj4gKyAgICBucy0+Y2Rldl9kZXZpY2UuZGV2dCA9IE1LREVWKE1BSk9SKG52
bWVfbnNfYmFzZV9jaHJfZGV2dCksCj4+ID4+ICsgICAgICAgICAgICAgICAgICAgICBucy0+aGVh
ZC0+aW5zdGFuY2UpOwo+PiA+Cj4+ID4gQWgsIEkgc2VlIG5vdy4gV2UgYXJlIG1ha2luZyB0aGVz
ZSBnZW5lcmljIGhhbmRsZXMgZm9yIGVhY2ggcGF0aCwgYnV0Cj4+ID4gdGhlIG5zLT5oZWFkLT5p
bnN0YW5jZSBpcyB0aGUgc2FtZSBmb3IgYWxsIHBhdGhzIHRvIGEgbmFtZXNwYWNlLCBzbyBpdCdz
Cj4+ID4gbm90IHVuaXF1ZSBmb3IgdGhhdC4gRnVydGhlciwgdGhhdCBoZWFkLT5pbnN0YW5jZSBp
cyBhbGxvY2F0ZWQgcGVyCj4+ID4gc3Vic3lzdGVtLCBzbyBpdCdzIG5vdCB1bmlxdWUgZnJvbSBu
YW1lc3BhY2UgaGVhZHMgc2VlbiBpbiBvdGhlcgo+PiA+IHN1YnN5c3RlbXMuCj4+ID4KPj4gPiBT
bywgSSB0aGluayB5b3UgbmVlZCB0byBhbGxvY2F0ZSBhIG5ldyBkZXZfdCBmb3IgZWFjaCBzdWJz
eXN0ZW0gcmF0aGVyCj4+ID4gdGhhbiB0aGUgZ2xvYmFsIG52bWVfbnNfYmFzZV9jaHJfZGV2dCwg
YW5kIEkgZ3Vlc3Mgd2UgYWxzbyBuZWVkIGEgbmV3Cj4+ID4gbnZtZV9ucyBpbnN0YW5jZSBmaWVs
ZCBhc3NpZ25lZCBmcm9tIHlldCBhbm90aGVyIGlkYT8KPj4KPj4gT2suIEnigJlsbCBsb29rIGlu
dG8gaXQuCj4KPlRoZSBzdWdnZXN0aW9uIG1heSBiZSBvdmVya2lsbCBhcyB3ZSBkb24ndCBuZWVk
IHVuaXF1ZSBtYWpvcnMgZm9yIGVhY2gKPmNvbnRyb2xsZXIgcmlnaHQgbm93ICh0aGF0IG1heSBj
aGFuZ2UgaWYgcGVvcGxlIG5lZWQgbW9yZSB0aGFuIGEKPm1pbGxpb24gZ2VuZXJpYyBoYW5kbGVz
LCBidXQgSSB0aGluayB3ZSdyZSBhIHdheXMgb2ZmIGZyb20gdGhhdCByZWFsaXR5KS4KPgo+VGhl
IGZvbGxvd2luZyBvbiB0b3Agb2YgeW91ciBwYXRjaCBtYWtlcyBpdCBhbGwgd29yayBmb3IgbWUu
IEFsc28sIEkKPmRvbid0IHRoaW5rIHdlIHNob3VsZCBhYm9ydCBhZGRpbmcgdGhlIG5hbWVzcGFj
ZSBpZiB0aGUgZ2VuZXJpYyBoYW5kbGUKPmZhaWxzLCBzbyB0aGF0J3MgaW5jbHVkZWQgaGVyZSB0
b286Cj4KPi0tLQo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYwo+aW5kZXggYzFhYTRiY2NkZWIyLi5jYzllYWY0ZWJhMzIgMTAw
NjQ0Cj4tLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPisrKyBiL2RyaXZlcnMvbnZtZS9o
b3N0L2NvcmUuYwo+QEAgLTg2LDYgKzg2LDggQEAgc3RhdGljIERFRklORV9NVVRFWChudm1lX3N1
YnN5c3RlbXNfbG9jayk7Cj4KPiBzdGF0aWMgREVGSU5FX0lEQShudm1lX2luc3RhbmNlX2lkYSk7
Cj4gc3RhdGljIGRldl90IG52bWVfY3RybF9iYXNlX2Nocl9kZXZ0Owo+Kwo+K3N0YXRpYyBERUZJ
TkVfSURBKG52bWVfZ2VuX21pbm9yX2lkYSk7Cj4gc3RhdGljIGRldl90IG52bWVfbnNfYmFzZV9j
aHJfZGV2dDsKPiBzdGF0aWMgc3RydWN0IGNsYXNzICpudm1lX2NsYXNzOwo+IHN0YXRpYyBzdHJ1
Y3QgY2xhc3MgKm52bWVfbnNfY2xhc3M7Cj5AQCAtNTM5LDcgKzU0MSw4IEBAIHN0YXRpYyB2b2lk
IG52bWVfZnJlZV9ucyhzdHJ1Y3Qga3JlZiAqa3JlZikKPgo+IAlpZiAobnMtPm5kZXYpCj4gCQlu
dm1lX252bV91bnJlZ2lzdGVyKG5zKTsKPi0KPisJaWYgKG5zLT5taW5vcikKPisJCWlkYV9zaW1w
bGVfcmVtb3ZlKCZudm1lX2dlbl9taW5vcl9pZGEsIG5zLT5taW5vciAtIDEpOwo+IAljZGV2X2Rl
dmljZV9kZWwoJm5zLT5jZGV2LCAmbnMtPmNkZXZfZGV2aWNlKTsKPiAJcHV0X2Rpc2sobnMtPmRp
c2spOwo+IAludm1lX3B1dF9uc19oZWFkKG5zLT5oZWFkKTsKPkBAIC0zOTMyLDkgKzM5MzUsMTMg
QEAgc3RhdGljIGludCBudm1lX2FsbG9jX2NoYXJkZXZfbnMoc3RydWN0IG52bWVfY3RybCAqY3Ry
bCwgc3RydWN0IG52bWVfbnMgKm5zKQo+IAljaGFyIGNkaXNrX25hbWVbRElTS19OQU1FX0xFTl07
Cj4gCWludCByZXQ7Cj4KPisJcmV0ID0gaWRhX3NpbXBsZV9nZXQoJm52bWVfZ2VuX21pbm9yX2lk
YSwgMCwgMCwgR0ZQX0tFUk5FTCk7Cj4rCWlmIChyZXQgPCAwKQo+KwkJcmV0dXJuIHJldDsKPisK
PisJbnMtPm1pbm9yID0gcmV0ICsgMTsKPiAJZGV2aWNlX2luaXRpYWxpemUoJm5zLT5jZGV2X2Rl
dmljZSk7Cj4tCW5zLT5jZGV2X2RldmljZS5kZXZ0ID0gTUtERVYoTUFKT1IobnZtZV9uc19iYXNl
X2Nocl9kZXZ0KSwKPi0JCQkJICAgICBucy0+aGVhZC0+aW5zdGFuY2UpOwo+Kwlucy0+Y2Rldl9k
ZXZpY2UuZGV2dCA9IE1LREVWKE1BSk9SKG52bWVfbnNfYmFzZV9jaHJfZGV2dCksIHJldCk7Cj4g
CW5zLT5jZGV2X2RldmljZS5jbGFzcyA9IG52bWVfbnNfY2xhc3M7Cj4gCW5zLT5jZGV2X2Rldmlj
ZS5wYXJlbnQgPSBjdHJsLT5kZXZpY2U7Cj4gCW5zLT5jZGV2X2RldmljZS5ncm91cHMgPSBudm1l
X25zX2NoYXJfaWRfYXR0cl9ncm91cHM7Cj5AQCAtMzk0NSwxNSArMzk1MiwyMiBAQCBzdGF0aWMg
aW50IG52bWVfYWxsb2NfY2hhcmRldl9ucyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCBzdHJ1Y3Qg
bnZtZV9ucyAqbnMpCj4KPiAJcmV0ID0gZGV2X3NldF9uYW1lKCZucy0+Y2Rldl9kZXZpY2UsICIl
cyIsIGNkaXNrX25hbWUpOwo+IAlpZiAocmV0KQo+LQkJcmV0dXJuIHJldDsKPisJCWdvdG8gcHV0
X2lkYTsKPgo+IAljZGV2X2luaXQoJm5zLT5jZGV2LCAmbnZtZV9jZGV2X2ZvcHMpOwo+IAlucy0+
Y2Rldi5vd25lciA9IGN0cmwtPm9wcy0+bW9kdWxlOwo+Cj4gCXJldCA9IGNkZXZfZGV2aWNlX2Fk
ZCgmbnMtPmNkZXYsICZucy0+Y2Rldl9kZXZpY2UpOwo+IAlpZiAocmV0KQo+LQkJa2ZyZWVfY29u
c3QobnMtPmNkZXZfZGV2aWNlLmtvYmoubmFtZSk7Cj4rCQlnb3RvIGZyZWVfa29iajsKPisKPisJ
cmV0dXJuIHJldDsKPgo+K2ZyZWVfa29iajoKPisJa2ZyZWVfY29uc3QobnMtPmNkZXZfZGV2aWNl
LmtvYmoubmFtZSk7Cj4rcHV0X2lkYToKPisJaWRhX3NpbXBsZV9yZW1vdmUoJm52bWVfZ2VuX21p
bm9yX2lkYSwgbnMtPm1pbm9yIC0gMSk7Cj4rCW5zLT5taW5vciA9IDA7Cj4gCXJldHVybiByZXQ7
Cj4gfQo+Cj5AQCAtNDAyMyw3ICs0MDM3LDkgQEAgc3RhdGljIHZvaWQgbnZtZV9hbGxvY19ucyhz
dHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCB1bnNpZ25lZCBuc2lkLAo+IAludm1lX2ZhdWx0X2luamVj
dF9pbml0KCZucy0+ZmF1bHRfaW5qZWN0LCBucy0+ZGlzay0+ZGlza19uYW1lKTsKPgo+IAlpZiAo
bnZtZV9hbGxvY19jaGFyZGV2X25zKGN0cmwsIG5zKSkKPi0JCWdvdG8gb3V0X3B1dF9kaXNrOwo+
KwkJZGV2X3dhcm4oY3RybC0+ZGV2aWNlLAo+KwkJCSJmYWlsZWQgdG8gY3JlYXRlIGdlbmVyaWMg
aGFuZGxlIGZvciBuc2lkOiVkXG4iLAo+KwkJCW5zaWQpOwo+Cj4gCWtmcmVlKGlkKTsKPgo+ZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaCBiL2RyaXZlcnMvbnZtZS9ob3N0L252
bWUuaAo+aW5kZXggMTY4Yzc3MTljZGE0Li5jY2ZkNDlkMmEwMzAgMTAwNjQ0Cj4tLS0gYS9kcml2
ZXJzL252bWUvaG9zdC9udm1lLmgKPisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaAo+QEAg
LTQzNSw2ICs0MzUsNyBAQCBzdHJ1Y3QgbnZtZV9ucyB7Cj4KPiAJc3RydWN0IGRldmljZSBjZGV2
X2RldmljZTsJLyogY2hhciBkZXZpY2UgKi8KPiAJc3RydWN0IGNkZXYgY2RldjsKPisJaW50IG1p
bm9yOwo+Cj4gCWludCBsYmFfc2hpZnQ7Cj4gCXUxNiBtczsKPi0tCgpUaGFua3MgS2VpdGguIEkg
d2lsbCBzZW5kIGEgbmV3IHZlcnNpb24gdG9kYXkuCgpSZWdhcmRpbmcgbnZtZS1jbGk6IHdoYXQg
YXJlIHlvdXIgdGhvdWdodHM/CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=
