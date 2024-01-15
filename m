Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1832C4707C
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jan 2024 12:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=92yYWvXugpBAZ9qccr6vP6U/Ys7JQ0xeSC2s9XDbNe4=; b=NxH8aWRrUh4PIT+d94hCwW6Rg8
	81NhUzmZ3sF0osdNw1NUogVoerubW31EY5Ae9V0DMtSIGt3VcLiQAB2+0jj3jJ9vG1B3Uy0yYI7M4
	9d+4q/4QLk4tjg2FixILIoEC+0idLZCENzic/Iab9k26ZmH8mwFKbIJ/H++ezEiJImH/RLbLYIn11
	uyAZYvszFcmpkbkVHODS9vrZbH0CD20T7DskjCWznsUJY/p+IOsCvZmkcWAfkAlGaF0ib5QC0mxHx
	vcDlL0Ur/FkKaNrNbhkA/JsUau6Go8hW0NFle6SR5B7/2hSD/u9Nv8/UE+WNX3uTPJPwhV7wQds1H
	QrlhEr9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPM1D-008tng-27;
	Mon, 15 Jan 2024 12:24:43 +0000
Received: from sendmail.purelymail.com ([34.202.193.197])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPM1A-008tnC-1W
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jan 2024 12:24:41 +0000
DKIM-Signature: a=rsa-sha256; b=BnDQLjKOW19avyvqmZiJX+5Hk0ojNMHF28dWv/L/51Me1N3MXrOePTuvUPeGM0XZ5+C6wUyAqBbGSiijktKG936gz7NXwxY94cXfzeRmt66oyINQYxtOh6mnn/gl/FI9XPcVh4NEXW6Rg78tx4nHCSG5yq8in0nISgAXKi7j/HL9wYWBW1NK0zKku6vg1kUpBkfLEsvjujHHxvRPUyBwEG6nr9VlBjZR0ZdAY2VpxQyXjdHDjTvULiKtdWTjdWtIU5s+S97ZQB7JkS3lS9NacW7YurygcDF8lQxU5QT8JIzggWn9Nsc+VEtQ50PzPacuicmBtt9eHyoPCe4Xe1oStA==; s=purelymail1; d=saulv.es; v=1; bh=92yYWvXugpBAZ9qccr6vP6U/Ys7JQ0xeSC2s9XDbNe4=; h=Received:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=WWRBY/zd3DnFNdkcL6+X4ffWMA8DJ5YUrZJNtKP7CL2lFKJWYN9uoukuS72ZWXr/fWxDqfFCN0dbYsSRhTdbrSX5GoVsFvm458NFJhbGuKrt93MT8ljV4u6E+T3Pw92uer4uD8CGrDTXj+l1RwE9DinI5FLa8sR6qJJOauEjIKFXsR70I3pBVZ8We90yYR+smVrhCUybLUvf4LmYlEToHoMFi5VthItDMQypI0oAGgvLgin7y85mwG/bevMNEO3PCazwq/b0aLk+4HOOqGZQ3mtI1RGvb19GbjcqvnsPLsPJR+8ZfdAojkhOdH2b2RbTGyW34DlHqLp15EZVAwBTww==; s=purelymail1; d=purelymail.com; v=1; bh=92yYWvXugpBAZ9qccr6vP6U/Ys7JQ0xeSC2s9XDbNe4=; h=Feedback-ID:Received:From:To:Subject;
Feedback-ID: 13394:2854:null:purelymail
X-Pm-Original-To: linux-nvme@lists.infradead.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1040886809;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 15 Jan 2024 12:24:15 +0000 (UTC)
Date: Mon, 15 Jan 2024 13:24:28 +0100
From: =?utf-8?B?U2HDumw=?= Valdelvira <saul@saulv.es>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Add quirk to fix hang issue on SanDisk SSD
Message-ID: <uo4isru6o4xt4n2sdrlz3msdj3hv2dbeh3qhmyduhwjlwkas2f@7zwaenqvjbvg>
References: <20240113213012.30898-1-saul@saulv.es>
 <6c87384e-36ee-4050-863d-63345a6951d5@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c87384e-36ee-4050-863d-63345a6951d5@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_042440_806003_90422E3B 
X-CRM114-Status: GOOD (  16.98  )
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

On Mon, Jan 15, 2024 at 10:57:50AM +0200, Sagi Grimberg wrote:
> > This patch fixes an issue I've always had when running Linux on my
> > Acer Extensa 215-22 laptop. I think it might be useful to other people
> > with the same hardware as mine.
> > This is the first time I submit a patch to the kernel, so I hope I did
> > everything correctly and that I'm not wasting your time.
>
> Does this issue have a bugzilla link?
>
As far as I know, it doesn't.

