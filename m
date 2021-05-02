Return-Path: <SRS0=wOI1=J5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57D6C433B4
	for <linux-nvme@archiver.kernel.org>; Sun,  2 May 2021 11:13:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7795960234
	for <linux-nvme@archiver.kernel.org>; Sun,  2 May 2021 11:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7795960234
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aOkqMQFk9Nz07XHWTTwt2NF/DaZLwqqHq7qgxxLjdPw=; b=dXc3BEtNktkX5t+7L3aYhNBvS
	WxS5c4o7mcqxz/63hzScJhqL8BmaEBklN7M7ARAEsDCEr1YBPoA9ik7Abuvk0X6f+0xIOzACCYIFu
	sKaFz6VwB1ZQplTTU2vRvecFeAhkhIj+MtLrGVlpPXrWZGZqmSdf3W0S+NC5+b5cLgx8iwUrACtnP
	24pWWw9DvE2pwh6+sB2CL0i7U9tjP/dIc14ftI9kBPKUMWVmFVEIkvqTqH2/TYZcNyZZaN4SQ20xz
	3/S8RpDOPO8rvAF7Og0dNaRvRtHDUwSgu85srDBP7f8IoIGQMUCPi05JODJ8rsLC+AKrTL1oeXc2A
	Fy9xJ9ojg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldA2N-00BedK-7G; Sun, 02 May 2021 11:13:23 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldA2L-00Bed9-N6
 for linux-nvme@desiato.infradead.org; Sun, 02 May 2021 11:13:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=lf8JeLj0XhVyDBAf8R1qxoxXa4erQjSZOdLmSr8cUD4=; b=jTEo+vO5K7o83aZUAcUjY38ljX
 VILApiTnluqq/YUTYO0GTWzpAxz/eJqNM7Wm5w4zn4O34ccihpQnOuD9NM+ShHCE7ZGODkJ5dLLBI
 VhtuY+DJUVQcF+sNCfhpZja6UGI+I2cGADELA37BX6DSTCGCmMoxJI4dBOaUtD5dZvOZKbpV4YxNu
 TqJLN+QToQUaLPY15DzuxZ7akouBhO8xbPDbkQe/w2XcrrkoZG7qUXLaUpgwssgMOJPmLgde1YXpP
 UR1L1rZeA33gy8sCxeqbaktcKluDYbr65gdg2xALZvzYQ8rNmWHfsAm5wy4tu7w7bkRC0kX2h6kbo
 7CDfMGDw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldA2J-002UaU-7O
 for linux-nvme@lists.infradead.org; Sun, 02 May 2021 11:13:20 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E229DAFAB;
 Sun,  2 May 2021 11:13:17 +0000 (UTC)
Subject: Re: [RFC PATCH v4 04/27] qed: Add support of HW filter block
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org
Cc: "David S . Miller davem @ davemloft . net --cc=Jakub Kicinski"
 <kuba@kernel.org>, aelior@marvell.com, mkalderon@marvell.com,
 okulkarni@marvell.com, pkushwaha@marvell.com, malin1024@gmail.com
References: <20210429190926.5086-1-smalin@marvell.com>
 <20210429190926.5086-5-smalin@marvell.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <761a58da-2933-4750-510e-c12dfe8f919c@suse.de>
Date: Sun, 2 May 2021 13:13:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210429190926.5086-5-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210502_041319_435961_F2CE9B29 
X-CRM114-Status: GOOD (  13.08  )
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

T24gNC8yOS8yMSA5OjA5IFBNLCBTaGFpIE1hbGluIHdyb3RlOgo+IEZyb206IFByYWJoYWthciBL
dXNod2FoYSA8cGt1c2h3YWhhQG1hcnZlbGwuY29tPgo+IAo+IFRoaXMgcGF0Y2ggaW50cm9kdWNl
cyB0aGUgZnVuY3Rpb25hbGl0eSBvZiBIVyBmaWx0ZXIgYmxvY2suCj4gSXQgYWRkcyBhbmQgcmVt
b3ZlcyBmaWx0ZXJzIGJhc2VkIG9uIHNvdXJjZSBhbmQgdGFyZ2V0IFRDUCBwb3J0Lgo+IAo+IEl0
IGFsc28gYWRkIGZ1bmN0aW9uYWxpdHkgdG8gY2xlYXIgYWxsIGZpbHRlcnMgYXQgb25jZS4KPiAK
PiBBY2tlZC1ieTogSWdvciBSdXNza2lraCA8aXJ1c3NraWtoQG1hcnZlbGwuY29tPgo+IFNpZ25l
ZC1vZmYtYnk6IFByYWJoYWthciBLdXNod2FoYSA8cGt1c2h3YWhhQG1hcnZlbGwuY29tPgo+IFNp
Z25lZC1vZmYtYnk6IE9ta2FyIEt1bGthcm5pIDxva3Vsa2FybmlAbWFydmVsbC5jb20+Cj4gU2ln
bmVkLW9mZi1ieTogU2hhaSBNYWxpbiA8c21hbGluQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYt
Ynk6IE1pY2hhbCBLYWxkZXJvbiA8bWthbGRlcm9uQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYt
Ynk6IEFyaWVsIEVsaW9yIDxhZWxpb3JAbWFydmVsbC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL25l
dC9ldGhlcm5ldC9xbG9naWMvcWVkL3FlZC5oICAgICAgICAgfCAgMTAgKysKPiAgIGRyaXZlcnMv
bmV0L2V0aGVybmV0L3Fsb2dpYy9xZWQvcWVkX2Rldi5jICAgICB8IDEwNyArKysrKysrKysrKysr
KysrKysKPiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L3Fsb2dpYy9xZWQvcWVkX252bWV0Y3AuYyB8
ICAgNSArCj4gICBpbmNsdWRlL2xpbnV4L3FlZC9xZWRfbnZtZXRjcF9pZi5oICAgICAgICAgICAg
fCAgMjQgKysrKwo+ICAgNCBmaWxlcyBjaGFuZ2VkLCAxNDYgaW5zZXJ0aW9ucygrKQo+IApSZXZp
ZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMK
LS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJj
aGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEg
NzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkw
NDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVy
OiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW52bWUK
