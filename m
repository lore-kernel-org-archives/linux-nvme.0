Return-Path: <SRS0=73dC=AL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8997C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 06:01:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A31FC20759
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 06:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K7dTW2S+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A31FC20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=obfSipb8vokZto3fu+QMhayJZNVvrfiBOubXmDBQVEg=; b=K7dTW2S+29dR31zkYGcuikhiJ
	zIf7tGtleedSsxNizmPhGldEIlmKPR3fFsPKnK0jqnZHOe3AMukgqjlzIsXBRiHAcL1Jq3VTt57Jp
	9GP7FGseSk12UnepxvrmqwnDVM0J5NDpWjnC7ZFosVAW1whMU5ENQ0r4KgfKc6AnOD2mVeuYRGmBM
	srB6AFicyzgZVnY0OPl/WHq75bFpkHqms3cxAJigdzsVzLP3XIA6y0YXilBoMzMPymDLeENVarRmG
	WrIE5JOID7mfimubHNa+URb56mIC2gsSF4lbSDdHwCNXcA6UiUNfU0q9izyOW5R1sfu1TdWkMUr+N
	oE+TDh/eQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jq9Kk-0003YH-O9; Tue, 30 Jun 2020 06:01:30 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jq9Ki-0003Xs-MM
 for linux-nvme@lists.infradead.org; Tue, 30 Jun 2020 06:01:29 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id BFC29AAC3;
 Tue, 30 Jun 2020 06:01:25 +0000 (UTC)
Subject: Re: [PATCHv4 3/5] nvme: implement I/O Command Sets Command Set support
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org
References: <20200629190641.1986462-1-kbusch@kernel.org>
 <20200629190641.1986462-4-kbusch@kernel.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <252de04e-90e7-8e56-e718-5619d8c08209@suse.de>
Date: Tue, 30 Jun 2020 08:01:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629190641.1986462-4-kbusch@kernel.org>
Content-Language: en-US
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
Cc: axboe@kernel.dk, Niklas Cassel <niklas.cassel@wdc.com>,
 Daniel Wagner <dwagner@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNi8yOS8yMCA5OjA2IFBNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBGcm9tOiBOaWtsYXMgQ2Fz
c2VsIDxuaWtsYXMuY2Fzc2VsQHdkYy5jb20+Cj4gCj4gSW1wbGVtZW50cyBzdXBwb3J0IGZvciB0
aGUgSS9PIENvbW1hbmQgU2V0cyBjb21tYW5kIHNldC4gVGhlIGNvbW1hbmQgc2V0Cj4gaW50cm9k
dWNlcyBhIG1ldGhvZCB0byBlbnVtZXJhdGUgbXVsdGlwbGUgY29tbWFuZCBzZXRzIHBlciBuYW1l
c3BhY2UuIElmCj4gdGhlIGNvbW1hbmQgc2V0IGlzIGV4cG9zZWQsIHRoaXMgbWV0aG9kIGZvciBl
bnVtZXJhdGlvbiB3aWxsIGJlIHVzZWQKPiBpbnN0ZWFkIG9mIHRoZSB0cmFkaXRpb25hbCBtZXRo
b2QgdGhhdCB1c2VzIHRoZSBDQy5DU1MgcmVnaXN0ZXIgY29tbWFuZAo+IHNldCByZWdpc3RlciBm
b3IgY29tbWFuZCBzZXQgaWRlbnRpZmljYXRpb24uCj4gCj4gRm9yIG5hbWVzcGFjZXMgd2hlcmUg
dGhlIENvbW1hbmQgU2V0IElkZW50aWZpZXIgaXMgbm90IHN1cHBvcnRlZCBvcgo+IHJlY29nbml6
ZWQsIHRoZSBzcGVjaWZpYyBuYW1lc3BhY2Ugd2lsbCBub3QgYmUgY3JlYXRlZC4KPiAKPiBSZXZp
ZXdlZC1ieTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+Cj4gUmV2
aWV3ZWQtYnk6IE1hcnRpbiBLLiBQZXRlcnNlbiA8bWFydGluLnBldGVyc2VuQG9yYWNsZS5jb20+
Cj4gUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdk
Yy5jb20+Cj4gUmV2aWV3ZWQtYnk6IE1hdGlhcyBCasO4cmxpbmcgPG1hdGlhcy5iam9ybGluZ0B3
ZGMuY29tPgo+IFJldmlld2VkLWJ5OiBEYW5pZWwgV2FnbmVyIDxkd2FnbmVyQHN1c2UuZGU+Cj4g
U2lnbmVkLW9mZi1ieTogTmlrbGFzIENhc3NlbCA8bmlrbGFzLmNhc3NlbEB3ZGMuY29tPgo+IC0t
LQo+ICAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIHwgNTMgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLQo+ICAgZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oIHwgIDEgKwo+
ICAgaW5jbHVkZS9saW51eC9udm1lLmggICAgIHwgMTkgKysrKysrKysrKysrLS0KPiAgIDMgZmls
ZXMgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCj4gUmV2aWV3ZWQt
Ynk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApE
ci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgVGVhbWxlYWQgU3RvcmFnZSAmIE5ldHdvcmtp
bmcKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQw
NTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5
IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBG
ZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LW52bWUK
