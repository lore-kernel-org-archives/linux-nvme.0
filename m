Return-Path: <SRS0=QV8n=5I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B89C43331
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 20:10:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B301A20637
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 20:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o6/Idqa9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bppck7cy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B301A20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date
	:Message-ID:From:References:To:Subject:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9FZuq57pJjgAkkmUt5qmLkpB+3a48FfSXTgLuY0Tsao=; b=o6/Idqa9J8qtcV
	ajDCRqlQhdB4rKAFi4KDy59B9blA/JXPzB/2AqurryHqgcIpRvnS9mjmVY18cYj2Uhi1KO4nA0tD8
	EgN2gW9uGkDrMEtf9fDgc154LOQI+bWU4KUMH/FaoNvhPkhokPsS8BXb505Yrb6GvTRoxnPjXxGl/
	WSx5l/ZSxsNuKXISXK+Zk8OZStOW/YdzeOl6tt8yuJqCtCW3FbsCnHQohJyhn/A9x6B2/fYSuepv4
	eNRCUR+2XwAfw7V4DTd8qx2gs0ZKdFZy8RpPW41lIIPF2urWf6XKRATU+GDhBLrCDqP40zAvVTAtF
	EYUwAQt3SWl3ADfsCr/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGTOz-0008QS-En; Mon, 23 Mar 2020 20:10:25 +0000
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGTOx-0008Q6-1n
 for linux-nvme@lists.infradead.org; Mon, 23 Mar 2020 20:10:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584994221;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0EUvvFdrllLo7j4Q3owIHMILGlxEkw8ApzW4I+P8ESc=;
 b=Bppck7cylZVMxaLFs6bqC5ZDQ/x+Lf4ycIS4VW2uVofqtWPMiMezMSyrBz3iLuKnz8rJuv
 9DrDswm4olYxUm8VSfGfWfr9EA//Kmh+NL8MQZqdBtg8i5aadOGetkiWUenhfOO6NU65Xw
 Dbbov+AZ7dUJdRnTh2GwZx+xHBioKb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-n2eQOXnAPJSSoG1WhytQLQ-1; Mon, 23 Mar 2020 16:10:19 -0400
X-MC-Unique: n2eQOXnAPJSSoG1WhytQLQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15B2E801E67
 for <linux-nvme@lists.infradead.org>; Mon, 23 Mar 2020 20:10:19 +0000 (UTC)
Received: from [10.3.128.7] (unknown [10.3.128.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F2B05DA7C
 for <linux-nvme@lists.infradead.org>; Mon, 23 Mar 2020 20:10:18 +0000 (UTC)
Subject: Re: nvmet: Kernel oops when doing mkfs on nvme-tcp device
To: linux-nvme@lists.infradead.org
References: <17c25d8d-0dc2-9dc8-2b65-954034c23646@redhat.com>
 <507887d2-96dd-b0ee-bb05-519039d98359@grimberg.me>
 <f18d9173-b94e-69d6-022a-20603e8cb42b@grimberg.me>
 <7b56c65b-40a3-0172-6e42-7158fd88361c@redhat.com>
 <BYAPR04MB4965E360B649BF0EB0D1BAA586F20@BYAPR04MB4965.namprd04.prod.outlook.com>
 <52a296da-839d-a8a8-fe77-720faeb37aab@redhat.com>
 <d09a86be-01eb-1665-d596-886beedf53b4@grimberg.me>
From: Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Message-ID: <1c882509-0a76-81c3-76ca-eba67de2fe34@redhat.com>
Date: Mon, 23 Mar 2020 15:10:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <d09a86be-01eb-1665-d596-886beedf53b4@grimberg.me>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_131023_170470_F8F6E141 
X-CRM114-Status: GOOD (  11.84  )
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
Reply-To: tasleson@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy8yMy8yMCAyOjQyIFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+Pj4gbnZtZXQgZG9l
cyBzdXBwb3J0IGZpbGUgYmFja2VuZCwgcGxlYXNlIGhhdmUgYSBsb29rIGF0IGJsa3Rlc3RzIFsx
XQo+Pj4gdW5kZXIgdGhlIHRlc3QgMDI1IGluIHtCTEtURVNUX0hPTUV9L3Rlc3RzL252bWUgYWJv
dXQgaG93IHRvIHNldHVwCj4+PiB0YXJnZXQgd2l0aCBmaWxlIGJhY2tlbmQuCj4+Cj4+IEkgY3Jl
YXRlZCBhIHNwYXJzZSBmaWxlIGFuZCB1c2VkIG52bWV0Y2xpIHRvIGNoYW5nZSBkZXZpY2UgdG8g
dGhlCj4+IHNwZWNpZmllZCBmaWxlLsKgIEkgY29ubmVjdGVkIHRoZSBjbGllbnQsIHJhbiBkZCBh
bmQgdGhhdCB3b3JrZWQgZmluZS7CoCBJCj4+IHRyaWVkIHVzaW5nIG1rZnMuZXh0NCBhbmQgSSBn
b3QgdGhlIHNhbWUga2VybmVsIG9vcHMuwqAgQXBwYXJlbnRseSBpdAo+PiBkb2Vzbid0IG1hdHRl
ciBpZiBJIHVzZSBhIGZpbGUgb3IgZGV2aWNlIGFzIHRoZSBiYWNraW5nIHN0b3JlIGZvciB0aGlz
Cj4+IGlzc3VlLgo+IAo+IEludGVyZXN0aW5nLCBkaWQgeW91IHNlZSB0aGUgd3JpdGVfemVyb2Vz
IGVycm9yIHRob3VnaD8KClllcywgd3JpdGUgemVyb3MgZXJyb3IgaXMgc3RpbGwgcHJlc2VudC4K
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1u
dm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
