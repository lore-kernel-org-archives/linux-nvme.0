Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02740C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Oct 2022 22:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DBqT85mgl04WYMAAg/V/+c1M56joYmfUFuIPgt3KBZU=; b=AlCFU5vPrQA8jsS3WgJ7OJXaDl
	kyX86TXQalRJDM7Q3FUvsXGVk1qiBMXQVFHtOn97q4pMyw9/xCsCjNi9klT/9VOQOkuTfUz7EPFk8
	oWFQGO0ZR5kGSs4wX0b3aObzztOIDl+7OYQfCviKA1hT/FVNqzaPTvAOQkA82Q0Zls28L5h2regax
	3+J5jhkvUZ0Dq1xih0aBnzmuS3vIazf3l1IgfSdHlBlhmbO4A/rHrHr9BqwIX2ttC3TZMzZqnYpuj
	WfuRltVcs4p8KTruIzzBlCHCP9il/o5ua45FOnZyP4VABKbgK3I1yl0TdobfN5XPn09e6LimrE6bo
	UrPMbYkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofqVG-00BMZa-76; Tue, 04 Oct 2022 22:35:06 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofqVC-00BMYq-Cf
	for linux-nvme@lists.infradead.org; Tue, 04 Oct 2022 22:35:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664922902; x=1696458902;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G0Cz013hrBxnry1hziTrqbqgGA4zQdvcqYvl1r/wTKk=;
  b=kCX50gr3lGOBpSzNADZug+intWczvVVFlhrPG+4FpJiQ8QzwV3IxsaxS
   awpC4ld356m0sopPhMRyScmxqu335s+xKN2c6gobRXi5Ye9LN8DQ3x/Mv
   0uprCX/juSeFvQE9HzfZTb4gIMz1o4b27EtJ0uoQAhjzsdyFIl4J4btdU
   BC9Xq5952XD93G7DkeeFKVUqMezMw4OCBQOxP/WUuV9zK50CPaXk8QaWk
   oKClf3iSgm3yIwsONab2E36LNVDQaa4Mdmm14JtPDN7fceIVUwEQwvxV1
   /IRp6+c1LR0R+YI+4CxPoRfufVxgnpDfhUCCjXOjhPXJvw4Cpdl0rZx19
   A==;
X-IronPort-AV: E=Sophos;i="5.95,158,1661788800"; 
   d="scan'208";a="218172274"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2022 06:34:58 +0800
IronPort-SDR: SnioU81e5WQRKvyHeyoCRK6PunoS6O9bWOtaPnf+2ussh9FjuIMKizmwsMnaepAOTSi0he38vG
 VsduTvmVihu1M5hk0YANIFuvfk8noe0tVT55XrTepe/8x8wL/mbP2qz06rgDevSf819HTZAeUE
 BTmOWzECCyeDyK8ZR1Vj3qT9+lRpgc/ThRjGQd0NC8DB9TuGKqOaM2RzsOdMKIINIMvOBVuNq/
 0R/t4/pwSGLuA9FShIuv+RJZ/B8rIv0+S5ELpOXHIeFd2itw99m1cMEvtXksXj78qMcWaKmYoI
 GZOeSQIMpUeF5EaQsT2SvNbf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 14:49:12 -0700
IronPort-SDR: k3XOGyiIktmXt1A7fli32WSwDZ2TDTdXgycySvaiwwgWhFOcKgzDltofAjwdWOJeC0zIROhQ4+
 lUxN7Z/c61I9UebW07xUlfWjqML7/UhdQVlgNIKtssRFM2oHqbbvALk0FBYYCHU/RA1XShxw3o
 La4pEurWy3MgP4vsWVqHfVBIJ6MnBvtvBEUqTChGrIea09V89/vmbOYeOuVAGGmb5366EMN8PH
 O4xRaZABBI2/GwmZb6fDzqxh6Qkh/9JXr5DZdr7g/us/HYnBquqXIhG3Y+z/1Gjr6n7SiJboMu
 Lm0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 15:34:58 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mhsw22Shxz1Rwrq
	for <linux-nvme@lists.infradead.org>; Tue,  4 Oct 2022 15:34:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:content-language:references:to
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1664922897; x=1667514898; bh=G0Cz013hrBxnry1hziTrqbqgGA4zQdvcqYv
	l1r/wTKk=; b=CNMOBY4wN7t1et/jHuKKGopfWerwof3RTute05VtJ4XJTDyqA7R
	xXxuRaQ57E78lXrW+KL7r4B1LfxKj99FP32hXFh/dzoAfobLgUZTDT0IVGPeXOMF
	hx3wHV4Okwpm1T78sXNAwXFhiuXaxuTH6VUXy1V263zlmv3hbFLk7jCzAFAqY6sa
	Nu8RObJcv3KkTuQ1fotwrpVC7ir2UhV0KHN+uYIsqVPLGgO223+8QI1DJ6PyQY1K
	1ijT79KgoaH9OCWnThCpc4YUwq8PX05CTMCpaF3MEo49qYcScpCRITwb4FDb7g+D
	zd6M2wkNXt8zXtdPXO4ImFwuGPQrRBGYxJg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pB6lI17mGGyU for <linux-nvme@lists.infradead.org>;
	Tue,  4 Oct 2022 15:34:57 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mhsw02ysnz1RvLy;
	Tue,  4 Oct 2022 15:34:56 -0700 (PDT)
Message-ID: <d9d9ae2f-dea1-4672-8458-c2542c1f951f@opensource.wdc.com>
Date: Wed, 5 Oct 2022 07:34:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: lockdep WARNING at blktests block/011
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Keith Busch <kbusch@kernel.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Tejun Heo <tj@kernel.org>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <20220930001943.zdbvolc3gkekfmcv@shindev>
 <313d914e-6258-50db-4317-0ffb6f936553@I-love.SAKURA.ne.jp>
 <20221003133240.bq2vynauksivj55x@shindev>
 <Yzr/pBvvq0NCzGwV@kbusch-mbp.dhcp.thefacebook.com>
 <20221004104456.ik42oxynyujsu5vb@shindev>
Content-Language: en-US
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221004104456.ik42oxynyujsu5vb@shindev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221004_153502_537971_ACDCF302 
X-CRM114-Status: GOOD (  30.37  )
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

On 10/4/22 19:44, Shinichiro Kawasaki wrote:
> On Oct 03, 2022 / 09:28, Keith Busch wrote:
>> On Mon, Oct 03, 2022 at 01:32:41PM +0000, Shinichiro Kawasaki wrote:
>>>
>>> BTW, I came up to another question during code read. I found nvme_reset_work()
>>> calls nvme_dev_disable() before nvme_sync_queues(). So, I think the NVME
>>> controller is already disabled when the reset work calls nvme_sync_queues().
>>
>> Right, everything previously outstanding has been reclaimed, and the queues are
>> quiesced at this point. There's nothing for timeout work to wait for, and the
>> sync is just ensuring every timeout work has returned.
> 
> Thank you Keith, good to know that we do not need to worry about the deadlock
> scenario with nvme_reset_work() :)  I also checked nvme_reset_prepare() and
> nvme_suspend(). They also call nvme_dev_disable() or nvme_start/wait_freeze()
> before nvme_sync_queues(). So I think the queues are quiesced in these context
> also, and do not worry them either.
> 
>>
>> It looks like a timeout is required in order to hit this reported deadlock, but
>> the driver ensures there's nothing to timeout prior to syncing the queues. I
>> don't think lockdep could reasonably know that, though.
> 
> I see... From blktests point of view, I would like to suppress the lockdep splat
> which triggers the block/011 failure. I created a quick patch using
> lockdep_off() and lockdep_on() which skips lockdep check for the read lock in
> nvme_sync_io_queues() [1] and confirmed it avoids the lockdep splat. I think
> this lockdep check relax is fine because nvme_sync_io_queues() callers do call
> nvme_dev_disable(), nvme_start/wait_freeze() or nvme_stop_queues(). The queues
> are quiesced at nvme_sync_io_queues() and the deadlock scenario does not happen.
> 
> Any comment on this patch will be appreciated. If this action approach is ok,
> I'll post as a formal patch for review.
> 
> [1]
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 66446f1e06c..9d091327a88 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5121,10 +5121,14 @@ void nvme_sync_io_queues(struct nvme_ctrl *ctrl)
>  {
>         struct nvme_ns *ns;
> 

I think there should be a comment here explaining why your turn off lockdep.

> +       lockdep_off();
>         down_read(&ctrl->namespaces_rwsem);
> +       lockdep_on();
>         list_for_each_entry(ns, &ctrl->namespaces, list)
>                 blk_sync_queue(ns->queue);
> +       lockdep_off();
>         up_read(&ctrl->namespaces_rwsem);
> +       lockdep_on();
>  }
>  EXPORT_SYMBOL_GPL(nvme_sync_io_queues);
> 

-- 
Damien Le Moal
Western Digital Research


