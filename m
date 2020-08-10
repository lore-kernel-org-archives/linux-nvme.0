Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F90CC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 22:01:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58E88206C3
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 22:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jt0cZxx6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="axiG2fg/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E88206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0C2bvoy4+ENGF/ZyvdiqcW6NM/KVaM+nwUYcfFq99Bg=; b=Jt0cZxx6SgyWx1tfIAaHy0KWw
	fTp3YkQ/d0pDSvoelSrZPr/DriZ3LmF9Usj7YdUAGssb5kkd0tumIkYUIxEztQhsO3iJg2+7OhgrR
	nkSEa9KsM1a2J/8wxoHmgxZBZw2smsarn6ywsQDa6qiWiWElEo+dfxmki4BLhRbSkOvVr/QbE2hVN
	Fk90Nix08s1h39ba6nk4d5mX3aqI8+NOOnoqnozgDkk+j3mNJ5GzvaMskwUBEdzplIh28apblp1qr
	tLvSz3xoii9DoKYizXA/Z64VMZ8xzKvI6fBYdV2uxSM0z5MY7goFwstDbeg5muY0hKGNUQPZaMQNV
	2wvDQ1BwA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5Fr4-0007jz-N8; Mon, 10 Aug 2020 22:01:18 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Fr2-0007io-0R
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 22:01:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EvSmYNDsztjXC2vKHgPoDu97yFLzyRexMnqr55kfXDs=; b=axiG2fg/py2FzJ0gsu5WGp13h9
 OmTPJGZ2D4jNISpxsbW9TR6oja/ZQC7P8mzwhUTOISE5BqhEkil/R+SVQcpLcvo2+JFjj90UKZpvU
 C9rndrWwG7R6W4DTMPJ6Bxz3mS3sozEiI8ddC99Oem3aA4xypeKeVE2E9cb65u5ChDmF6EeePdy4l
 1AkqfrsrsM1DpYPDfkeUDwWBAHSpW0igymboO39MyJkapdHJLsW+FxsyXZSUNH65aC2AvoVUbUk9e
 I7EekehkOxWp1CYBXhpNu/RvJS3LzB44BCcPM5l2UDXPQL4P0IIi6D2Hw6KKWNGGRrcyVVZ5j+QIt
 VHqTZN5g==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1k5Fqz-0000HC-Ii; Mon, 10 Aug 2020 16:01:14 -0600
To: Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-7-chaitanya.kulkarni@wdc.com>
 <20200810204627.GA269401@dhcp-10-100-145-180.wdl.wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ac9e3694-1200-a3dd-caa1-c53c4113d656@deltatee.com>
Date: Mon, 10 Aug 2020 16:01:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810204627.GA269401@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sagi@grimberg.me, linux-nvme@lists.infradead.org, hch@lst.de,
 chaitanya.kulkarni@wdc.com, kbusch@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 06/14] nvmet: use unlikely for uncommon commands
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_180116_097491_51EF6B92 
X-CRM114-Status: GOOD (  13.98  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-08-10 2:46 p.m., Keith Busch wrote:
> On Mon, Aug 10, 2020 at 11:54:48AM -0700, Chaitanya Kulkarni wrote:
>> I/O commands (nvme_cmd_read, nvme_cmd_write) are most common commands
>> when accessing passthru controller, most controllers should not
>> have set the effects for r/w I/O commnds (atleast I don't know at this
>> moment).
> 
> The method that gets effects actually always returns 0 for IO commands,
> which is the case if you are sending this command to a namespace.
> 
>>  	effects = nvme_command_effects(ctrl, ns, req->cmd->common.opcode);
> 
> In which case you could skip retrieving effects if ns != NULL.

Is that a safe assumption going forward? If someone changes
nvme_command_effects are they going to know they need to change the
callsite?

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
