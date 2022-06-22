Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC5AC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 06:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:
	Cc:To:Subject:MIME-Version:Date:Message-ID:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XrI66eRIpFBNycQpbazvBG65UP0N3THl4yxJRgOm+jc=; b=WNBOFXO+DMBxSwTCcBHfeFc/jA
	V8Lhjz+wcqD9xYaipHhrRHCezhH/M0/CJNj6MFsbCGVIe26prrJu69V9aGD/5P6hzy2XhInq4EE3F
	JIxaKsEcdFoyfjn1CuZOhtohPrZylO5Ne6A6Lsr2iWJrfgX0UdljA/HbhVkTeuFpJfEIuzfv0lh2S
	KgZAchj4I2WYcmYh5t+7ygVq/Pfc7NetCvMLubAY0CcWQ+AEHSVjLIEKvonXdmlJejABUYY8pMVh5
	y4hrakpnWl2RHt/p6ogpTuXBBpVrO+kKzIeXq2d++2cmxKGSVslm8Ea7C2y3odmrMc/oxhF+7UTUz
	G5wfO1cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3tQO-008gX6-Kh; Wed, 22 Jun 2022 06:01:12 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3tQM-008gVP-0P
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 06:01:11 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 87C4D1F9A2;
	Wed, 22 Jun 2022 06:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1655877668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XrI66eRIpFBNycQpbazvBG65UP0N3THl4yxJRgOm+jc=;
	b=eTxr1jBYT9X0bdRlw9bNDbnwuORGzkb3V+pDcEnPAZbCeDFiK1FXGKvaq9f0KjyRSN0F03
	zwmP7/cfPm6K5+blxqWF1wsUfKVO0rxc5V/csQXJALK6NqHcWJosC1APCg+yRT52jq4leC
	4xuYIvEN7N+ozWYVgQpnBn0zJ6fgl0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1655877668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XrI66eRIpFBNycQpbazvBG65UP0N3THl4yxJRgOm+jc=;
	b=wYVDXkbQWgFkbvRCkrfiLvH7RKdJfjYOc/vsbhW54EX6/9vmZqeRm5WiJMIsp12haPgJ1d
	xTRPSAzjwSnHv3Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06B9C134A9;
	Wed, 22 Jun 2022 06:01:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Vg2ENyOwsmJlQAAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 22 Jun 2022 06:01:07 +0000
Content-Type: multipart/mixed; boundary="------------nWyRTVf0FkJz1jJrXX3gHSy5"
Message-ID: <3784f492-67f8-c75a-dccf-7f7272e0b4ad@suse.de>
Date: Wed, 22 Jun 2022 08:01:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 06/11] nvme: Implement In-Band authentication
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220621090255.69549-1-hare@suse.de>
 <20220621090255.69549-7-hare@suse.de>
 <f8f0a631-6752-096c-4e85-bcde9bb2869e@grimberg.me>
 <22236c51-90cd-1707-05b8-3772ef4c548d@suse.de>
 <ab4aaf2b-444f-2b3c-091a-396de62afbd1@grimberg.me>
 <a32afeac-983c-2ea4-e693-2d46411e7f4a@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <a32afeac-983c-2ea4-e693-2d46411e7f4a@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_230110_257006_8A202896 
X-CRM114-Status: GOOD (  22.42  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is a multi-part message in MIME format.
--------------nWyRTVf0FkJz1jJrXX3gHSy5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/21/22 16:59, Sagi Grimberg wrote:
> 
>> Looks like if I pass a malformed ctrl key to nvme connect I am able to
>> crash the system:
> 
> This was what I used in this:
> $ nvme connect -a 192.168.123.1 -t tcp  -s 8009 -n testnqn1 -S 
> "DHHC-1:00:QpxVGpctx5J+4SeW2MClUI8rfZO3WdP1llImvsPsx7e3TK+I:" -C 
> "DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVafdfaS7YQOMYhk9zSmlatobqB8C:"
> 
> The dhchap_ctrl_key is the offending string...
> 
Right. Should be fixed with the attached patch.
Can you check?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman
--------------nWyRTVf0FkJz1jJrXX3gHSy5
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-nvme-auth-do-not-use-ctrl-opts-dhchap_ctrl_secret.patch"
Content-Disposition: attachment;
 filename*0="0001-nvme-auth-do-not-use-ctrl-opts-dhchap_ctrl_secret.patch"
Content-Transfer-Encoding: base64

RnJvbSAxZjRkMzQwMTZlN2NhZDQxZjY5NDcxNDNmMDdmODAyYjA1NDE1ZTI2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4K
RGF0ZTogV2VkLCAyMiBKdW4gMjAyMiAwNzo1NzowNiArMDIwMApTdWJqZWN0OiBbUEFUQ0hd
IG52bWUtYXV0aDogZG8gbm90IHVzZSBjdHJsLT5vcHRzLT5kaGNoYXBfY3RybF9zZWNyZXQK
ClRoZSB1c2VyIG1pZ2h0IGhhdmUgcGFzc2VkIGluIGFuIGludmFsaWQgY29udHJvbGxlciBz
ZWNyZXQsIGNhdXNpbmcKY3RybC0+b3B0cy0+ZGhjaGFwX2N0cmxfc2VjcmV0IHRvIGJlIHBy
ZXNlbnQsIGJ1dCBjdHJsLT5jdHJsX2tleSB0bwpiZSBlbXB0eS4gU28gYWx3YXlzIHVzZSBj
dHJsLT5jdHJsX2tleSB3aGVuIGNoZWNraW5nIGlmIGEgdmFsaWQKY29udHJvbGxlciBzZWNy
ZXQgaXMgcHJlc2VudC4KClNpZ25lZC1vZmYtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBz
dXNlLmRlPgotLS0KIGRyaXZlcnMvbnZtZS9jb21tb24vYXV0aC5jIHwgMTMgKysrKysrKy0t
LS0tLQogZHJpdmVycy9udm1lL2hvc3QvYXV0aC5jICAgfCAgOCArKysrLS0tLQogMiBmaWxl
cyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL252bWUvY29tbW9uL2F1dGguYyBiL2RyaXZlcnMvbnZtZS9jb21tb24v
YXV0aC5jCmluZGV4IDk0NWY2YmI2ZWIxZi4uMGM4NmViY2U1OWQyIDEwMDY0NAotLS0gYS9k
cml2ZXJzL252bWUvY29tbW9uL2F1dGguYworKysgYi9kcml2ZXJzL252bWUvY29tbW9uL2F1
dGguYwpAQCAtMjM3LDIxICsyMzcsMjEgQEAgRVhQT1JUX1NZTUJPTF9HUEwobnZtZV9hdXRo
X2ZyZWVfa2V5KTsKIAogdTggKm52bWVfYXV0aF90cmFuc2Zvcm1fa2V5KHN0cnVjdCBudm1l
X2RoY2hhcF9rZXkgKmtleSwgY2hhciAqbnFuKQogewotCWNvbnN0IGNoYXIgKmhtYWNfbmFt
ZSA9IG52bWVfYXV0aF9obWFjX25hbWUoa2V5LT5oYXNoKTsKKwljb25zdCBjaGFyICpobWFj
X25hbWU7CiAJc3RydWN0IGNyeXB0b19zaGFzaCAqa2V5X3RmbTsKIAlzdHJ1Y3Qgc2hhc2hf
ZGVzYyAqc2hhc2g7CiAJdTggKnRyYW5zZm9ybWVkX2tleTsKIAlpbnQgcmV0OwogCi0JaWYg
KGtleS0+aGFzaCA9PSAwKSB7Ci0JCXRyYW5zZm9ybWVkX2tleSA9IGttZW1kdXAoa2V5LT5r
ZXksIGtleS0+bGVuLCBHRlBfS0VSTkVMKTsKLQkJcmV0dXJuIHRyYW5zZm9ybWVkX2tleSA/
IHRyYW5zZm9ybWVkX2tleSA6IEVSUl9QVFIoLUVOT01FTSk7Ci0JfQotCiAJaWYgKCFrZXkg
fHwgIWtleS0+a2V5KSB7CiAJCXByX3dhcm4oIk5vIGtleSBzcGVjaWZpZWRcbiIpOwogCQly
ZXR1cm4gRVJSX1BUUigtRU5PS0VZKTsKIAl9CisJaWYgKGtleS0+aGFzaCA9PSAwKSB7CisJ
CXRyYW5zZm9ybWVkX2tleSA9IGttZW1kdXAoa2V5LT5rZXksIGtleS0+bGVuLCBHRlBfS0VS
TkVMKTsKKwkJcmV0dXJuIHRyYW5zZm9ybWVkX2tleSA/IHRyYW5zZm9ybWVkX2tleSA6IEVS
Ul9QVFIoLUVOT01FTSk7CisJfQorCWhtYWNfbmFtZSA9IG52bWVfYXV0aF9obWFjX25hbWUo
a2V5LT5oYXNoKTsKIAlpZiAoIWhtYWNfbmFtZSkgewogCQlwcl93YXJuKCJJbnZhbGlkIGtl
eSBoYXNoIGlkICVkXG4iLCBrZXktPmhhc2gpOwogCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFM
KTsKQEAgLTQ3MCw2ICs0NzAsNyBAQCBpbnQgbnZtZV9hdXRoX2dlbmVyYXRlX2tleSh1OCAq
c2VjcmV0LCBzdHJ1Y3QgbnZtZV9kaGNoYXBfa2V5ICoqcmV0X2tleSkKIAkvKiBQYXNzIGlu
IHRoZSBzZWNyZXQgd2l0aG91dCB0aGUgJ0RISEMtMTpYWDonIHByZWZpeCAqLwogCWtleSA9
IG52bWVfYXV0aF9leHRyYWN0X2tleShzZWNyZXQgKyAxMCwga2V5X2hhc2gpOwogCWlmIChJ
U19FUlIoa2V5KSkgeworCQkqcmV0X2tleSA9IE5VTEw7CiAJCXJldHVybiBQVFJfRVJSKGtl
eSk7CiAJfQogCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9hdXRoLmMgYi9kcml2
ZXJzL252bWUvaG9zdC9hdXRoLmMKaW5kZXggOWI4NGUxZTU0Y2E3Li41MzE4NGFjNzYyNDAg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2F1dGguYworKysgYi9kcml2ZXJzL252
bWUvaG9zdC9hdXRoLmMKQEAgLTMxNCw3ICszMTQsNyBAQCBzdGF0aWMgaW50IG52bWVfYXV0
aF9zZXRfZGhjaGFwX3JlcGx5X2RhdGEoc3RydWN0IG52bWVfY3RybCAqY3RybCwKIAlkYXRh
LT5obCA9IGNoYXAtPmhhc2hfbGVuOwogCWRhdGEtPmRodmxlbiA9IGNwdV90b19sZTE2KGNo
YXAtPmhvc3Rfa2V5X2xlbik7CiAJbWVtY3B5KGRhdGEtPnJ2YWwsIGNoYXAtPnJlc3BvbnNl
LCBjaGFwLT5oYXNoX2xlbik7Ci0JaWYgKGN0cmwtPm9wdHMtPmRoY2hhcF9jdHJsX3NlY3Jl
dCkgeworCWlmIChjdHJsLT5jdHJsX2tleSkgewogCQlnZXRfcmFuZG9tX2J5dGVzKGNoYXAt
PmMyLCBjaGFwLT5oYXNoX2xlbik7CiAJCWRhdGEtPmN2YWxpZCA9IDE7CiAJCWNoYXAtPnMy
ID0gbnZtZV9hdXRoX2dldF9zZXFudW0oKTsKQEAgLTM0NCw3ICszNDQsNyBAQCBzdGF0aWMg
aW50IG52bWVfYXV0aF9wcm9jZXNzX2RoY2hhcF9zdWNjZXNzMShzdHJ1Y3QgbnZtZV9jdHJs
ICpjdHJsLAogCXN0cnVjdCBudm1mX2F1dGhfZGhjaGFwX3N1Y2Nlc3MxX2RhdGEgKmRhdGEg
PSBjaGFwLT5idWY7CiAJc2l6ZV90IHNpemUgPSBzaXplb2YoKmRhdGEpOwogCi0JaWYgKGN0
cmwtPm9wdHMtPmRoY2hhcF9jdHJsX3NlY3JldCkKKwlpZiAoY3RybC0+Y3RybF9rZXkpCiAJ
CXNpemUgKz0gY2hhcC0+aGFzaF9sZW47CiAKIAlpZiAoY2hhcC0+YnVmX3NpemUgPCBzaXpl
KSB7CkBAIC03OTEsNyArNzkxLDcgQEAgc3RhdGljIHZvaWQgX19udm1lX2F1dGhfd29yayhz
dHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAJCXJldHVybjsKIAl9CiAKLQlpZiAoY3RybC0+
b3B0cy0+ZGhjaGFwX2N0cmxfc2VjcmV0KSB7CisJaWYgKGN0cmwtPmN0cmxfa2V5KSB7CiAJ
CWRldl9kYmcoY3RybC0+ZGV2aWNlLAogCQkJIiVzOiBxaWQgJWQgY29udHJvbGxlciByZXNw
b25zZVxuIiwKIAkJCV9fZnVuY19fLCBjaGFwLT5xaWQpOwpAQCAtODA5LDcgKzgwOSw3IEBA
IHN0YXRpYyB2b2lkIF9fbnZtZV9hdXRoX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3Jr
KQogCQlnb3RvIGZhaWwyOwogCX0KIAotCWlmIChjdHJsLT5vcHRzLT5kaGNoYXBfY3RybF9z
ZWNyZXQpIHsKKwlpZiAoY3RybC0+Y3RybF9rZXkpIHsKIAkJLyogREgtSE1BQy1DSEFQIFN0
ZXAgNTogc2VuZCBzdWNjZXNzMiAqLwogCQlkZXZfZGJnKGN0cmwtPmRldmljZSwgIiVzOiBx
aWQgJWQgc2VuZCBzdWNjZXNzMlxuIiwKIAkJCV9fZnVuY19fLCBjaGFwLT5xaWQpOwotLSAK
Mi4yNi4yCgo=
--------------nWyRTVf0FkJz1jJrXX3gHSy5--


