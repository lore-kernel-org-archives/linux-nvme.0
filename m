Return-Path: <SRS0=jPKm=2D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CCFC43603
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2019 01:22:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6025821655
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2019 01:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gduCi5m7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6025821655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KC0wnykspE9j323vU/LhKIGaJ0RwhOgtUYMiPmKXnCI=; b=gduCi5m7oAYapg
	wF7PIOt98EdrmsA4wM9p7YoktAOwcRKiobQJ0oQA8ERJX8B3rvRC4R3v2megLxzm+GjdC0TgkI54h
	Hv9PRdTwBy/vFV5pVtJOcl8j+8AqGM4afgAvC1vtjLlTVHrqlpsmk6nFZP7QhFMZAGJZZlwtAKcGA
	upzPBW55q8CoxJiHML+uHE2NnwugCS5jM87rBerXQVP3G/O3xAbqKqSG9gi3utb/kEDWPgPydIy/D
	9nPfAGqy0i5odBc94HmMnTh9bgHHbC3T4bRyGRKgqjIK1b2APZyuW7WFHhnQFF/+TtGfM1QbQjg82
	JdTHx/srqa2ACGfo6IMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifZfN-0001HQ-7z; Fri, 13 Dec 2019 01:22:49 +0000
Received: from mo-csw1514.securemx.jp ([210.130.202.153]
 helo=mo-csw.securemx.jp)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifZfJ-0001FC-Qj
 for linux-nvme@lists.infradead.org; Fri, 13 Dec 2019 01:22:48 +0000
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id xBD1MI8f004858;
 Fri, 13 Dec 2019 10:22:19 +0900
X-Iguazu-Qid: 34tMW239prEbamBl7g
X-Iguazu-QSIG: v=2; s=0; t=1576200138; q=34tMW239prEbamBl7g;
 m=DbsMCbvPb+sjHY3Tcm8122ptWVvKsoNwp0ip2wil+9M=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
 by relay.securemx.jp (mx-mr1512) id xBD1MGoF018190;
 Fri, 13 Dec 2019 10:22:16 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
 by imx12.toshiba.co.jp  with ESMTP id xBD1MFpl013668;
 Fri, 13 Dec 2019 10:22:15 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
 by enc02.toshiba.co.jp  with ESMTP id xBD1MFWW024230;
 Fri, 13 Dec 2019 10:22:15 +0900
From: <tsutomu.owa@kioxia.com>
To: <kbusch@kernel.org>
Subject: subsystem reset question (RE: [RFC PATCH 0/5] to add more nvme reset
 functions)
Thread-Topic: subsystem reset question (RE: [RFC PATCH 0/5] to add more nvme
 reset functions)
Thread-Index: AdWxSppTAiT/t2dDQwKme0sGrrN4wg==
Date: Fri, 13 Dec 2019 01:22:14 +0000
X-TSB-HOP: ON
Message-ID: <ba698ab21fef46f18a40fcdec2db6d26@tgxml778.toshiba.local>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [133.118.176.119]
msscp.transfermailtomossagent: 103
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191212_172246_070154_4EAB9B01 
X-CRM114-Status: UNSURE (   5.94  )
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
Cc: hch@infradead.org, tsutomu.owa@kioxia.com, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Keith-san,

thanks a lot for your reply.

BTW, I have a question regarding subsystem reset which is almost identical with the following post.
http://lists.infradead.org/pipermail/linux-nvme/2016-October/006609.html

I've tested 4.19.87 and 5.4.1 kernel with a few nvme devices and got the same result;
the device disappears after subsystem-reset.  It requires nvme remove and rescan via sysfs to recover.

I suppose that this is an expected behavior since the result looks same, but would like to
make sure that it is.

===
[guest@localhost ~]$ uname -r
4.19.87
[guest@localhost ~]$ nvme --version
nvme version 1.8.1
[guest@localhost ~]$ ls /dev/nvme*
/dev/nvme0  /dev/nvme0n1
[guest@localhost ~]$ sudo nvme id-ctrl /dev/nvme0 |egrep "^mn |^fr "
mn        : INTEL SSDPEKNW020T8
fr        : 002C
[guest@localhost ~]$ date; sudo dd if=/dev/nvme0n1 of=/dev/null bs=4096 count=1; date
Fri Dec 13 10:16:01 JST 2019
1+0 records in
1+0 records out
4096 bytes (4.1 kB) copied, 0.000172932 s, 23.7 MB/s
Fri Dec 13 10:16:01 JST 2019
[guest@localhost ~]$
[guest@localhost ~]$ date; sudo nvme subsystem-reset /dev/nvme0; date
Fri Dec 13 10:16:10 JST 2019
Fri Dec 13 10:16:10 JST 2019
[guest@localhost ~]$
[guest@localhost ~]$ ls /dev/nvme*
/dev/nvme0  /dev/nvme0n1
[guest@localhost ~]$ date; sudo dd if=/dev/nvme0n1 of=/dev/null bs=4096 count=1; date
Fri Dec 13 10:16:28 JST 2019
dd: error reading '/dev/nvme0n1': Input/output error
0+0 records in
0+0 records out
0 bytes (0 B) copied, 32.0633 s, 0.0 kB/s
Fri Dec 13 10:17:00 JST 2019
[guest@localhost ~]$
[guest@localhost ~]$ ls /dev/nvme*
ls: cannot access /dev/nvme*: No such file or directory
[guest@localhost ~]$
[guest@localhost ~]$ sudo sh -c 'echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/remove'
[guest@localhost ~]$ sudo sh -c 'echo 1 > /sys/bus/pci/rescan'
[guest@localhost ~]$
[guest@localhost ~]$ ls /dev/nvme*
/dev/nvme0  /dev/nvme0n1
[guest@localhost ~]$
===

thank you.
-- owa


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
