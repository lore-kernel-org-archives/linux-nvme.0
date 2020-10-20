Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEEDC4363A
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 23:16:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D695A223BF
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 23:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sb3+8R1j";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="DPG2xchs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D695A223BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oP/AqRR561Gzc2i8YM38ZyHdAGErMu6WaM8O8SWS5A8=; b=Sb3+8R1jHpD/0ngp9WpRgwuTC
	L4t4pgvpHckuarku20D8TrNHypEUhJqBtJUB6I19w8EShNLqr9lDHOgqNyyCJk/07GqW90kMMzL4i
	FcF8oBrm5eVOn8NmqGfpXvaISHJcjqMV/A9Q1qmYUoLK82IEgtcMfkOOkpOaWiM2H4E25WpRtutgj
	J7IZJoLuGTtD2UEqKWQ9VAiUGAOdrVBwxeQ9fvf6sDK9evZv1aQ1vrzLbtKcg+kkuLysCoaiIWubD
	7zdMpjd2O+LltG0TfGflt/g+dlQYDMVMXTljvXF0j+fqaESBvpaF2W61sntRwdnvHYPtYflhynDDG
	h8Iv/sfLQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kV0rQ-0001M2-1Y; Tue, 20 Oct 2020 23:16:08 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kV0rJ-0001Kc-Pq
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 23:16:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/xTwQa5Dp1cAYUmE5bfuGOJqbSiyEnZzuWTuwMzSwGE=; b=DPG2xchsujupLebWNsA/AT/Upu
 8MS4aZvcY9dhIEaC729bZH7WQaZGzE2/YB3ceH+KJW4ih4AVWvdkLFAnuLLLZiiIYtqKEpx299u9f
 Iq+L09j7mNpMOPxs/PcE4uuPTSpvggWCqjk1TkQmwlO6pPjKthKFJAPkZgwTbSyifNx9jT7Tq46qb
 TMJoiIBM0TKqkZOyLe00fPyI6TQThYA5UTA+9Vr4LujU3c33YHl1pFgKxg0WQjDgoRqAOFyLcyaYL
 rGzgKoQP+i6sgjgJKgo5emOfVvFaxjLkzgfdrZmn/7jdi7TqyojsLPLs1hQmG5vcyn+sIloxv3niX
 F99me61Q==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kV0rD-0003xF-Bw; Tue, 20 Oct 2020 17:15:56 -0600
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20201020231404.9365-1-chaitanya.kulkarni@wdc.com>
 <20201020231404.9365-2-chaitanya.kulkarni@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <32159323-7473-c699-ff16-32380ae385e3@deltatee.com>
Date: Tue, 20 Oct 2020 17:15:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020231404.9365-2-chaitanya.kulkarni@wdc.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
 linux-nvme@lists.infradead.org, chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH V2 1/1] nvmet: don't use BLK_MQ_REQ_NOWAIT for passthru
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_191601_908950_E484180D 
X-CRM114-Status: GOOD (  15.24  )
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
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIwLTEwLTIwIDU6MTQgcC5tLiwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOgo+IEJ5
IGRlZmF1bHQsIHdlIHNldCB0aGUgcGFzc3RocnUgcmVxdWVzdCBhbGxvY2F0aW9uIGZsYWcgc3Vj
aCB0aGF0IGl0Cj4gcmV0dXJucyB0aGUgZXJyb3IgaW4gdGhlIGZvbGxvd2luZyBjb2RlIHBhdGgg
YW5kIHdlIGZhaWwgdGhlIEkvTyB3aGVuCj4gQkxLX01RX1JFUV9OT1dBSVQgaXMgdXNlZCBmb3Ig
cmVxdWVzdCBhbGxvY2F0aW9uIDotCj4gCj4gbnZtZV9hbGxvY19yZXF1ZXN0KCkKPiDCoGJsa19t
cV9hbGxvY19yZXF1ZXN0KCkKPiDCoCBibGtfbXFfcXVldWVfZW50ZXIoKQo+IMKgIMKgaWYgKGZs
YWcgJiBCTEtfTVFfUkVRX05PV0FJVCkKPiDCoCDCoCDCoCDCoCByZXR1cm4gLUVCVVNZOyA8LS0g
cmV0dXJuIGlmIGJ1c3kuCj4gCj4gT24gc29tZSBjb250cm9sbGVycyB1c2luZyBCTEtfTVFfUkVR
X05PV0FJVCBlbmRzIHVwIGluIEkvTyBlcnJvciB3aGVyZQo+IHRoZSBjb250cm9sbGVyIGlzIHBl
cmZlY3RseSBoZWFsdGh5IGFuZCBub3QgaW4gYSBkZWdyYWRlZCBzdGF0ZS4KPiAKPiBCbG9jayBs
YXllciByZXF1ZXN0IGFsbG9jYXRpb24gZG9lcyBhbGxvdyB1cyB0byB3YWl0IGluc3RlYWQgb2YK
PiBpbW1lZGlhdGVseSByZXR1cm5pbmcgdGhlIGVycm9yIHdoZW4gd2UgQkxLX01RX1JFUV9OT1dB
SVQgZmxhZyBpcyBub3QKPiB1c2VkLiBUaGlzIGhhcyBzaG93biB0byBmaXggdGhlIEkvTyBlcnJv
ciBwcm9ibGVtIHJlcG9ydGVkIHVuZGVyCj4gaGVhdnkgcmFuZG9tIHdyaXRlIHdvcmtsb2FkLgo+
IAo+IFJlbW92ZSB0aGUgQkxLX01RX1JFUV9OT1dBSVQgcGFyYW1ldGVyIGZvciBwYXNzdGhydSBy
ZXF1ZXN0IGFsbG9jYXRpb24KPiB3aGljaCByZXNvbHZlcyB0aGlzIGlzc3VlLgo+IAo+IFNpZ25l
ZC1vZmYtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8Y2hhaXRhbnlhLmt1bGthcm5pQHdkYy5jb20+
CgpNYWtlcyBzZW5zZSB0byBtZToKClJldmlld2VkLWJ5OiBMb2dhbiBHdW50aG9ycGUgPGxvZ2Fu
Z0BkZWx0YXRlZS5jb20+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dm1lCg==
