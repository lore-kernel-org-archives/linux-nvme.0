Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2EDC47DD9
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 16:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q+JVMdj/l+NGQAe7FXneJHQkOcMkFpNoKaBkvO/E/HI=; b=JOoXPjpy/o3cu5p+Af8pllsJ/9
	YM2mHKv7etkhS68ziEaWpeGJP1VFnjHXSZ12oJKz9lZ9Qi1tmI26HF8K17sH/hATM/GtindInrxEV
	0QSgKsVhsgWgsLGfSgrA+oCTPBvSVVKE8l81TGHPwrZm+uSzzpymYrnBMo8tMbFUWfwRhyJTDAL+F
	V4ZstzwQH8nncxV7lpY+NLuPoGyRhnI01eAbSEMCIr8N3jCs9fiDMkhSgBVtbyw0/nNUdd0LsZC65
	ZT0iSHIpbWKzyxw3DTdTQc1PV+JOenCV52VXNyputU5DXEiPd4m9xOuTNU7yeT9gWlACzlCLiI4tV
	fXchXMzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRwyi-00CuFn-0n;
	Mon, 22 Jan 2024 16:16:52 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRwyg-00CuDz-2y
	for linux-nvme@bombadil.infradead.org;
	Mon, 22 Jan 2024 16:16:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:To:From:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=Q+JVMdj/l+NGQAe7FXneJHQkOcMkFpNoKaBkvO/E/HI=; b=GL5yr81deICXf7eHGJPSWwHFtC
	+ySIZRtgFJZ2f62GG+4r30yztIfGZ5tfbDq+riBMVJ2lIyL8tmBn+YDXoW0RUKkDVcmtxt1ukmiSI
	/v85lksB7fD/BVdCjdRMU+ZXqwTte1oitFB66nEJYZK953dyt261jvsnXEqvrtOicCkiDcRVgVPNP
	zphfH5nBgCyAuzUHaa5cbGKdOi0DdivapUEBoImLr5bAegBsqFGJegxEmHJC7D6chDDKwdL7pkGCE
	+ZqUWXppFtwAq0/bedcgkh1Z+xoWnUTGxQhMx67b2MbVHXruvv5+KKo+NG1R3c9SUjpCmp9nP8KUb
	oXg8nYcg==;
Received: from 46-117-114-124.bb.netvision.net.il ([46.117.114.124] helo=[10.100.102.14])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rRwye-00000000N9A-1jdG
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 16:16:49 +0000
Message-ID: <2607637b-b9e6-47a2-af65-830a8d729c2c@grimberg.me>
Date: Mon, 22 Jan 2024 18:16:49 +0200
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

