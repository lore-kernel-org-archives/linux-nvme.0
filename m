Return-Path: <SRS0=G/Rm=MN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6FFC07E9B
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 06:07:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F4E6101E
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 06:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F4E6101E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:Subject:From:References:Cc:To:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=51Wl+JH/7tgLwXDY5nk/jPUiRPQy8xG+lXYKB/+9rSc=; b=KUNGN9cC4qBvFdtSq7yW2eTts+
	8iJulVwgdgFdibVEmx2Z4MJRUSmd8d+BSPmw2fUekDfBsilVNDqdz+yfigIMvAuak7H/EV6wYaIcQ
	D2mJoi6gs1Ay553G9krQKPy0BXZon9AMrHyOjwEvVAqnMYFuUCSfJnu6+d4tTsoj266qHPCg4p+m4
	FvaNS23j5fqfo10oVkLZbNWX3LpEADgnlCZGf/7P5X2NJm7HZNMjju1bIOx5B02dlCHG5Jhk3j4DG
	CWPqDrQJfPZ25U6jai3ZpcrQqxDLgmGCsuX9ndx6zKyX6x7vVDboJct+JUOzDV7hTfMiYdOYCm+QZ
	gKVs6Eug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m65Nn-00EYff-Tk; Wed, 21 Jul 2021 06:07:03 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m65Nk-00EYf4-Jj
 for linux-nvme@lists.infradead.org; Wed, 21 Jul 2021 06:07:02 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9BBE020309;
 Wed, 21 Jul 2021 06:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626847618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDKjmwZBzuhTX/zXo42Os5PnZWO5pbPwuwZBvd9jOh4=;
 b=XbhmW09AKmdYLULB6qyPFcfQc2B1beut3E6UMGFeLiyNO4xpuPNUVhbhCAe5xD1bbUfur3
 8fRGqrlQ9miQLX/Y2zYwRcXH00Hwo6XLpRepw8BSUWlYs889Bhyk0oS/T2Bl5aHpbu9ZD3
 2/BINIwyQzLsH/Kw0vAwdICNwOjlfM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626847618;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDKjmwZBzuhTX/zXo42Os5PnZWO5pbPwuwZBvd9jOh4=;
 b=FwGkorSMBKo8lHB2XOpELu9ooXOxP32bYCHC7fwdizpWNGcsscnAIqS+lBxbpcUtoAWzmj
 PchIEgHo2xe98WBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A67C133D1;
 Wed, 21 Jul 2021 06:06:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wAOCIYK592CTbAAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 21 Jul 2021 06:06:58 +0000
To: Vladislav Bolkhovitin <vst@vlnb.net>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <66b3b869-02bd-9dee-fadc-8538c6aad57a@vlnb.net>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC PATCH 00/11] nvme: In-band authentication support
Message-ID: <e339e6e7-fc32-2480-ca99-516547105776@suse.de>
Date: Wed, 21 Jul 2021 08:06:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <66b3b869-02bd-9dee-fadc-8538c6aad57a@vlnb.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210720_230700_852494_FD5DE51E 
X-CRM114-Status: GOOD (  34.40  )
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

T24gNy8yMC8yMSAxMDoyNiBQTSwgVmxhZGlzbGF2IEJvbGtob3ZpdGluIHdyb3RlOgo+IEhpLAo+
IAo+IEdyZWF0IHRvIHNlZSB0aG9zZSBwYXRjaGVzIGNvbWluZyEgQWZ0ZXIgc29tZSByZXZpZXcs
IHRoZXkgbG9vayB0byBiZQo+IHZlcnkgd2VsbCBkb25lLiBTb21lIGNvbW1lbnRzL3N1Z2dlc3Rp
b25zIGJlbG93Lgo+IAo+IDEuIEkgc3Ryb25nbHkgcmVjb21tZW5kIHRvIGltcGxlbWVudCBESCBl
eHBvbmVudGlhbHMgcmV1c2UgKGcgeCBtb2QgcCAvCj4gZyB5IG1vZCBwIGFzIHdlbGwgYXMgZyB4
eSBtb2QgcCkgYXMgc3BlY2lmaWVkIGluIHNlY3Rpb24gOC4xMy41LjcKPiAiREgtSE1BQy1DSEFQ
IFNlY3VyaXR5IFJlcXVpcmVtZW50cyIuIFdoZW4gSSB3YXMgd29ya2luZyBvbiBUUCA4MDA2IEkK
PiBoYWQgYSBwcm90b3R5cGUgdGhhdCBkZW1vbnN0cmF0ZWQgdGhhdCBESCBtYXRoIGhhcyBxdWl0
ZSBzaWduaWZpY2FudAo+IGxhdGVuY3ksIHNvbWV0aGluZyBsaWtlIChhcyBmYXIgYXMgSSByZW1l
bWJlcikgMzBtcyBmb3IgNEsgZ3JvdXAgYW5kIGZldwo+IGh1bmRyZWRzIG9mIG1zIGZvciA4SyBn
cm91cC4gRm9yIHNpbmdsZSBjb25uZWN0aW9uIGl0IGlzIG5vdCBhIGJpZyBkZWFsLAo+IGJ1dCBp
bWFnaW5lIEFNRCBFUFlDIHdpdGggMTI4IGNvcmVzLiBTaW5jZSBhbGwgY29ubmVjdGlvbnMgYXJl
IGNyZWF0ZWQKPiBzZXF1ZW50aWFsbHksIGV2ZW4gd2l0aCAzMCBtcyBwZXIgY29ubmVjdGlvbiB0
aW1lIHRvIGNvbXBsZXRlIGZ1bGwKPiByZW1vdGUgZGV2aWNlIGNvbm5lY3Rpb24gd291bGQgYmVj
b21lIDEyOCozMCA9PiBhbG1vc3QgNCBzZWNvbmRzLiBXaXRoCj4gOEsgZ3JvdXAgaXQgbWlnaHQg
YmUgbW9yZSB0aGFuIDEwIHNlY29uZHMuIFVzZXJzIGFyZSB1bmxpa2VseSBnb2luZyB0bwo+IGJl
IGhhcHB5IHdpdGggdGhpcywgZXNwZWNpYWxseSBpbiBjYXNlcywgd2hlbiBjb25uZWN0aW5nIG11
bHRpcGxlIG9mCj4gTlZNZS1vRiBkZXZpY2VzIGlzIGEgcGFydCBvZiBhIHNlcnZlciBvciBWTSBi
b290IHNlcXVlbmNlLgo+IApPaCwgaW5kZWVkLCBJIGNhbiBjb25maXJtIHRoYXQuIEZGREhFIGNh
bGN1bGF0aW9ucyBhcmUgcXVpdGUgdGltZS1jb25zdW1pbmcuCkJ1dCBpbmNpZGVudGFsbHksIEVD
REggYW5kIGN1cnZlMjU1MTkgYXJlIHJlYXNvbmFibHkgZmFzdCwgc28gbWF5YmUKdGhlcmUgX2lz
XyBhIHZhbHVlIGluIGhhdmluZyBhIFRQQVIgYXNraW5nIGZvciB0aGVtIHRvIGJlIHNwZWNpZmll
ZCwgdG9vIC4uLgoKPiBJZiBESCBleHBvbmVudGlhbCByZXVzZSBpbXBsZW1lbnRlZCwgZm9yIGFs
bCBzdWJzZXF1ZW50IGNvbm5lY3Rpb25zIHRoZQo+IERIIG1hdGggaXMgZXhjbHVkZWQsIHNvIGF1
dGhlbnRpY2F0aW9uIG92ZXJoZWFkIGJlY29tZXMgcHJldHR5IG11Y2gKPiBuZWdsaWdpYmxlLgo+
IAo+IEluIG15IHByb3RvdHlwZSBJIGltcGxlbWVudGVkIERIIGV4cG9uZW50aWFsIHJldXNlIGFz
IGEgc2ltcGxlCj4gcGVyLWhvc3QvdGFyZ2V0IGNhY2hlIHRoYXQga2VlcHMgREggZXhwb25lbnRp
YWxzIChpbmNsdWRpbmcgZyB4eSBtb2QgcCkKPiBmb3IgdXAgdG8gMTAgc2Vjb25kcy4gU2ltcGxl
IGFuZCBzdWZmaWNpZW50Lgo+IAoKRnJhbmtseSwgSSBoYWRuJ3QgbG9va2VkIGF0IGV4cG9uZW50
aWFsIHJldXNlOyB0aGlzIGltcGxlbWVudGF0aW9uCnJlYWxseSBpcyBqdXN0IGEgZmlyc3Qgc3Rl
cCB0byBnZXQgZmVlZGJhY2sgZnJvbSBwZW9wbGUgaWYgdGhpcyBpcyBhCmRpcmVjdGlvbiB0aGV5
IHdhbnQgdG8gZ28uCgo+IEFub3RoZXIsIG1pZ2h0IGJlIGV2ZXIgbW9yZSBzaWduaWZpY2FudCBy
ZWFzb24gd2h5IERIIGV4cG9uZW50aWFsIHJldXNlCj4gaXMgaW1wb3J0YW50IGlzIHRoYXQgd2l0
aG91dCBpdCB4IChvciB5IG9uIHRoZSBob3N0IHNpZGUpIG11c3QgYWx3YXlzIGJlCj4gcmFuZG9t
bHkgZ2VuZXJhdGVkIGVhY2ggdGltZSBhIG5ldyBjb25uZWN0aW9uIGlzIGVzdGFibGlzaGVkLiBX
aGljaAo+IG1lYW5zLCBmb3IgaW5zdGFuY2UsIGZvciA4SyBncm91cHMgZm9yIGVhY2ggY29ubmVj
dGlvbiAxS0Igb2YgcmFuZG9tCj4gYnl0ZXMgbXVzdCBiZSB0YWtlbiBmcm9tIHRoZSByYW5kb20g
cG9vbC4gV2l0aCAxMjggY29ubmVjdGlvbnMgaXQgaXMgbm93Cj4gMTI4S0IuIFF1aXRlIGEgYmln
IHByZXNzdXJlIG9uIHRoZSByYW5kb20gcG9vbCB0aGF0IERIIGV4cG9uZW50aWFsIHJldXNlCj4g
bW9zdGx5IGF2b2lkcy4KPiAKPiBUaG9zZSBhcmUgdGhlIDIgcmVhc29ucyB3aHkgd2UgYWRkZWQg
dGhpcyBESCBleHBvbmVudGlhbCByZXVzZSBzZW50ZW5jZQo+IGluIHRoZSBzcGVjLiBJbiB0aGUg
b3JpZ2luYWwgVFAgODAwNiB0aGVyZSB3YXMgYSBzbWFsbCBpbmZvcm1hdGl2ZSBwaWVjZQo+IGV4
cGxhaW5pbmcgcmVhc29uaW5ncyBiZWhpbmQgdGhhdCwgYnV0IGZvciBzb21lIHJlYXNvbnMgaXQg
d2FzIHJlbW92ZWQKPiBmcm9tIHRoZSBmaW5hbCB2ZXJzaW9uLgo+IAoKVGhhbmtzIGZvciB0aGUg
aGludC4gSSdsbCBiZSBhZGRpbmcgZXhwb25lbnRpYWwgcmV1c2UgdG8gdGhlIGNvZGUuCgo+IDIu
IFdoYXQgaXMgdGhlIHN0YXR1cyBvZiB0aGlzIGNvZGUgZnJvbSBwZXJzcGVjdGl2ZSBvZiBzdGFi
aWxpdHkgaW4gZmFjZQo+IG9mIG1hbGljaW91cyBob3N0IGJlaGF2aW9yPyBTZWVtcyBpbXBsZW1l
bnRhdGlvbiBpcyBjYXJlZnVsbHkgZG9uZSwgYnV0LAo+IGZvciBpbnN0YW5jZSwgYXQgdGhlIGZp
cnN0IGxvb2sgSSB3YXMgbm90IGFibGUgdG8gZmluZCBhIGNvZGUgdG8gY2xlYW4KPiB1cCBpZiBo
b3N0IGluIG5vdCBhY3RpbmcgZm9yIHRvbyBsb25nIGluIHRoZSBtaWRkbGUgb2YgZXhjaGFuZ2Uu
IE90aGVyCj4gb2JzZXJ2YXRpb24gaXMgdGhhdCBpbiBudm1ldF9leGVjdXRlX2F1dGhfc2VuZCgp
Cj4gbnZtZXRfY2hlY2tfdHJhbnNmZXJfbGVuKCkgZG9lcyBub3QgY2hlY2sgaWYgdGwgc2l6ZSBp
cyByZWFzb25hYmxlLAo+IGkuZS4sIGZvciBpbnN0YW5jZSwgbm90IDFHQi4KPiAKClRoYXQgaXMg
dHJ1ZTsgZXhjaGFuZ2UgdGltZW91dHMgYXJlIG1pc3NpbmcuIFdpbGwgYmUgYWRkaW5nIHRoZW0s
IG9mCmNvdXJzZS4gQW5kIGhhdmVuJ3QgdGhvdWdodCBvZiBjaGVja2luZyBmb3IgdGwgc2l6ZSBv
dmVyZmxvd3M7IHdpbGwgYmUKYWRkaW5nIHRoZW0sIHRvby4KCj4gRm9yIHN1cmUsIHdlIGRvbid0
IHdhbnQgdG8gYWxsb3cgcmVtb3RlIGhvc3RzIHRvIGhhbmcgb3IgY3Jhc2ggdGFyZ2V0Lgo+IEZv
ciBpbnN0YW5jZSwgYmVjYXVzZSBvZiBPT00gY29uZGl0aW9ucyB0aGF0IGhhcHBlbmVkLCBiZWNh
dXNlIG1hbGljaW91cwo+IGhvc3QgYXNrZWQgdGFyZ2V0IHRvIGFsbG9jYXRlIHRvbyBtdWNoIG1l
bW9yeSBvciBvcGVuIHRvIG1hbnkgYmVpbmcKPiBhdXRoZW50aWNhdGVkIGNvbm5lY3Rpb25zIGlu
IHdoaWNoIHRoZSBob3N0IGlzIG5vdCBnb2luZyB0byByZXBseSBpbiB0aGUKPiBtaWRkbGUgb2Yg
ZXhjaGFuZ2UuCj4gClRoaXMgaXMgc29tZXRoaW5nIEknbGwgbmVlZCB0byBsb29rIGF0LCBhbnl3
YXkuIFdoYXQgd2UgZG8gbm90IHdhbnQgaXMgYQp1c2Vyc3BhY2UgYXBwbGljYXRpb24gY2hpcHBp
bmcgaW4gYW5kIHNlbmQgYSAnbmVnb3RpYXRlJyBjb21tYW5kIHdpdGhvdXQKYW55IHN1YnNlcXVl
bnQgc3RlcHMsIHRoZXJlYnkgaW52YWxpZGF0aW5nIHRoZSBleGlzdGluZyBhdXRoZW50aWNhdGlv
bi4KCj4gQXNraW5nLCBiZWNhdXNlIGRvbid0IHdhbnQgdG8gZ28gaW4gbXkgcmV2aWV3IHRvbyBm
YXIgYWhlYWQgZnJvbSB0aGUKPiBhdXRob3IgOykKPiAKPiBJbiB0aGlzIHJlZ2FyZCwgaXQgd291
bGQgYmUgZ3JlYXQgaWYgeW91IGFkZCBpbiB5b3VyIHRlc3QgYXBwbGljYXRpb24KPiBhYmlsaXR5
IHRvIHBlcmZvcm0gYXV0aGVudGljYXRpb24gd2l0aCByYW5kb20gcGFyYW1ldGVycyBhbmQgcmFu
ZG9tbHkKPiBzdG9wIHJlc3BvbmRpbmcuIE92ZXJuaWdodCBydW5uaW5nIG9mIHN1Y2ggdGVzdCB3
b3VsZCBnaXZlIHVzIGdvb2QKPiBkZWdyZWUgb2YgY29uZmlkZW5jZSB0aGF0IGl0IHdpbGwgYWx3
YXlzIHdvcmsgYXMgZXhwZWN0ZWQuCj4gCgpUaGF0IGluZGVlZCB3b3VsZCBiZSBnb29kOyBsZXQg
bWUgdGhpbmsgb24gaG93IHNvbWV0aGluZyBsaWtlIHRoYXQgY2FuCmJlIGltcGxlbWVudGVkLgoK
Q2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgICAgIEtlcm5l
bCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAgICAgICArNDkg
OTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIE1heGZl
bGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBG
ZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LW52bWUK
