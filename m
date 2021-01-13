Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771C7C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 16:58:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 272C823383
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 16:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272C823383
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+cHwiYhZZH5W2th0fDZprcfdaJEr7TpS7HFRGLxWReo=; b=Pz9i6/kRfzKpVrBDlH/w3hxSn
	oq/lFxrwdXk1lp06NlKOQf7cnTRye4t2adVLC11+3FYhgK9vD31E4S0dO0T+QNubRBGr5xfrFj8BT
	gRP5ne0y1emWy5dFE5PVNIhZDm/qZh16uv9Zu5jGAs6pEaOT7OEyjvOOb5MINh75Rf9sQ2y0fE8+l
	te53kTOzr+t06g0n6RNhIb3vxuzbtA807CEzcgBIhwDs3KPryYSFvJ0EslYZ/f+uHnnq9zmDB6x8Q
	HMVAsfjvVg+jy+mM6tUkSCMALzcB2gZfWvHqLUwPirYa0L407g5dzZ6tKOCGAOpMMQesZ3fdGT04z
	wC3xLPfxg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzjSq-00076S-U9; Wed, 13 Jan 2021 16:57:44 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzjSk-00074S-C8
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 16:57:42 +0000
IronPort-SDR: 8Vz/Ahiq4G550dUMPD/HUyjQP9jt6RuIIw9KCE01YsIJuZMmO2p3ofIb1HFM6nemP2HcJ6zKvm
 lC+3j7rdOa8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="157416076"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; d="scan'208";a="157416076"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2021 08:57:27 -0800
IronPort-SDR: 9i2id6aIq2+1pZF+ZibgXr8G/AN+G+qXWeyTuliZKXkjU7U4enJxo9u7ENb5ZK2xDJTods0pfF
 eC0pR509JAmA==
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; d="scan'208";a="353550590"
Received: from rrajashe-mobl1.amr.corp.intel.com (HELO [10.209.160.254])
 ([10.209.160.254])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2021 08:57:27 -0800
Subject: Re: [PATCH v2] nvme: Check the PRINFO bit and the Metadata size
 before deciding the host buffer length
To: Christoph Hellwig <hch@lst.de>
References: <20210112172941.3911-1-revanth.rajashekar@intel.com>
 <20210112183911.GB5050@lst.de>
From: "Rajashekar, Revanth" <revanth.rajashekar@intel.com>
Message-ID: <2fa121b7-dc22-6913-7876-ca71249e15bf@intel.com>
Date: Wed, 13 Jan 2021 09:57:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210112183911.GB5050@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_115738_578296_DBF9DCDE 
X-CRM114-Status: GOOD (  13.86  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>,
 Jonathan Derrick <jonathan.derrick@intel.com>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Christoph,
Thanks for reviewing.

On 1/12/2021 11:39 AM, Christoph Hellwig wrote:
>> @@ -1546,6 +1546,11 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
>>  	meta_len = (io.nblocks + 1) * ns->ms;
>>  	metadata = nvme_to_user_ptr(io.metadata);
>>
>> +	if (io.control & NVME_RW_PRINFO_PRACT && ns->ms == 8) {
>> +		meta_len = 0;
>> +		metadata = NULL;
>> +	}
>> +
> Wouldn't something like:
>
> 	if ((io.control & NVME_RW_PRINFO_PRACT) &&
> 	    ns->ms == sizeof(struct t10_pi_tuple)) {
> 		/*
> 		 * Protection information is stripped/inserted by the
> 		 * controller.
> 		 */
> 		if (nvme_to_user_ptr(io.metadata))
> 			return -EINVAL;
> 		meta_len = 0;
> 		metadata = NULL;
> 	} else {
> 	 	meta_len = (io.nblocks + 1) * ns->ms;
> 		metadata = nvme_to_user_ptr(io.metadata);
> 	}
>
> make a little more sense?
Yes! it definitely makes more sense.
Will send out a v3 for this patch.

Thanks!
Revanth

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
