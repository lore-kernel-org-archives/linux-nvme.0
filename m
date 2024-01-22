Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A202CC47DD9
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 15:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fXr11iCzefnxFD5s6+/z6E11JhCRj6Wc821AE9XmJdQ=; b=pxiad6ZEYl5gIS0k8P7qInqYsA
	PHEckbLSQb072d2yJPVmuAauPDs8kDoMloRy+xKI7fxfv0PRlyU1UJF105CbKTrEp7SRJ0f7yZpal
	ZphkL/vb3AXknT02y+/atZ2+yQp18VC8XCeMFEw+hI/rap3demnO+D8R60NALwv9sZGecJQ/r0RnD
	mtpRhefCeSeim/KxSsVfXhBCXaKupX0w9mTKAxcucJ2b91tnRsd8wC0JYSa5cL2vSdruKSXUnhoxu
	x8cjSUfbYLBj/jsaHsBqZLZqvep+p7gfnQ09+D2Q1wJg8dhtMOcGSKQiZTRmT/hshiyGXA/EPrtUx
	L/xWCUng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRwXf-00CnMJ-2b;
	Mon, 22 Jan 2024 15:48:55 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRwXd-00CnLA-3D
	for linux-nvme@bombadil.infradead.org;
	Mon, 22 Jan 2024 15:48:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:To:From:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=fXr11iCzefnxFD5s6+/z6E11JhCRj6Wc821AE9XmJdQ=; b=YA5aIYf8oSsmavuvPivERCTk2y
	vyC/+NgKG9YJoEO2K6RHu9kHhB61iUme+W43d+CibeG/jtuxdlJ7BcAnPk4jSWWB1xK9HPd+Ojm51
	uMDBDN+apFNzttCYz+GTj2wvZyZF7SyFbD5k2011oy8oucXgjmiSoxEkEBihYFeSltemwMYPVVhH1
	2LpednQ4pw5iyUghPndBCpuQJfrAJQilgrbUyRo1parj/rN7qTOaTRBGVkHMF+rQf22W2B3PfWfZV
	mi5WFJWPQSoZV16HvA2uHU0vr1vsWUhhH/T1Edk49U9aEccj0ms4KqcvHy7y+nZAMtRRueqckuQNo
	gOiP3jJg==;
Received: from 46-117-114-124.bb.netvision.net.il ([46.117.114.124] helo=[10.100.102.14])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rRwXb-00000000Jgb-1bJF
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 15:48:52 +0000
Message-ID: <9de87ea1-e898-4c98-8481-41a0beb71d0c@grimberg.me>
Date: Mon, 22 Jan 2024 17:48:50 +0200
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

Another test (sorry for spamming)

