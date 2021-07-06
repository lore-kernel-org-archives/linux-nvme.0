Return-Path: <SRS0=sCQG=L6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E448C07E96
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jul 2021 10:32:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA53E619AC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jul 2021 10:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA53E619AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RAL5JwT7afDAQ+B7aaWu5n45rzTy75v6FASPxZwBF18=; b=B6u57x7Ax0ld/erQifZSvog3x3
	t7zmi6XcjC57Q/lms9Q1o2Zm+xebXrLOuBDh0M6m6Et1k2W93ve13OfoKSZYTalBPust+dIjrtQCU
	9ExuJE1KesbKITswwMxorFaDap5LEPqoHxBP5eG67CwOA4d1jrT6lRCNkd30i21xraMKrL6EzqWKV
	d/uaKJq7iS8MTLmiBVsBJN244cUL99c+lxvNwJhSitV5VOu4hpt6PFQgJ0VfPYZxMBvweiTgW/6UE
	RHp5C+1DJ6dHGAfzNXUMc9ylv8YyGj/JwtgIhrcOtUwMyO5lDV7iFSRxSwVuE4Ujr+Qrzlprdv2Dl
	3EUEt/QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0iNX-00B2cP-NO; Tue, 06 Jul 2021 10:32:35 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0iNU-00B2af-N4
 for linux-nvme@lists.infradead.org; Tue, 06 Jul 2021 10:32:34 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6A2D4226DF;
 Tue,  6 Jul 2021 10:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625567549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oYa45f4FhhRp+3FK6NuiOaD625cS0Uqo4Ax5m9HnxYw=;
 b=NRj74pTdCy5DxHYIxwbfnLobgD/j6f23HzVf1OS9cvWIpyYUH8n+sd/dgaOSLmFDrHpQwW
 ntq1sDwz1GcrYxQPfeX1lejGBgKrhFPt/zH+Y9WApyi1yPwV8pPTrRHWhe6gW3wFhzk2lU
 RxnD8JjhQBW5aXrxZEc7cyAOxaw7AlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625567549;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oYa45f4FhhRp+3FK6NuiOaD625cS0Uqo4Ax5m9HnxYw=;
 b=+GzqWh4ZemorKBDqD5TsMk/iO0aFymDwcLq1fcK+Fv9dr8pvI2650ZYx/AMlfgFtXRywqv
 9NhBrXf50dxV8kCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1A6351372D;
 Tue,  6 Jul 2021 10:32:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id 3XK7Az0x5GAKZQAAGKfGzw
 (envelope-from <hare@suse.de>); Tue, 06 Jul 2021 10:32:29 +0000
Subject: Re: [PATCH V2 3/6] scsi: add flag of .use_managed_irq to 'struct
 Scsi_Host'
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.garry@huawei.com>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, Wen Xiong <wenxiong@us.ibm.com>,
 Keith Busch <kbusch@kernel.org>, Damien Le Moal <damien.lemoal@wdc.com>
References: <20210702150555.2401722-1-ming.lei@redhat.com>
 <20210702150555.2401722-4-ming.lei@redhat.com>
 <47fc5ed1-29e3-9226-a111-26c271cb6d90@huawei.com> <YOLXJZF7wo/IiFMU@T590>
 <20210706053719.GA17027@lst.de> <YOQJD2dgeb8wobOk@T590>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <fb71bccf-0d92-68ed-ad42-cac23fede5a8@suse.de>
Date: Tue, 6 Jul 2021 12:32:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOQJD2dgeb8wobOk@T590>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210706_033232_945527_289355A0 
X-CRM114-Status: GOOD (  18.91  )
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

T24gNy82LzIxIDk6NDEgQU0sIE1pbmcgTGVpIHdyb3RlOgo+IE9uIFR1ZSwgSnVsIDA2LCAyMDIx
IGF0IDA3OjM3OjE5QU0gKzAyMDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+PiBPbiBNb24s
IEp1bCAwNSwgMjAyMSBhdCAwNTo1NTo0OVBNICswODAwLCBNaW5nIExlaSB3cm90ZToKPj4+IFRo
ZSB0aGluZyBpcyB0aGF0IGJsa19tcV9wY2lfbWFwX3F1ZXVlcygpIGlzIGFsbG93ZWQgdG8gYmUg
Y2FsbGVkIGZvcgo+Pj4gbm9uLW1hbmFnZWQgaXJxcy4gQWxzbyBzb21lIG1hbmFnZWQgaXJxIGNv
bnN1bWVycyBkb24ndCB1c2UgYmxrX21xX3BjaV9tYXBfcXVldWVzKCkuCj4+Pgo+Pj4gU28gdGhp
cyB3YXkganVzdCBwcm92aWRlcyBoaW50IGFib3V0IG1hbmFnZWQgaXJxIHVzZXMsIGJ1dCB3ZSBy
ZWFsbHkKPj4+IG5lZWQgdG8gZ2V0IHRoaXMgZmxhZyBzZXQgaWYgZHJpdmVyIHVzZXMgbWFuYWdl
ZCBpcnEuCj4+Cj4+IGJsa19tcV9wY2lfbWFwX3F1ZXVlcyBpcyBhYnNvbHV0ZWx5IGludGVuZGVk
IHRvIG9ubHkgYmUgdXNlZCBieQo+PiBtYW5hZ2VkIGlycXMuICBJIHdvbmRlciBpZiB3ZSBjYW4g
ZW5mb3JjZSB0aGF0IHNvbWVob3c/Cj4gCj4gSXQgbWF5IGJyZWFrIHNvbWUgc2NzaSBkcml2ZXJz
Lgo+IAo+IEFuZCBibGtfbXFfcGNpX21hcF9xdWV1ZXMoKSBqdXN0IGNhbGxzIHBjaV9pcnFfZ2V0
X2FmZmluaXR5KCkgdG8KPiByZXRyaWV2ZSB0aGUgaXJxJ3MgYWZmaW5pdHksIGFuZCB0aGUgaXJx
IGNhbiBiZSBvbmUgbm9uLW1hbmFnZWQgaXJxLAo+IHdoaWNoIGFmZmluaXR5IGlzIHNldCB2aWEg
ZWl0aGVyIGlycV9zZXRfYWZmaW5pdHlfaGludCgpIGZyb20ga2VybmVsCj4gb3IgL3Byb2MvaXJx
Ly4KPiAKQnV0IHRoYXQncyBzdGF0aWMsIHJpZ2h0PyBJRSBibGtfbXFfcGNpX21hcF9xdWV1ZXMo
KSB3aWxsIGJlIGNhbGxlZCBvbmNlIApkdXJpbmcgbW9kdWxlIGluaXQ7IHNvIHdoYXQgaGFwcGVu
cyBpZiB0aGUgdXNlciBjaGFuZ2VzIHRoZSBtYXBwaW5nIApsYXRlciBvbj8gSG93IHdpbGwgdGhh
dCBiZSB0cmFuc2ZlcnJlZCB0byB0aGUgZHJpdmVyPwoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4g
SGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApo
YXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4
OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xy
bmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXgg
SW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1l
Cg==
