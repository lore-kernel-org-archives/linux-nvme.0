Return-Path: <SRS0=oqNq=DJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99848C4727F
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 08:30:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F68206B8
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 08:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="19S48gbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F68206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yj2Bp2bR62w+cIp3HlFyCO0nwOLu6tHRPbzuyTKUdKk=; b=19S48gbgaRsaczfB8Ffs3yPtx
	XJsVx0lh1mK9A/T+QiwcDIzVbktHQ8xk0UOuH5xNUtAKuG0rE9ohoQfNHUEqwh/7zjoUxh8sCatfH
	RpYc67RiEH7X8QIKsAy7i/N9O8Qdljurb+zCV4qMdaVheLGMbRTjv2tiVnOuosKDY3qFIEitCLumj
	PwzEdQKkX/3meS2DopBokNF6w8Sk9efnXBI2sEYvxUtRaOYR3zCtF7NKS45CBuyrSgbuKaDSarLGg
	XkilyxmkIYQ+MZbkW5XhokHC0jJMiuUc+fIjk+ZAUbe61M3W5Ev2/gbmagCRo19hNeQTooegaKB27
	eAJG3yBlA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kOGSX-00071H-4q; Fri, 02 Oct 2020 08:30:33 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kOGSU-00070Q-Sn
 for linux-nvme@lists.infradead.org; Fri, 02 Oct 2020 08:30:31 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A4D13AF34;
 Fri,  2 Oct 2020 08:30:29 +0000 (UTC)
Subject: Re: [PATCH v9 0/7] Introduce sendpage_ok() to detect misused sendpage
 in network related drivers
To: David Miller <davem@davemloft.net>
References: <20201001075408.25508-1-colyli@suse.de>
 <20201001.124345.2303686561459641833.davem@davemloft.net>
 <20201001.124815.793423380665613978.davem@davemloft.net>
From: Coly Li <colyli@suse.de>
Autocrypt: addr=colyli@suse.de; keydata=
 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
Message-ID: <3a46f056-8314-4467-4a11-40d11ddad99e@suse.de>
Date: Fri, 2 Oct 2020 16:30:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201001.124815.793423380665613978.davem@davemloft.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201002_043031_198082_FF897F21 
X-CRM114-Status: GOOD (  16.47  )
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
Cc: michaelc@cs.wisc.edu, amwang@redhat.com, linux-nvme@lists.infradead.org,
 philipp.reisner@linbit.com, hch@lst.de, vbabka@suse.com, sagi@grimberg.me,
 linux-scsi@vger.kernel.org, idryomov@gmail.com, open-iscsi@googlegroups.com,
 mskorzhinskiy@solarflare.com, chaitanya.kulkarni@wdc.com,
 linux-block@vger.kernel.org, hare@suse.de, ceph-devel@vger.kernel.org,
 axboe@kernel.dk, cleech@redhat.com, vvs@virtuozzo.com, eric.dumazet@gmail.com,
 netdev@vger.kernel.org, jlayton@kernel.org, linux-kernel@vger.kernel.org,
 lduncan@suse.com, jack@suse.com
Content-Type: text/plain; charset="iso8859-7"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjAyMC8xMC8yIDAzOjQ4LCBEYXZpZCBNaWxsZXIgd3JvdGU6Cj4gRnJvbTogRGF2aWQgTWls
bGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0Pgo+IERhdGU6IFRodSwgMDEgT2N0IDIwMjAgMTI6NDM6
NDUgLTA3MDAgKFBEVCkKPiAKPj4gU2VyaWVzIGFwcGxpZWQgYW5kIHF1ZXVlZCB1cCBmb3IgLXN0
YWJsZSwgdGhhbmsgeW91Lgo+IAo+IEFjdHVhbGx5LCB0aGlzIGRvZXNuJ3QgZXZlbiBidWlsZDoK
PiAKPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9idWcuaDo5
MywKPiAgICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L2J1Zy5oOjUsCj4gICAg
ICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51eC9tbWRlYnVnLmg6NSwKPiAgICAgICAg
ICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L21tLmg6OSwKPiAgICAgICAgICAgICAgICAg
IGZyb20gbmV0L3NvY2tldC5jOjU1Ogo+IG5ldC9zb2NrZXQuYzogSW4gZnVuY3Rpb24goWtlcm5l
bF9zZW5kcGFnZaI6Cj4gLi9pbmNsdWRlL2FzbS1nZW5lcmljL2J1Zy5oOjk3OjM6IGVycm9yOiB0
b28gZmV3IGFyZ3VtZW50cyB0byBmdW5jdGlvbiChX193YXJuX3ByaW50a6IKPiAgICA5NyB8ICAg
X193YXJuX3ByaW50ayhhcmcpOyAgICAgXAo+ICAgICAgIHwgICBefn5+fn5+fn5+fn5+Cj4gCj4g
V2FzIHRoaXMgZXZlbiBidWlsZCB0ZXN0ZWQ/Cj4gCgpIaSBEYXZpZCwKCk9idmlvdXNseSBteSBm
YXVsdCBhbmQgbm8gZXhjdXNlIGZvciBsZWFraW5nIHRoaXMgdW5jb21wbGV0ZWQgdmVyc2lvbiB0
bwp5b3UuIEkganVzdCByZS1wb3N0IGEgdjEwIHZlcnNpb24gd2hpY2ggSSBtYWtlIHN1cmUgYWxs
IHBhdGNoZXMgYXJlIHRoZQpsYXRlc3QgdmVyc2lvbi4KClNvcnJ5IGZvciB0aGUgaW5jb252ZW5p
ZW5jZSBhbmQgdGhhbmsgeW91IGluIGFkdmFuY2UgZm9yIHRha2luZyB0aGlzIHNldC4KCkNvbHkg
TGkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
