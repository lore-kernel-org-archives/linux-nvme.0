Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCC9C71153
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Aug 2023 23:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qBlbdawOVe2RY5CaEGmqAFN7Qj8QDw1yQiewvNd8PTo=; b=VXcjL0ElnOIhCbLvHb2yeVMVZc
	nSHyJKLjxOCpYoVc30iH+ZycalA44zqXmXE6dkjVb+TKSVn02LOtYYRkqONbRSZwvS9M+fXw1WzDb
	COE2YOc5jYw5si5EJ9sgR3q6KzE0vSU0LBB0uYXz0W/Dl6o5eBR96hki8/KoNfTXoyWMQTGq4lCsm
	SZvir4LTxmMgfdarkJmyCwfpNbXj6n3StTjeohV8bUbJL8UeEfaxDWaQ1MaMXYgAeMZWvJ0ESsVBZ
	Lzq9IK8Puq89znS2w2MDjS1OUPgcMIOlIdJLF6Ej1ZrN0UOEeivq9udd5QW5OQyjxrXq6bB1Mf47Z
	hEZ+48gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qb8LM-00CSkR-1Z;
	Tue, 29 Aug 2023 23:41:56 +0000
Received: from mout01.posteo.de ([185.67.36.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qb8LI-00CSk0-1B
	for linux-nvme@lists.infradead.org;
	Tue, 29 Aug 2023 23:41:54 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 76166240029
	for <linux-nvme@lists.infradead.org>; Wed, 30 Aug 2023 01:41:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1693352507; bh=D6AYcLbD9pyug1LRusmbFmyIx8d1u0ojE0a7WGxPfcI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:
	 Content-Transfer-Encoding:From;
	b=E1UA3umtxlMcu7FDgeUIryd/e3tYyoRICaaJb5wQEeLUq0GLbKaLl158Uj1BAYCNy
	 TjR/rQYBcpolQqFtmH+8gs36Z3y5DCkFQMDRK2oTVLSi402Jsz3qGItmjP0KpeEfhJ
	 ZdK4whamNe3clJRDIaagv9GPvFLak4aN8oNakphqGpOxffCr31fmru4Uk2IgcpeGik
	 fyVBe1+QrS+zs7M5F/SyntFiu6BCGxopnlT/MnsFMDF3Anp7kJg/6/EcnJMFk90F+8
	 R0AjPFAOJdMuryqMf1aH40ySGTGJp+1DAxpIYemrP+VFS5mjHivJJdpJ6EXwpBEBFZ
	 l9Tx2rBqEgKNQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Rb3qD3BwDz6twJ;
	Wed, 30 Aug 2023 01:41:44 +0200 (CEST)
Message-ID: <08a9b45b-f1e8-3fac-3d02-54b7bb31d954@posteo.net>
Date: Tue, 29 Aug 2023 23:37:15 +0000
MIME-Version: 1.0
From: Mark O'Donovan <shiftee@posteo.net>
Subject: Re: [PATCH 1/2] nvme-tcp: auth success1 msg always includes resp
To: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
 kbusch@kernel.org, hare@suse.de
References: <20230828212033.3244512-1-shiftee@posteo.net>
 <34c159dc-c534-2329-4049-7e9e8a53cd4d@grimberg.me>
Content-Language: en-US
In-Reply-To: <34c159dc-c534-2329-4049-7e9e8a53cd4d@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230829_164152_578671_B5C06393 
X-CRM114-Status: UNSURE (   7.50  )
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

On 29/08/2023 12:47, Sagi Grimberg wrote:
> This is not nvme-tcp specific.
> prefix should be "nvme-auth: ..."
> 
> I'm assuming that this passes blktests?
> 
> Nonetheless looks fine to me.

Yes, the nvme auth blktests all pass with this change.
Sorry about the prefix. Will fix if doing another revision.

