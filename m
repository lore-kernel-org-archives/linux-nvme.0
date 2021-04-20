Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC8DC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 13:19:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB8526054E
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 13:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8526054E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bFTWjvOjkjd55coJ/JIEqKM+C2X3vxhGJophLR6/AUc=; b=XoD/VS3uR8+Kb28q3kHSb8oy5
	y52jJokkVQ4VotTcangxIwv4zUHdmD6WT9rAGDwB60GX1iqWWSCn28iOWMZtyIvDK2WHWxDL/tjPt
	BRg8UO7nIHD3SM7HDiy3g0nS4O5GAFECvxL7GNIdPZ7TfKEX2C9DB8DCOs9TAs4y8y1BPLWSEipEo
	jAKLzOGuI8ARtx1vgpmZAC66K7S/2aDseF4dbkeWiPrgf+iDhunfwwX1SrtzJiNPkn4MCNLfMkhOo
	oNxteZutFoU1eW/4u0Vced8QRYPhTFnBVqJNFTwvm1jiMBc5goFcSfQ/ILchT9HeF19nc0ZeINuL0
	jUxe0bRcQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYqHf-00CBtm-O6; Tue, 20 Apr 2021 13:19:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYqHd-00CBsr-0J
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 13:19:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=ZDchkqagQB/gLb/sRwaUJrwKJ4SOD1Mjooij5QG4pEs=; b=RwuNwLx7wMBQ+TTfiffu/52zlu
 Id+3HWn8BN++M6CgU6EWBq9BFnDAW5GTypPFJKGwd5R5d/qTU4zAVa4s0xRCJyrKmv9DVwFwwUzQS
 IWG+jaxnhW1pOoEpXPHBblB08rfWUeDl438hqqZtfe/5aIdv8jUQNnVowHVTdW8g/HHoqo75Aj2e8
 ycxvtVi1/KCUyz52Fr1bvnQrLbiBiL30DFlr0Hp3zFbdnRHuc9fIJSLa4p4tnKQlAtE7+XagtR43q
 1SSCqE9z5PAgyhApij8Ly2mEZaTeaWm1H2fcVQifDpCM+jvb1h6c9mVhN7AB0A7ykndPi0c71/1r9
 48vnvsZQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYqHa-00C8U2-9O
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 13:19:15 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E37C7B2F1;
 Tue, 20 Apr 2021 13:19:12 +0000 (UTC)
Subject: Re: [PATCHv2] nvme-mpath: delete disk after last connection
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <daniel.wagner@suse.de>
References: <20210416062411.47958-1-hare@suse.de>
 <20210420080527.GA21651@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b5dc2cdf-fcb0-8ffc-8ea9-c77d32561043@suse.de>
Date: Tue, 20 Apr 2021 15:19:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210420080527.GA21651@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_061914_495982_6C2B10B2 
X-CRM114-Status: GOOD (  18.08  )
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

T24gNC8yMC8yMSAxMDowNSBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gT24gRnJpLCBB
cHIgMTYsIDIwMjEgYXQgMDg6MjQ6MTFBTSArMDIwMCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+
PiBXaXRoIHRoZSBwcm9wb3NlZCBwYXRjaCwgdGhlIGZvbGxvd2luZyBtZXNzYWdlcyBhcHBlYXI6
Cj4+Cj4+ICAgWyAgMjI3LjUxNjgwN10gbWQvcmFpZDE6bWQwOiBEaXNrIGZhaWx1cmUgb24gbnZt
ZTNuMSwgZGlzYWJsaW5nIGRldmljZS4KPj4gICBbICAyMjcuNTE2ODA3XSBtZC9yYWlkMTptZDA6
IE9wZXJhdGlvbiBjb250aW51aW5nIG9uIDEgZGV2aWNlcy4KPiAKPiBTbyBob3cgaXMgdGhpcyBn
b2luZyB0byB3b3JrIGZvciBlLmcuIGEgY2FzZSB3aGVyZSB0aGUgZGV2aWNlCj4gZGlzYXBwZWFy
IGR1ZSB0byByZXNldHMgb3IgZmFicmljcyBjb25uZWN0aW9uIHByb2JsZW1zPyAgVGhpcyBub3cK
PiBkaXJlY3RseSB0ZWFyZHMgZG93biB0aGUgZGV2aWNlLgo+IApZZXMsIHRoYXQgaXMgY29ycmVj
dDsgdGhlIG5zaGVhZCB3aWxsIGJlIHJlbW92ZWQgb25jZSB0aGUgbGFzdCBwYXRoIGlzIApfcmVt
b3ZlZF8uIEJ1dCBrZXkgcG9pbnQgaGVyZSBpcyB0aGF0IG9uY2UgdGhlIHN5c3RlbSBmaW5kcyBp
dHNlbGYgaW4gCnRoYXQgc2l0dWF0aW9uIGl0J3MgaW1wb3NzaWJsZSB0byByZWNvdmVyLCBhcyB0
aGUgcmVmY291bnRzIGFyZSBtZXNzZWQuCkV2ZW4gYSBtYW51YWwgY29ubmVjdCBjYWxsIHdpdGgg
dGhlIHNhbWUgcGFyYW1ldGVyIHdpbGwgX25vdF8gcmVzdG9yZSAKb3BlcmF0aW9uLCBidXQgcmF0
aGVyIHJlc3VsdCBpbiBhIG5ldyBuYW1lc3BhY2UuClNvIHdpdGggdGhpcyBwYXRjaCB3ZSBjaGFu
Z2UgZnJvbSBzdGFsbGVkIEkvTyAod2hlcmUgdGhlIHVzZXIgaGFzIHRvCnJlYm9vdCB0aGUgbWFj
aGluZSB0byByZXN0b3JlIG9wZXJhdGlvbikgdG8gSS9PIGVycm9ycyAoZ2l2aW5nIHRoZSB1c2Vy
IAphdCBsZWFzdCBhIF9jaGFuY2VfIHRvIHJlY292ZXIpLgoKSSBjYW4gZWFzaWx5IGNvbnNpZGVy
IGFkZGluZyBhICdxdWV1ZV9pZl9ub19wYXRoJyBvcHRpb24gdG8gYWxsb3cgSS9PIHRvIApiZSBo
ZWxkIGV2ZW4gb25jZSBhbGwgcGF0aHMgYXJlIGRpc2Nvbm5lY3RlZCwgYnV0IHRoYXQgd2lsbCBi
ZSBlbm90aGVyIApwYXRjaC4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNr
ZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2Fy
ZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgw
OSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZt
ZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
