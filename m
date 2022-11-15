Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35310C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 08:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:Cc:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RkoU26U/dZPVHfi9eE3QrlrFJ6aPM7eFT8qTAFT7OUc=; b=D414jCNt3vth5GKPJKz1tzq7qM
	eBrbUcf+RTEEWYO3VHQCu1ks04VEALihJLel7+lZVMsPihADeXe2WEawdzwrWACy8nx/9rvKX4k0O
	8dhWsgKmi7ewXFRglM03C0mIAhcekvjeG06Nf68l5ov/1N/elDQ070BHw6qnbg+SN3G8w0jEOVbCi
	qljWxge7nu4Ic0+fdGWzPfF/qzzWmYyg6jNbx6+4roUxk2zpoTlGF5dXibmi0VF0585OF+PXmAs3C
	yiXe1S092oBqAXXjiqFevlAjuc6vCE+wuuAr/trx2FrPUpbh7uxTL1Qeh6RzIQFhiiGxlA/V/Mou0
	g8jt+UNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ourdJ-0092dB-0Q; Tue, 15 Nov 2022 08:49:29 +0000
Received: from out2.migadu.com ([2001:41d0:2:aacc::])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ourdF-0092aB-H5
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 08:49:27 +0000
Message-ID: <bcf1c16d-e822-8fbd-50b3-7224465589d0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1668502161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RkoU26U/dZPVHfi9eE3QrlrFJ6aPM7eFT8qTAFT7OUc=;
	b=avNwFKDhL/J+Yh4INzOEN0CQTsD/mZ7FeN14q/CpHF/7hTDSQG4tpam8jEwk1HxtSc5ELC
	i8vffCns/AXFO6EJMFIYFxhn4/amKfeoMyaxARM4rECItYGn1o69KR92TnZFCSkXSdFI2w
	bqdJSjASWRda9hlp/pi4uXiIzhOcgXc=
Date: Tue, 15 Nov 2022 01:49:15 -0700
MIME-Version: 1.0
Subject: Re: [PATCH] tests/nvme: Add admin-passthru+reset race test
Content-Language: en-US
To: linux-nvme@lists.infradead.org
References: <20221114203412.383-1-jonathan.derrick@linux.dev>
 <bb0cec9a-693e-8fd9-b521-8c23a7ff2ce5@nvidia.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <bb0cec9a-693e-8fd9-b521-8c23a7ff2ce5@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_004925_795576_81B622F0 
X-CRM114-Status: GOOD (  11.17  )
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



On 11/14/2022 5:25 PM, Chaitanya Kulkarni wrote:
> On 11/14/22 12:34, Jonathan Derrick wrote:
>> Adds a test which runs many formats and reset_controllers in parallel.
>> The intent is to expose timing holes in the controller state machine
>> which will lead to hung task timing and the controller becoming
>> unavailable.
>>
>> Reported by https://bugzilla.kernel.org/show_bug.cgi?id=216354
>>
>> Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>
>> ---
> 
> Thanks a lot for submitting this, it is really useful...
> 
> Overall it looks good.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> 
> -ck
> 

Thanks
I have v2 coming with a bit more robustness, so let's not merge this one just yet

