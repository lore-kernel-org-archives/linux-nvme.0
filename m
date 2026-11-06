Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E26606A335
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dZHBQPDA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:MIME-Version:
	Subject:Message-ID:Cc:To:From:Date:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ylNb4lyoDnDVbeVYjsPUy5/EMBQ+X4muWILrXlRvMxo=; b=dZHBQPDAURK4Om4XKxyCZeeGKH
	D/56LflBsiZRPMD7BnP7xg3phC7xVlIqir7a3ckG22PxdxI6psvtAT5PGhwC8WO0pCMl9R4mwhsif
	wpDv+6KUHfV2VKPPHN9U8pXO4HGwI+iK5DGsWrioMZrdr2kP6RmlLlxVB0LNwxad14KvPjodqiuw4
	HJD3+LftZYiZVCockYVTwZwGDakaJ7GfwStSn0CWLkN39WG4RgYLm9d3KHGvZSkSq6iQoEHOa2JrW
	jtyd3fhlYxB6N6G15VtAIYmXk4Glr2VZMiuBjTM2AJPnnza2K3/FJGrnpzH8/lrIAF1hoNIPENjbG
	EeFqjQyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHc3-0000000C3oP-06Ds;
	Fri, 06 Nov 2026 10:56:03 +0000
Received: from out28-125.mail.aliyun.com ([115.124.28.125])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPAsh-0000000BBNQ-2IRs
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 03:44:48 +0000
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1308854|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.00454194-0.000177499-0.995281;FP=8458208776405753275|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037026024;MF=liaoxuan@open-hieco.net;NM=1;PH=DW;RN=9;RT=9;SR=0;TI=W4_0.2.3_v5ForWebDing_211855CA_1793935086753_o7001c533;
Received: from WS-web (liaoxuan@open-hieco.net[W4_0.2.3_v5ForWebDing_211855CA_1793935086753_o7001c533] cluster:ay29) at Fri, 06 Nov 2026 11:39:26 +0800
Date: Fri, 06 Nov 2026 11:39:26 +0800
From: "=?UTF-8?B?5buW54WK?=" <liaoxuan@open-hieco.net>
To: "Bjorn Helgaas" <helgaas@kernel.org>
Cc: "kbusch" <kbusch@kernel.org>,
  "axboe" <axboe@kernel.dk>,
  "hch" <hch@lst.de>,
  "sagi" <sagi@grimberg.me>,
  "linux-nvme" <linux-nvme@lists.infradead.org>,
  "linux-kernel" <linux-kernel@vger.kernel.org>,
  "default avatarZheng Tan" <tanzheng@kylinos.cn>,
  "=?UTF-8?B?SWxwbyBKw6RydmluZW4=?=" <ilpo.jarvinen@linux.intel.com>
Message-ID: <d20d0f7a-6296-43e7-b27e-5a1ea3ae0607.liaoxuan@open-hieco.net>
Subject: =?UTF-8?B?5Zue5aSN77ya5Zue5aSN77yaW1BBVENIIDEvM10gbnZtZTogQWRkIGFkYXB0aXZlIFBDSWUg?=
  =?UTF-8?B?bGluayByYXRlIHN3aXRjaGluZyBmdW5jdGlvbg==?=
X-Mailer: [Alimail-Mailagent][W4_0.2.3][v5ForWebDing][Chrome]
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <5453bf57-fd19-458b-a723-bc7ab99c2479.liaoxuan@open-hieco.net>,<20261105192228.GA1550766@bhelgaas>
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_SFRTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzE1Ni4wLjAuMCBTYWZhcmkvNTM3LjM2IEVkZy8xNTYuMC4wLjA=Ch
In-Reply-To: <20261105192228.GA1550766@bhelgaas>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_194447_764970_145237E8 
X-CRM114-Status: GOOD (  12.25  )
X-Spam-Score: -1.9 (-)
X-Mailman-Approved-At: Fri, 06 Nov 2026 02:56:02 -0800
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

SGkgQmpvcm4sCgpUbyBpbXByb3ZlIGdlbmVyYWxpdHkgYW5kIG1ha2UgdGhlIGFzc3VtcHRpb24g
ZXhwbGljaXQsIEkgd2lsbCBmb2xsb3cKeW91ciBzdWdnZXN0aW9uOiBJIHdpbGwgZW5jYXBzdWxh
dGUgdGhlIHRocmVzaG9sZCBjYWxjdWxhdGlvbiBmbG93IGluCmEgc2VwYXJhdGUgZnVuY3Rpb24s
IGFuZCBhZGQgYSBjb21tZW50IHRoZXJlIHN0YXRpbmcgdGhhdCB0aGlzIHBhcmFtZXRlcgppcyBw
bGF0Zm9ybS1kZXBlbmRlbnQgYW5kIHRoYXQgdGhlIGN1cnJlbnQgdmFsdWUgaXMgZm9yIEh5Z29u
IHBsYXRmb3Jtcy4KSSB3aWxsIHNlbmQgYW4gdXBkYXRlZCBwYXRjaCB3aXRoIHRoaXMgY2hhbmdl
LgoKVGhhbmtzLApMaWFvIFh1YW4KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCuWPkeS7tuS6uu+8mkJqb3JuIEhlbGdhYXMg
PGhlbGdhYXNAa2VybmVsLm9yZz4K5Y+R6YCB5pe26Ze077yaMjAyNuW5tDEx5pyINuaXpSjlkajk
upQpIDAzOjIyCuaUtuS7tuS6uu+8miLlu5bnhYoiPGxpYW94dWFuQG9wZW4taGllY28ubmV0Pgrm
ioTjgIDpgIHvvJprYnVzY2g8a2J1c2NoQGtlcm5lbC5vcmc+OyBheGJvZTxheGJvZUBrZXJuZWwu
ZGs+OyBoY2g8aGNoQGxzdC5kZT47IHNhZ2k8c2FnaUBncmltYmVyZy5tZT47ICJsaW51eC1udm1l
IjxsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmc+OyAibGludXgta2VybmVsIjxsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgZGVmYXVsdCBhdmF0YXJaaGVuZyBUYW48dGFuemhlbmdA
a3lsaW5vcy5jbj47ICJJbHBvIErDpHJ2aW5lbiI8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5j
b20+CuS4u+OAgOmimO+8mlJlOiDlm57lpI3vvJpbUEFUQ0ggMS8zXSBudm1lOiBBZGQgYWRhcHRp
dmUgUENJZSBsaW5rIHJhdGUgc3dpdGNoaW5nIGZ1bmN0aW9uCgoKT24gVGh1LCBOb3YgMDUsIDIw
MjYgYXQgMDI6MzA6MTNQTSArMDgwMCwg5buW54WKIHdyb3RlOgo+IEhpIEJqb3JuLAo+IFRoYW5r
IHlvdSBmb3IgdGhlIHJldmlldyBhbmQgZm9yIHRoZSBxdWVzdGlvbi4KPiAKPiBUaGUgcmVhc29u
IGZvciByZXN0cmljdGluZyB0aGlzIGZlYXR1cmUgdG8gSHlnb24gcGxhdGZvcm1zIGlzIHRoYXQg
dGhlCj4gUENJZSBsaW5rIHJldHJhaW5pbmcgdGltZSB2YXJpZXMgYWNyb3NzIGRpZmZlcmVudCBD
UFUgcGxhdGZvcm1zLgo+IAo+IEluIHRoaXMgcGF0Y2gsIHRoZSBJL08gdGhyZXNob2xkIGZvciBk
b3duZ3JhZGluZy91cGdyYWRpbmcgdGhlIGxpbmsgcmF0ZQo+IGlzIGRlcml2ZWQgYmFzZWQgb24g
dGhpcyByZXRyYWluaW5nIHRpbWUuIEN1cnJlbnRseSwgaXQgaXMgaGFyZGNvZGVkIGFzCj4gMTAw
dXMgaW4gbnZtZV9jYWxjX3NwZWVkX3RocmVzaG9sZCgpLCB3aGljaCBpcyB0aGUgdmFsaWRhdGVk
IHZhbHVlIGZvcgo+IEh5Z29uLiBTaW5jZSB3ZSBoYXZlIG9ubHkgdmVyaWZpZWQgdGhpcyB0aW1p
bmcgcGFyYW1ldGVyIG9uIEh5Z29uIHBsYXRmb3JtcywKPiB3ZSBhZGRlZCB0aGUgcmVzdHJpY3Rp
b24gdG8gYXZvaWQgcG90ZW50aWFsIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb25zIG9uCj4gb3RoZXIg
cGxhdGZvcm1zIHdoZXJlIHRoZSByZXRyYWluaW5nIHRpbWUgbWlnaHQgYmUgZGlmZmVyZW50LgoK
U2VlbXMgc3VzcGVjdCB0byBoYXJkLWNvZGUgcGxhdGZvcm0gcGFyYW1ldGVycyBsaWtlIHRoaXMs
IGJ1dCBpZiB5b3UKbXVzdCwgYXQgbGVhc3QgYWRkIGEgY29tbWVudCB0byB0aGUgZWZmZWN0IHRo
YXQgdGhpcyBkZXBlbmRzIG9uIHRoZQpwbGF0Zm9ybSBhbmQgdGhlIGN1cnJlbnQgdmFsdWUgaXMg
Zm9yIHBsYXRmb3JtIFguCg==

