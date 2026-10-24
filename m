Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4351606A31A
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Oct 2026 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ct1OneBM;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YWwzvwzI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=KOufyIqj5ml4Op5dlewXCJT0MbIMefl0mDB0TdLJeOQ=; b=ct1OneBMTJRd/ucrkJfqfpHzhS
	ylDO6F1qJvcfvxreovHKZKzW1xkWDOG9swC1lXJ1bAgqiyVtWlJ9N2kMHalBd3FAf59o4ccRuaLQI
	HRxNlzx8crIPoIFhO1wb9IiiVc0r73ekzfGBzTPVbIVpREj04IpYRa8qBcjUgVSbjqJQZuxLec1e3
	3KliiXk+q0WQ1z7Fl5GVrKOQdOSKMcvIyHqtlJnVE3Ql+O/qW2kXYyItQOIaR11dyc7EIYEGy2oxD
	WTnnv/GL1nETv7gov/wH3G3Z/CLmT2p6csrmcgqXMjjAzhqyl2Oekb+w2RhyfqZYpIr5cJ1hRDmDV
	NZt6Xicw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKZ8R-0000000065n-0Yvy;
	Sat, 24 Oct 2026 10:37:59 +0000
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKZ8J-0000000065N-2OZS
	for linux-nvme@lists.infradead.org;
	Sat, 24 Oct 2026 10:37:53 +0000
Received: by mail-dl1-x1233.google.com with SMTP id a92af1059eb24-1438d9363fbso1138975c88.0
        for <linux-nvme@lists.infradead.org>; Sat, 24 Oct 2026 03:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792838270; x=1793443070; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KOufyIqj5ml4Op5dlewXCJT0MbIMefl0mDB0TdLJeOQ=;
        b=YWwzvwzI78br1zKTPoH5mvzL+Ioy1tBexJ28bioQakk3u7pcTRUq4HSMscp/Ji/JIk
         pCxisAP/1UaMgkmDS7T5ljT14ey89uaSYjRx5TCM6pO9MJnaYg7tVFSsmzTZje5jCzVh
         TZlMooO1W4UK61oqWq4ZkTM+1n7Q9Dnr6Mg7XZAG8VAH9nuhq/PPLHeDKgnfXr3hGqXJ
         pscFRC5Ns0kZSycQ/RDrm9VG+0gzNRd2+LR1GDM6X24ETeDCILsWNxMALrRvwwJ4MtbO
         h+vGbCrs9MiMEI5pJzay2RnBnW1Ig/vgYj30HXvfVUciH4QDvLzyJ17TOrOjbjDv6OvP
         lo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792838270; x=1793443070;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KOufyIqj5ml4Op5dlewXCJT0MbIMefl0mDB0TdLJeOQ=;
        b=Leedsx2/9N4b0R+4lzp0g1uMVO2o31fMe7pwatVcZLVZcpVj0hvJVpXuzibReqnFDl
         2/ckZjyQDYrT4UGOHwpRgCAzAv6m95mJSDcqjoMPkDnWFqph1XxSTs20rCeUWmTLOCYs
         OC6hwXOjtp7JbuNofLGu4HE1Y0lTG2v7JryW5DPu16KqYmcOMAisml+cax+jCsfTZsC0
         viaE9vWPBS4uvQ3RcHtU6Ii4R4Bb+VusTC2lyLNNr7+hlU3w6BCMTlLvFryGq2V8Qu/0
         hraMC/kzB26qMAGXc26euUPetONWSrQtSGD0igK8z9PtlByCrR614VeO8QeT/BwrKMAA
         0OeQ==
X-Gm-Message-State: AFq9FYLDS2+AobxyxNmlVvdF31TjgyLZkl68FZ0iprbarvDP4e051Al/
	t5lGJA5RHIzYM8noPCU5T+p18eTQ6ub2Uis6uqzPGanIXISBywo+8n9fKgv+P1o+ACA=
X-Gm-Gg: AYBFou3Tpe++7rn60qNOtjDUHp5ryecVYsSfzaAXiZw3+9biFmnfDY4Nvc9+DET7gId
	U1XEjMQcRijhuD3tkAt5hxkH8LeOHziGeCijUXbfSWmkoMqldRYh/jY+id0oKbrTCojcsRRoJYf
	1qWKAdVr0zxdusIoIe4XUgCs1WR5N0w6nUWRQGR/eyrOigdDUhYSGJKBu7PAIlFSxAP8PV2kBQk
	bB5hk9cw1cbHyjzO3nycXSwQsaCiGqZnYEN0j8tTVzYokJXJyAcnKQxFyEI2zra9YvQ66RlwrNF
	qnMIy64Hcg2nkg8//e3lJeh4gSt2iyfKpTslP75xL6U4X49NXBMRjjD008AqojXkoLPX2H5MxlZ
	yk594+eTRLUucBBzVLjg2HjfEnUssefprVGqne6512+HvPbvwVrJlYgkFPrH7gwq413UEKaXtuK
	2RRVq3ydve5bYdWZFZ1bUxZY+TowRIiOoM0ODL95TWFyHHByatJmgfxVM5KU1fI8sxHUR3Tvzva
	2oFQDeV94f4bPzo4AQpxTiiikkIHFYEbQTpOB3vXOPMz/pVi6Enf50oVYB3/LNlmSaxP1rIAw==
X-Received: by 2002:a05:7022:fe08:b0:187:8a2a:353b with SMTP id a92af1059eb24-199344cca1emr2581135c88.6.1792838270263;
        Sat, 24 Oct 2026 03:37:50 -0700 (PDT)
Received: from [10.0.2.15] ([136.226.244.189])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a1bfaebfsm6153234c88.15.2026.10.24.03.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 03:37:49 -0700 (PDT)
Message-ID: <ec1327b1fcad832c065db8aad1b987ff6437cc2f.camel@gmail.com>
Subject: Re: [PATCH v3 3/3] nvme: document the service-time iopolicy sysfs
 attributes
From: Martin George <martinus.gpy@gmail.com>
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner
 <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Date: Sat, 24 Oct 2026 16:07:45 +0530
In-Reply-To: <20261023070243.2495522-4-kanie@linux.alibaba.com>
References: <20261023070243.2495522-1-kanie@linux.alibaba.com>
	 <20261023070243.2495522-4-kanie@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261024_033751_615325_869236F8 
X-CRM114-Status: GOOD (  10.99  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 2026-10-23 at 15:02 +0800, Guixin Liu wrote:
> =C2=A0		Shows or sets the multipath I/O path selection
> policy for
> =C2=A0		this subsystem. Accepted values: "numa", "round-
> robin",
> -		"queue-depth". Changing the policy clears all
> current path
> -		selections. Only available when
> CONFIG_NVME_MULTIPATH is
> -		enabled.
> +		"queue-depth", "service-time". Changing the policy
> clears
> +		all current path selections. Only available when
> +		CONFIG_NVME_MULTIPATH is enabled.
> =C2=A0
> =C2=A0What:		/sys/class/nvme-subsystem/nvme-subsysX/subsystype
> =C2=A0Date:		September 2021

Same nit as before. Looks like only the iopolicy documentation is
updated above with the new 'service-time' policy, but not the
iopolicies documentation. Have you drafted these patches against the
latest nvme-7.4 branch itself?

-Martin


