Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A49C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 18:01:46 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F9160FEE
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 18:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F9160FEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fnM4ABRUDfkVFdhPFNwl86QIW43NtOGCobZmI3LEHpo=; b=jijju1sPcTEcmzMQO8NwvtYnW
	d+Ge+9/l4hmFD2f4vaXjgfhrRbLee7230Ve1kc39lAmft7kRKJMmaQFD9WiCI2b6VAtLMCE5tOitQ
	tNAFxPszduqXEAGm77aDbdCulTNKrGzsVB65431l66MrHGRuH5zx1uZz5elrOPi1kO5aGX/RO+pSJ
	4v12oyf1roft2AZJH3f92c092DiEWi1RSTLHVAL4O6sgDOUGD79CEu/aea9mbkquKwuN1YcPouw9+
	v8yfKogfCgvvz2+eMGJuCW7DebsCcTjVB7Vre0aEOyDOfvSqdWpQesRFJmpaQy4ag1Ypw2TuNmWsk
	axI5Dhmvg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRf9r-007EMe-9w; Wed, 31 Mar 2021 18:01:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRf9m-007ELc-Pt
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 18:01:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617213687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9TIoYOxwgSa1oTS8+sR3o06KhEyayI82f4/zo2TYwM=;
 b=SRrWvAQ3+rUtTYcbouClPg+ZJI2WgaBRQhG0vPjtOvtBssV8sId5YJxku5+7GyECm5k/Lz
 J+q3k7whUFuw8vX/rJX2Udbj+AYdtkzzexxX65hG1mtWGeUDOLA6GWbORS1zqHAjPUHW3z
 QNrK312kFcL8YNGTRh0qxK2bnMgU7mk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-QUw5xmPbOeiwz7_cEDoPBg-1; Wed, 31 Mar 2021 14:01:24 -0400
X-MC-Unique: QUw5xmPbOeiwz7_cEDoPBg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADFAD107ACCA;
 Wed, 31 Mar 2021 18:01:23 +0000 (UTC)
Received: from ovpn-112-207.phx2.redhat.com (ovpn-112-207.phx2.redhat.com
 [10.3.112.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BBB55D720;
 Wed, 31 Mar 2021 18:01:22 +0000 (UTC)
Message-ID: <7605c89ca672030cb296dc47208b4298ce00b30d.camel@redhat.com>
Subject: Re: [PATCH] nvme: Export fast_io_fail_tmo to sysfs
From: "Ewan D. Milne" <emilne@redhat.com>
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Date: Wed, 31 Mar 2021 14:01:22 -0400
In-Reply-To: <20210331131228.131118-1-dwagner@suse.de>
References: <20210331131228.131118-1-dwagner@suse.de>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_190131_193998_32BD78C3 
X-CRM114-Status: GOOD (  23.49  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, 2021-03-31 at 15:12 +0200, Daniel Wagner wrote:
> Commit 8c4dfea97f15 ("nvme-fabrics: reject I/O to offline device")
> introduced fast_io_fail_tmo but didn't export the value to sysfs.
> That
> means the value is hard coded during compile time. Export the timeout
> value to user space via sysfs to allow runtime configuration.
> 
> Cc: Victor Gladkov <Victor.Gladkov@kioxia.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> 
> This patch is against nvme-5.13
> 
> BTW, checkpatch complains with
> 
>   WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not
> preferred. Consider using octal permissions '0644'.
> 
> Is this something we want to adapt to?
> 
>  drivers/nvme/host/core.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 40215a0246e4..c8de0e37c7d9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3696,6 +3696,36 @@ static ssize_t
> nvme_ctrl_reconnect_delay_store(struct device *dev,
>  static DEVICE_ATTR(reconnect_delay, S_IRUGO | S_IWUSR,
>  	nvme_ctrl_reconnect_delay_show,
> nvme_ctrl_reconnect_delay_store);
>  
> +static ssize_t nvme_ctrl_fast_io_fail_tmo_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +
> +	if (ctrl->opts->fast_io_fail_tmo == -1)
> +		return sprintf(buf, "off\n");
> +	return sprintf(buf, "%d\n", ctrl->opts->fast_io_fail_tmo);
> +}
> +
> +static ssize_t nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t
> count)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	struct nvmf_ctrl_options *opts = ctrl->opts;
> +	int fast_io_fail_tmo, err;
> +
> +	err = kstrtoint(buf, 10, &fast_io_fail_tmo);
> +	if (err)
> +		return -EINVAL;
> +
> +	else if (fast_io_fail_tmo < 0)
> +		opts->fast_io_fail_tmo = -1;
> +	else
> +		opts->fast_io_fail_tmo = fast_io_fail_tmo;
> +	return count;
> +}
> +static DEVICE_ATTR(fast_io_fail_tmo, S_IRUGO | S_IWUSR,
> +	nvme_ctrl_fast_io_fail_tmo_show,
> nvme_ctrl_fast_io_fail_tmo_store);
> +
>  static struct attribute *nvme_dev_attrs[] = {
>  	&dev_attr_reset_controller.attr,
>  	&dev_attr_rescan_controller.attr,
> @@ -3715,6 +3745,7 @@ static struct attribute *nvme_dev_attrs[] = {
>  	&dev_attr_hostid.attr,
>  	&dev_attr_ctrl_loss_tmo.attr,
>  	&dev_attr_reconnect_delay.attr,
> +	&dev_attr_fast_io_fail_tmo.attr,
>  	NULL
>  };
>  

Thanks.
Reviewed-by: Ewan D. Milne <emilne@redhat.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
