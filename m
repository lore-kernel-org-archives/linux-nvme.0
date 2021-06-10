Return-Path: <SRS0=9ZED=LE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13253C48BD1
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 07:46:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF24661285
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 07:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF24661285
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=weQVsuKS1F6HpttcywAOC6IBXcQINxxHQI3XC/ZqyGM=; b=0zYTtvVHee8sHV
	F53iS9YrbB9nWm9rhwYTE/4ttf6RIjYnJicVss36MX34LnfIToUdC78f7wr9ybLjl3whNu/C+Wq4W
	HMathN4ZNLt19v2i4bFbgDjxCCJsHXE3sJ0xgjITHr2gBHjAf3qLgy3W2N1I/3JogMqllYNzsHwIB
	alMDDqAC9V9TjswTCa0Ncer6HYzyKTRpAniDsICYHndWEE2YMYaBFzfvuHrYrPOTp0msRN05xVsUB
	EKNua2hqe/tb3Ohod51VuLt8M7fEur6HWlkD+XKgHGf+LMdo9S0u3nJLdh1MHXNdWOdx6fUNa11ek
	uFP133taDLI4QQA6U/5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lrFNy-00HGBi-RC; Thu, 10 Jun 2021 07:45:54 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lrFNv-00HGA2-PB
 for linux-nvme@lists.infradead.org; Thu, 10 Jun 2021 07:45:53 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BB3B5219A0;
 Thu, 10 Jun 2021 07:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623311146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ESMEkgz5NgDZPa9e0yAJm02YlEyCTYWZbd6RMVS0ZN4=;
 b=sZ3DSWwGKVWMOAG4a4TQPjGScHGhOscitDbU1Bvwo3lkmcaxjHmqmOlp9wmX140/IUI8hE
 IFQ2/LmkrnTCEJmMtwbkwNuSzP7cHlD4mXMTKXmTB239htus5biTxRNwGVb0IkOP6312Jo
 LBXh6qhuVVwOwHSZk+GOzyLIquOUKrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623311146;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ESMEkgz5NgDZPa9e0yAJm02YlEyCTYWZbd6RMVS0ZN4=;
 b=G+4CjzFKIeUIbf9dKZnC1irdlBZfYR6MYVZe7qDFFAX1Pc4cWMLIG9VOcTJ+yV4n3lp7pQ
 nlcKY8C4jqgfXKBg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id A1D21118DD;
 Thu, 10 Jun 2021 07:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623311146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ESMEkgz5NgDZPa9e0yAJm02YlEyCTYWZbd6RMVS0ZN4=;
 b=sZ3DSWwGKVWMOAG4a4TQPjGScHGhOscitDbU1Bvwo3lkmcaxjHmqmOlp9wmX140/IUI8hE
 IFQ2/LmkrnTCEJmMtwbkwNuSzP7cHlD4mXMTKXmTB239htus5biTxRNwGVb0IkOP6312Jo
 LBXh6qhuVVwOwHSZk+GOzyLIquOUKrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623311146;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ESMEkgz5NgDZPa9e0yAJm02YlEyCTYWZbd6RMVS0ZN4=;
 b=G+4CjzFKIeUIbf9dKZnC1irdlBZfYR6MYVZe7qDFFAX1Pc4cWMLIG9VOcTJ+yV4n3lp7pQ
 nlcKY8C4jqgfXKBg==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id 3imIJirDwWBrAQAALh3uQQ
 (envelope-from <dwagner@suse.de>); Thu, 10 Jun 2021 07:45:46 +0000
Date: Thu, 10 Jun 2021 09:45:46 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] Revert "nvme: verify MNAN value if ANA is enabled"
Message-ID: <20210610074546.jyqjalpldii6reg6@beryllium.lan>
References: <20210610024539.28875-1-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB49655A9B821FEE29D7A89E3986359@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49655A9B821FEE29D7A89E3986359@BYAPR04MB4965.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210610_004552_004091_9033D8BB 
X-CRM114-Status: GOOD (  21.19  )
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

Hi Chaitanya,

On Thu, Jun 10, 2021 at 02:55:08AM +0000, Chaitanya Kulkarni wrote:
> On 6/9/21 19:45, Chaitanya Kulkarni wrote:
> > This reverts commit 8872c159c7a83daf633768cee7a7ef7154010341. This is
> > needed to move forward with the blktests for now, without this patch
> > all the testcases result in the error :-
> >
> > [ 3502.072798] nvme nvme1: Invalid MNAN value 1024
> 
> Thinking about the code again I think following should work :-
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 23573fe3fc7d..4277f1554bd5 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -813,7 +813,7 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl,
> struct nvme_id_ctrl *id)
>             !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
>                 return 0;
>  
> -       if (!ctrl->max_namespaces ||
> +       if (ctrl->max_namespaces &&
>             ctrl->max_namespaces > le32_to_cpu(id->nn)) {
>                 dev_err(ctrl->device,
>                         "Invalid MNAN value %u\n", ctrl->max_namespaces);

'!ctrl->max_namespace' could also be written as
'ctrl->max_namespace != 0' which makes it more obvious what the intend
is here:

  If the controller supports Asymmetric Namespace Access Reporting, then
  this field shall be set to a non-zero value that is less than or equal
  to the NN value.


> diff --git a/drivers/nvme/target/admin-cmd.c
> b/drivers/nvme/target/admin-cmd.c
> index cd60a8184d04..a8ec377bb68d 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -394,7 +394,7 @@ static void nvmet_execute_identify_ctrl(struct
> nvmet_req *req)
>         id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
>  
>         id->nn = cpu_to_le32(ctrl->subsys->max_nsid);
> -       id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
> +       id->mnan = cpu_to_le32(ctrl->subsys->max_nsid);
>         id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
>                         NVME_CTRL_ONCS_WRITE_ZEROES);

This looks like the right fix for the upper limit problem.
I can see the tests are still failing with

  nvme nvme0: Invalid MNAN value 0

which indicates there is another problem in the nvmet core.

I try to find it.x

Thanks,
Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
