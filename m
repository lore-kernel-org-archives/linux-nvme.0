Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37A6C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 08:37:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5472C64DBD
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 08:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5472C64DBD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8FcuEQCwTKS0UZuRqSRVkXfHJBZDYTq2VKbATgxWQNY=; b=NZci/It8eqFAK+YU619tOOOzW
	4HJARpZ2A5jkxI/eG/cDbDnbjsp3AbJESJEF6l+hZE0WIZFduzUoDqqN8yryp+59qZvS+tmd53zbo
	zy9DBnbHdUNidxmw4HwZR8K7aWAZjimtmRor/Fli4P2+hTurrrOpO6V5jam4bU77rzkpLiB8n9Tyw
	U0m7X8r6WUuICFfB+gL/mGCtQ8fl3xfsDdXs0XDwwPKr+QftU9miBMrn9OPwmmhj5QI4hwUkzOAHN
	akEHBHEVlyyHEa0OZVLhv1wwxFeOvA7EnBzZVvY+Mdy2oD0zNJ6P5z0urJXJRXglRydbbm9Vu8mBL
	7Ycz9efxQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l52oB-0003v6-3w; Thu, 28 Jan 2021 08:37:43 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l52o9-0003uU-Ex
 for linux-nvme@merlin.infradead.org; Thu, 28 Jan 2021 08:37:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=iBC2D/bgE1LB79BY92rDOC5j3lxONlL0u3Mr/Hhsruc=; b=ox/rR3cqOZC42Sy5SfQIhlYoa5
 BtDwzk86IjOwYIE7YBi4B3kKaYvcLCByL3ByEAQBbeu12wU74fEC5Unt7xCXwbQREq04251XOfnlj
 T8sZwSPEAagQr+O5itr4M8937hjP+7RMcZ/Cz7QJ2MPLXomX69mCsvtkyPIm8oOxDeQvQW4EntVKZ
 73JHZM3ZjQddJaDA/sGwqVfdhjS4ctXu/ePN1N/O0kvYLReTViISP3M6yV1vzQMq+fIjIOd4x4Epp
 5S56KzLP+zlMuesvb5cR6cok87uwbEKVEhF3TFWiE+E9GzF+nnFDOSccFrQ6xVhT34u16wcIDYyI0
 2ukzGQqg==;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1l52T5-008A8m-IX
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 08:15:58 +0000
Received: by mail-wr1-f45.google.com with SMTP id d16so4410532wro.11
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 00:15:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iBC2D/bgE1LB79BY92rDOC5j3lxONlL0u3Mr/Hhsruc=;
 b=OnkSZKvsVeZWrqCL1emPRnFXsK3CNVF7S5fefHSWB//G3oPPlMjVrprT3hSTQj752V
 9sJQvwmgokSvYNV8zJtSZos1zhwPnMnaJWPpSy0p4rKtFQ80D9NTDXC4FFriaPJsTir7
 8LLDAXu/BieMkezv51MCp/YlvX09X+9+NYl/mhvry9jxAYXruWmWIn24jiHO3UJWPDzi
 nAsnSEOGUZpXW/mJ04zVdwu/Yq2ObWd2r4VM9ovWZyuiVZHlRqg0wtUrzSW5ohPOtkrO
 ifyUQ9/yNfTWBlR0ZrcF6pwaxqkB1cLTd/RhFPoMLk1kA+BjCjpK5rziUFCJks3covcS
 p/QQ==
X-Gm-Message-State: AOAM5332ZNXA+Dgb+2nAqJAEsaGqbsnNdGfHQHaQ/xq3Kbit9Pprnx1c
 PSve9GKCa9ihi53c5h526r/nmonFz20=
X-Google-Smtp-Source: ABdhPJwz0Z2isFucRn+aLlkgNx0+P4IO4mQJdJqROtp84Chu4Yp01/2UAwZcv/fVqwn0s5htAzKysA==
X-Received: by 2002:adf:f909:: with SMTP id b9mr15355892wrr.111.1611821752310; 
 Thu, 28 Jan 2021 00:15:52 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:4d86:226e:ca4b:6bef?
 ([2601:647:4802:9070:4d86:226e:ca4b:6bef])
 by smtp.gmail.com with ESMTPSA id i4sm5042961wml.46.2021.01.28.00.15.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Jan 2021 00:15:51 -0800 (PST)
Subject: Re: [PATCH 1/5] nvme: add NVME_REQ_CANCELLED flag in
 nvme_cancel_request()
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20210127103326.16191-1-hare@suse.de>
 <20210127103326.16191-2-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6be12f35-7674-83ff-b6ef-ee51170e8d79@grimberg.me>
Date: Thu, 28 Jan 2021 00:15:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210127103326.16191-2-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_081558_259354_9909CC41 
X-CRM114-Status: GOOD (  14.60  )
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
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <keith.busch@wdc.com>, James Smart <james.smart@broadcom.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> NVME_REQ_CANCELLED is translated into -EINTR in nvme_submit_sync_cmd(),
> so we should be setting this flags during nvme_cancel_request() to
> ensure that the callers to nvme_submit_sync_cmd() will get the correct
> error code when the controller is reset.

We will have an issue here. Because now nvme_validate_ns will return
EINTR, which means that now scans failing to validate during resets
will now end up incorrectly removing the namespace:

--
out:
         /*
          * Only remove the namespace if we got a fatal error back from the
          * device, otherwise ignore the error and just move on.
          *
          * TODO: we should probably schedule a delayed retry here.
          */
         if (ret && ret != -ENOMEM && !(ret > 0 && !(ret & NVME_SC_DNR)))
                 nvme_ns_remove(ns);
--

Did you check resets loop with scans with this?

If we go down this path (we already had this discussion in the
past), we need to decide on either of:
- Don't remove the namespace for any of the return codes from
   nvme_submit_sync_cmd (understanding that this may be just a
   transport issue).
- Or, return the raw positive nvme status (which doesn't have
   the DNR bit set) and make sure we return ret codes on top.

But this change alone, re-triggers a condition that during
resets a namespace is incorrectly removed.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
