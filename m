Return-Path: <SRS0=y/hj=KX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F9BC47087
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 11:14:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4753D613C9
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 11:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4753D613C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=6TXFUOUIvLmnYJRKWpojv2jdo10GaahhIKxPRWf2svY=; b=K2mwutCc7u7T9hSMD8r1l3rFHK
	hOgfkBZD1Um4jJ45wasm8/YogeecgjxB6c+8JlYN06s5KqRIjCufXIVvj3EDDOmCEfdvpEujhrjrT
	IUm9jJysaojRrV4oWl/MJOjHWhk9GbmaXnIqJIjYQUe4i5SHYu/O3yeylhHBNOW0CIOpCiPx4UtPP
	p3tIsytUUnkoZ2kVE1d8KbJTprqBUm/YELw1lQvV1qiH3g7YiCNVL5IOiNmI10BzoKecfaxblwKVN
	LVXYGOdYTs2Q9moN6PiANKyVXIUKiGPYzIa74D3WPd6BSs2+IzDBS5sqjBvn1fyRoqChCeQZDoWri
	2bKXrgaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmaRI-00EiYz-Bs; Fri, 28 May 2021 11:14:04 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmZZz-00EJnc-MG
 for linux-nvme@lists.infradead.org; Fri, 28 May 2021 10:19:01 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1144A1FD2E;
 Fri, 28 May 2021 10:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622197138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBhUat4GnoA52vhi8JcgynrGRIIB4YwYrSWLCjF2Sr4=;
 b=EdSfkLqyDHiAd7FJQDYMa164amxKYbz7iftFwmLekoj9t7FCDOhfcAGqs+tqlUVB4/CBG0
 oOd0UNwx7lA+buiCE+eJ3DZ9p7Q4mlBsgGTbz3PGeX6TBbz8+Z8UyLSt6hD7Yhu6sykR1U
 hXqavcSZAu0WviEfg8aiGEi/j8N0558=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622197138;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBhUat4GnoA52vhi8JcgynrGRIIB4YwYrSWLCjF2Sr4=;
 b=7g63VftgwsXoUjqdPKXqlYISWrleEyV2XlA/R6kcGQp2Bgk8r8gbFmyBcfXAoCFmyrGWJ4
 FqlIDoIdHyuAc9Aw==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
 by imap.suse.de (Postfix) with ESMTPSA id D065711A98;
 Fri, 28 May 2021 10:18:57 +0000 (UTC)
Subject: Re: [RFC PATCH v6 03/27] nvme-fabrics: Expose
 nvmf_check_required_opts() globally
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, davem@davemloft.net, kuba@kernel.org,
 sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org
Cc: aelior@marvell.com, mkalderon@marvell.com, okulkarni@marvell.com,
 pkushwaha@marvell.com, malin1024@gmail.com
References: <20210527235902.2185-1-smalin@marvell.com>
 <20210527235902.2185-4-smalin@marvell.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <f37e7e6f-be53-ca80-b170-311e52d687a1@suse.de>
Date: Fri, 28 May 2021 12:18:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210527235902.2185-4-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210528_031859_967653_7E4F0AF0 
X-CRM114-Status: GOOD (  15.81  )
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

T24gNS8yOC8yMSAxOjU4IEFNLCBTaGFpIE1hbGluIHdyb3RlOgo+IEZyb206IFByYWJoYWthciBL
dXNod2FoYSA8cGt1c2h3YWhhQG1hcnZlbGwuY29tPgo+IAo+IG52bWZfY2hlY2tfcmVxdWlyZWRf
b3B0cygpIGlzIHVzZWQgdG8gY2hlY2sgaWYgdXNlciBwcm92aWRlZCBvcHRzIGhhcwo+IHRoZSBy
ZXF1aXJlZF9vcHRzIG9yIG5vdC4gaWYgbm90LCBpdCB3aWxsIGxvZyB3aGljaCBvcHRpb25zIGFy
ZSBub3QKPiBwcm92aWRlZC4KPiAKPiBJdCBjYW4gYmUgbGV2ZXJhZ2VkIGJ5IG52bWUtdGNwLW9m
ZmxvYWQgdG8gY2hlY2sgaWYgcHJvdmlkZWQgb3B0cyBhcmUKPiBzdXBwb3J0ZWQgYnkgdGhpcyBz
cGVjaWZpYyB2ZW5kb3IgZHJpdmVyIG9yIG5vdC4KPiAKPiBTbyBleHBvc2UgbnZtZl9jaGVja19y
ZXF1aXJlZF9vcHRzKCkgZ2xvYmFsbHkuCj4gCj4gQWNrZWQtYnk6IElnb3IgUnVzc2tpa2ggPGly
dXNza2lraEBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBQcmFiaGFrYXIgS3VzaHdhaGEg
PHBrdXNod2FoYUBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBPbWthciBLdWxrYXJuaSA8
b2t1bGthcm5pQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhbCBLYWxkZXJvbiA8
bWthbGRlcm9uQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEFyaWVsIEVsaW9yIDxhZWxp
b3JAbWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogU2hhaSBNYWxpbiA8c21hbGluQG1hcnZl
bGwuY29tPgo+IC0tLQo+ICBkcml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmMgfCA1ICsrKy0tCj4g
IGRyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuaCB8IDIgKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gClJldmlld2VkLWJ5OiBIYW5uZXMgUmVp
bmVja2UgPGhhcmVAc3VzZS5kZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWlu
ZWNrZQkJICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlCQkJICAg
ICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2Vy
bWFueSBHbWJILCA5MDQwOSBOw7xybmJlcmcKR0Y6IEYuIEltZW5kw7ZyZmZlciwgSFJCIDM2ODA5
IChBRyBOw7xybmJlcmcpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dm1lCg==
