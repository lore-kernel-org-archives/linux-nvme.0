Return-Path: <SRS0=adoP=K2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3051EC47080
	for <linux-nvme@archiver.kernel.org>; Mon, 31 May 2021 15:26:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C78C56124C
	for <linux-nvme@archiver.kernel.org>; Mon, 31 May 2021 15:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78C56124C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=t8uIRC7tTTColFI7TbCPtabDUHWqRV4kLobGrrUxpbA=; b=yZIXzMJmImohWgVZUpAeubMX/M
	kgD0ysJYfpnTZ646IEsKl4QoGdRSprgDXTRXmR6nAhwuXsap4vOzNJVhpqO1F3Qov1y+7QRKgJF3U
	k0QszwgN3XErfCBXjdtMrtHZwfBZXSLqX/bVuMybAevaaCvELf5QPmXu1YQgitSJTSKngADqFFFKc
	OYRpNX88JplSiXWG5mV0F17oHnZW33NErrafqwoHxHQWkVMEGG/06jh/vKW5ExYA7kETW5BjUZ1nS
	1xB1ThALYqRJbnD806j6F8f3KsURVldDsZL8K30YM0VQJkdnc/RN+oaurmor0Z095rop1WSUNeREX
	Yv5yqeoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lnjnY-00CjHt-2h; Mon, 31 May 2021 15:25:48 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lnjnV-00CjHL-07
 for linux-nvme@lists.infradead.org; Mon, 31 May 2021 15:25:46 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B22341FD2E;
 Mon, 31 May 2021 15:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622474739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2zZ93JPqCxZrSsk/n57nxlrCWP6IQJN5JOfNw2ybZ9c=;
 b=BwNRtZQdewfSD5/Y/MAaTAQ+HFuDdWwB7E9kqcjTmUQCofNG8Uw8NejuCIl4GbyvttA+RI
 ztvIPbsgaYeYbRb1gvvoTdUApVj3i33lziPwmlkrBAlDviY41KiPiahLXhNgwqiy0vnm6U
 ZqglJiO3TAIES7KBUe13+vORCL62IWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622474739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2zZ93JPqCxZrSsk/n57nxlrCWP6IQJN5JOfNw2ybZ9c=;
 b=5AbunJCdRaWXd1KtJWWp9KOqfk/3AMKQ5nVVxdTY0oxm6+UL1NEWlp1ulnf5ue1ZrBfDHi
 HE1DTs1+AsyIoxDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 4A925118DD;
 Mon, 31 May 2021 15:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622474739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2zZ93JPqCxZrSsk/n57nxlrCWP6IQJN5JOfNw2ybZ9c=;
 b=BwNRtZQdewfSD5/Y/MAaTAQ+HFuDdWwB7E9kqcjTmUQCofNG8Uw8NejuCIl4GbyvttA+RI
 ztvIPbsgaYeYbRb1gvvoTdUApVj3i33lziPwmlkrBAlDviY41KiPiahLXhNgwqiy0vnm6U
 ZqglJiO3TAIES7KBUe13+vORCL62IWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622474739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2zZ93JPqCxZrSsk/n57nxlrCWP6IQJN5JOfNw2ybZ9c=;
 b=5AbunJCdRaWXd1KtJWWp9KOqfk/3AMKQ5nVVxdTY0oxm6+UL1NEWlp1ulnf5ue1ZrBfDHi
 HE1DTs1+AsyIoxDQ==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id aamiEfP/tGDvHQAALh3uQQ
 (envelope-from <hare@suse.de>); Mon, 31 May 2021 15:25:39 +0000
Subject: Re: [PATCH] nvme: verify MNAN value if ANA is enabled
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20210531103651.109426-1-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <7c7b96e7-ea31-1d3b-9b5c-3b89133926b5@suse.de>
Date: Mon, 31 May 2021 17:25:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210531103651.109426-1-dwagner@suse.de>
Content-Language: en-US
Authentication-Results: imap.suse.de;
	none
X-Spamd-Result: default: False [-1.00 / 100.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; HAS_ORG_HEADER(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210531_082545_217411_AABDA8F5 
X-CRM114-Status: GOOD (  22.70  )
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

T24gNS8zMS8yMSAxMjozNiBQTSwgRGFuaWVsIFdhZ25lciB3cm90ZToKPiBUaGUgY29udHJvbGxl
ciBpcyByZXF1aXJlZCB0byBoYXZlIGEgbm9uLXplcm8gTU5BTiB2YWx1ZSBpZiBpdCBzdXBwb3J0
cwo+IEFOQToKPiAKPiAgICBJZiB0aGUgY29udHJvbGxlciBzdXBwb3J0cyBBc3ltbWV0cmljIE5h
bWVzcGFjZSBBY2Nlc3MgUmVwb3J0aW5nLCB0aGVuCj4gICAgdGhpcyBmaWVsZCBzaGFsbCBiZSBz
ZXQgdG8gYSBub24temVybyB2YWx1ZSB0aGF0IGlzIGxlc3MgdGhhbiBvciBlcXVhbAo+ICAgIHRv
IHRoZSBOTiB2YWx1ZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgV2FnbmVyIDxkd2FnbmVy
QHN1c2UuZGU+Cj4gLS0tCj4gVGhpcyBpcyBhIGZvbGxvdyB1cCB0byB0aGUgZGlzY3Vzc2lvbiBp
bgo+IAo+ICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbnZtZS8yMDIxMDUyMTE0NDcz
NC45MDA0NC0xLWR3YWduZXJAc3VzZS5kZS8KPiAKPiAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5j
IHwgMTAgKysrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQo+IAo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9z
dC9jb3JlLmMKPiBpbmRleCBjYjFhNzZhM2Q0MmEuLjRjNDEyYWRjOWUxNCAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3Jl
LmMKPiBAQCAtMjk3Miw2ICsyOTcyLDE2IEBAIHN0YXRpYyBpbnQgbnZtZV9pbml0X2lkZW50aWZ5
KHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpCj4gIAlpZiAocmV0IDwgMCkKPiAgCQlnb3RvIG91dF9m
cmVlOwo+ICAKPiArI2lmZGVmIENPTkZJR19OVk1FX01VTFRJUEFUSAo+ICsJaWYgKGN0cmwtPmFu
YV9sb2dfYnVmICYmICghY3RybC0+bWF4X25hbWVzcGFjZXMgfHwKPiArCQkJCSAgY3RybC0+bWF4
X25hbWVzcGFjZXMgPiBsZTMyX3RvX2NwdShpZC0+bm4pKSkgewo+ICsJCWRldl9lcnIoY3RybC0+
ZGV2aWNlLAo+ICsJCQkiSW52YWxpZCBNTkFOIHZhbHVlICV1XG4iLCBjdHJsLT5tYXhfbmFtZXNw
YWNlcyk7Cj4gKwkJcmV0ID0gLUVJTlZBTDsKPiArCQlnb3RvIG91dF9mcmVlOwo+ICsJfQo+ICsj
ZW5kaWYKPiArCj4gIAlpZiAoY3RybC0+YXBzdF9lbmFibGVkICYmICFwcmV2X2Fwc3RfZW5hYmxl
ZCkKPiAgCQlkZXZfcG1fcW9zX2V4cG9zZV9sYXRlbmN5X3RvbGVyYW5jZShjdHJsLT5kZXZpY2Up
Owo+ICAJZWxzZSBpZiAoIWN0cmwtPmFwc3RfZW5hYmxlZCAmJiBwcmV2X2Fwc3RfZW5hYmxlZCkK
PiAKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoK
SGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFy
Y2hpdGVjdApoYXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApT
VVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIDkwNDA5IE7DvHJuYmVyZwpHRjog
Ri4gSW1lbmTDtnJmZmVyLCBIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZykKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0
CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
