Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27ECC4706C
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jan 2024 08:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hDt9Uq34pgtSkBBfKXCdKZgutvopaAIQAS68L4fUP+g=; b=qqzAGkkmjfOmNMIc9WTVnV+c5k
	7+wJmvghfnlj94MTA2ADwGfASnDmt3h5bPQOG6C5MYVF34NmbsFARwg6MkBZAL2X179P7/VJY0Sgs
	qvSYBnds7wwFm33ZAiNbIpZeCuEM9Jd7bCOFy4drIdjb3a6NZqn2mP5lMl8vuPMM32wy4uYp247be
	aQ14PZSJtBvNIJ0ovigfSmCTfpM8RtX0pgdLE4W2EAA8VosOyGe2XPjFd3+P0dA89XEwhvXG2arHc
	/0xhTCtasVtyFH/I+qLLTwbjJ31RWwW1nAF9JiJdH4r14jPwSzsaXDJkJoOcnkwc+aqTM2M0JLYjH
	r0hKEbnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPewg-00BRV3-23;
	Tue, 16 Jan 2024 08:37:18 +0000
Received: from sendmail.purelymail.com ([34.202.193.197])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPewe-00BRS9-05
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jan 2024 08:37:17 +0000
DKIM-Signature: a=rsa-sha256; b=PD2b7TJtXnGp05hWE8MqUJ4PY4DMgibIV3k+7DhVaIP5mQ1GON/qs8CMEmFiVmYtJjPOrgMYX4mZ1Sfz5Ygz6XnzDRUmOMUnf3vmtjRe1tVtO57wHxoCzfa5tZyH+1x3nLoqGYPhRLusg3s4/ypkj1t67mkgjWxtwsm0VX9jMRVhFQZISWUarEbL781NCtK2HpOKH1bKRduLG29CJJqCu97C4u7Vku8Kgr5vMOLFGy2GB3wZw0j8GnSs30wi/1MEdvHYqC1AEatp9b1YLJ4FkWGA+JiOHz/afPKGI0rVeeilSZYaFJAvk1wbLGAIvsziLRa+KMtZvuzmIZ3Ppt+tcQ==; s=purelymail1; d=saulv.es; v=1; bh=hDt9Uq34pgtSkBBfKXCdKZgutvopaAIQAS68L4fUP+g=; h=Received:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=hayu7PYp3iU2dRFdlD+dOZfPmSSh8ByuKV4Rm0ipatgUFfANAChbdlWtz6WYyIAqZqwv1Ml5TZbiREpeQT5Z+L7FyTfw1aY1awphybjr3cQYVe9pcWActQIGt3WPfRwC9RfOgcUKMlX1zQh+Qv5BRk7fO3mq0jDPPnZySLxsEYXG4xdN7qens6Qf+6WUabqdNowu6zJefn6oYrbODhfZSE+8DeSU7vkrZuO6/OwKYiRTEPH/n1feENkqCYhLBX7e1Kozmdp8BNRiipFb/ePR4FvAJ5JwY5V5ZrnetM9ejYdTuzP5bzfYJwPBKWch+IsF0rAhGGNlIT2EZmmCto8Wvg==; s=purelymail1; d=purelymail.com; v=1; bh=hDt9Uq34pgtSkBBfKXCdKZgutvopaAIQAS68L4fUP+g=; h=Feedback-ID:Received:From:To:Subject;
Feedback-ID: 13394:2854:null:purelymail
X-Pm-Original-To: linux-nvme@lists.infradead.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 369274966;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 16 Jan 2024 08:36:50 +0000 (UTC)
Date: Tue, 16 Jan 2024 09:37:04 +0100
From: =?utf-8?B?U2HDumw=?= Valdelvira <saul@saulv.es>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Add quirk to fix hang issue on SanDisk SSD
Message-ID: <3kwqc6dgg2wm25pmadb3szrevd4rpoimhcytmlxeloa24p44hc@tsx3yjxqq32k>
References: <20240113213012.30898-1-saul@saulv.es>
 <f2822df1-22db-426c-86cd-a7509e624e06@grimberg.me>
 <lnfpduryv5nwibiejqxnvohr4pcismnkyzkowqvit3gkpdgt3d@ojcvlonaolzu>
 <df8864fe-655a-4890-a19c-7fb69513aeb5@grimberg.me>
 <qy2em323bnjfuy5if2yyxw5qrzurplltlzqgpg6xpbnh4hfy4f@olq7qyaudjcr>
 <493dfa7c-a0f3-4207-90a8-b22fb17edf20@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <493dfa7c-a0f3-4207-90a8-b22fb17edf20@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240116_003716_330298_D81EA4FC 
X-CRM114-Status: GOOD (  11.44  )
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

On Tue, Jan 16, 2024 at 10:09:47AM +0200, Sagi Grimberg wrote:
>
> Seems so, but it doesn't makes sense to me why it doesn't work.
>
> Do you have force_apst enabled?
I think I don't. At least I haven't manually set it.

> What is the ctrl npss value?
npss: 4
Got the value with "nvme id-ctrl /dev/nvme0n1"

