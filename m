Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B015C5475B
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 09:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4jhZdt64EcdO9zb3C4yz+FuK2XZDywhM4dPfbsaAXGY=; b=oZ9c7Osx4PZcBH3gzoHELdprvH
	VLkf2lO0UECvAVrhl9SZkEjHGMpO7aa7bm3VTvUHY1Mi3vqewfpNExFrHOFDIOdTFFZJGsltiRBmb
	6mCxQWQXU6Z6b8ZsX0pblPJ2vSXM3NTMTrPwD3i5GkGfuxcMw0HRUsfLysM78QcsXz+3jpVX5dhY1
	Nl5ykWgDgBliq2cxNxuwMvkRjPGMtcQNVTJ5NTmTU3VyrQM8MFJtRfA+7oLuYlcIGw4+8TeetZkJc
	Y7ucpx/32LL4WXCkcGHUccazGO42JvTf/+ic0zosOuvDdhRwdOG3BqHF3HST8MNrSUHzkaT5mv+3z
	+68sLLXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riWKL-00000008WeR-1DQO;
	Fri, 08 Mar 2024 09:15:41 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riWKH-00000008Wbk-0SPt
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 09:15:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709889330; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4jhZdt64EcdO9zb3C4yz+FuK2XZDywhM4dPfbsaAXGY=;
	b=TzDC1njLazuolfI24l2ners3hpmMjKvVGIr0Rt1sDrvdJqRP2VfQ44L7Bow5yvUuNFKjTgvrzXiljVXQGqJngVVw7TkOm0on5sycTtfVNTlSN1PCMeplwSbg/B0+r8IcSQemC2Cw9MASpOH1FE7hWPc2/nAK/DUfAlT9+fiCLVQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W22F8ND_1709889326;
Received: from 30.178.90.168(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W22F8ND_1709889326)
          by smtp.aliyun-inc.com;
          Fri, 08 Mar 2024 17:15:27 +0800
Message-ID: <0c33b803-baff-45af-90bb-623822f756b8@linux.alibaba.com>
Date: Fri, 8 Mar 2024 17:15:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] nvmet: support reservation feature
Content-Language: en-GB
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, kch@nvidia.com, linux-nvme@lists.infradead.org
References: <20240201023207.112007-1-kanie@linux.alibaba.com>
 <20240201023207.112007-2-kanie@linux.alibaba.com>
 <ee516418-d072-4506-acba-d02f22cc4476@grimberg.me>
 <0c74a2c2-c9d9-4b0c-9deb-bdc3caf72005@linux.alibaba.com>
 <Zd6msstIWsNQMPfK@kbusch-mbp>
 <727aabbc-1464-48d6-9915-a1c22343c2b2@linux.alibaba.com>
 <6e34a652-da40-46f2-8a43-b45b08682e41@grimberg.me>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <6e34a652-da40-46f2-8a43-b45b08682e41@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_011537_692288_69FED731 
X-CRM114-Status: GOOD (  12.86  )
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


> unlike abort, preempt-and-abort needs a semantic guarantee because the 
> consumer
> may rely on this for fencing purposes. So it cannot be supported in 
> "best effort" I think.
>
> A possible implementation would be not to abort as there is no such 
> interface, but
> nvmet may wait for all pending ns IO to complete and disallowing new 
> IO to come in
> (using percpu_ref_kill and percpu_ref_resurrect on ns->ref). This 
> won't work very efficiently
> withALL_REGS reservations though.

Hi Sagi,

I found that if we return an error when the call to 
percpu_ref_tryget_live(&ns->ref) fails,

it might cause hosts that still have permissions to interrupt their IO. 
Additionally,

preempt_and_abort itself holds an ns->ref, we cannot wait the ref to 
become to zero.

The solution I can think of is to add a "per-namespace" percpu_ref to 
the controller for

counting IO issued to a particular namespace by that controller. Then, 
during the execution

of preempt_and_abort, we wait for the count of those preempted and 
unregistered controllers

to drop to zero.

The nsid is user-specified, so we can not use array to store the 
per-namespace percpu_ref,

this will increase lookup overhead if we use xarray.

What do you think Sagi? Or may be we can declare that preempt_and_abort 
is not supported, just

like SPDK does.

Best Regards,

Guixin Liu


