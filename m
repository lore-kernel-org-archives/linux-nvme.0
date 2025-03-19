Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54C8C35FFA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Mar 2025 16:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:MIME-Version:
	Content-Type:Content-Transfer-Encoding:References:In-Reply-To:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eXFMareT0j729yCGcXp+ap+t+xyUPza11v3I+cq8P4M=; b=kQF4cOID1dAPx+ONJYGQW8yHO4
	nJTVNNpFlHdxRCDX1TKhgFgOi2afazl2wdnaTUVijQfFM1r9hiuyOIsVI+UBtb7+9ju856ncDUfEU
	LjgIPmFANOUM4xknyEXZSSb5jGBqo+ZluxANmXsjUdWZ4fM0Z69rkPLxNotVTHvV7LNNCNx22U27d
	dAPScH1JJPrWzGfAXo8/1AvWmIYJWIYtSqgpSBWTdf5pntJYn+oEDlMPKvrDiZKxvqKDAPJLK13E8
	zAOG87Vj+4geDImjJE1e/MR8kWx97wwBXleSj7A1GNqyYSQYtOUkX+WpWHjzxYXXNQT+i1CBEKMLE
	ccWQX3tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuwCj-00000009XQd-419y;
	Wed, 19 Mar 2025 16:23:41 +0000
Received: from m16.mail.163.com ([117.135.210.2])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuwCg-00000009XQ7-3Lm8
	for linux-nvme@lists.infradead.org;
	Wed, 19 Mar 2025 16:23:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=YIOAJuGEapQGaq2je2RAXjlrvCrqas88zQ1RK5Ljcxk=; b=f
	RXoqkhuDREMxb7lCuv8Xa7RKS0NDmqjFhZASymkwSTRBYfIAuDBxU2Huqr94NgLZ
	/XTzZfA9hzWOJj8tsMZLi7XqFxrc6anPkrKMVG5K5SYj0nwewgPIUvR3foAQ9ebD
	oYY0f5z3GRcsmqCKxTpTjTWHyF+UE5t9Vh/Oz2xtWg=
Received: from 00107082$163.com ( [111.35.188.213] ) by
 ajax-webmail-wmsvr-40-100 (Coremail) ; Thu, 20 Mar 2025 00:23:05 +0800
 (CST)
X-Originating-IP: [111.35.188.213]
Date: Thu, 20 Mar 2025 00:23:05 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Keith Busch" <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: nvme interrupt counters got reset after suspend/resume
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <Z9rpeIsNlf6SBWi6@kbusch-mbp>
References: <20250319153910.18684-1-00107082@163.com>
 <Z9rpeIsNlf6SBWi6@kbusch-mbp>
X-NTES-SC: AL_Qu2fAPibvksj4yifZekXn0oTju85XMCzuv8j3YJeN500siT23TInW29GB1LQws6qEAOhoAiNWwNEzf96Qpd9VIFdP9wFSrgCIMWd+3+S8/Jz
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <349dba2d.b878.195af373591.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: ZCgvCgAHyFlq79pnfgsoAA--.61915W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqBcVqmfa6klc6AACso
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_092339_205267_AA43C6FC 
X-CRM114-Status: UNSURE (   7.85  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGksIAoKQXQgMjAyNS0wMy0xOSAyMzo1Nzo0NCwgIktlaXRoIEJ1c2NoIiA8a2J1c2NoQGtlcm5l
bC5vcmc+IHdyb3RlOgo+T24gV2VkLCBNYXIgMTksIDIwMjUgYXQgMTE6Mzk6MTBQTSArMDgwMCwg
RGF2aWQgV2FuZyB3cm90ZToKPj4gCj4+IFRoaXMgZG9lcyBub3QgaGFwcGVuZCB0byBjb3VudGVy
cyBmb3Igb3RoZXIgaW50ZXJydXB0cyBvbiBteSBzeXN0ZW0uCj4+IE5vdCBzdXJlIHdoZXRoZXIg
dGhpcyBpcyBkZXNpZ25lZCBleHBsaWNpdGx5IHRoaXMgd2F5LCBvciBoYXBwZW5kZWQgdG8gYmUg
dGhpcyB3YXkgdG8gbWFrZSBzdXNwZW5kL3Jlc3VtZSB3b3JrLAo+PiBvciB0aGVyZSBpcyBzb21l
IGJ1ZyBiZWhpbmQgdGhpcy4KPgo+VGhlIG52bWUgZHJpdmVyIGNvbXBsZXRlbHkgYnJpbmdzIGRv
d24gdGhlIGludGVycnVwdHMgb24gc3VzcGVuZCBhbmQKPmNyZWF0ZXMgbmV3IG9uZXMgb24gcmVz
dW1lLiBUaGV5IG1pZ2h0IGhhdmUgdGhlIHNhbWUgbnVtYmVycyBhbmQgbGFiZWxzCj5vbiB0aGUg
b3RoZXIgc2lkZSBvZiB0aGUgcmVzdW1lLCBidXQgdGhleSdyZSBub3QgZnJvbSB0aGUgc2FtZSBv
cmlnaW5hbAo+YWxsb2NhdGlvbiB0aGF0IHRyYWNrcyB0aGVzZSBzdGF0cy4gSG9wZSB0aGF0IGhl
bHBzLgoKQ29weSB0aGF0fiEgIEFuZCB0aGFua3MgZm9yIGNsZWFyaW5nIHRoaW5ncyBvdXQuCgoK
CkRhdmlkCg==

