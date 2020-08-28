Return-Path: <SRS0=SY4p=CG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A523C433E2
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 19:09:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E24720776
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 19:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iepN2tGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E24720776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qcobuDznlC8ytin2beLIde8BFd2LMdLc6J049PCoMXQ=; b=iepN2tGi5tTCpat1ZV4iX9m46
	9XIF9ttogmUhZKI6+rrTg5QM8Cb6+ntEzfKoQRN8Z0R0iBGKqJUIwtYr7KlaoNBzyXmC/f3GmxUqf
	F1FGOEcHhGhwSvXKS3VWHbpmG6U15arif/PVhdPqMbsT6jLba+qmSSLtSK/3QVtuRuVdIibm5dvbo
	brrp9P2aBoLgn4pIRq4u0LuSjb5yg4FEITBaUCKyvuZ+Cms4tFsqNNOjnex98naq30AzRm8CxEH9+
	fznfrkCCiUmQMcq92Jeel4xuu9Z7FwjKq/OaMznlYHhmD1z0xsh48AfiJkqpxJ2VrjPZzpHJPNvpk
	4TGFswZNw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBjk9-00065q-69; Fri, 28 Aug 2020 19:08:57 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBjk7-00065R-6l
 for linux-nvme@lists.infradead.org; Fri, 28 Aug 2020 19:08:55 +0000
Received: by mail-pf1-f193.google.com with SMTP id k15so1101648pfc.12
 for <linux-nvme@lists.infradead.org>; Fri, 28 Aug 2020 12:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XM8dt+Eo2K0S9fXx+j818YEhd/W3DzDGMLAUALGK5fw=;
 b=blbEBhxZgJK9kCrFhRR3iwW1saJ5BqYv3bUAgO01OZ2OvuTpKfQDtYU4MHH6QraXqz
 jDm5xoXtpZhfGgZEOZEevn/xWgSnkakVVDyAsb4hZGb0Pvznzb5TyLySkoCSjbvkTObG
 hRVuaOf900rVaUUX2CvndHlbiqEab9FoL+VrrFHzBHJjGDywN1wFuZyo0GvKn72h3P4u
 Z99McfgH0qrQKE3jbLSFdrHkkiG2zcJxujJ4Npb3KeoNLJusnZhq1hs/USnYc2Y84mCh
 ayn0zxH8Y+ise6a3XEwHKmyB7IflX/1116UtwcOCli92O7HB60ugzlccOzwrU3xZ7yLf
 tCMQ==
X-Gm-Message-State: AOAM530W4Gbl7SWfqFyVS8I36cFl3zEsYRxFatxFQdkhzSQCyRAR3Gmo
 kpbk3m6RRs4PfeV5R0q4dSk=
X-Google-Smtp-Source: ABdhPJw3fNGYkWJlxTYNNAfR9zKd2lAO+Ga5l/So2hSewQFnDJPIFzyi9BIUwWiqaXd6RC4CajDxMQ==
X-Received: by 2002:a65:60ce:: with SMTP id r14mr180818pgv.85.1598641729827;
 Fri, 28 Aug 2020 12:08:49 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:c4b8:3871:4bc4:154f?
 ([2601:647:4802:9070:c4b8:3871:4bc4:154f])
 by smtp.gmail.com with ESMTPSA id c5sm248462pgj.0.2020.08.28.12.08.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 12:08:49 -0700 (PDT)
Subject: Re: [PATCH] nvme: Revert: Fix controller creation races with teardown
 flow
To: James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org
References: <20200828190150.34455-1-james.smart@broadcom.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0867c437-1521-c0c9-d7fa-6a615d88105a@grimberg.me>
Date: Fri, 28 Aug 2020 12:08:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828190150.34455-1-james.smart@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200828_150855_273463_63F02FA8 
X-CRM114-Status: GOOD (  20.94  )
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
Cc: Keith Busch <kbusch@kernel.org>, Israel Rukshin <israelr@mellanox.com>,
 Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org,
 Max Gurtovoy <maxg@mellanox.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> The indicated patch introduced a barrier in the sysfs_delete attribute
> for the controller that rejects the request if the controller isn't
> created. "Created" is defined as at least 1 call to nvme_start_ctrl().
> 
> This is problematic in error-injection testing.  If an error occurs on
> the initial attempt to create an association and the controller enters
> reconnect(s) attempts, the admin cannot delete the controller until
> either there is a successful association created or ctrl_loss_tmo
> times out.
> 
> Where this issue is particularly hurtful is when the "admin" is the
> nvme-cli, it is performing a connection to a discovery controller, and
> it is initiated via auto-connect scripts.  With the FC transport, if the
> first connection attempt fails, the controller enters a normal reconnect
> state but returns control to the cli thread that created the controller.
> In this scenario, the cli attempts to read the discovery log via ioctl,
> which fails, causing the cli to see it as an empty log and then proceeds
> to delete the discovery controller. The delete is rejected and the
> controller is left live. If the discovery controller reconnect then
> succeeds, there is no action to delete it, and it sits live doing nothing.

This is indeed a regression.

Perhaps we should also revert:
12a0b6622107 ("nvme: don't hold nvmf_transports_rwsem for more than 
transport lookups")

Which inherently caused this by removing the serialization of
.create_ctrl()...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
