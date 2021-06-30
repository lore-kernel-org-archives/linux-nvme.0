Return-Path: <SRS0=p1db=LY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4037C11F65
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jun 2021 09:44:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B288616ED
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jun 2021 09:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B288616ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4hf44F+3rSo+KTvrzj8uYvttC53ne6bXMTwZe/8mYfU=; b=2ruYnH6nHVQ7mZtRP7JVYmgUYO
	3jty5Hyhrr+m2oCtN1dPqTjxWgDITEdaUTUD0vzFFsbolLw14EEbGYNxS5XT7e9NPfhncxWhKGQ9H
	JVQkAwkR8GsO4wwaklon8qk8KANsd7IOAWIljwcgQDxuVkVahK8xhtqfHyhDgvKzbKBJduNBLG36g
	vJfoLydkZf4GcdSlP/S02ysE/qw7KXv3nNJrhf/BQ9nqn+m07Hxvj3k4N94LCZmlJFYv/rlZZX/B4
	AyhHUF88a096E7rBUms7A+Zj575jkMZqm/FIdf+GukC7x4Dj5LZ7gnM9AwF3qalcajLgDAhsjLjdk
	sd5SEUug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyWl3-00DWnz-6e; Wed, 30 Jun 2021 09:43:49 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyWkz-00DWmZ-Vp
 for linux-nvme@lists.infradead.org; Wed, 30 Jun 2021 09:43:47 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3065D1FE59;
 Wed, 30 Jun 2021 09:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625046223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=syWhgjUEA3Suq9NaFjFTKKAGY+GrebcNJjzwNFC1W58=;
 b=FYP1W55Q+UbCZnlwzcG0DvU0eogwKiE7Y052FIn0XwjJDTu1BM6tfC3RJOSbQ1njj34OPc
 hGOFztYZUoryR4h9mGXfEmV5Whtk5NT8ya0OZKItWBFKFCB/3pKFFqM9XqguoDzijlLIau
 OJ3uy2uIsiOj7rMExIMNuvt300Bktx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625046223;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=syWhgjUEA3Suq9NaFjFTKKAGY+GrebcNJjzwNFC1W58=;
 b=aQgP1PCWUn6Vad+J9a4c2XI39JglUKNaBjMSjFVVVLBRnZA8Ij7PCz+djbTtJDh9Z1CN9d
 5v3rHjiuH1TfzNDg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 939F111906;
 Wed, 30 Jun 2021 09:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625046223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=syWhgjUEA3Suq9NaFjFTKKAGY+GrebcNJjzwNFC1W58=;
 b=FYP1W55Q+UbCZnlwzcG0DvU0eogwKiE7Y052FIn0XwjJDTu1BM6tfC3RJOSbQ1njj34OPc
 hGOFztYZUoryR4h9mGXfEmV5Whtk5NT8ya0OZKItWBFKFCB/3pKFFqM9XqguoDzijlLIau
 OJ3uy2uIsiOj7rMExIMNuvt300Bktx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625046223;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=syWhgjUEA3Suq9NaFjFTKKAGY+GrebcNJjzwNFC1W58=;
 b=aQgP1PCWUn6Vad+J9a4c2XI39JglUKNaBjMSjFVVVLBRnZA8Ij7PCz+djbTtJDh9Z1CN9d
 5v3rHjiuH1TfzNDg==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id Kr7RIM483GCnbQAALh3uQQ
 (envelope-from <hare@suse.de>); Wed, 30 Jun 2021 09:43:42 +0000
Subject: Re: [PATCH 0/2] blk-mq: fix blk_mq_alloc_request_hctx
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, John Garry <john.garry@huawei.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <5f304121-38ce-034b-2d17-93d136c77fe6@suse.de> <YNwug8n7qGL5uXfo@T590>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c1de513a-5477-9d1d-0ddc-24e9166cc717@suse.de>
Date: Wed, 30 Jun 2021 11:43:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YNwug8n7qGL5uXfo@T590>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210630_024346_207416_C7EABE4A 
X-CRM114-Status: GOOD (  37.19  )
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

T24gNi8zMC8yMSAxMDo0MiBBTSwgTWluZyBMZWkgd3JvdGU6Cj4gT24gV2VkLCBKdW4gMzAsIDIw
MjEgYXQgMTA6MTg6MzdBTSArMDIwMCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+PiBPbiA2LzI5
LzIxIDk6NDkgQU0sIE1pbmcgTGVpIHdyb3RlOgo+Pj4gSGksCj4+Pgo+Pj4gYmxrX21xX2FsbG9j
X3JlcXVlc3RfaGN0eCgpIGlzIHVzZWQgYnkgTlZNZSBmYy9yZG1hL3RjcC9sb29wIHRvIGNvbm5l
Y3QKPj4+IGlvIHF1ZXVlLiBBbHNvIHRoZSBzdyBjdHggaXMgY2hvc2VuIGFzIHRoZSAxc3Qgb25s
aW5lIGNwdSBpbiBoY3R4LT5jcHVtYXNrLgo+Pj4gSG93ZXZlciwgYWxsIGNwdXMgaW4gaGN0eC0+
Y3B1bWFzayBtYXkgYmUgb2ZmbGluZS4KPj4+Cj4+PiBUaGlzIHVzYWdlIG1vZGVsIGlzbid0IHdl
bGwgc3VwcG9ydGVkIGJ5IGJsay1tcSB3aGljaCBzdXBwb3NlcyBhbGxvY2F0b3IgaXMKPj4+IGFs
d2F5cyBkb25lIG9uIG9uZSBvbmxpbmUgQ1BVIGluIGhjdHgtPmNwdW1hc2suIFRoaXMgYXNzdW1w
dGlvbiBpcwo+Pj4gcmVsYXRlZCB3aXRoIG1hbmFnZWQgaXJxLCB3aGljaCBhbHNvIHJlcXVpcmVz
IGJsay1tcSB0byBkcmFpbiBpbmZsaWdodAo+Pj4gcmVxdWVzdCBpbiB0aGlzIGhjdHggd2hlbiB0
aGUgbGFzdCBjcHUgaW4gaGN0eC0+Y3B1bWFzayBpcyBnb2luZyB0bwo+Pj4gb2ZmbGluZS4KPj4+
Cj4+PiBIb3dldmVyLCBOVk1lIGZjL3JkbWEvdGNwL2xvb3AgZG9uJ3QgdXNlIG1hbmFnZWQgaXJx
LCBzbyB3ZSBzaG91bGQgYWxsb3cKPj4+IHRoZW0gdG8gYXNrIGZvciByZXF1ZXN0IGFsbG9jYXRp
b24gd2hlbiB0aGUgc3BlY2lmaWVkIGhjdHggaXMgaW5hY3RpdmUKPj4+IChhbGwgY3B1cyBpbiBo
Y3R4LT5jcHVtYXNrIGFyZSBvZmZsaW5lKS4KPj4+Cj4+PiBGaXggYmxrX21xX2FsbG9jX3JlcXVl
c3RfaGN0eCgpIGJ5IGFkZGluZy9wYXNzaW5nIGZsYWcgb2YKPj4+IEJMS19NUV9GX05PVF9VU0Vf
TUFOQUdFRF9JUlEuCj4+Pgo+Pj4KPj4+IE1pbmcgTGVpICgyKToKPj4+ICAgICBibGstbXE6IG5v
dCBkZWFjdGl2YXRlIGhjdHggaWYgdGhlIGRldmljZSBkb2Vzbid0IHVzZSBtYW5hZ2VkIGlycQo+
Pj4gICAgIG52bWU6IHBhc3MgQkxLX01RX0ZfTk9UX1VTRV9NQU5BR0VEX0lSUSBmb3IgZmMvcmRt
YS90Y3AvbG9vcAo+Pj4KPj4+ICAgIGJsb2NrL2Jsay1tcS5jICAgICAgICAgICAgIHwgNiArKysr
Ky0KPj4+ICAgIGRyaXZlcnMvbnZtZS9ob3N0L2ZjLmMgICAgIHwgMyArKy0KPj4+ICAgIGRyaXZl
cnMvbnZtZS9ob3N0L3JkbWEuYyAgIHwgMyArKy0KPj4+ICAgIGRyaXZlcnMvbnZtZS9ob3N0L3Rj
cC5jICAgIHwgMyArKy0KPj4+ICAgIGRyaXZlcnMvbnZtZS90YXJnZXQvbG9vcC5jIHwgMyArKy0K
Pj4+ICAgIGluY2x1ZGUvbGludXgvYmxrLW1xLmggICAgIHwgMSArCj4+PiAgICA2IGZpbGVzIGNo
YW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gQ2M6IFNhZ2kg
R3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+Cj4+PiBDYzogRGFuaWVsIFdhZ25lciA8ZHdhZ25l
ckBzdXNlLiB0aGVkZT4KPj4+IENjOiBXZW4gWGlvbmcgPHdlbnhpb25nQHVzLmlibS5jb20+Cj4+
PiBDYzogSm9obiBHYXJyeSA8am9obi5nYXJyeUBodWF3ZWkuY29tPgo+Pj4KPj4+Cj4+IEkgaGF2
ZSBteSBtaXNnaXZpbmdzIGFib3V0IHRoaXMgcGF0Y2hzZXQuCj4+IFRvIG15IHVuZGVyc3RhbmRp
bmcsIG9ubHkgQ1BVcyBwcmVzZW50IGluIHRoZSBoY3R4IGNwdW1hc2sgYXJlIGVsaWdpYmxlIHRv
Cj4+IHN1Ym1pdCBJL08gdG8gdGhhdCBoY3R4Lgo+IAo+IEl0IGlzIGp1c3QgdHJ1ZSBmb3IgbWFu
YWdlZCBpcnEsIGFuZCBzaG91bGQgYmUgQ1BVcyBvbmxpbmUuCj4gCj4gSG93ZXZlciwgbm8gc3Vj
aCBjb25zdHJhaW50IGZvciBub24gbWFuYWdlZCBpcnEsIHNpbmNlIGlycSBtYXkgbWlncmF0ZSB0
bwo+IG90aGVyIG9ubGluZSBDUFVzIGlmIGFsbCBDUFVzIGluIGlycSdzIGN1cnJlbnQgYWZmaW5p
dHkgYmVjb21lIG9mZmxpbmUuCj4gCgpCdXQgdGhlcmUgc2hvdWxkbid0IGJlIGFueSBJL08gcGVu
ZGluZyBkdXJpbmcgQ1BVIG9mZmxpbmUgKGNmIApibGtfbXFfaGN0eF9ub3RpZnlfb2ZmbGluZSgp
KSwgc28gbm8gaW50ZXJydXB0cyBzaG91bGQgYmUgdHJpZ2dlcmVkLCAKZWl0aGVyLCBubz8KCj4+
IENvbnNlcXVlbnRseSBpZiBhbGwgY3B1cyBpbiB0aGF0IG1hc2sgYXJlIG9mZmxpbmUsIHdoZXJl
IGlzIHRoZSBwb2ludCBvZgo+PiBldmVuIHRyYW5zbWl0dGluZyBhICdjb25uZWN0JyByZXF1ZXN0
Pwo+IAo+IG52bWVmIHJlcXVpcmVzIHRvIHN1Ym1pdCB0aGUgY29ubmVjdCByZXF1ZXN0IHZpYSBv
bmUgc3BlY2lmaWVkIGhjdHgKPiB3aGljaCBpbmRleCBoYXMgdG8gYmUgc2FtZSB3aXRoIHRoZSBp
byBxdWV1ZSdzIGluZGV4Lgo+IAo+IEFsbW9zdCBhbGwgbnZtZWYgZHJpdmVycyBmYWlsIHRvIHNl
dHVwIGNvbnRyb2xsZXIgaW4gY2FzZSBvZgo+IGNvbm5lY3QgaW8gcXVldWUgZXJyb3IuCj4gCgpB
bmQgSSB3b3VsZCBwcmVmZXIgdG8gZml4IHRoYXQsIG5hbWVseSBhbGxvd2luZyBibGstbXEgdG8g
cnVuIG9uIGEgCnNwYXJzZSBzZXQgb2YgaW8gcXVldWVzLgpUaGUgcmVtYWluaW5nIGlvIHF1ZXVl
cyBjYW4gYmUgY29ubmVjdGVkIG9uY2UgdGhlIGZpcnN0IGNwdSBpbiB0aGUgaGN0eCAKY3B1bWFz
ayBpcyBvbmxpbmVkOyB3ZSBhbHJlYWR5IGhhdmUgYmxrX21xX2hjdHhfbm90aWZ5X29ubGluZSgp
LCB3aGljaCAKY291bGQgZWFzaWx5IGJlIGV4cGFuZGVkIHRvIGNvbm5lY3QgdG8gcmVsZXZhbnQg
SS9PIHF1ZXVlLi4uCgo+IEFsc28gQ1BVIGNhbiBiZWNvbWUgb2ZmbGluZSAmIG9ubGluZSwgZXNw
ZWNpYWxseSBpdCBpcyBkb25lIGluCj4gbG90cyBvZiBzYW5pdHkgdGVzdC4KPiAKClRydWUsIGJ1
dCB0aGVuIGFnYWluIGFsbCBJL08gb24gdGhlIGhjdHggc2hvdWxkIGJlIHF1aWVzY2VkIGR1cmlu
ZyBjcHUgCm9mZmxpbmUuCgo+IFNvIHdlIHNob3VsZCBhbGxvdyB0byBhbGxvY2F0ZSB0aGUgY29u
bmVjdCByZXF1ZXN0IHN1Y2Nlc3NmdWwsIGFuZAo+IHN1Ym1pdCBpdCB0byBkcml2ZXJzIGdpdmVu
IGl0IGlzIGFsbG93ZWQgaW4gdGhpcyB3YXkgZm9yIG5vbi1tYW5hZ2VkCj4gaXJxLgo+IAoKSSdk
IHJhdGhlciBub3QgZG8gdGhpcywgYXMgdGhlICdjb25uZWN0JyBjb21tYW5kIHJ1bnMgb24gdGhl
ICdub3JtYWwnIApJL08gdGFnc2V0LCBhbmQgaGVuY2UgcnVucyBpbnRvIHRoZSByaXNrIG9mIGJl
aW5nIGlzc3VlcyBhZ2FpbnN0IApub24tZXhpc3RpbmcgQ1BVcy4KCj4+IFNob3VsZG4ndCB3ZSBy
YXRoZXIgbW9kaWZ5IHRoZSB0YWdzZXQgdG8gb25seSByZWZlciB0byB0aGUgY3VycmVudCBvbmxp
bmUKPj4gQ1BVcyBfb25seV8sIHRoZXJlYnkgbmV2ZXIgc3VibWl0IGEgY29ubmVjdCByZXF1ZXN0
IGZvciBoY3R4IHdpdGggb25seQo+PiBvZmZsaW5lIENQVXM/Cj4gCj4gVGhlbiB5b3UgbWF5IHNl
dHVwIHZlcnkgbGVzcyBpbyBxdWV1ZXMsIGFuZCBwZXJmb3JtYW5jZSBtYXkgc3VmZmVyIGV2ZW4K
PiB0aG91Z2ggbG90cyBvZiBDUFVzIGJlY29tZSBvbmxpbmUgbGF0ZXIuCj4gOwpPbmx5IGlmIHdl
IHN0YXkgd2l0aCB0aGUgcmVkdWNlZCBudW1iZXIgb2YgSS9PIHF1ZXVlcy4gV2hpY2ggaXMgbm90
IHdoYXQgCkknbSBwcm9wb3Npbmc7IEknZCByYXRoZXIgcHJlZmVyIHRvIGNvbm5lY3QgYW5kIGRp
c2Nvbm5lY3QgcXVldWVzIGZyb20gCnRoZSBjcHUgaG90cGx1ZyBoYW5kbGVyLiBGb3Igc3RhcnRl
cnMgd2UgY291bGQgZXZlbiB0cmlnZ2VyIGEgcmVzZXQgb25jZSAKdGhlIGZpcnN0IGNwdSB3aXRo
aW4gYSBoY3R4IGlzIG9ubGluZWQuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVp
bmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5k
ZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29m
dHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIg
MzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZm
ZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
