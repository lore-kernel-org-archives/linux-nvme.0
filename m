Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FB3C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:23:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 261FA206C3
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lCIjWGB/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="AMIhhsQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261FA206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=INTID1tsAeVcdYSage+LOYkpM+FAWJLh1cG5ZRlY1tw=; b=lCIjWGB/N+M4+aEvymzgLFOiI
	r2ezM5KviCL9d7g9Go4p9gb9RoDcVS7CWcMZ/gqM7R8HqTZ5Xs67SShY0nwG4g2FHR8OBUj6nvtCE
	tabbyUxCejgJb8Bkdq9qSv5dGcC2QtQmVqtFK3tds8sICRS7BLeske6gGXwIlfHdqyoLeDstyCLRI
	e8fPjfKm4RwmdxsPRw51fHGjaxvhrpYg/RabAjZemUWb1AvJfHBXz6O3r+up9xTUQptOymBiL2ZIE
	2PSH5r2Rxzf4Nb/rcYoespudC09PfpXWXBiQNep35ZcMqE528SbFOfIpVb8rZZC+mNNWgHj8VL0r+
	NsmSzSVcQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5H8z-0003XN-Os; Mon, 10 Aug 2020 23:23:53 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5H8w-0003Wj-QV
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 23:23:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G2u8NYmm8so2ifmlKErFCMhB4KaHpnO1uqNHPmdsTr0=; b=AMIhhsQX2tYTI0fAkGbyOi25jh
 CG+oA1BcDp5pFzukj6/SziyrHYMuFsapIqu/blBB4RN7C1yCiOBHVe56lRgA/Vvo+is6ZR4EH3B6l
 8EzZBD3fZ/F1vCo5I1x1u0R4YD8bYLbt8SBgabBSADDt7oCIFTdeiEEwZJHN//8Tcq8DMCCHpxc6L
 JhB+NCBYSA7Ug27SRyYraVmrf6Gry02a0WPHrMOjn+u3JZPF4nrC9qy2rq/Qq+vRccBco91Hc0gyj
 bu6w9534Klgpj8n4Ynp0dgsNqpS4sAqOmW4Mib6P6fCJfph2xjbJOV8sCwMqN5swKNjq1e3FmWaFL
 txKfhebw==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1k5H8u-00024v-1W; Mon, 10 Aug 2020 17:23:49 -0600
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-9-chaitanya.kulkarni@wdc.com>
 <ec013b0e-e9ac-f6b1-3285-d281a81f74a0@deltatee.com>
 <BYAPR04MB496527B7BFE2E1049B6E6FF386440@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ab9d6ee3-a7ae-1ad8-1a81-4fe5bc6feab0@deltatee.com>
Date: Mon, 10 Aug 2020 17:23:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB496527B7BFE2E1049B6E6FF386440@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
 Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 08/14] nvmet: use nvme write cmd group setting op_flag
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_192350_913079_00B5A4DC 
X-CRM114-Status: GOOD (  13.51  )
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-08-10 5:08 p.m., Chaitanya Kulkarni wrote:
>>> +static inline bool nvmet_write_cmd_group(__u8 opcode)
>>> +{
>>> +	bool ret;
>>> +
>>> +	/* NVM Express Revision 1.4 Figure 462. */
>>> +	switch (opcode) {
>>> +	case nvme_admin_format_nvm:
>>> +	case nvme_admin_ns_attach:
>>> +	case nvme_admin_ns_mgmt:
>>> +	case nvme_admin_sanitize_nvm:
>>> +	case nvme_admin_security_send:
>>
>> All of these admin commands are rejected as INVALID_OPCODE in
>> nvmet_parse_passthru_admin_cmd(). So adding them here seems confusing at
>> best.
>>
> 
> These are extremely important commands, why these commands are
> rejected ?

In some cases we were worried about side effects with other hosts
accessing the namespace, in others they require using the ctrl_id which
isn't really mapped in a sane way.

> What is the use of passthru if host cannot create namespaces format ns 
> and sanitize the important data ?

Plenty, they can format the ns on the native host and still use them on
other targets.

> Irrespective of that it better have it documented there is no harm.

We shouldn't have code that doesn't actually do anything. It's confusing
and bad practice.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
