Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DCBC2D0EE
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:57:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C448206CC
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uX70PcK1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhnP63q6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C448206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y6QqQReT4qisvfSCm+HTiAb6jMKhh2vDujmf+sgvnPw=; b=uX70PcK1r3o9hq
	y2Ezf+2IHer51m9wmu+TNfvnPQ3Xwpl7ccQZNdOdaLWe5YVgjCHPvtVmtS0B0mb7G6VVmF8xLi3VP
	8qLsgUfvTFOEOqxt41Hz7c+8kc63h3k+l1zK5VLAnzGx7hzmoaC6NK5nRY0xKy+JSziJuJ2Clcy5S
	+6DlMbX0/ZE7oT71orvTpY9bYIkSNWPrKFRH6dXOrfNyPuHxtYlDpQlf7PD1SIUG6BeUzrsDnre9v
	5RSv5ywSRLrSDdlY1P0gwC/XxEruzyY3kHaM6Ka9/SHZOPPsf3A56I1iNluHBhUBqN+xtPColJgjW
	e/UFWKQhNPa5MkB0ZujQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJKCL-0002nH-55; Tue, 31 Mar 2020 16:57:09 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJK7j-0005qJ-C5
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 16:52:42 +0000
Received: by mail-qt1-x842.google.com with SMTP id z24so17709686qtu.4
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5QdQJELOcEARpklGhcfRyc4XK3qOpUmQExpfCli9uaw=;
 b=lhnP63q6FHbTkDmsaVAbHbx5O9jgQdz8ILBnXyAQW8EWhoNE3rWAeH2Tb6658qcJt0
 gaoUFgwQSJmbOXCMLvEAAMnRhmfWK9ilMM8HKDi1bTQk5CXhrwBrTThiCXjarfCCTWDm
 Qaxn/T9wtn7ZsVlUGL2cNfzCwSn+jpk0ZPVRp/ByZURLckSKcJHBGXwwdnggw6SH14jT
 y7Y4vjRdNY2paebFxyxhZ2pJi2OFcU11vFO64Pkk0NOs3AXjHhWW9jHCF6zOIrgqRVxj
 ssLVSIETx1ZiWhcUcYkMiJnc94BHHIjGTHVHBzW/WvKgNhKGXZdLU76w1+1kakDhqkVh
 WR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5QdQJELOcEARpklGhcfRyc4XK3qOpUmQExpfCli9uaw=;
 b=f/K+BcdIc9k7EEpUMG0zL9Y3ADvQ7fRU2Qb37rqf/4PvZPx44a686MxjS31P0JYYRq
 p2VbDt6aoCNMf08hSmBN/ZXuh2HJoveBLZI6BecqtrluGArD47CTJ5GcCKeNW2D4yNMO
 MR5jlfsOih89QhslJPfYBMdBRY28uPg21q8Bd6Dm3zDDpCbDQfQy5r/i1oBFH18Y/zul
 kT2wd6xtNtmWlh8F5e8Cq70QQQn4In43NbBD4Q8+MsdWjBD39xVReukk7F268dnJSByI
 eqTAMMsxKdYQo0oCbVjDLJl0G58KQ4JnZ3B1pkpA/oeh4hzTnrbCmCu86oM8eKYYgq8N
 qmSw==
X-Gm-Message-State: ANhLgQ22QDL2/S7TxQIWy5DYCpL9axEldzQ1HpoEmAsVFmBwaZwxU9ur
 RpvOTcK1ik4sL5Ps1K9tcSe5y4nJzk2FO65xN6k=
X-Google-Smtp-Source: ADFU+vsEokjkkNudcxEEMAdpfGLeH69VEteAjWQhulMNP+hActo74MOrq3W5ZxtFuqynK8vtzkv7Ren+dg7pxZ3InfU=
X-Received: by 2002:ac8:18c3:: with SMTP id o3mr6260590qtk.49.1585673542073;
 Tue, 31 Mar 2020 09:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1580786525.git.zhangweiping@didiglobal.com>
 <20200204154200.GA5831@redsun51.ssa.fujisawa.hgst.com>
 <CAA70yB5qAj8YnNiPVD5zmPrrTr0A0F3v2cC6t2S1Fb0kiECLfw@mail.gmail.com>
 <CAA70yB62_6JD_8dJTGPjnjJfyJSa1xqiCVwwNYtsTCUXQR5uCA@mail.gmail.com>
 <20200331143635.GS162390@mtj.duckdns.org>
 <CAA70yB51=VQrL+2wC+DL8cYmGVACb2_w5UHc4XFn7MgZjUJaeg@mail.gmail.com>
 <20200331155139.GT162390@mtj.duckdns.org> <20200331155257.GA22994@lst.de>
 <CAA70yB6PYH-W8-RRd7nxXOvpg6n+_-h_BLm6JA3EbLmsYG-ZSw@mail.gmail.com>
 <20200331163337.GA25020@lst.de>
In-Reply-To: <20200331163337.GA25020@lst.de>
From: Weiping Zhang <zwp10758@gmail.com>
Date: Wed, 1 Apr 2020 00:52:10 +0800
Message-ID: <CAA70yB7V03mDSi8o8PEv0+8QzqZiA-8SJuGkyOXk5VRF-KHiQQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add support Weighted Round Robin for blkcg and nvme
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_095223_439999_42E7EB34 
X-CRM114-Status: UNSURE (   9.69  )
X-CRM114-Notice: Please train this message.
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
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Minwoo Im <minwoo.im.dev@gmail.com>, cgroups@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, "Nadolski, Edmund" <edmund.nadolski@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Q2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+IOS6jjIwMjDlubQ05pyIMeaXpeWRqOS4iSDk
uIrljYgxMjozM+WGmemBk++8mgo+Cj4gT24gV2VkLCBBcHIgMDEsIDIwMjAgYXQgMTI6MzE6MTdB
TSArMDgwMCwgV2VpcGluZyBaaGFuZyB3cm90ZToKPiA+IFdvdWxkIHlvdSBsaWtlIHRvIHNoYXJl
IG1vcmUgZGV0YWlsIGFib3V0IHdoeSBOVk1lIFdSUiBpcyBicm9rZW4/Cj4KPiBCZWNhdXNlIGl0
IG9ubHkgd2VpZ2h0cyBjb21tYW5kIGZldGNoaW5nLiAgSXQgc2F5cyBhYnNvbHV0ZWx5IG5vdGhp
bmcKPiBhYm91dCBjb21tYW5kIGV4ZWN1dGlvbi4KCkkga25vdyB0aGF0IGRpZmZlcmVudCBzc2Qg
dmVuZG9yIG1heSBoYXZlIGRpZmZlcmVudCBpbXBsZW1lbnRhdGlvbiwKZXZlbiBzb21lIGRldmlj
ZSBjYW4gd29yayB3ZWxsLCBzZWVtcyB5b3UgaGF2ZSBubyBwbGFuIHN1cHBvcnQgaXQuCkkgZHJv
cCB0aGlzIHBhdGNoc2V0LgoKQFRlanVuIEhlbyAgQEtlaXRoIEJ1c2NoClRoYW5rcyBhbGwgb2Yg
eW91CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
