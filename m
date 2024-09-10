Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CDDECE582
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 09:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zlAWGAMR/XQQF80+taBk+m4GPNM0qyL7BM9k0wks0no=; b=G0GsnH6t7bHlPLEtD5m8twgTs9
	B5dZ4tJoy2C7n3Un65uH5R1k4dOAH3Y97DHB2WIKjhVA8jEJsM+qZt7Y2j59Ma0EE76Sxhcpq/Kiu
	5CJVOjzFYRvXAGpzSrRAYu61ngEz14YRj8E4/r/Z5eBVCYo7eUnkaATZ4/ZvumlUH63uiUHWqjnIB
	FJ5ingis5qhivU6jgYAeWYXPU3NrBVDOOhqv2pEt0p/zT+AVuebWNtjHRVBrmq6KRmLMqra3BAju4
	OFo4ZkrtSklwPMloXnirxtmgUWaBO1cV3Z8S+A7j0lE879+gclfByqRR1x7PRnN2/UnltJbYFdO20
	gL7kXtmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snxKA-000000052xN-1ypM;
	Tue, 10 Sep 2024 09:38:14 +0000
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snxK7-000000052w4-0DPw
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 09:38:12 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1725961088; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=P9+QC1DVkKXMxXHb+7VHB0pKhnoGgB465hrcnyOfx4l+5x0RIN+09zbILvs+4jeJpOn/vZhVQKy16i6XuZDCwhbWH1j3EGQS1ok4/gTVoI+wXumEFoLh5mmP26MVVG/iQ3AVKDEAEkn5D+lnQW3Io5xvAoG7/dC1KH603m2rYq8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725961088; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zlAWGAMR/XQQF80+taBk+m4GPNM0qyL7BM9k0wks0no=; 
	b=QOg0SiOH8YkfItcLdutTbc72hTsQ2jFEaY/BOuSubxS5L2al8jKwky3+bcnglyb15+l9NewiZwfBom7zfMmJ1GdE/VC7cFCoLTHSlU4b6zhivS2vAVZcT3t1mLWDuGiP2mZQm6VPOEttzC0ZEpBUnpiHU6uas7LTmZf55GBHHPo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725961088;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zlAWGAMR/XQQF80+taBk+m4GPNM0qyL7BM9k0wks0no=;
	b=j9i/yl1fPQczk/wHycdqcMjP56/cAUOFuRigq6oO3eRu7S6H8BgadN4eAv2lHhdF
	LDE7z/t2JFghLNosCDXNYZoaPtI6smcXY4aTdnS2MOV9RgqR1WPuUg41UvarH7+WBCD
	N8JqGGLPWqfXrWtyeErXEpotI2jLAMupd/dGJFjQ=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1725961058042760.1255232461166; Tue, 10 Sep 2024 02:37:38 -0700 (PDT)
Date: Tue, 10 Sep 2024 10:37:38 +0100
From: Robert Beckett <bob.beckett@collabora.com>
To: "Christoph Hellwig" <hch@lst.de>
Cc: "linux-nvme" <linux-nvme@lists.infradead.org>,
	"Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@fb.com>,
	"Sagi Grimberg" <sagi@grimberg.me>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"linux-mm" <linux-mm@kvack.org>
Message-ID: <191db4bb6e4.efaca8f7990517.372475432909163316@collabora.com>
In-Reply-To: <20240910042411.GA15282@lst.de>
References: <191d810a4e3.fcc6066c765804.973611676137075390@collabora.com> <20240910042411.GA15282@lst.de>
Subject: Re: possible regression fs corruption on 64GB nvme
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_023811_184996_A596E0A1 
X-CRM114-Status: GOOD (  10.29  )
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

 ---- On Tue, 10 Sep 2024 05:24:11 +0100  Christoph Hellwig  wrote --- 
 > Hi Robert,
 > 
 > what platform is this on?  Does it have DMA that is not cache coherent?
 > 
 > 

I't s an AMD Zen2 based device, should be coherent.
It also didn't occur on 6.1 kernel, making this fell more like a regression to me (though never discount statistics)

