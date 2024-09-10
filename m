Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DDAEDE9AB
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 17:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xIDalGuglFCsWPANE/RXImM1MbzLrLepclcprYWZhd0=; b=UhgPp/omjefn+mdX2jEsa4y0uj
	ozfDppSLYi/yiGTf6KAKyOzLW9j8SkZYcgUEC3k/9bxI6n8OLWz6bkLUWJmpBbp1pjxUxYxtG8F1Q
	Mru4WS0TBXzDmyctAq3gVbOFhD8Mfd7l/U3H1gL9yYZedsbFrPOZr19wx6hG5/6r8m2Ja5OYgRPZ7
	4/wlllpVJ43FAMPIPLhS3bM6ZU1FXlcqz/uQhscIgOoSqD9sjSnip8dGqaNJJwyt956kxZoM9s8XV
	cEwQmU8L1N12/kiTnhiiyyXalgaZ5m1atmdO5VaprqfOSjgRNv7d4H0Par6PoIxdwCfkVyokQ61nk
	ZcrYZNxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so4fJ-00000006YeP-3bFS;
	Tue, 10 Sep 2024 17:28:33 +0000
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so4fG-00000006Ycy-2zTS
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 17:28:32 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1725989307; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OQFU74OFQ/T13NhMVadu6N4xXSEYqdsXZyTWpB5Uo9eJ15JdPxCT53UVfhYsCtZXCao9zgBE0B0TmM2y3oZBCgQG6z1WmA5MDqZRRtpIWBRiVfsj/u7A7j4hfypdvts1zk5lj88OrndjlrK0iRmoCiye2qxuF/PyLv5uwUUSM/g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725989307; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xIDalGuglFCsWPANE/RXImM1MbzLrLepclcprYWZhd0=; 
	b=iJNj0k2w2QNof0U0RGnBPdE/iYHyEuechjUerGj6/E+j727JU6aXjL/fWDMPkoJsdQyuWO8CrXrsSPOlY0WCiNhjJld+vRh+TBH7aPSd7eeLLPF6dRE8X6QZ4DST7FWdAQ1OVm1EzQeRpAlxjPgVHT5TukCfmIwG6kIWJx5tRFk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725989307;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=xIDalGuglFCsWPANE/RXImM1MbzLrLepclcprYWZhd0=;
	b=FcyR+0IIksMy0xlPrDUWUF44qbJjNSBS/GjPEbc704cAbzXXiwUqWC0lIqLT1D4P
	/dWYTupEBKR9Tg30LAfjKQFzacc3Oxrmw5ATJVL9p5JwK0NYptmoU3YvhY/BQYziy8o
	aBDar8naHC7ehvdJA1TtQMej3nN0wD75H2OWOfYA=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1725989275740601.1685810015596; Tue, 10 Sep 2024 10:27:55 -0700 (PDT)
Date: Tue, 10 Sep 2024 18:27:55 +0100
From: Robert Beckett <bob.beckett@collabora.com>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "linux-nvme" <linux-nvme@lists.infradead.org>,
	"Jens Axboe" <axboe@fb.com>, "Christoph Hellwig" <hch@lst.de>,
	"Sagi Grimberg" <sagi@grimberg.me>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"linux-mm" <linux-mm@kvack.org>
Message-ID: <191dcfa4846.bb18f3291189856.1624418308692137124@collabora.com>
In-Reply-To: <191db450152.e0b28690987786.6989198174827147639@collabora.com>
References: <191d810a4e3.fcc6066c765804.973611676137075390@collabora.com>
 <Zt9amhUGs9FT5i-O@kbusch-mbp> <Zt9bLa4TJT6L75aG@kbusch-mbp> <191db450152.e0b28690987786.6989198174827147639@collabora.com>
Subject: Re: possible regression fs corruption on 64GB nvme
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_102830_846403_25E69D2F 
X-CRM114-Status: GOOD (  20.83  )
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

 ---- On Tue, 10 Sep 2024 10:30:18 +0100  Robert Beckett  wrote --- 
 > 
 > 
 > 
 > 
 > 
 >  ---- On Mon, 09 Sep 2024 21:31:41 +0100  Keith Busch  wrote --- 
 >  > On Mon, Sep 09, 2024 at 02:29:14PM -0600, Keith Busch wrote:
 >  > > As a test, could you try kernel parameter "nvme.io_queue_depth_set=2"?
 >  > 
 >  > Err, I mean "nvme.io_queue_depth=2".
 >  > 
 > 
 > Thanks, I'll give it a try along with your other questions and report back.
 > 
 > For clarity, the repro steps dropped a step. They should have included the make command:
 > 
 > 
 > $ dd if=/dev/urandom of=test_file bs=1M count=10240
 > $ desync make test_file.caibx test_file
 > $ sudo bash -c "echo 3 > /proc/sys/vm/drop_caches"
 > $ desync verify-index test_file.caibx test_file
 > 

CONFIG_SLUB_DEBUG_ON showed no debug output.

nvme.io_queue_depth=2 appears to fix it. Could you explain the implications of this?
I assume it is limiting to 2 outstanding requests concurrently.
Does it suggest an issue with the specific device's FW?
I assume this would suggest that it is not actually anything wrong with the dmapool, it was just exposing the issue of the device/fw?
Any advice for handling this and/or investigating further?

My initial speculation was that maybe the disk fw is signalling completion of an access before it has actually finished making it's way to ram. I checked the code and saw that the dmapool appears to be used for storing the buffer page addresses, so I imagine that is not updated by the disk at all, which would rule out my assumption.
I'd appreciate any insight you could give on the usage of the dmapools in the driver and whether you would expect them to be significant in this issue, or if they are just making a device/fw bug more observable.

Thanks

Bob


p.s. Here is an transcript of the issue seen in testing. To my knowledge, if everything is working as it should, nothing should be able to produce this output, that dropping caches and re-priming the page cache via a linear read it fixes things.

$ dd if=/dev/urandom of=test_file bs=1M count=10240
10240+0 records in
10240+0 records out
10737418240 bytes (11 GB, 10 GiB) copied, 111.609 s, 96.2 MB/s
$ desync make test_file.caibx test_file
Chunking [=======================================================================================================================================] 100.00% 18s
$ sudo bash -c "echo 3 > /proc/sys/vm/drop_caches"
$ desync verify-index test_file.caibx test_file
[=============>-----------------------------------------------------------------------------------------------------------------------------------]   9.00% 4s
Error: seed index for test_file doesn't match its data
$ md5sum test_file
ce4f1cca0b3dfd63ea2adfd745e4bfc1  test_file
$ sudo bash -c "echo 3 > /proc/sys/vm/drop_caches"
$ md5sum test_file
1edb3eaf5ae57b6187cc0be843ed2e5c  test_file
$ desync verify-index test_file.caibx test_file
[=================================================================================================================================================] 100.00% 5s


