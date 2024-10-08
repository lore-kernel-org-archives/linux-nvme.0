Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81203CEF14D
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 10:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lz3eknZqwmeibseg1a2QiGlIWkTzRQ82hsCslpxgkGE=; b=oKY+SQx29X/Z28tPsfVawrPCu5
	OeOO7f8/MbqIoGfIjAIWVp0E18tUwlte75yuBZEiIu+aRYyuXo5LmroJSYT0riX1kqe3ePuJueo4+
	bRe2VAgEFOJaFwSHiyJcdMv00JOp2sZmMXnoFOWBpB9acsNt4rBpRPDdhXzwC2fL3+mmYsCVEh8LQ
	II1AjTFpPbPmPp16LdM3fE/zhNGRRksbEcT/puao0ysI3L9ZgtEHPZfC8X3S9NNDWt7RWjObnq7gJ
	x0t8AdUUmj0CfBuaQbsyHjJgx34E1FMXwetexU/tObrVkN/07ulKeo5QvBB1rzSvST7cMyaW8Ji7w
	yiJWybCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy7cA-00000005Tr2-3tI3;
	Tue, 08 Oct 2024 10:38:50 +0000
Received: from mta-03.yadro.com ([89.207.88.253])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy7az-00000005Tl8-1mQq
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 10:37:39 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com EE069E000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1728383851; bh=lz3eknZqwmeibseg1a2QiGlIWkTzRQ82hsCslpxgkGE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=tXbUrEcwhI2tHYaGDN5jsgkAnBEnTqHvLyA1cRV34XhEKOURk3vwQR/toMJapmaCv
	 u6fmtsUAPBI2vmvstozTlWANpTX6REMpU7uW7YrLXif6YZHHjCJ5WbOagqjblIL6et
	 Tg+EZpIq0gtUUtLQmZRiQIZlxOjRtKiwVDB5HoJBeXrCAO5F6GL+maHGCqLZZ/+boo
	 nH22apvwxKMlve6ZKjGjXolSWjJSggyh5KDpb1gHclkZwmcQfONvWdovbEQ7w1WkUp
	 K1XBXGpJZglV0oW0ZSO6ZxnG226RR9izUv9yYmoWS0anWN4xSwLwlpKa3C8y62itYw
	 CWSCp7iw5dPGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1728383851; bh=lz3eknZqwmeibseg1a2QiGlIWkTzRQ82hsCslpxgkGE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=lSKMrnWclnbrR0fXdtdfqW7uOUTbp+D5WcZQw7+xLQoOJ6sMFyKDiWK8g3jPE4fkk
	 Vy4MaWVLXR268EypVYmkythZNggWLN+SWiLiasFU2HmGPX6NRdRhNxoNX3GQ9yuO4f
	 iM+U2FFre3fKySAKPcw0k+JdFS1wMHD0cc5GbpquUXXYtGIOsRKMgMxn+l0zAC6otg
	 nOo/t7K58Xe+JywXcNdsdt2kJ0NxZkwXPn/wJyTY34gTQXp6Ti8PzSmkr3iDOmHEqe
	 id2IgyF3eJv1P9Upb/04/2QohaLzVQObWZpHb2eGzu3kCVV+l6Ygtpv8GPdIhvI9wD
	 /JffUBUzMWC7Q==
Date: Tue, 8 Oct 2024 13:37:25 +0300
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v13 2/2] nvmet: support reservation feature
Message-ID: <20241008103725.GL22571@yadro.com>
References: <20241008102114.26199-1-kanie@linux.alibaba.com>
 <20241008102114.26199-3-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241008102114.26199-3-kanie@linux.alibaba.com>
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_033738_155039_E06D06C4 
X-CRM114-Status: GOOD (  11.24  )
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

On Tue, Oct 08, 2024 at 06:21:14PM +0800, Guixin Liu wrote:
> This patch implements the reservation feature, includes:
> 1. reservation register(register, unregister and replace).
> 2. reservation acquire(acquire, preempt, preempt and abort).
> 3. reservation release(release and clear).
> 4. reservation report.
> 5. set feature and get feature of reservation notify mask.
> 6. get log page of reservation event.
> 
> Not supported:
> 1. persistent reservation through power loss.
> 
> Test:
> Use nvme-cli and fio to test all implemented sub features:
> 1. use nvme resv-register to register host a registrant or
> unregister or replace a new key.
> 2. use nvme resv-acquire to set host to the holder, and use fio
> to send read and write io in all reservation type. And also test
> preempt and "preempt and abort".
> 3. use nvme resv-report to show all registrants and reservation
> status.
> 4. use nvme resv-release to release all registrants.
> 5. use nvme get-log to get events generated by the preceding
> operations.
> 
> In addition, make reservation configurable, one can set ns to
> support reservation before enable ns. The default of resv_enable
> is false.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Thanks!

Reviewed-by: Dmitry Bogdanov <d.bogdanov@yadro.com>

