Return-Path: <SRS0=li1X=BB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3F2C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2020 22:57:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CAA920825
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2020 22:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OezL+jN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CAA920825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UO0cYm0uyNmLXGLIYdBE/CBNJfkH8RBCY9BbR1N2LMY=; b=OezL+jN78e20GGHKWKthkw0Pb
	JcoYBHLWdNmVnAOLko4G46sjZ9J/YRB6/aEp2WD3P2GoHSgxacU/n7ENMn79ZjzCiZNSh0W86NH+1
	7lJdeMr0KpHEM9caQMMsDGeLPWZ2qp0yud9w82Q/dzKa5gSHTzLN4NTHxmg8v0kxXY+S7RNELbADM
	EF6ZCezNlqKfQRVpaNAuDli02Q3s0fxerwwKi75M3HZ6zalJb0G7yY6mEWZW8SVzJrkDBfdePx9Qs
	eKAbqiSLpNoKzBihEDF9MT07g8/gYJS+wXNkjldLalumxe9eqFvgM8VFA5ZFCl5sJ+9Qugq5ALt5+
	XYD7jpVFg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jyNg6-00019V-II; Wed, 22 Jul 2020 22:57:34 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyNg3-000197-MM
 for linux-nvme@lists.infradead.org; Wed, 22 Jul 2020 22:57:32 +0000
Received: by mail-wr1-f65.google.com with SMTP id q5so3391292wru.6
 for <linux-nvme@lists.infradead.org>; Wed, 22 Jul 2020 15:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=azQc7BoTBU22vHJkPQgm5pNc6XaEySgQNMHhiU9fVXw=;
 b=rS4CTblsR9Yy/Ru3tFjyUTHuBKJ08+nVfywzRBYCfZX/wijElu9aN6Yh/2IYdIKa2L
 z5cBEMHislN3O6ksxe5x/lsRUPvOHNnQwr0CTQHeOuP61NHqZgIze2XtbifPeizzJ6kL
 238acyLglanT3a/PZSdrUCanUQBjjAl87+FEKZazSFVU63gh4IBLwwD6mOdDivnaJF4e
 vnOKb2UAwXVp5ZFS5O3bNpXJikmQr2yntWLGI9YLVOkB9hLJuejS8158QLSQSNLb5YES
 JItDzAN0gw7q2mvjRlPON0S1tpMC7qtfdhilbZnnq1bfhaJ/mGN7m5TfcuZOabnnWf5A
 0KWQ==
X-Gm-Message-State: AOAM532SQ05i/a7tQVIAULySrDxc3vn8vE6wveS4AP1XjJh12bMJXQ7O
 MQjpsFAOs7QimW4Ra2ljPVg=
X-Google-Smtp-Source: ABdhPJxDppN59rT91PyLmMVA+IdbXdubfx/B42o/3xokiIP8CLnHnYTJWeT32QrdwWVCkCgOCCgMag==
X-Received: by 2002:adf:f007:: with SMTP id j7mr1323703wro.195.1595458650485; 
 Wed, 22 Jul 2020 15:57:30 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:45ba:2951:1398:d100?
 ([2601:647:4802:9070:45ba:2951:1398:d100])
 by smtp.gmail.com with ESMTPSA id d14sm1505835wre.44.2020.07.22.15.57.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 15:57:29 -0700 (PDT)
Subject: Re: [PATCH v7] nvme-fabrics: reject I/O to offline device
To: Christoph Hellwig <hch@lst.de>
References: <168ed5d66eae49ac8b445478b1bb362d@kioxia.com>
 <ca82af03-0cf7-bb71-cf55-caf88c278dfa@broadcom.com>
 <fee0ecca-3d31-a04f-af7c-7a3aada9d6fe@grimberg.me>
 <20200714110435.GF16178@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <52eec097-606d-1e2c-edc3-81b60807ad5c@grimberg.me>
Date: Wed, 22 Jul 2020 15:57:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714110435.GF16178@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200722_185731_766472_7CA66036 
X-CRM114-Status: GOOD (  13.10  )
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
Cc: James Smart <james.smart@broadcom.com>, "Ewan D. Milne" <emilne@redhat.com>,
 Victor Gladkov <Victor.Gladkov@kioxia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+PiBMb29rcyBnb29kIHRvIG1lLsKgIE9ubHkgbml0IEkgc2VlIGlzIC0gd2h5IGFyZSB3ZSBj
aGVja2luZyBjdHJsLT5vcHRzIGluCj4+PiB0aGUgeHh4X2ZhaWxmYXN0X3dvcmsoKSByb3V0aW5l
cyA/Cj4+Cj4+IFdoaWNoIGJyaW5ncyBtZSB0byB0aGUgcXVlc3Rpb24sIGlzIHRoZXJlIGFueSBk
ZXNpcmUgdG8gaGF2ZSB0aGlzCj4+IGJlaGF2aW9yIGluIHBjaSBhcyB3ZWxsPwo+IAo+IFdoZXJl
IGlzIHRoaXMgZGlzY3Vzc2lvbiBjb21pbmcgZnJvbT8gIEluIGdlbmVyYWx5IGlmIHNvbWV0aGlu
ZyBpcyBub3QKPiB0cmFuc3BvcnQgc3BlY2lmaWMgSSB0aGluayB3ZSBzaG91bGQgc3VwcG9ydCBp
dCBmb3IgYWxsIHRyYW5zcG9ydHMuCgpBZ3JlZWQuCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1l
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1udm1lCg==
