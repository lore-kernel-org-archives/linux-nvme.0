Return-Path: <SRS0=KW0X=MA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BB8C07E96
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jul 2021 07:36:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BC86619BE
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jul 2021 07:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC86619BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GkiUJtg9JNKbhtRb5oiJ/vLp2/qE6LIZkXnKxpmJQTs=; b=zjMqoCnZCzYovedb3JF9wqx6VZ
	ommGcucWwIGxbUfTn911OELwj7lrAN0tD3hDOjJ/YLcIfezbfHOsAXTJlBAVHAPHaUL3xgUeIu8H7
	ptduBI/jxQRHncLb6I01E0Nkwy7hJVRXozGx+c8Rh4R+dLwmnv5/J0UHLppFkNNkyNRadZp1/iNuP
	rqYXis4UpuJME1xb3oZcQ1M+H9VSQTVjcqcInh7P5dQyL+LynjFRfvFlCHN36Y3mdozuK7APkrDjw
	KNYh9YCzwBEktz2JqVyBEh0f/CT+FF1G3g0UuQssfZpXB8iMBbSKRMDuzV29YAQtKar4aAl/eGpHT
	WVu4+88Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1Oa1-00GCzY-QA; Thu, 08 Jul 2021 07:36:17 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1OZy-00GCyv-CV
 for linux-nvme@lists.infradead.org; Thu, 08 Jul 2021 07:36:16 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 16C4820169;
 Thu,  8 Jul 2021 07:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625729773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GU17aDk5eTbemzXM5zBoSjT6Iki0gv19RDmxIbml/H4=;
 b=v49wXK+macPCpuL+8g4d9I6HHX4lGQUDlQlSSGbL9phYmLeWEUnA9/3QWVQBRs8JTLh4Bi
 KyXGlEVg2wjfatVeeUasgxbpn8QVO/teCStzkd9Nr9InnBGfzdNw27o0PBcNdu+wZ/FFri
 kbzznkJPJjoMGdAgH/QjxM+YmGGYpHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625729773;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GU17aDk5eTbemzXM5zBoSjT6Iki0gv19RDmxIbml/H4=;
 b=yXmsszhAnTBNUANz/LB4mLTYayhCbNqL7cGfLQDDL/d/XWcjhCsHoEkRmSRxRACMgJGrtF
 pf/+uRWccwnz7kBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id CF63A13430;
 Thu,  8 Jul 2021 07:36:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id IbUfL+yq5mCUHAAAGKfGzw
 (envelope-from <hare@suse.de>); Thu, 08 Jul 2021 07:36:12 +0000
Subject: Re: [PATCH 0/2] nvme-fabrics: short-circuit connect retries
To: Chao Leng <lengchao@huawei.com>, James Smart <jsmart2021@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210623143250.82445-1-hare@suse.de>
 <8d7c79d9-0928-8c71-74fd-7185d67e7895@grimberg.me>
 <204a6656-ef83-b688-4979-26fe17f57974@suse.de>
 <cdf40226-12ed-5f87-8549-10b4defceae5@huawei.com>
 <91ff9961-6537-05d1-c552-18a02d13bf0c@suse.de>
 <984b2d1a-f319-1a09-7347-6c4edd1dbab6@huawei.com>
 <d20b23fc-dd08-cb51-eb29-aa033810b0a4@suse.de>
 <caa3759f-9a72-5e3b-9097-700132e4ab63@gmail.com>
 <28ec79af-beb0-8ef9-ab6a-d608a632ee2c@huawei.com>
 <0af5901a-4dab-70de-abda-00ed7f8cf45f@suse.de>
 <c5ddf523-af8c-eae0-03fc-6c64d0df9e7c@huawei.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <2bf723c2-0c96-665e-c986-e630fa01862b@suse.de>
Date: Thu, 8 Jul 2021 09:36:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c5ddf523-af8c-eae0-03fc-6c64d0df9e7c@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210708_003614_629379_D02307AA 
X-CRM114-Status: GOOD (  30.97  )
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

T24gNy84LzIxIDg6MjkgQU0sIENoYW8gTGVuZyB3cm90ZToKPiAKPiAKPiBPbiAyMDIxLzYvMjkg
MTk6MDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4gT24gNi8yOC8yMSAzOjEwIEFNLCBDaGFv
IExlbmcgd3JvdGU6Cj4+Pgo+Pj4KPj4+IE9uIDIwMjEvNi8yNyAyMTozOSwgSmFtZXMgU21hcnQg
d3JvdGU6Cj4+Pj4gT24gNi8yNi8yMDIxIDU6MDkgQU0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToK
Pj4+Pj4gT24gNi8yNi8yMSAzOjAzIEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4+Pj4+Pgo+Pj4+Pj4K
Pj4+Pj4+IE9uIDIwMjEvNi8yNCAxNjoxMCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+Pj4+Pj4+
IE9uIDYvMjQvMjEgOToyOSBBTSwgQ2hhbyBMZW5nIHdyb3RlOgo+Pj4+Pj4+Pgo+Pj4+Pj4+Pgo+
Pj4+Pj4+PiBPbiAyMDIxLzYvMjQgMTM6NTEsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4+Pj4+
Pj4+IE9uIDYvMjMvMjEgMTE6MzggUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+Pj4gSGkgYWxsLAo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiBjb21taXQgZjI1Zjhl
ZjcwY2UyICgibnZtZS1mYzogc2hvcnQtY2lyY3VpdCByZWNvbm5lY3QgcmV0cmllcyIpCj4+Pj4+
Pj4+Pj4+IGFsbG93ZWQgdGhlIGZjIHRyYW5zcG9ydCB0byBob25vdXIgdGhlIEROUiBiaXQgZHVy
aW5nIHJlY29ubmVjdAo+Pj4+Pj4+Pj4+PiByZXRyaWVzLCBhbGxvd2luZyB0byBzcGVlZCB1cCBl
cnJvciByZWNvdmVyeS4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IEhvdyBkb2VzIHRoaXMgc3BlZWQg
dXAgZXJyb3IgcmVjb3Zlcnk/Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gV2VsbCwgbm90IGV4YWN0bHkg
ZXJyb3IgcmVjb3ZlcnkgKGFzIHRoZXJlIGlzIG5vdGhpbmcgdG8gcmVjb3ZlcikuCj4+Pj4+Pj4+
PiBCdXQgd2Ugd29uJ3QgYXR0ZW1wdCBwb2ludGxlc3MgcmV0cmllcywgdGhlcmVieSByZWR1Y2lu
ZyB0aGUgCj4+Pj4+Pj4+PiBub2lzZSBpbgo+Pj4+Pj4+Pj4gdGhlIG1lc3NhZ2UgbG9nLgo+Pj4+
Pj4+PiBUaGlzIGNvbmZsaWN0IHdpdGggdGhlIHRjcCBhbmQgcmRtYSB0YXJnZXQuCj4+Pj4+Pj4+
IFlvdSBtYXkgbmVlZCB0byBkZWxldGUgdGhlIGltcHJvcGVyIE5WTUVfU0NfRE5SIGF0IHRoZSB0
YXJnZXQuCj4+Pj4+Pj4+IEhvd2V2ZXIsIHRoaXMgd2lsbCBjYXVzZSBjb21wYXRpYmlsaXR5IGlz
c3VlcyBiZXR3ZWVuIGRpZmZlcmVudCAKPj4+Pj4+Pj4gdmVyc2lvbnMuCj4+Pj4+Pj4KPj4+Pj4+
PiBXaGljaCBvbmVzPwo+Pj4+Pj4gSW4gbWFueSBzY2VuYXJpb3MsIHRoZSBkZXN0aW5hdGlvbiBz
ZXRzIEROUiBmb3IgYWJub3JtYWwgcGFja2V0cywKPj4+Pj4+IGJ1dCBlYWNoIG5ldyBjb25uZWN0
aW9uIG1heSBub3QgaGF2ZSB0aGUgc2FtZSBlcnJvci4KPj4+Pj4KPj4+Pj4gVGhpcyBwYXRjaCBz
ZXJpZXMgaXMgb25seSBmb3IgdGhlIEROUiBiaXQgc2V0IGluIHJlc3BvbnNlIHRvIHRoZSAKPj4+
Pj4gJ2Nvbm5lY3QnIGNvbW1hbmQuCj4+Pj4+IElmIHRoZSB0YXJnZXQgaXMgbm90IGFibGUgdG8g
cHJvY2VzcyB0aGUgJ2Nvbm5lY3QnIGNvbW1hbmQsIGJ1dCBtYXkgCj4+Pj4+IGJlIHNvIGluIHRo
ZSBmdXR1cmUgaXQgcmVhbGx5IHNob3VsZCBub3Qgc2V0IHRoZSBETlIgYml0Lgo+Pj4+Pgo+Pj4+
Pj4+IEkgY2hlY2tlZCB0aGUgRE5SIHVzYWdlIGluIHRoZSB0YXJnZXQgY29kZSwgYW5kIHRoZXkg
c2VlbSB0byBzZXQgaXQKPj4+Pj4+PiBjb3JyZWN0bHkgKGllIHRoZSByZXN1bHQgd291bGQgbm90
IGNoYW5nZSB3aGVuIHRoZSBjb21tYW5kIGlzIAo+Pj4+Pj4+IHJldHJpZWQpLgo+Pj4+Pj4+IFdp
dGggdGhlIHBvc3NpYmxlIGV4Y2VwdGlvbiBvZiBFTk9TUEMgaGFuZGxpbmcsIGFzIHRoaXMgaXMg
YXJndWFibHkKPj4+Pj4+PiBkeW5hbWljIGFuZCBtaWdodCBjaGFuZ2Ugd2l0aCBhIHJldHJ5Lgo+
Pj4+Pj4gVGhlIEROUiBzdGF0dXMgb2YgdGhlIG9sZCBjb25uZWN0aW9uIG1heSBub3QgYmUgcmVs
ZXZhbnQgdG8gdGhlIAo+Pj4+Pj4gcmUtZXN0YWJsaXNoZWQgY29ubmVjdGlvbi4KPj4+Pj4KPj4+
Pj4gU2VlIGFib3ZlLgo+Pj4+PiBXZSBhcmUganVzdCBjaGVja2luZyB0aGUgRE5SIHNldHRpbmdz
IGZvciB0aGUgJ2Nvbm5lY3QnIGNvbW1hbmQgKG9yIAo+Pj4+PiBhbnkgb3RoZXIgY29tbWFuZHMg
YmVpbmcgc2VudCBkdXJpbmcgaW5pdGlhbCBjb250cm9sbGVyIAo+Pj4+PiBjb25maWd1cmF0aW9u
KS4KPj4+Pj4gSWYgdGhhdCBmYWlscyB0aGUgY29ubmVjdCBuZXZlciB3YXMgcHJvcGVybHkgaW5p
dGlhbGl6ZWQ7IGlmIHRoZSAKPj4+Pj4gY29udHJvbGxlciB3b3VsZCByZXR1cm4gYSBkaWZmZXJl
bnQgc3RhdHVzIGFmdGVyIHJlY29ubmVjdCBpdCAKPj4+Pj4gc2ltcGx5IHNob3VsZCBub3Qgc2V0
IHRoZSBETlIgYml0IC4uLgo+Pj4+Pgo+Pj4+PiBDaGVlcnMsCj4+Pj4+Cj4+Pj4+IEhhbm5lcwo+
Pj4+Cj4+Pj4gQWdyZWVkLiBTaW5jZSAxLjMgc3BlYyBzYXlzOiAiSWYgc2V0IHRvIOKAmDHigJks
IGluZGljYXRlcyB0aGF0IGlmIHRoZSAKPj4+PiBzYW1lIGNvbW1hbmQgaXMgcmUtc3VibWl0dGVk
IHRvIGFueSBjb250cm9sbGVyIGluIHRoZSBOVk0gc3Vic3lzdGVtLCAKPj4+PiB0aGVuIHRoYXQg
cmUtc3VibWl0dGVkIGNvbW1hbmQgaXMgZXhwZWN0ZWQgdG8gZmFpbC4iCj4+PiBBY2NvcmRpbmcg
dG8gdGhlIGRlZmluaXRpb24gb2YgdGhlIHByb3RvY29sLCB0aGlzIGlzIG5vdCBzdHJpY3RseSAK
Pj4+IGltcGxlbWVudGVkIG9uIHRoZSB0YXJnZXQgc2lkZS4KPj4+IEluIG52bWUvdGFyZ2V0LCB0
aGVyZSBhcmUgbWFueSBleHRlcm5hbCBlcnJvcnMsIHRoZSBETlIgaXMgc2V0IHRvIDEuCj4+PiBG
b3IgZXhhbXBsZSwgYWJvcm1hbCBmYWJyaWNzIGNtZC4KPj4KPj4gWWVzOyBidXQgYW4gYWJub3Jt
YWwgZmFicmljcyBjbWQgd2lsbCBiZSBhYm5vcm1hbCBldmVuIGFmdGVyIGEgcmVjb25uZWN0Lgo+
IFNvcnJ5LCBkZWxheWVkIHJlcGx5IGR1ZSB0byBsZWF2ZS4KPiBUaGVyZSBhcmUgbWFueSBwb3Nz
aWJpbGl0aWVzIGZvciBhYm5vcm1hbCBmYWJyaWNzIGNtZC4KPiBJbiBzb21lIHNjZW5hcmlvcywg
aWYgdGhlIGxpbmsgaXMgcmUtZXN0YWJsaXNoZWQsIHRoZSBlcnJvciBtYXkgbm90IAo+IG9jY3Vy
IGFnYWluLAo+IHN1Y2ggYXMgSEJBIGlubmVyIGVycm9yLCBuZXR3b3JrIGlzIGFibm9ybWFsIG9y
IGF0dGFja2VkIGV0Yy4KPj4KPj4+Pgo+Pj4+IFRodXMgaWYgdGhlIGluaXRpYWwgY29ubmVjdCBm
YWlscyBpbiB0aGlzIG1hbm5lciwgYW55IG5ldyAKPj4+PiBhc3NvY2lhdGlvbiB3aWxsIGJlIG9u
IGEgZGlmZmVyZW50IGNvbnRyb2xsZXIsIHdoZXJlIGl0IGlzIG5vdyAKPj4+PiBleHBlY3RlZCBj
b25uZWN0IG9uIHRoYXQgY29udHJvbGxlciB3aWxsIGZhaWwgdG9vLsKgIFRodXMgLSB3aHkgCj4+
Pj4gY29udGludWUgdG8gY29ubmVjdCB3aGVuIGl0J3MgZXhwZWN0ZWQgZWFjaCB3aWxsIGZhaWwu
Cj4+PiBBZ3JlZS4KPj4+IFdlIHNob3VsZCBub3QgYXR0ZW1wdCB0byByZS1lc3RhYmxpc2ggdGhl
IGNvbm5lY3Rpb24gaWYgdGFyZ2V0IGNhbiAKPj4+IG5vdCB3b3JrIGR1ZSB0byB0YXJnZXQgaW5u
ZXIgZXJyb3IgLgo+Pj4gSG93ZXZlciwgbm93wqAgdGFyZ2V0IGRvZXMgbm90IGJlaGF2ZSBleGFj
dGx5IGxpa2UgdGhpcywgc28gdGhlcmUgYXJlIAo+Pj4gY29uZmxpY3RzIGFuZCBjb21wYXRpYmls
aXR5IGlzc3Vlcy4KPj4KPj4gTm90ZTogd2UgbmV2ZXIgc2FpZCB0aGUgdGFyZ2V0IHNob3VsZCBf
bm90XyBzZW5kIGEgRE5SIHN0YXRlLiBXZSBvbmx5IAo+PiBzYWlkIHRoZSB0YXJnZXQgc2hvdWxk
IG9ubHkgc2V0IHRoZSBETlIgYml0IGlmIGEgcmV0cnkgKGV2ZW4gYWZ0ZXIgCj4+IHJlY29ubmVj
dCBvciBvbiBhIGRpZmZlcmVudCBjb250cm9sbGVyKSB3aWxsIG5vdCBjaGFuZ2UgdGhlIHJlc3Vs
dC4KPj4gV2hpY2ggZnJvbSB3aGF0IEkgY2FuIHNlZSBfaXNfIHRoZSBjYXNlLCBzbyBJIGRvIG5v
dCBzZWUgYW55IGlzc3VlcyBoZXJlLgo+Pgo+PiBQbGVhc2UgZ2l2ZSBkZXRhaWxzIGZvciB0aGUg
aXNzdWVzIHlvdSBhcmUgY29uY2VybmVkIHdpdGguCj4gRm9yIGV4YW1wbGUsIGlmIGhvc3Qgc2Vu
ZCBhIGZhYnJpYyBjbWQsIGJ1dCB0aGUgZmFicmljIGNtZCBpcyBwb2lzb25lZAo+IGR1ZSB0byBI
QkEgaW5uZXIgZXJyb3IsIGFibm9ybWFsIG9yIGF0dGFja2VkIG5ldHdvcmssIGFuZCB0aGVuIHRo
ZSB0YXJnZXQKPiBzZXQgdGhlIEROUiB0byByZXBseSByZXNwb25zZS4gSWYgZG8gbm90IHJlY29u
bmVjdCBmb3IgRE5SIHJlc3BvbnNlIG9mCj4gb2xkIGNvbm5lY3Rpb24sIHRodXMgdGhlIGNvbm5l
Y3RpbmcgY2FuIG5vdCBhb3RvIHJlY292ZXJ5LiBUaGUgZmFicmljCj4gY21kIHBvaXNvbmluZyBt
YXkgYmUgdHJhbnNpZW50LCBtYXkgc3VjY2VzcyBpZiB0cnkgZm9yIHJlY29ubmVjdGluZy4KPiBz
byB0cnkgdG8gcmVjb25uZWN0aW5nIGlzIGEgYmV0dGVyIGNob2ljZS4KCkJlZyB0byBkaXNhZ3Jl
ZSBoZXJlLgpBbnkgb2YgdGhlIGVycm9ycyB5b3UgZGVzY3JpYmUgaGVyZSBhcmUgc29tZXRoaW5n
IHdoaWNoIF9yZWFsbHlfIGRvIAp3YXJyYW50IGEgY2xvc2UgaW5zcGVjdGlvbiAoYXMgeW91IGZv
ciBfc3VyZV8gd2lsbCB3YW50IHRvIGludmVzdGlnYXRlIAppZiB5b3VyIG5ldHdvcmsgaXMgdW5k
ZXIgYXR0YWNrKSwgc28gZXZlbiBfaWZfIGEgcmV0cnkgd291bGQgJ2ZpeCcgCnRoaW5ncyB3ZSBz
dGlsbCBzaG91bGQgYmFpbCBvdXQgdG8gaW5kaWNhdGUgdG8gdGhlIGNhbGxlciB0aGF0IHNvbWUg
CmludGVyYWN0aW9uIGlzIGluIG9yZGVyLgoKPiBJZiBkbyBub3QgcmVjb25uZWN0IGZvciBETlIg
cmVzcG9uc2UsIHRhcmdldCBzaG91bGQgc2V0IEROUiBzdGF0ZSBqdXN0Cj4gZm9yIHRhcmdldCBp
bm5lciBlcnJvci4KClllcy4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNr
ZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2Fy
ZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgw
OSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZt
ZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
