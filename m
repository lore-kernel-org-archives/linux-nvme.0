Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4076BE9A047
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Feb 2026 17:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wgBaqBCJjhUtnx4dsmUK37qc4M3rfF8Symkw4fl4b3o=; b=3yZA8y/qE+3xEuULcjomiLHQHB
	6kzEx64aM37MlEOBFj8oxRyhhouq9NwPOyG22t8fZ5bDcSI1BXFMDqGyMhwqGxF2WXtztFWHRURzM
	GtLVmZAlXllZsJbchc9tSrBLjkN47VMzTpAZVLur5KKAW26dHBISwGjiT40KUtXlJuqXFPjxvTGKy
	J/Yw5El2eNA9EkE11pHzVjXOQ0XrJ1hOSicGDorWfZEF8FftKuJC0mRZd+KZHP+U3XN4TxOpq0Rit
	w6h+PFfYeYDf7svmmdcPPvlWbBCrvHozBnLXbjxOnvKgukWXYI6Diiz7REJjNG11pmLnwb/sXVhuv
	10xuDQ8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsllK-0000000ABw8-3iwK;
	Wed, 18 Feb 2026 17:54:58 +0000
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsllI-0000000ABvj-0Tf8
	for linux-nvme@lists.infradead.org;
	Wed, 18 Feb 2026 17:54:58 +0000
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso56146eec.1
        for <linux-nvme@lists.infradead.org>; Wed, 18 Feb 2026 09:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771437295; x=1772042095; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wgBaqBCJjhUtnx4dsmUK37qc4M3rfF8Symkw4fl4b3o=;
        b=WOXjWjDu1HdnD6xYOo5a5TRBwMMGnQUiUbfHiTae0LyZdWBeqzbdBbZry1WWbWqU07
         ql1bt+CUMlTgoNnWW503TAz8kDw5eNo+NjKf0+m00IcyTOBR4J52eGCy5E62eqYKSDig
         Vv7zmLm7acyueuE7Yso4nVm7S9nDTv61WDxJxxBTMm8eZKUqwy++kC9vFeLeWs+6UKVp
         FXyhfWdKexfBVC9cEmgsfQLAIhucyxnrEclDWsDb/Km6q50T6wmuY9JzsMx9apntFbbU
         ZRUMNKXAPGTpApYVBx2BhYvdvP4hLLlqLLHZYWr3IBIis2CMpnsKK9/rwOOL9DLNud3z
         kNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771437295; x=1772042095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgBaqBCJjhUtnx4dsmUK37qc4M3rfF8Symkw4fl4b3o=;
        b=PCT9Is9TponI+WaPlFIWMk6jm3V4IvTRBPHdycBYDiVEWuW4BgjtyQyCx1jZHeJlZt
         uI/IpgC3ELNRAou4W4v+/YHPIXgxmO0RH4i9E8D+wHSZlKwKcm1yN8uWlb0v2Ws1jWHO
         Xg6pDawbBvtblapxuuK2Vx9oXiUAuXqCkQda6zkJ+BOsC9/z7WkYjfHeRuJIE0AVknVZ
         s7PVnNogO+tkmtQCLnt3bRIlf2krJV3fcMquKkppQm6LYYyIFVJ8qsLHHJ9rv6m5FWUU
         6nX2OSj4DKFgu1SnCdCPzLpljWVlhP9AJsVXbzqwKddxxdD79mpnHhQulKeAFA/qlry2
         lpEw==
X-Forwarded-Encrypted: i=1; AJvYcCVy7WFitIuWapYbMhHA4H4c2y7dWn0JM4dYiA4QJQYGqymt06wic9c1+8GyWzDz5TDuQ+sWXjnPov0Z@lists.infradead.org
X-Gm-Message-State: AOJu0YyrZJU2PzM+5DLBQBCd3CgSWFY9hk8eR1yETNr1znZ1Y94Vgucd
	EqchMfseZEH7stJY/FOoBeKSXtaH0Xpi2/bXXTxtpgNVlzcmGNSj6acytA2Ibzlv1Ws=
X-Gm-Gg: AZuq6aKCfUMmNHxZbOPyOnCNqqdGFsvB0GtCZqmUML8PYVDelx/fjRD1a4n+Fnlkye+
	uGqORe9Vksfb7XLXDHsKw1qV8iQ5CFtAn1A3ILWZ4xXo4NLQ8LVFx4/rth4TEbImCc/TVgmri+2
	WspLZOwDFiD7Zn3WGlxWO8IR5k0xo3yHchfu/10A45nx4xkEQhSCKd73L7Toybrejyou6jpfzIw
	WJ5Ym0eFGKa9Q6Mxka2hdpBiR4yqRPFUhlMYYkrt0Eomb0wXRpCyAR7YbNhbFVzlLBY/6dH1HIN
	E05LlkPTu5RNlPVwBJiEIc34R3PvZV0WSc3os7RiimzmYWrwKJu5i0KUxSsJofEIJ/bPm6RZgXq
	jl7KIhyE1TO5X3nPkt7QBel/6OPBF6e/WhMpczinoTaw3cmBbjJuWyngGFpJQPUHLPHFEewZjuH
	tu7QEXjxvqW3VaTcl2ryjmrhckcpnXlCXhhxIvtg==
X-Received: by 2002:a05:7301:d1a:b0:2ba:8f0d:cfe with SMTP id 5a478bee46e88-2bac933a6femr7876457eec.9.1771437294523;
        Wed, 18 Feb 2026 09:54:54 -0800 (PST)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::68dd])
        by smtp.googlemail.com with UTF8SMTPSA id 5a478bee46e88-2bacb658fc4sm22063122eec.22.2026.02.18.09.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 09:54:54 -0800 (PST)
Date: Wed, 18 Feb 2026 09:54:52 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org,
	mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org, dwagner@suse.de,
	mlombard@bsdbackstore.eu
Subject: Re: [PATCH RFC 4/5] nvme: add sysfs attribute to change IO timeout
 per nvme controller
Message-ID: <20260218175452.GK2392949-mkhalfella@purestorage.com>
References: <20260212120951.79738-1-mlombard@redhat.com>
 <20260212120951.79738-5-mlombard@redhat.com>
 <20260217202553.GJ3435530-mkhalfella@purestorage.com>
 <DGI4FR7YBCQ3.28N1YY210A3PA@arkamax.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGI4FR7YBCQ3.28N1YY210A3PA@arkamax.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_095456_235204_224DB2E8 
X-CRM114-Status: GOOD (  20.58  )
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

On Wed 2026-02-18 14:28:03 +0100, Maurizio Lombardi wrote:
> On Tue Feb 17, 2026 at 9:25 PM CET, Mohamed Khalfella wrote:
> >> @@ -4169,6 +4169,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
> >>  		mutex_unlock(&ctrl->namespaces_lock);
> >>  		goto out_unlink_ns;
> >>  	}
> >> +	blk_queue_rq_timeout(ns->queue, ctrl->io_timeout);
> >
> > Given that io tagset->timeout has been initialized to ctrl->io_timeout
> > Do we still need the line above?
> 
> 
> Yes, the line is necessary. While the tagset is initialized with
> ctrl->io_timeout, that happens only once during tagset allocation.
> 
> If the user later changes io_timeout via sysfs, ctrl->io_timeout is updated,
> but the tagset->timeout remains at the old default value. I deliberately
> do not update tagset->timeout in the sysfs handler because the tagset
> lifetime is tied to the controller state (e.g., it may be freed during a
> controller reset). Attempting to update the tagset from the sysfs path
> introduces a race condition where we might dereference a pointer to
> a tagset that is being destroyed.
> 
> Therefore, when a new namespace is allocated (nvme_alloc_ns), the block
> layer initializes the queue using the stale tagset->timeout. We must
> explicitly override that with the current ctrl->io_timeout to
> ensure the new namespace respects the runtime configuration.

Yeah. I got it now. Thanks for the explanation.
It would great if there is way to update admin and io tagsets timeout.

