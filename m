Return-Path: <SRS0=o8uW=2S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30A0C2D0C6
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Dec 2019 09:01:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763D62168B
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Dec 2019 09:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H6Nrd9c3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763D62168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rKGxfcbE7ccwiZWqQh4Z5VKSDKiN9AiQYLKvQwElukQ=; b=H6Nrd9c3grMIMR9bRG0ms/81C
	FI8+AabW8fWCNqi01Fp5kyQR6cAsktpQRo1tNOB6DS1Fgrs7O4xILaIKU6zo7IbfnVCCJFTbBm+/Y
	fd7jk2oQIJdYbTn3MOpSKEYeSwU5FznKk4tI4Dcnw1Jn0ZkJTcUoEnwjBYHMw3LeV0QfA49eg8LtG
	4F27Bacwl/6UX0LUvnEOV9v/qk7RfM0dNOtTV1iHm1uzxme1aKeZcLO751B2zjHb6nc9+TgzMq33B
	Qa7jZdcW+VaMU7XLOpAn79NVb5yAG/17uYl+cRnouT1ug4PDpoP3NSbX2PnNH7357k+aHUMLdffuY
	ec/o+aVCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1il7yB-0000iN-8a; Sat, 28 Dec 2019 09:01:11 +0000
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1il7y7-0000hy-VX
 for linux-nvme@lists.infradead.org; Sat, 28 Dec 2019 09:01:09 +0000
Received: by mail-pg1-f194.google.com with SMTP id k197so15581271pga.10
 for <linux-nvme@lists.infradead.org>; Sat, 28 Dec 2019 01:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T7SUnFsu26oBjgi0Uq9LdmW+utyfzikFXEs5oNkxYNQ=;
 b=lTyqpQarzr9wdmd7GunJ9j3M2HPYy+PfwyxYfvaUbZ0Uu6xbDAI7VHhJg6kUC98f3t
 Q42l4Ldo4PrZiehtpAe0lk2PYLfYWLna2oXIXZFzdAJNmHjIhRYVm/2Tl+ER4sxWWiT6
 d01zi9uXhLppRe9d4JuHmuhEcAP81VuHtaz8tmLdWyc2/a9SFlnboFO7mJwawkO1A3VJ
 7J0ZYG7Bqm+V3qPVewbG5hdBREFIybukb4AHA9ou0s6ICniSLJXusyxzPf5zT/k5UI2p
 I4ftKlzP6y0LYQ0jf4lGs5PgtUMWLbA30WPFI7PeS+RZDD9dPIQwvdC4iUlJtvSGF7Es
 1vEg==
X-Gm-Message-State: APjAAAVt5+dLQS1XzW8/5JNRyidDHzu42B3dYfwJsby93+M/l+T71R5J
 42ZAN25LKmbXtpaGhegebDM=
X-Google-Smtp-Source: APXvYqwOQXlt3QlYG1k3FLNnik24EeY7QA4AAbzsL0o1LGA2xF3W0UwmsRVnUgvfqfVakcRT5z3IXw==
X-Received: by 2002:a63:b642:: with SMTP id v2mr58166204pgt.126.1577523666204; 
 Sat, 28 Dec 2019 01:01:06 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:6a:a5ee:acc3:ebdb?
 ([2601:647:4802:9070:6a:a5ee:acc3:ebdb])
 by smtp.gmail.com with ESMTPSA id s11sm32741311pfd.157.2019.12.28.01.01.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 28 Dec 2019 01:01:05 -0800 (PST)
Subject: Re: nvme blk_update_request IO error observed on formatting device
 with kernels 5.5-rc1 and above.
To: Eduard Hasenleithner <eduard@hasenleithner.at>,
 Dakshaja Uppalapati <dakshaja@chelsio.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>
References: <CH2PR12MB40053A64681EFA3E6F63FDFBDD2A0@CH2PR12MB4005.namprd12.prod.outlook.com>
 <0b33acdb-2b8c-2a06-3c6d-b978f9a760ad@hasenleithner.at>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <00d16b98-fcd1-2439-b50f-ccc992bbf871@grimberg.me>
Date: Sat, 28 Dec 2019 01:01:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0b33acdb-2b8c-2a06-3c6d-b978f9a760ad@hasenleithner.at>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191228_010108_012657_EBA60F11 
X-CRM114-Status: GOOD (  17.37  )
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
Cc: Potnuri Bharat Teja <bharat@chelsio.com>,
 Nirranjan Kirubaharan <nirranjan@chelsio.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> I am trying to setup and run NVMF with tot linux kernel installed(5.5.0-rc3) on
>> both target and host. Attached is the target configuration using ramdisk device.
> 
>> The following error is seen in dmesg:
>> [  219.507989] blk_update_request: I/O error, dev nvme0c0n1, sector 0 op 0x3:(DISCARD) flags 0x4000800 phys_seg 1 prio class 0
> 
>> Please let me know if any info is needed further.
> 
> How big is the ramdisk?
> Are there further error messages in the kernel log?
> My current speculation is that it might fail in blk_cloned_rq_check_limits,
> but then there should be an additional error message,
>   e.g. "blk_cloned_rq_check_limits: over max size limit".

Its probably the target not expecting that dsm ranges payload doesn't
match the command sgl desc...

Does this untested patch help?
--
iff --git a/drivers/nvme/target/io-cmd-bdev.c 
b/drivers/nvme/target/io-cmd-bdev.c
index b6fca0e421ef..945dffc82503 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -280,8 +280,11 @@ static void nvmet_bdev_execute_discard(struct 
nvmet_req *req)

  static void nvmet_bdev_execute_dsm(struct nvmet_req *req)
  {
-       if (!nvmet_check_data_len(req, nvmet_dsm_len(req)))
+       if (unlikely(nvmet_dsm_len(req) > req->transfer_len)) {
+               req->error_loc = offsetof(struct nvme_common_command, dptr);
+               nvmet_req_complete(req, NVME_SC_SGL_INVALID_DATA | 
NVME_SC_DNR);
                 return;
+       }
--

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
