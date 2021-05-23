Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DD8C2B9F8
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 20:43:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A52D46140B
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 20:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52D46140B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lVW9s6Bz3JXSPGKphGjdhMkzq2HT8fktKzl8rqxalck=; b=O7P5KiLtR4b1rW8SvlSbgAd8Y
	GgMV8zfppSIvQdXUOr6aBnMAcug+naD5+1YWjSNaqxTMkAtUmom4tyMHyBSJ2aOO3uaJb1o/AV1UG
	AfCry8Gp5wkUw6CvfXxWki943m/KADY3g/ZxTgW3mFdxES1hnUmv4qnVGfLp097xiBzc+HZyLQWys
	VWJSeGe+s0Y1JydsnbCT8CIbgSY02CWMRw50N+fOX6lGTXTvExVgOJYwlZSRQDAM2WbCZAJNP/mwj
	T0ApWTTAZOB9a+jy3B66HOYFR/L/ey9TlS+5hbMX2F5KYoYF3Fzq0w9eyr3594ACaOfirpXGlZFjh
	SD8mAeAFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llHPR-001qsH-L8; Mon, 24 May 2021 20:42:46 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkjQP-00439K-23
 for linux-nvme@desiato.infradead.org; Sun, 23 May 2021 08:25:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=iVOkU6mPxfn5BVd8GlNU1HfGC6hDoW8TTxQlBhTR3w4=; b=rd+BNofqXLhPx2c5oxD87/STlS
 xu7deksoepH0Z4WEeT4+K1KTgLdswK6SDp3aX6Gd0R5EFjTf6/JFoslSIwgSCA9QxodbRo+4/Bhpt
 0tIrkU/+bbYxU+6N2bBm8s4+B9FL7fY48oQUrd/63Y2Rt3rgxiPrBG69ehQpBe6CzD3V5Gg5k9dMt
 7hEVi15j23IkQkZ/m+s+K9ofi6JK5Xr1MgflLNaLsdDPKUhQm6bMB/OTn6p6XxXoql/BGIoCrCQGu
 DmHhgQUDAXYvLz5mIUoNnwoV+5A2Gpg2fp1T7yOs9nUIU92AKoJSc5cXQvf5tRfOh5O2oeedyjOIN
 hqcwcfpQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkjQM-000NPv-GK
 for linux-nvme@lists.infradead.org; Sun, 23 May 2021 08:25:27 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1621758325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iVOkU6mPxfn5BVd8GlNU1HfGC6hDoW8TTxQlBhTR3w4=;
 b=i84+upGPrpeJEmerMBQJF8+vWdmEewYx5EjW7zLq6a/Sd5XWtPkssabYioaGiBH/ol/7RV
 FKOJhUGVlyY0Pn7Yudmj2SLwKy3IxGFWAVQM/OubG3+Ll6DH37tGIs6JOI9Pz78rRYWVcV
 r45V4o9tzsbKOWL/LET+rvYyDrmOroI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1621758325;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iVOkU6mPxfn5BVd8GlNU1HfGC6hDoW8TTxQlBhTR3w4=;
 b=BxnwIpSQOILsGXJCLzFOCfyUewZzX7miKhHWSWPYYMp0u4/JoaXtnu/6UQ7IUzRln4yuju
 eRhUjWD+2qtDE3Bw==
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 19B96AC3A;
 Sun, 23 May 2021 08:25:25 +0000 (UTC)
Subject: Re: [PATCH 25/26] null_blk: convert to blk_alloc_disk/blk_cleanup_disk
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jim Paris <jim@jtan.com>,
 Philip Kelleher <pjk1939@linux.ibm.com>, Minchan Kim <minchan@kernel.org>,
 Nitin Gupta <ngupta@vflare.org>, Matias Bjorling <mb@lightnvm.io>,
 Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
 Song Liu <song@kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>,
 Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com,
 linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org,
 drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-mmc@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
References: <20210521055116.1053587-1-hch@lst.de>
 <20210521055116.1053587-26-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a900d30c-811c-c90f-c24c-22134e750b3d@suse.de>
Date: Sun, 23 May 2021 10:25:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210521055116.1053587-26-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210523_012526_709566_E01ECB25 
X-CRM114-Status: GOOD (  14.62  )
X-Mailman-Approved-At: Mon, 24 May 2021 11:59:45 -0700
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

T24gNS8yMS8yMSA3OjUxIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBDb252ZXJ0IHRo
ZSBudWxsX2JsayBkcml2ZXIgdG8gdXNlIHRoZSBibGtfYWxsb2NfZGlzayBhbmQgYmxrX2NsZWFu
dXBfZGlzawo+IGhlbHBlcnMgdG8gc2ltcGxpZnkgZ2VuZGlzayBhbmQgcmVxdWVzdF9xdWV1ZSBh
bGxvY2F0aW9uLiAgTm90ZSB0aGF0IHRoZQo+IGJsay1tcSBtb2RlIGlzIGxlZnQgd2l0aCBpdHMg
b3duIGFsbG9jYXRpb25zIHNjaGVtZSwgdG8gYmUgaGFuZGxlZCBsYXRlci4KPiAKPiBTaWduZWQt
b2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KPiAtLS0KPiAgIGRyaXZlcnMv
YmxvY2svbnVsbF9ibGsvbWFpbi5jIHwgMzggKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMo
LSkKPiBSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMs
CgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0
b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRz
dHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6Rm
dHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW52bWUK
