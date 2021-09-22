Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CFBC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 11:22:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E319060F11
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 11:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E319060F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xxZzIMNDW2DydqK5+GLDxKdZ83JRNDSiokaMx15lA8U=; b=vDiQXWOGSvYGUl
	8PECP0FWIMD6UwdJH+nJBhrmB4M/Z7vCfGuyXQ41mjR8Z05fXRbXf6zEp/iJCVvnV/yuLUTI9OTbO
	kk1c9e+sR/Tv749VIFXNGiKi2EDOunoA2z+coTbb0vgafXp5X6i0P1/EyOBpGdmJ5mn3HsrdS+I2n
	YkCC2WiW+1IRQeyVAF7rhmCu4P9aU4tjw5wVQVFGnwzUqt+1g4iLtOIPqQrplMZmLemnSDrZPyWSC
	vAno3e12TceEHfKTPr8OYSrely3fB0wyebthuV0xiqkTgP38C2LjbdgaUXM5AT1BpWJCL8KPYyORR
	uI1TsnacVK/wRF9zhb7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mT0Jz-008IZ4-8y; Wed, 22 Sep 2021 11:21:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mT0Jv-008IYR-Ph
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 11:21:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632309705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WZ7VlNdIAbqUtMZ9wcykMecOabpcMeJaTOeYeiZ7dnM=;
 b=MXng+0mgVjRCvWF0bX4MrFlWyp0uSpqMeV2NJE1KhpsBybmThB0uWJILCX3NgEsogozonr
 dAzFYZBKO+6cs0oV9ASy6ZwTt8EWO7EVxxRTnZQuoBI+54NGsrsHazl8CO1QCwCIeoGNPS
 E/jGJaloxVt4gXCni/1MV5PGkF9Ol1k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-HUNmUO7TM6y-k2nCepXhcw-1; Wed, 22 Sep 2021 07:21:42 -0400
X-MC-Unique: HUNmUO7TM6y-k2nCepXhcw-1
Received: by mail-qk1-f197.google.com with SMTP id
 w2-20020a3794020000b02903b54f40b442so10594340qkd.0
 for <linux-nvme@lists.infradead.org>; Wed, 22 Sep 2021 04:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WZ7VlNdIAbqUtMZ9wcykMecOabpcMeJaTOeYeiZ7dnM=;
 b=tmExc9hxbN56KRj92uuahfFSvE/UWG80BISpSzs0oY2qUo+7jMe3gAzgzUipTabIMn
 TqKK2gkO6rxFZICLGYtZx7tqXMJ321E6Q9rdtzCKavLISeC7YuR6CdkKbar9RDXn9RTv
 YfyRxJTXFo5rIhT0M0gylk3se0TiPMoRoZqk+eQwlCkMC3nf6aMT9dMW4GQdbzD3Dhio
 D0djnk7ux0U5qAtiHyQ20KFQfahN+vQArDD/wpgDc988VwKEAXERuKDwy/DTIOgh8Fgk
 0uJ4hX7LQ1aFDwIrKVjdhG3Et7ReqmzFQP4YtWTXPAeMn/nFVLKJIs8+uUNqDEVqAk8Y
 Y+8g==
X-Gm-Message-State: AOAM530pTWa03zRFwC1o1xYeRUbC7eXRY4SGPTE2kgBzRagEF8WCzUdr
 ai0PmaxIAIpBtejLVD2wWf1YhIKuVTTvtxr5Ep1R5C9ApDzW+CzBlkf/GFEQCto6GbuL4mZkDHR
 gakpMXbVg61tDgOufPoXSPWAwQF0ft4Or6J2Oo40eqU8=
X-Received: by 2002:a25:c6cc:: with SMTP id
 k195mr43446082ybf.153.1632309701893; 
 Wed, 22 Sep 2021 04:21:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMDF7NXVZ4SCPXCOyXDo2unJoQFrKHB5GxbMmc+1q7ZxqlyG0P6m/7Ffc9PjcRSJyaog6X6Ng3sKUQDtd6SgE=
X-Received: by 2002:a25:c6cc:: with SMTP id
 k195mr43446061ybf.153.1632309701661; 
 Wed, 22 Sep 2021 04:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs_9AM7YvirAhcztZjhOV0nac_qShHs9qs4B1JAMc3PXdA@mail.gmail.com>
 <a214017f-8287-f281-b296-3424aba0131b@nvidia.com>
In-Reply-To: <a214017f-8287-f281-b296-3424aba0131b@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 22 Sep 2021 19:21:30 +0800
Message-ID: <CAHj4cs-hrSkU-8RS5zqeZpFkZP9zd+7emdOtmMNAm+e4LeVc7w@mail.gmail.com>
Subject: Re: [bug report] nvme removing after probe failed with pci rescan
 after nvme sysfs removal
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_042147_951850_04840ABE 
X-CRM114-Status: GOOD (  18.96  )
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

T24gV2VkLCBTZXAgMjIsIDIwMjEgYXQgMTA6MzIgQU0gQ2hhaXRhbnlhIEt1bGthcm5pCjxjaGFp
dGFueWFrQG52aWRpYS5jb20+IHdyb3RlOgo+Cj4gT24gOS8yMS8yMSA2OjU2IFBNLCBZaSBaaGFu
ZyB3cm90ZToKPiA+IEhlbGxvCj4gPgo+ID4gSSBmb3VuZCB0aGlzIGlzc3VlIGR1cmluZyB0aGUg
bnZtZSByZW1vdmFsIHRlc3QsIEkgZGlkIHNvbWUgZGVidWcgY29kZQo+ID4gZm91bmQgaXQgd2Fz
IGZhaWxlZCBkdXJpbmcgbnZtZSAiQ1NUUyDigJMgQ29udHJvbGxlciBTdGF0dXMiIHJlYWQsIGNv
dWxkCj4gPiBhbnlvbmUgaGVscCBjaGVjayBpZiB0aGlzIGlzIG9uZSBIVyBvciBTVyBpc3N1ZT8K
PiA+Cj4gPgo+Cj4gT25lIGVhc2llc3Qgd2F5IHRvIGlzb2xhdGUgdGhpcyBpc3N1ZSBpcyB0byB0
ZXN0IHRoZSBzdGVwcyBvbiB0aGUgUUVNVQo+IE5WTWUgY3RybCBhbmQgdXBkYXRlIGV2ZXJ5b25l
IGhlcmUuLi4KCkhpIENoYWl0YW55YQpJIHRyaWVkIGFub3RoZXIgTlZNZSBTU0RbMV0sIGFuZCBp
dCB3b3JrcyB3ZWxsLCBzZWVtcyB0aGlzIGlzIHNwZWNpYWwKZm9yICJTYW1zdW5nIFNTRCA5ODMg
RENUIDk2MEdCIi4KQW5kIHRoZSBrZXJuZWwgSSB1c2VkIHdhcyB1cHN0cmVhbSA1LjE1LjAtcmMy
LgoKWzFdCiMgbnZtZSBsaXN0Ck5vZGUgICAgICAgICAgICAgU04gICAgICAgICAgICAgICAgICAg
TW9kZWwKICAgICAgICBOYW1lc3BhY2UgVXNhZ2UgICAgICAgICAgICAgICAgICAgICAgRm9ybWF0
ICAgICAgICAgICBGVyBSZXYKLS0tLS0tLS0tLS0tLS0tLSAtLS0tLS0tLS0tLS0tLS0tLS0tLQot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIC0tLS0tLS0tLQotLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLSAtLS0tLS0tLS0tLS0tLS0tIC0tLS0tLS0tCi9kZXYvbnZtZTJu
MSAgICAgMzA4MEEwOUhUQUZSICAgICAgICAgRGVsbCBFeHByZXNzIEZsYXNoIENENSA5NjBHIFNG
RgogICAgICAgIDEgICAgICAgICA0NjkuMTggIE1CIC8gOTYwLjIwICBHQiAgICA1MTIgICBCICsg
IDAgQiAgIDEuMi4wCgotLSAKQmVzdCBSZWdhcmRzLAogIFlpIFpoYW5nCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxp
c3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
