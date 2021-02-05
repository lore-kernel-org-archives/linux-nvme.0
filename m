Return-Path: <SRS0=OXBW=HH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA1AC433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 09:38:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9F564FB2
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 09:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9F564FB2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=w7ULV/LwhkHcoCHX6ugFeTU2ZOGV8gUuchcrD6AHoUg=; b=M8Ob/co38NGOInYCqfz4WtV5G
	3ALi2khWpcePGvRw61FOcv8Ihy33u1xMx8uzzYADrHIg5kENdD8/QEpZxO/8RjBR52l4EHBHW0Dvg
	kMkq9/G0CBOIwdIYq/Xyb7X8f9D9XdZCMCqc5nN2cOQD6ACmy4jVBrMd5uCn5STA/OiA9uKBNM8SI
	nNuzhiaCtxudpFp4UUl3r7qxm6qtfDMXFmCf1OE4JxrTiboYksU04+y/i74AVzvbYSwMc4EWTTxEq
	vWG7nIE6c8F7GaDSFx5hg9Yp4/eY5I/lWBjQmWH/NjEKFm/czP3BxIKGWFLLyAHeWGuTj614z7vdw
	9XOsdl1HA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7xZe-00038y-PL; Fri, 05 Feb 2021 09:38:46 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7xZb-00038W-Lk
 for linux-nvme@lists.infradead.org; Fri, 05 Feb 2021 09:38:44 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 76EF1AD0B;
 Fri,  5 Feb 2021 09:38:42 +0000 (UTC)
Subject: Re: [PATCH] nvmet: per-host namespaces masking
To: Christoph Hellwig <hch@lst.de>
References: <20210205092926.64161-1-hare@suse.de>
 <20210205093237.GA2066@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e505e360-ec8a-ba06-4a40-bf9d2006a7a0@suse.de>
Date: Fri, 5 Feb 2021 10:38:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210205093237.GA2066@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210205_043843_835037_BDC43D22 
X-CRM114-Status: GOOD (  17.90  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi81LzIxIDEwOjMyIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBGcmksIEZl
YiAwNSwgMjAyMSBhdCAxMDoyOToyNkFNICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+
IEltcGxlbWVudCBwZXItaG9zdCBuYW1lc3BhY2VzIG1hc2tpbmcsIGFsbG93aW5nIHRvIGV4cG9z
ZQo+PiBkaWZmZXJlbnQgbmFtZXNwYWNlcyB0byBkaWZmZXJlbnQgaG9zdHMgY29ubmVjdGluZyB0
byB0aGUKPj4gc2FtZSBzdWJzeXN0ZW0uCj4+IFRoZSBvcmlnaW5hbCBtZXRob2Qgb2YgYWRkaW5n
IGhvc3QgbnFucyB0byB0aGUgc3Vic3lzdGVtCj4+IHRha2VzIHByZWNlZGVuY2Ugb3ZlciB0aGUg
cGVyLWhvc3QgbmFtZXNwYWNlIG1hc2tpbmcuCj4gCj4gV2h5IGRvIHlvdSB3YW50IHRvIGV4cG9z
ZSBhIHNpbmdsZSBzdWJzeXN0ZW0gdG8gbXVsdGlwbGUgaG9zdHM/ICBUaGlzCj4gY3JlYXRlcyBh
bGwga2luZHMgb2YgY292ZXJ0IGNoYW5uZWxzIGJldHRlciBhdm9pZGVkLgo+IApCdXQgdGhlIGFs
dGVybmF0aXZlIGlzIGEgc3Vic3lzdGVtIHBlciBob3N0LgpXaGljaCBsZWFkcyB0byBhIHByb2xp
ZmVyYXRpb24gb2Ygc3Vic3lzdGVtcyBvbiB0aGUgdGFyZ2V0LgpBbmQgSSB3YXNuJ3QgcXVpdGUg
a2VlbiBvbiB0aGF0LgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAg
ICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNv
bHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChB
RyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1h
aWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
