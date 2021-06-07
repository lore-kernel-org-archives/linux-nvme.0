Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5A7C47094
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 15:50:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E948061029
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 15:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E948061029
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=S+ee0d+Oh4qVfiD/8M/tAhbfG19TR/yDEFYbHcTSCXQ=; b=C1s53YZxTrx6rjTww0HYKJf+0l
	Yq+oaBtPOVig2/jmU1TKiHoxsWlB1BhoHToidU0XBlDHEVLE+zrX/3DoBl+046FecC+XX1RCleL2p
	/EcEGd5vvCeYSt7gUixFbFoW6El7eE9f1g0iYe83CbKL/NmSDEH3sb0kaf/PAH1Gm5KE6pTXDnvoz
	9IJRCoTsKiPwoqhtSgSJaIbXNTN29QD4JG7cFpwuBEKHdHFseweyILJjiB0frI5bxNztJgpDfzdnI
	HHwxS5wo4FBYEPojb2YtHD2iVnMU2CGKMYmGEGGpD+VYZ08zTLiRFElIHxwheQJj21+HFCm6i1bf3
	Kyfq1IRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqHVi-004KRM-BS; Mon, 07 Jun 2021 15:49:54 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqHVc-004KQJ-Sa
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 15:49:52 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 642FE219B6;
 Mon,  7 Jun 2021 15:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623080987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z8DP83ezEIRx09dRuboZviqfN18ugIBwF8ldlpJk2No=;
 b=cHxfr4TB9WZQ8+5qJ1EWxRYVA6pR1OD531xB1fpbRSca9OMNFjHK+gtz0cq76cP2Pt1xLZ
 IOAtA2KEthX1QU3mbxyi8RZX9zyFYEaKCNzrOIDJ6NgvEnG/aYu05kes1HgHAAEPjA1ZFO
 pw/yQxVFwzt60l1FcZYqaaYU+oIDSOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623080987;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z8DP83ezEIRx09dRuboZviqfN18ugIBwF8ldlpJk2No=;
 b=lOLp5JUGNHQpER+764JZSLjcvk09v+PXHCE8W2bMDggoVEth6lN6fkGjwKXophdQLoIwWa
 lObGzkGH55Z7N7AA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 3AE64118DD;
 Mon,  7 Jun 2021 15:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623080987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z8DP83ezEIRx09dRuboZviqfN18ugIBwF8ldlpJk2No=;
 b=cHxfr4TB9WZQ8+5qJ1EWxRYVA6pR1OD531xB1fpbRSca9OMNFjHK+gtz0cq76cP2Pt1xLZ
 IOAtA2KEthX1QU3mbxyi8RZX9zyFYEaKCNzrOIDJ6NgvEnG/aYu05kes1HgHAAEPjA1ZFO
 pw/yQxVFwzt60l1FcZYqaaYU+oIDSOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623080987;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z8DP83ezEIRx09dRuboZviqfN18ugIBwF8ldlpJk2No=;
 b=lOLp5JUGNHQpER+764JZSLjcvk09v+PXHCE8W2bMDggoVEth6lN6fkGjwKXophdQLoIwWa
 lObGzkGH55Z7N7AA==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id 25LqDRtAvmBieQAALh3uQQ
 (envelope-from <hare@suse.de>); Mon, 07 Jun 2021 15:49:47 +0000
Subject: Re: [PATCH 7/8] nvme-tcp-offload: Add queue level implementation
To: Shai Malin <smalin@marvell.com>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 aelior@marvell.com, mkalderon@marvell.com, okulkarni@marvell.com,
 pkushwaha@marvell.com, prabhakar.pkin@gmail.com, malin1024@gmail.com,
 Dean Balandin <dbalandin@marvell.com>
References: <20210602184246.14184-1-smalin@marvell.com>
 <20210602184246.14184-8-smalin@marvell.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <68d83513-aaf1-4956-367e-ab69ca1d37ce@suse.de>
Date: Mon, 7 Jun 2021 17:49:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210602184246.14184-8-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_084949_101572_DD71F18E 
X-CRM114-Status: GOOD (  14.57  )
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

T24gNi8yLzIxIDg6NDIgUE0sIFNoYWkgTWFsaW4gd3JvdGU6Cj4gRnJvbTogRGVhbiBCYWxhbmRp
biA8ZGJhbGFuZGluQG1hcnZlbGwuY29tPgo+IAo+IEluIHRoaXMgcGF0Y2ggd2UgaW1wbGVtZW50
IHF1ZXVlIGxldmVsIGZ1bmN0aW9uYWxpdHkuCj4gVGhlIGltcGxlbWVudGF0aW9uIGlzIHNpbWls
YXIgdG8gdGhlIG52bWUtdGNwIG1vZHVsZSwgdGhlIG1haW4KPiBkaWZmZXJlbmNlIGJlaW5nIHRo
YXQgd2UgY2FsbCB0aGUgdmVuZG9yIHNwZWNpZmljIGNyZWF0ZV9xdWV1ZSBvcCB3aGljaAo+IGNy
ZWF0ZXMgdGhlIFRDUCBjb25uZWN0aW9uLCBhbmQgTlZNZVRQQyBjb25uZWN0aW9uIGluY2x1ZGlu
Zwo+IGljcmVxK2ljcmVzcCBuZWdvdGlhdGlvbi4KPiBPbmNlIGNyZWF0ZV9xdWV1ZSByZXR1cm5z
IHN1Y2Nlc3NmdWxseSwgd2UgY2FuIG1vdmUgb24gdG8gdGhlIGZhYnJpY3MKPiBjb25uZWN0Lgo+
IAo+IEFja2VkLWJ5OiBJZ29yIFJ1c3NraWtoIDxpcnVzc2tpa2hAbWFydmVsbC5jb20+Cj4gU2ln
bmVkLW9mZi1ieTogRGVhbiBCYWxhbmRpbiA8ZGJhbGFuZGluQG1hcnZlbGwuY29tPgo+IFNpZ25l
ZC1vZmYtYnk6IFByYWJoYWthciBLdXNod2FoYSA8cGt1c2h3YWhhQG1hcnZlbGwuY29tPgo+IFNp
Z25lZC1vZmYtYnk6IE9ta2FyIEt1bGthcm5pIDxva3Vsa2FybmlAbWFydmVsbC5jb20+Cj4gU2ln
bmVkLW9mZi1ieTogTWljaGFsIEthbGRlcm9uIDxta2FsZGVyb25AbWFydmVsbC5jb20+Cj4gU2ln
bmVkLW9mZi1ieTogQXJpZWwgRWxpb3IgPGFlbGlvckBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2Zm
LWJ5OiBTaGFpIE1hbGluIDxzbWFsaW5AbWFydmVsbC5jb20+Cj4gUmV2aWV3ZWQtYnk6IEhpbWFu
c2h1IE1hZGhhbmkgPGhpbWFuc2h1Lm1hZGhhbmlAb3JhY2xlLmNvbT4KPiAtLS0KPiAgZHJpdmVy
cy9udm1lL2hvc3QvdGNwLW9mZmxvYWQuYyB8IDQxNyArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLQo+ICBkcml2ZXJzL252bWUvaG9zdC90Y3Atb2ZmbG9hZC5oIHwgICA0ICsKPiAgMiBm
aWxlcyBjaGFuZ2VkLCAzOTMgaW5zZXJ0aW9ucygrKSwgMjggZGVsZXRpb25zKC0pCj4gClJldmll
d2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KCkNoZWVycywKCkhhbm5lcwot
LSAKRHIuIEhhbm5lcyBSZWluZWNrZQkJICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QK
aGFyZUBzdXNlLmRlCQkJICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0
d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJILCA5MDQwOSBOw7xybmJlcmcKR0Y6IEYuIEltZW5k
w7ZyZmZlciwgSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1u
dm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1udm1lCg==
