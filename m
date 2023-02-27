Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B851C64ED6
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Feb 2023 21:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UG12ozmKDObdF4od3/xQzGBxn9w7lCazsUrVTRHUDJU=; b=zSMf7shbcpDjXcd3WqFeRrVBrr
	bhPalZCsV48THUcntHAKFK9WmWRp4zVkV1spAuKX/4qBz9uOcK0jmViSTHafbvi2hbi05h3/brNZT
	5LVwRQqZVLopc+SMllPB84hbos/detTXYdkHz84Yh0MOSxSQSxaEtB88INrmudFBd9RDSn4uq+Xzg
	KTgEFnVKMFbf2SBKCpg6vWMxc3GqQiGa0NKhILl7Ty1bKy27BzoQ7nmHifw8j+efrCLTRY3186wdq
	wXs4zzjrH/KSmBQfcfP8UqGTUNpu6v9Bk7qtV90m0voAYq1kEWFaV9J3VvQuYJcyO9+6U4tQFkJ7g
	yXYNqH5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWlG9-00BM1q-2x; Mon, 27 Feb 2023 21:42:13 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWlG5-00BM0t-HA
	for linux-nvme@lists.infradead.org; Mon, 27 Feb 2023 21:42:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677534129; x=1709070129;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E16+HmI91qcq4n85XyiBcodRpHC0xN8mBwf0nq/L8Kk=;
  b=ECL0ruoO2+aQ55etWMTBTd15zisZpVOWLhAdpEcVu/2VnTWibHGx5KIi
   sNCwIgeOKZ4mZJM+dSN2VGMbgJXd1VMHfMz0mK/2Y9SdcgsWFbSbiftrH
   HXg6TTeUryqslZkjjdceTpBqV9MgPQ3TJSRPwLBLzrPLOxxwGb0DIMJ/5
   hTxl6weZ5ieyOsehxzYpabIK8X9OzYyEdy5BjgSVUlARxJdWRhgBXJ3pG
   YThSUtVehw8sYDUdr2xaMDgPYicLhEGBGWDxC20n2X6rSdYLP9v5E/Adx
   HYxJ2MBlTubqSHO7s8IwERFGPYPaE9ltua2VlP+doHnCcyUA2qCHzU/3u
   w==;
X-IronPort-AV: E=Sophos;i="5.98,220,1673884800"; 
   d="scan'208";a="222644406"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2023 05:42:04 +0800
IronPort-SDR: iK0khzfXO365JkeLarxuufjtn9aTk9Bn4tbED8nuoQA3zHroKTltzwonPnZoXUWfdsuuYw7Nb7
 DD1qXS4VS0D6wJR7ii1pArMY47IP/RgLkWs0NObNaeJSG1KhFJ/ojgiwkT5AyKNNhYElyo6EFo
 tm6BzEI4LWa4k4XuzmIXplcRaDHwAPc73gx3JMcsGgRylvQnBnluizrZRwD+q6qJ0iOoXru7fv
 ok1DaEV0h8z6n5ZDyr9IJ3PJZfhgk5TnqxJxot5NTo0ery8aRuc4cpTIHZ4l5AhNANL8wuaWIy
 p+E=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2023 12:58:55 -0800
IronPort-SDR: bOV8HKzMGKcc3dKEpuQulTzne3VL9YDwVDM9gzRkZVe08te8/K3ZMfgtaV39K3XrMVkAFBlygq
 4hlYppP2KUv3dRUSsxgUn263FiMgXjBoF8B4Fs7FUrWa8fAWu/Lqtdvd5OA6LGlr45RYOq7ZRo
 mUNUJrGaw3vIu+BOJhdPAIcyuC7OdoT52fN4ZpYTPf0yM+orK0oKSfsPZ7DlkaWtwIb7lg9HZM
 redRidmy3q6LYDdujDNvXJmnsOKueA8hrE/QGydfKf5Eh9nwy6dwS+/UdsK5HS4TAXg6msm1r2
 NEQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2023 13:42:05 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PQYqb6R17z1Rwtl
	for <linux-nvme@lists.infradead.org>; Mon, 27 Feb 2023 13:42:03 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1677534123; x=1680126124; bh=E16+HmI91qcq4n85XyiBcodRpHC0xN8mBwf
	0nq/L8Kk=; b=ZDIJKxZC/XiBEFR1lU5bIqmUDLpKvv3mVUtzX+l+JOr1/H3c6o2
	bgjlE20HVQFCtxvgkyjUyzSnC+AFx6ptm/8HIXD7hcxLI/U4RNA0nd70r/YOuXsu
	CilEATzEr28n12S7pkjSLWEQJN4NYDeM6QwR/aRKUz8JJ3XLWTCGV296TWQBOoN7
	SgIgpfNN09SDg3s1N3uLHwyKLOWMCRjJnJroz0gXnFMFRYsq4g1/ro001OvSJZ2d
	1yPNrEFKtKf38tyW6eIEl8FBnB9WN+G/f8PQ7G3rSIeOOIngIHdr9sTE7N5bJlER
	L+dvopUXf7Z3pnIboSAdeaJiL9pGMoexDZA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id puJvwZdYeI-n for <linux-nvme@lists.infradead.org>;
	Mon, 27 Feb 2023 13:42:03 -0800 (PST)
Received: from [10.225.163.44] (unknown [10.225.163.44])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PQYqY2qRZz1RvLy;
	Mon, 27 Feb 2023 13:42:01 -0800 (PST)
Message-ID: <9e1d83e8-e382-59a6-3283-e4f4a5dc7f56@opensource.wdc.com>
Date: Tue, 28 Feb 2023 06:42:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [LSF/MM/BPF BOF] Userspace command abouts
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "dgilbert@interlog.com" <dgilbert@interlog.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "lsf-pc@lists.linuxfoundation.org" <lsf-pc@lists.linuxfoundation.org>
References: <ad837a26-948a-c690-cd9e-4dfffb5f990d@grimberg.me>
 <57d8dff9-2fdb-8198-6cdc-7265797a704a@interlog.com>
 <23526cf9-d912-59a7-4742-6003d6ccfd45@grimberg.me>
 <Y/Yscr82hqdKl1Hw@kbusch-mbp.dhcp.thefacebook.com>
 <561afa67-04d0-c675-6bbb-048313da152b@grimberg.me>
 <73b4dd39-9ce8-9b55-8a1d-06865f3bde32@nvidia.com>
 <Y/lpmrwuehnsWmmR@kbusch-mbp.dhcp.thefacebook.com>
 <0fe59301-65e6-d8a9-033e-0243ad59c56b@opensource.wdc.com>
 <316431ed-1727-7e80-2090-84ac5b334f74@grimberg.me>
 <3ea301b1-c808-ce08-8ec8-3a631b385fb9@suse.de>
 <Y/zsE9i7012Ivwe1@kbusch-mbp.dhcp.thefacebook.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y/zsE9i7012Ivwe1@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230227_134209_665701_170F7997 
X-CRM114-Status: GOOD (  22.72  )
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

On 2/28/23 02:44, Keith Busch wrote:
> On Mon, Feb 27, 2023 at 06:28:41PM +0100, Hannes Reinecke wrote:
>> On 2/27/23 17:33, Sagi Grimberg wrote:
>>>
>>> I'm not up to speed on how CDL is defined, but I'm unclear how CDL at
>>> the queue level would cause the host to open more queues?
> 
> Because each CDL class would need its own submission queue in that scheme. They
> can all share a single completion queue, so this scheme doesn't necassarily
> increase the number of interrupt vectors.
> 
>>> Another question, does CDL have any relationship with NVMe "Time Limited
>>> Error Recovery"? where the host can set a feature for timeout and
>>> indicate if the controller should respect it per command?
>>>
>>> While this is not a full-blown every queue/command has its own timeout,
>>> it could address the original use-case given by Hannes. And it's already
>>> there.
>> I guess that is the NVMe version of CDLs; can you give me a reference for
>> it?
> 
> They're not the same. TLER starts timing after a command experiences a
> recoverable error, where CDL is an end-to-end timing for all commands.

Note here that with the current T10/T13 CDL definitions, end-to-end actually
means from the time the command is received by the device to the time the device
signals the command completion.

That does not include the transport & host adapter queueing (if there is an
HBA). And I guess this is the issue at hand for fabrics: how to integrate the
transport times. I guess the CDL descriptors could have one additional limit for
that, but then the duration guideline limit definition would need to be tweaked.

-- 
Damien Le Moal
Western Digital Research


