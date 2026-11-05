Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFB8606D805
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3LlKBYmL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:MIME-Version:
	Subject:Message-ID:Cc:To:From:Date:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+nIQo6SJcvZDib3A+NhZjHGX96S244Rb7zbwdwutnkg=; b=3LlKBYmLJ5UwDb0GrXGw4A6wBH
	mKJ0hIZQ3Od/FlMVSa1tdREiBBG4ECcF0AUnf+lJ2hqfXDPVoVgWfUK77/qGQGC+nB484igN9BNR1
	fH9HWBXAGVw3ZVm0+V0W9PnDQn0rv0US9YuDieSbHP9jnR0GpSdIw1a2RQ9tXyrwYyOB2CsHdCQzz
	3zStg59sJUMVN+Ma861PHqhjBXxNu9W97YV/wOlaVH3DYEb9/+pyfJ/iIqY5AlAWiHjYW60u4slIt
	Pknk0ysadpkkztp7wx1gcaH3ESFxVOzFS4up560suiQauS+eEA0cN05wI+WEOOBU7/Zj+QgstLuT+
	EQSbO98A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0v0-00000009l5V-2egp;
	Thu, 05 Nov 2026 17:06:30 +0000
Received: from out28-49.mail.aliyun.com ([115.124.28.49])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOqMo-00000007uI9-2HaN
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 05:50:34 +0000
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.7356054|0.6548271;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_social|0.00726536-0.000343484-0.992391;FP=5296112782220841970|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032065030;MF=liaoxuan@open-hieco.net;NM=1;PH=DW;RN=7;RT=7;SR=0;TI=W4_0.2.3_v5ForWebDing_21251644_1793857779938_o7001c47r;
Received: from WS-web (liaoxuan@open-hieco.net[W4_0.2.3_v5ForWebDing_21251644_1793857779938_o7001c47r] cluster:ay29) at Thu, 05 Nov 2026 13:50:21 +0800
Date: Thu, 05 Nov 2026 13:50:21 +0800
From: "=?UTF-8?B?5buW54WK?=" <liaoxuan@open-hieco.net>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "axboe" <axboe@kernel.dk>,
  "hch" <hch@lst.de>,
  "sagi" <sagi@grimberg.me>,
  "linux-nvme" <linux-nvme@lists.infradead.org>,
  "linux-kernel" <linux-kernel@vger.kernel.org>,
  "default avatarZheng Tan" <tanzheng@kylinos.cn>
Message-ID: <34801e0a-5d66-47c4-9844-7844363072fe.liaoxuan@open-hieco.net>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIIDEvM10gbnZtZTogQWRkIGFkYXB0aXZlIFBDSWUgbGluayByYXRl?=
  =?UTF-8?B?IHN3aXRjaGluZyBmdW5jdGlvbg==?=
X-Mailer: [Alimail-Mailagent][W4_0.2.3][v5ForWebDing][Chrome]
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <cover.1790134954.git.liaoxuan@open-hieco.net> <85a11a4085d04a2823c04059702630cf34abf6d4.1790134954.git.liaoxuan@open-hieco.net>,<auoxH197kQfUJGaE@kbusch-mbp>
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_SFRTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzE1Ni4wLjAuMCBTYWZhcmkvNTM3LjM2IEVkZy8xNTYuMC4wLjA=Ch
In-Reply-To: <auoxH197kQfUJGaE@kbusch-mbp>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_215030_753860_D0BF9095 
X-CRM114-Status: UNSURE (   7.99  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
X-Mailman-Approved-At: Thu, 05 Nov 2026 09:06:25 -0800
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: =?UTF-8?B?5buW54WK?= <liaoxuan@open-hieco.net>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGksS2VpdGgKClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldyBhbmQgZm9yIHJhaXNpbmcgdGhlIEFT
UE0gTDEgcG9pbnQuIEkgYWdyZWUgdGhhdCBBU1BNIEwxIGlzIHZlcnkgZWZmZWN0aXZlIGZvciBw
b3dlciBzYXZpbmcuCkhvd2V2ZXIsIEwxIGlzIGVudGVyZWQgb25seSB3aGVuIHRoZSBsaW5rIGlz
IGNvbXBsZXRlbHkgaWRsZSAobm8gcGVuZGluZyB0cmFuc2FjdGlvbnMpLiBEdXJpbmcgYWN0aXZl
IGJ1dCBsb3ctdXRpbGl6YXRpb24gSS9PLCB0aGUgbGluayBjYW5ub3QgZW50ZXIgTDEgYW5kIHR5
cGljYWxseSBzdGF5cyB0cmFpbmVkIGF0IGl0cyBtYXhpbXVtIHJhdGUuIFRoaXMgcGF0Y2ggdGFy
Z2V0cyBleGFjdGx5IHRoYXQgd2luZG93OiBpdCBkeW5hbWljYWxseSBkb3duZ3JhZGVzIHRoZSBs
aW5rIHJhdGUgdG8gdGhlIG1pbmltdW0gc3VmZmljaWVudCBmb3IgdGhlIGN1cnJlbnQgdHJhZmZp
YywgYW5kIHVwZ3JhZGVzIGJhY2sgdG8gbWF4aW11bSB3aGVuIGxvYWQgcmlzZXMuClNvIHRoZSB0
d28gbWVjaGFuaXNtcyBjb3ZlciBkaWZmZXJlbnQgbGluayBjb25kaXRpb25zIGFuZCBhcmUgY29t
cGxlbWVudGFyeSByYXRoZXIgdGhhbiBjb25mbGljdGluZzogQVNQTSBMMSBoYW5kbGVzIHRoZSBp
ZGxlIGxpbmssIHdoaWxlIHRoaXMgcGF0Y2ggaGFuZGxlcyB0aGUgYWN0aXZlLWJ1dC11bmRlcnV0
aWxpemVkIGxpbmsuCgpCZXN0IHJlZ2FyZHMsCkxpYW8gWHVhbgoKLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCuWPkeS7tuS6
uu+8mktlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4K5Y+R6YCB5pe26Ze077yaMjAyNuW5
tDEx5pyINOaXpSjlkajkuIkpIDAzOjA4CuaUtuS7tuS6uu+8miLlu5bnhYoiPGxpYW94dWFuQG9w
ZW4taGllY28ubmV0PgrmioTjgIDpgIHvvJpheGJvZTxheGJvZUBrZXJuZWwuZGs+OyBoY2g8aGNo
QGxzdC5kZT47IHNhZ2k8c2FnaUBncmltYmVyZy5tZT47ICJsaW51eC1udm1lIjxsaW51eC1udm1l
QGxpc3RzLmluZnJhZGVhZC5vcmc+OyAibGludXgta2VybmVsIjxsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnPjsgZGVmYXVsdCBhdmF0YXJaaGVuZyBUYW48dGFuemhlbmdAa3lsaW5vcy5jbj4K
5Li744CA6aKY77yaUmU6IFtQQVRDSCAxLzNdIG52bWU6IEFkZCBhZGFwdGl2ZSBQQ0llIGxpbmsg
cmF0ZSBzd2l0Y2hpbmcgZnVuY3Rpb24KCgpPbiBUdWUsIE5vdiAwMywgMjAyNiBhdCAwMjoyNTo0
M1BNICswODAwLCBMaWFvIFh1YW4gd3JvdGU6Cj4gQWRkIHN1cHBvcnQgZm9yIGR5bmFtaWNhbGx5
IGFkanVzdGluZyB0aGUgUENJZSBsaW5rIHJhdGUgb2YgTlZNZQo+IGRldmljZXMgYmFzZWQgb24g
SS9PIGFjdGl2aXR5LiBUaGUgbGluayBpcyBkb3duZ3JhZGVkIHRvIGEKPiBjb25maWd1cmFibGUg
bWluaW11bSByYXRlIGR1cmluZyBwZXJpb2RzIG9mIGxvdyBhY3Rpdml0eSB0byBzYXZlCj4gcG93
ZXIsIGFuZCB1cGdyYWRlZCB0byB0aGUgbWF4aW11bSBzdXBwb3J0ZWQgcmF0ZSBhcyBzb29uIGFz
IHRoZQo+IHdvcmtsb2FkIGV4Y2VlZHMgYSBjb21wdXRlZCB0aHJlc2hvbGQsIHNvIHRoYXQgcGVh
ayBwZXJmb3JtYW5jZSBpcwo+IG1haW50YWluZWQgdW5kZXIgbG9hZC4KClByZXR0eSBzdXJlIFBD
SWUgQVNQTSBMMSBzdGF0ZXMgd291bGQgc2F2ZSBtb3JlIHBvd2VyIHRoYW4gZG93bmdyYWRpbmcK
dGhlIGxpbmsgcmF0ZSwgYXMgd2VsbCBhcyBoYXZlIGJldHRlciBlbnRyeS9leGl0IGxhdGVuY3kg
dGhhbiBhIHNvZnR3YXJlCmRyaXZlbiBtb25pdG9yIGFuZCBsaW5rIHJldHJhaW4uCg==

