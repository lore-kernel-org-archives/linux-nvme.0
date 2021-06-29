Return-Path: <SRS0=UYep=LX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630CBC11F66
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 12:39:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F2061D5E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 12:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F2061D5E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TIRP8q3LEz/t0fWf+37eis3pagvkEqHohYok8uYpxGg=; b=DTd+hrZHNW3mRKh38zIE7rJLwJ
	Tiy6uOePWE9z5OFR0sUp2amz7ZIhxBQfjP+176Sq4SOhySatxDXD0HY9dU67wPgMJNOtRUk2UjSD2
	m+/uppXnftLluVj9faB9aw03eisd6HMe2PCb+f0zEycm5QNbJ9G5JNMF/Jhp0x+YzCaixOKFhi+4h
	pp4vi2ZCW5rOoseVYavH5m8GtR1xd81QIKW5L9xM9jkNlLwuc/u15m9mag7OrRmmk96dfVb00a/ID
	GnwP3lbczmSGeWCWVfcP5Pc4HA2BBGGg1pm3hTAzcaure+fAWMoMnDD0srRQaAMHew/9TLFY5lQZ9
	0nlqwK+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyD1M-00Ar1s-3s; Tue, 29 Jun 2021 12:39:20 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyD1J-00Ar0f-Hj
 for linux-nvme@lists.infradead.org; Tue, 29 Jun 2021 12:39:19 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2B429226C5;
 Tue, 29 Jun 2021 12:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624970356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=48/eMUt5PtkU1Z+OfK7Ymi50jT0XX4Wxvx3dYOl3Xrk=;
 b=uyx75GqJK8gG+KLCTA2elm8fsSaPos9nVI0HNHwr8uhE88kPoeynppMTXU+2nZFccHkzYz
 ciyfylmnSU9dQCVBk+HDkuS10GaqNGgOnSuv8ree67i4imSJYQzwi9TE3s/Z5ymM7ecGQg
 vON/vpG+dstXkBU8CN5vv4SkEH9lO6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624970356;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=48/eMUt5PtkU1Z+OfK7Ymi50jT0XX4Wxvx3dYOl3Xrk=;
 b=MU69S6cXYp84mfJOzW4rWymAsY5ZrSD9xUiY7Af8LixR6kkoZketxEjUs3uwi4FcqJtQF4
 MHH+FPwe4eDthHCA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id B4F1F11906;
 Tue, 29 Jun 2021 12:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624970356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=48/eMUt5PtkU1Z+OfK7Ymi50jT0XX4Wxvx3dYOl3Xrk=;
 b=uyx75GqJK8gG+KLCTA2elm8fsSaPos9nVI0HNHwr8uhE88kPoeynppMTXU+2nZFccHkzYz
 ciyfylmnSU9dQCVBk+HDkuS10GaqNGgOnSuv8ree67i4imSJYQzwi9TE3s/Z5ymM7ecGQg
 vON/vpG+dstXkBU8CN5vv4SkEH9lO6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624970356;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=48/eMUt5PtkU1Z+OfK7Ymi50jT0XX4Wxvx3dYOl3Xrk=;
 b=MU69S6cXYp84mfJOzW4rWymAsY5ZrSD9xUiY7Af8LixR6kkoZketxEjUs3uwi4FcqJtQF4
 MHH+FPwe4eDthHCA==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id 4tdjKnMU22D8TAAALh3uQQ
 (envelope-from <hare@suse.de>); Tue, 29 Jun 2021 12:39:15 +0000
Subject: Re: [PATCH 1/2] blk-mq: not deactivate hctx if the device doesn't use
 managed irq
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, John Garry <john.garry@huawei.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <20210629074951.1981284-2-ming.lei@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1a14a397-6244-928e-5aaa-85c2ccbe0e40@suse.de>
Date: Tue, 29 Jun 2021 14:39:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210629074951.1981284-2-ming.lei@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210629_053917_806289_7442AE7E 
X-CRM114-Status: GOOD (  27.78  )
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

T24gNi8yOS8yMSA5OjQ5IEFNLCBNaW5nIExlaSB3cm90ZToKPiBoY3R4IGlzIGRlYWN0aXZhdGVk
IHdoZW4gYWxsIENQVSBpbiBoY3R4LT5jcHVtYXNrIGJlY29tZSBvZmZsaW5lIGJ5Cj4gZHJhaW5p
bmcgYWxsIHJlcXVlc3RzIG9yaWdpbmF0ZWQgZnJvbSB0aGlzIGhjdHggYW5kIG1vdmluZyBuZXcK
PiBhbGxvY2F0aW9uIHRvIGFjdGl2ZSBoY3R4LiBUaGlzIHdheSBpcyBmb3IgYXZvaWRpbmcgaW5m
bGlnaHQgSU8gd2hlbgo+IHRoZSBtYW5hZ2VkIGlycSBpcyBzaHV0ZG93bi4KPiAKPiBTb21lIGRy
aXZlcnMobnZtZSBmYywgcmRtYSwgdGNwLCBsb29wKSBkb2Vzbid0IHVzZSBtYW5hZ2VkIGlycSwg
c28KPiB0aGV5IG5lZWRuJ3QgdG8gZGVhY3RpdmF0ZSBoY3R4LiBBbHNvLCB0aGV5IGFyZSB0aGUg
b25seSB1c2VyIG9mCj4gYmxrX21xX2FsbG9jX3JlcXVlc3RfaGN0eCgpIHdoaWNoIGlzIHVzZWQg
Zm9yIGNvbm5lY3RpbmcgaW8gcXVldWUuCj4gQW5kIHRoZWlyIHJlcXVpcmVtZW50IGlzIHRoYXQg
dGhlIGNvbm5lY3QgcmVxdWVzdCBjYW4gYmUgc3VibWl0dGVkCj4gdmlhIG9uZSBzcGVjaWZpZWQg
aGN0eCBvbiB3aGljaCBhbGwgQ1BVIGluIGl0cyBoY3R4LT5jcHVtYXNrIG1heSBoYXZlCj4gYmVj
b21lIG9mZmxpbmUuCj4gCgpIb3cgY2FuIHlvdSBzdWJtaXQgYSBjb25uZWN0IHJlcXVlc3QgZm9y
IGEgaGN0eCBvbiB3aGljaCBhbGwgQ1BVcyBhcmUgCm9mZmxpbmU/IFRoYXQgaGN0eCB3aWxsIGJl
IHVudXNhYmxlIGFzIGl0J2xsIG5ldmVyIGJlIGFibGUgdG8gcmVjZWl2ZSAKaW50ZXJydXB0cyAu
Li4KCj4gQWRkcmVzcyB0aGUgcmVxdWlyZW1lbnQgZm9yIG52bWUgZmMvcmRtYS9sb29wLCBzbyB0
aGUgcmVwb3J0ZWQga2VybmVsCj4gcGFuaWMgb24gdGhlIGZvbGxvd2luZyBsaW5lIGluIGJsa19t
cV9hbGxvY19yZXF1ZXN0X2hjdHgoKSBjYW4gYmUgZml4ZWQuCj4gCj4gCWRhdGEuY3R4ID0gX19i
bGtfbXFfZ2V0X2N0eChxLCBjcHUpCj4gCj4gQ2M6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJl
cmcubWU+Cj4gQ2M6IERhbmllbCBXYWduZXIgPGR3YWduZXJAc3VzZS5kZT4KPiBDYzogV2VuIFhp
b25nIDx3ZW54aW9uZ0B1cy5pYm0uY29tPgo+IENjOiBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5QGh1
YXdlaS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogTWluZyBMZWkgPG1pbmcubGVpQHJlZGhhdC5jb20+
Cj4gLS0tCj4gICBibG9jay9ibGstbXEuYyAgICAgICAgIHwgNiArKysrKy0KPiAgIGluY2x1ZGUv
bGludXgvYmxrLW1xLmggfCAxICsKPiAgIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1tcS5jIGIvYmxvY2sv
YmxrLW1xLmMKPiBpbmRleCBkZjVkYzNiNzU2ZjUuLjc0NjMyZjUwZDk2OSAxMDA2NDQKPiAtLS0g
YS9ibG9jay9ibGstbXEuYwo+ICsrKyBiL2Jsb2NrL2Jsay1tcS5jCj4gQEAgLTQ5NCw3ICs0OTQs
NyBAQCBzdHJ1Y3QgcmVxdWVzdCAqYmxrX21xX2FsbG9jX3JlcXVlc3RfaGN0eChzdHJ1Y3QgcmVx
dWVzdF9xdWV1ZSAqcSwKPiAgIAlkYXRhLmhjdHggPSBxLT5xdWV1ZV9od19jdHhbaGN0eF9pZHhd
Owo+ICAgCWlmICghYmxrX21xX2h3X3F1ZXVlX21hcHBlZChkYXRhLmhjdHgpKQo+ICAgCQlnb3Rv
IG91dF9xdWV1ZV9leGl0Owo+IC0JY3B1ID0gY3B1bWFza19maXJzdF9hbmQoZGF0YS5oY3R4LT5j
cHVtYXNrLCBjcHVfb25saW5lX21hc2spOwo+ICsJY3B1ID0gY3B1bWFza19maXJzdChkYXRhLmhj
dHgtPmNwdW1hc2spOwo+ICAgCWRhdGEuY3R4ID0gX19ibGtfbXFfZ2V0X2N0eChxLCBjcHUpOwoK
SSBkb24ndCBnZXQgaXQuCkRvZXNuJ3QgdGhpcyBhbGxvdyB1cyB0byBhbGxvY2F0ZSBhIHJlcXVl
c3Qgb24gYSBkZWFkIGNwdSwgaWUgdGhlIHZlcnkgCnRoaW5nIHdlIHRyeSB0byBwcmV2ZW50PwoK
Q2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtl
cm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBN
YXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBH
ZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
