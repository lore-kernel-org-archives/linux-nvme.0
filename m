Return-Path: <SRS0=jrCY=IV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5366C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 07:29:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C2D0619AB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 07:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2D0619AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=q5MB0eUy42yjt+8WaItR3vE3A845Cuq0YXNiNPNNTeg=; b=I8JlT83F/O64hLmqJxi7CNiNC
	aPFC6oUAPMDPmnJpOfb5GosZxiJjj5Vsgi2PDJPFlEZx0uw+t6nI0rK5UMIRhroYUOhOOcL9ozSLk
	l9ki/w/xb1xoUCx4/USpQzbKKtVQ8FXCwlkc8O1ko4GfLoRQkv1r/KIoRjOrXJI8OZEutAkELxUyz
	UkziD3E5b/j51w4oyve2X2MocfpxuJO50hkGKGuBlqxRE4gee0mxsR28uYpB3L0j4xlYREbhu5gHe
	PMh1dCYU5Ih+bBPBySycrbobWAoNf+BeN6o1kG5kFo6K7hJca+iEMz0/aUZehVbUzuY4NHKOul+49
	FkmHq3qsw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lObTA-00E8fE-8w; Tue, 23 Mar 2021 07:28:52 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lObT1-00E8eD-TT
 for linux-nvme@lists.infradead.org; Tue, 23 Mar 2021 07:28:47 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id AB318AE20;
 Tue, 23 Mar 2021 07:28:41 +0000 (UTC)
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of the
 underlying device
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Chao Leng <lengchao@huawei.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
 <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c064b296-c25c-3731-cbbd-f99ab93e6bd2@suse.de>
Date: Tue, 23 Mar 2021 08:28:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210323_072845_228454_3CF7BB49 
X-CRM114-Status: GOOD (  23.15  )
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

T24gMy8yMy8yMSAzOjU3IEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+PiBXaGVuIHdlIHJl
c2V0L3RlYXJkb3duIGEgY29udHJvbGxlciwgd2UgbXVzdCBmcmVlemUgYW5kIHF1aWVzY2UgdGhl
Cj4+IG5hbWVzcGFjZXMgcmVxdWVzdCBxdWV1ZXMgdG8gbWFrZSBzdXJlIHRoYXQgd2Ugc2FmZWx5
IHN0b3AgaW5mbGlnaHQgSS9PCj4+IHN1Ym1pc3Npb25zLiBGcmVlemUgaXMgbWFuZGF0b3J5IGJl
Y2F1c2UgaWYgb3VyIGhjdHggbWFwIGNoYW5nZWQgYmV0d2Vlbgo+PiByZWNvbm5lY3RzLCBibGtf
bXFfdXBkYXRlX25yX2h3X3F1ZXVlcyB3aWxsIGltbWVkaWF0ZWx5IGF0dGVtcHQgdG8gZnJlZXpl
Cj4+IHRoZSBxdWV1ZSwgYW5kIGlmIGl0IHN0aWxsIGhhcyBwZW5kaW5nIHN1Ym1pc3Npb25zICh0
aGF0IGFyZSBzdGlsbAo+PiBxdWllc2NlZCkgaXQgd2lsbCBoYW5nLgo+Pgo+PiBIb3dldmVyLCBi
eSBmcmVlemluZyB0aGUgbmFtZXNwYWNlcyByZXF1ZXN0IHF1ZXVlcywgYW5kIG9ubHkgdW5mcmVl
emluZwo+PiB0aGVtIHdoZW4gd2Ugc3VjY2Vzc2Z1bGx5IHJlY29ubmVjdCwgaW5mbGlnaHQgc3Vi
bWlzc2lvbnMgdGhhdCBhcmUKPj4gcnVubmluZyBjb25jdXJyZW50bHkgY2FuIG5vdyBibG9jayBn
cmFiYmluZyB0aGUgbnNoZWFkIHNyY3UgdW50aWwgZWl0aGVyCj4+IHdlIHN1Y2Nlc3NmdWxseSBy
ZWNvbm5lY3Qgb3IgY3RybF9sb3NzX3RtbyBleHBpcmVkIChvciB0aGUgdXNlcgo+PiBleHBsaWNp
dGx5IGRpc2Nvbm5lY3RlZCkuCj4+Cj4+IFRoaXMgY2F1c2VkIGEgZGVhZGxvY2sgd2hlbiBhIGRp
ZmZlcmVudCBjb250cm9sbGVyIChkaWZmZXJlbnQgcGF0aCBvbiB0aGUKPj4gc2FtZSBzdWJzeXN0
ZW0pIGJlY2FtZSBsaXZlIChpLmUuIG9wdGltaXplZC9ub24tb3B0aW1pemVkKS4gVGhpcyBpcwo+
PiBiZWNhdXNlIG52bWVfbXBhdGhfc2V0X2xpdmUgbmVlZHMgdG8gc3luY2hyb25pemUgdGhlIG5z
aGVhZCBzcmN1IGJlZm9yZQo+PiByZXF1ZXVlaW5nIEkvTyBpbiBvcmRlciB0byBtYWtlIHN1cmUg
dGhhdCBjdXJyZW50X3BhdGggaXMgdmlzaWJsZSB0bwo+PiBmdXR1cmUgKHJlLSlzdWJtaXNpb25z
LiBIb3dldmVyIHRoZSBzcmN1IGxvY2sgaXMgdGFrZW4gYnkgYSBibG9ja2VkCj4+IHN1Ym1pc3Np
b24gb24gYSBmcm96ZW4gcmVxdWVzdCBxdWV1ZSwgYW5kIHdlIGhhdmUgYSBkZWFkbG9jay4KPj4K
Pj4gSW4gb3JkZXIgdG8gZml4IHRoaXMgdXNlIHRoZSBibGtfbXFfc3VibWl0X2Jpb19kaXJlY3Qg
QVBJIHRvIHN1Ym1pdCB0aGUKPj4gYmlvIHRvIHRoZSBsb3ctbGV2ZWwgZHJpdmVyLCB3aGljaCBk
b2VzIG5vdCBibG9jayBvbiB0aGUgcXVldWUgZnJlZQo+PiBidXQgaW5zdGVhZCBhbGxvd3MgbnZt
ZS1tdWx0aXBhdGggdG8gcGljayBhbm90aGVyIHBhdGggb3IgcXVldWUgdXAgdGhlCj4+IGJpby4K
PiAKPiBBbG1vc3QuLi4KPiAKPiBUaGlzIHN0aWxsIGhhcyB0aGUgc2FtZSBpc3N1ZSBidXQgaW5z
dGVhZCBvZiBibG9ja2luZyBvbgo+IGJsa19xdWV1ZV9lbnRlcigpIGl0IGlzIGJsb2NrZWQgb24g
YmxrX21xX2dldF90YWcoKToKPiAtLSAKPiAgwqBfX3NjaGVkdWxlKzB4MjJiLzB4NmUwCj4gIMKg
c2NoZWR1bGUrMHg0Ni8weGIwCj4gIMKgaW9fc2NoZWR1bGUrMHg0Mi8weDcwCj4gIMKgYmxrX21x
X2dldF90YWcrMHgxMWQvMHgyNzAKPiAgwqA/IGJsa19iaW9fc2VnbWVudF9zcGxpdCsweDIzNS8w
eDJhMAo+ICDCoD8gZmluaXNoX3dhaXQrMHg4MC8weDgwCj4gIMKgX19ibGtfbXFfYWxsb2NfcmVx
dWVzdCsweDY1LzB4ZTAKPiAgwqBibGtfbXFfc3VibWl0X2JpbysweDE0NC8weDUwMAo+ICDCoGJs
a19tcV9zdWJtaXRfYmlvX2RpcmVjdCsweDc4LzB4YTAKPiAgwqBudm1lX25zX2hlYWRfc3VibWl0
X2JpbysweGMzLzB4MmYwIFtudm1lX2NvcmVdCj4gIMKgX19zdWJtaXRfYmlvX25vYWNjdCsweGNm
LzB4MmUwCj4gIMKgX19ibGtkZXZfZGlyZWN0X0lPKzB4NDEzLzB4NDQwCj4gIMKgPyBfX2lvX2Nv
bXBsZXRlX3J3LmNvbnN0cHJvcC4wKzB4MTUwLzB4MTUwCj4gIMKgZ2VuZXJpY19maWxlX3JlYWRf
aXRlcisweDkyLzB4MTYwCj4gIMKgaW9faXRlcl9kb19yZWFkKzB4MWEvMHg0MAo+ICDCoGlvX3Jl
YWQrMHhjNS8weDM1MAo+ICDCoD8gY29tbW9uX2ludGVycnVwdCsweDE0LzB4YTAKPiAgwqA/IHVw
ZGF0ZV9sb2FkX2F2ZysweDdhLzB4NWUwCj4gIMKgaW9faXNzdWVfc3FlKzB4YTI4LzB4MTAyMAo+
ICDCoD8gbG9ja190aW1lcl9iYXNlKzB4NjEvMHg4MAo+ICDCoGlvX3dxX3N1Ym1pdF93b3JrKzB4
YWEvMHgxMjAKPiAgwqBpb193b3JrZXJfaGFuZGxlX3dvcmsrMHgxMjEvMHgzMzAKPiAgwqBpb193
cWVfd29ya2VyKzB4YjYvMHgxOTAKPiAgwqA/IGlvX3dvcmtlcl9oYW5kbGVfd29yaysweDMzMC8w
eDMzMAo+ICDCoHJldF9mcm9tX2ZvcmsrMHgyMi8weDMwCj4gLS0gCj4gCj4gLS0gCj4gIMKgPyB1
c2xlZXBfcmFuZ2UrMHg4MC8weDgwCj4gIMKgX19zY2hlZHVsZSsweDIyYi8weDZlMAo+ICDCoD8g
dXNsZWVwX3JhbmdlKzB4ODAvMHg4MAo+ICDCoHNjaGVkdWxlKzB4NDYvMHhiMAo+ICDCoHNjaGVk
dWxlX3RpbWVvdXQrMHhmZi8weDE0MAo+ICDCoD8gZGVsX3RpbWVyX3N5bmMrMHg2Ny8weGIwCj4g
IMKgPyBfX3ByZXBhcmVfdG9fc3dhaXQrMHg0Yi8weDcwCj4gIMKgX193YWl0X2Zvcl9jb21tb24r
MHhiMy8weDE2MAo+ICDCoF9fc3luY2hyb25pemVfc3JjdS5wYXJ0LjArMHg3NS8weGUwCj4gIMKg
PyBfX2JwZl90cmFjZV9yY3VfdXRpbGl6YXRpb24rMHgxMC8weDEwCj4gIMKgbnZtZV9tcGF0aF9z
ZXRfbGl2ZSsweDYxLzB4MTMwIFtudm1lX2NvcmVdCj4gIMKgbnZtZV91cGRhdGVfYW5hX3N0YXRl
KzB4ZDcvMHgxMDAgW252bWVfY29yZV0KPiAgwqBudm1lX3BhcnNlX2FuYV9sb2crMHhhNS8weDE2
MCBbbnZtZV9jb3JlXQo+ICDCoD8gbnZtZV9tcGF0aF9zZXRfbGl2ZSsweDEzMC8weDEzMCBbbnZt
ZV9jb3JlXQo+ICDCoG52bWVfcmVhZF9hbmFfbG9nKzB4N2IvMHhlMCBbbnZtZV9jb3JlXQo+ICDC
oHByb2Nlc3Nfb25lX3dvcmsrMHgxZTYvMHgzODAKPiAgwqB3b3JrZXJfdGhyZWFkKzB4NDkvMHgz
MDAKPiAtLSAKPiAKQWN0dWFsbHksIEkgaGFkIGJlZW4gcGxheWluZyBhcm91bmQgd2l0aCBtYXJr
aW5nIHRoZSBlbnRpcmUgYmlvIGFzIAonTk9XQUlUJzsgdGhhdCB3b3VsZCBhdm9pZCB0aGUgdGFn
IHN0YWxsLCB0b286CgpAQCAtMzEzLDcgKzMxNiw3IEBAIGJsa19xY190IG52bWVfbnNfaGVhZF9z
dWJtaXRfYmlvKHN0cnVjdCBiaW8gKmJpbykKICAgICAgICAgbnMgPSBudm1lX2ZpbmRfcGF0aCho
ZWFkKTsKICAgICAgICAgaWYgKGxpa2VseShucykpIHsKICAgICAgICAgICAgICAgICBiaW9fc2V0
X2RldihiaW8sIG5zLT5kaXNrLT5wYXJ0MCk7Ci0gICAgICAgICAgICAgICBiaW8tPmJpX29wZiB8
PSBSRVFfTlZNRV9NUEFUSDsKKyAgICAgICAgICAgICAgIGJpby0+Ymlfb3BmIHw9IFJFUV9OVk1F
X01QQVRIIHwgUkVRX05PV0FJVDsKICAgICAgICAgICAgICAgICB0cmFjZV9ibG9ja19iaW9fcmVt
YXAoYmlvLCBkaXNrX2RldnQobnMtPmhlYWQtPmRpc2spLAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBiaW8tPmJpX2l0ZXIuYmlfc2VjdG9yKTsKICAgICAgICAgICAgICAg
ICByZXQgPSBzdWJtaXRfYmlvX25vYWNjdChiaW8pOwoKCk15IG9ubHkgd29ycnkgaGVyZSBpcyB0
aGF0IHdlIG1pZ2h0IGluY3VyIHNwdXJpb3VzIGZhaWx1cmVzIHVuZGVyIGhpZ2ggCmxvYWQ7IGJ1
dCB0aGVuIHRoaXMgaXMgbm90IG5lY2Vzc2FyaWx5IGEgYmFkIHRoaW5nLgoKQ2hlZXJzLAoKSGFu
bmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdl
IEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkg
OTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1
LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8
aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udm1lCg==
