Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA41D68B07
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 13:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FSWhUoxAhdB6lSMDwjSVTKLi5Zip+jPlJqZckIZHULk=; b=NJGtHwbBtUvCjiLeuBeG6U26cD
	t75Jy5Hllz5yHEMU1ueYCDcBi2FmyZEqT3A7jAYLDUJMdZJz91kFcvhnoDtSuJguT7t9srgZjkD8d
	HT1EtI7vaSBQbs1+3VegEcNS0jFelBmmJf49Ym9uLAP/6mdgc3OEIpkll6tMNpwN0XKXQEr+Px4Ps
	gYcSZ8YLAN6kGr1D8h4QuvhuUTA667MhuXdPJbNzSORBHKh4mDYp4zshYA0ikuqiMwY/FXqgbaQlh
	FMGqIgWhGl0klxjRjDyoPpoh3HkVoFgFa0Juqkhw2lWMW4gekydXC5bJCdqtmybc4vvDItOdLvwCo
	3MLIzzrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBZcf-0000000A0vX-2Dls;
	Thu, 14 Nov 2024 13:10:57 +0000
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBZcc-0000000A0uJ-11fp
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 13:10:56 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1731589845; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=k/f+pTC01kz6e9kpLAwUe16ixePuBxkStoUqmQDBQOYbRvhaMN+sZKKi/s9OuTAUqDCflU0U+Rn0AfhwOw6By2MlhUcavrI5YhtrbofSWTWFzyKIhWuUqZpN2VHz58Hnou38+HBe6bgESHTXJfGZQ/UfjA8H2ZcklAIS9lOZ2X0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731589845; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FSWhUoxAhdB6lSMDwjSVTKLi5Zip+jPlJqZckIZHULk=; 
	b=cQhBwp14IR1lzSWQ39Son/gacJp4fRMDpaDdowZQDSlvGl2elWwh659QJfrWbbIy+Lgww7/an4hr67depTsyOt+nx8Abvby2cKIG05wb5N4s6mkJwq8UwzjLzqIh70616oohmMbc9a2HA7UaFTFj4CXJM6XaWTGn31rXl0cy/L8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731589845;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=FSWhUoxAhdB6lSMDwjSVTKLi5Zip+jPlJqZckIZHULk=;
	b=Mv/RAIVAnhD+zZ9lFK5Ms33Zg1em/70x4MmVVPM7iheG3kdqFyPKxkSgerrcp8fV
	2YE4ZsTVZkD6tiDuF0JeTd/3q8/1R+2czkJELKqp+JLXf/QV9xpD0n/R1URuXx/tKui
	7MRwV9Ji3MMDQeCPhm2c9efYAERQtWa2GpT47y9g=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1731589813271173.51718259903373; Thu, 14 Nov 2024 05:10:13 -0800 (PST)
Date: Thu, 14 Nov 2024 13:10:13 +0000
From: Robert Beckett <bob.beckett@collabora.com>
To: "Christoph Hellwig" <hch@lst.de>
Cc: "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
	"Sagi Grimberg" <sagi@grimberg.me>, "kernel" <kernel@collabora.com>,
	"linux-nvme" <linux-nvme@lists.infradead.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1932acbb3d1.10d91b9c8590854.6159524670771006351@collabora.com>
In-Reply-To: <20241114055544.GA10948@lst.de>
References: <20241112195053.3939762-1-bob.beckett@collabora.com> <20241113043151.GA20077@lst.de> <ZzTqgXqjN4UrT392@kbusch-mbp> <20241114055544.GA10948@lst.de>
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_051054_389726_510537C7 
X-CRM114-Status: GOOD (  13.27  )
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






 ---- On Thu, 14 Nov 2024 05:55:44 +0000  Christoph Hellwig  wrote --- 
 > On Wed, Nov 13, 2024 at 11:05:53AM -0700, Keith Busch wrote:
 > > Well, he's doing what I suggested. I thought this was better because it
 > > puts the decision making in the initialization path instead of the IO
 > > path.
 > 
 > I guess it's fine in that regard.  It just usually expect patch
 > authors to at least reply to reviews..
 > 
apologies for not replying directly. I assumed a new patch would suffice.

