Return-Path: <SRS0=Qryz=E2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8816C5519F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 07:58:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7D9222BA
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2020 07:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GIA4qn4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7D9222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=woBxG1FVbOuMYCLsY9KhGChIIzUP8NTOSxLaKOpBe9M=; b=GIA4qn4eObuK2e6ebh30U3yqC
	1Yylmf/W4M2429vw6WQZ/F4QpHwfzhZ/vJ+zgarTiPi7jFjv3ZLUbayV6U16kwn2Mwaq/1zmBOhqE
	KHkUXLiKIvxmYcF3xOc8YZ8jHjI6cWTrPC3aLfpF7Jdbe+dSrh90m9oTtu1dMttcVoDeI6BnRi1C9
	zk2xjB+WOwsakjgZaKExSb2pQEjscQEc2enFngDuEkp1kVOA5CTjbQbtGtU6DsXdXUCf/OT08z/Cy
	qstSf7S7SMkScyld85Toilg5wtUu6C2itR4vJLMsCfbkQh/Ws953QuKubZ4iQGv/U1ZeSMErhPoAD
	Ttt2k0mbw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kg1JG-0002VH-Jo; Fri, 20 Nov 2020 07:58:22 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kg1JC-0002Th-Hp
 for linux-nvme@lists.infradead.org; Fri, 20 Nov 2020 07:58:20 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 75B07AC0C;
 Fri, 20 Nov 2020 07:58:17 +0000 (UTC)
Subject: Re: [PATCH 70/78] block: replace bd_mutex with a per-gendisk mutex
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20201116145809.410558-1-hch@lst.de>
 <20201116145809.410558-71-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c854459e-d124-d0fd-2159-d40ef4d6ca75@suse.de>
Date: Fri, 20 Nov 2020 08:58:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201116145809.410558-71-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201120_025818_745890_2668A936 
X-CRM114-Status: GOOD (  19.95  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvMTYvMjAgMzo1OCBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gYmRfbXV0ZXgg
aXMgcHJpbWFyaWx5IHVzZWQgZm9yIHN5bmNocm9uaXppbmcgdGhlIGJsb2NrIGRldmljZSBvcGVu
IGFuZAo+IHJlbGVhc2UgcGF0aCwgd2hpY2ggcmVjdXJzZXMgZnJvbSBwYXJ0aXRpb25zIHRvIHRo
ZSB3aG9sZSBkaXNrIGRldmljZS4KPiBUaGUgZmFjdCB0aGF0IHdlIGhhdmUgdHdvIGxvY2tzIG1h
a2VzIGxpZmUgdW5uZWNlc3NhcmlseSBjb21wbGV4IGR1ZQo+IHRvIGxvY2sgb3JkZXIgY29uc3Ry
YWlucy4gIFJlcGxhY2UgdGhlIHR3byBsZXZlbHMgb2YgbG9ja2luZyB3aXRoIGEKPiBzaW5nbGUg
bXV0ZXggaW4gdGhlIGdlbmRpc2sgc3RydWN0dXJlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IENocmlz
dG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+IC0tLQo+ICAgYmxvY2svZ2VuaGQuYyAgICAgICAg
ICAgICAgICAgICB8ICA3ICsrLS0KPiAgIGJsb2NrL2lvY3RsLmMgICAgICAgICAgICAgICAgICAg
fCAgNCArLQo+ICAgYmxvY2svcGFydGl0aW9ucy9jb3JlLmMgICAgICAgICB8IDIyICsrKysrLS0t
LS0KPiAgIGRyaXZlcnMvYmxvY2svbG9vcC5jICAgICAgICAgICAgfCAxNCArKystLS0tCj4gICBk
cml2ZXJzL2Jsb2NrL3hlbi1ibGtmcm9udC5jICAgIHwgIDggKystLQo+ICAgZHJpdmVycy9ibG9j
ay96cmFtL3pyYW1fZHJ2LmMgICB8ICA0ICstCj4gICBkcml2ZXJzL2Jsb2NrL3pyYW0venJhbV9k
cnYuaCAgIHwgIDIgKy0KPiAgIGRyaXZlcnMvbWQvbWQuaCAgICAgICAgICAgICAgICAgfCAgNyAr
LS0tCj4gICBkcml2ZXJzL3MzOTAvYmxvY2svZGFzZF9nZW5oZC5jIHwgIDggKystLQo+ICAgZHJp
dmVycy9zY3NpL3NkLmMgICAgICAgICAgICAgICB8ICA0ICstCj4gICBmcy9ibG9ja19kZXYuYyAg
ICAgICAgICAgICAgICAgIHwgNzEgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tCj4g
ICBmcy9idHJmcy92b2x1bWVzLmMgICAgICAgICAgICAgIHwgIDIgKy0KPiAgIGZzL3N1cGVyLmMg
ICAgICAgICAgICAgICAgICAgICAgfCAgOCArKy0tCj4gICBpbmNsdWRlL2xpbnV4L2Jsa190eXBl
cy5oICAgICAgIHwgIDEgLQo+ICAgaW5jbHVkZS9saW51eC9nZW5oZC5oICAgICAgICAgICB8ICAx
ICsKPiAgIDE1IGZpbGVzIGNoYW5nZWQsIDgwIGluc2VydGlvbnMoKyksIDgzIGRlbGV0aW9ucygt
KQo+IApSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMs
CgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0
b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRz
dHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6Rm
dHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW52bWUK
