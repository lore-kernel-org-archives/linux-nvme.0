Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5124CC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 10:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k14e2yF0p2BjxiMfjS6n+R9NeLouEHn5be7epS5MMOQ=; b=ZIdtZiKCXQrHNObGG5GC81M2h8
	aw0EgrAhfi3Rm4xUhAtuzJNT/pSOucU38FodtxnoLrtNpwQ+VotbaWKFw7iVDrH48+fNEsa8uNR9m
	9+gIdyold11KHPHMP7AEmpgvZqCiKGGd3Y9L5jUWB+s+qp/aRtEM334sDf67fHc2UAUBt78/3bNge
	xfjBaBBuLNHQgnwlAq5nZqWkLjkTxGj1Z7coMmD3tcMluHgKIWYwdp7z+yMgQuFWf1O9sGY77pN7n
	rxTMFOy8r/GU0w9oN3ZvwzHWyw324gDQUN9kjx2Rm/xuB4f1JP5zanbWh1gxKqoaSH5KhFFI5Et3Z
	1d5k/0mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndrHL-008KNH-50; Mon, 11 Apr 2022 10:28:15 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndqoI-0086ze-Cy
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 09:58:16 +0000
Received: by mail-wm1-f45.google.com with SMTP id p189so9536637wmp.3
 for <linux-nvme@lists.infradead.org>; Mon, 11 Apr 2022 02:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=k14e2yF0p2BjxiMfjS6n+R9NeLouEHn5be7epS5MMOQ=;
 b=SZJH/RAkj2WjH0yQ17zGBExqlOUyxyynA5kgpw+ORH5ou5agk+1Q3Td7IO+4n2EJbt
 uK6Ez5bmEBzl9/PsDxtTscZ1ALHbFMcOiR3toQ9vZ9UhwJsnka3/UwLuwKr/aVntqFfB
 t7gM/SpMxmGWefF1DKahZU8yk1t4p1cJYo81R7jpEnSXFXBbVQuyw6CGIhS+aBZvBjtX
 Q26tm/TsgqRB8TOYW4blOaMeYWe+8rcTIfuFGyMChTcQN9OKZd0mdCWmoeKAQz+EK88a
 GsRIVuBk97Q9h/bAaCv06UtV8GjOXJKPtvEVcFu1zMJWQBwyKGLM7COxIwD1b8Il3ekk
 vCGA==
X-Gm-Message-State: AOAM531W33jznaQCgjAGfh8y7fEV0A0JaiEnitPViSldkRToA0SbnPrg
 pPlV4Ci9STacEQ8IuktvXt0=
X-Google-Smtp-Source: ABdhPJxRt61BxTeMoENETj7yQYEDXrhb7+A7ypPXqTGxLa9NnrY98Q9zue/7ACE7O+ao91Pr1B70Dw==
X-Received: by 2002:a05:600c:3d86:b0:38d:581:89ad with SMTP id
 bi6-20020a05600c3d8600b0038d058189admr28818335wmb.42.1649671091442; 
 Mon, 11 Apr 2022 02:58:11 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 f9-20020a05600c4e8900b0038cc29bb0e1sm20272010wmq.4.2022.04.11.02.58.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Apr 2022 02:58:10 -0700 (PDT)
Message-ID: <adb47490-e13a-1c18-c6fb-23a233471796@grimberg.me>
Date: Mon, 11 Apr 2022 12:58:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvme-tcp: handle failing req immediately for
 REQ_FAILFAST_DRIVER
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, Anton Eidelman <anton@lightbitslabs.com>
Cc: linux-nvme@lists.infradead.org, Martin.Belanger@dell.com
References: <20220407092540.66227-1-dwagner@suse.de>
 <eef5eda6-f00f-b879-858f-80f7ce44a362@grimberg.me>
 <20220407122054.reywmgnysnhryvg2@carbon.lan>
 <129b9f99-fd4d-1920-dee8-652e774a3b57@grimberg.me>
 <20220407133806.xawe6y5v5uec4vzi@carbon.lan>
 <48363e60-d506-b1bf-cb3a-db781290f285@grimberg.me>
 <20220407135353.uupdcx2jbk37qtpx@carbon.lan>
 <20220407150155.sryxcqrv25wt3irp@carbon.lan>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220407150155.sryxcqrv25wt3irp@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_025814_566370_47D45417 
X-CRM114-Status: GOOD (  29.93  )
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


>>> But in your case the queue is live...
>>
>> Could we not just test for NVME_CTRL_ADMIN_Q_STOPPED instead as it is
>> set in nvme_stop_admin_queue:
>>
>> nvme_tcp_teardown_ctrl
>>    nvme_stop_admin_queue
>>    nvme_shutdown_ctrl
>>
>> instead?
>>
>>> I'm thinking that we maybe need a register access timeout value for
>>> fabrics...
>>
>> I see there is a shutdown_timeout which is 5 seconds on default. Seems
>> not to trigger though.
> 
> Obviously, the shutdown_timeout is not connected to the register
> writes. So we would need something like:

Looking at this, its probably not what we want...

I've inspected the code and I don't think that we should check
the return code at all, we should simply fail the request. If
the io_work context is running in parallel with the the error
recovery handler we have a bug that we need to fix.

How about this?
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 10fc45d95b86..6d59867bb275 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1147,8 +1147,7 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue 
*queue)
         } else if (ret < 0) {
                 dev_err(queue->ctrl->ctrl.device,
                         "failed to send request %d\n", ret);
-               if (ret != -EPIPE && ret != -ECONNRESET)
-                       nvme_tcp_fail_request(queue->request);
+               nvme_tcp_fail_request(req);
                 nvme_tcp_done_send_req(queue);
         }
         return ret;
--

Adding Anton,

Anton, do you see an issue with this change? io_work is safely
fenced from the cancellation iter so there is no reason for
us not to fail the request here when the socket closes (or
any other reason for that matter).


> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f204c6f78b5b..a146ea25f386 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2133,7 +2133,8 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
>   	u32 csts, bit = enabled ? NVME_CSTS_RDY : 0;
>   	int ret;
>   
> -	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
> +	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS,
> +					    &csts, timeout)) == 0) {
>   		if (csts == ~0)
>   			return -ENODEV;
>   		if ((csts & NVME_CSTS_RDY) == bit)
> @@ -2166,7 +2167,8 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl)
>   	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
>   	ctrl->ctrl_config &= ~NVME_CC_ENABLE;
>   
> -	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
> +	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config,
> +				     NVME_REG_ACCESS_TIMEOUT);
>   	if (ret)
>   		return ret;
>   
> @@ -2182,7 +2184,8 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
>   	unsigned dev_page_min;
>   	int ret;
>   
> -	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
> +	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap,
> +				    NVME_REG_ACCESS_TIMEOUT);
>   	if (ret) {
>   		dev_err(ctrl->device, "Reading CAP failed (%d)\n", ret);
>   		return ret;
> @@ -2205,7 +2208,8 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
>   	ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
>   	ctrl->ctrl_config |= NVME_CC_ENABLE;
>   
> -	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
> +	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config,
> +				     NVME_REG_ACCESS_TIMEOUT);
>   	if (ret)
>   		return ret;
>   	return nvme_wait_ready(ctrl, ctrl->cap, true);
> @@ -2221,11 +2225,13 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
>   	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
>   	ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
>   
> -	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
> +	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config,
> +				     NVME_REG_ACCESS_TIMEOUT);
>   	if (ret)
>   		return ret;
>   
> -	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
> +	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts,
> +					    NVME_REG_ACCESS_TIMEOUT)) == 0) {
>   		if ((csts & NVME_CSTS_SHST_MASK) == NVME_CSTS_SHST_CMPLT)
>   			break;
>   
> @@ -3084,7 +3090,8 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
>   {
>   	int ret;
>   
> -	ret = ctrl->ops->reg_read32(ctrl, NVME_REG_VS, &ctrl->vs);
> +	ret = ctrl->ops->reg_read32(ctrl, NVME_REG_VS, &ctrl->vs,
> +				    NVME_REG_ACCESS_TIMEOUT);
>   	if (ret) {
>   		dev_err(ctrl->device, "Reading VS failed (%d)\n", ret);
>   		return ret;
> @@ -4386,7 +4393,8 @@ static bool nvme_ctrl_pp_status(struct nvme_ctrl *ctrl)
>   
>   	u32 csts;
>   
> -	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts))
> +	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts,
> +				  NVME_REG_ACCESS_TIMEOUT))
>   		return false;
>   
>   	if (csts == ~0)
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index ee79a6d639b4..7882559e89bc 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -142,7 +142,7 @@ EXPORT_SYMBOL_GPL(nvmf_get_address);
>    *	> 0: NVMe error status code
>    *	< 0: Linux errno error code
>    */
> -int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
> +int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val, int timeout)
>   {
>   	struct nvme_command cmd = { };
>   	union nvme_result res;
> @@ -152,8 +152,8 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
>   	cmd.prop_get.fctype = nvme_fabrics_type_property_get;
>   	cmd.prop_get.offset = cpu_to_le32(off);
>   
> -	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0, 0,
> -			NVME_QID_ANY, 0, 0);
> +	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
> +				     timeout, NVME_QID_ANY, 0, 0);
>   
>   	if (ret >= 0)
>   		*val = le64_to_cpu(res.u64);
> @@ -187,7 +187,7 @@ EXPORT_SYMBOL_GPL(nvmf_reg_read32);
>    *	> 0: NVMe error status code
>    *	< 0: Linux errno error code
>    */
> -int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
> +int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val, int timeout)
>   {
>   	struct nvme_command cmd = { };
>   	union nvme_result res;
> @@ -198,8 +198,8 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
>   	cmd.prop_get.attrib = 1;
>   	cmd.prop_get.offset = cpu_to_le32(off);
>   
> -	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0, 0,
> -			NVME_QID_ANY, 0, 0);
> +	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
> +				     timeout, NVME_QID_ANY, 0, 0);
>   
>   	if (ret >= 0)
>   		*val = le64_to_cpu(res.u64);
> @@ -232,7 +232,7 @@ EXPORT_SYMBOL_GPL(nvmf_reg_read64);
>    *	> 0: NVMe error status code
>    *	< 0: Linux errno error code
>    */
> -int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
> +int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val, int timeout)
>   {
>   	struct nvme_command cmd = { };
>   	int ret;
> @@ -243,8 +243,8 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
>   	cmd.prop_set.offset = cpu_to_le32(off);
>   	cmd.prop_set.value = cpu_to_le64(val);
>   
> -	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0, 0,
> -			NVME_QID_ANY, 0, 0);
> +	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0,
> +				     timeout, NVME_QID_ANY, 0, 0);
>   	if (unlikely(ret))
>   		dev_err(ctrl->device,
>   			"Property Set error: %d, offset %#x\n",
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index c3203ff1c654..c2ae0c04cd4a 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -186,9 +186,9 @@ static inline char *nvmf_ctrl_subsysnqn(struct nvme_ctrl *ctrl)
>   	return ctrl->subsys->subnqn;
>   }
>   
> -int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
> -int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
> -int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
> +int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val, int timeout);
> +int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val, int timeout);
> +int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val, int timeout);
>   int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl);
>   int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid);
>   int nvmf_register_transport(struct nvmf_transport_ops *ops);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a1f8403ffd78..f17a4df17e11 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -27,6 +27,8 @@ extern unsigned int admin_timeout;
>   
>   #define NVME_DEFAULT_KATO	5
>   
> +#define NVME_REG_ACCESS_TIMEOUT NVME_DEFAULT_KATO
> +
>   #ifdef CONFIG_ARCH_NO_SG_CHAIN
>   #define  NVME_INLINE_SG_CNT  0
>   #define  NVME_INLINE_METADATA_SG_CNT  0
> @@ -489,9 +491,12 @@ struct nvme_ctrl_ops {
>   #define NVME_F_FABRICS			(1 << 0)
>   #define NVME_F_METADATA_SUPPORTED	(1 << 1)
>   #define NVME_F_PCI_P2PDMA		(1 << 2)
> -	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
> -	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
> -	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
> +	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val,
> +			  int timeout);
> +	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val,
> +			   int timoeut);
> +	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val,
> +			  int timeout);
>   	void (*free_ctrl)(struct nvme_ctrl *ctrl);
>   	void (*submit_async_event)(struct nvme_ctrl *ctrl);
>   	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
> @@ -561,7 +566,8 @@ static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
>   {
>   	if (!ctrl->subsystem)
>   		return -ENOTTY;
> -	return ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65);
> +	return ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65,
> +				      NVME_REG_ACCESS_TIMEOUT);
>   }
>   
>   /*
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 66f1eee2509a..b7246fee99ef 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2943,19 +2943,22 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
>   	nvme_put_ctrl(&dev->ctrl);
>   }
>   
> -static int nvme_pci_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
> +static int nvme_pci_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val,
> +			       int timeout)
>   {
>   	*val = readl(to_nvme_dev(ctrl)->bar + off);
>   	return 0;
>   }
>   
> -static int nvme_pci_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
> +static int nvme_pci_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val,
> +				int timeout)
>   {
>   	writel(val, to_nvme_dev(ctrl)->bar + off);
>   	return 0;
>   }
>   
> -static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
> +static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val,
> +			       int timeout)
>   {
>   	*val = lo_hi_readq(to_nvme_dev(ctrl)->bar + off);
>   	return 0;

