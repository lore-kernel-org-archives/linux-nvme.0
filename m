Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DABFC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 06:39:46 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6485161419
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 06:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6485161419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ud3GePFttcwUTT7LNwuZEJtyWJRJLW3Cf9QYnT4MHlc=; b=hNkZjF88LB2I6MfpoXKY1IulH
	0v0kle3uwGI4X+Easdt98LY++GxuGHYCalHSv/Ihanmmujfe/tSjyzDmlrlFSJcsjXZA3yjA0Wpyy
	xJ1RXWK6UJqxKp9FXq/lA6cjJX2EtWM7D23RA7VigLuq4A3EUCIvK8ch5GkIRk9FDL51vYrFUxt8L
	67hGV3mrDJ8umuw36iYr53H6zngBOGKWF0wHlkq6+zNTmw2sxOYfV+CyrJQOD8s5ndgLkT15jSpgL
	rkvaoG+/B6Lo25WBSFC5fP5kPFu4h/cmh7M5nvNP3VwsaeYifTFe43Z0fiR2186OyRHNmQjSrGgeg
	+FKxJXByA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbdrE-002wNP-Tp; Wed, 28 Apr 2021 06:39:37 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbdrA-002wLs-Os
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 06:39:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-ID:Content-Description;
 bh=Mw29yMzqVHFx3JmMEZ3wEvw64Bi3lRDgayDcOCxCtDA=; b=2dUuqpZuAzv78QElp0eV3HQngV
 OEnwFAAeRzI02ANdRf6LhT+Z6YuZ+M+tEbK7uluXrk5Kh8pmUYRX/y1RX9vJYasUVhBKs7L1lvSH3
 Nidf3Q3UPPWI0GH3ZWwyqAWloXTvxgAi0lBNWCAvR8WFNmpArQGrAexAtoXWQSOZwUb59kwLUjO9R
 6v3vzpOa2Zx63mtUyYwE9kzKTO8/D0sr+tI0rkAz9FM6aDaj2csLF4oUR2EhbF7Yh43iNOMbvlfQr
 mbujaHWGNjJDoNRCf8rJmwRt3sbGQx8aqJNL2o2/D9m7ZbjPs32Bi0UpEGXwQ1neK+2ijpUmkkyq2
 fM/Mcu/Q==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbdr8-00HDcE-AA
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 06:39:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619591967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mw29yMzqVHFx3JmMEZ3wEvw64Bi3lRDgayDcOCxCtDA=;
 b=WIqjtDjBPdTd4oy2ydNLA/FzsJy1ZStRwVAlL13HKAOY39b+WkJ7/FBPiU84PTW1yCcJN2
 +6sDVPy1fpdWUnR/lQqyPGgevyjTqd9JJHyN1iHLsChJShPO8sVOWqmVf8DKWX0ZZV5fKd
 TMlviy2EC/zcpPilELmvZe5ExX+8w7c=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-LCfUF-SNMhC79v-8w_x35w-1; Wed, 28 Apr 2021 02:39:24 -0400
X-MC-Unique: LCfUF-SNMhC79v-8w_x35w-1
Received: by mail-io1-f69.google.com with SMTP id
 w2-20020a5ed6020000b02903ee20b1d066so25903137iom.19
 for <linux-nvme@lists.infradead.org>; Tue, 27 Apr 2021 23:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Mw29yMzqVHFx3JmMEZ3wEvw64Bi3lRDgayDcOCxCtDA=;
 b=GVzCvZsGhqw6CGB8PqeRJG4dC/zcZiSiPg4RP5avHiFnMoP0BV6Q99qhLLFs0ewisR
 VfLJiMxc6pwM0Pr1LfH42KDZuSsnshJ6vSppiKX3OwX7Z00VKdF/veHOcWWTZ6Y9/8HS
 Jk3WwMQ805PG2CkCG/FPV/ENk1Xs1hjcuUjrto/U8DDL2B8/qN5wuISqj9Czaahxybsp
 jT038kmgWGrb7Azb4jruNLTri/SD0nw+D6m4L/cEd34Pj2Di631P2q85fjqw6l4qOjVa
 aoDt4rXgTBJgPMkg4/XmPepbxh7fgY/Z7n+5hSl++vqcUNgz1N9TUOv2wXaUSPvmv+x6
 SR2g==
X-Gm-Message-State: AOAM533YgiF/vlGk/4Qw0HTFBzKHU/IOWZOSHvKZr3pGDSNind7ySwpe
 yyCTEUOnGKcTdXs3XlTUtNCt+Qahkwprt1TgLlKh7WAVdQ9cgzfCIzkUSYbJab8GqqHDzWWhVd5
 rCnC8T8QmxDxZHFzh1DOQTDeOODSVXfpfs7A0h0u4vx0=
X-Received: by 2002:a92:da0f:: with SMTP id z15mr20353938ilm.226.1619591963404; 
 Tue, 27 Apr 2021 23:39:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTwGQQ3WEX3wX/F87PZ0G5dHvrgWDVMrJBcQZakolNKVRibOUCrbtBRYoImGE7DVkyhPITlkNklkcfy97s/cg=
X-Received: by 2002:a92:da0f:: with SMTP id z15mr20353925ilm.226.1619591963154; 
 Tue, 27 Apr 2021 23:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210427085246.13728-1-mwilck@suse.com>
 <0ff2dbc0-0182-f54d-b750-084feac53601@suse.de>
 <20210427162521.GA26528@lst.de> <f82b7f7c-ef12-27bb-1349-d23ea22e50a9@suse.de>
 <3a0b10f45ac75df3f744dd04ac874021488f42b1.camel@suse.com>
In-Reply-To: <3a0b10f45ac75df3f744dd04ac874021488f42b1.camel@suse.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Wed, 28 Apr 2021 08:39:11 +0200
Message-ID: <CAFL455=m_4tLZwbh1qRGPgE8ufBfKuq84zKkZmCntX56A17kog@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: rdma/tcp: fix list corruption with anatt timer
To: Martin Wilck <mwilck@suse.com>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, 
 Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
 Daniel Wagner <dwagner@suse.de>, 
 linux-nvme@lists.infradead.org, stable@vger.kernel.org
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_233930_471528_BD457441 
X-CRM114-Status: UNSURE (   9.57  )
X-CRM114-Notice: Please train this message.
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

w7p0IDI3LiA0LiAyMDIxIHYgMjI6MDIgb2Rlc8OtbGF0ZWwgTWFydGluIFdpbGNrIDxtd2lsY2tA
c3VzZS5jb20+IG5hcHNhbDoKPiBUaGUgY29kZSBkb2Vzbid0IHVzZSBhZGRfdGltZXIoKSwgb25s
eSBtb2RfdGltZXIoKSBhbmQKPiBkZWxfdGltZXJfc3luYygpLiBBbmQgd2UgZGlkbid0IG9ic2Vy
dmUgYSBjcmFzaCB1cG9uIGFkZF90aW1lcigpLiBXaGF0Cj4gd2Ugb2JzZXJ2ZWQgd2FzIHRoYXQg
YSB0aW1lciBoYWQgYmVlbiBlbnF1ZXVlZCBtdWx0aXBsZSB0aW1lcywgYW5kIHRoZQo+IGtlcm5l
bCBjcmFzaGVzIGluIGV4cGlyZV90aW1lcnMoKS0+ZGV0YWNoX3RpbWVyKCksIHdoZW4gaXQgZW5j
b3VudGVycwo+IGFuIGFscmVhZHkgZGV0YWNoZWQgZW50cnkgaW4gdGhlIHRpbWVyIGxpc3QuCgpI
b3cgY2FuIGEgdGltZXIgZW5kIHVwIGVucXVldWVkIG11bHRpcGxlIHRpbWVzPwpJdCdzIHNhZmUg
dG8gY2FsbCBtb2RfdGltZXIoKSBhZ2FpbnN0IGJvdGggYW4gYWN0aXZlIG9yIGFuIGluYWN0aXZl
IHRpbWVyCmFuZCBtb2RfdGltZXIoKSBpcyB0aHJlYWQtc2FmZSBhbHNvLgoKSU1PIHRoZSBwcm9i
bGVtIGlzIGR1ZSB0byB0aGUgZmFjdCB0aGF0IHRpbWVyX3NldHVwKCkgY291bGQgZW5kIHVwCmJl
aW5nIGNhbGxlZCBhZ2FpbnN0CmFuIGFjdGl2ZSwgcGVuZGluZyB0aW1lci4KdGltZXJfc2V0dXAo
KSBkb2Vzbid0IHRha2UgYW55IGxvY2sgYW5kIG1vZGlmaWVzIHRoZSBwcHJldiBwb2ludGVyIGFu
ZAp0aGUgdGltZXIncyBmbGFncwoKTWF1cml6aW8KCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1l
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1udm1lCg==
