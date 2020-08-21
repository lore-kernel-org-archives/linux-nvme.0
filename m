Return-Path: <SRS0=kXjr=B7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAED0C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 21:08:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98FF9207DA
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 21:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RLFCG1/a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gGYsjZpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FF9207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=brMqeOFpXADLpwCG3r4RpBWPl2nyNeP9tphTIol4Teo=; b=RLFCG1/aK2n+tpCceUBBoilFx
	t5dzutsKScEZ/O/FNRT6uB1+qI0cVuYayjhWuQPy3iw3LS5qhzkzZ+q58S2Rsz+cSdA0TtmLvA171
	J7RlzHcvyhZQlxAKv805dct/WdHRje31RJ4GlaeD4jvnl4YNeHH7vyHB0QTrmiC27WGk5c1KPuozz
	ZgMftTa6IHZl8qExG0brbpk4ZkYzdWTTquiZndrGKmWjGivuCuHbVzFC4yZ7xu4OaSx172Tn8x21t
	Dd24NL9d7ULa8tmiQ59Sgw4GXGvLilsPdxeCZvCyJW1K2jSdb2aQR62f4Dw+Pksxq81UXYPC7cCxq
	d7GS7JgVA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k9EH3-0004j4-CO; Fri, 21 Aug 2020 21:08:33 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k9EH0-0004id-8u
 for linux-nvme@lists.infradead.org; Fri, 21 Aug 2020 21:08:31 +0000
Received: by mail-pf1-x444.google.com with SMTP id d22so1664720pfn.5
 for <linux-nvme@lists.infradead.org>; Fri, 21 Aug 2020 14:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=fg3iXjgA1NcqEY+45RtvmM6gvhFqhzGDLrM8b7f/Svc=;
 b=gGYsjZpq25F9I0gC938fuU9ryvdJi+IgqdgHHkuXztxgCiDIDzmJ1N2LU8wl7UUQFd
 A7k03f7W8q9Gy6/RysXx+sp+Ow4xAPS4dWhwbhXKfCzfhQsYw6ZdBC25W9ClRIv/nR2W
 MHXxe5wdKhczqROkTz79rQXTWVKPi+Ai6crxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=fg3iXjgA1NcqEY+45RtvmM6gvhFqhzGDLrM8b7f/Svc=;
 b=dxBWeCkI8ztfP466HKYuCRwg3P7JxAg2aLAOfkl2xrmMLVnwVmBECiB2kERL47SW7y
 ybT4gDstZk+82eOt+PkKqwoR5EzC3Yd7S/BUf+70JP5nb1psHMJrgGQXKYRXh8CMbCZW
 0wYGdL9N3hnifAzazAJmZnUnPNBfqpdpmr6BaCmhJ6FkS4cib+LXhbCmXzSxN/uGvlrD
 DUsSllMyK9UccbCZORnbHugsk7RAo74txKIpTrnWvnGzWhf7Hbqg0C+jg6u1ms+oNMIq
 HN06C+jpiXKBaESgiBPkBlldQ8FK3Bnw0QuKR9fLFrV6q5vx82rWcbHSswStqbLBiZZ2
 9X2w==
X-Gm-Message-State: AOAM531MGmvDJIqzAGSFKOpL0MOjistwEUrx9szqBrbhuff5t3gvj3bL
 ZRZJsbGUZaDuhi5ffuh3eqcaGg==
X-Google-Smtp-Source: ABdhPJzBcMvJBJBG7kG1XZ4fXbqRwc/NDZskVsnUfJOPrhpe7DesiJipge/6aW14XRqg11FYrCGDaQ==
X-Received: by 2002:a62:5c84:: with SMTP id q126mr3990320pfb.324.1598044105920; 
 Fri, 21 Aug 2020 14:08:25 -0700 (PDT)
Received: from [10.69.69.102] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id i11sm3092362pjg.50.2020.08.21.14.08.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 14:08:25 -0700 (PDT)
Subject: Re: [PATCH v3 7/9] nvme-rdma: serialize controller teardown sequences
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <20200820053651.197057-8-sagi@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <ee8e30d9-286f-4201-5911-284174f5bc72@broadcom.com>
Date: Fri, 21 Aug 2020 14:08:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200820053651.197057-8-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200821_170830_580382_7AC2FC1B 
X-CRM114-Status: GOOD (  19.31  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gOC8xOS8yMDIwIDEwOjM2IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IEluIHRoZSB0aW1l
b3V0IGhhbmRsZXIgd2UgbWF5IG5lZWQgdG8gY29tcGxldGUgYSByZXF1ZXN0IGJlY2F1c2UgdGhl
Cj4gcmVxdWVzdCB0aGF0IHRpbWVkIG91dCBtYXkgYmUgYW4gSS9PIHRoYXQgaXMgYSBwYXJ0IG9m
IGEgc2VyaWFsIHNlcXVlbmNlCj4gb2YgY29udHJvbGxlciB0ZWFyZG93biBvciBpbml0aWFsaXph
dGlvbi4gSW4gb3JkZXIgdG8gY29tcGxldGUgdGhlCj4gcmVxdWVzdCwgd2UgbmVlZCB0byBmZW5j
ZSBhbnkgb3RoZXIgY29udGV4dCB0aGF0IG1heSBjb21wZXRlIHdpdGggdXMKPiBhbmQgY29tcGxl
dGUgdGhlIHJlcXVlc3QgdGhhdCBpcyB0aW1pbmcgb3V0Lgo+Cj4gSW4gdGhpcyBjYXNlLCB3ZSBj
b3VsZCBoYXZlIGEgcG90ZW50aWFsIGRvdWJsZSBjb21wbGV0aW9uIGluIGNhc2UKPiBhIGhhcmQt
aXJxIG9yIGEgZGlmZmVyZW50IGNvbXBldGluZyBjb250ZXh0IHRyaWdnZXJlZCBlcnJvciByZWNv
dmVyeQo+IGFuZCBpcyBydW5uaW5nIGluZmxpZ2h0IHJlcXVlc3QgY2FuY2VsbGF0aW9uIGNvbmN1
cnJlbnRseSB3aXRoIHRoZQo+IHRpbWVvdXQgaGFuZGxlci4KPgo+IFByb3RlY3QgdXNpbmcgYSBj
dHJsIHRlYXJkb3duX2xvY2sgdG8gc2VyaWFsaXplIGNvbnRleHRzIHRoYXQgbWF5Cj4gY29tcGxl
dGUgYSBjYW5jZWxsZWQgcmVxdWVzdCBkdWUgdG8gZXJyb3IgcmVjb3Zlcnkgb3IgYSByZXNldC4K
Pgo+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KPiBTaWduZWQt
b2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPgo+IC0tLQo+ICAgZHJpdmVy
cy9udm1lL2hvc3QvcmRtYS5jIHwgNiArKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2Vy
dGlvbnMoKykKPgo+CgpSZXZpZXdlZC1ieTrCoCBKYW1lcyBTbWFydCA8amFtZXMuc21hcnRAYnJv
YWRjb20uY29tPgoKeWVzLCBpdCBsb29rcyBiZXR0ZXIuIHRoZSByZXdvcmtlZCBlaCBoYW5kbGVy
IGRlZmluaXRlbHkgaGVscHMuCgotLSBqYW1lcwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW52bWUK
