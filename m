Return-Path: <SRS0=YlYz=BJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCD4C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2020 01:50:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF7C72074B
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2020 01:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PHS/yQ5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7C72074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=htjsxw5G9C6WVQy2isSLIkv4FQ5jTvbulnSAcyVXymo=; b=PHS/yQ5oLsQbkkDE5LYU5ZiAO
	3NriZSAjLp3QO8JuFSu4fq6wrkwIcke/8u1Bj11Wa0Wn0mvVKdKUT8BLe5IFkUrwLKMq4kWW4Q1/t
	OMWauDzvD6CO1E50c5zy1ZB8UnjLoadJka9ToNxl3dFPTNRWAa90kTQ5YIQE7K1CR0X8ZwnTGiXD/
	UCDakP9Mh3zbQ5GpNLeyE1XlOLxIwYh2dlvjTKyrtwUfFX34s88CzXTv9hqw5Y/20JwiEQW2Y1Mvp
	tBZs0NhOfmw3Bfs/t8LNrGUcL5AA/rSkSi9jYyueQk18fg4Cpi806SiHIovNBETruCxcT2Z6EO/TS
	wm4jTarMQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0xiB-0004yZ-8z; Thu, 30 Jul 2020 01:50:23 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0xhv-0004ja-96
 for linux-nvme@lists.infradead.org; Thu, 30 Jul 2020 01:50:17 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 6EA78E437306F9660194;
 Thu, 30 Jul 2020 09:49:53 +0800 (CST)
Received: from [10.27.125.30] (10.27.125.30) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0;
 Thu, 30 Jul 2020 09:49:48 +0800
Subject: Re: [PATCH] nvme-core: fix io interrupt when work with dm-multipah
To: Christoph Hellwig <hch@lst.de>
References: <20200727055818.21430-1-lengchao@huawei.com>
 <20200728111956.GA31546@lst.de>
 <6df01884-5498-0809-b358-0c9f7d775a73@huawei.com>
 <20200729055903.GC31113@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <43e5dee8-1a91-4d8b-fdb5-91f9679ddeb3@huawei.com>
Date: Thu, 30 Jul 2020 09:49:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200729055903.GC31113@lst.de>
Content-Language: en-US
X-Originating-IP: [10.27.125.30]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200729_215007_627592_7F617D69 
X-CRM114-Status: GOOD (  22.41  )
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
Cc: kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, John.Meneghini@netapp.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIwLzcvMjkgMTM6NTksIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IE9uIFdlZCwg
SnVsIDI5LCAyMDIwIGF0IDEwOjU0OjI5QU0gKzA4MDAsIENoYW8gTGVuZyB3cm90ZToKPj4KPj4K
Pj4gT24gMjAyMC83LzI4IDE5OjE5LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4+IE9uIE1v
biwgSnVsIDI3LCAyMDIwIGF0IDAxOjU4OjE4UE0gKzA4MDAsIENoYW8gTGVuZyB3cm90ZToKPj4+
PiBUaGUgcHJvdG9jb2wgTlZNLUV4cHJlc3MtMS40IGRlZmluZToKPj4+PiBDb21tYW5kIEludGVy
cnVwdGVkOiBDb21tYW5kIHByb2Nlc3Npbmcgd2FzIGludGVycnVwdGVkIGFuZCB0aGUKPj4+PiBj
b250cm9sbGVyIGlzIHVuYWJsZSB0byBzdWNjZXNzZnVsbHkgY29tcGxldGUgdGhlIGNvbW1hbmQu
IFRoZSBob3N0Cj4+Pj4gc2hvdWxkIHJldHJ5IHRoZSBjb21tYW5kLiBJZiB0aGlzIHN0YXR1cyBj
b2RlIGlzIHJldHVybmVkLCB0aGVuCj4+Pj4gdGhlIGNvbnRyb2xsZXIgc2hhbGwgY2xlYXIgdGhl
IERvIE5vdCBSZXRyeSBiaXQgdG8g4oCYMOKAmSBpbiB0aGUgU3RhdHVzCj4+Pj4gZmllbGQgb2Yg
dGhlIENRRSAocmVmZXIgdG8gRmlndXJlIDEyNCkuIFRoZSBjb250cm9sbGVyIHNoYWxsIG5vdCBy
ZXR1cm4KPj4+PiB0aGlzIHN0YXR1cyBjb2RlIHVubGVzcyB0aGUgaG9zdCBoYXMgc2V0IHRoZSBB
ZHZhbmNlZCBDb21tYW5kIFJldHJ5Cj4+Pj4gRW5hYmxlIChBQ1JFKSBmaWVsZCB0byAxaCBpbiB0
aGUgSG9zdCBCZWhhdmlvciBTdXBwb3J0IGZlYXR1cmUocmVmZXIgdG8KPj4+PiBzZWN0aW9uIDUu
MjEuMS4yMikuCj4+Pj4KPj4+PiBBY2NvcmRpbmcgdGhlIHByb3RvY29sIGRlZmluZSwgTlZNRV9T
Q19DTURfSU5URVJSVVBURUQgbmVlZCByZXRyeS4KPj4+PiBUaGUgZXJyb3IgY29kZSBOVk1FX1ND
X0NNRF9JTlRFUlJVUFRFRCBzaG91bGQgbm90IHRyYW5zbGF0ZSB0bwo+Pj4+IEJMS19TVFNfVEFS
R0VULCBiZWNhdXNlIGlmIHRoZSBlcnJvciBjb2RlIHRyYW5zbGF0ZSB0byBCTEtfU1RTX1RBUkdF
VCwKPj4+PiBkbS1tdWx0aXBhaCB3aWxsIHJldHVybiBlcnJvciB0byBhcHBsaWNhdGlvbi4gU28g
aWYgdGFyZ2V0IHJldHVybiBlcnJvcgo+Pj4+IGNvZGUgTlZNRV9TQ19DTURfSU5URVJSVVBURUQs
IGlvIHdpbGwgaW50ZXJydXB0LiBOVk1FX1NDX0NNRF9JTlRFUlJVUFRFRAo+Pj4+IHNob3VsZCB0
cmFuc2xhdGUgdG8gQkxLX1NUU19JT0VSUiBieSBkZWZhdWx0LCBkbS1tdWx0aXBhdGggd2lsbCBm
YWlsCj4+Pj4gb3ZlciB0byBvdGhlciBwYXRoIHJldHJ5IHRoZSBpby4KPj4+Cj4+PiBJT0VSUiBz
dGlsbCBzZWVtcyB3cm9uZywgdGhvdWdoLgo+Pj4gLgo+Pgo+PiBCTEtfU1RTX1RBUkdFVCBtZWFu
cyB0YXJnZXQgaGFzIGNyaXRpY2FsIGVycm9yLiBOVk1FX1NDX0NNRF9JTlRFUlJVUFRFRAo+PiBq
dXN0IG1lYW5zIHRhcmdldCBuZWVkIHJldHJ5IGlvLiBJdCBpcyBub3Qgc3VpdGFibGUgdG8gdHJh
bnNsYXRlCj4+IE5WTUVfU0NfQ01EX0lOVEVSUlVQVEVEIHRvIEJMS19TVFNfVEFSR0VULiBNYXli
ZSB0cmFuc2xhdGUgdG8KPj4gQkxLX1NUU19JT0VSUiBpcyBhbHNvIG5vdCBzdWl0YWJsZSwgd2Ug
c2hvdWxkIHRyYW5zbGF0ZQo+PiBOVk1FX1NDX0NNRF9JTlRFUlJVUFRFRCB0byBCTEtfU1RTX0FH
QUlOLgo+PiBXZSBjYW4gZG8gbGlrZSB0aGlzOgo+IAo+IEJMS19TVFNfQUdBSU4gaXMgYSBiYWQg
Y2hvaWNlIGFzIHdlIHVzZSBpdCBmb3IgY2FsbHMgdGhhdCBibG9jayB3aGVuCj4gdGhlIGNhbGxl
cnMgYXNrZWQgZm9yIG5vbi1ibG9ja2luZyBzdWJtaXNzaW9uLiAgSSdtIHJlYWxseSBub3Qgc3Vy
ZQo+IHdlIHdhbnQgdG8gY2hhbmdlIGFueXRoaW5nIGhlcmUgLSB0aGUgZXJyb3IgZGVmaW5pdGlv
biBjbGVhcmx5IHN0YXRlcwo+IGl0IGlzIG5vdCBhIGZhaWx1cmUgYnV0IGEgcmVxdWVzdCB0byBy
ZXRyeSBsYXRlci4KPiAuCj4gCkJMS19TVFNfQUdBSU4gaXMgbm90IGEgZ29vZCBjaG9pY2UsIGJ1
dCBCTEtfU1RTX1RBUkdFVCBpcyBhbHNvIG5vdAphIGdvb2QgY2hvaWNlLiBJIGZpbmQgdGhlIHBh
dGNoIHRoYXQgdHJhbnNsYXRlIE5WTUVfU0NfQ01EX0lOVEVSUlVQVEVECnRvIEJMS19TVFNfVEFS
R0VULgoKY29tbWl0OjM1MDM4YmZmYTg3ZGEyODIwMTBiOTExMDhjYWRkMTMyMzhiYjViYmQKbnZt
ZTogVHJhbnNsYXRlIG1vcmUgc3RhdHVzIGNvZGVzIHRvIGJsa19zdGF0dXNfdApEZWNvZGUgaW50
ZXJydXB0ZWQgY29tbWFuZCBhbmQgbm90IHJlYWR5IG5hbWVzcGFjZSBudm1lIHN0YXR1cyBjb2Rl
cyB0bwpCTEtfU1RTX1RBUkdFVC4gVGhlc2UgYXJlIG5vdCBnZW5lcmljIElPIGVycm9ycyBhbmQg
c2hvdWxkIHVzZSBhIG5vbi1wYXRoCnNwZWNpZmljIGVycm9yIHNvIHRoYXQgaXQgY2FuIHVzZSB0
aGUgbm9uLWZhaWxvdmVyIHJldHJ5IHBhdGguClJlcG9ydGVkLWJ5OiBKb2huIE1lbmVnaGluaSA8
Sm9obi5NZW5lZ2hpbmlAbmV0YXBwLmNvbT4KCkluIHRoZSBvbGQgdmVyc2lvbiwgbmVlZCB0cmFu
c2xhdGUgTlZNRV9TQ19DTURfSU5URVJSVVBURUQgdG8KQkxLX1NUU19UQVJHRVQsIGJlY2F1c2Ug
bnZtZSBtdWx0aXBhdGggY2hlY2sgdGhlIGJsa19wYXRoX2Vycm9yLAp3ZSBleHBlY3QgcmV0cnkg
SU8gaW4gdGhlIGN1cnJlbnQgcGF0aCwgc28gaGF2ZSB0byB0cmFuc2xhdGUKTlZNRV9TQ19DTURf
SU5URVJSVVBURUQgdG8gQkxLX1NUU19UQVJHRVQuIEFsdGhvdWdoIGNvbnZlcnRpbmcgdG8KQkxL
X1NUU19UQVJHRVQgaXMgbm90IGEgZ29vZCBjaG9pY2UsIHRoZXJlIHNlZW1zIHRvIGJlIG5vIGJl
dHRlciBjaG9pY2UKZm9yIHRoZSBvbGQgdmVyc2lvbiBjb2RlLiBCdXQgbm93IHdlIGRvIG5vdCBu
ZWVkIHRyYW5zbGF0ZQpOVk1FX1NDX0NNRF9JTlRFUlJVUFRFRCB0byBCTEtfU1RTX1RBUkdFVCwg
bnZtZSBtdWx0aXBhdGggYWxyZWFkeQppbXByb3ZlIGFuZCBkb2VzIG5vdCBkZXBlbmQgb24gYmxr
X3BhdGhfZXJyb3IuCgpBY2NvcmRpbmcgdG8gdGhlIGRlc2NyaXB0aW9uIG9mIEJMS19TVFNfVEFS
R0VUOgpbQkxLX1NUU19UQVJHRVRdCT0geyAtRVJFTU9URUlPLAkiY3JpdGljYWwgdGFyZ2V0IiB9
CkJMS19TVFNfVEFSR0VUIG1heSBlYXNpbHkgbWlzdGFrZW4gYXMgYSBmYXRhbCBlcnJvciBvbiB0
aGUgc3RvcmFnZS4KSSBhbHJlYWR5IGNoZWNrIGFsbCB0aGUgZXJyb3IgY29kZSBvZiBCTEtfU1RT
X3h4LCB0aGVyZSBpcyBubyBnb29kCmNob2ljZSBmb3IgTlZNRV9TQ19DTURfSU5URVJSVVBURUQg
bm93LiBJbiB0aGUgYWJzZW5jZSBvZiBhIHN1aXRhYmxlCmVycm9yIGNvZGUsIGl0IGlzIGEgZ29v
ZCBjaG9pY2UgdG8gcmV0YWluIHRoZSBkZWZhdWx0LiBTbyBJIHN0cm9uZ2x5CnN1Z2dlc3QgZGVs
ZXRlIHRyYW5zbGF0ZSBOVk1FX1NDX0NNRF9JTlRFUlJVUFRFRCB0byBCTEtfU1RTX1RBUkdFVC4K
CkpvaG4sIHdoYXQgZG8geW91IHRoaW5rPwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtbnZtZQo=
