Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D14C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 19:09:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C336064DE3
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 19:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C336064DE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iVC6GnPimOF75vbcOASYfrRc2SuqRx+BulhDd+ECZnk=; b=CfFJoGCzc6A2qdrB+K5JdTy23
	x4LvZqdmINbi49e8rn/X/Ge8zRnKhVoxLfHNCSzrP8ivPBDR/mmJ+BSkgG+ELgOhTVcQCbjJ8/ger
	i3AW+f/sK2r4TrO7cC+ErHjsIoOuG0kG+1UrJnmTGN0DBuK2KTyzaaf6ObwZXrjXfiguLiRFqttQV
	4zBuP0LMLYTGKT+DB4x0pLEztVwF99q5ZIxl1figVjzYb75okgBQp7kAYgaPkG/cbEAZY9VDJFH6+
	xX2Qckq7Jm0gkRurrAzyEWeK1bduJ/vg8DZcK+Gueo/amW8I/ttVeZwz4kiNyePO8/ipUK4FAM9aF
	TauLwRhKg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5Z8v-0007In-D7; Fri, 29 Jan 2021 19:09:17 +0000
Received: from mail-pg1-f182.google.com ([209.85.215.182])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5Z8t-0007I1-Du
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 19:09:16 +0000
Received: by mail-pg1-f182.google.com with SMTP id o16so7322177pgg.5
 for <linux-nvme@lists.infradead.org>; Fri, 29 Jan 2021 11:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xph4ht6Brm27jgbSRDgqukCjhh9JY+zdTnAVjUoaza4=;
 b=mIBqm6nEwyMYahOcLziOVmau6q84XQxlTfn1uoQTDHqnlKvoIdNS4CjBWUJHKItgPv
 NW1SrTJzdNVTXaHFMFh41DqDe4DBWO7B8tmm86dZvOMEWPi7kBHjkmyRl2GNHYdk3k2X
 okhMviMdrExa/F8gWFlQxqWx0km9H3IRTzog08rfD8CKvYVaeB0tPIupvwI5pJmxv1Gd
 omEB45PjtfxDoY2NFMXJZP5CrPCAWeVGu/a9Nu7ghv87cv3O7jbAz3YsAqpWC54Vm6f2
 tpJ/Q611oe6BmP2Hm9b041Sv8CqkdglqkCnlIUPcRcxOg+eKyLR5r3wv96Q3FOJ+Ep83
 TXsQ==
X-Gm-Message-State: AOAM530r1Osj3nqd5/nnt8Bt8iBLWP9XwW/8ntjDzDJuOZLfuMaqPvIK
 o10daEWh6GC5B439SfydVh9ybQiehXY=
X-Google-Smtp-Source: ABdhPJwn2cRuFn9Y+7g8ux6EdIPGjf4wyvfH8pblofI74c5njJbquF3Zf1HKnAD418SyQNaKIC/Y8w==
X-Received: by 2002:a63:2352:: with SMTP id u18mr6117865pgm.385.1611947353996; 
 Fri, 29 Jan 2021 11:09:13 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:db7:4f5:6eca:f1ab?
 ([2601:647:4802:9070:db7:4f5:6eca:f1ab])
 by smtp.gmail.com with ESMTPSA id q24sm9815265pfs.72.2021.01.29.11.09.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Jan 2021 11:09:13 -0800 (PST)
Subject: Re: [PATCH 33/35] nvme-connect-all(1): fix documentation for
 --quiet/-S
To: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-34-mwilck@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ad90839a-f4a1-d8be-9dbc-58f839c7560d@grimberg.me>
Date: Fri, 29 Jan 2021 11:09:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126203324.23610-34-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_140915_516751_B02DA36A 
X-CRM114-Status: GOOD (  17.79  )
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
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cleanup unrelated patch

On 1/26/21 12:33 PM, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>   Documentation/nvme-connect-all.1    |  8 ++++----
>   Documentation/nvme-connect-all.html | 10 +++++-----
>   Documentation/nvme-connect-all.txt  |  4 ++--
>   3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/nvme-connect-all.1 b/Documentation/nvme-connect-all.1
> index 91d6896..a53a017 100644
> --- a/Documentation/nvme-connect-all.1
> +++ b/Documentation/nvme-connect-all.1
> @@ -2,12 +2,12 @@
>   .\"     Title: nvme-connect-all
>   .\"    Author: [FIXME: author] [see http://www.docbook.org/tdg5/en/html/author]
>   .\" Generator: DocBook XSL Stylesheets vsnapshot <http://docbook.sf.net/>
> -.\"      Date: 10/20/2020
> +.\"      Date: 01/20/2021
>   .\"    Manual: NVMe Manual
>   .\"    Source: NVMe
>   .\"  Language: English
>   .\"
> -.TH "NVME\-CONNECT\-ALL" "1" "10/20/2020" "NVMe" "NVMe Manual"
> +.TH "NVME\-CONNECT\-ALL" "1" "01/20/2021" "NVMe" "NVMe Manual"
>   .\" -----------------------------------------------------------------
>   .\" * Define some portability stuff
>   .\" -----------------------------------------------------------------
> @@ -51,7 +51,7 @@ nvme-connect-all \- Discover and Connect to Fabrics controllers\&.
>                   [\-\-queue\-size=<#>         | \-Q <#>]
>                   [\-\-matching               | \-m]
>                   [\-\-persistent             | \-p]
> -                [\-\-quiet                  | \-q]
> +                [\-\-quiet                  | \-S]
>   .fi
>   .SH "DESCRIPTION"
>   .sp
> @@ -193,7 +193,7 @@ If a traddr was specified on the command line or in the configuration file, only
>   Don\(cqt remove the discovery controller after retrieving the discovery log page\&.
>   .RE
>   .PP
> -\-q, \-\-quiet
> +\-S, \-\-quiet
>   .RS 4
>   Suppress error messages\&.
>   .RE
> diff --git a/Documentation/nvme-connect-all.html b/Documentation/nvme-connect-all.html
> index beae013..f779c7b 100644
> --- a/Documentation/nvme-connect-all.html
> +++ b/Documentation/nvme-connect-all.html
> @@ -4,7 +4,7 @@
>   <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
>   <head>
>   <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8" />
> -<meta name="generator" content="AsciiDoc 8.6.10" />
> +<meta name="generator" content="AsciiDoc" />
>   <title>nvme-connect-all(1)</title>
>   <style type="text/css">
>   /* Shared CSS for AsciiDoc xhtml11 and html5 backends */
> @@ -436,7 +436,7 @@ thead, p.table.header {
>   p.table {
>     margin-top: 0;
>   }
> -/* Because the table frame attribute is overriden by CSS in most browsers. */
> +/* Because the table frame attribute is overridden by CSS in most browsers. */
>   div.tableblock > table[frame="void"] {
>     border-style: none;
>   }
> @@ -768,7 +768,7 @@ nvme-connect-all(1) Manual Page
>                   [--queue-size=&lt;#&gt;         | -Q &lt;#&gt;]
>                   [--matching               | -m]
>                   [--persistent             | -p]
> -                [--quiet                  | -q]</pre>
> +                [--quiet                  | -S]</pre>
>   <div class="attribution">
>   </div></div>
>   </div>
> @@ -1048,7 +1048,7 @@ cellspacing="0" cellpadding="4">
>   </p>
>   </dd>
>   <dt class="hdlist1">
> --q
> +-S
>   </dt>
>   <dt class="hdlist1">
>   --quiet
> @@ -1115,7 +1115,7 @@ nvme-connect(1)</p></div>
>   <div id="footer">
>   <div id="footer-text">
>   Last updated
> - 2020-10-20 16:47:21 PDT
> + 2021-01-20 23:40:57 CET
>   </div>
>   </div>
>   </body>
> diff --git a/Documentation/nvme-connect-all.txt b/Documentation/nvme-connect-all.txt
> index 128f336..820dd6c 100644
> --- a/Documentation/nvme-connect-all.txt
> +++ b/Documentation/nvme-connect-all.txt
> @@ -27,7 +27,7 @@ SYNOPSIS
>   		[--queue-size=<#>         | -Q <#>]
>   		[--matching               | -m]
>   		[--persistent             | -p]
> -		[--quiet                  | -q]
> +		[--quiet                  | -S]
>   
>   DESCRIPTION
>   -----------
> @@ -154,7 +154,7 @@ OPTIONS
>   	Don't remove the discovery controller after retrieving the discovery
>   	log page.
>   
> --q::
> +-S::
>   --quiet::
>   	Suppress error messages.
>   
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
