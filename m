Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AECC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 08:45:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3940460F12
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 08:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3940460F12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PclUVJh2KwpRVzn2FDgSX4K2IKOt8J06BvB7sTBWQrM=; b=fgxqgFGVnrQHbp
	vNmS3jNGIRsmkZPC/3zjEVRi2WT+sCTja2OxIup7pUpCmdysNzRPC5UiQQCRPUDVnM13l3GHKo2ZS
	yEbQD7leALd6zdKWAHORIIS2AeSZCeHat4KdkUzDovWbVvrEns7PeCOm9pL3XLax5TvdZkQkkzWkE
	gW5j6lfjKBd4NpT4WTjUez1X5uYdWqnqIAUOCPYaKgaSf/KPE1UqP2pSItvKFYH53q0Jpuuoq3D3u
	TB6AWwwLE8Zh73ULGRI8aAU5OekWv4qAoOJvqnYn5vOI7HL394tjh++ixRvrRf7gHI18zMEDBBsH1
	jvsC/Lk4Wlvoeq2vTN9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mV8jv-006JPX-WF; Tue, 28 Sep 2021 08:45:28 +0000
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mV8jq-006JL2-1Y
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 08:45:23 +0000
Received: by mail-oi1-x22a.google.com with SMTP id y201so29158212oie.3
 for <linux-nvme@lists.infradead.org>; Tue, 28 Sep 2021 01:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rDmLRsU2I93uMDRTUo9+Pep/BvkZkrwEc7LdMqV2fmY=;
 b=WIOzdDVxcMTlVtaukdrKx4JeEiC7s6eXgOwDUg2WhTBlwzv8kgUcCjtLK9dck5hnj+
 3TjK1qge6rkI+nkosWGg/T7PxNsZwnO8cs1cOQ+bkWwPk6eIL+4xliIBsZMSIM6fwASc
 qLMVzdYNDp6h3t4mzElNstuteovCn8u2chnojLCXRcKG4QCQrSkxq6FtcNCCUpPlMx2t
 E9eyj9hG4atS8qv+2x3gnH3JTSXEwrmRV80i4aU2eGH5S0cwtve7s/SxBk7UL8f9W0eD
 z61s9sz3lZhXfdujv9Sf91HVus3DoNZEpztzCu5sjjJaXR/IypwwrxRdaCJIw7K0LGsp
 360Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rDmLRsU2I93uMDRTUo9+Pep/BvkZkrwEc7LdMqV2fmY=;
 b=QD+GOyRzZBPM092Ne2nwwxkJm62l5S4NVmmzPzcgyqqk5HuqHNblVgGDU3/VmodfTq
 qb2yuAzO7eX4nmF/M1nUNFN7sAX1AlQcrV2L3PQZCAAT7DsHDcew3MA/CmdW1n+Kxvv8
 UD394bi/8WgAv2ig+S+WNU9IZxZIHohOiWXWB/2TLT1uQ5ZhKoLSXmDgF1+Gp6rYVGhE
 N3xuwzw4qBuPXqF1T2Vw+WXLIPi4C27M1CNdLBuvW43GhxWr4vNTKdVsYJbqx029zTAf
 6GLG+ozt6bDNlL5BXnghVjl1SZ1ro0bO6emur1n5BT4N40LJV+Rajb+ivqE0O98BY1pN
 DnFA==
X-Gm-Message-State: AOAM531QwY6wS09AtaieHbdIqo4HaMVz8vZ65EPezJXaIXUzhEvi18T1
 i8q3idc0Z3zkbli/AkIGc1krkRCgsml2sBHbNVJpWkJB
X-Google-Smtp-Source: ABdhPJwKMbEZqwuOF/NA8NhTH2AN8WDBcT3CKXnHEI5iZ/js6iddR1Mvzfs+/n8YnAEAoUFv4zpLAxBLEhggAi1Pki8=
X-Received: by 2002:aca:744:: with SMTP id 65mr2850489oih.174.1632818719600;
 Tue, 28 Sep 2021 01:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAGrZSEyrdJaZkHX9fPse0bv3d1x-HU7vvPQeg5JyR++_hOs8bQ@mail.gmail.com>
 <20210927200357.GA387558@dhcp-10-100-145-180.wdc.com>
 <CAGrZSEwC4zKuXf-kwZmPrb1o7iGD4mqF_8zJ8n1PQ0KcohFAzg@mail.gmail.com>
 <20210928024307.GE387558@dhcp-10-100-145-180.wdc.com>
 <CAGrZSEw-YnoeJbt3_JQ6v81YWV6Lc3ao7eh8dNA0+aS8p7mWBw@mail.gmail.com>
 <20210928025916.GA389836@dhcp-10-100-145-180.wdc.com>
 <CAGrZSExsxVcPaqpo-bh+Bekb+dxvQf8rNFMXxX7-9_+f7DYECQ@mail.gmail.com>
In-Reply-To: <CAGrZSExsxVcPaqpo-bh+Bekb+dxvQf8rNFMXxX7-9_+f7DYECQ@mail.gmail.com>
From: Steven Seungcheol Lee <sc108.lee@gmail.com>
Date: Tue, 28 Sep 2021 17:45:08 +0900
Message-ID: <CAGrZSEwg4Nh+4CTSA024iGOS435zb1FywAtvefyAq4B0CecpZA@mail.gmail.com>
Subject: Re: [PATCH] nvme.h: expend lbaf on nvme_id_ns, lbafe on nvme_zns_id_ns
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_014522_156585_97DB1AB8 
X-CRM114-Status: GOOD (  10.98  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

U29ycnkgZ3V5cyBtaXN1bmRlcnN0b29kLCBJIGp1c3QgcmVhbGl6ZWQgdGhhdCBjaGFuZ2VzIG5l
ZWQgb3RoZXIKZnVuY3Rpb25hbGl0eSB0aGF0IHlvdSBndXlzIG1lbnRpb24uClRoYW5rcyBmb3Ig
dGhlIGNoZWtjaW5nIDopCkp1c3QgaWdub3JlIHRoaXMgcGF0Y2ggfgoKMjAyMeuFhCA57JuUIDI4
7J28ICjtmZQpIOyYpO2bhCAxMjo0NCwgU3RldmVuIFNldW5nY2hlb2wgTGVlIDxzYzEwOC5sZWVA
Z21haWwuY29tPuuLmOydtCDsnpHshLE6Cj4KPiBUaGF0IG1lYW5zIGxlYXZlIG90aGVyIGVsZW1l
bnRzIGFuZCBmaXggbGJmIG9ubHk/Cj4KPiBUaGUgY2hhbmdlcyBmb3IgbGJhZiwgbGJhZmUgaGFw
cGVucy4KPiBzbyBJIHRob3VnaHQgc2FtZSBzdHJ1Y3R1cmUgc2hvdWxkIGJlIHVwZGF0ZWQgYXMg
c2FtZSB2ZXJzaW9uIG9mIHNwZWMuCj4KPiBJZiBub3QgcmVjb21tYW5kZWQsIEkgd2xsIGNoYW5n
ZSBhcyBiZWxvdy4KPgo+IGlkX25zCj4gbXNzcmwsIG1jbCwgbXNyYyA9PiByZW1vdmUKPiByc3Zk
IGFyZWEgLT4gbGJhZls2NF0KPgo+IGlkX3pucwo+IHJybDF+MywgZnJsMX4zID0+IHJlbW92ZQo+
IHJzdmQgYXJlYSAtPiBsYmFmZVs2NF0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW52bWUK
