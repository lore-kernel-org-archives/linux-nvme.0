Return-Path: <SRS0=/f9n=N4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1E9C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 06:16:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4646B60F12
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 06:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4646B60F12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SziGcM01D2Ow4wh9+ogyILNbKp/pDUhT9JxQuV/V85A=; b=Ors3BkowRdJ+QkJsT/MoPUi9a9
	4wFyPiBo4mQmoQfWE9Mz46FUb9qn5UW00gIbrHHtyXvKD8rYI251z7Akunfwy7B1NEKDoq3gRrK0y
	TxHwb994QrxEa1AUOtKEj2+3pDK2uugDoD5PJfDK2CRBWADWFHUb4+7+gNlEQQ4wH2JvIhRAY1hxS
	SqxNDAInBCXSslcIujWVZbpA4sXwLUDv3YTueQAkULvA92XVkr4Ngy4EjkomSgsJknZ2meNEPW7ct
	LntgZERg8c4biZ/iv8iEU0V6ZqCprL5YklcMaTTcJFLN4XAc1SXb460s2+sFgClk5jgH6NNERsjui
	77mb5jdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mN7vq-00HNof-Uy; Mon, 06 Sep 2021 06:16:38 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mN7vo-00HNnA-5M
 for linux-nvme@lists.infradead.org; Mon, 06 Sep 2021 06:16:37 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B8DD32007F;
 Mon,  6 Sep 2021 06:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1630908994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kg4Wg8l9Kk8kQXbHb+Zd/FuQr2WxF39YElxb+dyQ+VE=;
 b=jUKgUkat+IWhWae9SRap4L0fOrkeAZYxNNu3dInXbGvI0NwGondgJOGBQ3nqMwT87HBvDx
 IiCWFhf0JbwgMc/IBcVoQrOD2wWgHtscQ49PVA/dZUyLxfE6EgXuAoeQbNEp7Mk/SzVzIn
 aB7KnTqlbofAItfphmfIvnFPK76BTF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1630908994;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kg4Wg8l9Kk8kQXbHb+Zd/FuQr2WxF39YElxb+dyQ+VE=;
 b=KrMO6ehR/K/zkDmPLkRvTxvqE5GVaXbGNecWPadjaqC3QuTyW1pJ2aFh5QHeu/H57K2JPF
 RApH1raAUiWxbPDw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B8ACF13299;
 Mon,  6 Sep 2021 06:16:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id lP1cKkGyNWFKTwAAGKfGzw
 (envelope-from <hare@suse.de>); Mon, 06 Sep 2021 06:16:33 +0000
Subject: Re: [PATCH v3 3/8] nvme: add error handling support for add_disk()
To: Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
 martin.petersen@oracle.com, jejb@linux.ibm.com, kbusch@kernel.org,
 sagi@grimberg.me, adrian.hunter@intel.com, beanhuo@micron.com,
 ulf.hansson@linaro.org, avri.altman@wdc.com, swboyd@chromium.org,
 agk@redhat.com, snitzer@redhat.com, josef@toxicpanda.com
Cc: hch@infradead.org, bvanassche@acm.org, ming.lei@redhat.com,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mmc@vger.kernel.org, dm-devel@redhat.com, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
References: <20210830212538.148729-1-mcgrof@kernel.org>
 <20210830212538.148729-4-mcgrof@kernel.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <677ca876-b003-d3b5-9e2e-d50ebef82cce@suse.de>
Date: Mon, 6 Sep 2021 08:16:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210830212538.148729-4-mcgrof@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210905_231636_389095_44880EBC 
X-CRM114-Status: GOOD (  20.78  )
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

T24gOC8zMC8yMSAxMToyNSBQTSwgTHVpcyBDaGFtYmVybGFpbiB3cm90ZToKPiBXZSBuZXZlciBj
aGVja2VkIGZvciBlcnJvcnMgb24gYWRkX2Rpc2soKSBhcyB0aGlzIGZ1bmN0aW9uCj4gcmV0dXJu
ZWQgdm9pZC4gTm93IHRoYXQgdGhpcyBpcyBmaXhlZCwgdXNlIHRoZSBzaGlueSBuZXcKPiBlcnJv
ciBoYW5kbGluZy4KPiAKPiBSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3Qu
ZGU+Cj4gU2lnbmVkLW9mZi1ieTogTHVpcyBDaGFtYmVybGFpbiA8bWNncm9mQGtlcm5lbC5vcmc+
Cj4gLS0tCj4gICBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgfCA5ICsrKysrKysrLQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMK
PiBpbmRleCA4Njc5YTEwOGY1NzEuLjY4N2QzYmU1NjNhMyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L252bWUvaG9zdC9jb3JlLmMKPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiBAQCAt
Mzc2Myw3ICszNzYzLDkgQEAgc3RhdGljIHZvaWQgbnZtZV9hbGxvY19ucyhzdHJ1Y3QgbnZtZV9j
dHJsICpjdHJsLCB1bnNpZ25lZCBuc2lkLAo+ICAgCj4gICAJbnZtZV9nZXRfY3RybChjdHJsKTsK
PiAgIAo+IC0JZGV2aWNlX2FkZF9kaXNrKGN0cmwtPmRldmljZSwgbnMtPmRpc2ssIG52bWVfbnNf
aWRfYXR0cl9ncm91cHMpOwo+ICsJaWYgKGRldmljZV9hZGRfZGlzayhjdHJsLT5kZXZpY2UsIG5z
LT5kaXNrLCBudm1lX25zX2lkX2F0dHJfZ3JvdXBzKSkKPiArCQlnb3RvIG91dF9jbGVhbnVwX25z
X2Zyb21fbGlzdDsKPiArCj4gICAJaWYgKCFudm1lX25zX2hlYWRfbXVsdGlwYXRoKG5zLT5oZWFk
KSkKPiAgIAkJbnZtZV9hZGRfbnNfY2Rldihucyk7Cj4gICAKPiBAQCAtMzc3Myw2ICszNzc1LDEx
IEBAIHN0YXRpYyB2b2lkIG52bWVfYWxsb2NfbnMoc3RydWN0IG52bWVfY3RybCAqY3RybCwgdW5z
aWduZWQgbnNpZCwKPiAgIAo+ICAgCXJldHVybjsKPiAgIAo+ICsgb3V0X2NsZWFudXBfbnNfZnJv
bV9saXN0Ogo+ICsJbnZtZV9wdXRfY3RybChjdHJsKTsKPiArCWRvd25fd3JpdGUoJmN0cmwtPm5h
bWVzcGFjZXNfcndzZW0pOwo+ICsJbGlzdF9kZWxfaW5pdCgmbnMtPmxpc3QpOwo+ICsJdXBfd3Jp
dGUoJmN0cmwtPm5hbWVzcGFjZXNfcndzZW0pOwo+ICAgIG91dF91bmxpbmtfbnM6Cj4gICAJbXV0
ZXhfbG9jaygmY3RybC0+c3Vic3lzLT5sb2NrKTsKPiAgIAlsaXN0X2RlbF9yY3UoJm5zLT5zaWJs
aW5ncyk7Cj4gCkkgd291bGQgcmF0aGVyIHR1cm4gdGhpcyBhcm91bmQsIGFuZCBjYWxsICdudm1l
X3B1dF9jdHJsKCknIGFmdGVyIApyZW1vdmluZyB0aGUgbmFtZXNwYWNlIGZyb20gdGhlIGxpc3Qu
IEJ1dCBpdCdzIHByb2JhYmx5IG1vcmUgYSBzdHlsZSAKaXNzdWUsIGNvbWUgdG8gdGhpbmsgb2Yg
aXQuCgpSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMs
CgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0
b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRz
dHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6Rm
dHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW52bWUK
