Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7E3C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 17:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5K6gfjt/6fDUJRQVpKaKe2Aa95UW3dW2wH/fO/u4ZK0=; b=P98HE7R2RzeOxF6YOLwujfwg9D
	jmDPyMudQwmNOmXP0+C9lTSjozuwp5O0wd7b/0kM0wn2Bej0IFCUCkfBeEgyWnYke3mNA8MCRpGTs
	IkVjgJj+3ObwtZQ2U2PU3Um6URa/Ubfga+mVHiqXqic3PeXfnr2K/ooBoJy89Y0wTadGQ2raDbiS/
	bc3WTP1jeEypGpPhk3PyKzV4fzvEVM4841cxG5QCeH5w1TSSzG2jQdN7KkHCk1HN8kEof5KdqIccF
	6pbPj7TQJvqlpXOHkK37SASNQBR9SEFyZPMVVUiPkp2lxlCrEnnvbwQeTFQl8Nc08ioMEYGbdwdIF
	tIt7doGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjKE7-0000000A5aO-0Dkr;
	Mon, 13 Jul 2026 17:13:55 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjKE4-0000000A5ZT-3APY
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 17:13:54 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gzTYT5cyHzlfgPY;
	Mon, 13 Jul 2026 17:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1783962828; x=1786554829; bh=5K6gfjt/6fDUJRQVpKaKe2Aa
	95UW3dW2wH/fO/u4ZK0=; b=tmYZSYhVF5tcT0Ypy2tVDuAIJNzd3bSa7jvqu2sF
	FyDyZcky+qPjp4Y4ArmElXZ/VPJVMM3UgP+UHlXqz13UkyRZhPEIjeiWWtVJuzXa
	2pBzIAvcR0GOdmpOx8/glI5vDf+9TCF+TJ4sMQ+jGA9cEbdKwIt+U2BAAwZnvD5n
	k0bq4bJRZA5T+nje5D3mxrdAUGdoQ6axwdv5LvqL91F/q0wewnVO6xFD09d8UFIg
	QYvHaFG6Us5vt46fTOYi01blBUuGHq4SWNJZKuQ7SxPT3zYYT9f5jhvV/e1qOY1Q
	cFvkmwwbFPw7zrcEUEzBVSPjkwUfeNRT4hZgzOGceyXnGA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id sANBuWLaxW_s; Mon, 13 Jul 2026 17:13:48 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gzTYR5dlPzlfvq7;
	Mon, 13 Jul 2026 17:13:47 +0000 (UTC)
Message-ID: <ef7dcd20-991d-49dd-ace5-ee8360ef4f2f@acm.org>
Date: Mon, 13 Jul 2026 10:13:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 0/4] misc fixes
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_101353_292402_6E63BF94 
X-CRM114-Status: UNSURE (   5.40  )
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

On 7/12/26 5:39 PM, Shin'ichiro Kawasaki wrote:
> These are miscellaneous fixes. They do not affect test results, but worth
> fixing.

For the series:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


