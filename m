Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A473C982FE
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 14:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9cUCkPdas2kfxE+efO9Wme9qFZiBsh0bAukmbBJvexM=; b=uAXrNVhsCsXVqtoA1OZaTS0I7I
	P1qxr1adPKE2ieXNsNlJGa9u7JIH1O63RLDnubBXl1yDkDQECHvXNG+1LibebID/53bXrb6KvFvcz
	Qc4+EXjIZT47latsHK4K+X24wtl88F20GR3MOkW6U93f/mRH0lnU9L/9BZKdF1XpVyUGFNd+kNmDL
	dMXlIzq4woHQ6M/NE8xmvpWJhgZWgmx1G6BgsDgk3YQgkPqKiLcTPamhYz1oY8W0fFTnNAuWe8Xxp
	Gn+Vag9hAOngTNoUW7chcJAocf+waahugXx3aLuOHJeYIAc+D6F5Ks5msnw5wzTevTl8Umx+ywAEr
	wAJsxZdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x91Pp-00000005fon-2nZz;
	Tue, 22 Sep 2026 14:24:13 +0000
Received: from out-235.mta1.migadu.com ([2001:41d0:203:375::eb] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x91Pm-00000005fmR-3l0c
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 14:24:12 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=dyuVfc8TH6PwmQ1IqSWziBs4ILig01qq98JwDOm0/eg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790087047; v=1; x=1790691847;
 b=CCa013Bi6cPYGPbLFc3CABMyfvD4t5fp7TpJpd6ladWkv8crWojzTw6uG8Uk/ODQXZ1P+9v+
 m6xQ2NOxOTG8ZyAd/uApGTH5USaGdGosu1D+nFiATcYkU17pofXm0mP4SqPSZs0WfOO2XCmJOXb
 fFSpQrwMLunyElAKLIfg5Y4U=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta12.migadu.com with ESMTPS id 0719151c0f307984;
	Tue, 22 Sep 2026 14:24:07 +0000
X-Mizu-Trace-ID: 0719151c0f307984
X-Migadu-Flow: FLOW_OUT
Message-ID: <1adea898-454f-4029-b8ea-d6f557f59087@linux.dev>
Date: Tue, 22 Sep 2026 15:24:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-multipath: add iopolicies sysfs attribute
To: loberman@redhat.com, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
References: <20260921144347.49620-1-loberman@redhat.com>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20260921144347.49620-1-loberman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_072411_154558_1AD808CE 
X-CRM114-Status: GOOD (  20.45  )
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

On 9/21/26 15:43, loberman@redhat.com wrote:
> From: Laurence Oberman <loberman@redhat.com>
> 
> The subsystem iopolicy attribute only shows the active policy, so
> there is no way to see which policies are available.
> 
> Changing the output of iopolicy would break existing userspace,
> since nvme-cli compares the value against a bare policy name. Leave
> iopolicy unchanged and add a read-only iopolicies attribute that
> lists the available policies:
> 
>    # cat iopolicies
>    numa round-robin queue-depth
> 
> The current policy is still read from iopolicy.
> 
> Signed-off-by: Laurence Oberman <loberman@redhat.com>

Apart from comment below:

Reviewed-by: John Garry <john.garry@linux.dev>

> Assisted-by: Claude:claude-sonnet-5
> ---
> v2:
>    - Drop the [ ] notation and list plain policy names (Christoph)
> 
>   drivers/nvme/host/multipath.c | 15 +++++++++++++++
>   drivers/nvme/host/nvme.h      |  1 +
>   drivers/nvme/host/sysfs.c     |  1 +
>   3 files changed, 17 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 75dbb58286a3..ea7d0c59587b 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -1085,6 +1085,21 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
>   SUBSYS_ATTR_RW(iopolicy, S_IRUGO | S_IWUSR,
>   		      nvme_subsys_iopolicy_show, nvme_subsys_iopolicy_store);
>   
> +static ssize_t iopolicies_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	int i, len = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++)
 > +		len += sysfs_emit_at(buf, len, "%s%s", i ? " " : "",> +				 
nvme_iopolicy_names[i]);
> +
> +	len += sysfs_emit_at(buf, len, "\n");
> +	return len;
> +}
> +
> +struct device_attribute subsys_attr_iopolicies = __ATTR_RO(iopolicies);

SUBSYS_ATTR_RO already exists for this, right?

> +
>   static ssize_t ana_grpid_show(struct device *dev, struct device_attribute *attr,
>   		char *buf)
>   {
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 75e5d5a8a77c..b419c6fc6081 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -1098,6 +1098,7 @@ extern struct device_attribute dev_attr_multipath_failover_count;
>   extern struct device_attribute dev_attr_io_requeue_no_usable_path_count;
>   extern struct device_attribute dev_attr_io_fail_no_available_path_count;
>   extern struct device_attribute subsys_attr_iopolicy;
> +extern struct device_attribute subsys_attr_iopolicies;
>   
>   static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
>   {
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index abf8edaae371..4c4518b6b7d5 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -1298,6 +1298,7 @@ static struct attribute *nvme_subsys_attrs[] = {
>   	&subsys_attr_subsystype.attr,
>   #ifdef CONFIG_NVME_MULTIPATH
>   	&subsys_attr_iopolicy.attr,
> +	&subsys_attr_iopolicies.attr,
>   #endif
>   	NULL,
>   };


