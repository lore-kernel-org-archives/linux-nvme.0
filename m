Return-Path: <SRS0=8Upu=34=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD998C2BA83
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Feb 2020 00:45:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F280222D9
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Feb 2020 00:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xe6+wt4Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="csK0axqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F280222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pSxm/1by0JbVBWnh6AELLWpCKmQ2axR43zM7kngAP80=; b=Xe6+wt4ZccTM54
	5wHttT6VaOS5sBzQKp2Le+bqjHGTc3Lj4cXhEWWI3Nx5lnSMIFvhX/KRTTnCY/lSgPqN/KnGHAiDo
	3ev5cep5CJTDzuyYbrN/Tj/tnuB5NDaIqPZXPWcWKDHD66UpUbnv1OLxCKYtJXUzw65RfXvFTbVTc
	Kt4CFYDiZKbZRKwaKHnQAcSCCobGRXu+F/LqjhtJptGwLSjIcvsa+ErnF9huofNngVj13ny0fLqkd
	y3WCTn1VtwnL/ohcD0iIbreFSTZHd8J1MKiQrG1qUUXcGqDFaN4UiNLYwAXnaGnQrIVREZZPMUGnz
	Hg829SK7RsaGu9rx16Hg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j0EFA-0002Iy-Oq; Sat, 08 Feb 2020 00:45:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j0EF8-0001dN-EQ
 for linux-nvme@lists.infradead.org; Sat, 08 Feb 2020 00:45:07 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D3FD8217BA;
 Sat,  8 Feb 2020 00:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581122704;
 bh=F5D+i6eb7nyZl3+fx+2q2e4163MiGXXRARAMA4FcS08=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=csK0axqN2QzFL5kpNmFwjjBGuEWEtH9dsu9vnL1E0/LCnVz9HBz0vWGIn83NqjZHN
 7991Vt9zvT2j4onMN3Mwb594E4f4EWeOF1mBVFqsAqSv6vpqcmGCYweaDzqT07MWbz
 JCHpVCbafK+5QFey/FfGdHeSfnvQP/pX6TtWWfVI=
Date: Sat, 8 Feb 2020 09:44:57 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/2] nvme: expose hostnqn via sysfs for fabrics controllers
Message-ID: <20200208004457.GA15482@redsun51.ssa.fujisawa.hgst.com>
References: <20200208002111.10220-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200208002111.10220-1-sagi@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200207_164506_513119_C0728B8B 
X-CRM114-Status: GOOD (  11.69  )
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
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Feb 07, 2020 at 04:21:10PM -0800, Sagi Grimberg wrote:
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

The code looks fine, but could you say more in the change log why this
is needed now?

> +static ssize_t nvme_sysfs_show_hostnqn(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n", ctrl->opts->host->nqn);
> +}
> +static DEVICE_ATTR(hostnqn, S_IRUGO, nvme_sysfs_show_hostnqn, NULL);
> +
>  static ssize_t nvme_sysfs_show_address(struct device *dev,
>  					 struct device_attribute *attr,
>  					 char *buf)
> @@ -3267,6 +3277,7 @@ static struct attribute *nvme_dev_attrs[] = {
>  	&dev_attr_numa_node.attr,
>  	&dev_attr_queue_count.attr,
>  	&dev_attr_sqsize.attr,
> +	&dev_attr_hostnqn.attr,
>  	NULL
>  };
>  
> @@ -3280,6 +3291,8 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
>  		return 0;
>  	if (a == &dev_attr_address.attr && !ctrl->ops->get_address)
>  		return 0;
> +	if (a == &dev_attr_hostnqn.attr && (!ctrl->opts))
> +		return 0;
>  
>  	return a->mode;
>  }

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
