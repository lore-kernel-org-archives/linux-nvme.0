Return-Path: <SRS0=ND0+=JJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104E6C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 07:45:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517B660FF0
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 07:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517B660FF0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=32ADs8rxANKcyMyu4mWMBIkGbt8ZaPCZ0EkzyaseFBg=; b=Tt8Ske88snPmT8t1oiiS2AuYx
	J99ZSZQ3vFY1SrNiaky74Jcg0OorYB80rBXO7Cq0Rs7vJo/3cNRmwySj9Dnf3yUBDFmpXME2/96L5
	3TGR9PbWusRZM0EKxmdJ3Atpc6cuL+KQJFG0fSiWWl62ScttAgXJsJEj8btnC/WtegEe9K5psRrgU
	oW2iEuv1ofXP3ja8O0+FLs6wNB+1uQvBSgi7xEh4ZXE4H80L8VQD9GCwFiFAToUSuzpCcIezBUbnY
	OQdsUdLOlIJ66CPAKPb8Pfc6GYYr6JDGgy6RAY0QorFHYK72rE+NI/W9m8GRlm8cSxm7+OJFp5W5k
	CQFaUXnug==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVrFt-0060uA-Dz; Mon, 12 Apr 2021 07:45:09 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVrFn-0060tm-2z
 for linux-nvme@desiato.infradead.org; Mon, 12 Apr 2021 07:45:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=CDMZ74Gid+GOYCUt0krCIOP8he1YJfkbgGjiLM/A8LU=; b=s+F1AAf6ew9XEb/OmdkPz2lfY+
 jvo7UxvP7vz5sBLOD4QudOZKeRtml7V4l9sQl14INnqbuPKUgTNairzyrsnuzpdVi7GPOLV+yC0GD
 Q0iNdVA5+wv0OZ6terUA7hg8JH08PWquem5jbRih9PTWwENX+SfI4udvNes3iMxNmRFAHYXMS3xPM
 GFUgRAEhFKjira6RvNZMkKWjPM9qRUHzJ+GmIceQw16JEjKHfkI5cFncnbzEXIznEKiBstZ3OOl71
 x6ThkrSGYvZYLqMqcEeMvwth/Y6mpLbpupG24ZHvRaUyUNM3irvZQhGDqlBo1q5ad4Vyy6zZo7cUW
 KU/uEESw==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVrFk-005w9o-Ib
 for linux-nvme@lists.infradead.org; Mon, 12 Apr 2021 07:45:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DD5DA68C4E; Mon, 12 Apr 2021 09:44:55 +0200 (CEST)
Date: Mon, 12 Apr 2021 09:44:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 13/13] nvme: introduce generic per-namespace chardev
Message-ID: <20210412074455.GA3653@lst.de>
References: <20210408120842.1450092-1-hch@lst.de>
 <20210408120842.1450092-14-hch@lst.de> <20210409072901.GA2085@localhost>
 <20210409075415.GA6991@lst.de> <20210409080214.GB2085@localhost>
 <20210409095205.GA15931@lst.de> <20210409112401.GF2085@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210409112401.GF2085@localhost>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210412_004500_780699_634B5B2D 
X-CRM114-Status: GOOD (  15.14  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Apr 09, 2021 at 08:24:01PM +0900, Minwoo Im wrote:
> I think if we don't have a route to the live controller from the
> multipath node /dev/ng0n1, how does application figure out controller
> node to request admin commands like Identify Namespace before their
> own I/O ?
> 
> We have sysfs, but it does not provide every information about the
> namespace.  Or is there any charming way to find out the live
> controller from a head node through sysfs or something that I missed
> here ? :)

The devie links points to the subsystem, which then points to the
controllers:

root@testvm:/sys/class/nvme-generic/ng0n1# ls -l device/
total 0
-r--r--r-- 1 root root 4096 Apr 12 07:43 firmware_rev
-rw-r--r-- 1 root root 4096 Apr 12 07:44 iopolicy
-r--r--r-- 1 root root 4096 Apr 12 07:43 model
drwxr-xr-x 3 root root    0 Apr 12 07:43 ng0n1
drwxr-xr-x 3 root root    0 Apr 12 07:43 ng0n2
lrwxrwxrwx 1 root root    0 Apr 12 07:44 nvme0 -> ../../nvme-fabrics/ctl/nvme0
drwxr-xr-x 9 root root    0 Apr 12 07:43 nvme0n1
drwxr-xr-x 9 root root    0 Apr 12 07:43 nvme0n2
lrwxrwxrwx 1 root root    0 Apr 12 07:44 nvme1 -> ../../nvme-fabrics/ctl/nvme1
drwxr-xr-x 2 root root    0 Apr 12 07:44 power
-r--r--r-- 1 root root 4096 Apr 12 07:43 serial
-r--r--r-- 1 root root 4096 Apr 12 07:44 subsysnqn
lrwxrwxrwx 1 root root    0 Apr 12 07:43 subsystem -> ../../../../class/nvme-subsystem
-rw-r--r-- 1 root root 4096 Apr 12 07:43 uevent


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
