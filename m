Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D943C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 13:18:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A936128E
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 13:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D6A936128E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V3u1E5X37JQS0y566qbaM966axNMnMamwPi+2/ZOHH8=; b=K7/acaPNdXuZht54xsGlK7MTn0
	YsOvxJmGyvQ3TsiLg71VlgJ8oD7UlKbTqkgPzMeg8/bvTa6C1BkbgGNRt+kNavKDRL4KhKp2G74k/
	1MPjfzpyPXFKKMZeuPFfX6tcBWyQ75fTi3G5Uds2ZqXfLViySeCj/RJ61WvSWka2fiHxSkcLl7PbB
	fI/jJ4xmjqVlLiYiwy+3N1nlGYmR4UjvT8m4UOojewRPoHLcjzmtar1QbhB1zyLR1JcScXYS1c6Iy
	qe8XnujWcejAowEse9D5DVboCHYDUX79zAhkThu0qV0CCi1Ru3YUHzVIWazHlErTsGCs+/6hnrhJF
	yMHfo2uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVZSh-00B7kC-Gs; Wed, 29 Sep 2021 13:17:27 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVZSe-00B7j6-C4
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 13:17:25 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 g19-20020a1c9d13000000b003075062d4daso1763669wme.0
 for <linux-nvme@lists.infradead.org>; Wed, 29 Sep 2021 06:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8hoLnXsbLHGdgKEViSmvYGe26wNzlc2codN/337SmUM=;
 b=wKoT1PU6L7Ub86FSg2va7Yy5obAgbQab07SizvjLcAQCntLV2AejicliHl1lG4yAsx
 MHeJYdIjR9BBE42mSTC7skXQ5bc2IWo/ix3+MFYpf1dnl1jc/o3FsI6trXtwhmx5qA45
 CDKVhEB83xVxGKqFYDW2ytFwG9Qm3ZYHTE4xM8RENCNm2B8+teJy0IQlf723PzChGBB6
 vkDbg4nvsPDAUkYMljZoW/vIc0fX5amGX6L/IoX/BvyavdJ+MzPWtfJlb5AjQivwdTGv
 aScm60LPT+gHly3aHR+1FVKIpaUHmqyOrHQmkDtCTtAr3kODocFovyI3UpdMw41YWjuA
 dm0Q==
X-Gm-Message-State: AOAM532fM7U7ks8v9U0bFmgiowecDo/pPF0tF3rmNduRJmmeeDnjKXPs
 kDOo3w5w4gMlWo+uStLXqYU=
X-Google-Smtp-Source: ABdhPJxd6EoK70P3vJ4/5TAg9Nj1w//tBTSw5fWnx9f+8xeG3325stf5LJedcmBVWD1BthjBxXQ2Aw==
X-Received: by 2002:a7b:c30c:: with SMTP id k12mr2729826wmj.38.1632921441772; 
 Wed, 29 Sep 2021 06:17:21 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id m29sm2316696wrb.89.2021.09.29.06.17.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Sep 2021 06:17:21 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] nvme sq associations
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Andrey Nikitin <nikitina@amazon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "davebuch@amazon.com" <davebuch@amazon.com>
References: <20210924210809.14536-1-nikitina@amazon.com>
 <5f65579c-0eb4-cf23-4237-e23f52ccd63f@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bfdae9a1-2250-d75f-8dab-7137a3211984@grimberg.me>
Date: Wed, 29 Sep 2021 16:17:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5f65579c-0eb4-cf23-4237-e23f52ccd63f@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_061724_441223_F048760B 
X-CRM114-Status: GOOD (  12.30  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+IFRoZSBOVk1lIHNwZWNpZmljYXRpb24gYWxsb3dzIGZvciBuYW1lc3BhY2VzIHdpdGggZGlm
ZmVyZW50IHBlcmZvcm1hbmNlCj4+IGNoYXJhY3RlcmlzdGljcywgYXMgd2VsbCBhcyBhbGxvd2lu
ZyBJT3Mgc3VibWlzc2lvbnMgdG8gYW55IG5hbWVzcGFjZSB2aWEKPj4gYW55IG5vbi1lbXB0eSBz
dWJtaXNzaW9uIHF1ZXVlLiBIb3dldmVyLCBzaGFyaW5nIHF1ZXVlIHJlc291cmNlcyBiZXR3ZWVu
Cj4+IG5hbWVzcGFjZXMgd2l0aCBkaWZmZXJlbnQgcGVyZm9ybWFuY2UgY2hhcmFjdGVyaXN0aWNz
IGNhbiBjYXVzZSB1bmRlc2lyZWQKPj4gYmVoYXZpb3IgKGUuZy4gaGVhZC1vZi1saW5lLWJsb2Nr
aW5nIGZvciBJT3MgdGhhdCB0YXJnZXQgYSBoaWdoLXBlcmZvcm1hbmNlCj4+IG5hbWVzcGFjZSBi
ZWhpbmQgSU9zIHRoYXQgdGFyZ2V0IGEgbG93IHBlcmZvcm1hbmNlIG5hbWVzcGFjZSB2aWEgdGhl
IHNhbWUKPj4gcXVldWUpLiBJbiBhZGRpdGlvbiwgdGhlIGxhY2sgb2YgaGFyZHdhcmUgcXVldWUg
aXNvbGF0aW9uIHN1cHBvcnQgY2FuIGNhdXNlCj4+IOKAnG5vaXN5IG5laWdoYm9y4oCdIHR5cGUg
cHJvYmxlbXMgZm9yIGFwcGxpY2F0aW9ucyBpc3N1aW5nIElPcyB0byBkaWZmZXJlbnQKPj4gbmFt
ZXNwYWNlcyBvZiB0aGUgc2FtZSBjb250cm9sbGVyLiBUaGlzIHByb2JsZW0gbWF5IGJlIGVzcGVj
aWFsbHkgcHJvbm91bmNlZAo+PiBpbiBtdWx0aS10ZW5hbnQgZW52aXJvbm1lbnRzIHN1Y2ggYXMg
dGhlIG9uZXMgcHJvdmlkZWQgYnkgY2xvdWQgc2VydmljZXMuCj4+Cj4gCj4gRm9yIFJGQyBzdWNo
IGFzIHRoaXMgeW91IG5lZWQgdG8gcHJvdmlkZSBhIHF1YW50aXRhdGl2ZSBkYXRhIGZvcgo+IGRp
ZmZlcmVudCB1c2VjYXNlcyBmb3IgdGFyZ2V0ZWQgKGUuZy4gbm9pc3kgbmVpZ2hib3IgcHJvYmxl
bSkgYW5kIG5vbgo+IHRhcmdldGVkIHdvcmtsb2FkcyAoZS5nLiBzdGFuZGFyZCBmaW8gcGVyZikg
YW5kIGFsc28gdGhlIHBlcmZvcm1hbmNlCj4gaW1wYWN0IG9mIHRoaXMgY2hhbmdlIG9uIHRoZSB0
aGUgaG90IHBhdGguCgpBZ3JlZWQuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1udm1lCg==
