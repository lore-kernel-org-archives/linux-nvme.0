Return-Path: <SRS0=UYep=LX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72DBC11F66
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 11:00:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 924AC61D50
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 11:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924AC61D50
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k1mm/6V/w0Z48n/9Y16A2TjFtUlVKEqI3WyqghBbogM=; b=LvZqf+aO6JoFCb0EdDCZzzPbZ1
	8Z5GBBpfWDfENb0h6mBEDNOKlvd9p/EqUdZQLAFJEzamkHkKe7mCNxVwaXtdFWQezis7NDmB1TcBb
	yhz+XzQks6OObIglYm8Hx0nqa4dSCc2xusoqLv03P6ACGrCLsFmJi+itlx0I8G5ZeobKooCqUnLDB
	uVTv038yGY54646nL/ifHqiPWlDHUH2l65fe09q1vjP1lrIpYfl+iFoy1Qz0MezQFqRXlO8IsDk3q
	bo2eYbTbGY8zY5cjsT/m0vP0PBgp578EXWMoaMEfTSUxFpHX/L03nbFBm06yTmi1VO/8wB6oJlCZl
	TRrRrHqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyBTT-00Abnm-Tz; Tue, 29 Jun 2021 11:00:15 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyBTQ-00AbmO-9b
 for linux-nvme@lists.infradead.org; Tue, 29 Jun 2021 11:00:13 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DF7A9203CD;
 Tue, 29 Jun 2021 11:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624964407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQtfzzdIjAy3ZxhwqNtVOmqXuS+Ive/xLwdgZl7Z5w4=;
 b=usrBRbHhyUg8rXXRgeb4ZCNl2W0vXJERUmwRx9EV7YD/cfbRJevmZKDqcKJxQ93kwjXG7T
 +N+VmFswYa2ZeyYJEvFzCTOgyS/4XhDmj5TT+bfi5JASaXS7dbTQyqshsFk+OM65vgDEgZ
 +K9gFOtrXl+hsjR8PW5iXbn+AIxRos8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624964407;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQtfzzdIjAy3ZxhwqNtVOmqXuS+Ive/xLwdgZl7Z5w4=;
 b=DElb1angYEIhOv/wNRgZUnAoZ7rYr0+B/O82t9zc9FnFYrm09keump1oWFo0SK2k/d8qBB
 OFHAbwSBCCjRPfDA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 9200111906;
 Tue, 29 Jun 2021 11:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624964407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQtfzzdIjAy3ZxhwqNtVOmqXuS+Ive/xLwdgZl7Z5w4=;
 b=usrBRbHhyUg8rXXRgeb4ZCNl2W0vXJERUmwRx9EV7YD/cfbRJevmZKDqcKJxQ93kwjXG7T
 +N+VmFswYa2ZeyYJEvFzCTOgyS/4XhDmj5TT+bfi5JASaXS7dbTQyqshsFk+OM65vgDEgZ
 +K9gFOtrXl+hsjR8PW5iXbn+AIxRos8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624964407;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQtfzzdIjAy3ZxhwqNtVOmqXuS+Ive/xLwdgZl7Z5w4=;
 b=DElb1angYEIhOv/wNRgZUnAoZ7rYr0+B/O82t9zc9FnFYrm09keump1oWFo0SK2k/d8qBB
 OFHAbwSBCCjRPfDA==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id iJ0cIjf92mDAFwAALh3uQQ
 (envelope-from <hare@suse.de>); Tue, 29 Jun 2021 11:00:07 +0000
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
From: Hannes Reinecke <hare@suse.de>
Message-ID: <0af5901a-4dab-70de-abda-00ed7f8cf45f@suse.de>
Date: Tue, 29 Jun 2021 13:00:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <28ec79af-beb0-8ef9-ab6a-d608a632ee2c@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210629_040012_538722_1490BEF0 
X-CRM114-Status: GOOD (  28.95  )
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

T24gNi8yOC8yMSAzOjEwIEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4gCj4gCj4gT24gMjAyMS82LzI3
IDIxOjM5LCBKYW1lcyBTbWFydCB3cm90ZToKPj4gT24gNi8yNi8yMDIxIDU6MDkgQU0sIEhhbm5l
cyBSZWluZWNrZSB3cm90ZToKPj4+IE9uIDYvMjYvMjEgMzowMyBBTSwgQ2hhbyBMZW5nIHdyb3Rl
Ogo+Pj4+Cj4+Pj4KPj4+PiBPbiAyMDIxLzYvMjQgMTY6MTAsIEhhbm5lcyBSZWluZWNrZSB3cm90
ZToKPj4+Pj4gT24gNi8yNC8yMSA5OjI5IEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4+Pj4+Pgo+Pj4+
Pj4KPj4+Pj4+IE9uIDIwMjEvNi8yNCAxMzo1MSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+Pj4+
Pj4+IE9uIDYvMjMvMjEgMTE6MzggUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4+Pj4+Pj4+Cj4+
Pj4+Pj4+PiBIaSBhbGwsCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gY29tbWl0IGYyNWY4ZWY3MGNlMiAo
Im52bWUtZmM6IHNob3J0LWNpcmN1aXQgcmVjb25uZWN0IHJldHJpZXMiKQo+Pj4+Pj4+Pj4gYWxs
b3dlZCB0aGUgZmMgdHJhbnNwb3J0IHRvIGhvbm91ciB0aGUgRE5SIGJpdCBkdXJpbmcgcmVjb25u
ZWN0Cj4+Pj4+Pj4+PiByZXRyaWVzLCBhbGxvd2luZyB0byBzcGVlZCB1cCBlcnJvciByZWNvdmVy
eS4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gSG93IGRvZXMgdGhpcyBzcGVlZCB1cCBlcnJvciByZWNvdmVy
eT8KPj4+Pj4+Pgo+Pj4+Pj4+IFdlbGwsIG5vdCBleGFjdGx5IGVycm9yIHJlY292ZXJ5IChhcyB0
aGVyZSBpcyBub3RoaW5nIHRvIHJlY292ZXIpLgo+Pj4+Pj4+IEJ1dCB3ZSB3b24ndCBhdHRlbXB0
IHBvaW50bGVzcyByZXRyaWVzLCB0aGVyZWJ5IHJlZHVjaW5nIHRoZSAKPj4+Pj4+PiBub2lzZSBp
bgo+Pj4+Pj4+IHRoZSBtZXNzYWdlIGxvZy4KPj4+Pj4+IFRoaXMgY29uZmxpY3Qgd2l0aCB0aGUg
dGNwIGFuZCByZG1hIHRhcmdldC4KPj4+Pj4+IFlvdSBtYXkgbmVlZCB0byBkZWxldGUgdGhlIGlt
cHJvcGVyIE5WTUVfU0NfRE5SIGF0IHRoZSB0YXJnZXQuCj4+Pj4+PiBIb3dldmVyLCB0aGlzIHdp
bGwgY2F1c2UgY29tcGF0aWJpbGl0eSBpc3N1ZXMgYmV0d2VlbiBkaWZmZXJlbnQgCj4+Pj4+PiB2
ZXJzaW9ucy4KPj4+Pj4KPj4+Pj4gV2hpY2ggb25lcz8KPj4+PiBJbiBtYW55IHNjZW5hcmlvcywg
dGhlIGRlc3RpbmF0aW9uIHNldHMgRE5SIGZvciBhYm5vcm1hbCBwYWNrZXRzLAo+Pj4+IGJ1dCBl
YWNoIG5ldyBjb25uZWN0aW9uIG1heSBub3QgaGF2ZSB0aGUgc2FtZSBlcnJvci4KPj4+Cj4+PiBU
aGlzIHBhdGNoIHNlcmllcyBpcyBvbmx5IGZvciB0aGUgRE5SIGJpdCBzZXQgaW4gcmVzcG9uc2Ug
dG8gdGhlIAo+Pj4gJ2Nvbm5lY3QnIGNvbW1hbmQuCj4+PiBJZiB0aGUgdGFyZ2V0IGlzIG5vdCBh
YmxlIHRvIHByb2Nlc3MgdGhlICdjb25uZWN0JyBjb21tYW5kLCBidXQgbWF5IAo+Pj4gYmUgc28g
aW4gdGhlIGZ1dHVyZSBpdCByZWFsbHkgc2hvdWxkIG5vdCBzZXQgdGhlIEROUiBiaXQuCj4+Pgo+
Pj4+PiBJIGNoZWNrZWQgdGhlIEROUiB1c2FnZSBpbiB0aGUgdGFyZ2V0IGNvZGUsIGFuZCB0aGV5
IHNlZW0gdG8gc2V0IGl0Cj4+Pj4+IGNvcnJlY3RseSAoaWUgdGhlIHJlc3VsdCB3b3VsZCBub3Qg
Y2hhbmdlIHdoZW4gdGhlIGNvbW1hbmQgaXMgCj4+Pj4+IHJldHJpZWQpLgo+Pj4+PiBXaXRoIHRo
ZSBwb3NzaWJsZSBleGNlcHRpb24gb2YgRU5PU1BDIGhhbmRsaW5nLCBhcyB0aGlzIGlzIGFyZ3Vh
Ymx5Cj4+Pj4+IGR5bmFtaWMgYW5kIG1pZ2h0IGNoYW5nZSB3aXRoIGEgcmV0cnkuCj4+Pj4gVGhl
IEROUiBzdGF0dXMgb2YgdGhlIG9sZCBjb25uZWN0aW9uIG1heSBub3QgYmUgcmVsZXZhbnQgdG8g
dGhlIAo+Pj4+IHJlLWVzdGFibGlzaGVkIGNvbm5lY3Rpb24uCj4+Pgo+Pj4gU2VlIGFib3ZlLgo+
Pj4gV2UgYXJlIGp1c3QgY2hlY2tpbmcgdGhlIEROUiBzZXR0aW5ncyBmb3IgdGhlICdjb25uZWN0
JyBjb21tYW5kIChvciAKPj4+IGFueSBvdGhlciBjb21tYW5kcyBiZWluZyBzZW50IGR1cmluZyBp
bml0aWFsIGNvbnRyb2xsZXIgY29uZmlndXJhdGlvbikuCj4+PiBJZiB0aGF0IGZhaWxzIHRoZSBj
b25uZWN0IG5ldmVyIHdhcyBwcm9wZXJseSBpbml0aWFsaXplZDsgaWYgdGhlIAo+Pj4gY29udHJv
bGxlciB3b3VsZCByZXR1cm4gYSBkaWZmZXJlbnQgc3RhdHVzIGFmdGVyIHJlY29ubmVjdCBpdCBz
aW1wbHkgCj4+PiBzaG91bGQgbm90IHNldCB0aGUgRE5SIGJpdCAuLi4KPj4+Cj4+PiBDaGVlcnMs
Cj4+Pgo+Pj4gSGFubmVzCj4+Cj4+IEFncmVlZC4gU2luY2UgMS4zIHNwZWMgc2F5czogIklmIHNl
dCB0byDigJgx4oCZLCBpbmRpY2F0ZXMgdGhhdCBpZiB0aGUgCj4+IHNhbWUgY29tbWFuZCBpcyBy
ZS1zdWJtaXR0ZWQgdG8gYW55IGNvbnRyb2xsZXIgaW4gdGhlIE5WTSBzdWJzeXN0ZW0sIAo+PiB0
aGVuIHRoYXQgcmUtc3VibWl0dGVkIGNvbW1hbmQgaXMgZXhwZWN0ZWQgdG8gZmFpbC4iCj4gQWNj
b3JkaW5nIHRvIHRoZSBkZWZpbml0aW9uIG9mIHRoZSBwcm90b2NvbCwgdGhpcyBpcyBub3Qgc3Ry
aWN0bHkgCj4gaW1wbGVtZW50ZWQgb24gdGhlIHRhcmdldCBzaWRlLgo+IEluIG52bWUvdGFyZ2V0
LCB0aGVyZSBhcmUgbWFueSBleHRlcm5hbCBlcnJvcnMsIHRoZSBETlIgaXMgc2V0IHRvIDEuCj4g
Rm9yIGV4YW1wbGUsIGFib3JtYWwgZmFicmljcyBjbWQuCgpZZXM7IGJ1dCBhbiBhYm5vcm1hbCBm
YWJyaWNzIGNtZCB3aWxsIGJlIGFibm9ybWFsIGV2ZW4gYWZ0ZXIgYSByZWNvbm5lY3QuCgo+Pgo+
PiBUaHVzIGlmIHRoZSBpbml0aWFsIGNvbm5lY3QgZmFpbHMgaW4gdGhpcyBtYW5uZXIsIGFueSBu
ZXcgYXNzb2NpYXRpb24gCj4+IHdpbGwgYmUgb24gYSBkaWZmZXJlbnQgY29udHJvbGxlciwgd2hl
cmUgaXQgaXMgbm93IGV4cGVjdGVkIGNvbm5lY3Qgb24gCj4+IHRoYXQgY29udHJvbGxlciB3aWxs
IGZhaWwgdG9vLsKgIFRodXMgLSB3aHkgY29udGludWUgdG8gY29ubmVjdCB3aGVuIAo+PiBpdCdz
IGV4cGVjdGVkIGVhY2ggd2lsbCBmYWlsLgo+IEFncmVlLgo+IFdlIHNob3VsZCBub3QgYXR0ZW1w
dCB0byByZS1lc3RhYmxpc2ggdGhlIGNvbm5lY3Rpb24gaWYgdGFyZ2V0IGNhbiBub3QgCj4gd29y
ayBkdWUgdG8gdGFyZ2V0IGlubmVyIGVycm9yIC4KPiBIb3dldmVyLCBub3fCoCB0YXJnZXQgZG9l
cyBub3QgYmVoYXZlIGV4YWN0bHkgbGlrZSB0aGlzLCBzbyB0aGVyZSBhcmUgCj4gY29uZmxpY3Rz
IGFuZCBjb21wYXRpYmlsaXR5IGlzc3Vlcy4KCk5vdGU6IHdlIG5ldmVyIHNhaWQgdGhlIHRhcmdl
dCBzaG91bGQgX25vdF8gc2VuZCBhIEROUiBzdGF0ZS4gV2Ugb25seSAKc2FpZCB0aGUgdGFyZ2V0
IHNob3VsZCBvbmx5IHNldCB0aGUgRE5SIGJpdCBpZiBhIHJldHJ5IChldmVuIGFmdGVyIApyZWNv
bm5lY3Qgb3Igb24gYSBkaWZmZXJlbnQgY29udHJvbGxlcikgd2lsbCBub3QgY2hhbmdlIHRoZSBy
ZXN1bHQuCldoaWNoIGZyb20gd2hhdCBJIGNhbiBzZWUgX2lzXyB0aGUgY2FzZSwgc28gSSBkbyBu
b3Qgc2VlIGFueSBpc3N1ZXMgaGVyZS4KClBsZWFzZSBnaXZlIGRldGFpbHMgZm9yIHRoZSBpc3N1
ZXMgeW91IGFyZSBjb25jZXJuZWQgd2l0aC4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5l
cyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBz
dXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VT
RSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJn
CkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5k
w7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
