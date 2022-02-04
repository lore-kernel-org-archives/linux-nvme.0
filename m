Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1E0C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Feb 2022 07:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WCyPc6fF77iohN966bb+9nbQzr+9g9cqXx0DScTo/M4=; b=ZgzcW8pNaQvBlusautMakQmL0S
	bi1npP3O8m0cV8SICTj9GAiU6qzPu50UsXbrepIKezZJ0QAY2fSN/lcYO4STzETLqI0zHsIqG4VBc
	5Eu2KHk6i0txZFlbkeQZyPhYzvPR0jyUjpsqkP4UFHb9KuMop+4n+zj9HmjKxBxleiC95FOU9rHC2
	rKmGAYsAAvmRRqmtODUk52nnp18Em45DxEQ6E0lViqozCeHupTLUOtHcbKLsvS6euS8y7I+uj5YJJ
	OTHFeX1pPB5FIqV6hTy+2BYBeDnAtgnRPdTBnqH4qJl009Jdg30L6Fd+ww2kP0owE5lI6KMRWIy3O
	OnlkrgMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFtEp-003gQv-EW; Fri, 04 Feb 2022 07:42:35 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFtEm-003gQW-3K
 for linux-nvme@lists.infradead.org; Fri, 04 Feb 2022 07:42:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id BF276B83600;
 Fri,  4 Feb 2022 07:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C66C004E1;
 Fri,  4 Feb 2022 07:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1643960546;
 bh=EOfJ00PsV8mdw48XYSEmEkXUQJcxy2RhvtN0oG9P+Ck=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zcHDJUwru6fkFj5FCu5FYeiYtMnQaiaMeFjIDfCF9sj96349UKOxXVBWiTejyK2Dj
 aav5cSB5OdMkaU1QpdSN7NXeRWCKNeya3ALKvZ+3XZAnr8AxpE0LzlF1K/DJkB2S2y
 QVXsifH+Nn7jh8Kf7xxH0QRmnE8BlIRmePNZwYKw=
Date: Fri, 4 Feb 2022 08:42:15 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Martin Belanger <nitram_67@hotmail.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hare@suse.de,
 axboe@fb.com, hch@lst.de, sagi@grimberg.me, rafael@kernel.org,
 charles_rose@dell.com, stuart_hayes@dell.com,
 Martin Belanger <martin.belanger@dell.com>
Subject: Re: [PATCHv2 2/3] nvme: Add device_update_groups()
Message-ID: <YfzY1/LeVNCSdWs2@kroah.com>
References: <20220203211748.27542-1-nitram_67@hotmail.com>
 <BL0PR13MB42916EA4483338B4BD37BA3E9C289@BL0PR13MB4291.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR13MB42916EA4483338B4BD37BA3E9C289@BL0PR13MB4291.namprd13.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_234232_329875_54040983 
X-CRM114-Status: GOOD (  20.77  )
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

On Thu, Feb 03, 2022 at 04:17:47PM -0500, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> This is used to update the sysfs groups after device objects are fully
> initialized.

Ick, no, why?

What needs this and how is userspace going to handle groups changing
after the device is already announced to userspace?


> 
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>  drivers/base/core.c    | 28 ++++++++++++++++++++++++++++
>  include/linux/device.h |  1 +
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 3d6430eb0c6a..0b5f6d5d2459 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4473,6 +4473,34 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
>  }
>  EXPORT_SYMBOL_GPL(device_change_owner);
>  
> +/**
> + * device_update_groups - update the sysfs groups
> + * @dev: device.
> + *
> + * Returns 0 on success or error code on failure.
> + */
> +int device_update_groups(struct device *dev)
> +{
> +	struct class *class = dev->class;
> +	const struct device_type *type = dev->type;
> +	int error;
> +
> +	if (class) {
> +		error = sysfs_update_groups(&dev->kobj, class->dev_groups);

So you added new groups based on the class for the device after it was
registered?

That feels really wrong.


> +		if (error)
> +			return error;
> +	}
> +
> +	if (type) {
> +		error = sysfs_update_groups(&dev->kobj, type->groups);

How can the type groups have changed for the device after it was
registered?

What problem are you trying to solve here that requires this?  How are
you changing the groups for a class or type after a device is
registered?

confused,

greg k-h

