Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E59DC5AD46
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 17:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wYQWJ7sjsBHehL0K3yC4xLqz7TpISWwGxuy6BgQlUPo=; b=0pKY9MalJM6nkzmY3vGDn0gvFQ
	aUiMEfDTdnVJlhveV2HjRjyZncpIw8bplr1+EApwS/qwR6bsajwnxM0uPyz3YiX3b15L3wPO7EEFF
	LyOe3y/Gju6kPWxtnPbGMi3A0XT7iazEykQvF1i7w3+X6via7NUBCgZYV1I+JQZ9DPCRvStNt1HRu
	ZjXwH7IbBusm/f6hkozyLZFlH+bk/PO+pE7cDweb/+CHHFWv2QGylzFyn9xVKftUXcwF4wQrsGBpG
	z0i0M+/zEGCP/0WjQKt9hPqdz96SluG77iuu7v27CKR25dNAHgWTI7X+XvCYczOZ300Y9T6vJGdo0
	++ttEIgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtUgz-0000000FPu3-0nEb;
	Fri, 20 Feb 2026 17:53:29 +0000
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtUgw-0000000FPtJ-3ICR
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 17:53:27 +0000
Received: by mail-dl1-x1229.google.com with SMTP id a92af1059eb24-127423bea4bso33398c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 20 Feb 2026 09:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771610006; x=1772214806; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wYQWJ7sjsBHehL0K3yC4xLqz7TpISWwGxuy6BgQlUPo=;
        b=LA9H87OpMOd3enQzkMWWNu02cOraQSj7Zm2M2x4sxbRTamQP5EE8nE7I1+zTsJJ+oI
         UaybHvoZS6awAXWb4DAGExK8zoBVcIJ6QP8wfhaPe4yC2ybsSNFvnqbCg6l8ve12pAdl
         UBn7v47cyRV4qZpssu3275Q5duKbRMIi6CVZnomDSzYM+Z/K2yB3035QVYf1w2v0Uhg0
         JXtnQJCa0lltJwhG9h5LjDKalBdSwf0cLu9gaMIMBFmHVZw1rE4xNVQuWfZYS2zdeokH
         RgVH5d1NZpTTkZHv62wXVEFX3LFLfWaHbFNzHBON9qHDT092fh/ymPo08HxsqulPBOYG
         Up7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771610006; x=1772214806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYQWJ7sjsBHehL0K3yC4xLqz7TpISWwGxuy6BgQlUPo=;
        b=YVGOpNHIMIwVUrWbg6vnD2s2Qyte2thLqgWTzRIUFztlp2JaADozCbIdFnW3RqSsRG
         V1YmwL9ZMoWqtAKiTNmoOiZzkECe7UcOnLqVYR7/waQ1d/R5Mv3eS7bjqovXIATxcH6a
         bZZuPHa8NNUtRSImWh7a7pgwr6oaD6GVHK7+AgJxBrrcymEVzpldAansWTxyz55GcSvt
         w5ETU137a6qSpvLBsDusjuzquLg2QwaRz3MBOvBr/bzdk3ARICN1YR8AGVHG0UxUSqec
         yeGjMMUcXkE14TlnZD2qdhZ75uEIqIAUxWRF/DKkrC7+4DI98ceX99cuOEVwqKNsmcTj
         Q6uw==
X-Forwarded-Encrypted: i=1; AJvYcCWPpjIZSLY9iKIyM2lMfcCZHH9DSMQ8VxadQsFOF6pQvRgQmTURxu1ayJaMFJX1aZVutJKx4WyiMKbq@lists.infradead.org
X-Gm-Message-State: AOJu0Yy7ja1OKOS/v0Y8b/fi6sPAQnv+BrR/h5pamQuiA/SVaa19MwuY
	ENB+XRWx+QRiA+O2rPAFUtkcvBeUOP6qNpoGu1/TfYPyNshlMBiJHY7O/JI6iUAKzNI=
X-Gm-Gg: AZuq6aKJ9vnzqCcIto4mgro4ct8iJ6tPFfCndpQgteD2gyOE4LWDlHPgHhRik8gHG4c
	1o3njugUgnihgJ+varMueLECvthG3DhzYH3r9G0BQb1kgRBlYS4O/kCJKJ8paHZzLbaQrjoPwmM
	VnGOvCshSxynWvcJKiuXchqmhciy8Hmstvf+OUaV1Fb8SoOnGcaWv8vR/U5wJtDbteuRGc35vQt
	oQA3/4v1qdXLC2QlxfLx9dFwjpJArcg0MWH3eypRah28IrZMgdMMdXVrl7z6G1nG9BCF1EwGR6G
	aRB/0XVyDjW69iatjX2+5C1J7b1W+nFp9v42AuoTnpV/FklXk2GhQSCxl4NeDmBLQkKmU2/UdUt
	gAAZnknNTVIPcaJTnTdjJcLiciB52Gvu1EKWkfn7wc/+D7ssqLaA5j8Vi+shOhnyGrJI2dcZ8Ji
	4kgWLU8OrlNDBRvaU40iIWp7FWpFeuPxLDDrNC3uyG3dI=
X-Received: by 2002:a05:7022:698a:b0:11a:3734:3db3 with SMTP id a92af1059eb24-1276ad1d3damr203031c88.32.1771610005377;
        Fri, 20 Feb 2026 09:53:25 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-1276af102d9sm118291c88.1.2026.02.20.09.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 09:53:24 -0800 (PST)
Date: Fri, 20 Feb 2026 09:53:23 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org,
	mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org, dwagner@suse.de,
	mlombard@bsdbackstore.eu
Subject: Re: [PATCH RFC 4/5] nvme: add sysfs attribute to change IO timeout
 per nvme controller
Message-ID: <20260220175323.GL3435530-mkhalfella@purestorage.com>
References: <20260212120951.79738-1-mlombard@redhat.com>
 <20260212120951.79738-5-mlombard@redhat.com>
 <20260217202553.GJ3435530-mkhalfella@purestorage.com>
 <DGI4FR7YBCQ3.28N1YY210A3PA@arkamax.eu>
 <20260218175452.GK2392949-mkhalfella@purestorage.com>
 <DGJ42477U84O.MIIO0U7J75II@arkamax.eu>
 <DGJSTIHMGMV2.316EK4AH62YKU@arkamax.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGJSTIHMGMV2.316EK4AH62YKU@arkamax.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_095326_823890_854D13B9 
X-CRM114-Status: GOOD (  15.07  )
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

On Fri 2026-02-20 13:47:08 +0100, Maurizio Lombardi wrote:
> On Thu Feb 19, 2026 at 6:22 PM CET, Maurizio Lombardi wrote:
> > On Wed Feb 18, 2026 at 6:54 PM CET, Mohamed Khalfella wrote:
> >
> > So changing the timeout field in the tagset should be doable, the
> > only problem is avoid racing against nvme_alloc_ns().
> >
> > I will try to come up with something.
> 
> I decided to keep the current design, calling blk_queue_rq_timeout()
> with the namespaces_lock mutex locked is the easiest solution
> 
> I am sending a V2 in a few moments.
> 

How about restricting changing io timeout to LIVE controllers only. This
will make the problem easier to solve. Maybe something like the below?

	enum nvme_ctrl_state state;
	unsigned long flags;

        spin_lock_irqsave(&ctrl->lock, flags);
	state = nvme_ctrl_state(ctrl);
	if (state != NVME_CTRL_LIVE) {
		spin_unlock_irqrestore(&ctrl->lock, flags);
		return -EBUSY
	}

	if (ctrl->queue_count > 1)
		WRITE_ONCE(ctrl->tagset->timeout, timeout);
	spin_unlock_irqrestore(&ctrl->lock, flags);

	/* Take the namespaces_lock to avoid racing against nvme_alloc_ns() */
	mutex_lock(&ctrl->namespaces_lock);

	ctrl->io_timeout = msecs_to_jiffies(timeout);
	list_for_each_entry(ns, &ctrl->namespaces, list)
		blk_queue_rq_timeout(ns->queue, ctrl->io_timeout);

	mutex_unlock(&ctrl->namespaces_lock);


> Maurizio
> 

