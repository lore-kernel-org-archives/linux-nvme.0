Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765F5C47DD9
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 16:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q+JVMdj/l+NGQAe7FXneJHQkOcMkFpNoKaBkvO/E/HI=; b=OFHAMvoMDDdcgzet3YVGhQqHgS
	CjFE+yXNKlvdcrNGx5kZzYGyxF+S4xPBNCw8tNAr9P5fvaKvrF5EIzMLBxXHtRZnCvY3bkUAdhTwG
	ThUVtT4A7sItrHz6PQegsdu9WjVTxxL9EHjQLW3sckAdBXE+TR9W0I8ZVFpCE0yOI8QUGE/5by/zM
	d3qTqdcez50DDoBpdrYGV5iR8isMF7VqrTkazo3ni/bAr6qSATLWDzQI3rBlNRTXi6vT/nv0WU0L0
	qt/YTfc3xTGROfBMRG99ti3Z3PI0aF6+hcOD6GihMnoITj6vv0yXhFdmHBFNbFxpHER20JyKlu3lr
	sltFhK1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRwxI-00Ctsu-1r;
	Mon, 22 Jan 2024 16:15:24 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRwxH-00Ctsi-02
	for linux-nvme@bombadil.infradead.org;
	Mon, 22 Jan 2024 16:15:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:To:From:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=Q+JVMdj/l+NGQAe7FXneJHQkOcMkFpNoKaBkvO/E/HI=; b=r16Hhmhx2CP9lV7emTfjzr14X8
	AKX6jvFBowhCEtLepZv1ZUo7xlp7lmX2YhyUrtXJ81I80icRoWWa7TN0drP0mTZzFzyWCxz8BlbzI
	pcFSQg4ftREwovx2Xjbz+2QWbu36uoDKhN4Rl7COntlqUe8tqHhWGL6mVgXoc3UGIE5PwfSsH77tR
	NYZOr9OsHZeEmSWsrqLCw5cEEcRdSJo4dM/F+9f0SL9C/GGTOU9unT8PavGbCaD1bZG/jBIg/gqYo
	u/G6db6mSQD+CyAG4SnkC7qAcqaHhO29skgKFLDtpaw7OXSxp2GVqb0tFslwfjTOpjoQdxJHBKOIF
	Kiq+2KrA==;
Received: from 46-117-114-124.bb.netvision.net.il ([46.117.114.124] helo=[10.100.102.14])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rRwxE-00000000N9A-1FZ6
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 16:15:21 +0000
Message-ID: <c835765c-de5b-4c75-abdf-51dca733c771@grimberg.me>
Date: Mon, 22 Jan 2024 18:15:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Test
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
References: <20240122154712.1235940-1-sagi@grimberg.me>
In-Reply-To: <20240122154712.1235940-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 1/22/24 17:47, Sagi Grimberg wrote:
> Test test test
> 

test test test

