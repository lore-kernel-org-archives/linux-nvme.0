Return-Path: <SRS0=DCfI=DO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7242C4363D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Oct 2020 00:13:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 205B1206F0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Oct 2020 00:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uX37Isbx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="c/GXW+u8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205B1206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WX4+ZdZfrv938C+5Pjyl5FW4SP+QoNCPO+KBj22WY4k=; b=uX37IsbxY3ovQ+rjg0hquIlOX
	Q1JER3rGktrvGrIyQaw+JnzsTzIS7GocJZ6iEBG/j274w5KbL1ZsAU3tVpaoXxTYJV1idsoieR/G+
	zJXsg1/nrChGTojTEYL7bwlzHCzM16P1hXVySp+9El35KYedL8XewchCqQF4lB3JKhvkzqESBGeGX
	76xQPaH3ihw5Ih8JgW3GP2EZaZoWJ6X9x9RPrOoBXo/DnlVxi5Ip5HHFwQ42f7VzumavXQV9oG8zG
	iE5r0JvdF7xH/Sbsso1K3b2Rw0h6jJyr7k4KMWm+Zkh4k6kSWu8UxegkwoJAHUogCRVBI+Kas670B
	WA0prNQCw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPx5O-0002Um-KD; Wed, 07 Oct 2020 00:13:38 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPx5M-0002UL-QB
 for linux-nvme@lists.infradead.org; Wed, 07 Oct 2020 00:13:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eYFnsTNV0pXGQumm+nqU2TNbmz7lOpEXm7qb8I/w0lQ=; b=c/GXW+u8o1AM2KEKc7MYJzCiPw
 eJ7MUQ4HAgarJHK+8kQ+sUs9iA6/8QNLZsq6zEF/gkhvIhD0MJ2wULJkvDl29UC589Njlg7qaYAok
 nB5K9nCja1NwF+12oHFqo80dGSQbvbsETf5CoMpHtChLSapQS8Tew70if3fCCZnc3efxLvPWnnWoV
 uuRNoHiw9xRVxbUbny0W/Gt77sCcQfAaW2hhuFGkfIYwhMXz9M1AFxdsPI2Ka20YX/5SXcfkQm33F
 fUol7kCrTM06e536K47DKAIWiLYz+PvLKIIkZKK0re0/K8iTd4pvr0Bi2Ztw8K7na+L50AH6MLr77
 ofW8Smsg==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kPx5J-0007C8-Ug; Tue, 06 Oct 2020 18:13:34 -0600
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Omar Sandoval <osandov@osandov.com>
References: <20200930185422.11494-1-logang@deltatee.com>
 <20200930185422.11494-6-logang@deltatee.com>
 <BYAPR04MB49654DCBAD729B05759EB6FF860A0@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e7bdf462-c86d-f248-58f4-d9d41b2bd343@deltatee.com>
Date: Tue, 6 Oct 2020 18:13:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49654DCBAD729B05759EB6FF860A0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, sagi@grimberg.me, osandov@osandov.com,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH blktests v2 05/11] nvme: Add common helpers for passthru
 tests
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_201336_851582_73470320 
X-CRM114-Status: GOOD (  16.13  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-10-06 6:02 p.m., Chaitanya Kulkarni wrote:
> On 9/30/20 12:01, Logan Gunthorpe wrote:
>> Add some simple helpers to setup a passthru target that passes through
>> to a nvme test device.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>  tests/nvme/rc | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 76 insertions(+)
>>
>> diff --git a/tests/nvme/rc b/tests/nvme/rc
>> index dfa57a299625..1ea23308a3f7 100644
>> --- a/tests/nvme/rc
>> +++ b/tests/nvme/rc
>> @@ -73,6 +73,17 @@ _require_nvme_trtype_is_fabrics() {
>>  	return 0
>>  }
>>  
>> +_test_dev_nvme_ctrl() {
>> +	local dev
>> +
>> +	dev=$(cat "${TEST_DEV_SYSFS}/device/dev")
>  can you initialize dev this at the time of declaration ?

Yup, will fix.

>> +	echo "/dev/char/${dev}"
>> +}
>> +
>> +_test_dev_nvme_nsid() {
>> +	cat "${TEST_DEV_SYSFS}/nsid"
>> +}
>> +
>>  _cleanup_nvmet() {
>>  	local dev
>>  	local port
>> @@ -257,6 +268,27 @@ _remove_nvmet_subsystem() {
>>  	rmdir "${subsys_path}"
>>  }
>>  
>> +_create_nvmet_passthru() {
>> +	local nvmet_subsystem="$1"
>> +	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
>> +	local passthru_path="${subsys_path}/passthru"
>> +
>> +	mkdir -p "${subsys_path}"
>> +	printf 1 > "${subsys_path}/attr_allow_any_host"
>> +
>> +	printf "%s" "$(_test_dev_nvme_ctrl)" > "${passthru_path}/device_path"
>> +	printf 1 > "${passthru_path}/enable"
> 
> can you please echo in general and printf only when it is needed ?>
> I know existing code is a bit inconsistent I'll send a clenup to make it
> uniform.

Yes, I agree. I will it fix in v3.
Thanks,

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
