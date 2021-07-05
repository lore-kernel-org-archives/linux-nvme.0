Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAD3C07E98
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 04:00:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 060BB613B0
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 04:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060BB613B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Oc92f50a0WtKyTc/EzolgghssWCZotopTH5X3HWvCs=; b=ATSBNrLGua4FSeeUBiUDGsZT9C
	XqZt5OemIHxGhLHXBsa44WAbHKRJtlMiEkBSklx96Ea/xyoloOcJbf6ejn/QRmJnuSoluOb3v0SRo
	Ezb8Uv3JmYUApdHUD6EvsBawJ3MmmRKFJPuPDNuW40R2Xd0+YNuGhTx7sDWSl/JuTN835LARvnBAX
	fnfWipBf92srEscAf6+7JYyAr1NKyKgr9KYpG4wPd6rkq8mm90glPTwrnPGhyj+aUppl9LSy5sdbS
	15ovA9NLolmfXo8FG4R01SMAIK5SgJakEa4J4FSpmR25U7vLlxcp7BqgnomN/SaVWq/u5/f9k1f0j
	Tsc8QFfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0Fly-007jol-6R; Mon, 05 Jul 2021 03:59:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0Flv-007jmO-4B
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 03:59:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625457589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WXgO0oXmvf/9A/1qL8w68Z6/mTqGpM66mMODKwc4Vbo=;
 b=Y/9V0wYz2D2UIwkSGFcyEkae9nfVeIZazhC/ybBGmZ76jxea1C92woiXcSOen/XYnaM1Cp
 C9VS2LKHpIHzhdR/n/vx5Td5FeH4LQY30XVvFNLLIrT6SZKq1e/wUxyi9dhVYn23U6qzGh
 sQcwgICOrDsmIY0YNtWNTGQhN24rcKE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-2RgpOLynPkuMSnPT0Q2Wow-1; Sun, 04 Jul 2021 23:59:48 -0400
X-MC-Unique: 2RgpOLynPkuMSnPT0Q2Wow-1
Received: by mail-pl1-f200.google.com with SMTP id
 x15-20020a170902e04fb02900f5295925dbso5831927plx.9
 for <linux-nvme@lists.infradead.org>; Sun, 04 Jul 2021 20:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=WXgO0oXmvf/9A/1qL8w68Z6/mTqGpM66mMODKwc4Vbo=;
 b=JX9+eEwp54A4jRfTYjf06e5CVmStROZOm+ER/lcH2ub6G7cYd4j4CjrHRkjCqktUgP
 YpDmJKbKJyxR3Hc850Prul4Hx7k9cuL40W/GhbHM1IEDcU4JZSl/bq4jKa4wPhwuuwnE
 GZntHMVLsZUJtRUYwQUosnLsqakShbOAO+7G/oTwleEs+IZDA6BWDKD3qFJcdDfnGi6t
 qPjQ/ZK7WNU3JST8hwshbIu2RSo3s8Pm+Nrf1kgFP8wkVx5CHE11Eia8xG+hXr8u3tuI
 DWGUcBwHctBTp6/LmCetg6ArryVOVT1fUTzGI4sWs+XJYTAGFmJOs7WWCJHDpBxeWsYV
 jiDA==
X-Gm-Message-State: AOAM531sue17EewNMaqWqsjGZYFD8iZ8XP5tjcp3vlcrQtXBYHyG3rQw
 HChR5vDJe6/9bUJ37ZNKgbXuZKw6sfoPFuJRwLXsPZkI5GCf3fO9XSh9xho9/xsEN95PdPh1K/5
 VvHiD7Z415PBm/nSyvobRGcrAtRI=
X-Received: by 2002:a17:90a:af90:: with SMTP id
 w16mr13185189pjq.129.1625457587010; 
 Sun, 04 Jul 2021 20:59:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7m1tdef3U/fD1ZeJXGh6nhQJM7pMQfOcmUl03cSHKc5dhYUnHwmNe0pBMkiHdPgpxcvo9fQ==
X-Received: by 2002:a17:90a:af90:: with SMTP id
 w16mr13185164pjq.129.1625457586781; 
 Sun, 04 Jul 2021 20:59:46 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id k9sm526132pfu.100.2021.07.04.20.59.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jul 2021 20:59:46 -0700 (PDT)
Subject: Re: [PATCH V2 5/6] virtio: add one field into virtio_device for
 recording if device uses managed irq
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, John Garry <john.garry@huawei.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Damien Le Moal <damien.lemoal@wdc.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, virtualization@lists.linux-foundation.org
References: <20210702150555.2401722-1-ming.lei@redhat.com>
 <20210702150555.2401722-6-ming.lei@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fbe8e661-86c7-ef79-1c61-884715b64e87@redhat.com>
Date: Mon, 5 Jul 2021 11:59:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702150555.2401722-6-ming.lei@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210704_205951_365883_91010254 
X-CRM114-Status: GOOD (  20.20  )
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CtTaIDIwMjEvNy8yIM/CzucxMTowNSwgTWluZyBMZWkg0LS1wDoKPiBibGstbXEgbmVlZHMgdG8g
a25vdyBpZiB0aGUgZGV2aWNlIHVzZXMgbWFuYWdlZCBpcnEsIHNvIGFkZCBvbmUgZmllbGQKPiB0
byB2aXJ0aW9fZGV2aWNlIGZvciByZWNvcmRpbmcgaWYgZGV2aWNlIHVzZXMgbWFuYWdlZCBpcnEu
Cj4KPiBJZiB0aGUgZHJpdmVyIHVzZSBtYW5hZ2VkIGlycSwgdGhpcyBmbGFnIGhhcyB0byBiZSBz
ZXQgc28gaXQgY2FuIGJlCj4gcGFzc2VkIHRvIGJsay1tcS4KPgo+IENjOiAiTWljaGFlbCBTLiBU
c2lya2luIjxtc3RAcmVkaGF0LmNvbT4KPiBDYzogSmFzb24gV2FuZzxqYXNvd2FuZ0ByZWRoYXQu
Y29tPgo+IENjOnZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj4gU2ln
bmVkLW9mZi1ieTogTWluZyBMZWk8bWluZy5sZWlAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIGRyaXZl
cnMvYmxvY2svdmlydGlvX2Jsay5jICAgICAgICAgfCAyICsrCj4gICBkcml2ZXJzL3Njc2kvdmly
dGlvX3Njc2kuYyAgICAgICAgIHwgMSArCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2Nv
bW1vbi5jIHwgMSArCj4gICBpbmNsdWRlL2xpbnV4L3ZpcnRpby5oICAgICAgICAgICAgIHwgMSAr
Cj4gICA0IGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvYmxvY2svdmlydGlvX2Jsay5jIGIvZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMKPiBp
bmRleCBlNGJkM2IxZmMzYzIuLjMzYjljODBhYzQ3NSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2Js
b2NrL3ZpcnRpb19ibGsuYwo+ICsrKyBiL2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jCj4gQEAg
LTc2NCw2ICs3NjQsOCBAQCBzdGF0aWMgaW50IHZpcnRibGtfcHJvYmUoc3RydWN0IHZpcnRpb19k
ZXZpY2UgKnZkZXYpCj4gICAJdmJsay0+dGFnX3NldC5xdWV1ZV9kZXB0aCA9IHF1ZXVlX2RlcHRo
Owo+ICAgCXZibGstPnRhZ19zZXQubnVtYV9ub2RlID0gTlVNQV9OT19OT0RFOwo+ICAgCXZibGst
PnRhZ19zZXQuZmxhZ3MgPSBCTEtfTVFfRl9TSE9VTERfTUVSR0U7Cj4gKwlpZiAodmRldi0+dXNl
X21hbmFnZWRfaXJxKQo+ICsJCXZibGstPnRhZ19zZXQuZmxhZ3MgfD0gQkxLX01RX0ZfTUFOQUdF
RF9JUlE7CgoKSSdtIG5vdCBmYW1pbGlhciB3aXRoIGJsayBtcS4KCkJ1dCB0aGUgbmFtZSBpcyBr
aW5kIG9mIGNvbmZ1c2luZywgSSBndWVzcyAKIkJMS19NUV9GX0FGRklOSVRZX01BTkFHRURfSVJR
IiBpcyBiZXR0ZXI/IChDb25zaWRlciB3ZSBoYWQgCiJJUlFEX0FGRklOSVRZX01BTkFHRUQiKQoK
VGhpcyBoZWxwcyBtZSB0byBkaWZmZXIgdGhpcyBmcm9tIHRoZSBkZXZyZXMgKGRldmljZSBtYW5h
Z2VkIElSUSkgYXQgbGVhc3QuCgpUaGFua3MKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbnZtZQo=
