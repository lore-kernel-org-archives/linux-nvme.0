Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C5CC3600C
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 01:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/OIJU9QPMxtFCYIcP7p8yixB8viOTUvvg7p+Re86knI=; b=aHi0ciemAk/BGZDJpXV/z3xzYP
	4xGlB7KUJEI8S7U6halBFyPYOTEwa6/0Oobh52R4bz9eByt1ezapVaELSj7zPk5VR7t107NvcGTbv
	BxGIHx2SkN0YBWZ89pzSJKGDbtOEQNK3T1BAjzMh37TEsuo5LIRyNLdsNY6G09+BlPWle1xfKh9YS
	LsuidYRYopf+89hvWn3lWjxhcmZs/0q6noGuX7oYb+qBXycad9gYNkz4cNSP7nKytQnV4foHUK51/
	e7d7KrF9FUGj5Xvgb6boSr9kGrlHX9krri5S1Vff3yaHdAualtsQHN8aLZpswBAJdP6VAwxGxQnLU
	m7B5Z+QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1bFx-0000000G7Z1-1bpw;
	Mon, 07 Apr 2025 01:26:33 +0000
Received: from out203-205-221-202.mail.qq.com ([203.205.221.202])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1bFn-0000000G7YG-3ydA
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 01:26:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1743989176; bh=/OIJU9QPMxtFCYIcP7p8yixB8viOTUvvg7p+Re86knI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bSbEpvWBjsan4ne8fJd5DMA95AJpAzdgmy0uxqI0msh1TerGIr7LAOkHRILvDtva6
	 ff9E+TyP+z/jXJQ1ASWTZEGUf1ZaUyqaPb3P6/vMA5kDainitMq4SfvhCJIkPBQyb4
	 zezh1aHL6NvKviMnDEbPgJaVK8Yrie4ysZrlP/lo=
Received: from [10.42.13.21] ([116.128.244.169])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 675B6ADF; Mon, 07 Apr 2025 09:25:53 +0800
X-QQ-mid: xmsmtpt1743989153tyv7wq22r
Message-ID: <tencent_6A42A1EE91831C3D5B94CECC5F8B12C3B107@qq.com>
X-QQ-XMAILINFO: NySneyYf/AjRBuw7u62X6Bzn4S6kIUfuTENl0LNV/au7n1wtpWG8htnPxbPS5n
	 wNd3KZZpjBZ+A6rYKfcH2bVsYgdfdGk6Fyf6p/8V1KNLEU74KbSF7l5MM1VmG9MDif1P4v6nkBqr
	 kTI4qwk5+hoqANiQ9Qf+pi7OiB2M78kZ3VW7fU4i4IVM5Wi7E3Rsh1BVYhsavZ0GGE7Us5iKsuDz
	 DqRA0As94KaeXyFPDQLMILY8C3rkg5Q9nIINpfydu+56kcPfWAsOC1rEvg20cAv9JP+BYJ3FWONb
	 DsUaAwN6oAJLC57heindqnTTLk2/1ro7XEQnxKPEir68ZR06yVV/YPpMYBxWWr317eRn5nxNX60q
	 d8C2EyweuqlfUF60Q50OzB/Ykm+SrMZ1RkLgifwViv7yx3EucM5KEhmUTvrNWk/ME+pGVRIPgt8B
	 iyeNOrX/tJmBcUvtn+R1WOSrvlFBBVQm8z9j5DObPEeLNArk9fs0xt98PyE0VzB2s7sJyhbjV0Uk
	 uAYvsq29XOq625JN1A27ExrbsU+sot3Pnad5q9s5pSE1sdz9Wxq4eBDnw54DtXApzOmgcEO2CHWj
	 uEtx00/zMHu+dt8tWTHjdaXmCbh3ctKRZ+gXA2BOD4FDXFkBn48CaMGyOvTX+dcSLyoDu9u/dpeC
	 KP92/KUfu2s1Bu5HcSH8gCFMrFrPT26ZQ7wYCpXBTm4jTZsm1ORoV9AT+6uJJJSwr4Pd/WXtcmoX
	 JdyC9xHuwyLCCJuPjiKcq1MpGsv+yA1MzfXkaG+8ldBRHdfY0yPeqMO3isG3GGGninLcZxddCzv2
	 e1lehheUJVGcOoHQF4WjN/LAqmiZdxHMtyUxFgjBPIhsFEvawLPahhvevTcf3GMfqIMV9UbFh0iv
	 VCXeX63ze92vwPeesrOU9goZIwjvGXKZS2sw2tq6fvbRZlrHdEEv1L7siV+EKoAPcztkHqkiIPWr
	 TnbP1sJC0=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-OQ-MSGID: <5f596d63-b11e-4728-a782-4551a0eead04@qq.com>
Date: Mon, 7 Apr 2025 09:25:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] nvme: Add sysfs interface for APST configuration
 management
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
 chaitanyak@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Yaxiong Tian <tianyaxiong@kylinos.cn>,
 alexey.bogoslavsky@wdc.com
References: <tencent_4612952C8C5109058CD8E688D81276A2FD0A@qq.com>
 <20250403042504.GB22360@lst.de>
 <tencent_D00C9DD2BF00258063B042172328396DB608@qq.com>
 <20250404082950.GA8928@lst.de>
Content-Language: en-US
From: Yaxiong Tian <iambestgod@qq.com>
In-Reply-To: <20250404082950.GA8928@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250406_182624_642906_EEE35E02 
X-CRM114-Status: UNSURE (   8.73  )
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



在 2025/4/4 16:29, Christoph Hellwig 写道:
> On Thu, Apr 03, 2025 at 03:05:37PM +0800, Yaxiong Tian wrote:
>> These two patches don't fundamentally change the APST configuration policy,
>> but rather enable users to configure various APST parameters in real-time
>> across different devices. As mentioned in commit <ebd8a93aa4f5> ("nvme:
>> extend and modify the APST configuration algorithm"):
> 
> And who are those users?  What tools do they use.  What settings do they
> set and why?
The three issues you mentioned were actually partially addressed in the 
previous email, or at least touched upon.

In any case, I agree with applying a universal setting for APST, as I 
don’t have a good tool to handle this either Now.


