Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6839C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 07:22:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0897F613E8
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 07:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0897F613E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8Fuo/I0FxoHprBoaX4ixN2B46CwTTCtx2VkdM3qZB28=; b=Hz9BCLZVXzcmZ+RFrtV+nIBkf
	nD28NKq0jo2KhuG8BGbTdcgpD6JCAN4cq+soyw2Y+06nuLk8ySAG73SLwAVH3x0amdxjt3E6FUJlO
	IQZM+1Vu/Bu0PxnxeV2BMpTWA3dImGCsyYKJfR6yaXeDIOhn34vAjKuIoEHv8VzELucMh3GV8OU+R
	zueNwEShrF87dpUSgputNX1YA1s40qZcNcvVV2VSP4NDElYuv2SBNqyd4Gange4uxVzzSI7Wbw3wO
	BDJziKIXB8cRkl+3u22xVlnI/TK9NkdiZdUE9lR+lOigWUOMDdOfNU1wYpylDeyBCee5Tvu6mRns9
	DQGVB2BBg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbeWX-0032xo-DA; Wed, 28 Apr 2021 07:22:17 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbeWU-0032xc-Ad
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 07:22:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-ID:Content-Description;
 bh=uyUv8KCIqiWEn/ycVVSuXUXWBjwtvxSoWo1VwEkGZHI=; b=nJiFYCRzcqQewm9aauPOlsbSE9
 E3yWnYFPAcyNWTQP45zPc8C9UjX15oRTwrMEftWKfRwQh9X8vTJf/y0EDcoDdI0C1/0GZIYYl+9mG
 TA6oRxmyn2pMDDB+Bc3UR1UK7dbNks8Ih8P3GFNVqZTh58eSO5ujnICfZGwKQNNbxNWWgi8ry5Xzn
 pLfkzi7lM5feFVQp2rp5sc66ypXj2ObyGxQnFWBHUU88eATK4wlp6BLIostZxzlZMKp4NYzGIjdiq
 v+oOfC6kQC89UxDHdAQjAtr7r7q9msYXDT9aVEVgRpXjUbfLRYVZXeUGE6rdoX1DSbt4iJuz9qyLY
 XTvIMI0A==;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbeWR-00HFQS-RO
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 07:22:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619594530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uyUv8KCIqiWEn/ycVVSuXUXWBjwtvxSoWo1VwEkGZHI=;
 b=UO8hxD8nDepeA+JOr9VaCAFxBx08V6Wfzc0WBOtmeJ6l6P+U6eYtVIPAwg5ELhrUI1VSig
 R/u77XHjdFjcYAPUKF2xActxtURJay6hSy+XFhZds3yL5cZy/YNYwF9Q2BfRgc3h8upCqT
 89H2mkYMDwwt1WRKfKaqPnj12i9xVlk=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-dE83I4UPOrSrlu93TF7n5A-1; Wed, 28 Apr 2021 03:22:08 -0400
X-MC-Unique: dE83I4UPOrSrlu93TF7n5A-1
Received: by mail-io1-f70.google.com with SMTP id
 f14-20020a056602038eb02903efc2bddb33so23928033iov.14
 for <linux-nvme@lists.infradead.org>; Wed, 28 Apr 2021 00:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uyUv8KCIqiWEn/ycVVSuXUXWBjwtvxSoWo1VwEkGZHI=;
 b=P2C8vG2246WhPfPeur4X9XJuKJldTiTErOMvxHghqf97jyKexmoIuTwijxuxRw+D5c
 UgiPZeMV2fyHis2qRAqn4eOuHpPs6FaLSYhVdH/5i0FD7w8xYRCe6q86bbsdftifAIdf
 anBtS+iq8mwieMgmc3ry+O9ADxFMh7tujsEtUjLH32so7coWeQBJdy8X4HPgJFoeX7Mu
 rWTHQUv5Izz4H1KT6WdBYF0UMeHDvZ3q3CCk9m0K7TJnc3ZqLBeia8jOd7OXZ5FhDgSG
 ImmI6t09hP3G8JTymT2urP/1u3GB355n6K9bgnsvkDJ9s0Zc95A+7k6jMlc63D2esxeM
 ZVig==
X-Gm-Message-State: AOAM533Z7F54j0TytrniiYN9weOqkfDmdUe3HNUMo8eZV/51ww7gecC8
 2dIksTSdJefh7nHCC32NM+dgLjzYqRDXFh60Zx0h5Eemc7VJXcNXPOrI/ZbpKWUBUUwl/fUUbRE
 OIFdgVAPKku/wGca2yiswek4QK/3WAw5L3Exs5C6qkHE=
X-Received: by 2002:a92:da0f:: with SMTP id z15mr20448581ilm.226.1619594527680; 
 Wed, 28 Apr 2021 00:22:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVECfNsqiX08l45sda2tYySi7bJlF6Ina+TOKm1xfR4BzNcwcJW3kuFUcefD/gtxLDDj1BXNaVcnAkPGW7iUo=
X-Received: by 2002:a92:da0f:: with SMTP id z15mr20448562ilm.226.1619594527441; 
 Wed, 28 Apr 2021 00:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210427085246.13728-1-mwilck@suse.com>
 <0ff2dbc0-0182-f54d-b750-084feac53601@suse.de>
 <20210427162521.GA26528@lst.de> <f82b7f7c-ef12-27bb-1349-d23ea22e50a9@suse.de>
 <3a0b10f45ac75df3f744dd04ac874021488f42b1.camel@suse.com>
 <CAFL455=m_4tLZwbh1qRGPgE8ufBfKuq84zKkZmCntX56A17kog@mail.gmail.com>
 <e11706e498a583b764ff9e9b1b7de409f996ad07.camel@suse.com>
In-Reply-To: <e11706e498a583b764ff9e9b1b7de409f996ad07.camel@suse.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Wed, 28 Apr 2021 09:21:56 +0200
Message-ID: <CAFL455=fqaaymf8PrmT4W_qkvcH0roymwFeE2g-ihAg4tcrKCw@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20210428_002211_982618_6DF44C9D 
X-CRM114-Status: GOOD (  11.48  )
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

c3QgMjguIDQuIDIwMjEgdiA5OjA2IG9kZXPDrWxhdGVsIE1hcnRpbiBXaWxjayA8bXdpbGNrQHN1
c2UuY29tPiBuYXBzYWw6Cj4KPiBZZXMsIHRoYXQncyB3aGF0IEkgdGhpbmsgaGFzIGhhcHBlbmVk
LiB0aW1lcl9zZXR1cCgpIGRvZXNuJ3QgY2xlYXIgYW55Cj4gcG9pbnRlcnMgaW4gdGhlIGxpc3Qg
b2YgcGVuZGluZyB0aW1lcnMgcG9pbnRpbmcgdG8gdGhpcyBlbnRyeS4gSWYgdGhlCj4gbmV3bHkt
aW5pdGlhbGl6ZWQgdGltZXIgaXMgdGhlbiBhZGRlZCB3aXRoIG1vZF90aW1lcigpLCBpdCBiZWNv
bWVzCj4gbGlua2VkIGluIGEgc2Vjb25kIHRpbWVyIGxpc3QuIFdoZW4gdGhlIGZpcnN0IG9uZSBl
eHBpcmVzLCB0aGUgdGltZXIKPiB3aWxsIGJlIGRldGFjaGVkLCBidXQgb25seSBmcm9tIG9uZSBv
ZiB0aGUgbGlzdHMgaXQncyBwZW5kaW5nIGluLiBJbiBhCj4gc2NlbmFyaW8gbGlrZSB0aGUgb25l
IHdlIGZhY2VkLCB0aGlzIGNvdWxkIGFjdHVhbGx5IGhhcHBlbiBtdWx0aXBsZQo+IHRpbWVzLiBJ
ZiB0aGUgZGV0YWNoZWQgdGltZXIgcmVtYWlucyBsaW5rZWQgaW50byBhIHRpbWVyIGxpc3QsIG9u
Y2UKPiB0aGF0IGxpc3QgaXMgdHJhdmVyc2VkLCB0aGUga2VybmVsIGRlcmVmZXJlbmNlcyBhIHBv
aW50ZXIgd2l0aCB2YWx1ZQo+IExJU1RfUE9JU09OMiwgYW5kIGNyYXNoZXMuCgpZZXMgSSB0aGlu
ayBpdCBtYWtlcyBzZW5zZS4KdGltZXJfc2V0dXAoKSBtb2RpZmllcyB0aGUgdGltZXIncyBiYXNl
IGluIHRoZSAiZmxhZ3MiIGZpZWxkLCB0aGVuIG1vZF90aW1lcigpCmNvdWxkIGFkZCB0aGUgdGlt
ZXIgdG8gdGhlIHdyb25nIGJhc2Ugc3RydWN0dXJlLgoKTWF1cml6aW8KCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlz
dApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
