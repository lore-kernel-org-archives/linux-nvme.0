Return-Path: <SRS0=KdjD=LS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA622C48BDF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 09:10:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66AE461380
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 09:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66AE461380
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=dF+EIKUnpETWHY+VRZRhwIAnodFULLGKh+loKtJVIyU=; b=LwkQaCXDpcZlO+HNljYlNgTKCN
	POhFCfZiMC6Xfvowxsf7xNxdKtU1ovQI7HWTUnyI+M+bgaROyy3Y/xTei5OloOLvNoCOuOCUgUtuK
	BHNbPJc9Kvg1YMc4WwuAW2hgLS0A3YmLRpO4slo5a90EMLYnEwso6HZi+BjjRcfcEbzW2rVGiEJY3
	4yoRaPzyPHwDGmy0w5vFDWZkqEjeFHCAidm3E2lGhYDkrVmwyiD+HImaKnSW2cZ110J/2qXxi5Spl
	FoMLgQO/xVXcG0UzaHCfKt9YJI1Xvf4gWXPKd+WhbB+hz7+tsZNkJO3WJaPXp1YsIQZAqNV3wPR2m
	TksA2itg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwLNO-00Df3o-SW; Thu, 24 Jun 2021 09:10:22 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwLNL-00Df2l-8k
 for linux-nvme@lists.infradead.org; Thu, 24 Jun 2021 09:10:20 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C51C021963;
 Thu, 24 Jun 2021 09:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624525817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s2Z73pWe35A+6qLtJS27RxDODez8pQhhLG2D6+rtCEU=;
 b=HlK6nfd98QkEWl2OBeGkqo7aQcbXIUuZaqtYJCtBCdMjdwQsvqhQ1whI1bvQmYhMZ8Gvau
 zNKSBeZc6RiaQcMAUeo+MHnWWPqApwPUrUfnvz7S3B3jiaizrnceBQwcz0dmcv4kJjvkv+
 ssjNSInxu8g39s2sv06RZNcvPOpODMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624525817;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s2Z73pWe35A+6qLtJS27RxDODez8pQhhLG2D6+rtCEU=;
 b=zIicjeMGhDDLrpoMdmPf7pCkMjP/b8xSeTkqLkPpmvJMS1uCi/g3/sRUG1ApbeIjA/yhQy
 mOSZcqWTKTFXPPBQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id B577211A97;
 Thu, 24 Jun 2021 09:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624525817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s2Z73pWe35A+6qLtJS27RxDODez8pQhhLG2D6+rtCEU=;
 b=HlK6nfd98QkEWl2OBeGkqo7aQcbXIUuZaqtYJCtBCdMjdwQsvqhQ1whI1bvQmYhMZ8Gvau
 zNKSBeZc6RiaQcMAUeo+MHnWWPqApwPUrUfnvz7S3B3jiaizrnceBQwcz0dmcv4kJjvkv+
 ssjNSInxu8g39s2sv06RZNcvPOpODMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624525817;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s2Z73pWe35A+6qLtJS27RxDODez8pQhhLG2D6+rtCEU=;
 b=zIicjeMGhDDLrpoMdmPf7pCkMjP/b8xSeTkqLkPpmvJMS1uCi/g3/sRUG1ApbeIjA/yhQy
 mOSZcqWTKTFXPPBQ==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id jGkjLPlL1GC/OAAALh3uQQ
 (envelope-from <hare@suse.de>); Thu, 24 Jun 2021 09:10:17 +0000
Subject: Re: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: "Rao, Vinay" <Vinay.Rao@dell.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "Belanger, Martin" <Martin.Belanger@dell.com>,
 "Hayes, Stuart" <Stuart.Hayes@dell.com>,
 "Tarikere, Madhu" <Madhu.Tarikere@dell.com>,
 Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>
References: <BL0PR13MB429142FD8B9FCC57C2FE451D9C409@BL0PR13MB4291.namprd13.prod.outlook.com>
 <20210429063056.GA2482@lst.de>
 <SJ0PR19MB454499BF2899EF772B1EA11CF25F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <BYAPR04MB4965BD2AE65469C96CBF1354865F9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BYAPR19MB29351987D7ABBA3F28791D978F5E9@BYAPR19MB2935.namprd19.prod.outlook.com>
 <20210430162104.GA907317@dhcp-10-100-145-180.wdc.com>
 <20210503065235.GB32627@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <eafbb7f9-5481-6138-15d2-bdcde3a29929@suse.de>
Date: Thu, 24 Jun 2021 11:10:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210503065235.GB32627@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210624_021019_531262_6632215F 
X-CRM114-Status: GOOD (  21.39  )
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

T24gNS8zLzIxIDg6NTIgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IE9uIEZyaSwgQXBy
IDMwLCAyMDIxIGF0IDA5OjIxOjA0QU0gLTA3MDAsIEtlaXRoIEJ1c2NoIHdyb3RlOgo+PiBPbiBG
cmksIEFwciAzMCwgMjAyMSBhdCAwNToxNDo1NUFNICswMDAwLCBSYW8sIFZpbmF5IHdyb3RlOgo+
Pj4gKyBNYWRodQo+Pj4KPj4+IEhpIENoYWl0YW55YSwgCj4+Pgo+Pj4gU29tZSBvZiB0aGUgQUVO
J3MgbGlrZSBBTkEgc3RhdGUgY2hhbmdlIGFuZCBOYW1lIFNwYWNlIGF0dHJpYnV0ZSBjaGFuZ2Ug
ZXZlbnRzIGFyZSBvZiBpbnRlcmVzdCBvdXRzaWRlIHRoZSBOVk1FIGRyaXZlci4gCj4+Pgo+Pj4g
SXQgd291bGQgYmUgZ29vZCB0byBjb25zaWRlciB0aGVzZSBldmVudHMgdG8gYmUgcHJvcGFnYXRl
ZCB1cCB0byB1c2VyIHNwYWNlLiBJIGFtIG5vdCB5ZXQgY29udmluY2VkIG9uIGhvdyBwcm9wYWdh
dGluZyB0aGlzIGFib3ZlIHRvIHVzZXIgc3BhY2UgaXMgcHJvYmxlbWF0aWMuCj4+Cj4+IFRoZSBu
YW1lc3BhY2UgYXR0cmlidXRlIGNoYW5nZSBldmVudCBwYWlycyB3aXRoIHRoZSBDaGFuZ2VkIE5h
bWVzcGFjZQo+PiBMaXN0IGxvZywgYW5kIHJlYWRpbmcgdGhhdCBsb2cgd2lsbCBjaGFuZ2UgdGhl
IHJlc3VsdCBmb3IgYSBzdWJzZXF1ZW50Cj4+IHJlYWRlci4gVXNlciBzcGFjZSByYWNpbmcgd2l0
aCB0aGUga2VybmVsIG9uIGEgbG9nIGFjY2VzcyB3aGVuIHRoZXJlIGFyZQo+PiByZWFkIHNpZGUg
ZWZmZWN0cyBjcmVhdGVzIG5vbi1kZXRlcm1pbmlzdGljIGJlaGF2aW9yLCBhbmQgdGhhdCBpcwo+
PiBwcm9ibGVtYXRpYy4KPiAKPiBUaGUgb25seSB3YXkgSSBjb3VsZCB0aGluayBvZiBtYWtpbmcg
dGhpcyB3b3JrIGlzIGJ5Ogo+IAo+IGZvcmNpbmcgdGhlIFJBRSBiaXQgb24gZm9yIGFsbCBsb2cg
cGFnZXMgdGhhdCB0aGUga2VybmVsIGNhcmVzIGFib3V0LAo+IGFuZCBvbmx5IGRlbGl2ZXJpbmcg
dGhlIHVldmVudCBvbiBjb250cm9sbGVycyB0aGF0IGFjdHVhbGx5IGRvIHN1cHBvcnQKPiB0aGUg
UkFFIGJpdCAoSUlSQyBpdCBnb3QgYWRkZWQgaW4gMS4zLCBidXQgSSdkIGhhdmUgdG8gY2hlY2sp
Lgo+IApZZXAsIHRoYXQgc291bmRzIGxpa2UgYSBnb29kIGlkZWEuCkkgd291bGQgZXZlbiBnbyBz
byBmYXIgYXMgdG8gaW5oaWJpdCBhbnkgdXNlci1zcGFjZSBjb21tYW5kcyB3aGljaCByZWFkCnRo
b3NlIGxvZyBwYWdlcyBhbmQgd2hpY2ggaGF2ZSB0aGUgUkFFIGJpdCBfbm90XyBzZXQsIGFzIHRo
aXMgaGFzIHRoZQpwb3RlbnRpYWwgb2YgbWVzc2luZyB1cCB0aGUga2VybmVsIG9wZXJhdGlvbnMu
Li4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZQkJICAgICAgICAgICBL
ZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlCQkJICAgICAgICAgICAgICAgICAg
KzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJILCBN
YXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBH
RjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1udm1lCg==
