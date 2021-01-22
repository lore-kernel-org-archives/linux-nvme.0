Return-Path: <SRS0=yPeo=GZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124DFC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 02:33:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A56C22310A
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 02:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56C22310A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=comcast.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:Reply-To:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CS3Cmo1/iJxtKUJUyISwshD94kfUeFLxukniemiInLY=; b=t/sUrfNgrvChl6
	aKSVTgswNId82urmrogPwmY3cP2QIG0vQowRN6f+Q9r64JN9v0D2E6pe4hv7PxbNxkWSJoEO85AmF
	Fg7ntsneXKpO5D/3cljNEHEwSeMLIK7Si0Nr4ecTqfZOHHUe6yWUcZ7yQUUMz9QArz4ixA+m10miA
	Aarph0jgTiyTK+NWIazLTpwuSSKDsc+4FNhtH4fJTUmL9gpNpbUod0hRxarm83R8Px2f9MP5E6Ock
	3kkbmJyYJa7Q1E+NAv2QTAkm+XjGCaDGtSrr7vB+EPvlHk/4vmhHLeaoSXELy0yX7O1BE0UeTHR1G
	GmSf0DWKQN/JD1LDEgug==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2mGN-00068F-QZ; Fri, 22 Jan 2021 02:33:27 +0000
Received: from resqmta-po-10v.sys.comcast.net ([96.114.154.169])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2mGK-00067s-Qt
 for linux-nvme@lists.infradead.org; Fri, 22 Jan 2021 02:33:25 +0000
Received: from resomta-po-03v.sys.comcast.net ([96.114.154.227])
 by resqmta-po-10v.sys.comcast.net with ESMTP
 id 2ltml7wBL2Xuv2mFElDkY8; Fri, 22 Jan 2021 02:32:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
 s=20190202a; t=1611282736;
 bh=zde58XiSfvDwNA9KH+bMOpXsS1O6NHUKi6tn5kA7X8g=;
 h=Received:Received:Reply-To:Subject:To:From:Message-ID:Date:
 MIME-Version:Content-Type;
 b=WVGF/WZuH0Hz8TXo134NuUHnhHZTBiOpPnGGQT8Fy3EUhJZIr2H04TEIyTI/QDURa
 XI/+y4CBXHqpjBsAgAVdVkNtLA7Iti9x893b/MddNp90UcrEpgmeI9isk8e3uBy3uR
 nhP+Fb0nKJnfU5QpD+0efoIPd2IFsF32P6UZxqaXaMOF+L97tyLYC9tvUiTW2KoRAk
 ZeBGqF77z5WC4Z+MGUON//IwWC5QkJkkQ5gBOICTkLo1a1ALG5XIacMeesb33ZAbUH
 dr04xdudTPiNGLHz85INUm8RQqmPBHzx/gHLbi6QgoqqHWhZqCRa/3/g8xiJAQ7PU7
 SJ2JaNSYIEhBA==
Received: from [IPv6:2601:147:c380:23e0:3df2:f84c:2a2:43ff]
 ([IPv6:2601:147:c380:23e0:3df2:f84c:2a2:43ff])
 by resomta-po-03v.sys.comcast.net with ESMTPSA
 id 2mFAlVN0jjnlV2mFBloF6h; Fri, 22 Jan 2021 02:32:14 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
Subject: Re: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow;
 use-after-free.
To: Niklas Cassel <Niklas.Cassel@wdc.com>
References: <f50bc59c-db11-bb44-55be-7b9db1119872@comcast.net>
 <BYAPR04MB49659C0F0F0E11D166B31E0586A40@BYAPR04MB4965.namprd04.prod.outlook.com>
 <a4c75497-d170-1e0f-8608-282231ff3a8e@comcast.net>
 <BYAPR04MB496542BEF594F0380F7D41CF86A20@BYAPR04MB4965.namprd04.prod.outlook.com>
 <df46d7ce-ce70-1f43-0efd-7153761bcff0@comcast.net>
 <20210121124459.GA156577@localhost.localdomain>
From: Bradley Chapman <chapman6235@comcast.net>
Message-ID: <96083ad4-e065-c071-bdc9-67517dc1e5a3@comcast.net>
Date: Thu, 21 Jan 2021 21:32:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210121124459.GA156577@localhost.localdomain>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_213324_927601_15F21B75 
X-CRM114-Status: GOOD (  25.31  )
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
Reply-To: chapman6235@comcast.net
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Good evening,

On 1/21/21 7:45 AM, Niklas Cassel wrote:
> On Wed, Jan 20, 2021 at 09:33:08PM -0500, Bradley Chapman wrote:
>>>>> Also can you please also try the latest nvme tree branch nvme-5.11 ?
>>>>>
>>>> Where do I get that code from? Is it already in the 5.11-rc tree or do I
>>>> need to look somewhere else? I checked https://github.com/linux-nvme but
>>>> I did not see it there.
>>> Here is the link :-git://git.infradead.org/nvme.git
>>> Branch 5.12.
>>
>> I tried fetching the entire repo but it was huge and would have taken a long
>> time, so I tried to fetch a single branch instead and got this result:
>>
>> $ git clone --branch 5.12 --single-branch git://git.infradead.org/nvme.git
>> Cloning into 'nvme'...
>> warning: Could not find remote branch 5.12 to clone.
>> fatal: Remote branch 5.12 not found in upstream origin
>>
>> I haven't compiled any out-of-tree kernel code in a very long time - how
>> easy is it to add this code to a kernel tree and compile it into the kernel
>> once I've figured out how to get it?
> 
> Hello there,
> 
> You can see the available branches by replacing git:// with https:// i.e.:
> https://git.infradead.org/nvme.git
> 
> The branch is called nvme-5.12
> 
> It is not out-of-tree kernel code, it is a subsystem git tree,
> so you build the kernel like usual.
> 
> If you already have a kernel git tree somewhere,
> simply add an additional remote, and it should be quick:
> 
> $ git remote add nvme git://git.infradead.org/nvme.git && git fetch nvme

Thanks for the pointer. I've downloaded the code and will add it to a 
stable 5.10 tree and a 5.11-rc tree and see what happens.

> 
> 
> Kind regards,
> Niklas
> 

Brad

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
