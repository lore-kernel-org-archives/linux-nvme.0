Return-Path: <SRS0=9ikG=CL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3608AC433E6
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 00:02:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96FC206EF
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 00:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="13SYgcAQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SIPn8cav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96FC206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rgGmprIt63i14ECiedcbLZOqaP25cExFt0Wc+qXLX2c=; b=13SYgcAQPISMwd672Abnm6k8p
	tOyapfa4K8qqPz+8B6h8X87jihpslyELNJp1shB7tRBJpoNZmcTm2U0P8pYCXiHBKjynN8+sPsuP0
	TKDBP9b6mwR3zAe60ZxgfjJwNcJOD1nYaDPh8IpNgqbpfwRL7doAIi7n61axvaYzbJVrzg66RirtJ
	zIOoNWOGeVIvkmU2xgWjXJthZZXkuSWY5YwRiJgc7ngbOE25omboJDXp0mEtkcU7jng+Y/89wLRYu
	3/wzMCXGGrI1s6wrqYq1ZSACDg6oB910g+bn/d8qL4IcOuhjvCr8O+DH5dktKg+qelw9ocH1ZIYsN
	dv7GV1wZg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDGE1-0008W1-7I; Wed, 02 Sep 2020 00:02:05 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDGDw-0008VE-Ax
 for linux-nvme@lists.infradead.org; Wed, 02 Sep 2020 00:02:03 +0000
Received: by mail-pg1-x542.google.com with SMTP id g29so1591411pgl.2
 for <linux-nvme@lists.infradead.org>; Tue, 01 Sep 2020 17:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=SUd5OBWmb4twpsDXcovuk1+7mDMags4RX62eeDKc/j4=;
 b=SIPn8cavJLZmGaqVbpSzNC79gtGkxz7L8SNrd1P28xvoptEqQGw4rDZs4+azyE0Vn3
 lH+/QkjXfGcA8S0+Iz0Z9ETZXh+hl+IVW1jgJP4pjOV9z4dgb+dFHGbDDcqURQ5niZtn
 ag1p/zowYHvS4DO2NVk0LHefLkYprvIdjbYTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=SUd5OBWmb4twpsDXcovuk1+7mDMags4RX62eeDKc/j4=;
 b=peHMUpKlP/YHykQUiH9Sw2G8Cx/fKD1RwXzKZu4gwpB/Itcm02x5/NawG3k24Xs208
 MHmX0Q6RXYJHDSZSXWkKt+j+k9koBHqqhnaDOfqbUo7PPcr6WrPG11OKl7Npr1idMVBV
 f0hhwT9js2DrMnxNDKTWiwnXrL91/U9sTgek4du+v7TlLIQ5ZmRR09RFrwwI8JWLZ993
 s6G9FLFIFeVEd0U/LNFVKsP/h93PvHNVn4wwLprx4W6ZHh543+eHTRAJFh16+0y6JwJY
 xyGfJU23ERDxr7kMMvenoUsMbzp7ptStFP1WNRLblBYXe7eNt3lYg/3BQy1J+0g2x8MC
 HrJg==
X-Gm-Message-State: AOAM533IqHW6vymaC+yq9W8IiKdyfmwL+k96YHbsJ+JVyBU+zo7hkc2k
 YKczZ0HYVxcqeOvkgrJjV5yqnw==
X-Google-Smtp-Source: ABdhPJzPaKvhg/U0wjf0jcoHxmLVETNP2MUiSLNBY70mczbJJMMlqJTGY+Qvfmv/G9cyo+zxoeOxCw==
X-Received: by 2002:a63:541e:: with SMTP id i30mr3684911pgb.47.1599004913647; 
 Tue, 01 Sep 2020 17:01:53 -0700 (PDT)
Received: from [10.230.128.89] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id g32sm3152900pgl.89.2020.09.01.17.01.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 17:01:52 -0700 (PDT)
Subject: Re: [PATCH] nvme: Revert: Fix controller creation races with teardown
 flow
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20200828190150.34455-1-james.smart@broadcom.com>
 <0867c437-1521-c0c9-d7fa-6a615d88105a@grimberg.me>
 <a73cd06b-b319-d55f-1465-4263e08900ae@broadcom.com>
 <741ec2a7-7a38-9432-33fb-58227bf1f1f1@grimberg.me>
 <7f43e9db-974a-5e98-76a6-ed2f3bd0dc92@broadcom.com>
 <4aaad97e-03b5-5c22-af8e-ae7624e78991@grimberg.me>
 <f7d0c08f-2a34-fffa-7962-d0641bc579fd@broadcom.com>
 <7e78b2e6-d103-23a1-a9ab-d12336a9c089@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <e1df5a4a-702e-eea0-d52d-ec5f0de1422d@broadcom.com>
Date: Tue, 1 Sep 2020 17:01:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.0
MIME-Version: 1.0
In-Reply-To: <7e78b2e6-d103-23a1-a9ab-d12336a9c089@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200901_200200_955107_147ADE36 
X-CRM114-Status: GOOD (  15.06  )
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
Cc: Keith Busch <kbusch@kernel.org>, Israel Rukshin <israelr@mellanox.com>,
 Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org,
 Max Gurtovoy <maxg@mellanox.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA5LzEvMjAyMCAzOjAxIFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Cj4gQnV0IHlvdSBh
bHNvIHJldHVybiBiYWNrICZjdHJsLT5jdHJsLCB0aGF0IGlzIGFub3RoZXIgZGVyZWZlcmVuY2Us
IGFuZAo+IHdoYXQgd2lsbCBtYWtlIGN0cmwgdG8gYmUgYW4gRVJSX1BUUj8KPgo+IEFueXdheSwg
d2Ugc2hvdWxkIHByb2JhYmx5IGNvbWUgdXAgd2l0aCBzb21ldGhpbmcgbW9yZSByb2J1c3QuLi4K
Cm9rCgo+Cj4+IG5vdCBzdXJlIHdoYXQgeW91IGFyZSBhc2tpbmcuwqDCoCBpZiBpdCdzIGhvdyBs
b25nIHRvIGZhaWwgdGhlIGNyZWF0aW9uIAo+PiBvZiBhIG5ldyBhc3NvY2lhdGlvbiAtIGl0J3Mg
YXQgbGVhc3QgNjBzIChhbiBhZG1pbiBjb21tYW5kIHRpbWVvdXQpLgo+Cj4gVGhhdCdzIHRoZSB3
b3JzdCBjYXNlIChhZG1pbiBjb21tYW5kIHRpbWVvdXQpLCBidXQgaXMgaXQgdGhlIG1vc3QgY29t
bW9uCj4gY2FzZT8KPgoKWWVzIC0gYXMgaXQgY3VycmVudGx5IGNvcnJlc3BvbmRzIHRvIHBhY2tl
dCBkcm9wcy7CoCBjb21tYW5kIGZhaWx1cmVzIGFyZSAKcmFyZS4gRkMgaGFzIGEgZmVhdHVyZSB0
byBzcGVlZCB0aGlzIHVwIGJ1dCBpdCdzIG5vdCB3aWRlbHkgaW1wbGVtZW50ZWQgeWV0LgoKPiBX
b3VsZCBtYWtpbmcgdGhlIHRpbWVvdXRzIHNob3J0ZXIgaW4gdGhlIGluaXRpYWwgY29ubmVjdCBt
YWtlIHNlbnNlPwo+IEp1c3QgdGhyb3dpbmcgb3V0IGlkZWFzLi4uCgpJJ2QgZW5qb3kgYSByZWR1
Y2VkIHRpbWUgcmVnYXJkbGVzcy4gQnV0IHRoZSBtYWluIGNvbmNlcm4gaXMgaG93IGxvbmcgd2Ug
CmhhdmUgdGhlIHN5c3RlbWQgcHJvY2Vzc2VzIGJsb2NrZWQuCgotLSBqYW1lcwoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGlu
ZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
