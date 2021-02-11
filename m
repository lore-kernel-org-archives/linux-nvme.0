Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89304C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 10:43:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E03D64E13
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 10:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E03D64E13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fiMsNLG/u/oFITiBsEbVg+bxLlYtfyTiBKuYpi3FSnE=; b=LvXmKP8R0IvfgppBvn6umzzyg
	8XiXQ+5ikCaZ/5RcQDelqlbPoESP6dTA6zWnGDFYNKKeUPg0buaa5Qbl9Ha3m+hSPMOxENkZh4JuW
	aJJw1Qg2HQYsNiCxl5QBaN78/dl1NAibka2uAY5+OqkFoGWQoDiBnA1RvvYP8q9B+y0XL2Wax61Yq
	eUjFsQwEK4b5Gp911UN3h9+OWAFTtuS6vA8GpljCU3U3UlsqF/k0UEHLL1EcDRRFU2lkLmtmEeXJC
	6F+uKnvX+oTgijzLGltjn7Zcu/bEuzqYFKoLLdF41WDhYRjF6GKVPrPwvTzOHAGysZnTa9DZQWYYJ
	UPDLzjcRw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lA9Re-0005TE-4x; Thu, 11 Feb 2021 10:43:34 +0000
Received: from mail-pf1-f169.google.com ([209.85.210.169])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lA9Rb-0005SX-92
 for linux-nvme@lists.infradead.org; Thu, 11 Feb 2021 10:43:32 +0000
Received: by mail-pf1-f169.google.com with SMTP id c11so3434038pfp.10
 for <linux-nvme@lists.infradead.org>; Thu, 11 Feb 2021 02:43:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cpWh4/SAjKSSmn0p7/c//7Tr+H7NzeT+TEq6/uuZvjA=;
 b=XWo/KwuneyrpDlRLY+VqcyF7rWNNW87ZMz5lfhlZkc9sEvNAYUwL3OtKkIdBHWqqqw
 v7RZp8lTHOyyX6mON43scB6MiFwnPbXFTYlw08OJ6dtbMpMjT6FvpOKxIzFzaY7q/Jnf
 Y2r+n2OvDVJwwYZ3khNzmZgvfypQj6Kzc+YjIpnzw3r9iCbVhAQbnuILCQKN35/qrnjc
 meHF4a6tMl0LA+XPlM3V1S1OI2Hdkt7Kx+K5LACAFPPUjztm2IlBzPEWcL2gmb0Hmr20
 y0ZccLO7RANrb0wAUTSU8dJx5Cj05xeYRdUul/x85dh6hN27Jr+O1TM4crEECV40KIz9
 k7Kg==
X-Gm-Message-State: AOAM531m/3RhrX2hrGLqoAf99clN4gYy82vQCIT3ZQooQc9zQsoIIDSY
 xpdcWI9trkEFb4F9IMZa824Zz+pb870=
X-Google-Smtp-Source: ABdhPJy4LAmZlP+NX6FmtYFiSY+IawHwpNLg9KLBbrZU/WQqXIqWHLtHPsA6fWWyXyt7eeNI2dUP6g==
X-Received: by 2002:a65:620f:: with SMTP id d15mr7395279pgv.218.1613040209028; 
 Thu, 11 Feb 2021 02:43:29 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:1c07:7210:2422:7e89?
 ([2601:647:4802:9070:1c07:7210:2422:7e89])
 by smtp.gmail.com with ESMTPSA id c24sm5222688pfo.209.2021.02.11.02.43.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Feb 2021 02:43:28 -0800 (PST)
Subject: Re: [PATCH 2/2] nvme: don't set iosqes,iocqes for discovery
 controllers
To: Christoph Hellwig <hch@lst.de>
References: <20210209101235.1539917-1-sagi@grimberg.me>
 <20210209101235.1539917-2-sagi@grimberg.me> <20210210101126.GA26624@lst.de>
 <3702938a-cfd5-b725-bb75-7c9072a42fde@grimberg.me>
 <20210211070250.GA13708@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f279bd6a-d4e3-52b6-740b-66f90434cf69@grimberg.me>
Date: Thu, 11 Feb 2021 02:43:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210211070250.GA13708@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210211_054331_362128_0D70FED4 
X-CRM114-Status: GOOD (  22.33  )
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
Cc: Keith Busch <kbusch@kernel.org>, Martin.Belanger@dell.com,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> So if we change this we break interaction with all old Linux (and maybe
>>> other?) targets.
>>
>> Well yes.. Do you think that we should do a retry in case it fails for
>> backward compatibility?
> 
> I think we have to.

The annoying thing here is that this issue will manifest in the host
waiting on nvme_wait_ready for a long 7.5 seconds to understand that
its maybe incompatible and re-attempt (nvme_enable_ctrl writes to cap
and then polls CSTS)...

What I have now looks like:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 02579f4f776c..ee65c89a991c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2457,8 +2457,14 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl)
  }
  EXPORT_SYMBOL_GPL(nvme_disable_ctrl);

+static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
+{
+       return ctrl->opts && ctrl->opts->discovery_nqn;
+}
+
  int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
  {
+       bool compat_disc_ctrl_config = false;
         unsigned dev_page_min;
         int ret;

@@ -2482,13 +2488,33 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
                 ctrl->ctrl_config = NVME_CC_CSS_NVM;
         ctrl->ctrl_config |= (NVME_CTRL_PAGE_SHIFT - 12) << 
NVME_CC_MPS_SHIFT;
         ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
-       ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
+again:
+       if (!nvme_discovery_ctrl(ctrl) || compat_disc_ctrl_config)
+               ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
         ctrl->ctrl_config |= NVME_CC_ENABLE;

         ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
         if (ret)
                 return ret;
-       return nvme_wait_ready(ctrl, ctrl->cap, true);
+
+       ret = nvme_wait_ready(ctrl, ctrl->cap, true);
+       if (ret) {
+               if (!compat_disc_ctrl_config) {
+                       pr_err("retrying...\n");
+                       /*
+                        * Backward compatibility work-around: some targets
+                        * (i.e. older Linux targets) may incorrectly verify
+                        * iosqes,iocqes are non-zero for discovery
+                        * controllers. So in order not to break them, we
+                        * attempt once again with the incorrect settings.
+                        */
+                       if (nvme_disable_ctrl(ctrl))
+                               return ret;
+                       compat_disc_ctrl_config = true;
+                       goto again;
+               }
+       }
+       return ret;
  }
  EXPORT_SYMBOL_GPL(nvme_enable_ctrl);

@@ -2902,11 +2928,6 @@ static const struct attribute_group 
*nvme_subsys_attrs_groups[] = {
         NULL,
  };

-static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
-{
-       return ctrl->opts && ctrl->opts->discovery_nqn;
-}
-
  static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
                 struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
  {
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
