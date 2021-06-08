Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29749C47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 13:09:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAFE16128A
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 13:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFE16128A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=VPrgMD1HVFIxU5ti8S18PMJTwxlp8KahcjJ9/06U338=; b=TZUUyz6VTWPLagAJipoPiU1wx+
	1BZdA2giX56ipdVh9dkjlmAEADjqKGkkJyTz6VA1a7EDTtQub6g5kKvUf7L470c7ZW9CtECjnymth
	UWqG9QgpI2nk0v8BegIyU6M+qTRQV6Z4l31EaEGfuJLgdJPmZYazR7GW7gA2pi1rYYkJADP50V5Qv
	a8JnH5BxOm6T+1Lm7wBE0VW++cEigpZ8jMlS7Kj8HOponq51k4N6TODMwSLpU8dwzmC9vWtvmOJDu
	nUOpFEelING9XIWRHsODk/xw+7bOrm9YU1mb+HzMyRxnoRHG/B+0NiHyLIty6WxAQ5WyT9Ju+L/Pn
	yEYoz2ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqbUA-008XK2-SN; Tue, 08 Jun 2021 13:09:38 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqbU8-008XIe-B6
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 13:09:37 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 40F751FD46;
 Tue,  8 Jun 2021 13:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623157773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FSyVpRECJSyB0ONBdUo37nvnzwImgFpzmH7ifqfbPzs=;
 b=0Pe6DtF4A66MvPs6Q7P5Ga69RNbVFaWy6jB6p7EwTYLzggg5ioSCYxWugAXLGFyBXMjjev
 CFk6sMNLuYoQke39LDJPZph6KorIBUApjD81/dMxKTvNzFo23GqWW+7e5fB+FV+qpB49Up
 oudMReAAN1Qzw7S5F543gGtzKFX2HNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623157773;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FSyVpRECJSyB0ONBdUo37nvnzwImgFpzmH7ifqfbPzs=;
 b=i2umO7VwzW79VTHD2pGB9Rtd+SH7cMfV6vOxukBZr32Mecic790Vr68Qk90r0sdmzsJn/y
 38hkw/iVFuWkvHDA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 353E8118DD;
 Tue,  8 Jun 2021 13:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623157773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FSyVpRECJSyB0ONBdUo37nvnzwImgFpzmH7ifqfbPzs=;
 b=0Pe6DtF4A66MvPs6Q7P5Ga69RNbVFaWy6jB6p7EwTYLzggg5ioSCYxWugAXLGFyBXMjjev
 CFk6sMNLuYoQke39LDJPZph6KorIBUApjD81/dMxKTvNzFo23GqWW+7e5fB+FV+qpB49Up
 oudMReAAN1Qzw7S5F543gGtzKFX2HNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623157773;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FSyVpRECJSyB0ONBdUo37nvnzwImgFpzmH7ifqfbPzs=;
 b=i2umO7VwzW79VTHD2pGB9Rtd+SH7cMfV6vOxukBZr32Mecic790Vr68Qk90r0sdmzsJn/y
 38hkw/iVFuWkvHDA==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id 8eDVDA1sv2DMXAAALh3uQQ
 (envelope-from <hare@suse.de>); Tue, 08 Jun 2021 13:09:33 +0000
Subject: Re: [PATCH v11 08/13] lpfc: vmid: Functions to manage vmids
To: Muneendra Kumar <muneendra.kumar@broadcom.com>,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
References: <20210608043556.274139-1-muneendra.kumar@broadcom.com>
 <20210608043556.274139-9-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <6f3e5eb9-22de-ba43-9591-1f3610172738@suse.de>
Date: Tue, 8 Jun 2021 15:09:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210608043556.274139-9-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_060936_554702_572D1046 
X-CRM114-Status: GOOD (  12.12  )
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

T24gNi84LzIxIDY6MzUgQU0sIE11bmVlbmRyYSBLdW1hciB3cm90ZToKPiBGcm9tOiBHYXVyYXYg
U3JpdmFzdGF2YSA8Z2F1cmF2LnNyaXZhc3RhdmFAYnJvYWRjb20uY29tPgo+IAo+IFRoaXMgcGF0
Y2ggY29udGFpbnMgdGhlIHJvdXRpbmVzIHRvIHNhdmUsIHJldHJpZXZlIGFuZCByZW1vdmUgdGhl
IHZtaWRzCj4gZnJvbSB0aGUgZGF0YSBzdHJ1Y3R1cmUuIEEgaGFzaCB0YWJsZSBpcyB1c2VkIHRv
IHNhdmUgdGhlIHZtaWRzIGFuZAo+IHRoZSBjb3JyZXNwb25kaW5nIFVVSURzIGFzc29jaWF0ZWQg
d2l0aCB0aGUgYXBwbGljYXRpb24vVk1zLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEdhdXJhdiBTcml2
YXN0YXZhICA8Z2F1cmF2LnNyaXZhc3RhdmFAYnJvYWRjb20uY29tPgo+IFNpZ25lZC1vZmYtYnk6
IEphbWVzIFNtYXJ0IDxqc21hcnQyMDIxQGdtYWlsLmNvbT4KPiAKUmV2aWV3ZWQtYnk6IEhhbm5l
cyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVz
IFJlaW5lY2tlCQkgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2Uu
ZGUJCQkgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNv
bHV0aW9ucyBHZXJtYW55IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIg
MzY4MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBs
aXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
