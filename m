Return-Path: <SRS0=wOI1=J5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A437C433B4
	for <linux-nvme@archiver.kernel.org>; Sun,  2 May 2021 11:58:17 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD79611AC
	for <linux-nvme@archiver.kernel.org>; Sun,  2 May 2021 11:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD79611AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Nfm13O2s08Uye2W5MbJdTgydAhqsV5SfmR44cfnYbv4=; b=mSTrHop4Pf6ObYFlvr70CXZq4
	AqBAJkvykAQs2nIqSxn3qCFeujeBR3a0eo1SUXybO/nimEbLzhotsTbY8+8rxI2ZtArt+NBsptko9
	pdBiBtnKJpGX2BJW1/C1Pn8ua+3Uc8xxQoILa3l1XnKyP688ZKlHLRMlfKEpbev+Vkp+XOKJCagVE
	JTvETWoLLAbC9UUIe3svaQp9bAlL8TEBDObm1vMZdkrboqJGVaQmqzUyijrTAUoyFtKy/yjMI+rnY
	G8iihJakLm1Oey09YEjJS0kpa8qaOtsUyVjKmpUpVKirwT/OJjFL5MBsWOJjNdE2JCRnIDCufJtnq
	SUF3Oi4NA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldAjf-00BiW8-RD; Sun, 02 May 2021 11:58:08 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldAja-00BiVZ-8M
 for linux-nvme@desiato.infradead.org; Sun, 02 May 2021 11:58:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=IeOFlCpINjnocXjbfTHAEjagNvmcqVgMQ9wF6zK4JUE=; b=Ca8QUq1vpS5ew1Qwrpi5rPJODZ
 OPIhfw251usTUFP47awFKs6k+S5gR58Cm/o6l9uvPLviu1IRvLZmsRxCEwcRusDwo6PoE/Jl6Mx2B
 AGT6NqPY56NWiDulIYAPtxbuETj05LdnF08RPzZjSCxsxV9Jpj6bByfF7z8oq5dNkpqwLaiqetZY3
 yo501yhb1wQ0Wn33lP379MhaJhBVP5dRJh24qgE+4p3usdyvyH703iOHzVmI/c0E5vdG64d80WesA
 yLtlgrU5TUpN0wlanbhUk8WhwtZ/xADWVZQvyBxkhU5XA/OpB7vSmDZAUM2094Ww5/Vn+PKRGQZgD
 s80u3CQw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldAjX-002W4O-Ed
 for linux-nvme@lists.infradead.org; Sun, 02 May 2021 11:58:00 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 20701B1AE;
 Sun,  2 May 2021 11:57:58 +0000 (UTC)
Subject: Re: [RFC PATCH v4 26/27] qedn: Add Connection and IO level recovery
 flows
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org
Cc: "David S . Miller davem @ davemloft . net --cc=Jakub Kicinski"
 <kuba@kernel.org>, aelior@marvell.com, mkalderon@marvell.com,
 okulkarni@marvell.com, pkushwaha@marvell.com, malin1024@gmail.com
References: <20210429190926.5086-1-smalin@marvell.com>
 <20210429190926.5086-27-smalin@marvell.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <daa07a1c-add4-9f27-5f55-05b1191e85c1@suse.de>
Date: Sun, 2 May 2021 13:57:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210429190926.5086-27-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210502_045759_675616_F70460F9 
X-CRM114-Status: GOOD (  13.80  )
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

T24gNC8yOS8yMSA5OjA5IFBNLCBTaGFpIE1hbGluIHdyb3RlOgo+IFRoaXMgcGF0Y2ggd2lsbCBw
cmVzZW50IHRoZSBjb25uZWN0aW9uIGxldmVsIGZ1bmN0aW9uYWxpdGllczoKPiAgIC0gY29ubiBj
bGVhci1zcTogd2lsbCByZWxlYXNlIHRoZSBGVyByZXN0cmljdGlvbnMgaW4gb3JkZXIgdG8gZmx1
c2ggYWxsCj4gICAgIHRoZSBwZW5kaW5nIElPcy4KPiAgIC0gZHJhaW46IGluIGNhc2UgY2xlYXIt
c3EgaXMgc3R1Y2ssIHdpbGwgcmVsZWFzZSBhbGwgdGhlIGRldmljZSBGVwo+ICAgICByZXN0cmlj
dGlvbnMgaW4gb3JkZXIgdG8gZmx1c2ggYWxsIHRoZSBwZW5kaW5nIElPcy4KPiAgIC0gdGFzayBj
bGVhbnVwIC0gd2lsbCBmbHVzaCB0aGUgSU8gbGV2ZWwgcmVzb3VyY2VzLgo+IAo+IEFja2VkLWJ5
OiBJZ29yIFJ1c3NraWtoIDxpcnVzc2tpa2hAbWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTog
UHJhYmhha2FyIEt1c2h3YWhhIDxwa3VzaHdhaGFAbWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1i
eTogT21rYXIgS3Vsa2FybmkgPG9rdWxrYXJuaUBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5
OiBNaWNoYWwgS2FsZGVyb24gPG1rYWxkZXJvbkBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5
OiBBcmllbCBFbGlvciA8YWVsaW9yQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFNoYWkg
TWFsaW4gPHNtYWxpbkBtYXJ2ZWxsLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvbnZtZS9ody9xZWRu
L3FlZG4uaCAgICAgIHwgICA4ICsrCj4gICBkcml2ZXJzL252bWUvaHcvcWVkbi9xZWRuX2Nvbm4u
YyB8IDEzMyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCj4gICBkcml2ZXJzL252bWUv
aHcvcWVkbi9xZWRuX21haW4uYyB8ICAgMSArCj4gICBkcml2ZXJzL252bWUvaHcvcWVkbi9xZWRu
X3Rhc2suYyB8ICAyNyArKysrKystCj4gICA0IGZpbGVzIGNoYW5nZWQsIDE2NiBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQo+IApSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJl
QHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAg
ICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRp
b25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7D
vHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGlu
ZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
