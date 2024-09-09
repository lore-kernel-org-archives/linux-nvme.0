Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC3ECD4F4C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2024 07:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; b=KLqTOC5QqQDmw6vWzJ3IuN4dgE
	8bEP5z1+ht0dqyKcZxTbA7K1jcq4IWz9vq5Ik27vtRLVixBKzyQ3rc/4PTebmOwAP1mWjSJqeZMKZ
	zZg/0QlkUEfHBYxBjaNtOsWKZ8Fqy/s8+g8U1BltnjO0lOzk1H9Xp1bMea2ZpsmWt2D4vMjNzxD2w
	OqBD8SdQLAruJH47kopqnHBiLMlBJKxjcWuRbnZR76vo30A1nx9FkZd0tL4usSuT4bE7iIzB9Wg9k
	qOpaWPT2Z9CNao3CLyEmXdsvUWK8g0U/c7apkrSLTYKetDmUVz0/cXHxDP6yQFVBs9D2gVVBhVDow
	DKj4ADLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snYQY-00000000ipF-3WIx;
	Mon, 09 Sep 2024 07:03:10 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snYQD-00000000ini-0Inx
	for linux-nvme@bombadil.infradead.org;
	Mon, 09 Sep 2024 07:02:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; b=rLyxSd/HerMRjkFML+lfjI8mPy
	oh96iRbHKSJlmEsSSX5sqCAMY29SfNzt9Ge5rSmh3L/ZBqMG29NMGypBmroZOPjPHHt5FQAxwS1bj
	DpRjd49mql2O0WeSNrMWCrq/hOXDnbYsLbcgPGYBTQISwHGI8PMzvdCTmFuabLDY+IDs0NX5sNyDN
	GT+r7pEDUwlyAzI5sndonq96mTAf/jKlJ492A/1w8ld9SHPG1mX2uPmmgEbgzqsNNFABKOi05+IZX
	/idGoGsJHFK0JNuzopSnUvi+8Shixfzbgulvtrxk/Mcl7QnOLbNAB/gnpTU5rG6JuWF7vE6VYMHtB
	heuZputw==;
Received: from bzq-84-110-32-226.static-ip.bezeqint.net ([84.110.32.226] helo=[10.50.4.202])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1snYQA-000000091ZT-14Hb;
	Mon, 09 Sep 2024 07:02:47 +0000
Message-ID: <a6f382a2-51f2-4721-8d35-2f4769fe8c58@grimberg.me>
Date: Mon, 9 Sep 2024 10:02:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Subject: test [IGNORE ME]
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



