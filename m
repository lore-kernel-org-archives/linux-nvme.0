Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739CBC47089
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 20:18:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32926613BF
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 20:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32926613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uLRP0qHl49ZnmthNMlQUhk5fxVUHiRKF/wwZAgN+E2w=; b=cLpm8SH9v/heFu
	W1rZ9ZnzsiiDWuX0E4WDvnHRBcFngmhH2Yy3BQtNE4Lj66xGnC8zUcx8RZExkreqFb4qG/XgQp01h
	l87DFg0ik5sKzXT0EZ7+ewMyhYqrZG3/htJi6VyMWq7XSfGqQNthIHuuT3sDjDXrGAvQeJHgp8hzb
	azetYYjVRcPsGawZRZtkueOvjQYSpe3TUtrb2ulG6WZ5Qv50wKJdk3tQ3hgvxWDgtVMRVBFccqpN/
	kCXUfAuBDLrRCXuAY5XHoD1Aady3EByJVtRV+rQ0fct5IxjeloNCNqVQxWim6VOGbxTzzK5Z2yFc1
	W2LBqL70VuEQaaTmSE3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llzyn-00HKgn-NT; Wed, 26 May 2021 20:18:13 +0000
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llz9Y-00GwEt-3b
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 19:25:17 +0000
Received: by mail-io1-xd2c.google.com with SMTP id r4so2223777iol.6
 for <linux-nvme@lists.infradead.org>; Wed, 26 May 2021 12:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=izmyF5lXZ6T+Ih81ROoFBWGYSX359TfngCEeuMk/7tw=;
 b=kMT8SVDJjaBto+io7zebuCCqledUf8nh4myBvhiKUjQphfgDe7/5JIOaMq3TeL2vli
 lGZSIEPGc5X7c2WAvwLO0tfc2FNWGgydkFVNt02Ogh4fov63BJn270+3sWaPdKFGgM0Z
 TeSGT3og1EXgFByRnd3ZSqx1UxiS33o0w7vjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=izmyF5lXZ6T+Ih81ROoFBWGYSX359TfngCEeuMk/7tw=;
 b=Ww9llosk5sfu7L8JNe7h27ZmjqS1RWeVubS8GkF7v+0Q6/Av5z3Eee9Fw0n2MOW0tN
 TsdH3MeCr9aIl4cfq4F8l3GQWLxa430IbOT4dWip1/g4sTTcoSwVWsfQ9n9k0934OWad
 OJoYVkg91ZSrjnJpU8Rvom9IsKO1dRxxhwNCTBIbFXk9pYzir5cgELi0GMVMCdvxZhXV
 /k9fehlvj55lDId+UKZM/28vpfmz/n2WcuOqNOAl7zrXZyHXUauk3azk7ae4NcqNezj5
 nsTX25lwyFthTA77ubaJICsk0lEFveOWXq4n5msepuRmjwffs5Olr8P7SHYhBvNSnt2M
 2/vw==
X-Gm-Message-State: AOAM530n1+dSL3xERN+fpP/9cwxD2VFVppHYuZLkl/TcxFjTNi/OcO1i
 q36v+LWBlUHf+UP/hG85wGdZzw==
X-Google-Smtp-Source: ABdhPJxCtegg75Nne7R6DXMK3EvcaNHbzYsgBnTRD663faG7Iz3QuT5u01nw0IQsC+K5QxYFkrdv2A==
X-Received: by 2002:a02:b78c:: with SMTP id f12mr4804493jam.7.1622057114750;
 Wed, 26 May 2021 12:25:14 -0700 (PDT)
Received: from google.com (h184-60-195-141.arvdco.broadband.dynamic.tds.net.
 [184.60.195.141])
 by smtp.gmail.com with ESMTPSA id b189sm113428iof.48.2021.05.26.12.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 12:25:14 -0700 (PDT)
Date: Wed, 26 May 2021 13:25:12 -0600
From: Raul E Rangel <rrangel@chromium.org>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, kbusch@kernel.org, axboe@fb.com,
 hch@lst.de, sagi@grimberg.me, dan.j.williams@intel.com,
 shyjumon.n@intel.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH V5] drivers/nvme: Add support for ACPI StorageD3Enable
 property
Message-ID: <YK6gmAWqaRmvpJXb@google.com>
References: <20200702225011.10932-1-david.e.box@linux.intel.com>
 <20200709184333.6241-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200709184333.6241-1-david.e.box@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_122516_218868_F279704D 
X-CRM114-Status: GOOD (  24.57  )
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

On Thu, Jul 09, 2020 at 11:43:33AM -0700, David E. Box wrote:
> +#ifdef CONFIG_ACPI
> +static bool nvme_acpi_storage_d3(struct pci_dev *dev)
> +{
> +	const struct fwnode_handle *fwnode;
> +	struct acpi_device *adev;
> +	struct pci_dev *root;
> +	acpi_handle handle;
> +	acpi_status status;
> +	u8 val;
> +
> +	/*
> +	 * Look for _DSD property specifying that the storage device on
> +	 * the port must use D3 to support deep platform power savings during
> +	 * suspend-to-idle
> +	 */
> +	root = pcie_find_root_port(dev);
> +	if (!root)
> +		return false;
> +
> +	adev = ACPI_COMPANION(&root->dev);
> +	if (!adev)
> +		return false;
> +
> +	/*
> +	 * The property is defined in the PXSX device for South complex ports
> +	 * and in the PEGP device for North complex ports.
> +	 */
> +	status = acpi_get_handle(adev->handle, "PXSX", &handle);
So I'm curious why we need to directly look at the PXSX and PEGP
devices instead of the ACPI_COMPANION node attached to the pci device?

I've looked around and I can't find any documentation that defines the
the PXSX and PEGP device names.

I've dumped some ACPI from a system that uses the PXSX name and
StorageD3Cold attribute:

    Scope (\_SB.PCI0.GP14)
    {
        Device (PXSX)
        {
            Name (_ADR, 0x0000000000000000)  // _ADR: Address
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }

            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("5025030f-842f-4ab4-a561-99a5189762d0"),
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "StorageD3Enable",
                        One
                    }
                }
            })
        }
    }

It looks to me like it's just the firmware node for the NVMe device
attached to the root port. Is that the correct assumption?

I'm wondering if we can simplify the look up logic to look at the
ACPI_COMPANION of the pci device?

The reason I ask is that I'm working on enabling S0i3 on an AMD device.
This device also defines the StorageD3Enable property, but it don't use
the PXSX name:

    Scope (GPP6) {
        Device (NVME)
        {
            Name (_ADR, Zero)  // _ADR: Address

            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
            {
                ToUUID ("5025030f-842f-4ab4-a561-99a5189762d0"),
                Package (0x01)
                {
                    Package (0x02)
                    {
                        "StorageD3Enable",
                        One
                    }
                }
            })
        }
    }

The Windows
[documentation](https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro#d3-support)
makes it sound like the _DSD should be defined on the PCI device.

I can send one of the following patches depending on the feedback:
1) Additionally check the pci device's ACPI_COMPANION for the _DSD.
2) Delete the PXSX and PEGP lookups and only look at the pci device's
   ACPI_COMPANION.

> +	if (ACPI_FAILURE(status)) {
> +		status = acpi_get_handle(adev->handle, "PEGP", &handle);
> +		if (ACPI_FAILURE(status))
> +			return false;
> +	}
> +
> +	if (acpi_bus_get_device(handle, &adev))
> +		return false;
> +
> +	fwnode = acpi_fwnode_handle(adev);
> +
> +	return fwnode_property_read_u8(fwnode, "StorageD3Enable", &val) ?
> +		false : val == 1;
> +}

Thanks,
Raul

p.s., Sorry for the second message, I somehow mangled the headers in the
first message and dropped the Message-Id.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
