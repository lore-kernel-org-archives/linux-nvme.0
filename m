Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A0CC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Dec 2021 15:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gGqzkkOuD1jeuSTDaw2wHn9n6OJ9CKhEbCBAqrOc7y8=; b=OeGuahrADZ0OIFUQDLe11pB4Xj
	iHMTtdXLA9u7cKYbWmLrmYXiXMnJZ5TY6gur8ZRhTcezU0dGBQaf/MbD+R57qdgSODBQE3j/IbtOH
	9FlmJJfEUB2tRpjHn00tBySUgzLfEJ+cbBMej+0obWVESejnv1806wroJUHFYdt869x3FcTql7NRB
	usVzVubiBzKv/QKzR31kBD7c+I2OCbM7L+6i/lWBMIpSBuLY7YmCDvmV6L/DkEo9xxjN+sB1nGD24
	uBv6BAjNJdsCoOUgJGM20I9n32Hd4c9EvTYo8ABGUc96A24F2GY4RM51HltMtKoIrgFNxLyfiW6jN
	dIrHVLAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mtAGd-00GKm0-8l; Fri, 03 Dec 2021 15:14:31 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mtAAC-00GJ34-8y
 for linux-nvme@lists.infradead.org; Fri, 03 Dec 2021 15:07:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CC72F62BC1;
 Fri,  3 Dec 2021 15:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C68C53FAD;
 Fri,  3 Dec 2021 15:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638544070;
 bh=lGlWskb+ohmBP+KnDzbN0ob8ExRxek+/Edt3jRgh6TU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cc1X8INK21wvbGeAJlK8Mj5xr3V/qvmwEBoMrFluT3QYuBJtXRyoqxF2aiakbnxcP
 SraZ5sneHADzfgXaop0RRMRZLgqH5o6hyDO4OvJipHKJRFUwnGvA922zwGnEKBd7w4
 +dDGqQMaJJCUqQ0OSwgsfrlPb5pnvV/csvSCcYuRvuGCdvP4gJOP5boanRNLkIxaug
 8dOpYKy0EWDlsgFo7jWchvY2Glw5NO8yCTykF4XnprBuiUgu+e1WVBsji9DLskVSQY
 rTNw07wap2OB+YcKWTUAiiB9uAzF9qIYqc9IP41AlrTsrNI0n4ur3Fuu8L/a5EZ99+
 aXfbrG0hCsZAw==
Date: Fri, 3 Dec 2021 07:07:47 -0800
From: Keith Busch <kbusch@kernel.org>
To: =?utf-8?B?5pu55Yab?= <caojun@uniontech.com>
Cc: axboe <axboe@fb.com>, hch <hch@lst.de>, sagi <sagi@grimberg.me>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add Intel 760p/Pro 7600p nvme disk
Message-ID: <20211203150747.GB3839336@dhcp-10-100-145-180.wdc.com>
References: <20211202030230.17507-1-caojun@uniontech.com>
 <20211202175539.GC3836713@dhcp-10-100-145-180.wdc.com>
 <tencent_5722FB4254C69E931F449D17@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_5722FB4254C69E931F449D17@qq.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211203_070752_394011_28407FDF 
X-CRM114-Status: GOOD (  13.02  )
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

On Fri, Dec 03, 2021 at 09:37:45AM +0800, 曹军 wrote:
> When I use two Intel 760p/Pro 7600p nvme hard disks under the 4.19 kernel system, there are two problems, sometimes only one hard disk is recognized, sometimes two hard disks are recognized, but the serial of the two hard disks in sysfs is the same
> 
> 
> &nbsp;I looked at the latest 4.19 kernel and did not fix this problem，so I want to merge this patch into the latest 4.19 kernel

Please see the rules for posting patches to stable:

  https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

