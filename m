Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70F5C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 20:45:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22802074D
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 20:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u2XNuiko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22802074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qUYvG1L71l6v2gtbH2szNwrfQmiMazMbUXzSOdUsN+k=; b=u2XNuikoSVGUqQtX4ENFv7ypg
	GgEXT48RcypzfIhyuMxWPCz1xJ6OhdTtR5hRAGujgGs8Ey2c8/NLK6aBbpBwVffLXmY8QFRQrFUb/
	s8jpAzg4Cy725d11tlstHVLYzWuA1jpS84xJUjDLXJzjAovg+9Ou4HXQZp4kTGmxi4lcn00bUtItS
	fv/xGOxw+vIENMmLCKicX+qSDmDnCLwwqzK6vVMu1CbEMgba67s7kdabNTOeanaqOPhoKPFHYPwYh
	6hFCizHaRxboMFM4Z5Mtr6BrBUbKN3jcub5hcmD6HliNhYDKsVp1J8yCtX3PPsjMIRVCs9BBBsqCo
	5WW7auPLQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6gZo-0003W4-O7; Fri, 14 Aug 2020 20:45:24 +0000
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6gZm-0003VF-MQ
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 20:45:23 +0000
Received: by mail-pg1-f193.google.com with SMTP id d19so5073997pgl.10
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 13:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pmkh8BPJsGYU0dWtb4D8/FWMc/a6NOcENQVLZIHuvPY=;
 b=aTSXJafbpkivbGM3ertmhOZ0/iwm9ULl0qtDK7MSwIyJn81vO5rK38eUGPoQLUzlNY
 ECvPuZzlxhzfZTQBjbAFn54sCnC18W99WbGXFY1de9XmB0HItwZoTV6YENAeFU9jQmQ6
 VKjfQ4ofn/ev9ofPAi55HhqkYJe7QSQz90HeNklQ9/UkmvE5fSaOi004XmX/jhj2PPtq
 hsmipAQfgAMyqB4wwa9OMxIZuQverNQx5q+78ex88+DNAkCSvKXkPepENyRo/2/cMZi7
 ly9ySv4GLGJ6DX5zbwPUb1ykHoxCfZkeH19SYQGRdqDt52xaDgj+GZ4kCNPxouUeoga/
 GWhA==
X-Gm-Message-State: AOAM532pn8aHbvEAGW+3nGR2dw/Vbld5epmh5SZ9+vDcBwpbwsBX0Fhd
 ihm370JhOPd52iDQslYxUls=
X-Google-Smtp-Source: ABdhPJz5fPJt8+qdOEqEqPiQpAN3SlE9t5zf/ZATPSZg9bXmFMNeWdKzve49feAFopd7kfAkfxMGMQ==
X-Received: by 2002:a62:aa07:: with SMTP id e7mr2972987pff.71.1597437921644;
 Fri, 14 Aug 2020 13:45:21 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:51f:3472:bc7:2f4f?
 ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id y65sm9987836pfb.155.2020.08.14.13.45.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 13:45:21 -0700 (PDT)
Subject: Re: [PATCH v4 7/7] nvme: support rdma transport type
To: Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
References: <20200814061815.536540-1-sagi@grimberg.me>
 <20200814061815.536540-8-sagi@grimberg.me>
 <ffcaf9e2-083c-9601-16bd-054c3bd3b94c@redhat.com>
 <af7154de-f2bb-fde6-4c6c-243711f971cb@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1d211ba1-c791-54b8-6811-b159a8a2868b@grimberg.me>
Date: Fri, 14 Aug 2020 13:45:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <af7154de-f2bb-fde6-4c6c-243711f971cb@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_164522_741437_A72CCF3D 
X-CRM114-Status: GOOD (  12.91  )
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
Cc: Keith Busch <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+PiBAQCAtMTI0LDYgKzEzNCwxMSBAQCBfc2V0dXBfbnZtZXQoKSB7Cj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgbW9kcHJvYmUgbnZtZXQtJHtudm1lX3RydHlwZX0KPj4+IMKgwqDCoMKgwqAgZmkK
Pj4+IMKgwqDCoMKgwqAgbW9kcHJvYmUgbnZtZS0ke252bWVfdHJ0eXBlfQo+Pj4gK8KgwqDCoCBp
ZiBbWyAiJHtudm1lX3RydHlwZX0iID09ICJyZG1hIiBdXTsgdGhlbgo+Pj4gK8KgwqDCoMKgwqDC
oMKgIHN0YXJ0X3NvZnRfcmRtYQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJkbWFfaW50ZnM9JChyZG1h
X25ldHdvcmtfaW50ZXJmYWNlcykKPj4+ICvCoMKgwqDCoMKgwqDCoCBkZWZfdHJhZGRyPSQoZ2V0
X2lwdjRfYWRkciAke3JkbWFfaW50ZnNbMF19KQo+IFRoZSBmaXJzdCByZG1hX2ludGZzIGhlcmUg
bWF5YmUgaGF2ZSBET1dOIHN0YXRlLCB3aGljaCBkb2Vzbid0IGhhdmUgYW4gCj4gYWRkclsxXSwg
SSBmb3VuZCBzaW1pbGFyIGNoZWNrIGNvZGUgaGVyZVsyXQo+IFsxXQo+ICMgZWNobyAkcmRtYV9p
bnRmcwo+IHJkbWFfaW50ZnM6ZW5vMQo+IGVubzIKPiBlbm8zCj4gZW5vNAo+IGVubzQ5Cj4gZW5v
NTAKPiAjIFtyb290QGhwZS1kbDM4MGdlbjktMDEgYmxrdGVzdHNdIyBpcCBhIHMKPiAxOiBsbzog
PExPT1BCQUNLLFVQLExPV0VSX1VQPiBtdHUgNjU1MzYgcWRpc2Mgbm9xdWV1ZSBzdGF0ZSBVTktO
T1dOIAo+IGdyb3VwIGRlZmF1bHQgcWxlbiAxMDAwCj4gIMKgwqDCoCBsaW5rL2xvb3BiYWNrIDAw
OjAwOjAwOjAwOjAwOjAwIGJyZCAwMDowMDowMDowMDowMDowMAo+ICDCoMKgwqAgaW5ldCAxMjcu
MC4wLjEvOCBzY29wZSBob3N0IGxvCj4gIMKgwqDCoMKgwqDCoCB2YWxpZF9sZnQgZm9yZXZlciBw
cmVmZXJyZWRfbGZ0IGZvcmV2ZXIKPiAgwqDCoMKgIGluZXQ2IDo6MS8xMjggc2NvcGUgaG9zdAo+
ICDCoMKgwqDCoMKgwqAgdmFsaWRfbGZ0IGZvcmV2ZXIgcHJlZmVycmVkX2xmdCBmb3JldmVyCj4g
MjogZW5vMTogPE5PLUNBUlJJRVIsQlJPQURDQVNULE1VTFRJQ0FTVCxVUD4gbXR1IDE1MDAgcWRp
c2MgbXEgc3RhdGUgCj4gRE9XTiBncm91cCBkZWZhdWx0IHFsZW4gMTAwMAo+ICDCoMKgwqAgbGlu
ay9ldGhlciAzYzphODoyYToyMTo3ZDphNCBicmQgZmY6ZmY6ZmY6ZmY6ZmY6ZmYKPiAzOiBlbm80
OTogPEJST0FEQ0FTVCxNVUxUSUNBU1QsVVAsTE9XRVJfVVA+IG10dSAxNTAwIHFkaXNjIG1xIHN0
YXRlIFVQIAo+IGdyb3VwIGRlZmF1bHQgcWxlbiAxMDAwCj4gIMKgwqDCoCBsaW5rL2V0aGVyIDhj
OmRjOmQ0OjFlOjdhOjc4IGJyZCBmZjpmZjpmZjpmZjpmZjpmZgo+ICDCoMKgwqAgaW5ldCAxMC4x
Ni4yMDMuMjcvMjQgYnJkIDEwLjE2LjIwMy4yNTUgc2NvcGUgZ2xvYmFsIGR5bmFtaWMgCj4gbm9w
cmVmaXhyb3V0ZSBlbm80OQo+ICDCoMKgwqDCoMKgwqAgdmFsaWRfbGZ0IDg0ODE0c2VjIHByZWZl
cnJlZF9sZnQgODQ4MTRzZWMKPiAgwqDCoMKgIGluZXQ2IDI2MjA6NTI6MDoxMGNiOjhlZGM6ZDRm
ZjpmZTFlOjdhNzgvNjQgc2NvcGUgZ2xvYmFsIGR5bmFtaWMgCj4gbm9wcmVmaXhyb3V0ZQo+ICDC
oMKgwqDCoMKgwqAgdmFsaWRfbGZ0IDI1OTE5NzhzZWMgcHJlZmVycmVkX2xmdCA2MDQ3NzhzZWMK
PiAgwqDCoMKgIGluZXQ2IGZlODA6OjhlZGM6ZDRmZjpmZTFlOjdhNzgvNjQgc2NvcGUgbGluayBu
b3ByZWZpeHJvdXRlCj4gIMKgwqDCoMKgwqDCoCB2YWxpZF9sZnQgZm9yZXZlciBwcmVmZXJyZWRf
bGZ0IGZvcmV2ZXIKPiBbMl0KPiAjIGdyZXAgLXJpbiByZG1hX25ldHdvcmtfIHRlc3RzL252bWVv
Zi1tcC8KPiB0ZXN0cy9udm1lb2YtbXAvcmM6OTM6wqDCoMKgIMKgwqDCoCBmb3IgaSBpbiAkKHJk
bWFfbmV0d29ya19pbnRlcmZhY2VzKTsgZG8KPiB0ZXN0cy9udm1lb2YtbXAvcmM6MjM1OsKgwqDC
oCDCoMKgwqAgKSAmJiBmb3IgaSBpbiAkKHJkbWFfbmV0d29ya19pbnRlcmZhY2VzKTsgZG8KClRo
aXMgaXMgYW5ub3lpbmcsIEkgd2lzaCBpdCB3b3VsZCBqdXN0IHdvcmsgb24gdGhlIGxvIGludGVy
ZmFjZSBidXQgaXQKZG9lc24ndCBmb3Igc29tZSByZWFzb24uLi4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0Ckxp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
