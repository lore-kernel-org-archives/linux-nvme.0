Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7D2C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 18:28:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F19020767
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 18:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VRH2Hilr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F19020767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PJzZUFqx4bn3f7ZKOWRgxrhCUe/k8Ydu7WLDLobzG78=; b=VRH2HilrBRC6mEc3JrsV/DNHK
	sqE/bgULmgVXx8RoHHS+diqVSoG9CfMmIjfRz/F4SrmOhrQOhs+QzPQGBZ2dkFZmMaax8p9/ie2ai
	q+natRIhwzKx0dGDnBKjxgNPK+r+aV1FmkFgn6S+xCHMHnT6eIFCV5iQRqwMcCn6Yo3hg7cpsibKg
	5asEoJLTD8UicJ/KSirJJp6L4qRblUdON7ad/EjpV/DqCTeN+lAIjyp2ia4GMxpmCyN4qbVWJUBzp
	veveBmxrtMipg7ae8aZ9O9/x6S0JWQQikdIBIh2d3ATPlSbbPYyUnuhKA9fEQkGSNMUh+rttTiJ+C
	orUoJF2QA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joA8c-0004GA-QM; Wed, 24 Jun 2020 18:28:46 +0000
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joA8Z-0004FN-HU
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 18:28:44 +0000
Received: by mail-pg1-f193.google.com with SMTP id s10so1817585pgm.0
 for <linux-nvme@lists.infradead.org>; Wed, 24 Jun 2020 11:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SAQYeh+8UWj+mTP1/uBOaQWSCarRWB94vNxrgsP23hQ=;
 b=YuL1ew5wyqt0s503vXEWbbemb/B8vdgEW975TszkVQ3RGXIzkgG1gww1ruYjXINYUw
 mDhHx6AUGMt472SE6zFyH8MKKsoyzq/gyZCLRB/zq18EpzvI+JNVaSWookwZOHLl5aHc
 wv06ypGYNIELG3RwfIHFYkNQzzW9RgVW2JOfpkl9Ltvc5HdQrziIKLyPufz+8Rv90ey+
 fjPMVFc7xbVlsUP3ox9VMNdOLvi82cqI5sjChuWhcO8pcP9fwE/KsTnlGUSVmgnHOQBU
 HekDjsVJaQPqIWbi7fNwdiPJzRvFdmw0PvJvkNQdYlZ+LXBC2xYgYkM+JqozNS/uWxDb
 wsLg==
X-Gm-Message-State: AOAM533Rp8jbHn7Trnksg7oMWzWQEOKZMxVkGAs08k6mck+7fifdF2E8
 enk//zOtWbVFJYzkUUfbBVs=
X-Google-Smtp-Source: ABdhPJyRwXLD2BVKbOvZqH5DBuIEvcp7Q+LIcA8yakrftiWhFhhAkxk1Y3Kk6KGMP0WPN5S4yHrVAA==
X-Received: by 2002:a65:620f:: with SMTP id d15mr13851822pgv.270.1593023322241; 
 Wed, 24 Jun 2020 11:28:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c08:474f:e61d:6947?
 ([2601:647:4802:9070:4c08:474f:e61d:6947])
 by smtp.gmail.com with ESMTPSA id j16sm11442629pgb.33.2020.06.24.11.28.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 11:28:36 -0700 (PDT)
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set support
To: Keith Busch <kbusch@kernel.org>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-4-kbusch@kernel.org>
 <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
 <20200623112551.GB117742@localhost.localdomain>
 <20200623221012.GA1291643@dhcp-10-100-145-180.wdl.wdc.com>
 <b5b7f6bc-22d4-0601-1749-2a631fb7d055@grimberg.me>
 <20200624172509.GD1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <e59e402b-de74-e670-59d1-a6c51680a31d@grimberg.me>
 <20200624180323.GE1291930@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1ddbf614-f5a7-a265-b1a2-7c5ed0922f18@grimberg.me>
Date: Wed, 24 Jun 2020 11:28:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624180323.GE1291930@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Daniel Wagner <dwagner@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 "hch@lst.de" <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> And what if it is a DNR error? For example, the controller simply
>>> doesn't support this CNS value. While the controller should support it,
>>> we definitely don't need it for NVM command set namespaces.
>>
>> Maybe I mis-undersatnd the comment, but if you see a DNR error, it means
>> that the controller replied an error and its final, so then you can have
>> extra checks.
> 
> If the controller does not support the CNS value, it may return Invalid
> Field with DNR set. That error currently gets propogated back to
> nvme_init_ns_head(), which then abandons the namespace. Just as the code
> coments say, we had been historically been clearing such errors because
> we have other ways to identify the namespace, but now we're not clearing
> that error.

I don't understand what you are saying Keith.

My comment was for this block:
--
	if (!status && nvme_multi_css(ctrl) && !csi_seen) {
		dev_warn(ctrl->device, "Command set not reported for nsid:%d\n",
			 nsid);
		status = -EINVAL;
	}
--

I was saying that !status doesn't necessarily mean success, but it can
also mean that its an retry-able error status (due to transport or
controller). If we see a retry-able error we should still clear the
status so we don't abandon the namespace.

This for example would achieve that:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ba512c45b40f..46d8a8379aff 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1126,12 +1126,21 @@ static int nvme_identify_ns_descs(struct 
nvme_ctrl *ctrl, unsigned nsid,
         if (status) {
                 dev_warn(ctrl->device,
                         "Identify Descriptors failed (%d)\n", status);
-                /*
-                 * Don't treat an error as fatal, as we potentially already
-                 * have a NGUID or EUI-64.
-                 */
-               if (status > 0 && !(status & NVME_SC_DNR))
-                       status = 0;
+
+               if (status > 0 && !(status & NVME_SC_DNR)) {
+                       if (nvme_multi_css(ctrl) && !csi_seen) {
+                               dev_warn(ctrl->device,
+                                       "Command set not reported for 
nsid:%d\n",
+                                       nsid);
+                               status = -EINVAL;
+                       } else {
+                               /*
+                                * Don't treat an error as fatal, as we
+                                * potentially already have a NGUID or 
EUI-64.
+                                */
+                               status = 0;
+                       }
+               }
                 goto free_data;
         }
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
