Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EF8C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 08:53:58 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25751610CF
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 08:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25751610CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sXMJzS3q1wHw4kpzVkyfiTFJ8KSvcE6gNuojJv787N0=; b=iS56dAOT7MJHsv4rIqsRSf+Ef
	0P4Mkb61LgaXTJr9JpdMqrpWyoQb0WR4f5x+O5Z6c3ALoz43+MPU3r7wOUw0flCZ0USLpqt38Fs7a
	hfLBGaUy2vY7Tnzxc7HUj/yM+tDU6DBt+JnOoWzQhb0YBTDcYbJhYnyHLIUaj/MQTnkdZMrR4UXEH
	Gj1qH8oApdsIc3bAPKqBJVNlsD3r3CyCsoFC0qP0ZnSrn4ruA8vFkwxEL67GFOIK45uRwk6h6qdlX
	7GkVlJp/XOO7QTIQdbBBflVN1xVpeJnJ245Be+vGN957LwMTfdTQS4qVhUx/Yu/J1fvIHMZqgPrPZ
	ZJulyg9gA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUQQ8-007ONq-4Z; Thu, 08 Apr 2021 08:53:48 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUQQ3-007OMn-Je
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 08:53:45 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 4DEEEB1D5;
 Thu,  8 Apr 2021 08:53:42 +0000 (UTC)
Subject: Re: [PATCH v9 11/13] lpfc: vmid: Timeout implementation for vmid
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
References: <1617750397-26466-1-git-send-email-muneendra.kumar@broadcom.com>
 <1617750397-26466-12-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c56363c9-ad39-fb94-6055-ea432683b57e@suse.de>
Date: Thu, 8 Apr 2021 10:38:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1617750397-26466-12-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_095344_244733_E3EA8CF6 
X-CRM114-Status: GOOD (  14.26  )
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

T24gNC83LzIxIDE6MDYgQU0sIE11bmVlbmRyYSB3cm90ZToKPiBGcm9tOiBHYXVyYXYgU3JpdmFz
dGF2YSA8Z2F1cmF2LnNyaXZhc3RhdmFAYnJvYWRjb20uY29tPgo+IAo+IFRoaXMgcGF0Y2ggaW1w
bGVtZW50cyB0aGUgdGltZW91dCBmdW5jdGlvbmFsaXR5IGZvciB0aGUgdm1pZC4gQWZ0ZXIgdGhl
Cj4gc2V0IHRpbWUgcGVyaW9kIG9mIGluYWN0aXZpdHksIHRoZSB2bWlkIGlzIGRlcmVnaXN0ZXJl
ZCBmcm9tIHRoZSBzd2l0Y2guCj4gCj4gU2lnbmVkLW9mZi1ieTogR2F1cmF2IFNyaXZhc3RhdmEg
IDxnYXVyYXYuc3JpdmFzdGF2YUBicm9hZGNvbS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogSmFtZXMg
U21hcnQgPGpzbWFydDIwMjFAZ21haWwuY29tPgo+IAo+IC0tLQo+IHY5Ogo+IE1vZGlmaWVkIGNv
ZGUgZm9yIHVzZSBvZiBoYXNodGFibGUKPiAKPiB2ODoKPiBGaXhlZCB0aGUgdW5pbml0aWFsaXpl
ZCB2YXJpYWJsZQo+IAo+IHY3Ogo+IE5vIGNoYW5nZQo+IAo+IHY2Ogo+IEFkZGVkIEZvcndhcmQg
ZGVjbGFyYXRpb25zCj4gCj4gdjU6Cj4gTm8gY2hhbmdlCj4gCj4gdjQ6Cj4gTm8gY2hhbmdlCj4g
Cj4gdjM6Cj4gTm8gY2hhbmdlCj4gCj4gdjI6Cj4gUG9ydGVkIHRoZSBwYXRjaCBvbiB0b3Agb2Yg
NS4xMC9zY3NpLXF1ZXVlCj4gLS0tCj4gICBkcml2ZXJzL3Njc2kvbHBmYy9scGZjX2hiYWRpc2Mu
YyB8IDEwNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gICBkcml2ZXJzL3Njc2kv
bHBmYy9scGZjX2luaXQuYyAgICB8ICA0MCArKysrKysrKysrKysKPiAgIDIgZmlsZXMgY2hhbmdl
ZCwgMTQ0IGluc2VydGlvbnMoKykKPiAKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFy
ZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAg
ICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0
aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBO
w7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
