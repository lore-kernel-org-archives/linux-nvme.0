Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08022C3DA79
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jan 2024 13:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N10VMK8xfjNh6e1wbj3IHfGf3VxvB+a0ayCUr2fT20g=; b=t2jvvrzcWrv6cSCRzkelCoyqqv
	q/mzog06VrfvJJEHN+K3nZJE6O+xbK84w0tCItPcYfBfJBDiSb/agoLfijWBHPUzBjjyJuMqIkY9x
	UH3OWEltjzl4LgfIwisyCK8xNp9+ry6IERZ0u2KkaHw6gqerh1A7joe4SDVOdxGnXammlLsDhKWNu
	m5fly8fFjW3p/VmWgxepPo7BvC7iRZ7a1be83piAn2m7aKqzj+Ilj2TPbUzXnnqmp/teMx5C7MlMQ
	JxVUWPoubl0TTXJzAwxSUyGTDVdsXcOkklHhPDxctMIuZANKJg4mHZQ3OETL2dSnYb68+A932oxff
	Fsby8qDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPNGu-0097Id-2O;
	Mon, 15 Jan 2024 13:45:00 +0000
Received: from sendmail.purelymail.com ([34.202.193.197])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPNGq-0097Go-3D
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jan 2024 13:44:58 +0000
DKIM-Signature: a=rsa-sha256; b=MclELIcknfNkQUtsEeg/2ZWG1mZ5vS7xHMPgahawNIyS7l7kHxFUdXLyUUVtXs6P4AqTceU0e9xHUmhfajWbhLQvFwVZ3Rh3bPbvliabq2R5St00G0hLew52cg6DsX/oXdFVsBu3Cfli5AyFQT+qrwL1zRcyhlx7frnPsN0Wu41GdxMTtPy/7T4iYLg6H1aegE6ZgFJelcan/9v2pau0JlWvx7T/IBo29JRQ9XigKM39vyknEvNDCRiQgvJkAZSZo0XweKOOj3Z/3ti8hM5x8LwkTIYdPp2EPQTWySAoWO35zr0sEWmpVyuagyBgmK8+flgU03O4T3Yn5AjV7hVxpg==; s=purelymail1; d=saulv.es; v=1; bh=OtWgboAayKunzYrYyCLLRn+fBLD2U4gTNHOxtZfoVoc=; h=Received:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=bHUtLQeS9trTcbpiU628p+b7W3IP8DnRyWRzItIQUu/gTPxUjNO1TUBcCiNZTh5UroEOWB0Hc2YUw8Jc5g60+B8A80/9aTArDqRIfk5VIAOk+uRo7uJP5aqlat5LVpJJLUiuop3X+dsOE8APgZvmk5aztCM5TtLEtBmuGJ1BDymrgFmfMgZ1tUo3RO9N1xuornAYKbV/un4hPit3JfynBxoTFtPuAASxbNTufp3juriXZTwucIp+GITtqtQpjrNt/Lu1aGD9AhzY1kinyu+VQ1IyCM5zgiUtUsar+J6nLpw3lbt6n2BlDN4WM1QNxdjD1MvdzvTxxB5gZcAEiYTANQ==; s=purelymail1; d=purelymail.com; v=1; bh=OtWgboAayKunzYrYyCLLRn+fBLD2U4gTNHOxtZfoVoc=; h=Feedback-ID:Received:From:To:Subject;
Feedback-ID: 13394:2854:null:purelymail
X-Pm-Original-To: linux-nvme@lists.infradead.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -10010050;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 15 Jan 2024 13:44:35 +0000 (UTC)
Date: Mon, 15 Jan 2024 14:44:49 +0100
From: =?utf-8?B?U2HDumw=?= Valdelvira <saul@saulv.es>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Add quirk to fix hang issue on SanDisk SSD
Message-ID: <lnfpduryv5nwibiejqxnvohr4pcismnkyzkowqvit3gkpdgt3d@ojcvlonaolzu>
References: <20240113213012.30898-1-saul@saulv.es>
 <f2822df1-22db-426c-86cd-a7509e624e06@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2822df1-22db-426c-86cd-a7509e624e06@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_054457_208027_53D5B79E 
X-CRM114-Status: GOOD (  15.06  )
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

On Mon, Jan 15, 2024 at 02:48:11PM +0200, Sagi Grimberg wrote:
> Is this specific to a certain fw version? otherwise this should perhaps
> live in the device ids table in pci.c ?

I'm not sure. I'm trying to check if there's a newer firmware version
for this drive, but the manufacturer's page [1] says "Firmware updates
are automatically handled by the Western Digital SSD Dashboard app and
apply to Windows exclusive systems", so I don't know if I'll be able to
update the firmware to check that.

About pci.c, I also tried adding an entry there like this:
    { PCI_DEVICE(0x15b7,0x5003),
              .driver_data = NVME_QUIRK_NO_DEEPEST_PS },

However, it didn't fix the problem. The only way I've managed it to work is
by adding the entry to the core_quirks table in core.c

[1] https://support-es.wd.com/app/answers/detailweb/a_id/47188/~/p%C3%A1gina-de-soporte-e-informaci%C3%B3n-de-western-digital-pc-sn520-nvme-ssd

