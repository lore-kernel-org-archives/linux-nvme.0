Return-Path: <SRS0=Uoxm=H7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD6DC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 13:55:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE3FC64EBA
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 13:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3FC64EBA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=E8hJWS0OXNxLI76k5wNO4p1vBbOVHoQP3E0QIizlVfc=; b=TLptr1BLUK6f2E26SwCkedBLF
	PQBM4GB8XdCKwe2c+JKCxuFn2qEo7canQbTj5o8dC597789BFPqWdDSK6B36ShnOv60EyKoBFy+rq
	w7LNr+lSCb51E1NifSbmZyWSUwSZ/f+YoHAkY4Rw6LJAW6cdc0TWmJVIoXJeYnEONv5HFQOUQL515
	1+1dpsVpTtJgAbGf+FPTNyrrzghTxcaMBnUcwQtd1yh9EwBESyddjIS6kbfFc0IITtlCoVV7BNrX/
	ezV1LGciQiCSruyypx2jskIepCkuZ+2htx+3qaftQ9GCYyVSxbR7HWLsD1yQt4Yyn1Jx8K3OI8Ps4
	yash09zdQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGj1M-0003Sv-K2; Mon, 01 Mar 2021 13:55:36 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGj1K-0003ST-71
 for linux-nvme@lists.infradead.org; Mon, 01 Mar 2021 13:55:35 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 4EA45AC24;
 Mon,  1 Mar 2021 13:55:31 +0000 (UTC)
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
To: Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>
References: <20210212210929.GA3851@redsun51.ssa.fujisawa.hgst.com>
 <ddf87227-1ad3-b8be-23ba-460433f70a85@grimberg.me>
 <73e4914e-f867-c899-954d-4b61ae2b4c33@suse.de>
 <20210215104020.yyithlo2hkxqvguj@beryllium.lan>
 <a2064070-b511-ba6d-bd64-0b3abc208356@grimberg.me>
 <20210226123534.4oovbzk4wrnfjp64@beryllium.lan>
 <9e209b12-3771-cdca-2c9d-50451061bd2a@suse.de>
 <20210226161355.GG31593@redsun51.ssa.fujisawa.hgst.com>
 <a42d6285-ff32-3e16-b2b1-808d29f2a743@suse.de>
 <20210226171901.GA3949@redsun51.ssa.fujisawa.hgst.com>
 <20210301132639.n3eowtvkms2n5mog@beryllium.lan>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <786dcef5-148d-ff34-590c-804b331ac519@suse.de>
Date: Mon, 1 Mar 2021 14:55:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210301132639.n3eowtvkms2n5mog@beryllium.lan>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210301_085534_377882_1B4544CE 
X-CRM114-Status: GOOD (  17.58  )
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
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy8xLzIxIDI6MjYgUE0sIERhbmllbCBXYWduZXIgd3JvdGU6Cj4gT24gU2F0LCBGZWIgMjcs
IDIwMjEgYXQgMDI6MTk6MDFBTSArMDkwMCwgS2VpdGggQnVzY2ggd3JvdGU6Cj4+IENyYXNoaW5n
IGlzIGJhZCwgc2lsZW50IGRhdGEgY29ycnVwdGlvbiBpcyB3b3JzZS4gSXMgdGhlcmUgdHJ1bHkg
bm8KPj4gZGVmZW5zZSBhZ2FpbnN0IHRoYXQ/IElmIG5vdCwgd2h5IHNob3VsZCBhbnlvbmUgcmVs
eSBvbiB0aGlzPwo+IAo+IElmIHdlIHJlY2VpdmUgYW4gcmVzcG9uc2UgZm9yIHdoaWNoIHdlIGRv
bid0IGhhdmUgYSBzdGFydGVkIHJlcXVlc3QsIHdlCj4ga25vdyB0aGF0IHNvbWV0aGluZyBpcyB3
cm9uZy4gQ291bGRuJ3Qgd2UgaW4ganVzdCByZXNldCB0aGUgY29ubmVjdGlvbgo+IGluIHRoaXMg
Y2FzZT8gV2UgZG9uJ3QgaGF2ZSB0byBwcmV0ZW5kIG5vdGhpbmcgaGFzIGhhcHBlbmVkIGFuZAo+
IGNvbnRpbnVpbmcgbm9ybWFsbHkuIFRoaXMgd291bGQgYXZvaWQgYSBob3N0IGNyYXNoIGFuZCB3
b3VsZCBub3QgY3JlYXRlCj4gKG1vcmUpIGRhdGEgY29ycnVwdGlvbi4gT3IgSSBhbSBqdXN0IHRv
byBuYWl2ZT8KPiAKVGhpcyBpcyBhY3R1YWxseSBhIHNlbnNpYmxlIHNvbHV0aW9uLgpQbGVhc2Ug
c2VuZCBhIHBhdGNoIGZvciB0aGF0LgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJl
aW5lY2tlCQkgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJ
CQkgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0
aW9ucyBHZXJtYW55IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4
MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0
CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
