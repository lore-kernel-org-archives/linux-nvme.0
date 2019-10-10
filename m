Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DD5C10F14
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 16:28:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CED72067B
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 16:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sBebstzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CED72067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JdS9er+2UtLQL0bzsV10xQ1nAUtGmklFPFu/GFmhc60=; b=sBebstzWkQYz4O
	7bSPV610/lZTgrDI3AydFFSBwyEn1stddiorY0e0UwmobCCvYLpRt/Ts/5iRKew1KosShu97FFc/U
	D0WCvTgiPdk3OVoTUnO0ZgoyosbJhfIfmpCRCNUF5Y2SvlmZKw1e/d0F9gUvHIQsy56VmdlyzC/0b
	1gFcodYxmjsBTgG+B3B8DhsNvuNt4PM4XkXZ0+a999aYbcuVcKvQM1fLpX4uNoO0JohfXh594qH/q
	IsiDVHbEr9mm9dBd5f325f7eG3MxJdkvv/GUMhsIf7cQq+k7fLKxm9DDv0zUM9WZjaa8zS+/O08Bt
	LWBfgY2Yy/RBX8R4FBIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIbJ0-0003Vw-HW; Thu, 10 Oct 2019 16:28:46 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIbIx-0003Uh-MV
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 16:28:45 +0000
Received: by mail-oi1-f194.google.com with SMTP id k9so5438242oib.7
 for <linux-nvme@lists.infradead.org>; Thu, 10 Oct 2019 09:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vR2xgB+PJ4hryKhIu/ABDp/zNbHr4xtzKP74nw4y8Ik=;
 b=dQy1f4UMSDzlriHKD9Mv1ETS358XKRmWqvkg+OyTNpTl995Z98kOyyYtms/0P2YZIB
 9RvC0rkCRHaeGH9FXQcY0uZUQkxrOqmyfpmsDSnw0vsmYXOxMVY8aV3/iGjTs+3BclUx
 +v//e3mQxpPkvPKJzOk4jpO+b+MzvN1zSJAElXkWzq5pYbXCJ1pUpYLvOdWG/WI3d31i
 lQh81AyvypDyMdWqW5dZVcQlGrEn/yGrnE5Pf9PdO6ubHcYOZxpGHxeZhue+W6kAytRt
 3pAlb+qxnGvYcdz/uvrN5jKsN+m3yPVh6rgOc1FmzkZHchBR7afni3q5m41kj9B+7Vg0
 wtOQ==
X-Gm-Message-State: APjAAAUFMomLj6zm9mYLWd43hEiUjyzs017ZWQXV33mdZ3j5wXEEPBEe
 vknY8mwK36fO89DvRkLL/fzyBeE8VJSHiHELqGk=
X-Google-Smtp-Source: APXvYqzbrJOhGfBWBTIglV05BZrFqcToiafb4MWI8sJuPR1PbO7wyzrGsiSbiAiZYgYzUUKgvZH6WdjUdOkyQrTiF2o=
X-Received: by 2002:aca:5885:: with SMTP id m127mr8546117oib.110.1570724920583; 
 Thu, 10 Oct 2019 09:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191010124746.2882-1-helgaas@kernel.org>
 <20191010124746.2882-2-helgaas@kernel.org>
In-Reply-To: <20191010124746.2882-2-helgaas@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Oct 2019 18:28:29 +0200
Message-ID: <CAJZ5v0i7EApH4rHjAqKJ1T96M57ONn+dNPUSwC9ZQ6UJi53Jqg@mail.gmail.com>
Subject: Re: [PATCH 1/1] PCI/ASPM: Remove pcie_aspm_enabled() unnecessary
 locking
To: Bjorn Helgaas <helgaas@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_092843_738462_A7D78F48 
X-CRM114-Status: GOOD (  19.24  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Mario Limonciello <Mario.Limonciello@dell.com>,
 Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 Keith Busch <keith.busch@intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>,
 Christoph Hellwig <hch@lst.de>, Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 10, 2019 at 2:48 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> The lifetime of the link_state structure (bridge->link_state) is not the
> same as the lifetime of "bridge" itself.  The link_state is allocated by
> pcie_aspm_init_link_state() after children of the bridge have been
> enumerated, and it is deallocated by pcie_aspm_exit_link_state() after all
> children of the bridge (but not the bridge itself) have been removed.
>
> Previously pcie_aspm_enabled() acquired aspm_lock to ensure that
> link_state was not deallocated while we're looking at it.  But the fact
> that the caller of pcie_aspm_enabled() holds a reference to @pdev means
> there's always at least one child of the bridge, which means link_state
> can't be deallocated.
>
> Remove the unnecessary locking in pcie_aspm_enabled().
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

(also for the further changes you and Christoph have been discussing).

> ---
>  drivers/pci/pcie/aspm.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 652ef23bba35..f5c7138a34aa 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1172,20 +1172,20 @@ module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
>  /**
>   * pcie_aspm_enabled - Check if PCIe ASPM has been enabled for a device.
>   * @pdev: Target device.
> + *
> + * Relies on the upstream bridge's link_state being valid.  The link_state
> + * is deallocated only when the last child of the bridge (i.e., @pdev or a
> + * sibling) is removed, and the caller should be holding a reference to
> + * @pdev, so this should be safe.
>   */
>  bool pcie_aspm_enabled(struct pci_dev *pdev)
>  {
>         struct pci_dev *bridge = pci_upstream_bridge(pdev);
> -       bool ret;
>
>         if (!bridge)
>                 return false;
>
> -       mutex_lock(&aspm_lock);
> -       ret = bridge->link_state ? !!bridge->link_state->aspm_enabled : false;
> -       mutex_unlock(&aspm_lock);
> -
> -       return ret;
> +       return bridge->link_state ? !!bridge->link_state->aspm_enabled : false;
>  }
>  EXPORT_SYMBOL_GPL(pcie_aspm_enabled);
>
> --
> 2.23.0.581.g78d2f28ef7-goog
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
