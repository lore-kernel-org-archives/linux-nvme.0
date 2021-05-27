Return-Path: <SRS0=/NUg=KW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023A5C4707F
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 07:42:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3D8060FF0
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 07:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D8060FF0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:Subject:From:References:Cc:To:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=jjiA8lird/2aESapvHRjlr5aRy+/V3Ni0gRH0O8gewM=; b=xdjPSsJL6zfXkG2SU/5TVr52sZ
	GtjuRygGGnHVHQ8+hfXhDAFiXaVYW2h13ewI4B3Zi2SzjCvGceNr2qkx1L/mhyEFmKkHhwEbh+bCM
	cRsGUsCcm6/TpAcgz+H8fkuEHwwcFh95k8IDQ9zX/V9CCBz+jRuU9al2hNuKaZyZZM1xnXGw0ck+g
	6RFVVqI+zX8nwtBuwKCVByiAaZEEHVtTy8yjzYddTjv0e2Ergq87Ygc/GUgTEBykTF9ycCBtoYLlt
	zRqun6dr08eWnl5vfbCn4RPKMbN97u075Xy40RrzTmnEZqTmufre21CUtiHl+Z5duiWS9XN+5c+wH
	9kOJ5SHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmAeU-003SAJ-6C; Thu, 27 May 2021 07:41:58 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmAeQ-003S7o-K0
 for linux-nvme@lists.infradead.org; Thu, 27 May 2021 07:41:56 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B39AF218DD;
 Thu, 27 May 2021 07:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622101311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ttE23UWAFNVZ79voJwxcR9BZTIr+cGS5rkk0rMZAv4=;
 b=G37Rd2Tl9nmQmo/aSnHsfaxoVuJG1gpZDW/+7zIsNaJD73F6mKMwY8BAWS3atZSFjRq9U1
 q0cqkNLwbfrheSF3otx/7lWDVPtkHs+puLD3YmTciEnKDhgay24iVTl7wdjjIec7JAS0dt
 ThHonE2EnIdnEWo5Qpy4Va4BiYj4uyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622101311;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ttE23UWAFNVZ79voJwxcR9BZTIr+cGS5rkk0rMZAv4=;
 b=0aHPCyCS6WhEkAtclxXHAn4zgLcfsCll1qrl0BdnA057x2WxMF3dvQY6Nfq4MbQnpuLevZ
 L/2M2m9lLskm1GCQ==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
 by imap.suse.de (Postfix) with ESMTPSA id 965C711A98;
 Thu, 27 May 2021 07:41:51 +0000 (UTC)
To: Keith Busch <kbusch@kernel.org>, Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <YJlzwcADaxO/JHRE@casper.infradead.org>
 <YJ636tQhuc9X7ZzR@casper.infradead.org>
 <20210526210742.GA3706388@dhcp-10-100-145-180.wdc.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Subject: Re: [LSF/MM/BPF TOPIC] Memory folios
Message-ID: <97698689-0a18-81e0-a0ff-b4f92e56be5b@suse.de>
Date: Thu, 27 May 2021 09:41:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210526210742.GA3706388@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_004154_843180_0155D820 
X-CRM114-Status: GOOD (  29.69  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNS8yNi8yMSAxMTowNyBQTSwgS2VpdGggQnVzY2ggd3JvdGU6Cj4gT24gRnJpLCBNYXkgMTQs
IDIwMjEgYXQgMDY6NDg6MjZQTSArMDEwMCwgTWF0dGhldyBXaWxjb3ggd3JvdGU6Cj4+IE9uIE1v
biwgTWF5IDEwLCAyMDIxIGF0IDA2OjU2OjE3UE0gKzAxMDAsIE1hdHRoZXcgV2lsY294IHdyb3Rl
Ogo+Pj4gSSBkb24ndCBrbm93IGV4YWN0bHkgaG93IG11Y2ggd2lsbCBiZSBsZWZ0IHRvIGRpc2N1
c3MgYWJvdXQgc3VwcG9ydGluZwo+Pj4gbGFyZ2VyIG1lbW9yeSBhbGxvY2F0aW9uIHVuaXRzIGlu
IHRoZSBwYWdlIGNhY2hlIGJ5IERlY2VtYmVyLiAgSW4gbXkKPj4+IGlkZWFsIHdvcmxkLCBhbGwg
dGhlIHBhdGNoZXMgSSd2ZSBzdWJtaXR0ZWQgc28gZmFyIGFyZSBhY2NlcHRlZCwgSQo+Pj4gcGVy
c3VhZGUgZXZlcnkgZmlsZXN5c3RlbSBtYWludGFpbmVyIHRvIGNvbnZlcnQgdGhlaXIgb3duIGZp
bGVzeXN0ZW0KPj4+IGFuZCBzdHJ1Y3QgcGFnZSBpcyBub3RoaW5nIGJ1dCBhIGJhZCBtZW1vcnkg
YnkgRGVjZW1iZXIuICBJbiByZWFsaXR5LAo+Pj4gSSdtIGp1c3Qgbm90IHRoYXQgcGVyc3Vhc2l2
ZS4KPj4+Cj4+PiBTbywgcHJvYmFibHkgc29tZSBraW5kIG9mIGRpc2N1c3Npb24gd2lsbCBiZSB3
b3J0aHdoaWxlIGFib3V0Cj4+PiBjb252ZXJ0aW5nIHRoZSByZW1haW5pbmcgZmlsZXN5c3RlbXMg
dG8gdXNlIGZvbGlvcywgd2hlbiBpdCdzIHdvcnRoCj4+PiBoYXZpbmcgZmlsZXN5c3RlbXMgb3B0
LWluIHRvIG11bHRpLXBhZ2UgZm9saW9zLCB3aGF0IHdlIGNhbiBkbyBhYm91dAo+Pj4gYnVmZmVy
LWhlYWQgYmFzZWQgZmlsZXN5c3RlbXMsIGFuZCBzbyBvbi4KPj4+Cj4+PiBIb3BlZnVsbHkgd2Ug
YXJlbid0IHN0aWxsIGRpc2N1c3Npbmcgd2hldGhlciBmb2xpb3MgYXJlIGEgZ29vZCBpZGVhCj4+
PiBvciBub3QgYnkgdGhlbi4KPj4KPj4gSSBnb3QgYW4gZW1haWwgZnJvbSBIYW5uZXMgdG9kYXkg
YXNraW5nIGFib3V0IG1lbW9yeSBmb2xpb3MgYXMgdGhleQo+PiBwZXJ0YWluIHRvIHRoZSBibG9j
ayBsYXllciwgYW5kIEkgdGhvdWdodCB0aGlzIHdvdWxkIGJlIGEgZ29vZCBjaGFuY2UKPj4gdG8g
dGFsayBhYm91dCB0aGVtLiAgSWYgeW91J3JlIG5vdCBmYW1pbGlhciB3aXRoIHRoZSB0ZXJtICJm
b2xpbyIsCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMTA1MDUxNTA2MjguMTEx
NzM1LTEwLXdpbGx5QGluZnJhZGVhZC5vcmcvCj4+IGlzIG5vdCBhIGJhZCBpbnRyb2R1Y3Rpb24u
Cj4+Cj4+IFRoYW5rcyB0byB0aGUgd29yayBkb25lIGJ5IE1pbmcgTGVpIGluIDIwMTcsIHRoZSBi
bG9jayBsYXllciBhbHJlYWR5Cj4+IHN1cHBvcnRzIG11bHRpcGFnZSBidmVjcywgc28gdG8gYSBm
aXJzdCBvcmRlciBvZiBhcHByb3hpbWF0aW9uLCBJIGRvbid0Cj4+IG5lZWQgYW55dGhpbmcgZnJv
bSB0aGUgYmxvY2sgbGF5ZXIgb24gZG93biB0aHJvdWdoIHRoZSB2YXJpb3VzIHN0b3JhZ2UKPj4g
bGF5ZXJzLiAgV2hpY2ggaXMgd2h5IEkgaGF2ZW4ndCBiZWVuIHRhbGtpbmcgdG8gYW55b25lIGlu
IHN0b3JhZ2UhCj4+Cj4+IEl0IG1pZ2h0IGNoYW5nZSAoc2xpZ2h0bHkpIHRoZSBjb250ZW50cyBv
ZiBiaW9zLiAgRm9yIGV4YW1wbGUsCj4+IGJ2ZWNbbl0tPmJ2X29mZnNldCBtaWdodCBub3cgYmUg
bGFyZ2VyIHRoYW4gUEFHRV9TSVpFLiAgRHJpdmVycyBzaG91bGQKPj4gaGFuZGxlIHRoaXMgT0ss
IGJ1dCBwcm9iYWJseSBoYXZlbid0IGJlZW4gYXVkaXRlZCB0byBtYWtlIHN1cmUgdGhleSBkby4K
Pj4gTW9zdGx5LCBpdCdzIHNpbXBseSB0aGF0IGRyaXZlcnMgd2lsbCBub3cgc2VlIGZld2VyLCBs
YXJnZXIsIHNlZ21lbnRzCj4+IGluIHRoZWlyIGJpb3MuICBPbmNlIGEgZmlsZXN5c3RlbSBzdXBw
b3J0cyBtdWx0aXBhZ2UgZm9saW9zLCB3ZSB3aWxsCj4+IGFsbG9jYXRlIG9yZGVyLU4gcGFnZXMg
YXMgcGFydCBvZiByZWFkYWhlYWQgKGFuZCBzdWZmaWNpZW50bHkgbGFyZ2UKPj4gd3JpdGVzKS4g
IERpcnRpbmVzcyBpcyB0cmFja2VkIG9uIGEgcGVyLWZvbGlvIGJhc2lzIChub3QgcGVyIHBhZ2Up
LAo+PiBzbyBmb2xpb3MgdGFrZSB0cmlwcyBhcm91bmQgdGhlIExSVSBhcyBhIHNpbmdsZSB1bml0
IGFuZCBmaW5hbGx5IG1ha2UKPj4gaXQgdG8gYmVpbmcgd3JpdHRlbiBiYWNrIGFzIGEgc2luZ2xl
IHVuaXQuCj4+Cj4+IERyaXZlcnMgc3RpbGwgbmVlZCB0byBjb3BlIHdpdGggc3ViLWZvbGlvLXNp
emVkIHJlYWRzIGFuZCB3cml0ZXMuCj4+IE9fRElSRUNUIHN0aWxsIGV4aXN0cyBhbmQgKGVnKSBk
b2luZyBhIHN1Yi1wYWdlLCBibG9jay1hbGlnbmVkIHdyaXRlCj4+IHdpbGwgbm90IG5lY2Vzc2Fy
aWx5IGNhdXNlIHJlYWRhcm91bmQgdG8gaGFwcGVuLiAgRmlsZXN5c3RlbXMgbWF5IHJlYWQKPj4g
YW5kIHdyaXRlIHRoZWlyIG93biBtZXRhZGF0YSBhdCB3aGF0ZXZlciBncmFudWxhcml0eSBhbmQg
YWxpZ25tZW50IHRoZXkKPj4gc2VlIGZpdC4gIEJ1dCB0aGUgdmFzdCBtYWpvcml0eSBvZiBwYWdl
Y2FjaGUgSS9PIHdpbGwgYmUgZm9saW8tc2l6ZWQKPj4gYW5kIGZvbGlvLWFsaWduZWQuCj4+Cj4+
IEkgZG8gaGF2ZSB0d28gc21hbGwgcGF0Y2hlcyB3aGljaCBtYWtlIGl0IGVhc2llciBmb3IgdGhl
IG9uZQo+PiBmaWxlc3lzdGVtIHRoYXQgSSd2ZSBjb252ZXJ0ZWQgc28gZmFyIChpb21hcC94ZnMp
IHRvIGFkZCBmb2xpb3MgdG8gYmlvcwo+PiBhbmQgZ2V0IGZvbGlvcyBiYWNrIG91dCBvZiBiaW9z
Ogo+Pgo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjEwNTA1MTUwNjI4LjExMTcz
NS03Mi13aWxseUBpbmZyYWRlYWQub3JnLwo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21s
LzIwMjEwNTA1MTUwNjI4LjExMTczNS03My13aWxseUBpbmZyYWRlYWQub3JnLwo+Pgo+PiBhcyB3
ZWxsIGFzIGEgdGhpcmQgcGF0Y2ggdGhhdCBlc3RpbWF0ZXMgaG93IGxhcmdlIGEgYmlvIHRvIGFs
bG9jYXRlLAo+PiBnaXZlbiB0aGUgY3VycmVudCBmb2xpbyB0aGF0IGl0J3Mgd29ya2luZyBvbjoK
Pj4gaHR0cHM6Ly9naXQuaW5mcmFkZWFkLm9yZy91c2Vycy93aWxseS9wYWdlY2FjaGUuZ2l0L2Nv
bW1pdGRpZmYvODk1NDFiMTI2YTU5ZGM3MzE5YWQ2MTg3NjdlMmQ4ODBmY2FkZDZjMgo+Pgo+PiBJ
dCB3b3VsZCBiZSBwb3NzaWJsZSB0byBtYWtlIG90aGVyIGNoYW5nZXMgaW4gZnV0dXJlLiAgRm9y
IGV4YW1wbGUsIGlmCj4+IHdlIGRlY2lkZSBpdCdkIGJlIGJldHRlciwgd2UgY291bGQgY2hhbmdl
IGJ2ZWNzIGZyb20gYmVpbmcgKHBhZ2UsIG9mZnNldCwKPj4gbGVuZ3RoKSB0byAoZm9saW8sIG9m
ZnNldCwgbGVuZ3RoKS4gIEkgZG9uJ3Qga25vdyB0aGF0IGl0J3Mgd29ydGggZG9pbmc7Cj4+IGl0
IHdvdWxkIG5lZWQgdG8gYmUgZXZhbHVhdGVkIG9uIGl0cyBtZXJpdHMuICBQZXJzb25hbGx5LCBJ
J2QgcmF0aGVyCj4+IHNlZSB1cyBtb3ZlIHRvIGEgKHBoeXNfYWRkciwgbGVuZ3RoKSBwYWlyLCBi
dXQgSSdtIGEgbGl0dGxlIGJ1c3kgYXQgdGhlCj4+IG1vbWVudC4KPj4KPj4gSGFubmVzIGhhcyBz
b21lIGZ1biBpZGVhcyBhYm91dCB1c2luZyB0aGUgZm9saW8gd29yayB0byBzdXBwb3J0IGxhcmdl
cgo+PiBzZWN0b3Igc2l6ZXMsIGFuZCBJIHRoaW5rIHRoZXkncmUgZG9hYmxlLgo+IAo+IEknbSBh
bHNvIGludGVyZXN0ZWQgaW4gdGhpcywgYW5kIHdhcyBsb29raW5nIGludG8gdGhlIGV4YWN0IHNh
bWUgdGhpbmcKPiByZWNlbnRseS4gU29tZSBvZiB0aGUgdmVyeSBoaWdoIGNhcGFjaXR5IFNTRHMg
dGhhdCBjYW4gcmVhbGx5IGJlbmVmaXQKPiBmcm9tIGJldHRlciBsYXJnZSBzZWN0b3Igc3VwcG9y
dC4gSWYgdGhpcyBpcyBhIHRvcGljIGZvciB0aGUgY29uZmVyZW5jZSwKPiBJIHdvdWxkIGxpa2Ug
dG8gYXR0ZW5kIHRoaXMgc2Vzc2lvbi4KPiAKQW5kLCBvZiBjb3Vyc2UsIHNvIHdvdWxkIEkgOi0p
CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UJCSAgICAgICAgS2VybmVs
IFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZQkJCSAgICAgICAgICAgICAgICs0OSA5MTEg
NzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSCwgOTA0MDkgTsO8
cm5iZXJnCkdGOiBGLiBJbWVuZMO2cmZmZXIsIEhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBt
YWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
