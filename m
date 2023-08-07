Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51020EB64DD
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 10:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ie1xgDxiiOiaNq3yXPerRraTJqI+zO5f31vlmZM58A=; b=amIH64I2sUXEC54kbm4YesW9y+
	nKkFTt39OOi/COUhaBOeHGTTkBGSrz+/e91QBKLVe4eZ92WHplHzEwObNu7XekFMcahRQhZeii5FO
	UDiXF6oGILVcOqIWYrpMIKqESyEUyU1uyMD5NHSEK++13ldR5MwSXr9HIK0+nbQO78C1WRnTc1283
	WHSlYmub0zJ4V4+Ale0BfX92sl4Om3p1NYt7zafsOzK++dmWPltsIoI4XiJqK2Th8E0tdk3Ka5TqV
	nKhh8vGh+cPOM+BH0RyINPIdZe02cHn/F+SYoTCcCqPxFEgnKNmXm0pBFI2A0OYZOoofzsFRVg3II
	lRrFTpig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSxVg-00GqNc-3B;
	Mon, 07 Aug 2023 10:30:48 +0000
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSxVd-00GqJT-1v
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 10:30:47 +0000
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qSxVP-0004E8-4E; Mon, 07 Aug 2023 12:30:31 +0200
Message-ID: <d7290782-bf72-3a65-26fa-b58e75bcae2c@leemhuis.info>
Date: Mon, 7 Aug 2023 12:30:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Ubuntu 22.04, "nvme list" will hang for 60 seconds after
 "nvme subsystem-reset"
Content-Language: en-US, de-DE
To: Bagas Sanjaya <bagasdotme@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, shenlinghai@163.com,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 dwmw2@infradead.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux NVMe <linux-nvme@lists.infradead.org>
References: <8edde583-2b5f-2332-e59a-f1f4688b9e40@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <8edde583-2b5f-2332-e59a-f1f4688b9e40@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691404245;49f0ba60;
X-HE-SMSGID: 1qSxVP-0004E8-4E
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_033045_779832_BC7A28C1 
X-CRM114-Status: GOOD (  12.79  )
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

On 02.08.23 13:41, Bagas Sanjaya wrote:
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
>> Issue description:
>> root:~# lsb_release -a
>> No LSB modules are available.
>> Distributor ID:	Ubuntu
>> Description:	Ubuntu 22.04 LTS
>> Release:	22.04
>> Codename:	jammy
>>
>> root:~# uname -a
>> Linux dapu-Star-Lake 5.19.0-46-generic #47~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Wed Jun 21 15:35:31 UTC 2 x86_64 x86_64 x86_64 GNU/Linux

Bagas, please don't forward reports to the developers (and also don't
add them to the regression tracking) if the report is about a problem
with a vendor kernel that is known or likely to be patched[1].
Developers otherwise will just start to ignore your mails, as you are
wasting their time.

Ciao, Thorsten

[1] unless of course the reporter confirmed that the issue also happens
with a fresh vanilla kernel; but that afaics still hasn't happened in
this case yet; and even if that's the case it must be really obvious
when forwarding a report.

>> root:~#nvme subsystem-reset /dev/nvme0
>>
>> root:~#nvme list      //This command will hang about 60 seconds. 
>>
>> Issue analysis:
>> Maybe it hangs in function nvme_wait_reset. When we revert the following commit, this issue will disappear.
>> if (!nvme_wait_reset(ctrl))
>> https://github.com/torvalds/linux/commit/1e866afd4bcdd01a70a5eddb4371158d3035ce03?diff=split
> 
> See Bugzilla for the full thread.
> 
> Anyway, I'm adding this regression to be tracked by regzbot:
> 
> #regzbot introduced: 1e866afd4bcdd0 https://bugzilla.kernel.org/show_bug.cgi?id=217745
> #regzbot title: listing nvme devices hangs after subsystem reset
> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217745
> 

