Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7044CC7EE32
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jun 2025 00:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mM7sGDuaUNmv6tnGLKuSSjw44nHEP/uGSgdlFXfk7xk=; b=ACBXGanPHetmkZ42sbGO8NcFFu
	ORcV2xOM+QdDWwsvLZ303xFP65mID3v25mV02L1mZyOObQH0yTWNVn2RR0/NGxvZU9atOzEJirW8h
	qJWYnyS9Vp3BnNoP5eACbKX362xV6EV+XB+uP8dNqo+Q76Ar1sD+y76XUyfv7tp5Q2FDjHA6N4cY1
	ZxAJHb2JNQojxLqxUHpzhP9rjW/2HL2eEzhEaC4SeR7WLKpQz6PCRycXMxvlsYUJmVgIWUvIQDQgR
	UR0SFCugTND0gXhaOaLclv3GRMQ3l7jryXaEB/UvUKIG4jDG/yZat2uqqkkOOjBqTSGS2MQ8n89xs
	HgCkG5iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUxEj-0000000DER1-2J7Y;
	Fri, 27 Jun 2025 00:46:37 +0000
Received: from mail-pf1-x464.google.com ([2607:f8b0:4864:20::464])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUwad-0000000D9gb-2dfd
	for linux-nvme@lists.infradead.org;
	Fri, 27 Jun 2025 00:05:13 +0000
Received: by mail-pf1-x464.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so1540747b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 26 Jun 2025 17:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750982710; x=1751587510; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mM7sGDuaUNmv6tnGLKuSSjw44nHEP/uGSgdlFXfk7xk=;
        b=c1YAT/vNQ5+rJDi9mRdBzUZeeEnH8x4PYCq91RhOf4C/otJUiFIiQClBLC8a+xwHXj
         kgo2r6RvebLwq34L2x43QAiLUGq3s77QbWvB/2nETb0crGggJ4Wp12nlFQ4O3KA07IuV
         mCd0xo2dR4gTo9ptEtobdxiAU6KOuLSP8FLt858ojEpUiBIo9T+xH2Ik5ge0PdpuYnBO
         13hZzOQexUyRgvioUmUvUDhtM1Nq/ua6P2c77uLSB8Zr/xZJzhb7PrYpAOYxVuRmQeSW
         yCMEoO/PmicygUzL3V8XrfupJL0TL3se/qGo9LwFv/Pn2MsyLeOeWq72Vm5j+eIDX5Tc
         n/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750982710; x=1751587510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mM7sGDuaUNmv6tnGLKuSSjw44nHEP/uGSgdlFXfk7xk=;
        b=KQpEdlvrP/oUR5u4CUGitogcp8rnwb5pJQXeJ94Sl+S/CBuAWXU5sfDeCGtMdZ0+F7
         sR1L6D9kIwt7vAuGfWaystUqnXWfRGl4ILe+1cz8GgHliX3OIzV/nq4K4/PZ6K9Xij22
         wuTacSt5fcDQGe/+MbO76t/kJhU95VZioOuHSQrl/4xCs+GscihKqKv8mOX+HVDffNE7
         u9rOjMpKqgq9h1nHnmqLc/f9tl3YLjRo1w6nuuR4/TdXJqWlhAF/z4hqEEHFzFYJ1Cte
         QDzOStjHn+qcI7o8iMbbNglwAgiFnBNCC1wQ1PkSvwxjpImDGtVvnGkyZfsjv2QLOQVb
         FchA==
X-Forwarded-Encrypted: i=1; AJvYcCU8+tow7ynoGd2+hDBBUd3JWHIIeNBfirlN4lW42hRplNJmjlSE7cZOjD5kIh/1zssH6zbP3BL0Ge4P@lists.infradead.org
X-Gm-Message-State: AOJu0YyXrvTHmNffHhcWECEHzxeTQsScFnRrDUKi7nrfMGoXvIOu796R
	chZc9+v/0iLlOc69vEaYLL9luhpx0BtXe//CVM7kzcXxdGRosR2UmC6nnpXqZSsopsKmHhRb1Rs
	pMRXPFHhteV23ltSfpVqecBiV4Ph+Y02pEdQHCQ8+dv0D7KW46rN/
X-Gm-Gg: ASbGncvqfFbpOZoUpppP5bKzaSnJPI9850Xy0FpzSv9jGTA92eC62zDKz7hzrscuEBD
	1JHcrmYouN1q3Fjpr+bzIAj+9wFhiHsgk4nM0saXkf4pkQ6vcl2sunoIDYS5ZzodKTF5JlZNSE7
	htL/L1x4b/b2FhV9qrrfY6l4KrBxhd4mlO+i2Ocva/MgxEUX3AlDxXy6Yjk8Fv5GDYZq4hizwh5
	0x8aCXF73sXk2Tnwoo5916+LFLWwWY8n9tx7ZcHQxRM31OTKkl+eOT9xNxU+YwAMD8FD8BzTXiY
	ehHel/i2IGTPuOqIU+qiTEEPNeGYcPTackXv2ygwLA==
X-Google-Smtp-Source: AGHT+IHj6XU3bYpiDVFxkemutKiyBWj0MTJkiVJwqhOHiDSdfqRNl3Zly1KVAPf3JX8o4RPeim1TDJIXUPv8
X-Received: by 2002:a05:6a20:12d0:b0:1f3:31fe:c1da with SMTP id adf61e73a8af0-220a0cf7360mr1389252637.11.1750982710253;
        Thu, 26 Jun 2025 17:05:10 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-74af540cc8csm49210b3a.1.2025.06.26.17.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 17:05:10 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3E03034027F;
	Thu, 26 Jun 2025 18:05:09 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 4DB31E4190F; Thu, 26 Jun 2025 18:05:09 -0600 (MDT)
Date: Thu, 26 Jun 2025 18:05:09 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
	Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 2/2] nvme: fix atomic write size validation
Message-ID: <aF3gNWvBaPpATiI+@dev-ushankar.dev.purestorage.com>
References: <20250625064003.436582-1-hch@lst.de>
 <20250625064003.436582-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625064003.436582-3-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_170511_837241_0B63255C 
X-CRM114-Status: GOOD (  32.18  )
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

On Wed, Jun 25, 2025 at 08:39:56AM +0200, Christoph Hellwig wrote:
> Don't mix the namespace and controller values, and validate the
> per-controller limit when probing the controller.  This avoid spurious
> failures for controllers with namespaces that have different namespaces

nit: having namespaces with different logical block sizes

> with different logical block sizes, or report the per-namespace values
> only for some namespaces.
> 
> It also fixes a missing queue_limits_cancel_update in an error path by
> removing that error path.
> 
> Fixes: 8695f060a029 ("nvme: all namespaces in a subsystem must adhere to a common atomic write size")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>

I couldn't find the report on linux-nvme; if it is public, can you
include a "Closes:" link here?

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>

I also saw a problem in a system running on 6.16-rc3 with several NVMe
subsystems, each containing one controller with AWUPF=0, each containing
two namespaces with NSABP=0. One namespace has a 512-byte LBA size while
the other has a 4096-byte LBA size, and some namespaces failed to add:

# dmesg | grep Inconsistent
[    5.537494] nvme nvme4: nvme4n2: Inconsistent Atomic Write Size, Namespace will not be added: Subsystem=512 bytes, Controller/Namespace=4096 bytes
[    5.539038] nvme nvme6: nvme6n2: Inconsistent Atomic Write Size, Namespace will not be added: Subsystem=4096 bytes, Controller/Namespace=512 bytes
[    5.560079] nvme nvme7: nvme7n2: Inconsistent Atomic Write Size, Namespace will not be added: Subsystem=4096 bytes, Controller/Namespace=512 bytes
[    5.595093] nvme nvme3: nvme3n2: Inconsistent Atomic Write Size, Namespace will not be added: Subsystem=4096 bytes, Controller/Namespace=512 bytes
[    5.597627] nvme nvme8: nvme8n2: Inconsistent Atomic Write Size, Namespace will not be added: Subsystem=512 bytes, Controller/Namespace=4096 bytes
[    5.600007] nvme nvme0: nvme0n2: Inconsistent Atomic Write Size, Namespace will not be added: Subsystem=512 bytes, Controller/Namespace=4096 bytes
[    5.605748] nvme nvme5: nvme5n2: Inconsistent Atomic Write Size, Namespace will not be added: Subsystem=512 bytes, Controller/Namespace=4096 bytes
[    5.608961] nvme nvme11: nvme11n2: Inconsistent Atomic Write Size, Namespace will not be added: Subsystem=4096 bytes, Controller/Namespace=512 bytes
[    5.618011] nvme nvme12: nvme12n1: Inconsistent Atomic Write Size, Namespace will not be added: Subsystem=4096 bytes, Controller/Namespace=512 bytes
[    5.618251] nvme nvme10: nvme10n2: Inconsistent Atomic Write Size, Namespace will not be added: Subsystem=4096 bytes, Controller/Namespace=512 bytes

Note that despite the messages saying otherwise, only those log lines
containing "Subsystem=512 bytes, Controller/Namespace=4096 bytes"
actually failed to add a namespace - the others had both namespaces
added just fine. I guess it isn't deterministic as to which namespace
was added first.

Anyways, the problem was fixed by this patch set.

Tested-by: Uday Shankar <ushankar@purestorage.com>

> ---
>  drivers/nvme/host/core.c | 33 +++++++++++----------------------
>  drivers/nvme/host/nvme.h |  3 +--
>  2 files changed, 12 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 520fb5f1e214..e533d791955d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2041,17 +2041,7 @@ static u32 nvme_configure_atomic_write(struct nvme_ns *ns,
>  		 * no clear language in the specification prohibiting different
>  		 * values for different controllers in the subsystem.
>  		 */
> -		atomic_bs = (1 + ns->ctrl->awupf) * bs;
> -	}
> -
> -	if (!ns->ctrl->subsys->atomic_bs) {
> -		ns->ctrl->subsys->atomic_bs = atomic_bs;
> -	} else if (ns->ctrl->subsys->atomic_bs != atomic_bs) {
> -		dev_err_ratelimited(ns->ctrl->device,
> -			"%s: Inconsistent Atomic Write Size, Namespace will not be added: Subsystem=%d bytes, Controller/Namespace=%d bytes\n",
> -			ns->disk ? ns->disk->disk_name : "?",
> -			ns->ctrl->subsys->atomic_bs,
> -			atomic_bs);
> +		atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
>  	}
>  
>  	lim->atomic_write_hw_max = atomic_bs;
> @@ -2386,16 +2376,6 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>  	if (!nvme_update_disk_info(ns, id, &lim))
>  		capacity = 0;
>  
> -	/*
> -	 * Validate the max atomic write size fits within the subsystem's
> -	 * atomic write capabilities.
> -	 */
> -	if (lim.atomic_write_hw_max > ns->ctrl->subsys->atomic_bs) {
> -		blk_mq_unfreeze_queue(ns->disk->queue, memflags);
> -		ret = -ENXIO;
> -		goto out;
> -	}
> -
>  	nvme_config_discard(ns, &lim);
>  	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
>  	    ns->head->ids.csi == NVME_CSI_ZNS)
> @@ -3219,6 +3199,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>  	memcpy(subsys->model, id->mn, sizeof(subsys->model));
>  	subsys->vendor_id = le16_to_cpu(id->vid);
>  	subsys->cmic = id->cmic;
> +	subsys->awupf = le16_to_cpu(id->awupf);
>  
>  	/* Versions prior to 1.4 don't necessarily report a valid type */
>  	if (id->cntrltype == NVME_CTRL_DISC ||
> @@ -3556,6 +3537,15 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>  		if (ret)
>  			goto out_free;
>  	}
> +
> +	if (le16_to_cpu(id->awupf) != ctrl->subsys->awupf) {
> +		dev_err_ratelimited(ctrl->device,
> +			"inconsistent AWUPF, controller not added (%u/%u).\n",
> +			le16_to_cpu(id->awupf), ctrl->subsys->awupf);
> +		ret = -EINVAL;
> +		goto out_free;
> +	}
> +

Could you explain (and perhaps add a comment here) why all controllers
in a subsystem must report the same awupf? Is it because namespaces may
inherit awupf from the controller, and may be reachable through multiple
controllers for multipath?

>  	memcpy(ctrl->subsys->firmware_rev, id->fr,
>  	       sizeof(ctrl->subsys->firmware_rev));
>  
> @@ -3651,7 +3641,6 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>  		dev_pm_qos_expose_latency_tolerance(ctrl->device);
>  	else if (!ctrl->apst_enabled && prev_apst_enabled)
>  		dev_pm_qos_hide_latency_tolerance(ctrl->device);
> -	ctrl->awupf = le16_to_cpu(id->awupf);
>  out_free:
>  	kfree(id);
>  	return ret;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a468cdc5b5cb..7df2ea21851f 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -410,7 +410,6 @@ struct nvme_ctrl {
>  
>  	enum nvme_ctrl_type cntrltype;
>  	enum nvme_dctype dctype;
> -	u16 awupf; /* 0's based value. */
>  };
>  
>  static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
> @@ -443,11 +442,11 @@ struct nvme_subsystem {
>  	u8			cmic;
>  	enum nvme_subsys_type	subtype;
>  	u16			vendor_id;
> +	u16			awupf; /* 0's based value. */
>  	struct ida		ns_ida;
>  #ifdef CONFIG_NVME_MULTIPATH
>  	enum nvme_iopolicy	iopolicy;
>  #endif
> -	u32			atomic_bs;
>  };
>  
>  /*
> -- 
> 2.47.2
> 
> 

