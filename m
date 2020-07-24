Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81733C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 01:03:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4630D20714
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 01:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KVdoWgzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4630D20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QljJy9NTP2QBxdlaPoj9gBAlsPbqN826306rpBJ67AU=; b=KVdoWgzdtEp6A6bLM6MwfXlnG
	NXfUDQA2OYkGVYzIFreNebkjyuFhOd7OzMz84n/N2nzX/9VvuEXScrwil23Qy95BHEwrXb3q1ZNmT
	4jnpVPNxle6n/bxS9E2NjazqOQTAfRh3KYmgVKI1txxWUKrxpLwAzRrhUPumcym9X7GLlb0FhgCik
	oxnQ40P2rjA4noX4N/0XqG7hnABGetnpmEBW376GuxtGwsTH9gItHxq2cVPG6JqODlE4YsyVeEG2a
	iME8n9XDJvi9MvC/+r+bKFabaOJnZYgrk+hsGm41BQciZY0gFvqcC0xmlEHxx5hXYatoB4u+tmbYm
	9ZmNzzvJQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jym7m-00073g-WD; Fri, 24 Jul 2020 01:03:47 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jym7i-00073H-VH
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 01:03:44 +0000
Received: by mail-wr1-f67.google.com with SMTP id f2so6798069wrp.7
 for <linux-nvme@lists.infradead.org>; Thu, 23 Jul 2020 18:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K+nKoomIiW7jRArOurTuoIZ+xOdx9M8hXcrK4deAZ4M=;
 b=nQQwweIOL4AsXz3CWOhyrU1TzrHYLthQ6R6gsq50qRRpjf3ElJgsGd+RwLtOnGRVDZ
 YmJMhurrePBTGPgiPzVkjBfXyHBHZVfLbD748tngeKBLdA0HBkFFb4Dhd1ooFPmgfYJB
 RBTrMu7rxIYXrHqL1wxOTIMOhBsVQI/Rk6Uw3qdnR45dvefDw93327iuV1QGZnznP4by
 QMK//zHHAc24zKDnDn0KWmR04NaU2r45MeeNUSjBjXjOKG285kL5e1L3vZEd8vXCMy/t
 UO47ne10zJLDE/C+xL9l4agKd5r/s2u+H/VMB3KjnvN1TnVjC8yTOLdOJzFVGBOaSH46
 DDKg==
X-Gm-Message-State: AOAM533aFQ6wijYqdGXOR5DBfTplTEFajLRPxKx4Zkw+2uYQ8xbHH3RF
 bbD65DJvRAmyikgMehiolrA=
X-Google-Smtp-Source: ABdhPJwfIpoKTTZ85VX2pu8GgeCzmSUzOlnsnXWhvjDxEFj09vH6S1Yp+45hSaAaPD5iScsLjcZlNw==
X-Received: by 2002:adf:f711:: with SMTP id r17mr6297387wrp.409.1595552621464; 
 Thu, 23 Jul 2020 18:03:41 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:a07e:34d2:a5fa:d770?
 ([2601:647:4802:9070:a07e:34d2:a5fa:d770])
 by smtp.gmail.com with ESMTPSA id u1sm7067221wrb.78.2020.07.23.18.03.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2020 18:03:40 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] nvme-core: fix deadlock in disconnect during
 scan_work and/or ana_work
From: Sagi Grimberg <sagi@grimberg.me>
To: Logan Gunthorpe <logang@deltatee.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200722233219.117326-1-sagi@grimberg.me>
 <20200722233219.117326-3-sagi@grimberg.me>
 <770b71ff-b3d9-886d-3455-cfae217c45c8@deltatee.com>
 <4da6f061-ee5b-d40a-7e81-6f705ac0fcb8@grimberg.me>
 <70424742-3af4-ded7-d3d0-b1f32d97905e@grimberg.me>
Message-ID: <b53211f1-d1e5-fd58-c1ca-b924eecab6ea@grimberg.me>
Date: Thu, 23 Jul 2020 18:03:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <70424742-3af4-ded7-d3d0-b1f32d97905e@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200723_210343_056151_B7B4BDD8 
X-CRM114-Status: GOOD (  21.44  )
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
Cc: Anton Eidelman <anton@lightbitslabs.com>,
 James Smart <james.smart@broadcom.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Actually, I think that the design was to unblock the scan_work and that
> is why nvme_mpath_clear_ctrl_paths was placed before (as the comment
> say).
> 
> But looking at the implementation of nvme_mpath_clear_ctrl_paths, it's
> completely unclear why it should take the scan_lock. It is just clearing
> the paths..
> 
> I think that the correct patch would be to just not take the scan_lock
> and only take the namespaces_rwsem.

OK, I was able to reproduce this on my setup.

What was needed is that fabrics will allow I/O to pass in
NVME_CTRL_DELETING, which needed this add-on:
--
     nvme-fabrics: don't fast fail on ctrl state DELETING

     This is now an state that allows for I/O to be sent to the
     device, and when the device shall transition into
     NVME_CTRL_DELETING_NOIO we shall fail the I/O.

     Note that this is fine because the transport itself has
     a queue state to protect against queue access.

     Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index a0ec40ab62ee..a9c1e3b4585e 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -182,7 +182,8 @@ bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
  static inline bool nvmf_check_ready(struct nvme_ctrl *ctrl, struct 
request *rq,
                 bool queue_live)
  {
-       if (likely(ctrl->state == NVME_CTRL_LIVE))
+       if (likely(ctrl->state == NVME_CTRL_LIVE ||
+                  ctrl->state == NVME_CTRL_DELETING))
                 return true;
         return __nvmf_check_ready(ctrl, rq, queue_live);
  }
--

Logan,

Can you verify that it works for you?

BTW, I'm still seriously suspicious on why nvme_mpath_clear_ctrl_paths
is taking the scan_lock. It appears that it shouldn't. I'm tempted to
remove it and see if anyone complains...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
