Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2E2C36018
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Apr 2025 08:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rM5cbxZYgFPy7zIZPnNCFByNLwR2155xOFzFBb62i7g=; b=q1qkf/19GKlYtAXqdFDEU9xJ1S
	oXIzpIJXzvXO8no8jZS5YchGcrYLyjuvGVEuXNVmUuAPKam0sruWZXZh+8FJIHQWAyPrDon5Lz8CU
	G4qTPrbmmzXzz/4mi8U9scYxcXm22Cs/ES2Pd42rFyVYPALSeUfVJ5BPUZ7PtD3PCdLJfELnIJMeY
	G4WWscv5bP8auC+plFmkoKFGrOsRPf0/j4d+TAwKuooqZ8V8o2XB4zsdFGgdBOd+o2F/r5qwTjHTq
	eHPesvY8isQ7X4cJLcDXvI2yQ9spE5bxSS2SqZNIV6ciCxKTbE7/HhU3giT/sYnJ+7ZWQqr5p0mtY
	CmSrZZ8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzXQ6-00000002NyK-1K2z;
	Tue, 01 Apr 2025 08:56:30 +0000
Received: from out162-62-57-87.mail.qq.com ([162.62.57.87])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzXQ3-00000002NwZ-0Pu7
	for linux-nvme@lists.infradead.org;
	Tue, 01 Apr 2025 08:56:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1743497772; bh=rM5cbxZYgFPy7zIZPnNCFByNLwR2155xOFzFBb62i7g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=y9rne3SNzZcdKsmdrGVDSBLGBqGjSYjgxguHIq0Mg2+sA/5cEXpe+pBW7EsS99cCC
	 Z/Kjzj0MifZLLu6irnNDLCT+YHvXTlURhIvVe7dEq1X0HzCbo1lIc9LkfDL+Gr+5qn
	 MupLLDwJnQPpCib8l3muGNiJ8ZugB5y55lWOXHkM=
Received: from [10.42.13.21] ([116.128.244.169])
	by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
	id E099F4ED; Tue, 01 Apr 2025 16:56:09 +0800
X-QQ-mid: xmsmtpt1743497769tmn5m2fdy
Message-ID: <tencent_092C538875C434A7CA16B453FBF7B3E46705@qq.com>
X-QQ-XMAILINFO: MuOYcNghSeILxxBIWXDhMG+Q/3nbxQ5MGreLl9oL85VP9Fia4G7SPGKrgIs/xc
	 Cpp070drCv1oOJdrGyI5EgCBBsO/sbC8GhS1h2D8Fe/tqLJu3rENnsYso1jAhJKabdLPmyKxm4fL
	 MemKNXVxe+vVTi/XgOp7bbgwc55jbL9ksSGvEuEDrQnISvOlvhZriam5JjEy53kWTlpjVO/+WZEc
	 /Vb0QQTo1BwBq2W3zmmE7HKGEinevhafm/XVDBm7jzEta9zBNZ/EBePEKdY/xBRQpLUAe0LvZwO9
	 RNASQelWsNkH0apgySJbxZo7GsQeStji/kyJZVRBThLMaav/NOvpw/DxOEoMyxYt0UmuNMVpxfb6
	 7EOQxIjKff+uZD+WpsZIlUtP6qpjAZBm542lWVdojB9Q7EFUf69lYexrC31RbndOQlBLJzk+jxGg
	 vGZPP/GUndlhnqdrvRDn5uMwYnxuXu2jAg87qe+kq+CLF+x99BJn7MjvZr0kHOI6jDLkYJnR+sEz
	 PxMt7iXkJ/tfZoeKwGu84xWqjngiT4IE41IdNLGQ+gDtFm8uc9SOg5y3j9H9wFa0TcYmkTP8tN7X
	 Ww/cEPbNmgxDRXIAh7SQ9CCAJfzba/w8yFTiawucdM9KVqV4ZlJEnlskcJWB10i2245F6i0hogDR
	 gZxU0XjWgUcctC5h3SDQ6FQ/7z3FfR4vI2wZY1rG6CpY5s48IURaT9mm8jBivnJI5zyBAs2juxk+
	 m/iVpwGAG0jmQVxwXCPQJFbJzYzQmb8NV+E2XExm6xq4YWfE/IbYph/yTpkcU+hpJIVGX9PNlhVp
	 nQxTqiFDRJeTGeqcl4+gSWixE+Srk+qRb19dNOhIgABV5kgYAK0j/x4bs39z77nfESVJYBi2wWkX
	 alInMk5yTf4SKM4C7cH2q0qkrXYCpKM7plQG2zLprGbtbOEkbpZDWqFZlRDRT2OSqYDqso1UFBCQ
	 QXanp9Sju6Nq7ShXmaCA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-OQ-MSGID: <16d6c02a-815a-4ffe-b281-937f3aea3c9f@qq.com>
Date: Tue, 1 Apr 2025 16:56:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] nvme: add sysfs interface for APST table updates
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
 <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yaxiong Tian <tianyaxiong@kylinos.cn>
References: <tencent_4A5421BA11BD9C5B5BF3CEA95FD212AB3107@qq.com>
 <tencent_29C768845246A8732C6D233A857EC74B6809@qq.com>
 <d89c3460-cacf-4df1-bc31-3b710671d699@nvidia.com>
Content-Language: en-US
From: Yaxiong Tian <iambestgod@qq.com>
In-Reply-To: <d89c3460-cacf-4df1-bc31-3b710671d699@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250401_015627_894738_8F3421F2 
X-CRM114-Status: GOOD (  21.74  )
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



On 2025/4/1 10:55, Chaitanya Kulkarni wrote:
> On 3/27/25 18:40, Yaxiong Tian wrote:
>> From: Yaxiong Tian <tianyaxiong@kylinos.cn>
>>
>> Currently, the APST (Autonomous Power State Transition) table can only be
>> updated during module initialization via module parameters or indirectly
>> by setting QoS latency requirements. This patch adds a direct sysfs
>> interface to allow dynamic updates to the APST table at runtime.
>>
>> The new sysfs entry is created at:
>> /sys/class/nvme/<controller>/apst_update
>>
>> This provides more flexibility in power management tuning without
>> requiring module reload or QoS latency changes.
>>
>> Example usage:
>> update nvme module parameters.
>> echo 1  > /sys/class/nvme/nvme0/apst_update
>>
>> Signed-off-by: Yaxiong Tian  <tianyaxiong@kylinos.cn>
> 
> by any chance can you please provide a use-case in which scenario
> you need to dynamically updating APST ?
Yes,In desktop systems, users can choose between power-saving mode and 
performance mode. These two modes involve different trade-offs between 
NVMe performance and power efficiency, thus requiring dynamic updates to 
APST. I will update the commit message.
> 
>> ---
>>    drivers/nvme/host/core.c  |  9 +++++++--
>>    drivers/nvme/host/nvme.h  |  2 ++
>>    drivers/nvme/host/sysfs.c | 23 +++++++++++++++++++++++
>>    3 files changed, 32 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index fb0404fee551..9dea1046b8b4 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2654,7 +2654,7 @@ static bool nvme_apst_get_transition_time(u64 total_latency,
>>     *
>>     * Users can set ps_max_latency_us to zero to turn off APST.
>>     */
>> -static int nvme_configure_apst(struct nvme_ctrl *ctrl)
>> +int nvme_configure_apst(struct nvme_ctrl *ctrl)
>>    {
>>    	struct nvme_feat_auto_pst *table;
>>    	unsigned apste = 0;
>> @@ -2778,8 +2778,11 @@ static void nvme_set_latency_tolerance(struct device *dev, s32 val)
>>    
>>    	if (ctrl->ps_max_latency_us != latency) {
>>    		ctrl->ps_max_latency_us = latency;
>> -		if (nvme_ctrl_state(ctrl) == NVME_CTRL_LIVE)
>> +		if (nvme_ctrl_state(ctrl) == NVME_CTRL_LIVE) {
>> +			mutex_lock(&ctrl->apst_lock);
>>    			nvme_configure_apst(ctrl);
>> +			mutex_unlock(&ctrl->apst_lock);
>> +		}
>>    	}
>>    }
>>    
>> @@ -4852,6 +4855,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>>    	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
>>    	ctrl->ka_last_check_time = jiffies;
>>    
>> +	mutex_init(&ctrl->apst_lock);
>> +
>>    	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
>>    			PAGE_SIZE);
>>    	ctrl->discard_page = alloc_page(GFP_KERNEL);
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index 51e078642127..7f8e10f5bf7a 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -385,6 +385,7 @@ struct nvme_ctrl {
>>    	key_serial_t tls_pskid;
>>    
>>    	/* Power saving configuration */
>> +	struct mutex apst_lock;
>>    	u64 ps_max_latency_us;
>>    	bool apst_enabled;
>>    
>> @@ -828,6 +829,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl);
>>    void nvme_wait_freeze(struct nvme_ctrl *ctrl);
>>    int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
>>    void nvme_start_freeze(struct nvme_ctrl *ctrl);
>> +int nvme_configure_apst(struct nvme_ctrl *ctrl);
>>    
>>    static inline enum req_op nvme_req_op(struct nvme_command *cmd)
>>    {
>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>> index 6d31226f7a4f..5003cb294d65 100644
>> --- a/drivers/nvme/host/sysfs.c
>> +++ b/drivers/nvme/host/sysfs.c
>> @@ -684,6 +684,28 @@ static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
>>    	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
>>    #endif
>>    
>> +static ssize_t apst_update_store(struct device *dev,
>> +					      struct device_attribute *attr,
>> +					      const char *buf, size_t size)
>> +{
>> +	int err;
>> +	bool bool_data = false;
>> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> 
> reverse tree ?
> 
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	bool bool_data = false;
> +	int err;
> 
>> +	err = kstrtobool(buf, &bool_data);
> 
> add new line above after all the declarations ?
> 
> -ck
> 
> 
Thanks, I'll update this in the V3 patch.


