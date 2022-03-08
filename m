Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285B0C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 15:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0ZR9FwH3D+exTqdROkMCZNENmTbneHFVfFxZ1ZHcdXU=; b=GvIzVfzpinsnUhCMjlsQ8uOpJO
	QHnWFSy50YcRHq03U2iqY3PknzhCOry8id70QTdL8y2F2oPNcqzA/8KDT4IApJ4kEkn1a9FQtvtKE
	xLqaQ67vYxbchXtOLFuAEksaVkc1lgMWM0erPCmCUARmGpQBOdJj/7Ebbzz+fr7/AKTH98wQScIb7
	HQSElDpoMK4LWcxL3gtolq4/xfcGg6DOqRNCgahX4cMQ/c6rgt+cunJ0YZC1QKjNc8OZ9T0OVBBE/
	o4sjsJecEQqbdS5cGmpi9feKd4jRs/mcvp4CQEWO3oMuOVH5KfzbqO9MObJDpCCAup3fcgNW1K4wt
	joWFteBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRbtC-004zRJ-C6; Tue, 08 Mar 2022 15:36:42 +0000
Received: from smtprz15.163.net ([106.3.154.248] helo=smtp.tom.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRbt7-004zPj-Ud
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 15:36:40 +0000
Received: from my-app02.tom.com (my-app02.tom.com [127.0.0.1])
 by freemail02.tom.com (Postfix) with ESMTP id 87043B00D93
 for <linux-nvme@lists.infradead.org>; Tue,  8 Mar 2022 23:36:34 +0800 (CST)
Received: from my-app02.tom.com (HELO smtp.tom.com) ([127.0.0.1])
 by my-app02 (TOM SMTP Server) with SMTP ID -1584034737
 for <linux-nvme@lists.infradead.org>;
 Tue, 08 Mar 2022 23:36:34 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
 by freemail02.tom.com (Postfix) with ESMTP id 75C5BB00D91
 for <linux-nvme@lists.infradead.org>; Tue,  8 Mar 2022 23:36:33 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
 t=1646753794; bh=0ZR9FwH3D+exTqdROkMCZNENmTbneHFVfFxZ1ZHcdXU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=gswbSjw+I95T4W+FsQK9Gwk8QYERnmyyaoxghxUiShnuoLPtwxZiwnyl7FgbUa/Fx
 R70zw4ogsWxiD7OaHi8hGFWzWYdyo+C9RkHM8jknqBArgyqZapgU1/jsaZKUDWYoB2
 3iit3qc/NR+wF9Xt6IosoP/gcBx9pg1wzILSssDc=
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
 by antispam1.tom.com (Postfix) with ESMTP id ED8DAD415B4
 for <linux-nvme@lists.infradead.org>; Tue,  8 Mar 2022 23:36:32 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
 by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZNW0Xr0b-hFw for <linux-nvme@lists.infradead.org>;
 Tue,  8 Mar 2022 23:36:31 +0800 (CST)
Received: from localhost (unknown [101.93.196.13])
 by antispam1.tom.com (Postfix) with ESMTPA id 85940D4155C;
 Tue,  8 Mar 2022 23:36:28 +0800 (CST)
Date: Tue, 8 Mar 2022 23:36:27 +0800
From: Mingbao Sun <sunmingbao@tom.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
 libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 2/2] nvme-tcp: support specifying the congestion-control
Message-ID: <20220308233627.0000727d@tom.com>
In-Reply-To: <20220308151606.2563-1-sunmingbao@tom.com>
References: <20220308151606.2563-1-sunmingbao@tom.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_073638_374686_9271FC21 
X-CRM114-Status: UNSURE (   6.19  )
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

Per the comments from Christoph Hellwig, the calls to networking APIs
in nvme-fabrics.ko were deleted.

Since the tcp_congestion passed in from the user-space could also get
checked later within sock_common_setsockopt in nvme_tcp_alloc_queue.
So this deletion brings no downside to command 'nvme connect'.

