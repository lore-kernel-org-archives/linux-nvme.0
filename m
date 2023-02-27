Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0A7C7EE2E
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Feb 2023 21:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hhb+o2bEayp+f4Zj/5IIprArbl64Rwb+MdGZZRBDGWc=; b=QrbnnROT20cqc8yc/uR4TJ687R
	yYDvIXV6MVUDDcLOa+sMv5DppSVsSiE2bE+5IeZxOPm+LHC+gesLJG7BE6D6NQIYpX3zgRc12PKNQ
	m4ZSDugI9+WnrIztA3ijtOYdIct9dyYZis8TVpSGAH5Md/1J15NuOX6szlguKPzt2kYJvb5QCfp3s
	mHvv5db94+pyLFt1oSSQcB5jjaQv55adlOu8aYGBF/aF9ofRRhEkWFOosOQmrRFf0vY0vo0mAYSgn
	jdNSbVCTlUiVLfGgKTHfftOSXVErJZngI4gQLR2RP6wXbJ4uHQvV54vRqCQ9jBNlHxrU/oYB7bbpJ
	BTbtD43w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWktJ-00BIJw-Au; Mon, 27 Feb 2023 21:18:37 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWktG-00BIHR-Cw
	for linux-nvme@lists.infradead.org; Mon, 27 Feb 2023 21:18:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677532714; x=1709068714;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DX80PnHjJHoZBpzLbMSl34pvvXAuVXENmZVvv87jZNg=;
  b=YVtKqbJw45ib9FW++PL1+RIMPlzF46F+fJ2omCoVC/a9dQbvzV9cfQiv
   BMgkiUBCDYmDxYkn3/xDbC1VFNznCr65lRkFzlXxoIKFPTmLmRZNnK3qR
   zTGjgG3xz9Qw1xA7/FPeu0/1diJzSCd5BtzE5I6kV8jOn4lSUzQEJoMCl
   b2BxpyNd2CkmZlGs6X3dCK8Y040aK5qRWAIDDmrUNEWkv8oBnhfIJ2zgO
   QfH3+y3UN4tONLuHHt3oYZOG6OqIMIpM+wDDNXeAV9J4HtPRQpUz7CLKr
   H9Gsv1U8W+O42rMDaL5QyHJ+/AZ1x8WRNnXegLRYQNDoTF3WdR4d33zH+
   A==;
X-IronPort-AV: E=Sophos;i="5.98,220,1673884800"; 
   d="scan'208";a="336331067"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2023 05:18:32 +0800
IronPort-SDR: b7LACnhyEJfUIdmsEQ695NpOMWzd3WhF6Iw6bXKqFf8pzl829Z07MoXNJO0VZ+3WLiGecYjOqS
 qyA/wLixHqffAu8XO/EIFqwuCPnLdUpMaSv3xvMWamx+47MkoyP5zdnt+nearCqaUvwekqBoNJ
 LCOG70A+t4ss8WYylWX7L3JssZXniJIvjb220tih0Kl9VE55BKOJhwQ0Ead0smP6cSlkJxcX3t
 3zl40k7wHcmm5aO9Zc0olbVnLv+ZwCCqp/o37nn8wgLGgCqWo9KSvTjdS9P8xNPGlRz8c65+4I
 pFE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2023 12:35:23 -0800
IronPort-SDR: Yq0ivxtbhpflw/zVS9NrbuM2E0gvhVr6pHDIuv86glJL+fSSuJ1vV+l9htVrJkw4rXNiEDHVQY
 2gWMeG+Hcr5FWX7cS0RysAdrkfCx6QKSkIKHyO/frrziRk+uBtg5CA0idKQ90ZUaVBtWk5C0Y+
 J/gjCzKB908gmbePFutR5cG6ucgqf0n2WZhWBVotYIiFwEqQjlDibjKT9Z1M/RXcYfmTWcReQB
 jgKblw96mioWZs8DT9q3uFx7xmQFg1qCavV8A4Vb+/bkKw1SFW/LigW5EeMYMNsQs939tdnCBK
 9ss=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2023 13:18:32 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PQYJR5xtlz1RwtC
	for <linux-nvme@lists.infradead.org>; Mon, 27 Feb 2023 13:18:31 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1677532711; x=1680124712; bh=DX80PnHjJHoZBpzLbMSl34pvvXAuVXENmZV
	vv87jZNg=; b=gfDm7UacfGl4S7JY8ppurANZH5fOxlOdeX+COAZW/l1Z+US4tLM
	L8z5JkyoiiJ2Tc3t7UtCy5Fv+UNB13ImMZd+eVkxUpUTaldtgx4qy5xGwXbr0dBM
	AnEqSqwShOU6nEI9f1IFA1rtGmF2wDX6qTlK3M67aLFuzULZEtdJR3Hy2ipke5XA
	JJVfllp+tw0xGxeqHmBRsfMt8xX3jZHyV+7GleotWUMoxlOv9waOPsEeZlL0VjXb
	THgLxAs8PTRAOM+Cuw0fh/Q97PsTvNThgo/RhbBGL69vE2NV26mBpgg8EYAWIp7J
	a/SuTMpWweayZh8elDVl9XmHzE4hiECmr6w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AN84zW9r8Cto for <linux-nvme@lists.infradead.org>;
	Mon, 27 Feb 2023 13:18:31 -0800 (PST)
Received: from [10.225.163.44] (unknown [10.225.163.44])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PQYJP3wmLz1RvLy;
	Mon, 27 Feb 2023 13:18:29 -0800 (PST)
Message-ID: <f39d4184-db92-3101-1e83-b0aa65699aa8@opensource.wdc.com>
Date: Tue, 28 Feb 2023 06:18:28 +0900
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
X-CRM114-CacheID: sfid-20230227_131834_478067_DB6521AB 
X-CRM114-Status: GOOD (  18.21  )
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

Ah yes. good point. I always forget about the shared completion queue :)

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

-- 
Damien Le Moal
Western Digital Research


