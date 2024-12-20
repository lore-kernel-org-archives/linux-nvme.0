Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC22CE77188
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2024 08:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MxscJpmY5uO8wZO4oXxpni8cg2MJMXxVI8cfdPWLHwM=; b=R0Uhqnep8B53DAQ9qx6jzSAn1j
	nGee2zlQw3xamcMxf9/PeQkW44gkCsnv9q3noXSdU2HWVpvs4U/j5RCr/Y5Cas5766kuzEWyKtR7I
	tRByHRXp5JFRB+jfQBKYNKP8vbjCK22x6KxVxXaBBPBs8KilTr+nR/144bZl0OPlLBcap0/sQWvjc
	cDLneeJWiJD8OREUpVpXEdtSff+7XOr2zuq64XXWPRXoiKxJ9pGsTo2V03lq+qQsVYWfLrdKnXmY4
	eQ0wYiT2n0jdH3BMyKNjFQpgHn3xJhFhGWlOb/KwdUnR2Bv5+VQBdCAwP+n6ofZ/cc7LERJnxLHlk
	LSZhB3+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOYBh-00000004Fmt-0T3u;
	Fri, 20 Dec 2024 08:16:45 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOYBe-00000004FmT-3jHD
	for linux-nvme@lists.infradead.org;
	Fri, 20 Dec 2024 08:16:44 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2166022c5caso13635635ad.2
        for <linux-nvme@lists.infradead.org>; Fri, 20 Dec 2024 00:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734682602; x=1735287402; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MxscJpmY5uO8wZO4oXxpni8cg2MJMXxVI8cfdPWLHwM=;
        b=K5N2GyF57LNcVHmuwR7ZOoRZHZ8/ZzJ+nTVfeQP5+oXiqCd0cSV+3llSU9Eo8nd3ql
         CoCBwCda1E1tma2+lp8iHrNfMw5SXqaigDDk2PnU81jq6jfKO/2vZM6jDFPC+zNW5ph2
         SuOvxrDS/H+Totdc3BOmjUGvdf9zD7dJmorxd5YsVhoMI3NessRFnwC2ThA8n6VdnO/j
         btztTNVG/ilcYxpZ0fbB94xiHAwlsV0xtigkkHaQfrFrtZq9fAfwbFZdp4/P68s6PegK
         dn5mzlHOAr5/AQC7njldSAnNLrhklRtg0vz8vtCmwuo9zhR+NQcvuA572Me3L5AsOrqz
         ovzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734682602; x=1735287402;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MxscJpmY5uO8wZO4oXxpni8cg2MJMXxVI8cfdPWLHwM=;
        b=L8OJwoD5SitM9/U7GcmCBo/p4lcpRJaLtp8PUta/jb53Ys7vfeHFxjRTnf5rzp1JWo
         qTS08ctAYd4yI/ss2ea4A9T/vGstYtFsRI/1fL9ihKV1d0HItnZq4Yx8F1akOUo6TP/y
         0LGzinN6/biD7HcskQiqLA+2ZAH36GuaTI5ZhecS/cvPSzk8v4yyxElqgaKw8c8Sc386
         BV9OpKSYN9+w/j+1IGrYSq+XsfZM1mHuuxC01XCi6nDmR2C6Aw6iUV1Xz9YJ4tMM3I1A
         iBVKyCF6hp+oxXVln591yXozezCtsUzO38zy27PoHk/xqrcTj1ixIY7zj9wHvAMXqat+
         zTTQ==
X-Gm-Message-State: AOJu0YyKLngdiBmF0kKBy/YhTts+Rrg3yQSXWf4GXC+ggyi0Y0AqDLax
	egpyWMaC4E2As+aJZpWpwZcO2TundE6ICRXBshyTBXPo9xoEHwDvbQM0bAE97A==
X-Gm-Gg: ASbGncv7xRKcgwCyR5CcY6SAf8NilO3u2rTlxlFhbfbjDkro+iina4otvYRDzPQu6hY
	AhW8860TVzkdanTvBuDc2ezDfd6bzpcIccAdlq57SxmTuigPSAak4MF1VYu6x5OsumgvRpzNhGP
	m8y5znbx9oBfAId/LjkICIn86nl1ZSQnzNzSKIl9XwTydDYH0QwjnTA0DFIgHfRKwhXHtRFfphh
	FLE6nhJnFl6rGC032Az71LhkJDhjH6ONURkrutp93IKT+YIHu43/t7QuqIzdaQKRhZi
X-Google-Smtp-Source: AGHT+IHhSWc6owgfOBNABUpmvDLdbZxY9kQiP35jiZs+r2gN3KlwlEQZ+m5Odj3KuGMUJ0r1Nfmypw==
X-Received: by 2002:a17:902:e542:b0:215:65f3:27f2 with SMTP id d9443c01a7336-219e6e8c9bamr24090475ad.8.1734682602113;
        Fri, 20 Dec 2024 00:16:42 -0800 (PST)
Received: from thinkpad ([117.193.209.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f7307sm23738985ad.195.2024.12.20.00.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 00:16:41 -0800 (PST)
Date: Fri, 20 Dec 2024 13:46:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v6 17/18] nvmet: New NVMe PCI endpoint function target
 driver
Message-ID: <20241220081635.oaudrom74yp6t7ej@thinkpad>
References: <20241220035441.600193-1-dlemoal@kernel.org>
 <20241220035441.600193-18-dlemoal@kernel.org>
 <20241220081229.pij52jwfdyeygux7@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241220081229.pij52jwfdyeygux7@thinkpad>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_001642_930367_2E773A63 
X-CRM114-Status: GOOD (  15.73  )
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

On Fri, Dec 20, 2024 at 01:42:29PM +0530, Manivannan Sadhasivam wrote:

[...]

Sorry, forgot to trim my reply.

> > +static void nvmet_pci_epf_clear_bar(struct nvmet_pci_epf *nvme_epf)
> > +{
> > +	struct pci_epf *epf = nvme_epf->epf;
> > +
> > +	pci_epc_clear_bar(epf->epc, epf->func_no, epf->vfunc_no,
> > +			  &epf->bar[BAR_0]);
> > +	pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0, PRIMARY_INTERFACE);
> > +	nvme_epf->reg_bar = NULL;
> 
> Memory for BAR 0 is allocated in nvmet_pci_epf_bind(), but it is freed in both
> nvmet_pci_epf_epc_deinit() and nvmet_pci_epf_bind(). This will cause NULL ptr
> dereference if epc_deinit() gets called after nvmet_pci_epf_bind() and then
> epc_init() is called (we call epc_deinit() once PERST# is deasserted to cleanup
> the EPF for platforms requiring refclk from host).
> 
> So please move pci_epf_free_space() and 'nvme_epf->reg_bar = NULL' to a
> separate helper nvmet_pci_epf_free_bar() and call that only from
> nvmet_pci_epf_unbind() (outside of 'epc->init_complete' check).
> 
> With the above change, I'm able to get this EPF driver working on my Qcom RC/EP
> setup.
> 
> - Mani

-- 
மணிவண்ணன் சதாசிவம்

